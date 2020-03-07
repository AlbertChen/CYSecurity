# CYSecurity
Data encrypt/decrypt and keychain storage

# RSA Key Pairs Generate
Open Terminal and generate steps as following.
Step 1: openssl
Step 2: genrsa -out rsa_private_key.pem 1024
Step 3: rsa -in rsa_private_key.pem -out rsa_public_key.pem -pubout
Step 4: pkcs8 -topk8 -in rsa_private_key.pem -out pkcs8_rsa_private_key.pem -nocrypt (use this private key on iOS)

