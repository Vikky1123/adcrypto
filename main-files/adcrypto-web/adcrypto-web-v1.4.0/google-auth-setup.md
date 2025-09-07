# Google Authentication Setup Guide

To enable Google Sign-In functionality, you need to add the following credentials to your `.env` file:

## Required Environment Variables

Add these lines to your `.env` file:

```
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=your_google_client_secret_here
GOOGLE_CALLBACK=https://yourdomain.com/oauth/google/response
```

## How to Get Google Credentials

1. Go to the [Google Developers Console](https://console.developers.google.com/)
2. Create a new project or select an existing one
3. Navigate to "Credentials" in the left sidebar
4. Click "Create Credentials" and select "OAuth client ID"
5. Choose "Web application" as the application type
6. Add your domain to the "Authorized JavaScript origins" (e.g., https://yourdomain.com)
7. Add your callback URL to "Authorized redirect URIs" (e.g., https://yourdomain.com/oauth/google/response)
8. Copy the Client ID and Client Secret to your `.env` file

## Facebook Authentication (Optional)

If you also want to enable Facebook authentication, add these credentials:

```
FACEBOOK_CLIENT_ID=your_facebook_client_id_here
FACEBOOK_CLIENT_SECRET=your_facebook_client_secret_here
FACEBOOK_CALLBACK=https://yourdomain.com/oauth/facebook/response
```

## Testing

After adding the credentials:
1. Clear the application cache: `php artisan config:cache`
2. Test the Google Sign-In button on the login and registration pages