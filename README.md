# README

Final project for Cloud application development, I have implemented a cloud-based trading platform using Ruby on Rails. The web application follows Software as a Service (SaaS) model, and it is deployed into a Platform as a Service (PaaS) provider using Continuous Integration/Continuous Delivery (CI/CD).

## Use cases

### Administrator
* Create/update administrators
* Create/update portfolio managers
* Create/update portfolio managers’ traders
* Update administrator’s profile
* Upload profile’s photo
* Sign-in and redirect to administrator’s main page
* Sign-out

### Portfolio manager
* Create/update traders
* Assign budget to traders
* Update profile
* Upload profile’s photo
* Sign-in and redirect to portfolio manager’s main page
* Sign-out

### Trader
* Search stock symbols
* Follow/unfollow stock symbol
* Visualize stock symbol information: Sector, industry, Dividend yield, P/E ratio etc.
* Visualize chart of intra-day prices and transactions volume
* Update profile
* Upload profile’s photo
* Sign-in and redirect to trader’s main page
* Sign-out

## Environment variables
This is the list of environment variables from .env file:
* STOCK_PRICES_API_URL=https://stock-prices2.p.rapidapi.com/api/v1/resources/stock-prices/1d?ticker=
* STOCK_PRICES_API_KEY=
* STOCK_PRICES_API_HOST=
* STOCK_INFO_API_URL=https://yahoo-finance97.p.rapidapi.com/stock-info
* STOCK_INFO_API_KEY=
* STOCK_INFO_API_HOST=
* INTRADAY_STOCK_PRICES_API_URL=https://apistocks.p.rapidapi.com/intraday?symbol=
* INTRADAY_STOCK_PRICES_API_KEY=
* INTRADAY_STOCK_PRICES_API_HOST=
* DATABASE_USERNAME=
* DATABASE_PASSWORD= 
* USER_PASSWORD= 
* FAKE_SERVICES=true
