#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec 12 21:22:22 2020

@author: rashi
"""

import json
from flask import Flask,request,jsonify,Response, render_template, url_for
import base64
import numpy as np
import imageio
from matplotlib.pyplot import imshow
from keras.preprocessing import image
from types import SimpleNamespace 
import pandas as pd
import joblib
import requests

from flask import Flask
app = Flask(__name__)


@app.route('/fertilizers', methods = ["GET"])
def fertilizers():
    #data = request.get_json(force = "true")
    with open(r"/home/shivam/FTX-Razorpay_APP/Fertilizers.json") as f:
        file = json.load(f)
    
    
    return (file)
@app.route('/pesticides', methods = ["GET"])
def pesticides():
    #data = request.get_json(force = "true")
    with open(r"/home/shivam/FTX-Razorpay_APP/Pesticides.json") as f:
        file = json.load(f)
    
    
    return (file)

@app.route('/seed', methods = ["GET"])
def seed():
    #data = request.get_json(force = "true")
    with open(r"/home/shivam/FTX-Razorpay_APP/Seed.json") as f:
        file = json.load(f)
    
    
    return (file)

@app.route('/tools', methods = ["GET"])
def tools():
    #data = request.get_json(force = "true")
    with open(r"/home/shivam/FTX-Razorpay_APP/Tools.json") as f:
        file = json.load(f)
    
    
    return (file)



if __name__ == "__main__":
    app.run()