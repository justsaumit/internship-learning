# Activities Done today

## Dashboard changes
### Website monitoring (Categorizing Response codes)
HTTP Response to this API url is 401
Which indicates that it is down, however in reality the URL is working it is that the scraping endpoint does not have valid credentials.
So made changes to the PieChart using PromQL accordingly to the URLs that are working but cannot be reached for 2xx.
![Focussed View of Panel wih Filter for 401 Status](Screenshot_from_2023-07-10_09-54-18.png)
![HTTP Status Code 401 Unauthorized](Screenshot_from_2023-07-10_10-01-20.png)
![Making changes to PieChart using PromQL](Screenshot_from_2023-07-10_10-58-55.png)
#### Website Monitoring Dashboard
![Website Monitoring Dashboard Overview](Screenshot_from_2023-07-10_11-01-33.png)
**Note:** URLs are yet to be screened out and filtered this is testing environment.
![Individual Site monitoring](Screenshot_from_2023-07-10_11-02-32.png)

### Node Exporter full 
### Variable renaming
I think it is appropriate to use instance IP as node variable than the tagname, so made changes accordingly for that in a way tagname is dependent on instance.
### Extracting target Variable using regex
To get the number of instances displayed in the Overview Panel, I need to asssign $target variable properly.
However by using this PromQL I get a very crude value- `{} 50 1688970564000` instead of the desired value of `50`
![Without regex value](Screenshot_from_2023-07-10_11-59-32.png)
So I made use of regex and made it so that the query only fetches me the text which is surrounded by regex in a way the `{}` is also accounted for and as sample query I recieve `50`
![With regex value](Screenshot_from_2023-07-10_11-59-52.png)

## Dashboard viewing + Alerts
### How dashboard looks when Two Sites were down
![502 Site down Alert+ Dashboard](Screenshot_from_2023-07-10_12-34-22.png)
### Focused view
![Focused view](Screenshot_from_2023-07-10_12-36-15.png)
### Focused view - Issue Resolved
![Issue Resolved](Screenshot_from_2023-07-10_12-46-47.png)

## Dropping RDP/Windows instances
Dropping Windows instances from scanning for now a node-exporter can only installed on \*NIX or UNIX-like OS.
There exists [windows-exporter](https://github.com/prometheus-community/windows_exporter) by prometheus team which I would look into in future, after I get the clearance to install it.
However, for now I'm trying to eliminate false negatives as much as I can.
![Dropping to scan RDP/Windows instances](Screenshot_from_2023-07-10_13-55-36.png)
### Instance Down Alerts before Dropping
![Before Dropping](Screenshot_from_2023-07-10_13-53-53.png)
### Instance Down Alerts after Dropping
![After Dropping](Screenshot_from_2023-07-10_13-58-39.png)
