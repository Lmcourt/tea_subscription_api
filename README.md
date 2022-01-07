## Tea Subscription API
This is a REST API for a tea subscription service.

### Primary Technologies

  - Ruby 2.7.2
  - Rails 5.2.6
  - PostgreSQL


### Local Set-Up

Fork and clone this repository to your local machine then

`bundle install`

`rails db:{create,migrate,seed}`


### Testing

Testing is done with [RSpec](https://rspec.info/) with coverage details provided by [SimpleCov](https://github.com/simplecov-ruby/simplecov).

#### Test Suite Execution

`bundle exec rspec`


### Database Design

![Screen Shot 2021-12-08 at 1 56 33 PM](https://user-images.githubusercontent.com/84806907/145283660-625b735b-7ddb-430a-88ad-84797ff6ab5b.png)

### Endpoints

`GET /api/v1/customers/:customer_id/subscriptions`

Response:

```
{
    "id": "10",
    "type": "subscription",
    "attributes": {
        "id": 10,
        "title": "est",
        "price": 8,
        "status": "cancelled",
        "frequency": "Monthly"
    }
},
{
    "id": "11",
    "type": "subscription",
    "attributes": {
        "id": 11,
        "title": "commodi",
        "price": 13,
        "status": "active",
        "frequency": "Bi-monthly"
    }
}
```


`POST /api/v1/customers/:customer_id/subscriptions`

With the required body:
```
{
  "title": "Lovely tea",
  "price": 5,
  "status": "active",
  "frequency": "Monthly",
  "customer_id": 1,
  "tea_id": 1
  }
```
Response:
```

```

`PATCH /api/v1/customers/:customer_id/subscriptions/:id`
With the required body:
```
{
  "status": "cancelled"
}
```

Response:
```
{
    "id": "11",
    "type": "subscription",
    "attributes": {
        "id": 11,
        "title": "commodi",
        "price": 13,
        "status": "active",
        "frequency": "Bi-monthly"
    }
}
```

### Contributors

Laura Court
- [LinkedIn](https://www.linkedin.com/in/laura-court/)
- [GitHub](https://github.com/lmcourt)
