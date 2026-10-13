# Binary Classification of Built Environment in Cairo Using MATLAB and GIS

**Author:** Maria M. Polychroniadou (ID: 25023)  
*University of the Aegean, Department of Geography (Thessaloniki, 2026)*

---

## 1. Introduction

This study presents the mapping and binary classification of the built environment using an Artificial Neural Network (ANN) trained in MATLAB, combined with spatial analysis in GIS. Monitoring and recording urban sprawl—especially under conditions of rapid population growth and intense urbanization—is vital for urban planning, resource management, and environmental impact assessment.

Mapping land use/land cover (LULC) across heterogeneous environments presents notable challenges, particularly regarding the collection and retention of reliable training datasets for machine learning and deep learning pipelines. While artificial neural networks effectively model complex, multi-dimensional non-linear patterns, model training is computationally intensive.

To address this challenge, **vectorization** was implemented throughout the pipeline: replacing loop-based and scalar-dependent routines with native matrix and vector operations. This reduced full-scene classification runtimes from hours or days to mere seconds, enabling rapid retraining and hyperparameter tuning.

As urban populations continue to expand into peripheral and agricultural lands, equitable land management and continuous satellite-based monitoring become increasingly critical.

---

## 2. Data and Methodology

### 2.1 Study Area
The study focuses on the peri-urban regions of Cairo, Egypt. Cairo is the most populous metropolitan area in Africa, with a population exceeding 23,534,600. The territory is characterized by extreme landscape heterogeneity: high-density urban cores sit immediately adjacent to fertile agricultural zones along the Nile River and hyper-arid desert terrain.

Over the past 50 years, Egypt has experienced intense urbanization, with the urban share of the population increasing from less than 10% in the early 20th century to over 45% by its end.

<p align="center">
  <img src="Cairo_2015.png" width="48%" alt="Sentinel-2 Scene Cairo 2015" />
  <img src="Cairo_2025.png" width="48%" alt="Sentinel-2 Scene Cairo 2025" />
</p>
*Sentinel-2 multi-spectral composite acquisitions covering Greater Cairo for 13 August 2015 (left) and 25 August 2025 (right).*


### 2.2 Satellite Data and Reference System
Multi-spectral imagery was obtained from the European Space Agency (ESA) via the Copernicus Open Access platform:
* **Sentinel-2A:** Acquired 13 August 2015
* **Sentinel-2B:** Acquired 25 August 2025

August acquisitions were specifically selected to guarantee minimal cloud cover, optimal surface reflectance, and reduced solar shadow effects.
* **Spectral Bands:** 9 spectral channels were retained for classification (the 60 m atmospheric bands B1, B9, B10 and the 20 m narrow NIR Band 8A were excluded).
* **Coordinate Reference System:** All datasets were projected to **WGS 84 / UTM zone 36N (EPSG:32636)**.

### 2.3 Methodology
1. **Training Sample Collection:** Polygons defining Built-up (Class 1) and Non-built-up (Class 0) areas were digitized in GIS across the multi-band composite rasters. Ground truth reference polygons were digitized across stable, persistent land cover classes (core urban fabric, permanent water bodies, and undisturbed deep desert) to establish consistent, baseline spectral signatures across both the 2015 and 2025 Sentinel-2 scenes.
2. **ANN Architecture:** A pattern recognition network (`patternnet`) was configured in MATLAB to distinguish the two classes.
3. **Training & Validation:** Multiple training runs were conducted and evaluated using Confusion Matrices, Receiver Operating Characteristic (ROC) curves, and Cross-Entropy Performance Plots.
4. **Vectorized Inference & Verification:** The optimal network weights classified the full-scene rasters using vectorized script execution, followed by GIS post-processing and spatial validation.

---

## 3. Results and Discussion

### 3.1 Year 2015 Results
Training of the 2015 neural network converged at **161 epochs**, achieving its **Best Validation Performance** at epoch 155 with a cross-entropy error of **0.027242**.

The optimal network configuration and partition ratios were:

```matlab
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio   = 20/100;
net.divideParam.testRatio  = 10/100;
```

#### Table 1. Training Progress - NN 2015
| Unit / Metric | Initial Value | Stopped Value | Target Value |
| :--- | :--- | :--- | :--- |
| **Epoch** | 0 | 161 | 1000 |
| **Elapsed Time** | - | 00:00:00 (vectorized) | - |
| **Performance** | 0.852 | 0.0324 | 0 |
| **Gradient** | 0.633 | 0.00498 | 1e-06 |
| **Validation Checks** | 0 | 6 | 6 |
*Table 1. Training Progress — Neural Network 2015.*

#### Table 2. Confusion Matrices (2015)
The 2015 model achieved an **Overall Accuracy of 99.0%** (All Confusion Matrix), with False Positives at 0.6% (27 samples) and False Negatives at 0.4% (17 samples).
* **Training Accuracy:** 99.1%
* **Validation Accuracy:** 99.0%
* **Test Accuracy:** 98.7% (False Positives: 0.7% / 3 samples, False Negatives: 0.7% / 3 samples)


![Table 2. Confusion Matrices 2015](Plots-2015/Plots/All_Confusion_Matrix.png)
*Table 2. MATLAB Confusion Matrices (Validation, Training, Test, All) for 2015.*

#### Table 3 & 4. ROC Curves and Performance Plot (2015)
Cross-entropy error decreased smoothly across training, validation, and test subsets. The validation and test curves track the training curve closely throughout, while ROC curves hug the upper-left axis, confirming high generalization capacity with no evidence of overfitting.

<p align="center">
  <img src="Plots-2015/Plots/ROC_Curves.png" width="48%" />
  <img src="Plots-2015/Plots/Performance_Plots.png" width="48%"  />
</p>
*Table 3 (left): ROC Curves for 2015. Table 4 (right): Cross-Entropy Performance Plot showing best validation at epoch 155 (0.027242).*

![Figure 2. Cairo Urban Classification 2015](Cairo_urban_class15.png)
*Figure 2. Built-up environment classification map of Cairo for 2015 (Built-up in green; Scale 1:300,000).*

---

### 3.2 Year 2025 Results
Training of the 2025 neural network completed at **95 epochs**, reaching its **Best Validation Performance** at epoch 89 with a cross-entropy error of **0.10093**.

The optimal network configuration and partition ratios were:

```matlab
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);
net.divideParam.trainRatio = 60/100;
net.divideParam.valRatio   = 20/100;
net.divideParam.testRatio  = 20/100;
```

#### Table 5. Training Progress - NN 2025
| Unit / Metric | Initial Value | Stopped Value | Target Value |
| :--- | :--- | :--- | :--- |
| **Epoch** | 0 | 95 | 1000 |
| **Elapsed Time** | - | 00:00:00 (vectorized) | - |
| **Performance** | 0.749 | 0.0939 | 0 |
| **Gradient** | 0.559 | 0.0114 | 1e-06 |
| **Validation Checks** | 0 | 6 | 6 |
*Table 5. Training Progress — Neural Network 2025.*

#### Table 6. Confusion Matrices (2025)
The 2025 model achieved an **Overall Accuracy of 97.0%** (All Confusion Matrix).
* **True Positives:** 51.4% (2,178 samples)
* **True Negatives:** 45.6% (1,931 samples)
* **False Positives:** 1.3% (57 samples)
* **False Negatives:** 1.7% (72 samples)
* **Test Evaluation:** 97.2% overall test accuracy (98.0% correct on Class 0, 96.2% on Class 1)


![Table 6. Confusion Matrices 2025](Plots-2025/plots/All_Confusion_Matrix.png)
*Table 6. MATLAB Confusion Matrices (Validation, Training, Test, All) for 2025.*

#### Table 7. Performance Plot (2025)
Cross-entropy error decreased steadily across all 95 epochs, with validation and test trajectories remaining closely aligned with training loss.


![Table 7. Performance Plot 2025](Plots-2025/plots/Performance_Plot.png)
*Table 7. Cross-Entropy Performance Plot for 2025 showing best validation at epoch 89 (0.10093).*

![Figure 3. Cairo Urban Classification 2025](Cairo_urban_class25.png)
*Figure 3. Built-up environment classification map of Cairo for 2025 (Built-up in orange; Scale 1:300,000).*

---

### 3.3 Error Analysis
Despite high overall accuracies (>97%–99%), visual inspection highlighted localized classification errors, primarily across peripheral sandy desert terrains:
1. **High-Albedo Confusion:** Non-built bare ground and bright desert sands exhibit high reflectance similar to specific concrete and roofing materials.
2. **Mixed Pixels:** Transition zones between urban boundaries, irrigated agricultural parcels, and desert soils produce mixed-pixel spectral signatures.
3. **Topographic Shading:** Dune topography introduces steep slope shadows that alter raw digital numbers, leading to false-positive built-up classifications.


<p align="center">
  <img src="Plots-2015/Figures4_5_error_2015.png" width="48%" alt="2015 Dune Misclassification Detail" />
  <img src="Plots-2025/Figures6_7_error_2025.png" width="48%" alt="2025 Dune Misclassification Detail" />
</p>
*Figures 4 & 5 (left): Detailed zoom of dune shadow misclassification in 2015. Figures 6 & 7 (right): Corresponding dune shadow misclassification in 2025.*

---

## 4. Multi-Temporal Comparison and Conclusions

### 4.1 Multi-Temporal Comparison (2015–2025)
Probability rasters were segmented using an operational binary threshold ($0 \le 80$ Non-built, $1 > 80$ Built). The difference between the two classified rasters was computed using the Raster Calculator and quantified in Python (Spyder):

$$\Delta \text{Built} = \text{Built}_{2025} - \text{Built}_{2015}$$

* **Total New Built-Up Pixels (Class 1):** 5,321,621 pixels
* **Total Decadal Urban Expansion:** **532.16 km²**

While the 2015 model achieved slightly higher overall accuracy (99.0%) than the 2025 model (97.0%), both models demonstrated high fidelity. The slight decline in 2025 accuracy reflects increased urban surface heterogeneity from rapid sprawl and new transitional surfaces. The results capture pronounced expansion corridors toward New Cairo and the eastern desert plateaus.

![Figure 8. Cairo Urban Expansion 2015-2025](urban%20expantion%202015-2025.jpg)
*Figure 8. Decadal urban expansion map of Cairo (2015–2025) showing 2015 baseline urban footprint (orange) and 2015–2025 new urban expansion (red; Scale 1:300,000).*

### 4.2 Conclusions
* The artificial neural network pipeline achieved overall classification accuracies exceeding **97%** across both decadal time steps.
* Code **vectorization** in MATLAB eliminated loop overhead, reducing execution times from hours/days to seconds and making iterative training workflows practical.
* Spectral confusion remained localized to high-albedo and shadowed sand dune environments, emphasizing the need for targeted training data in arid zones.
* The measured expansion of **532.16 km²** confirms significant urban sprawl across Greater Cairo, highlighting the necessity of continuous satellite remote sensing for sustainable metropolitan planning.

---

## 5. References

1. Yanyan Dong, Xiaogao Chang (2026), Spatio-temporal analysis of land use and land cover changes: assessing urban expansion and ecological transformations (2003–2023), GeoJournal.
2. H. N. Manh, T. V. Anh et.al. (2025), Urban Expansion Monitoring Using Sentinel-1 and Sentinel-2 Data Fusion on Google Earth Engine, Volume 2: Earth, Mine, and Environmental Sciences for Green, Sustainable, and Prosperous Development.
3. Osman, T., Arima, T. & Divigalpitiya, P. (2016), Measuring Urban Sprawl Patterns in Greater Cairo Metropolitan Region, J Indian Soc Remote Sens 44, 287–295.
4. Radek Silhavy, Petr Silhavy (2024), Machine Learning Methods in Systems, Proceedings of 13th Computer Science On-line Conference, Vol. 4.
5. Reynaldo Hinojosa-Contreras, Eric Gielen, José-Sergio Palencia-Jiménez, Isidro Cantarino-Mart (2026), Urban sprawl in Latin America: A systematic review of the existing literature and emerging insights, Land Use Policy, Volume 165.
6. World Population Review (2026), Africa Cities by Population 2026. Available: https://worldpopulationreview.com/cities/continent/africa
7. European Space Agency (ESA), Cairo Overview and Urban Monitoring. Available: https://www.esa.int/SPECIALS/Eduspace_Global_GR/SEM0G3ZOBFG_2.html

---
*Project developed at the University of the Aegean, Department of Geography.*
