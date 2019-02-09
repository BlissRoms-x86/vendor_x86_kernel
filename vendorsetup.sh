# save the official lunch command to aosp_lunch() and source it
tmp_lunch=`mktemp`
sed '/ lunch()/,/^}/!d'  build/envsetup.sh | sed 's/function lunch/function aosp_lunch/' > ${tmp_lunch}
source ${tmp_lunch}
rm -f ${tmp_lunch}

# Override lunch function to filter lunch targets
function lunch
{
   aosp_lunch $*

   rm -rf Android.mk
   vendor/x86_kernel/utils/autopatch.sh

}


