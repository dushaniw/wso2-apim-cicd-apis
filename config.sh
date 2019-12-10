#!/bin/sh

echo $(which apictl)
apictl version

rm -rf $HOME/.wso2apictl

echo 'setting up dev environment'
apictl add-env -e dev \
                    --registration https://dev.apim.wso2.com/client-registration/v0.15/register \
                    --apim https://dev.apim.wso2.com \
                    --token https://dev.apim.wso2.com/token \
                    --admin https://dev.apim.wso2.com/api/am/admin/v0.15 \
                    --api_list https://dev.apim.wso2.com/api/am/publisher/v0.15/apis \
                    --app_list https://dev.apim.wso2.com/api/am/store/v0.15/applications

echo 'setting up prod environment'
apictl add-env -e prod \
                    --registration https://prod.apim.wso2.com/client-registration/v0.15/register \
                    --apim https://prod.apim.wso2.com \
                    --token https://prod.apim.wso2.com/token \
                    --admin https://prod.apim.wso2.com/api/am/admin/v0.15 \
                    --api_list https://prod.apim.wso2.com/api/am/publisher/v0.15/apis \
                    --app_list https://prod.apim.wso2.com/api/am/store/v0.15/applications