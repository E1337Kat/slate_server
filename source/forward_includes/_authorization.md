# Authentication

## General
Whether you want to integrate Wecounsel API into your application, or just allow your users to authenticate with their existing Wecounsel credentials, you need to work with oAuth. Wecounsel exposes the industry-standard oAuth2 protocol, through which applications can allow their users to perform user authentication. When the user clicks a “Login with Wecounsel” button, the application should redirect him to Wecounsel secured server, where the client authenticates with his usual Wecounsel username and password. Then he is returned to the application with a token, which from that point is used by the client's browser to access application’s protected pages.

## How To
In order to set-up your application to authenticate with Wecounsel oAuth mechanism, there are several steps involved:

1. Provide to your Wecounsel contact the callback URL (for both, edge and production environments) to which the Wecounsel server should redirect clients after successful authentication. Here’s an example of such callback URL: http://your.app.com/auth/wecounsel/callback
2. Receive from your Wecounsel contact Application Id and Secret (for both, edge and production environments) and set them as environment variables in your application (never put them in version-controlled files).
3. Code the code
4. Test your implementation with this ruby script against the Wecounsel edge server:
* Install ruby on your dev machine and clone/copy the project to your machine.
* Add a secrets.yml file in the oauth_tools root directory and add your Application Id and Secret credentials for each environment like this.
* Run on command line: ENV=edge ruby oauth_test_client.rb
* Follow the instructions on screen
* Change to ENV=production when you are ready to test with production

## Access Token
When authorization completes successfully, your application will have received access token. This token should be provided in each subsequent API call. 

for `GET` and `DELETE` requests the access token should be passed as a query parameter, like this: `https://api.wecounsel.com/v1/calendar?access_token=e0059898cd9bf3931cafa695bcf`
For POST and PATCH requests, the access token should be passed in Authorization header with value: Bearer e0059898cd9bf3931cafa695bcf

## Refresh Token
The access token you receive is valid for 2 hours. In order to receive a new access token when the current one expires (and to avoid making your users authenticate often), use the refresh token you received together with the access token. Refresh tokens do not expire, so you can save those in your DB, preferably encrypted.
