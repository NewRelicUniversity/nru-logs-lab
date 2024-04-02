# _Lab:_ Using New Relic APM to troubleshoot a database performance problem

**Objective:** Use the features of New Relic APM, such as the _Databases_ page and transaction traces, to identify the cause of slow database performance.

## Logging into the training account
In a private browser window, use the following credentials to log into New Relic: 

- URL: [https://one.newrelic.com/](https://one.newrelic.com/)
- Email: [readonly@newrelicuniversity.com](readonly@newrelicuniversity.com)
- Password: o11y-as-code

## Step 1
Under _Services - APM_ in the New Relic UI, select **Ad Service** in the **NRU Demotron v4** account. Set the time window to the last 60 minutes.

## Step 2
Notice that there are several response-time spikes during the past hour. Based on the colors on the _Web transactions time_ chart, where is most of the time being spent?

## Step 3
Select the _Databases_ menu to the left of the _Summary_ page. Which database query is taking the most time? 

## Step 4
Select the most time-consuming database query from the list. Why do you think it is taking so much time? Are there any slow query traces? If not, why not?

## Step 5
Go back to the _Summary_ page and scroll down to the list of Transactions. Select the slowest transaction. Do you notice anything on that page that might explain why database queries are taking a long time?

## Step 6
Scroll further down the transaction detail page and select a transaction trace with a duration greater than 60,000 ms. Looking at the trace, what do you think caused the transaction to take so long?

## Conclusion
In this lab, you practiced using features of New Relic APM, such as the _Databases_ page and transaction traces, to identify the root cause of slow database performance in a transaction.

## Additional resources
- [APM Databases page documentation](https://docs.newrelic.com/docs/apm/apm-ui-pages/monitoring/databases-page-view-operations-throughput-response-time/)
- [APM Transactions page documentation](https://docs.newrelic.com/docs/apm/apm-ui-pages/monitoring/transactions-page-find-specific-performance-problems/)
- [Tutorial: Troubleshoot slow application performance](https://docs.newrelic.com/docs/tutorial-improve-app-performance/root-causes/)

---

# _Lab:_ Using the New Relic Logs UI

**Objective:** Practice using the New Relic Logs UI to search and analyze log data.

## Logging into the training account
In a private browser window, use the following credentials to log into New Relic: 

- URL: [https://one.newrelic.com/](https://one.newrelic.com/)
- Email: [demotron@newrelicuniversity.com](demotron@newrelicuniversity.com)
- Password: o11y-as-code

## Step 1
From New Relic’s main menu, select _Logs_. Select the **Demotron V2** account, and set the time picker to the past 60 minutes.

## Step 2
See if you can find two methods to filter the list to show logs from the entity named **WebPortal**, containing the word “error”. How many logs did you find?

## Step 3
Filter the list to show only logs with a level of ERROR. Now how many logs are there? 

## Step 4
Add columns to the results table to display the level and hostname of each log.

## Step 5
How could you save this view to quickly recall it later? How could you share this data with a colleague? What if they don’t have access to your New Relic account?

## Step 6
How could you create an alert condition based on this log search?

---

# _Lab:_ Searching logs based on custom attributes

**Objective:** Find logs containing custom attributes recorded with automatic logs in context.

## Logging into the training account
In a private browser window, use the following credentials to log into New Relic: 

- URL: [https://one.newrelic.com/](https://one.newrelic.com/)
- Email: [readonly@newrelicuniversity.com](readonly@newrelicuniversity.com)
- Password: o11y-as-code

## Step 1
In a web browser, visit [https://foodme.nru.to/](https://foodme.nru.to/). Enter a customer name and address you will search for later. Select a restaurant and add some menu items to your cart, then complete your order. (_Tip:_ Try changing the item quantity to a very large value.) 

## Step 2
From New Relic’s main menu, select _Logs_. Select the **NRU Training** account.

## Step 3
Using the filter bar at the top of the page, try to find the order you just placed.

## Step 4
Select a matching log entry and notice the custom attributes that were recorded.

## Conclusion
In these labs, you practiced using the New Relic Logs UI to search and analyze generic log data. You also searched for logs containing custom attributes recorded with automatic logs in context.

## Additional resources
- [New Relic Logs UI documentation](https://docs.newrelic.com/docs/logs/ui-data/use-logs-ui/)
- [APM Logs in Context documentation](https://docs.newrelic.com/docs/logs/logs-context/get-started-logs-context/)

---

# _Lab:_ Troubleshooting Log Forwarding

**Objective:** Troubleshoot common log forwarding problems.

## Prerequisites
To complete this lab, you will need: 
- A personal New Relic account. If you don’t have one, you may sign up for a free account here: [https://newrelic.com/signup](https://newrelic.com/signup). 
- A personal [Github account](https://github.com).

# Start the lab environment and add your license key

## Step 1
Log into your Github account and navigate to [https://github.com/codespaces](https://github.com/codespaces). Click the _New codespace_ button in the upper-right corner.

## Step 2
On the _Create a new codespace_ page, click _Select a repository_ and search for **NewRelicUniversity/nru-logs-lab**. Click the _Create codespace_ button at the bottom of the page.

## Step 3
In another browser tab, log into your New Relic account. Copy your INGEST - LICENSE key from the [API keys](https://one.newrelic.com/launcher/api-keys-ui.api-keys-launcher) page.

## Step 4
Back in your codespace, select the **newrelic-infra.yml** tab and replace the YOUR_LICENSE_KEY placeholder with the license key you copied in Step 3.

## Step 5
Wait for the terminal window to finish running the startup script, then execute the command `./start.sh` to start the Infrastructure agent. Within a few minutes, you should see Infrastructure log messages on the Logs page of your New Relic account.

# Problem: Infrastructure agent not forwarding logs

**Scenario:** You have configured the Infrastructure agent to forward logs from `/var/log/test.log`. The file exists, but no log data appears in the New Relic UI.

Observe the issue: 

## Step 1
Confirm that log data is missing: Execute the following query in the New Relic NRQL Console: `SELECT * FROM Log WHERE hostname = 'nru-logs-lab' AND message NOT LIKE 'time=%'`. The query should return no data.

## Step 2
Confirm that `logging.yml` is correctly configured: In the terminal, execute the following command to view the configuration file: `cat /etc/newrelic-infra/logging.d/logging.yml`. It should look like this: 
```
logs:
  - name: nru-logs-lab
    file: /var/log/test.log
```
## Step 3
Confirm that log data exists: Execute the following command in the terminal to view the contents of the log file: `cat /var/log/test.log`. You should see some log messages.

If log forwarding is configured correctly and there is data in the log file, why do you think it does not appear in the New Relic UI?

# Solution: Infrastructure agent not forwarding logs

The Infrastructure agent only forwards log messages that are created _after_ log forwarding is configured. The file `/var/log/test.log` existed before the Infrastructure agent was started; its contents will not be forwarded to New Relic until new data is written to the file.

Confirm that log forwarding is working: 

## Step 1
Add some log messages to the file: In the terminal, execute the following command to edit the log file: `sudo nano /var/log/test.log`. Add some text to the end of the file, then type Ctrl+O, Enter, Ctrl+X to save your changes.

## Step 2
Confirm that the new log messages were forwarded to New Relic: Execute the following query in the New Relic NRQL Console: `SELECT * FROM Log WHERE hostname = 'nru-logs-lab' AND message NOT LIKE 'time=%'`. You should see the message(s) you added to the file.

# Problem: No Data After Log API Reports Success (Part 1)

**Scenario:** You used the Log API to send logs to New Relic. The API returned a `requestId` and `202` response code, but no data appears in the New Relic UI.

Observe the issue: 

## Step 1
Confirm that Log API reports success: Replace `YOUR_LICENSE_KEY` with your license key in the following command, and execute it in the terminal: `API_KEY=YOUR_LICENSE_KEY ./post-logs-1.sh`. You should see a response like this:
```
    < HTTP/1.1 202 Accepted
    ...
    {"requestId":"00000000..."}
```
## Step 2
Confirm that log data is not present in New Relic: Execute the following query in the NRQL Console: `SELECT * FROM Log WHERE logtype = 'nru-logs-lab'`. The query should return no data.

How would you investigate the issue? Need a hint? Check [this document](https://docs.newrelic.com/docs/logs/troubleshooting/no-log-data-appears-ui/). 

# Solution: No Data After Log API Reports Success (Part 1)

New Relic’s ingestion endpoints are asynchronous; the endpoint verifies the payload _after_ it returns the HTTP response. If any issues occur while verifying the payload, New Relic will generates an `NrIntegrationError`.

## Step 1
Check for `NrIntegrationError` events: Execute the following query in the NRQL Console: `SELECT * FROM NrIntegrationError`. You should see a LogValidationException with a message saying, “Error unmarshalling message payload”.

## Step 2
Correct the invalid JSON: Edit the `post-logs-1.sh` file and replace the missing comma before the word “logs”:
```
    "common": {
      "attributes": {
        "logtype": "nru-logs-lab",
        "service": "login-service",
        "hostname": "login.example.com"
      }
    },
    "logs": [{
```
## Step 3
Try posting the logs again: Replace `YOUR_LICENSE_KEY` with your license key in the following command, and execute it in the terminal: `API_KEY=YOUR_LICENSE_KEY ./post-logs-1.sh`. 

## Step 4
Confirm that the log data was ingested successfully. Execute the following query in the NRQL Console: `SELECT * FROM Log WHERE logtype = 'nru-logs-lab'`. You should now see two log messages.

# Problem: No Data After Log API Reports Success (Part 2)

**Scenario:** You used the Log API to send logs to New Relic. The API returned a `requestId` and `202` response code, but no data appears in the New Relic UI. (These are the same symptoms as the previous lab, but the cause is different.)

Observe the issue: 

## Step 1
Confirm that Log API reports success: Replace `YOUR_LICENSE_KEY` with your license key in the following command, and execute it in the terminal: `API_KEY=YOUR_LICENSE_KEY ./post-logs-2.sh`. You should see a response like this:
```
    < HTTP/1.1 202 Accepted
    ...
    {"requestId":"00000000..."}
```
## Step 2
Confirm that log data is not present in New Relic: Execute the following query in the NRQL Console: `SELECT * FROM Log WHERE logtype = 'nru-logs-lab'`. The query should return only the log messages from the previous lab.

Use the techniques you learned in the previous lab to investigate this issue.

# Solution: No Data After Log API Reports Success (Part 2)

What did you find in your investigation? Were there any `NrIntegrationError` events? Was the API payload formatted correctly? What is the problem?

The issue is that, by default, NRQL queries return data _for the past 60 minutes_. The log timestamps are from 12 hours ago, so they are not visible within the default NRQL time window.

To see the data, execute the following query in the NRQL Console: `SELECT * FROM Log WHERE logtype = 'nru-logs-lab' SINCE 1 day ago`. By expanding the time window to the past 24 hours, you should now see four log messages (two from the previous lab and two from this one).

## Conclusion
In these labs, you practiced troubleshooting several common log forwarding problems, including how to use the `NrIntegrationError` event to investigate log API payload issues.

## Additional resources
[Troubleshooting: No log data appears in the UI](https://docs.newrelic.com/docs/logs/troubleshooting/no-log-data-appears-ui/)