#to get this to work, you are going to need to intall bs4 and requests

import bs4
from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup

filename = "products.csv"
f = open(filename, "w")

handlers = "item, calories,fats, carbs, protein\n"

f.write(handlers)

def read_link(url):
    Client = uReq(url)
    page_data = Client.read()
    Client.close()
    page_data_soup = soup(page_data,"html.parser")
    return page_data_soup

def Get_Data_from_item_page(page):
    product_soup = read_link(page)
    product_containers = product_soup.findAll("table", {"class": "tableOfIngredients"})
    product_name_containers = product_soup.find("div", {"class": "product-heading"})
    product_name = product_name_containers.h2.text
    print(product_name)
    if len(product_containers) != 0:
        product_info = product_containers[0]
        # this will get you the number of calories
        calories =product_info.find("td", {"class": "table-ingredients-text"}).text
    # This will get you all the data for the table, it returns and array
        raw_data = product_info.findAll("td", {"class": "table-ingredients-text"})

    # Explain what this does and my process for the index
        fats = raw_data[4].text
        if 'Dietary Fiber' in raw_data[24].text:
            carbs = raw_data[25].text
        else:
            carbs = raw_data[24].text
        if raw_data[30] == '':
            protien = "0g"
        else:
            protien = raw_data[30].text


        f.write(product_name + "," + CalorieFormat(calories) + "," + FormatInfo(fats) + "," + FormatInfo(carbs) + "," + FormatInfo(protien) + "\n")
        return product_name, calories, fats, carbs, protien
    else:
        return 0

def FormatInfo(macro):
    macro = macro.replace("Amount Per serving", "")
    return macro

def CalorieFormat(calorie):
    new_format = calorie.replace("Amount Per Serving\n", "")
    new_new_format = new_format.replace(' ', '')
    return new_new_format

def GetSafewayLink(parital_url_container):
    try:
        internal_link = parital_url_container['href']
        return "https://safeway.com" + internal_link
    except ValueError:
        print('Invalid container, it does not have a link, does not have attribute href')

def GetItemsFromPage(url):
    my_url = 'https://www.safeway.com/shop/aisles/canned-goods-soups/soups-ramen.3132.html?sort=&page=1'
    page_soup = read_link(url)
    containers = page_soup.findAll("a", {"class": "product-title"})
    len(containers)
    # we can see that there are 33 items per page, so we must continue to increase until we get to 33*n = total items

    safeway_link = []
    name = []
    info = []
    for contain in containers:
        new_link = GetSafewayLink(contain)
        safeway_link.append(new_link)
        data = Get_Data_from_item_page(new_link)
        if data != 0:
            info.append(data)
            name.append(contain.text)


#Test, new data
a_whole_new_link = 'https://www.safeway.com/shop/aisles.3132.html'
a_whole_new_soup = read_link(a_whole_new_link)
a_whole_new_container = a_whole_new_soup.findAll("ul", {"class": "product-subcats"})
Product_blacklist = ['Baby', 'Coffee', 'Deli', 'Flowers','Fruits & Vegetables', 'Eggs' ,'Meat & Seafood', 'Beef', 'Laundry', 'Care', 'Pet', 'Wine', 'Beer']

for new_container in a_whole_new_container:
    if new_container.a is not None:
        Product_genre = new_container.a.text
        test = any([Product_blacklist_item in Product_genre for Product_blacklist_item in Product_blacklist])
        if not test:
            print(Product_genre)
            link = GetSafewayLink(new_container.a)
            print(link)
            GetItemsFromPage(link)
