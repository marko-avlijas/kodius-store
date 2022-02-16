# README

## Task

The goal of the exercise is to create a checkout system that fulfills the criteria listed below :
1. Items can be added to a basket
2. Items can be removed from a basket
3. Promotions can be applied to a basket
4. Promotions can be removed from a basket
5. Basket can be checked out - a total price is calculated
6. Customer’s Email, Address and Credit card details are required to check out
7. Customers will have an Order after checking out which contains all the basket items

### Items :

| Name               |  Price (EUR) |
|--------------------|--------------|
| Smart Hub          |  49.99       |
| Motion Sensor      |  24.99       |
| Wireless Camera    |  99.99       |
| Smoke Sensor       |  19.99       |
| Water Leak Sensor  |  14.99       |

### Promotions:

#### Codes:

| Name     |  Effect               | Note                    |
|----------|-----------------------|-------------------------|
| 20%OFF   | 20% off final cost    | cannot be used in conjunction with other codes |
| 5%OFF    | 5% off final cost     | can be used in conjunction with other codes |
| 20EUROFF | 20 EUR off final cost | can be used in conjunction with other codes |

#### Quantity:

3 Motion sensors for 65.00 EUR  
2 Smoke Sensors for 35.00 EUR

### Deliverables:
* Create a database that can support the criteria
* Create pages to accommodate functionality
* Validation of intended functionality

### Notes:
* Speed of delivery is important


## Installation

```
git clone https://github.com/marko-avlijas/kodius-store.git
cd kodius-store
bin/setup
```

## Start dev server, css & javascript compilation

```
bin/dev
```

## Run tests

```
rspec
```
