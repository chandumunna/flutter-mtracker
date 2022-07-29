import pandas as pd
import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate(r"firebase-admin-key.json")
firebase_admin.initialize_app(cred)

db = firestore.client()
COLLECTION_NAME = 'Transaction_A'
df = pd.DataFrame()

source = db.collection(COLLECTION_NAME)
for doc in source.stream():
    print("Reading :::", doc.id)
    df = df.append(doc.to_dict(), ignore_index=True)

csv_file=r"csv\Transaction.csv"
print("Generating CSV under",csv_file)
df.to_csv(csv_file, index=False)