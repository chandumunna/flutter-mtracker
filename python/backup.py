import pandas as pd
import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate(r"firebase-admin-key.json")
firebase_admin.initialize_app(cred)

db = firestore.client()
COLLECTION_NAME = 'Transaction_A'
BACKUP_COLLECTION_NAME = 'Transaction_B'

def indexGenerator(s):
    s = "".join(str(s).lower().split(" "))
    return_ls = []
    return_ls.extend(list(s))
    return_ls.append(s)
    for i in range(0,len(s)):
        if i:
            return_ls.append(s[:i])
    for i in range(0,len(s)):
        if i:
            return_ls.append(s[i:])
    
    return list(set(return_ls))

source = db.collection(COLLECTION_NAME)
for doc in source.stream():
    print("Reading :::", doc.id)
    data = doc.to_dict()
    data["search_index"] = indexGenerator(data["note"])
    db.collection(COLLECTION_NAME).document(doc.id).set(data)
