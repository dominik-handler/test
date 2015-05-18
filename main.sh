

lib_names="wt wt_PIWI_ChIP wt_HP1 wt_poll_chip wt_ChIP_tmH3K4 wt_ChIP_tmH3K9 wt_ChIP_tmH3K27 wt_acH3K9 piwi_ChIP_Background piwi_ChIP_HP1 piwi_ChIP_PolII piwi_ChIP_mH3K4 piwi_ChIP_tmH3K9 piwi_ChIP_acH3K9 Gtsf1_het_input Gtsf1_het_H3K9me3 Gtsf1_hom_H3K9me3"


raw_folder="/groups/brennecke/www/tmp/read_annotation/haifan6/"

tmp="/local3tb/handler/haifan/"
rm -rf $tmp
mkdir -p $tmp
cd $tmp

echo $tmp
#lib_names=$(echo $lib_names | awk '{ print $1}')

available_folder_names="uniq-0MM collapsed-0MM all-0MM uniq-Uextra-0MM collapsed-Uextra-0MM all-Uextra-0MM"
#available_folder_names=$(echo $available_folder_names | awk '{ print $1}')

for folder_name in $available_folder_names
do

  folder=${raw_folder}/${folder_name}/

  for library in $lib_names
  do
    echo ${folder}${library}/${library}_final_annotation.txt
    cp ${folder}${library}/${library}_final_annotation.txt ${tmp}${library}_final_annotation.txt
    Rscript /groups/brennecke/handler/scripts/do_pie_charts/plot_pie-chart.R name=${library} folder_name=${folder_name} 
   done
   
   module load imagemagick
   montage=""
   for name in $lib_names;do montage=$(echo $montage ${tmp}${name}_pie.jpeg ); done
   montage $montage  -tile x1 -geometry +2+2 ${tmp}${folder_name}.jpeg
  
done

module load imagemagick
montage=""
for name in $available_folder_names;do montage=$(echo $montage ${tmp}${name}.jpeg ); done
echo $montage
montage $montage -tile 1x6 -geometry +2+2  ${tmp}full.jpeg

