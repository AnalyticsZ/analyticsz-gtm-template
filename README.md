# AnalyticsZ Browser Tracking Tag for Google Tag Manager

The AnalyticsZ Browser Tracking Tag connects a Google Tag Manager Web container to an AnalyticsZ website. It loads the official AnalyticsZ browser tracker and verifies the installation with a website-specific token generated inside AnalyticsZ.

Current release: **1.2.0**

## Features

- Codeless AnalyticsZ installation through Google Tag Manager
- Website-specific verification token
- Automatic page and event tracking through the existing AnalyticsZ tracker
- Restricted script-injection permission limited to `analyticsz.com`
- Google Tag Manager sandboxed JavaScript
- Built-in template tests
- Automatic connection health and template-version reporting in AnalyticsZ

## Installation

1. In AnalyticsZ, open **Apps & Integrations** and select the website.
2. Open **Google Tag Manager** and start setup.
3. Copy the verification token.
4. In a GTM Web container, open **Templates → Search Gallery**.
5. Search for **AnalyticsZ Browser Tracking Tag** and add it to the workspace.
6. Create a new tag, paste the verification token, and choose the **All Pages** trigger.
7. Publish the container and visit the website once.
8. AnalyticsZ will verify the connection automatically.

Until the Community Template Gallery listing is approved, AnalyticsZ also provides a manual `.tpl` download.

## Permissions

The template requests only the `inject_script` permission and restricts it to:

```text
https://analyticsz.com/integrations/google-tag-manager/loader.js*
```

## Support

- Documentation: https://analyticsz.com/developers/integrations/google-tag-manager
- Product: https://analyticsz.com
- Issues: use this repository's GitHub Issues tab

## License

Apache License 2.0.
