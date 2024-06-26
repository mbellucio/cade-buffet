
# Cadê Buffet: Catering Web Application

A buffet system application project using Ruby on Rails.

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-this-project">About this project</a></li>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#external-gems-used">External Gems used</a></li>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#dummy-data">Dummy data</a></li>
    <li><a href="#testing">Testing</a></li>
    <li><a href="#system-description-and-functions">System functions and description</a></li>
    <li><a href="#cade-buffet-api">Cadê Buffet API</a></li>
  </ol>
</details>

## About this project
### TreinaDev12 by Campus Code
[Treina Dev](https://treinadev.com.br/) is a tuition free selection process hosted by [Campus Code](https://www.campuscode.com.br/) 
to find new talents and prepare them for the Ruby on Rails development market.
### Project tasks
The life cycle of this project is the incremental type one. Based on Scrum principles, each week a new sprint
is generated on their platform with the tasks to implement new functionalities into the project
### Test Driven Development
All functionalities of this application were made using TDD principles, therefore all the application is propperly covered by tests. 
Any atempt to alter or add anything to this project is secure by those tests, guaranteeing a safe application scalability.

## Built With
![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-A10E3B?style=for-the-badge&amp;logo=rubyonrails&amp;logoColor=white)
![html](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![css](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)

## External Gems used
<ul>
  <li><a href="https://github.com/heartcombo/devise">Devise</a> - Authentication</li>
  <li><a href="https://github.com/fnando/cpf_cnpj">cpf_cnpj</a> - Brazilian ID validation</li>
  <li><a href="https://github.com/rspec/rspec-rails">rspec-rails</a> - testing</li>
  <li><a href="https://teamcapybara.github.io/capybara/">Capybara</a> - system testing</li>
  <li><a href="https://github.com/simplecov-ruby/simplecov">simplecov</a> - test analytics</li>
</ul>

## Installation
### Local Setup
1. Install Ruby ***3.2.3***.
2. Clone this repository
3. Once inside the project folder run ```bundle install```
4. Run ```rails db:migrate```
5. Run ```rails db:seed``` to create vital models for application.
6. Run ```rails s``` to start server.
7. Go to ```localhost:3000``` to access Cadê Buffet Application

## Testing
To run all the tests use this command on the prompt: ```rspec```<br/>
The test files are located at: <code>./spec</code> <br/>
There are 3 types of tests covering this project: 
<ul>
  <li>System tests - located at <code>./spec/system</code></li>
  <li>Model tests - located at <code>./spec/model</code></li>
  <li>Request tests - located at <code>./spec/request</code></li>
</ul>

## Dummy data
For testing and viewing the UI some dummy data was inserted into the 
**db/seeds.rb** file.
Only the <code>Jaquin Buffet</code> has events, orders and chat messages to visualize.
here are the credentials to log into Jaquin Buffet as a Company User: 
<ul>
  <li>Email: jaquin@gmail.com</li>
  <li>Password: safestpasswordever</li>
</ul>

here are the credentials to log as Client User:
<ul>
  <li>Email: matheus@gmail.com.com</li>
  <li>Password: safestpasswordever</li>
</ul>

## System Description and Functions
There are two roles in the system: **Company** and **Client**.<br/><br/>
Company can:<br/>
<ol>
    <li>Create, Edit Buffet</li>
    <li>Create, Edit, Delete Events</li>
    <li>Create, Edit, Delete Event Pricings</li>
    <li>Accept orders issued by clients countering with a budget offer</li>
    <li>Cancel orders</li>
    <li>Activate/Deactivate Buffet and it's events</li>
</ol>

Clients can:<br/>
<ol>
    <li>Search Buffets by name, city or event</li>
    <li>Check Buffet details</li>
    <li>Check events details</li>
    <li>Create event orders</li>
    <li>Accept budget offer for order</li>
    <li>Cancel order on pending and awaiting status</li>
    <li>Rate buffets</li>
</ol>

<hr>

## Cade Buffet API 

### Introduction
Welcome to the Cadê Buffet API!. This documentation will guide you throught our API and its available resources and how to consume them with HTTP requests.

### Authentication
Cadê Buffet is a completely open API. No authentication is required to query and get data.

## Resources
### BUFFETS
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

### EVENTS
Events are a specific catering service for a specific type of event.

**Endpoints**
<ul>
  <li><code>/api/v1/buffets/:buffet_id/events/</code> -- get all the events resources from a specif buffet</li>
  <li>
    <code>/api/v1/events/:id/</code> -- get a response on weather a certain type of event is available for a certain date and guest number 
    <ul>
      <li>those are mandatory params for this resource: <code> params: {booking_date: date, guest_number: guest_number}</code></li>
    </ul>
  </li>
</ul>

**Example request:**
```
http http://localhost:3000/api/v1/events/1?booking_date=2024-05-10&guest_number=20
```
**Example response:**
```
HTTP/1.0 200 OK
Content-Type: application/json
{
  "event_id": 1,
  "event": "Churrasco",
  "estimated_price": 2000
}
```
**Attributtes:**
<ul>
  <li><code>event</code> string -- the type of event</li>
  <li><code>estimated_price</code> string -- Price prediction on the event based on date and guest number</li>
</ul>

<hr>
Project made during the crash course "Ruby on rails with TDD" - TreinaDev12 class by Campus Code
