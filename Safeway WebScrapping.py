#to get this to work, you are going to need to intall bs4

import bs4
from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup

def read_link(url):
    Client = uReq(url)
    page_data = Client.read()
    Client.close()
    page_data_soup = soup(page_data,"html.parser")
    return page_data_soup

def Get_Data_from_item_page(page):
    product_soup = read_link(page)
    product_containers = product_soup.findAll("table", {"class": "tableOfIngredients"})
    if len(product_containers) != 0:
        product_info = product_containers[0]
        # this will get you the number of calories
        print(product_info.find("td", {"class": "table-ingredients-text"}))

    # This will get you all the data for the table, it returns and array
        raw_data = product_info.findAll("td", {"class": "table-ingredients-text"})

    # These are definetly true for the soups, have to check if this table hold for all other food items
        fats = "fats:" + raw_data[4].text
        carbs = "carbs: " + raw_data[24].text
        protien = "protien:" + raw_data[31].text
        return fats, carbs, protien
    else:
        return 0



my_url = 'https://www.safeway.com/shop/aisles/canned-goods-soups/soups-ramen.3132.html?sort=&page=1'
page_soup = read_link(my_url)
containers = page_soup.findAll("a",{"class":"product-title"})
len(containers)
#we can see that there are 33 items per page, so we must continue to increase until we get to 33*n = total items

safeway_link = []
name = []
info = []
for contain in containers:
    new_link = "https://safeway.com" + contain["href"]
    safeway_link.append(new_link)
    data = Get_Data_from_item_page(new_link)
    if data != 0:
        info.append(data)
        name.append(contain.text)
        print(contain.text)
        print(data)



# Test, new data
# a_whole_new_link = 'https://www.safeway.com/shop/aisles.3132.html'
# a_whole_new_soup = read_link(a_whole_new_link)
# a_whole_new_container = a_whole_new_soup.findAll("ul", {"class": "product-subcats"})
#
# for new_contaner in a_whole_new_container:
#     Product_genre = new_contaner.a.text
#     if 'Baby' in new_contaner

