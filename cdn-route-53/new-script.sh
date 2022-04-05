#!/bin/bash
/bin/terraform show |grep cdn_domain|awk '{print$3}'|tr -d '"' > cdn_domain
/bin/terraform show |grep s3_bucket_name_id|awk '{print$3}'|tr -d '"' > route53_domain

cdn_domain=`cat cdn_domain`
route=`cat route53_domain`

echo ${cdn_domain}
echo ${route}

#sed -i "s/domain_value/${cdn_domain}/g" update-record.json 
sed -i "s/route_variable/${route}/g" update-record.json && cat update-record.json 
#aws route53 change-resource-record-sets --hosted-zone-id Z2434WFRJZDZ7A --change-batch file://update-record.json
