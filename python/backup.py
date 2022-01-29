import pandas as pd
import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate(r"firebase-admin-key.json")
firebase_admin.initialize_app(cred)

db = firestore.client()
COLLECTION_NAME = 'Transaction'
BACKUP_COLLECTION_NAME = 'Transaction_A'

source = db.collection(COLLECTION_NAME)
for doc in source.stream():
    print("Reading :::", doc.id)
    data = doc.to_dict()
    data['pin'] = False
    db.collection(BACKUP_COLLECTION_NAME).document(doc.id).set(data)
