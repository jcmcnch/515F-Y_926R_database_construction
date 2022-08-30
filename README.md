# 515F-Y_926R_database_construction

This is a repository that shows the steps for creating `qiime2` classifiers specific for the "Parada primers". You might find yourself needing to do this when updating `qiime2` as the `scikit-learn` version used to create the classifer needs to be the same as your version of `qiime2`. Selected artifacts are available at the OSF.io link below. Please open a github issue if you have any questions. If you want to add other artifacts to the OSF repo, you can just make a free account on OSF and ask to collaborate.

How artifacts were created:

1. Using the steps outlined in the RESCRIPt tutorial posted on the `qiime2` forum (see link below), *SILVA* (138.1) classifiers were created for the 515F-Y / 926R primers.
2. The dereplicated sequences and taxonomy were exported to create input files for `VSEARCH`.
3. These files were combined using a custom python script.
4. A UDB file was then created with `VSEARCH`.
5. The same steps were followed for *PR2* (4.14.0).
6. All four classifiers were uploaded to OSF.io.

To do:
- Re-jig pipeline to include updated db and new workflow (PR2 as first-pass, SILVA138.1 second)

Location of finished artifacts:

https://osf.io/e65rs/

Source for RESCRIPt commands:
https://forum.qiime2.org/t/processing-filtering-and-evaluating-the-silva-database-and-other-reference-sequence-data-with-rescript/15494

Source for PR2 files:
https://github.com/pr2database/pr2database/releases/tag/v4.14.0
