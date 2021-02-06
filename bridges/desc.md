### Exploration on Bridges data provided by US Department of Transportation

[DATA](https://www.fhwa.dot.gov/bridge/nbi/ascii.cfm)

I have taken data of all the bridges in Wisconsin where the data has been collected from 1992 to 2019.

#### Columns
```
1. DATA_YEAR --> Year in which the data was recorded
2. FIPS_CODE --> FIPS Code for the States
3. BRIDGE_ID --> ID for individual bridges
4. YEAR_BUILT --> Year in which the bridge was built
5. YEAR_RECONSTRUCTED --> Year in which the bridge was reconstructed
6. AVERAGE_DAILY_TRAFFIC --> Average Daily Traffic on the bridge
7. YEAR_ADT --> Year when the ADT was recorded
8. FUTURE_ADT --> Prediction for average daily traffic in future
9. DECK_COND --> Rating for the deck condition
10. SUPERSTRUCTURE_COND --> Rating for the superstructure condition
11. CHANNEL_COND --> Rating for the channel condition
12. CULVERT_COND --> Rating for the culvert condition
13. OPERATING_RATING --> Capacity rating gives the absolute maximum permissible load level
14. INVENTORY_RATING --> Capacity rating gives a load level which can safely utilize an existing structure
```

We can check the trend of operating and inventory rating for the bridges over the years.  
![](https://github.com/sidthakur08/stat-433/blob/main/bridges/operating_rating.png)  
![](https://github.com/sidthakur08/stat-433/blob/main/bridges/inv_rating.png)

Another idea can be to compare the actual average daily traffic recorded and the predicted average daily traffic to see how much the estimate differs.
