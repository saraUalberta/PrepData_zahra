

#---------------------------------
# New invocation of recon-all Sat Jan 13 22:04:33 UTC 2018 

 mri_convert /home/ubuntu/sMRI/3818.nii /usr/local/freesurfer/subjects/3818/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Sat Jan 13 22:04:39 UTC 2018

 cp /usr/local/freesurfer/subjects/3818/mri/orig/001.mgz /usr/local/freesurfer/subjects/3818/mri/rawavg.mgz 


 mri_convert /usr/local/freesurfer/subjects/3818/mri/rawavg.mgz /usr/local/freesurfer/subjects/3818/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3818/mri/transforms/talairach.xfm /usr/local/freesurfer/subjects/3818/mri/orig.mgz /usr/local/freesurfer/subjects/3818/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Sat Jan 13 22:04:54 UTC 2018

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Sat Jan 13 22:14:19 UTC 2018

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /usr/local/freesurfer/bin/extract_talairach_avi_QA.awk /usr/local/freesurfer/subjects/3818/mri/transforms/talairach_avi.log 


 tal_QC_AZS /usr/local/freesurfer/subjects/3818/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Sat Jan 13 22:14:19 UTC 2018

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3818/mri/transforms/talairach.xfm nu.mgz nu.mgz 

#--------------------------------------------
#@# Intensity Normalization Sat Jan 13 22:25:51 UTC 2018

 mri_normalize -g 1 -mprage nu.mgz T1.mgz 

#--------------------------------------------
#@# Skull Stripping Sat Jan 13 22:30:01 UTC 2018

 mri_em_register -rusage /usr/local/freesurfer/subjects/3818/touch/rusage.mri_em_register.skull.dat -skull nu.mgz /usr/local/freesurfer/average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta 


 mri_watershed -rusage /usr/local/freesurfer/subjects/3818/touch/rusage.mri_watershed.dat -T1 -brain_atlas /usr/local/freesurfer/average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta T1.mgz brainmask.auto.mgz 


 cp brainmask.auto.mgz brainmask.mgz 

#-------------------------------------
#@# EM Registration Sat Jan 13 23:06:03 UTC 2018

 mri_em_register -rusage /usr/local/freesurfer/subjects/3818/touch/rusage.mri_em_register.dat -uns 3 -mask brainmask.mgz nu.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta 

#--------------------------------------
#@# CA Normalize Sat Jan 13 23:29:10 UTC 2018

 mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz 

#--------------------------------------
#@# CA Reg Sat Jan 13 23:32:03 UTC 2018

 mri_ca_register -rusage /usr/local/freesurfer/subjects/3818/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z 

#--------------------------------------
#@# SubCort Seg Sun Jan 14 03:48:22 UTC 2018

 mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz 

