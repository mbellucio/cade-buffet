# Cadê Buffet API 

### Introduction
Welcome to the Cadê Buffet API!. This documentation will guide you throught our API and its available resources and how to consume them with HTTP requests.

### Authentication
Cadê Buffet is a completely open API. No authentication is required to query and get data.

## Resources
### Buffets
A Buffet is the organization that can cater for many events.

**Endpoints**
<ul>
  <li>
    <code>/api/v1/buffets/</code> -- get all the buffets resources
    <ul>
      <li>this resource accepts a <bold>Search Field</bold><code> params: {search: name}</code></li>
    </ul>
  </li>
  <li><code>/api/v1/buffets/:id/</code> -- get a specific buffet resource</li>
</ul>

**Example request:**
```
http http://localhost:3000/api/v1/buffets/1/
```
**Example response:**
```
HTTP/1.0 200 OK
Content-Type: application/json
{
  "id": 1,
  "phone_number": "21967276117",
  "zip_code": "21830-390",
  "adress": "Rua Henrique Domingues",
  "neighborhood": "Bangu",
  "city": "Rio de Janeiro",
  "state_code": "RJ",
  "description": "Um buffet feito para você",
  "email": "buffetbangu@gmail.com",
  "buffet_name": "Bangu Buffet",
  "payment_methods": [
    {
      "method": "PIX"
    },
    {
      "method": "Cartão de Crédito"
    },
    {
      "method": "Cartão de Débito"
    },
    {
      "method": "Depósito Bancário"
    }
  ]
}
```
**Attributtes:**
<ul>
  <li><code>phone_number</code> string -- Comercial phone number</li>
  <li><code>zip_code</code> string -- Code from the buffet location area</li>
  <li><code>adress</code> string -- Buffet adress</li>
  <li><code>neighborhood</code> string -- Neighborhood from where the buffet is located</li>
  <li><code>city</code> string -- City from where the buffet is located</li>
  <li><code>state_code</code> string -- 2 letter code representing the State which the buffet is located</li>
  <li><code>state_code</code> string -- 2 letter code representing the State which the buffet is located</li>
  <li><code>description</code> string -- Buffet description</li>
  <li><code>email</code> string -- Buffet email for contacting it</li>
  <li><code>buffet_name</code> string -- Name of the buffet</li>
  <li><code>payment_methods</code> array -- An array of payment methods accepted by the buffet</li>
</ul>

<hr>
Project made during the crash course "Ruby on rails with TDD" - TreinaDev12 class by Campus Code
