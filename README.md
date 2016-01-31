#Data Cleaning Project: Wearables

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does these things:

1. Creates a Directory and makes it the working directory.
2. If the zipped file hasn't been downloaded, it downloads it into this directory then unzips it.
3. We read the eight key files into R.
+activity_labels.txt
+features.txt
+X_train.txt (with Activity_labels labeled)
+X_test.txt (with Activity_labels labeled)
+y_train.txt
+y_test.txt
+subject_train
+subject_test
4. A new dataset keeps only the columns containing means and stdevs.
5. Combines the training and test dataset, labeling activities and 
6. 'activity' and 'subject' are converted into factors
7. Exports the (tidy) dataset to 'tidy.txt'
8. Creates a (tidy) dataset for the average for each activity
9. Creates a (tidy) dataset for the average of each subject.

---
title: "README.md"
author: "Scott Alberts"
date: "January 30, 2016"
output: html_document
---