#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec 12 21:22:22 2020

@author: rashi
"""

import json
from flask import Flask,request,jsonify,Response, render_template, url_for
import base64
import pandas as pd
import csv
import requests

from flask import Flask
app = Flask(__name__)


@app.route('/fertilizers', methods = ["GET"])
def fertilizers():
    with open("Fertilizers.json") as f:
        file = json.load(f)
    
    
    return (file)
@app.route('/pesticides', methods = ["GET"])
def pesticides():
    with open("Pesticides.json") as f:
        file = json.load(f)
    
    
    return (file)

@app.route('/seed', methods = ["GET"])
def seed():
    with open("Seed.json") as f:
        file = json.load(f)
    
    
    return (file)

@app.route('/tools', methods = ["GET"])
def tools():
    with open("Tools.json") as f:
        file = json.load(f)
    
    
    return (file)
@app.route("/sell",methods=["POST"])

def sell():
    data=request.get_json(force=True)
    base64_img=str(data['base64'])
    file_name=data["ID"]
    with open(file_name,'wb') as f:
        f.write(base64.b64decode(base64_img))
    prd_name = data["product_name"]
    description = data["description"]
    qty = data["quantity"]
    amt = data["amount"]
    #print(qty)
    
    
    Prod_Sell = {}
    Prod_Sell["Image_path"] = file_name
    Prod_Sell["Item"] = prd_name
    Prod_Sell["Description"] = description
    Prod_Sell["Quantity"] = qty
    Prod_Sell["Amount"] = amt
    
    output = json.dumps(Prod_Sell)
    with open("Products.json","w") as sout:
        sout.write(output)
    
    with open("Products.json") as read_it: 
         data_in = json.load(read_it) 
    #print(data_in)
          
    field_names = ["Image_path", "Item", "Description", "Quantity", "Amount"]
    with open ("Products.csv", "a+") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames = field_names)
        #writer.writeheader()
        writer.writerow(data_in)
    csvfile.close()
    
    return data_in

@app.route("/rent",methods=["POST"])

def rent():
    data=request.get_json(force=True)
    base64_img=str(data['base64'])
    file_name=data["ID"]
    with open(file_name,'wb') as f:
        f.write(base64.b64decode(base64_img))
    prd_name = data["product_name"]
    description = data["description"]
    qty = data["quantity"]
    amt = data["amount"]
    #print(qty)
    
    
    Prod_Rent = {}
    Prod_Rent["Image_path"] = file_name
    Prod_Rent["Item"] = prd_name
    Prod_Rent["Description"] = description
    Prod_Rent["Quantity"] = qty
    Prod_Rent["Amount"] = amt
    
    outputs = json.dumps(Prod_Rent)
    with open("Products_rent.json","w") as pout:
        pout.write(outputs)
    
    with open("Products_rent.json") as read_its: 
         data_ins = json.load(read_its) 
    #print(data_in)
          
    field_name = ["Image_path", "Item", "Description", "Quantity", "Amount"]
    with open ("Products_rent.csv", "a+") as csv_file:
        writers = csv.DictWriter(csv_file, fieldnames = field_name)
        #writers.writeheader()
        writers.writerow(data_ins)
    csv_file.close()
    
    return data_ins



if __name__ == "__main__":
    app.run(host='0.0.0.0',port=3000)
