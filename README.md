# Classic-MUSIC

This repository contains the implementation of the **MUSIC (Multiple Signal Classification)** algorithm for estimating the Angle of Arrival (AoA) in MIMO systems. Classic MUSIC assumes that the number of sources is known a priori; therefore, in this project, we implemented criteria to estimate it.

## 📌 Features
- Antenna Array Design: ULA.
- Scenario: Free space with Line-of-Sight.
- System: MIMO, M-MIMO.

## 📌 File Description

| File                 | Description                                  |
|----------------------|----------------------------------------------|
| `main.m`            | Main script for the MUSIC algorithm          |
| `signals.m`         | Generates/processes signals                  |
| `responsearray.m`   | Defines the array response matrix            |
| `aic_estimation.m`  | Implements the AIC criterion                |
| `gap_estimation.m`  | Implements the natural separation criterion  |
| `mdl_estimation.m`  | Implements the MDL criterion                |
| `music.m`           | Implementation of the MUSIC algorithm        |
