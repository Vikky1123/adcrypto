# How to Create Google API Credentials for Social Login

This guide will walk you through the process of creating the necessary Google API credentials to enable "Sign in with Google" functionality on your website.

## Step 1: Go to the Google Cloud Platform Console

First, you'll need to go to the [Google Cloud Platform Console](https://console.cloud.google.com/). If you don't have an account, you'll need to create one.

## Step 2: Create a New Project

1.  In the top-left corner, click the project dropdown menu and select **New Project**.
2.  Give your project a name (e.g., "adcrypto-social-login") and click **Create**.

## Step 3: Enable the Google+ API

1.  In the left-hand navigation menu, go to **APIs & Services > Library**.
2.  In the search bar, type "Google+ API" and press Enter.
3.  Click on the **Google+ API** result and then click the **Enable** button.

## Step 4: Create an OAuth 2.0 Client ID

1.  In the left-hand navigation menu, go to **APIs & Services > Credentials**.
2.  Click the **Create credentials** button and select **OAuth client ID**.
3.  For the **Application type**, select **Web application**.
4.  Give your client ID a name (e.g., "adcrypto-web-client").

## Step 5: Set the Authorized Redirect URIs

Under **Authorized redirect URIs**, you'll need to add the following URL:

```
http://127.0.0.1:8000/oauth/google/response
```

This is the URL that Google will redirect users to after they have authenticated with their Google account.

## Step 6: Get Your Client ID and Client Secret

After you've created the OAuth client ID, you'll be presented with your **client ID** and **client secret**. You'll need to copy these values and provide them to me so I can add them to the `.env` file.

Once you have completed these steps, please let me know and I'll proceed with the next step.