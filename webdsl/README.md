<img style="margin: 0 auto;" src="./images/logo.png" />

A simple Habit Tracker.

## Features

Users can track their habits.

## Development

### Setup

To run, WebDSL itself is sufficient.
To develop, you will need to install at least Node to build the css files (don't forget to `npm install`).

### Running the development server

I have WebDSL installed on Windows, a weird issue where I manually need to kill of an orphaned tomcat server.

The dev process needs the following steps:

1. check if we need to kill of tomcat
2. calculate the new styles
3. run `webdsl run`

The Powershell script `restart.ps1` does all of the above, but your mileage may vary. When in doubt look at what the script is doing. And be prepared to wait for WebDSL.
Since WebDSL tries to be smart and aggressive with the cache, css changes sometimes are only loaded with `restart.ps1 -clean`.
