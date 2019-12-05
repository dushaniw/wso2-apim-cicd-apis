#!/bin/sh

echo $(which apictl)
apictl version

rm -rf $HOME/.wso2apictl

echo 'setting up dev environment'
apictl add-env -e dev \
                    --registration https://10.100.7.153:9443/client-registration/v0.15/register \
                    --apim https://10.100.7.153:9443 \
                    --token https://10.100.7.153:8243/token \
                    --admin https://10.100.7.153:9443/api/am/admin/v0.15 \
                    --api_list https://10.100.7.153:9443/api/am/publisher/v0.15/apis \
                    --app_list https://10.100.7.153:9443/api/am/store/v0.15/applications
echo 'logging into dev'
apictl login dev -u $USERNAME -p $PASSWORD -k

echo 'setting up prod environment'
apictl add-env -e prod \
                    --registration https://10.100.7.153:9444/client-registration/v0.15/register \
                    --apim https://10.100.7.153:9444 \
                    --token https://10.100.7.153:8244/token \
                    --admin https://10.100.7.153:9444/api/am/admin/v0.15 \
                    --api_list https://10.100.7.153:9444/api/am/publisher/v0.15/apis \
                    --app_list https://10.100.7.153:9444/api/am/store/v0.15/applications
echo 'logging into prod'
apictl login prod -u $USERNAME -p $PASSWORD -k
