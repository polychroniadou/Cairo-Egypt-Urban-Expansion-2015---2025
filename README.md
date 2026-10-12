# Binary Classification of Built-Up Environment in Cairo Using MATLAB and GIS

Mapping built-up vs non-built-up land in the Cairo region from Sentinel-2 imagery, using a neural network trained in MATLAB and GIS analysis, to measure urban expansion over a decade[cite: 30, 32].

![Urban expansion in Cairo, 2015-2025](urban%20expantion%202015-2025.jpg)

---

## 1. Introduction

Urban sprawl monitoring under conditions of rapid population growth and urbanization is vital for urban planning, resource management, and environmental impact assessment[cite: 30]. However, land cover mapping in heterogeneous landscapes faces ongoing challenges, particularly the collection and preservation of reliable training data for machine learning algorithms[cite: 30].

While Artificial Neural Networks (ANNs) excel at modeling complex data patterns, training can be computationally demanding[cite: 30]. In this project, execution was optimized using **vectorization**—refactoring loop- and scalar-based code into matrix and vector operations[cite: 30]. This reduced full-scene classification runtimes from hours/days down to seconds, enabling rapid retraining and testing[cite: 30].

---

## 2. Data and Methodology

### 2.1 Study Area
The study focuses on the peri-urban fringes of Cairo, Egypt—the most populous metropolitan area in Africa with over 23.5 million residents[cite: 31]. The territory features extreme landscape heterogeneity, where high-density urban areas directly border agricultural zones along the Nile and hyper-arid desert terrain[cite: 31].

![Sentinel-2 image of Cairo, 2015](Cairo_2015.png)
*Figure 1a: Sentinel-2 true-color composite of the Cairo study area (13 August 2015)[cite: 32].*

![Sentinel-2 image of Cairo, 2025](Cairo_2025.png)
*Figure 1b: Sentinel-2 true-color composite of the Cairo study area (25 August 2025)[cite: 32].*

<!-- 
========================================================================
IMAGE INSERTION COMMENT (LOCATION / STUDY AREA MAP):
If you have exported your Figure 1 map from the paper (Study Area: Cairo, Egypt 1:430,000), add it here:

![Study Area: Cairo, Egypt](images/cairo_study_area_map.jpg)
*Figure 1c: Geographic location of Cairo and New Cairo along the Nile River corridor (1:430,000).*[cite: 33]
========================================================================
-->

### 2.2 Satellite Data and Reference System
- **Sensors:** Sentinel-2A (Acquired: 13 August 2015) and Sentinel-2B (Acquired: 25 August 2025), downloaded via the Copernicus platform[cite: 32]. August scenes provide cloud-free coverage and minimal shadow interference[cite: 32].
- **Bands:** 9 spectral channels (60 m atmospheric bands and Band 8A were excluded)[cite: 32].
- **Coordinate Reference System:** Projected to **WGS 84 / UTM zone 36N (EPSG:32636)**[cite: 32].

### 2.3 Methodology
1. **Training Sampling:** Digitized polygons for Built-up (Class 1) and Non-built-up (Class 0) in GIS[cite: 32]. The same shapefile was used across both years as the sampled areas represent invariant reference classes for each year[cite: 32].
2. **ANN Architecture:** Configured a pattern recognition neural network (`patternnet`) in MATLAB with a hidden layer of 10 neurons, trained separately for 2015 and 2025[cite: 32, 33, 37]:
   - **2015 Split:** 70% Training | 20% Validation | 10% Testing[cite: 33]
   - **2025 Split:** 60% Training | 20% Validation | 20% Testing[cite: 37]
3. **Model Selection & Evaluation:** Assessed training progression, Confusion Matrices, ROC curves, and Cross-Entropy Performance Plots[cite: 32, 34, 35, 36, 38, 39].
4. **Vectorized Inference & Thresholding:** Applied exported network weights across each full scene using vectorized array operations[cite: 30, 32]. Probability outputs were thresholded at 80 ($\le 80$ non-built-up, $> 80$ built-up)[cite: 41].
5. **Change Detection:** Subtracted binary raster layers via Raster Calculator, then quantified net area change ($km^2$) using Python in Spyder[cite: 41, 42].

---

## 3. Results and Discussion

### 3.1 Results: Year 2015
Training completed at epoch 161, reaching its **Best Validation Performance** at epoch 155 with a cross-entropy loss of **0.027242**[cite: 33, 35].

- **Overall Accuracy:** **99.0%** (All Confusion Matrix), with 0.6% False Positives and 0.4% False Negatives[cite: 34].
- **Partition Accuracies:** Training: 99.1% | Validation: 99.0% | Test: 98.7%[cite: 34].
- Validation and test loss curves closely trace the training trajectory, and ROC curves hug the upper-left axis, indicating strong generalization without overfitting[cite: 35].

![Built-up area classification, Cairo 2015](Cairo_urban_class15.png)
*Figure 2: Built-up environment classification for Cairo, 2015 (built-up areas in green; scale 1:300,000)[cite: 36].*

<!-- 
========================================================================
IMAGE INSERTION COMMENT (2015 EVALUATION MATRICES & PLOTS):
Export your MATLAB plots into Plots-2015/ and uncomment:

<p align="center">
  <img src="Plots-2015/confusion_matrix_2015.png" width="48%" alt="Confusion Matrices 2015" />
  <img src="Plots-2015/performance_plot_2015.png" width="48%" alt="Performance Plot 2015" />
</p>
*Figure 3: 2015 evaluation outputs: Confusion Matrices (Table 2) and Cross-Entropy Performance Plot (Table 4).*[cite: 34, 36]
========================================================================
-->

### 3.2 Results: Year 2025
Training completed at epoch 95, with the **Best Validation Performance** occurring at epoch 89 at a cross-entropy loss of **0.10093**[cite: 37, 38].

- **Overall Accuracy:** **97.0%** (All Confusion Matrix)[cite: 37].
- **Partition Accuracies:** Training: 97.0% | Validation: 96.5% | Test: 97.2%[cite: 37].
- The slight decrease in accuracy relative to 2015 is attributed to increased urban fabric heterogeneity resulting from massive urban sprawl into fringe areas[cite: 42].

![Built-up area classification, Cairo 2025](Cairo_urban_class25.png)
*Figure 4: Built-up environment classification for Cairo, 2025 (built-up areas in orange; scale 1:300,000)[cite: 39, 40].*

<!-- 
========================================================================
IMAGE INSERTION COMMENT (2025 EVALUATION MATRICES & PLOTS):
Export your MATLAB plots into Plots-2025/ and uncomment:

<p align="center">
  <img src="Plots-2025/confusion_matrix_2025.png" width="48%" alt="Confusion Matrices 2025" />
  <img src="Plots-2025/performance_plot_2025.png" width="48%" alt="Performance Plot 2025" />
</p>
*Figure 5: 2025 evaluation outputs: Confusion Matrices (Table 6) and Cross-Entropy Performance Plot (Table 7).*[cite: 38, 39]
========================================================================
-->

### 3.3 Error Analysis
Despite accuracies exceeding 97%[cite: 34, 37], visual inspection revealed misclassifications primarily in peripheral sandy desert terrains[cite: 40]:
- **High Reflectance Confusion:** High-albedo sands exhibit spectral reflectance profiles very similar to certain concrete and building roofing materials[cite: 40].
- **Topographic Shading:** In dune complexes, steep slopes and shadows alter surface pixel reflectance, creating local false positives[cite: 40].
- **Mixed Pixels:** Transition boundaries between urban fabric, crops, and desert scrub generate mixed pixels that challenge binary separation[cite: 40].

<!-- 
========================================================================
IMAGE INSERTION COMMENT (ZOOMED DUNE ERROR EXAMPLES):
Export Figures 4, 5, 6, and 7 from page 12 of your paper and uncomment:

<p align="center">
  <img src="images/error_detail_2015.jpg" width="48%" alt="2015 Dune Misclassification Detail" />
  <img src="images/error_detail_2025.jpg" width="48%" alt="2025 Dune Misclassification Detail" />
</p>
*Figure 6: High-magnification inspection of dune shadow misclassification in 2015 (left) and 2025 (right).*[cite: 41]
========================================================================
-->

### 3.4 Multi-Temporal Comparison (2015–2025)
Subtracting the 2015 and 2025 binary classification layers quantified the decadal physical growth of the built environment[cite: 41]:

$$\Delta \text{Built} = \text{Built}_{2025} - \text{Built}_{2015}$$

- **Total New Built-Up Pixels:** 5,321,621 pixels[cite: 42]
- **Net Spatial Expansion:** **532.16 km²**[cite: 42]

The change detection demonstrates intense eastward urban expansion toward New Cairo and peripheral desert developments, matching documented metropolitan sprawl patterns[cite: 31, 42].

![Urban expansion in Cairo, 2015-2025](urban%20expantion%202015-2025.jpg)
*Figure 7: Multi-temporal urban expansion map of Cairo (2015–2025), showing baseline urban extent (orange) and 2015–2025 expansion corridors (red; scale 1:300,000)[cite: 42].*

---

## 4. Conclusions

- The artificial neural network model achieved high classification accuracy (>97%) across both observation dates[cite: 34, 37, 42].
- Implementing code **vectorization** in MATLAB significantly accelerated data processing, allowing rapid network iteration and retraining[cite: 30, 42].
- The quantified net expansion of **532.16 km²** confirms rapid, sprawling urban growth, underscoring the necessity of continuous satellite monitoring for sustainable metropolitan management[cite: 42].

---

## 5. References

1. Yanyan Dong, Xiaogao Chang (2026), *Spatio-temporal analysis of land use and land cover changes: assessing urban expansion and ecological transformations (2003–2023)*, GeoJournal[cite: 42].
2. H. N. Manh, T. V. Anh et.al. (2025), *Urban Expansion Monitoring Using Sentinel-1 and Sentinel-2 Data Fusion on Google Earth Engine*, Volume 2: Earth, Mine, and Environmental Sciences for Green, Sustainable, and Prosperous Development[cite: 42].
3. Osman, T., Arima, T. & Divigalpitiya, P. (2016), *Measuring Urban Sprawl Patterns in Greater Cairo Metropolitan Region*, J Indian Soc Remote Sens 44, 287–295[cite: 31, 42].
4. Radek Silhavy, Petr Silhavy (2024), *Machine Learning Methods in Systems*, Proceedings of 13th Computer Science On-line Conference, Vol. 4[cite: 30, 42].
5. Reynaldo Hinojosa-Contreras, Eric Gielen, José-Sergio Palencia-Jiménez, Isidro Cantarino-Mart (2026), *Urban sprawl in Latin America: A systematic review of the existing literature and emerging insights*, Land Use Policy, Volume 165[cite: 30, 42].
6. World Population Review (2026), *Africa Cities by Population 2026*[cite: 31, 42].
7. European Space Agency (ESA), *Cairo Overview and Urban Monitoring*[cite: 31, 42].

---
*Project developed at the University of the Aegean, Department of Geography.*[cite: 30, 36, 42]
