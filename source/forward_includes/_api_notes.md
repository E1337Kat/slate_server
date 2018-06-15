# API Facts

### Pagination
Every collection resource can be returned paginated. By default, if a collection has more than 25 items, it will be returned paginated, but you can control how many items are returned per page, and which page to request.

> Example: `https://api.wecounsel.com/v1/calendar?access_token=xyz&page[size]=10&page[number]=2`

The response, in addition to the regular fields, will include a pagination object inside a meta object. You can see this in the response body of this example (have to be signed-in to view).

<aside class="notice">Note: The example query parameters above use unencoded [ and ] characters simply for readability. In practice, these characters must be percent-encoded.
</aside>

### Time Zone
All times are generally returned in the time zone of the current user. The time zone of the current user can be obtained by GET .../v1/users/me . See detailed information here (have to be signed-in to view).

### Organization Mode
To specify the organization in context of which the request should be executed, add org_mode=’org_value` to the request.

> Example: `https://api.wecounsel.com/v1/users/123?access_token=xyz&org_mode='my_org'`

### Rate Limits
Currently API calls from the same IP are limited to 15 per minute. If this limit is exceeded, 429 Too Many Requests HTTP status will be returned.

### API Reference
To access the full API reference, log-in with your Wecounsel account, and go to https://portal.wecounsel.com/docs (if you are using a portal, change the link to https://<my_portal>/docs)
