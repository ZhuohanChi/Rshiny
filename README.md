# NICU Interactive Visualizations Dashboard

This Shiny dashboard presents interactive visualizations based on NICU (Neonatal Intensive Care Unit) data extracted from the MIMIC-III public dataset. It helps visualize vital-sign distributions and model performance to support early infection detection in infants.

## Rshiny App link

https://stlittlewhite.shinyapps.io/data_description/

## Project Overview

This project provides:
- **Box plots** showing the distribution of vital signs (e.g., heart rate, oxygen saturation) comparing infected vs. non-infected NICU patients.
- **Line charts** visualizing machine learning model performance metrics (CV Score, Precision, Recall, F1, Accuracy) across different hyperparameter rankings.
- **Dataset description** summarizing the NICU dataset source, sample size, and study population.

The dashboard enables users to dynamically select:
- Different time windows (30 minutes vs. 120 minutes) for vital sign analysis.
- Different machine learning models (CatBoost, GradientBoost) and time windows for model evaluation.

## Data Source

- Extracted from the **MIMIC-III** public clinical database.
- Approximately 12 million time-stamped vital-sign observations.
- Population: Infants admitted to NICU once and alive two hours after admission.

> **Note:** Due to privacy concerns, specific patient time periods are not provided.

## How to Run

1. Clone or download this repository.
2. Ensure you have the required R libraries installed:
   ```r
   install.packages(c("shiny", "plotly"))
   ```
3. Place your dataset CSV files inside a `/data/` folder (relative to the app).
4. Run the app locally:
   ```r
   shiny::runApp()
   ```

## Project Structure

```
/NICU-dashboard/
├── ui.R
├── server.R
├── data/
│   ├── nicu_30_mean.csv
│   ├── nicu_120_mean.csv
│   ├── nicu_30_cb_data.csv
│   ├── nicu_120_cb_data.csv
│   ├── nicu_30_gb_data.csv
│   ├── nicu_120_gb_data.csv
└── README.md
```

## Real-World Impact

This dashboard helps identify infections in NICU infants faster, enabling earlier intervention and potentially reducing ICU mortality rates.
By visualizing key clinical variables and optimizing model hyperparameters, it supports more informed and timely medical decision-making.

## License

This project is for academic and educational purposes only.

