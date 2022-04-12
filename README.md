# car_scraper

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)

## General info
Scrape information about food carts in Tokyo and export the data to a CSV file.

## Technologies
Created with:
* Ruby
* [Kimurai](https://github.com/vifreefly/kimuraframework)
	
## Setup
Begin by installing Kimurai:

```
$ gem install kimurai
```

Install this project locally.
In the car_scraper_each.rb file, insert the desired url for each food truck from https://kitchencars-japan.com/k/____.

Then run this project:

```
$ cd ../car_scraper
$ ruby car_scraper_each.rb
```
Open carDataEach.csv to view the parsed data.
