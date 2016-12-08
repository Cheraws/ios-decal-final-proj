#Career Fair Prep
## Authors
- Robert Chang

##Purpose
To allow preparation for the career fair by looking up companies and keeping track of which ones you want to visit.
## Features
- Create of list of companies you want to visit.
- For each company, list a general description of it(like wikipedia) or grab info from wikipedia.
- Show the jobs that are applicable to it and possible specializations.
- Allow you to add to the main page.

## Control Flow
- Have a search that allows you to add companies to the career fair page, or alternatively add your own company you are interested in.
- Look at the company page and figure out if you want to apply to the company.
- if you do, you can add it to your main page.
- on the day of the career fair, you can click the company while in line to get some last minute notes or make some about it.
- Add notes about the company while on the app like application emails.
## Implementation

### Model 
Scraper.swift
    
### View
- ListView
- ViewCompany
- AddCompany
    
### Controller
ListViewController
ViewCompanyController
AddCompanyController

### Closing thoughts
If I had more time, I would have integrated photo taking within my app, but I was having issues filling everything up within the screen. How it works is when you press the plus button, you enter a company name. Once you have done that, you can touch the company name to receive info about it. With more time, I would have also tried to improve it so that it would look proper on all the devices. An example of the image is shown below.
![alt text](https://github.com/Cheraws/ios-decal-final-proj/demonstration.png  "Logo Title Text 1")

