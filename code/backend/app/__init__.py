from fastapi import FastAPI
from mangum import Mangum
from boto3 import Session
from os import environ
from app.routers import api_router
from starlette.middleware.cors import CORSMiddleware

app = FastAPI(redirect_slashes=False)
app.add_middleware(CORSMiddleware, 
  allow_origins=["*"],
  allow_credentials=True, 
  allow_methods=["*"], 
  allow_headers=["*"])
app.include_router(api_router)

handler = Mangum(app)
