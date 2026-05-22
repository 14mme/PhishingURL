from fastapi import FastAPI
from pydantic import BaseModel

from pathlib import Path
import pandas as pd
import joblib

from feature_extraction import extract_features

# Load model
BASE_DIR = Path(__file__).resolve().parent
model_path = BASE_DIR / "model" / "Baseline_Model_v2.pkl"
model = joblib.load(model_path)

# FastAPI App
app = FastAPI(
    title='URL Detection API'
)

# Request Body
class URLRequest(BaseModel):
    url: str

# Root Endpoint
@app.get('/')
def home():
    return {
        'message': 'URL Detection API Running'
    }

# Prediction Endpoint
@app.post('/predict')
def predict(data: URLRequest):

    # Extract Features
    features_df = extract_features(data.url)

    # Prediction
    prediction = model.predict(features_df)[0]

    # Probability
    probability = model.predict_proba(features_df)[0].max()

    # Result Label
    result = (
        'Risk'
        if prediction == 1
        else 'Safe'
    )

    return {
        'url': data.url,
        'prediction': result,
        'confidence': round(
            float(probability),
            4
        )
    }