# url-shortener
A simple url shortener app built with rails and react

## Getting started
There are two components to the app. The Rails-API backend and the React frontend. These are seperate projects within the same repo. You will need to start up both of them in seperate terminals. 

Normally I would create the backend and frontend in completely seperate repos, but I kept them together for simplicity since this is not a production app. Keeping them seperate allows you to deploy seperate. Using this approach you can deploy your versioned front-end to a CDN and your backend to a server. It reduces load on your server and speeds up pageloads for your customers. It also allows you to deploy breaking changes without any service interruptions when doing blue/green deployments. It also just simplies development in my opinion. 

### Requirements
- Ruby 2.6.3
- Bundler 1.17.1
- Node 8.11.3
- Yarn or npm

## Start the Rails API
1. Clone the repo `git clone git@github.com:tmatti/url-shortener.git`
2. Switch to the rails project `cd url-shortener-api`
3. Install packages `bundle install`
4. Run tests `rake spec` 
5. Start rails `rails s`

## Start the React Frontend
1. Open a new terminal `cmd-T` if you have mac 
2. Switch to the react project `cd ../url-shortener-frontend`
3. Install packages `yarn install` or `npm install`
4. Start react `yarn start` or `npm start`

## Open the webpage
http://localhost:8080/

You should see the app now. Fill in a link to shorten. Or create a bunch. You have the ability to edit links if you mess one up. That way you can keep using the same slug.

## If I had more time I would have...

- gotten to 100% code coverage on the rails unit tests
- added more integration tests
- added ability to delete urls
- cleaned up the React code (this is my first time using it)
- improved the design
- added a 404 page
- dockerized so you could stand it up with 1 command


