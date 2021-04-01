# -*-coding:utf-8-*-
import requests
from urllib.parse import urlparse, parse_qs
from bs4 import BeautifulSoup
# import codecs


def contents_save(file_path, content):
    """
    :param file_path: 爬取文件保存路径
    :param content: 爬取文本文件内容
    :return: None
    """
    with open(file_path, 'a', encoding="utf-8", errors='ignore') as f:
        try:
            f.write(content)
        except:
            pass
        f.write('\n')


def get_html(url_list, file_path, headers):
    for url in url_list:
        req = requests.get(url, headers=headers)
        content = req.content.decode('utf-8', 'ignore')
        bf = BeautifulSoup(content, fromEncoding="gb18030")
        del_text = bf.find_all(
            class_=["this_jammer", "hidejammersa", "jammerd42"])
        # print(del_text)
        for i in del_text:
            if i:
                new_tag = ""
                try:
                    i.string.replace_with(new_tag)
                except:
                    pass
        texts = bf.find_all('div', class_='answer_detail')
        # print(texts)
        try:
            texts = texts[0].text.replace('\xa0', '')
            texts = texts.replace(" ", "")
        except:
            pass
        try:
            texts = texts.replace("\n", '')
        except:
            pass
        print(texts)
        contents_save(file_path, texts)


def get_url(target_url, server, headers):
    req = requests.get(target_url, headers=headers)
    # 查看网页的编码格式
    # enconding = requests.utils.get_encodings_from_content(req.text)
    # print(enconding) //utf-8
    bf = BeautifulSoup(req.text)
    div = bf.find_all('div', class_='questions_col')
    # print(div[0])
    a_bf = BeautifulSoup(str(div[0]))
    a = a_bf.find_all('a')
    cheak_parsing_url = []
    for each in a:
        if each.string == "查看解析":
            full_url = server + each.get('href')
            cheak_parsing_url.append(full_url)
    print(cheak_parsing_url)
    return cheak_parsing_url


def change_page(target_url, server, headers):
    req = requests.get(target_url, headers=headers)
    bf = BeautifulSoup(req.text)
    div = bf.find_all('div', class_='fenye')
    a_bf = BeautifulSoup(str(div[0]))
    a = a_bf.find_all('a')
    full_url = None
    for each in a:
        if each.string == "下一页":
            full_url = server + each.get('href')
            print(full_url)
        else:
            continue
    return full_url


def get_category(target_url, server, headers):
    req = requests.get(target_url, headers=headers)
    bf = BeautifulSoup(req.text)
    div = bf.find_all('div', class_='shiti_catagory frame')
    a_bf = BeautifulSoup(str(div[0]))
    a = a_bf.find_all('a')
    category = []
    for each in a:
        full_url = server + each.get('href')
        qs = parse_qs(urlparse(full_url).query)
        cid = qs.get('cid')
        if cid and int(cid[0]) >= 1378:
            category.append(full_url)
    print(category)
    return category


if __name__ == "__main__":
    main_url = "https://tiku.21cnjy.com/tiku.php?mod=quest&channel=3&cid=1378&xd=3"
    server = "https://tiku.21cnjy.com/"
    save_dir = "./data"
    subject_file = "senior_Math"
    file_path = save_dir + '/' + subject_file
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36',
        'Accept-Encoding': 'gzip'}
    categorys = get_category(main_url, server, headers)
    for category_url in categorys:
        counting = 0
        target_url = category_url
        cid = parse_qs(urlparse(category_url).query)["cid"]

        while counting < 100 and cid:
            cheak_parsing_url = get_url(target_url, server, headers)
            if int(cid[0]) >= 1378:
                get_html(cheak_parsing_url, file_path+cid[0], headers)
            target_url = change_page(target_url, server, headers)

            if target_url == None:
                break
            counting += 1
