

#---------------------------------
# New invocation of recon-all Mon Jan  1 23:33:49 UTC 2018 

 mri_convert /home/ubuntu/sMRI/3176.nii /usr/local/freesurfer/subjects/3176/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Mon Jan  1 23:34:00 UTC 2018

 cp /usr/local/freesurfer/subjects/3176/mri/orig/001.mgz /usr/local/freesurfer/subjects/3176/mri/rawavg.mgz 


 mri_convert /usr/local/freesurfer/subjects/3176/mri/rawavg.mgz /usr/local/freesurfer/subjects/3176/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3176/mri/transforms/talairach.xfm /usr/local/freesurfer/subjects/3176/mri/orig.mgz /usr/local/freesurfer/subjects/3176/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Mon Jan  1 23:34:14 UTC 2018

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 

