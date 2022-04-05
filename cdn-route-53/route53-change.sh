#!/bin/bash

/bin/terraform show |grep cdn_domain|awk '{print$3}'|tr -d '"' > cdn_domain
/bin/terraform show |grep s3_bucket_name_id|awk '{print$3}'|awk -F'"' '$0=$2' > route53_domain

cdn_domain=`cat cdn_domain`
route=`cat route53_domain`

echo ${cdn_domain}
echo ${route}

aws route53 change-resource-record-sets --hosted-zone-id Z2434WFRJZDZ7A --change-batch file://<(cat << EOF

{
  "Comment": "Swaps the Policy Record for a simple routing policy",
  "Changes": [
    {
      "Action": "CREATE",
      "ResourceRecordSet": {
      "Name": "${route}",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "Z2FDTNDATAQYW2",
          "DNSName": "${cdn_domain}",
          "EvaluateTargetHealth": false
        }
      }
    }
  ]
}
EOF
)

#this is the end point mapped with cdn
echo "BELOW IS THE DNS MAPPED ROUTE"
echo ${route}
