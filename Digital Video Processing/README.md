# Color Video Denoising Based on Combined Interframe and Intercolor Prediction

## Project Intro

This project aims at implementing an color video denoising filter. Compared to the classical spatial filtering, we also consider the interframe(temporal) and intercolor relationship:
1) an automatic tuning of the smoothing parameter;
2) a selection of the pixels or blocks;
3) a blockwise implementation;

After these optimization, the computation time of algorithm improved 5 times compared to the classical one while the denoising performance did not decrease.


