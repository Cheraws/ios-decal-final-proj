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
- Create a careerFair event.
- Have a search that allows you to add companies to the career fair page, or alternatively add your own company you are itnerested in.
- Look at the company page and figure out if you want to apply to the company.
- if you do, you can add it to your main page.
- on the day of the career fair, you can click the company while in line to get some last minute notes about it.
- Add notes about the company while on the app like application emails.
## Implementation

### Model 
-WebsiteScraper.swift
    
### View
- HomeView
- CompanyView
- CareerFairView
    
### Controller
- HomeViewController
- CareerFairViewController
- CompanyViewController
