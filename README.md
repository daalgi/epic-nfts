# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```

Opensea url to check our deployed NFTs on the Rinkeby testnet:
https://testnets.opensea.io/assets/CONTRACT_ADDRESS/NFT_ID

Like for instance:
https://testnets.opensea.io/assets/0xa278b1Ccdb76d51B1b631aEC95b068bd78E9cdc9/0

Svg viewer web:
https://www.svgviewer.dev/

Base64 to svg web:
https://base64.guru/converter/decode/image/svg

To host the json and image (svg) on-chain, we can convert the json file into base64 encoded string. The encoded string will have to be within the mint function at `_setTokenURI(newItemId, BASE64_ENCODED_STRING)`, something like:

```_setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiQ29udGVtcG9yYXJ5IGFydCAjMSIsCiAgICAiZGVzY3JpcHRpb24iOiAiQ29tcG9zaXRpb25zIG1hZGUgb2YgY29sb3JmdWwgc2ltcGxlIHNoYXBlcy4iLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajRLSUNBZ0lEeHpkSGxzWlQ0dVltRnpaU0I3SUdacGJHdzZJSGRvYVhSbE95Qm1iMjUwTFdaaGJXbHNlVG9nYzJWeWFXWTdJR1p2Ym5RdGMybDZaVG9nTVRSd2VEc2dmVHd2YzNSNWJHVStDaUFnSUNBOGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaUJtYVd4c1BTSmliR0ZqYXlJZ0x6NEtJQ0FnSUR4MFpYaDBJSGc5SWpVd0pTSWdlVDBpTlRBbElpQmpiR0Z6Y3owaVltRnpaU0lnWkc5dGFXNWhiblF0WW1GelpXeHBibVU5SW0xcFpHUnNaU0lnZEdWNGRDMWhibU5vYjNJOUltMXBaR1JzWlNJK1JIbHVZVzFwWXlCd2NtOW5jbUZ0YldsdVp5RThMM1JsZUhRK0Nqd3ZjM1puUGc9PSIKfQ==");
```

Check this web to perform the conversion:
https://www.utilities-online.info/base64

Example of a json containing the image in svg (base64)
```
{
    "name": "Contemporary art #1",
    "description": "Compositions made of colorful simple shapes.",
    "image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj4KICAgIDxzdHlsZT4uYmFzZSB7IGZpbGw6IHdoaXRlOyBmb250LWZhbWlseTogc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgfTwvc3R5bGU+CiAgICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJibGFjayIgLz4KICAgIDx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBjbGFzcz0iYmFzZSIgZG9taW5hbnQtYmFzZWxpbmU9Im1pZGRsZSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+RHluYW1pYyBwcm9ncmFtbWluZyE8L3RleHQ+Cjwvc3ZnPg=="
}
```

The resulting base64 string (that we can include in our contract definition):
```
{
    "name": "Contemporary art #1",
    "description": "Compositions made of colorful simple shapes.",
    "image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj4KICAgIDxzdHlsZT4uYmFzZSB7IGZpbGw6IHdoaXRlOyBmb250LWZhbWlseTogc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgfTwvc3R5bGU+CiAgICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJibGFjayIgLz4KICAgIDx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBjbGFzcz0iYmFzZSIgZG9taW5hbnQtYmFzZWxpbmU9Im1pZGRsZSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+RHluYW1pYyBwcm9ncmFtbWluZyE8L3RleHQ+Cjwvc3ZnPg=="
}
```

Note that it's much more expensive to host images on-chain (around 5 times more per mint for an extremely simple svg)!