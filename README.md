# edabk_genderDetection
Detect gender through a voice.

- !!! Download dataset at: (valid-12/04/2020)
	https://www.kaggle.com/mozillaorg/common-voice/home
- !!! Copy the folder "cv-valid-train/cv-valid-train" to the folder containing the source code.

- Using matlab to run.
- Description:
	+ pitchDetection.m: Detect gender of a voice file with Auto-correlation function and pitch threshold.

	+ test_pitchDetection.m: Test the precision of "pitchDetection.m" with 74.546  gender labeled samples.

	+ test_pitchDetection_2000.m: Short test with 2.000 samples.
	
	+ label_2000.txt: Label of 2.000 samples.
	
	+ label_all.txt: Label of 74.546 samples.

- Open one of the m-files above on matlab to Debug.
- "Editor-> Run" or press "F5"  to Debug.
