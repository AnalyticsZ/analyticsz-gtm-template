___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "categories": [
    "ANALYTICS",
    "CONVERSIONS",
    "MARKETING"
  ],
  "displayName": "AnalyticsZ Browser Tracking Tag",
  "brand": {
    "id": "analyticsz",
    "displayName": "AnalyticsZ"
  },
  "description": "Connect a website to AnalyticsZ, load the AnalyticsZ browser tracker, and verify the installation with a website-specific token.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "verificationToken",
    "displayName": "AnalyticsZ verification token",
    "simpleValueType": true,
    "notSetText": "Enter the verification token from AnalyticsZ",
    "help": "Open AnalyticsZ, go to Apps \u0026 Integrations, choose Google Tag Manager, and copy the verification token for the selected website.",
    "valueValidators": [
      {
        "type": "NON_EMPTY",
        "errorMessage": "Enter the AnalyticsZ verification token."
      },
      {
        "type": "REGEX",
        "args": [
          "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89aAbB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$"
        ],
        "errorMessage": "Enter the complete verification token shown in AnalyticsZ."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const encodeUriComponent = require('encodeUriComponent');
const makeString = require('makeString');
const getContainerVersion = require('getContainerVersion');

const token = makeString(data.verificationToken || '').trim();
const containerVersion = getContainerVersion();
const containerId = makeString(containerVersion.containerId || '').trim();
const templateVersion = '1.3.0';

if (!token) {
  data.gtmOnFailure();
  return;
}

const loaderUrl = 'https://analyticsz.com/integrations/google-tag-manager/loader.js?token=' + encodeUriComponent(token) +
  '&container=' + encodeUriComponent(containerId) +
  '&version=' + encodeUriComponent(templateVersion);

injectScript(
  loaderUrl,
  data.gtmOnSuccess,
  data.gtmOnFailure,
  'analyticsz-google-tag-manager-v1-3'
);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://analyticsz.com/integrations/google-tag-manager/loader.js*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Loads the AnalyticsZ GTM loader with a valid token
  code: |-
    runCode({
      verificationToken: '123e4567-e89b-42d3-a456-426614174000'
    });
    assertApi('injectScript').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
    assertThat(injectedUrl).isEqualTo('https://analyticsz.com/integrations/google-tag-manager/loader.js?token=123e4567-e89b-42d3-a456-426614174000&container=GTM-TEST123&version=1.3.0');
    assertThat(cacheToken).isEqualTo('analyticsz-google-tag-manager-v1-3');
- name: Fails when the token is empty
  code: |-
    runCode({ verificationToken: '' });
    assertApi('injectScript').wasNotCalled();
    assertApi('gtmOnSuccess').wasNotCalled();
    assertApi('gtmOnFailure').wasCalled();
setup: |-
  mock('getContainerVersion', function() {
    return {containerId: 'GTM-TEST123', version: '1'};
  });
  let injectedUrl = '';
  let cacheToken = '';
  mock('injectScript', function(url, onSuccess, onFailure, token) {
    injectedUrl = url;
    cacheToken = token;
    onSuccess();
  });


___NOTES___

AnalyticsZ Google Tag Manager template version 1.3.0.


