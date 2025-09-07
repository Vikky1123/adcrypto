# AdCrypto Login Credentials

## Admin Login

**URL**: http://adcrypto.test/admin/login (or your configured admin URL)
**Username/Email**: superadmin@appdevs.net
**Password**: appdevs

## User Login

### Test User 1
**Email**: user@appdevs.net
**Password**: appdevs

### Test User 2
**Email**: user1@appdevs.net
**Password**: appdevs

## Google Authentication

To enable Google Sign-In, you need to:
1. Add Google OAuth credentials to your `.env` file:
   ```
   GOOGLE_CLIENT_ID=your_google_client_id_here
   GOOGLE_CLIENT_SECRET=your_google_client_secret_here
   GOOGLE_CALLBACK=https://yourdomain.com/oauth/google/response
   ```
2. Configure your Google OAuth app in the Google Developers Console
3. Run `php artisan config:cache` to refresh the configuration

## Notes

1. These are the default credentials that come with the application seeders
2. For security reasons, you should change these passwords after your first login
3. The application uses the database configuration from the `.env` file:
   - Database: adcrypto
   - Host: localhost
   - Port: 3306
   - Username: root
   - Password: (empty)