#QuoteApp-iOS
This is a [Kinvey](http://www.kinvey.com) iOS Sample app to illustrate how to to show the power of utilizing a mobile application in a business context. The app allows users to browse a catalog of products, request a quote for products/services, place an order, and view previous quotes and orders. The Quoting App streamlines the buying process for your customers, letting them explore and understand your product, then ask for more when they’re ready to purchase. 

![](https://github.com/KinveyApps/QuoteApp-iOS/raw/master/assets/QuoteApp_ss1.png)
![](https://github.com/KinveyApps/QuoteApp-iOS/raw/master/assets/QuoteApp_ss3.png)

In particular this sample application highlights the following key backend tasks:
* Allow users to sign up and log in
* View Product list and Quotes
* Create your own quote
* Make an Order and view previous ones
* Provide offline functionality

## Using the App
1. On login screen fill Login and Password fields and press `Log In`
* New accounts require user name and password of at least 5 characters to create new account press `Register`
2. Go to `New Quote` tab, fill all fields and press `Submit` to create
3. Watch preview of new Quote and press `Submit Order`
4. Go to `Orders` tab and refresh the list by pulling down.
5. Tap a row in the list to see the Order Details

## Using the Kinvey Backend
The following section describes where to look in the code for examples of common backend tasks.

### User management
* `- [CreateAccountViewController createNewAccount:]` goes through the process of adding a new user to the users collection for a Kinvey-powered application. 
* `- [LoginViewContoller login:]` provides an example of using the `KCSUser` class to verify input credentials.
* `- [LoginViewContoller loginWithFacebook:]` provides an example of using the Facebook SDK obtain a Facebook session token an log in to Kinvey with it.


### Data caching and linking
Class `DataHelper` provides data caching and linking management
It contains Stores for Quotes, Orders and Products
Storages are `KCSLinkedAppdataStore` with a cache policy: `KCSCachePolicyNetworkFirst`, this means that at first data will be save on Backend.

### View controllers
View controllers able to use `DataHelper` methods with cached data and data from network
* The `QuoteHomeViewController` uses `DataHelper`'s method `- (void)loadOrdersUseCache:(BOOL)useCache containtSubstinrg:(NSString *)substring OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure;` method and can manipulate how to fetch data with `(BOOL)useCache`

## System Requirements
* iOS 5+
* KinveyKit library 1.27.1

## License

Copyright (c) 2014 Kinvey, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.