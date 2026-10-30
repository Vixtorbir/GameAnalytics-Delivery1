using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;
using UnityEngine.Networking;

public class AnalyticsTracker : MonoBehaviour
{
    public static AnalyticsTracker Instance;

    [SerializeField] private string serverUrl = "https://citmalumnes.upc.es/~marcam5/";

    private Dictionary<uint, uint> sessionToPlayer = new Dictionary<uint, uint>();

    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
            return;
        }
        Instance = this;

        if (string.IsNullOrEmpty(serverUrl) || serverUrl.Contains("localhost"))
        {
            serverUrl = "https://citmalumnes.upc.es/~marcam5/";
        }
    }

    private void OnEnable()
    {
        Simulator.OnNewPlayer += HandleNewPlayer;
        Simulator.OnNewSession += HandleNewSession;
        Simulator.OnBuyItem += HandleBuyItem;
        Simulator.OnEndSession += HandleEndSession;
    }

    private void OnDisable()
    {
        Simulator.OnNewPlayer -= HandleNewPlayer;
        Simulator.OnNewSession -= HandleNewSession;
        Simulator.OnBuyItem -= HandleBuyItem;
        Simulator.OnEndSession -= HandleEndSession;
    }

    private void HandleNewPlayer(string name, string country, int age, float gender, DateTime date)
    {
        RunCommand(new AddUserCommand(serverUrl, name, country, age, gender, playerId =>
        {
            CallbackEvents.OnAddPlayerCallback?.Invoke(playerId);
        }));
    }

    private void HandleNewSession(DateTime date, uint playerId)
    {
        RunCommand(new AddSessionCommand(serverUrl, playerId, date, sessionId =>
        {
            sessionToPlayer[sessionId] = playerId;
            CallbackEvents.OnNewSessionCallback?.Invoke(sessionId);
        }));
    }

    private void HandleBuyItem(int itemId, DateTime date, uint sessionId)
    {
        RunCommand(new AddPurchaseCommand(serverUrl, sessionId, itemId, () =>
        {
            CallbackEvents.OnItemBuyCallback?.Invoke(sessionId);
        }));
    }

    private void HandleEndSession(DateTime date, uint sessionId)
    {
        RunCommand(new EndSessionCommand(serverUrl, sessionId, date, () =>
        {
            if (!sessionToPlayer.TryGetValue(sessionId, out uint playerId))
            {
                Debug.LogError("No player found for session " + sessionId);
                return;
            }
            sessionToPlayer.Remove(sessionId);
            CallbackEvents.OnEndSessionCallback?.Invoke(playerId);
        }));
    }

    private void RunCommand(ICommand command)
    {
        StartCoroutine(command.Execute());
    }

    public static string FormatDate(DateTime date)
    {
        return date.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture);
    }

    public static IEnumerator PostForm(string url, WWWForm form, Action<uint> onSuccess)
    {
        using (UnityWebRequest www = UnityWebRequest.Post(url, form))
        {
            yield return www.SendWebRequest();

            if (www.result != UnityWebRequest.Result.Success)
            {
                Debug.LogError("Error in " + url + ": " + www.error);
                yield break;
            }

            string response = www.downloadHandler.text.Trim();
            if (uint.TryParse(response, out uint id))
                onSuccess(id);
            else
                Debug.LogError("Unexpected response from " + url + ": " + response);
        }
    }
}

public interface ICommand
{
    IEnumerator Execute();
}

public class AddUserCommand : ICommand
{
    private string url;
    private string name;
    private string country;
    private int age;
    private float gender;
    private Action<uint> onDone;

    public AddUserCommand(string serverUrl, string name, string country, int age, float gender, Action<uint> onDone)
    {
        url = serverUrl + "add_user.php";
        this.name = name;
        this.country = country;
        this.age = age;
        this.gender = gender;
        this.onDone = onDone;
    }

    public IEnumerator Execute()
    {
        WWWForm form = new WWWForm();
        form.AddField("name", name);
        form.AddField("country", country);
        form.AddField("age", age);
        form.AddField("gender", gender.ToString(CultureInfo.InvariantCulture));

        yield return AnalyticsTracker.PostForm(url, form, onDone);
    }
}

public class AddSessionCommand : ICommand
{
    private string url;
    private uint userId;
    private DateTime startDate;
    private Action<uint> onDone;

    public AddSessionCommand(string serverUrl, uint userId, DateTime startDate, Action<uint> onDone)
    {
        url = serverUrl + "add_session.php";
        this.userId = userId;
        this.startDate = startDate;
        this.onDone = onDone;
    }

    public IEnumerator Execute()
    {
        WWWForm form = new WWWForm();
        form.AddField("userId", userId.ToString());
        form.AddField("startDate", AnalyticsTracker.FormatDate(startDate));

        yield return AnalyticsTracker.PostForm(url, form, onDone);
    }
}

public class AddPurchaseCommand : ICommand
{
    private string url;
    private uint sessionId;
    private int itemId;
    private Action onDone;

    public AddPurchaseCommand(string serverUrl, uint sessionId, int itemId, Action onDone)
    {
        url = serverUrl + "add_purchase.php";
        this.sessionId = sessionId;
        this.itemId = itemId;
        this.onDone = onDone;
    }

    public IEnumerator Execute()
    {
        WWWForm form = new WWWForm();
        form.AddField("sessionId", sessionId.ToString());
        form.AddField("itemId", itemId);

        yield return AnalyticsTracker.PostForm(url, form, purchaseId => onDone());
    }
}

public class EndSessionCommand : ICommand
{
    private string url;
    private uint sessionId;
    private DateTime endDate;
    private Action onDone;

    public EndSessionCommand(string serverUrl, uint sessionId, DateTime endDate, Action onDone)
    {
        url = serverUrl + "end_session.php";
        this.sessionId = sessionId;
        this.endDate = endDate;
        this.onDone = onDone;
    }

    public IEnumerator Execute()
    {
        WWWForm form = new WWWForm();
        form.AddField("sessionId", sessionId.ToString());
        form.AddField("endDate", AnalyticsTracker.FormatDate(endDate));

        yield return AnalyticsTracker.PostForm(url, form, id => onDone());
    }
}
