# Implementation of an Optimized Blockwise Nonlocal Means Denoising Filter for 2-D MRI Images

## Project Intro

This project aims at implementing an optimized NLM denoising filter. Compared to the classical NLM, we mainly optimized it in three ways:
1) an automatic tuning of the smoothing parameter;
2) a selection of the pixels or blocks;
3) a blockwise implementation;

After these optimization, the computation time of algorithm improved 5 times compared to the classical one while the denoising performance did not decrease.
