# Puppers

## Get All Puppers

```ruby
require 'puppr'

api = Puppr::APIClient.authorize!('woofwoofwoof')
api.puppers.get
```

```python
import puppr

api = puppr.authorize('woofwoofwoof')
api.puppers.get()
```

```shell
curl "http://example.com/api/puppers"
  -H "Authorization: woofwoofwoof"
```

```javascript
const puppr = require('puppr');

let api = puppr.authorize('woofwoofwoof');
let puppers = api.puppers.get();
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 1,
    "name": "Fluffums",
    "breed": "calico",
    "fluffiness": 6,
    "cuteness": 7
  },
  {
    "id": 2,
    "name": "Max",
    "breed": "unknown",
    "fluffiness": 5,
    "cuteness": 10
  }
]
```

This endpoint retrieves all puppers.

### HTTP Request

`GET http://example.com/api/puppers`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
include_doggos | false | If set to true, the result will also include big ol' puppers.
available | true | If set to false, the result will include puppers that have already been adopted.

<aside class="success">
Remember — a happy pupper is an authenticated pupper!
</aside>

## Get a Specific Pupper

```ruby
require 'puppr'

api = Puppr::APIClient.authorize!('woofwoofwoof')
api.kittens.get(2)
```

```python
import puppr

api = puppr.authorize('woofwoofwoof')
api.puppers.get(2)
```

```shell
curl "http://example.com/api/puppers/2"
  -H "Authorization: woofwoofwoof"
```

```javascript
const puppr = require('puppr');

let api = puppr.authorize('woofwoofwoof');
let max = api.puppers.get(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Max",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

This endpoint retrieves a specific pupper.

<aside class="warning">Inside HTML code blocks like this one, you can't use Markdown, so use <code>&lt;code&gt;</code> blocks to denote code.</aside>

### HTTP Request

`GET http://example.com/puppers/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the pupper to retrieve

## Delete a Specific Pupper

```ruby
require 'puppr'

api = Puppr::APIClient.authorize!('woofwoofwoof')
api.puppers.delete(2)
```

```python
import puppr

api = puppr.authorize('woofwoofwoof')
api.puppers.delete(2)
```

```shell
curl "http://example.com/api/puppers/2"
  -X DELETE
  -H "Authorization: woofwoofwoof"
```

```javascript
const puppr = require('puppr');

let api = puppr.authorize('woofwoofwoof');
let max = api.puppers.delete(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "deleted" : ":("
}
```

This endpoint deletes a specific kitten.

### HTTP Request

`DELETE http://example.com/puppers/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the pupper to delete
