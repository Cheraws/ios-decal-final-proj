import urllib2
wiki = "https://en.wikipedia.org/wiki/Category:Companies_in_the_NASDAQ-100_Index"
page = urllib2.urlopen(wiki)
from bs4 import BeautifulSoup
soup = BeautifulSoup(page)
right_div = soup.find('div', class_ = "mw-category")
all_links = right_div.find_all("a")
f1 = open("company_list", 'w+')
for link in all_links:
    company =  link.get("title")
    f1.write(company)
    f1.write("\n")
