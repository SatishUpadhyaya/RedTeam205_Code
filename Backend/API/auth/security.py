import hashlib
def sha256(inputtedstr):
    return hashlib.sha256(bytes(inputtedstr.encode('utf-8'))).hexdigest()