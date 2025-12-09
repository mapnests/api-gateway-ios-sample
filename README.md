# API Gateway SDK Integration

## Changelog (v1.0.0)
- Initial integration of the API Gateway SDK.
- 

---

## Onboarding Process
1. Send email to `apigw@technonext.com` to get `bind_client_config.json`. 
2. Place `bind_client_config.json` in the **root directory** of your project.


### 2. Configure Build Settings

1. Drag and drop the `TNApiGetwaySDK.xcframework` into your project’s **Project Navigator** (e.g., into a `Frameworks` group). 
2. Add Kronos 4.4 using Swift Package Manager:  `https://github.com/MobileNativeFoundation/Kronos.git`
2. Select your project in Xcode → **Target** → **General** tab.
3. Scroll down to **Frameworks, Libraries, and Embedded Content**.
4. Click the **+** button → Add `TNApiGetwaySDK.xcframework`.
5. Set **Embed** to **Embed & Sign**.
   
   
   
---

## Project Setup

### Root `add TNApiGetwaySDKConfigFile under your  Info.plist`

```xml

<dict>
    <key>TNApiGetwaySDKConfigFile</key>
    <string>bind-client-config.json</string>
</dict>
```

#Add your URLProtocol class to URLSession

```swift

    let config = URLSessionConfiguration.default
    config.protocolClasses = [ClientNetworkProtocol.self] // Inject framework headers
    return URLSession(configuration: config)
                
```
        
        
#Example
class ClientNetworkProtocol: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(forKey: "ClientHandled", in: request) != nil {
            return false
        }
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {

        guard let modifiedRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else {
            return
        }

        URLProtocol.setProperty(true, forKey: "ClientHandled", in: modifiedRequest)

        modifiedRequest.setValue("global-level-value-1", forHTTPHeaderField: "global-level-header-1")
        modifiedRequest.setValue("global-level-value-2", forHTTPHeaderField: "global-level-header-2")

        let config = URLSessionConfiguration.default
        config.protocolClasses = [
            ClientNetworkProtocol.self,
            FrameworkProtocol.self
        ]

        let session = URLSession(configuration: config)

        let task = session.dataTask(with: modifiedRequest as URLRequest) { data, response, error in

            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }

            if let error = error {
                self.client?.urlProtocol(self, didFailWithError: error)
            }

            self.client?.urlProtocolDidFinishLoading(self)
        }

        task.resume()
    }

    override func stopLoading() {}
}

Check full exmaple under APIURIProtocalDemo.swift



## Request
```json
{
  "method": "GET",
  "url": "http://192.168.61.103:9080/load-test/api/auth-casbin-success-plugin-test",
  "timestamp": "2025-12-07 15:51:32.497",
  "headers": {
    "Client-Header-Name1": "xxxxxx",
    "Client-Header-Name2": "yyyyyy",
    "x-client-identity": "KlD0r8ocjAqEbzeEqiQYeycvIKuKimA6btcfgGqUcDo1DXOBR8M+z6XKwa/uP0ee1H4Di53awaeZrh8vsbd6H0RSTs+By0cmSl6XROCpupDPdPfT78cCchjF+LC7oCFbnztVAPXKhTercr2zcRE7uLQA1Yfmx7xbinYGrFCud0fZbdqYWLp6i9sycXQjvVFpw7G2bz2x2IWNY/SzhWuSU31rnjpZMdI0RLNy/zUu2awj5LBmO0zk0cRYTnhWnZLCmbCiuu0I+Ag6UJm/H9hqJecB59NmTyqWUzRK/tUNnpcQhC2WGneyb9gAa25mfQ1xcYYL7WWk5Xc1ci5nx3/alQ==",
    "x-key-identity": "596119440572023487"
  },
  "request_id": "1765101092497"
}
```

## Response
```json
{
  "status": 200,
  "timestamp": "2025-12-07 15:51:32.673",
  "headers": {
    "Connection": "keep-alive",
    "Content-Type": "application/json",
    "Date": "Sun, 07 Dec 2025 09:51:31 GMT",
    "Server": "APISIX/3.14.1",
    "Transfer-Encoding": "chunked"
  },
  "body": {
    "message": "Auth Casbin plugin test api call succeed"
  },
  "response_id": "177"
}
```

## Developer Notes
- Keep package names consistent between JSON and Gradle.

---

## Support

For issues or feature requests contact us through email: `apigw@technonext.com`

---
