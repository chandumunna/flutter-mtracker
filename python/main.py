import pandas as pd
from firebase_admin import credentials, firestore, initialize_app

cred = credentials.Certificate(r"firebase-admin-key.json") # please find in bitwarden
initialize_app(cred)

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