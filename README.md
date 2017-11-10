# Achievements
This is a small app with basic UI to show few details such as groups, categories and achievements of GuildWars2. This app uses the version 2 of the [GuildWars2 API](https://wiki.guildwars2.com/wiki/API:2).

# API details

### Groups

For fetching the details of groups, we use the `/v2/achievements/groups` as endpoint. Each group will have a collection of categories associated with it.

API Doc Link: https://wiki.guildwars2.com/wiki/API:2/achievements/groups

### Categories

For fetching the details of categories, we use the `(/v2/achievements/categories` as endpoint. Each category will have a collection of achievements associated with it.

API Doc Link: https://wiki.guildwars2.com/wiki/API:2/achievements/categories

### Achievements

For fetching the details of categories, we use the `/v2/achievements` as endpoint.

API Doc Link: https://wiki.guildwars2.com/wiki/API:2/achievements

# Frameworks Used:

### Alamofire

We are using [Alamofire](https://github.com/Alamofire/Alamofire), for the web services. Alamofire is built upon the Apple provided native URLSession for Swift, thus making the usage and coding much easier and simpler. It also provides various in-depth usage for each network operations if needed by the user such as easier way to manage parameter encoding, network reachability monitoring etc. It has great community support for any help, if needed as in StackOverflow, creator's documentations etc.

### SwiftyJSON

We are using the [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) framework to help us with easy handling of the JSON response from the network calls. This is a wrapper built upon the JSONSerialisation in the Foundation provided by Apple. SwiftyJSON gives easy methods for the user to handle JSON data and it's conversion to any Foundation objects. The code will be cleaner and simpler for anyone to understand.

### SDWebImage

We are using [SDWebImage](https://github.com/rs/SDWebImage) for the image caching purpose. Images may take a very long time to download from any url in few network conditions. So, it would be very convenient to store these images as in cache these so we don't have to download them every time we require them. So, this improves the performance and removes the blocking of main thread for image download. But for this app though, we are using the provided image downloader support but not the caching.

### MBProgressHUD

We use [MBProgressHUD](https://github.com/jdg/MBProgressHUD/), when we need to show that a network action is happening and the view and it's contents are dependent on the response of this network task. So, MBProgressHUD provides a HUD view that can be put on any view, to inform the user about the network task rather than simply blocking the main thread. This also provides the developers with ability to show any information in a label below the HUD view, so the users will know what is happening. This is one among various ways to handle the UI when any background task related to main thread blocking/networking task is taking place.   
