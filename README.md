# Multi-class-SMMCA
Code and Datasets for "A Novel Potential Small Molecule-MiRNA-Cancer Associations Prediction Model Base on Fingerprint, Sequence and Clinical Symptom"

Dataset:
1.Combine.mat--(1) miR-combine: 604 miRNA mature sequence and precursor sequence;
               (2) SMMA2: an intergated adjacency matrix of 604 miRNAs and 133 SMs;
               (3) MCA2: an intergated adjacency matrix of 604 miRNAs and 32 cancers;
2.multi-class dataset.mat--4 class SM-miRNA-disease association datasets
3.Sample10.12。mat--a Benchmark dataset
4.CancerSym.mat--a 32*322 matrix of 32 cancers and 322 symptoms, the value in the matrix represented the relation between each cancer and 322 symptoms. This matrix was a feature     matrix of cancer.
5.miRfeature.mat--the feature matrix of 604 miRNAs, which was calculated through miRfrature.m
6.MACSSF.mat--the feature matrix of 133 SMs, which was calculated by PaDEL-Descriptor

Code:
1.miRfeature.m--calculating the feature of miRNA
2.TreebaggerSMMCA.m--the main code 
