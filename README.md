collecting and displaying historical WSDOT ferry data

_built for Ruby 3.0.0 on Windows + WSL2_

# Running
```bash
$ mkdir data
$ bundle install
$ ruby scraper.rb
```

# TODO
* write text data via cron
* persist in a database
* scrape "waiting in line" data too (https://wsdot.com/ferries/vesselwatch/terminaldetail.aspx?terminalid=12)
* stick this on a server somewhere and run on an interval
* visualize the data
