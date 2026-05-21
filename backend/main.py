from fastapi import FastAPI
from pydantic import BaseModel

import pandas as pd
import joblib

from feature_extraction import extract_features

# Load model
model = joblib.load(
    'model/Baseline_Model_v2.pkl'
)

# FastAPI App
app = FastAPI(
    title='Phishing URL Detection API'
)

# Request Body
class URLRequest(BaseModel):
    url: str

# Root Endpoint
@app.get('/')
def home():
    return {
        'message': 'Phishing URL Detection API Running'
    }

# Prediction Endpoint
@app.post('/predict')
def predict(data: URLRequest):

    # Extract Features
    features = extract_features(data.url)

    features_df = pd.DataFrame([features])

    # Prediction
    prediction = model.predict(features_df)[0]

    # Probability
    probability = model.predict_proba(
        features_df
    )[0].max()

    # Result Label
    result = (
        'Phishing'
        if prediction == 1
        else 'Legitimate'
    )

    return {
        'url': data.url,
        'prediction': result,
        'confidence': round(
            float(probability),
            4
        )
    }