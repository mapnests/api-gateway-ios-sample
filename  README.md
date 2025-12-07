# TNApiGetwaySDK.xcframework SDK Documentation (v1.0.0)

## API Registration & Authentication

### Step 1: Register for API Access

**Endpoint:** `https://console.mapnests.com/sign-up`

- Create an account and register for API access.

### Step 2: Login to Dashboard

**Endpoint:** `https://console.mapnests.com/sign-in`

- Use your credentials to log in and manage your projects.

## Project Setup

### Step 1: Create a Project

1. Log in to the TNMaps Dashboard.
2. Navigate to the dashboard.
3. Go to the **Projects** section.
4. Click on **"Create Project"**.
5. Provide a **Project Name** and **Project Description**.
6. After project creation, go to the **details section**.
7. In the **Android Section**, add your **Package Name** and **SHA256 fingerprint**.
8. Once successfully created, you will receive an **API Key**.


### Step 2: Add Dependencies

1. Copy the `TNMapSDK.xcframework` to your Xcode project directory.

2. In Xcode, drag and drop the `TNMapSDK.xcframework` into the "Frameworks" section of your Xcode project.
                            
## Step 3: Embed & Sign the Framework
1. In your Xcode project, select your target and navigate to the **General** tab.

2. Under **Frameworks, Libraries, and Embedded Content**, click the "+" button.

3. Choose `TNMapSDK.xcframework` from the list, and set the embedding option to **Embed & Sign**.


### Step 4: Configure Your Project

Replace placeholders with your actual **Package Name** and **API Key**:
Modify your project to include the API key and package name.

 **Example (inside DemoDistanceMatrixAPIContentView, DemoDistanceMatrixDetailsAPIContentView, DemoGeocodeContentView, DemoReverseGeocodeContentView.swift):**

```swift
  let apiKey = ""
  let packageName = ""
```

## Example Usage of TNMaps SDK



## Notes & Best Practices

- Ensure **API Key** is correctly configured in `DistanceMatrixActivity`.
- Use a **valid Package Name** & **SHA256 Fingerprint** in the TNMaps dashboard.
- Test with different locations to verify SDK responses.
- Log errors for debugging SDK failures.

## Support

For any issues or support, contact the **TNMaps team** or refer to the official documentation.
