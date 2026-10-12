# Binary Classification of the Built Environment of Cairo Using MATLAB and GIS

**Author:** Maria M. Polychroniadou (ID: 25023)  
*University of the Aegean, Department of Geography (Thessaloniki, 2026)*[cite: 30]

---

## 1. Introduction

This study presents the mapping and classification of the built environment using an Artificial Neural Network (ANN) trained in MATLAB, integrated with GIS spatial analysis[cite: 30]. Monitoring urban sprawl—particularly under rapid population growth and urbanization—is critical for urban planning, resource management, and environmental impact assessment[cite: 30]. Mapping land use/land cover (LULC) in heterogeneous environments presents major challenges, especially in collecting and maintaining reliable training datasets for machine learning and deep learning[cite: 30].

While neural networks effectively model complex non-linear patterns, training can be computationally demanding[cite: 30]. To resolve this, **vectorization** was implemented: refactoring loop- and scalar-based execution into matrix and vector operations[cite: 30]. Vectorization reduced model runtime from hours or days to mere seconds, enabling rapid retraining and hyperparameter tuning[cite: 30].

Urban expansion transforms agricultural and peri-urban fringes into developed surfaces[cite: 30]. As metropolitan populations surge, ethical and equitable land administration becomes essential under severe land scarcity constraints[cite: 30].

---

## 2. Data and Methodology

### 2.1 Study Area
The study focuses on the peri-urban regions of Cairo, Egypt[cite: 31]. Cairo is the most populous metropolitan area in Africa, housing over 23,534,600 residents[cite: 31]. The territory features extreme landscape heterogeneity: a dense historical and modern urban core situated immediately alongside fertile agricultural corridors bordering the Nile River, and vast hyper-arid desert terrain[cite: 31]. This contrast makes land cover mapping particularly compelling[cite: 31].

Over the past 50 years, Egypt has undergone rapid urbanization, with urban populations rising from under 10% in the early 20th century to over 45% by its end[cite: 31, 32].

<p align="center">
  <img src="Cairo_2015.png" width="48%" alt="Sentinel-2 Scene Cairo 2015" />
  <img src="Cairo_2025.png" width="48%" alt="Sentinel-2 Scene Cairo 2025" />
</p>
*Figure: Preprocessed Sentinel-2 scenes covering Greater Cairo for 13 August 2015 (left) and 25 August 2025 (right).*[cite: 32]

![Study Area: Cairo, Egypt 2025](images/Figure1_study_area_cairo_2025.png)
*Figure 1: Study Area Location Map: Cairo, New Cairo, and the Nile River corridor (Scale 1:430,000).*[cite: 32, 33]

### 2.2 Satellite Data and Reference System
Multi-spectral satellite scenes were acquired from the European Space Agency (ESA) Copernicus Open Access Hub[cite: 32]:
* **Sentinel-2A:** Acquired 13 August 2015[cite: 32]
* **Sentinel-2B:** Acquired 25 August 2025[cite: 32]

August acquisitions ensured minimum cloud cover and solar shadow distortions[cite: 32]. 
* **Bands Used:** 9 spectral channels (60 m atmospheric bands B1, B9, B10 and 20 m narrow NIR Band 8A were excluded)[cite: 32].
* **Coordinate System:** Projected to **WGS 84 / UTM zone 36N (EPSG:32636)**[cite: 32].

### 2.3 Methodology
1. **Training Sample Collection:** Polygons defining Built-up (Class 1) and Non-built-up (Class 0) were digitized in GIS across the multi-band rasters[cite: 32]. The same shapefile was utilized across both years as sampled locations represent temporally invariant training targets[cite: 32].
2. **ANN Training in MATLAB:** Digitized features were imported into MATLAB to train a pattern recognition network (`patternnet`) for automated built-up detection[cite: 32].
3. **Model Selection:** Iterative training routines were evaluated using Confusion Matrices, Receiver Operating Characteristic (ROC) curves, and Cross-Entropy Performance Plots[cite: 32].
4. **Vectorized Inference:** The selected network models classified full scene rasters via vectorized code, followed by cartographic review in GIS for each year independently[cite: 30, 32].

---

## 3. Results and Discussion

### 3.1 Year 2015 Results
Training was configured with 10 hidden neurons and completed at **161 epochs**, reaching its **Best Validation Performance** at epoch 155 with a cross-entropy loss of **0.027242**[cite: 33, 35]:

matlab
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio   = 20/100;
net.divideParam.testRatio  = 10/100;
```[cite: 33]

#### Training Progress (2015)
| Metric / Unit | Initial Value | Stopped Value | Target Value |
| :--- | :--- | :--- | :--- |
| **Epoch** | 0 | 161 | 1000 |
| **Elapsed Time** | - | 00:00:00 (vectorized) | - |
| **Performance** | 0.852 | 0.0324 | 0 |
| **Gradient** | 0.633 | 0.00498 | 1e-06 |
| **Validation Checks**| 0 | 6 | 6 |
*Table 1: Training Progress — Neural Network 2015.*[cite: 34]

#### Accuracy & Confusion Matrices (2015)
The 2015 model achieved an **Overall Accuracy of 99.0%** (All Confusion Matrix), with False Positives at 0.6% (27 samples) and False Negatives at 0.4% (17 samples)[cite: 34].
* **Training Set:** 99.1% accuracy[cite: 34]
* **Validation Set:** 99.0% accuracy[cite: 34]
* **Test Set:** 98.7% accuracy (False Positives: 0.7% / 3 samples, False Negatives: 0.7% / 3 samples)[cite: 34]

![Table 2: Confusion Matrices 2015](Plots-2015/confusion_matrix_2015.png)
*Table 2: MATLAB Confusion Matrices (Validation, Training, Test, All) for 2015.*[cite: 34]

#### ROC Curves & Performance Plot (2015)
The cross-entropy loss declined steadily across Training, Validation, and Test subsets[cite: 35]. The validation and test curves track the training trajectory without divergence, and ROC curves hug the upper-left axis, confirming robust generalization without overfitting[cite: 35].

<p align="center">
  <img src="Plots-2015/roc_curves_2015.png" width="48%" alt="ROC Curves 2015" />
  <img src="Plots-2015/performance_plot_2015.png" width="48%" alt="Performance Plot 2015" />
</p>
*Left (Table 3): ROC Curves (Training, Validation, Test, All) for 2015[cite: 35]. Right (Table 4): Cross-Entropy Performance Plot showing best validation at epoch 155 (0.027242)[cite: 35, 36].*

![Cairo Urban Classification 2015](Cairo_urban_class15.png)
*Figure 2: Built-up environment classification map of Cairo for 2015 (Built-up in green; Scale 1:300,000).*[cite: 36]

---

### 3.2 Year 2025 Results
The 2025 network training terminated at **95 epochs**, achieving its **Best Validation Performance** at epoch 89 with a cross-entropy loss of **0.10093**[cite: 37, 38]:

```matlab
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);
net.divideParam.trainRatio = 60/100;
net.divideParam.valRatio   = 20/100;
net.divideParam.testRatio  = 20/100;
```[cite: 37]

#### Training Progress (2025)
| Metric / Unit | Initial Value | Stopped Value | Target Value |
| :--- | :--- | :--- | :--- |
| **Epoch** | 0 | 95 | 1000 |
| **Elapsed Time** | - | 00:00:00 (vectorized) | - |
| **Performance** | 0.749 | 0.0939 | 0 |
| **Gradient** | 0.559 | 0.0114 | 1e-06 |
| **Validation Checks**| 0 | 6 | 6 |
*Table 5: Training Progress — Neural Network 2025.*[cite: 37]

#### Accuracy & Confusion Matrices (2025)
The 2025 model reached an **Overall Accuracy of 97.0%** (All Confusion Matrix)[cite: 37].
* **True Positives:** 51.4% (2,178 samples)[cite: 37]
* **True Negatives:** 45.6% (1,931 samples)[cite: 37]
* **False Positives:** 1.3% (57 samples)[cite: 37]
* **False Negatives:** 1.7% (72 samples)[cite: 37]
* **Test Evaluation:** 97.2% overall test accuracy (98.0% correct on Class 0, 96.2% on Class 1)[cite: 37]

![Table 6: Confusion Matrices 2025](Plots-2025/confusion_matrix_2025.png)
*Table 6: MATLAB Confusion Matrices (Validation, Training, Test, All) for 2025.*[cite: 38]

#### Performance Plot (2025)
Validation and test cross-entropy curves decreased smoothly alongside the training curve across all 95 epochs[cite: 38].

![Table 7: Performance Plot 2025](Plots-2025/performance_plot_2025.png)
*Table 7: Cross-Entropy Performance Plot for 2025 showing best validation at epoch 89 (0.10093).*[cite: 38, 39]

![Cairo Urban Classification 2025](Cairo_urban_class25.png)
*Figure 3: Built-up environment classification map of Cairo for 2025 (Built-up in orange; Scale 1:300,000).*[cite: 39, 40]

---

### 3.3 Error Analysis
Despite high statistical accuracy (>97%–99%), visual inspection revealed localized misclassifications, concentrated along sandy desert peripheries[cite: 40]:
1. **High Albedo Confusion:** Unbuilt bare ground and sandy soils reflect radiation at levels comparable to certain manufactured construction materials, inducing misclassification[cite: 40].
2. **Mixed Pixels:** Boundary pixels at urban-vegetation and urban-desert transitions create spectral ambiguity[cite: 40].
3. **Topographic Shading:** In sand dune areas, steep slope shadows significantly alter digital numbers, causing false-positive built-up predictions[cite: 40].

<p align="center">
  <img src="images/Figures4_5_error_2015.png" width="48%" alt="2015 Dune Misclassification Detail" />
  <img src="images/Figures6_7_error_2025.png" width="48%" alt="2025 Dune Misclassification Detail" />
</p>
*Figures 4 & 5 (left): Detailed zoom of dune shadow misclassification in 2015. Figures 6 & 7 (right): Corresponding dune misclassification in 2025.*[cite: 40, 41]

---

## 4. Multi-Temporal Comparison and Conclusions

### 4.1 Multi-Temporal Comparison (2015–2025)
Binary thresholding was applied to the probability surfaces ($0 \le 80$ Non-built, $1 > 80$ Built)[cite: 41]. Difference raster algebra was executed in Python (Spyder) to quantify spatial change[cite: 41]:

$$\Delta \text{Built} = \text{Built}_{2025} - \text{Built}_{2015}$$

* **Total New Built-Up Pixels (Class 1):** 5,321,621 pixels[cite: 42]
* **Total Decadal Urban Expansion:** **532.16 km²**[cite: 42]

The slight accuracy difference between 2015 (99.0%) and 2025 (97.0%) stems from increased landscape heterogeneity caused by rapid urban sprawl and new transitional surfaces[cite: 42]. Nonetheless, both models mapped decadal land dynamics with high fidelity, highlighting extensive development eastward into New Cairo and desert tracts[cite: 31, 42].

![Cairo Urban Expansion 2015-2025](urban%20expantion%202015-2025.jpg)
*Figure 8: Decadal urban expansion map of Cairo (2015–2025) showing 2015 baseline urban footprint (orange) and 2015–2025 new urban expansion (red; Scale 1:300,000).*[cite: 42]

### 4.2 Conclusions
* The ANN classification pipeline achieved overall accuracies exceeding **97%** for both temporal scenes[cite: 42].
* Code **vectorization** in MATLAB eliminated loop overhead, reducing runtime from hours/days to seconds and making iterative retraining practical[cite: 30, 42].
* Spectral confusion occurred in sandy dune areas due to shadow dynamics and bare soil albedo, underscoring the challenge of arid-zone classification[cite: 40, 42].
* The measured expansion of **532.16 km²** verifies rapid sprawl across Greater Cairo, emphasizing the necessity of routine satellite monitoring for sustainable metropolitan governance[cite: 42].

---

## 5. References

1. Yanyan Dong, Xiaogao Chang (2026), *Spatio-temporal analysis of land use and land cover changes: assessing urban expansion and ecological transformations (2003–2023)*, GeoJournal[cite: 42].
2. H. N. Manh, T. V. Anh et.al. (2025), *Urban Expansion Monitoring Using Sentinel-1 and Sentinel-2 Data Fusion on Google Earth Engine*, Volume 2: Earth, Mine, and Environmental Sciences for Green, Sustainable, and Prosperous Development[cite: 42].
3. Osman, T., Arima, T. & Divigalpitiya, P. (2016), *Measuring Urban Sprawl Patterns in Greater Cairo Metropolitan Region*, J Indian Soc Remote Sens 44, 287–295. https://doi.org/10.1007/s12524-015-0489-6[cite: 31, 42]
4. Radek Silhavy, Petr Silhavy (2024), *Machine Learning Methods in Systems*, Proceedings of 13th Computer Science On-line Conference, Vol. 4[cite: 30, 42].
5. Reynaldo Hinojosa-Contreras, Eric Gielen, José-Sergio Palencia-Jiménez, Isidro Cantarino-Mart (2026), *Urban sprawl in Latin America: A systematic review of the existing literature and emerging insights*, Land Use Policy, Volume 165[cite: 30, 42].
6. World Population Review (2026), *Africa Cities by Population 2026*. Available: https://worldpopulationreview.com/cities/continent/africa[cite: 31, 42]
7. European Space Agency (ESA), *Cairo Overview and Urban Monitoring*. Available: https://www.esa.int/SPECIALS/Eduspace_Global_GR/SEM0G3ZOBFG_2.html[cite: 31, 42]

---
*Project developed at the University of the Aegean, Department of Geography.*[cite: 30, 36, 42]
