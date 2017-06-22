# README

## Requirements
Ruby version: >= 2.3.1

## External Dependencies
* Twilio
* Giphy

## Setup
* clone the repository
* bundle install
* Copy config/application.yml.sample to config/application.yml
* Replace placeholder values for ENV variables in application.yml
* Public beta key for Gliphy is dc6zaTOxFJmzC

## Database
Do not need to store anything in a database at this point. Skipping for now.

## Running the Server
rails server

## Notes
* Twilio media_url has a size limit of 5MB
* Using fixed width still GIFs from Gliphy
* Using the default limit for Giphy search of 25
* Using URI encoding as requested by the Giphy API

## Analysis
The Gliphy API returns URIs for GIFs that are embedded in the their own GIF. The
actual URI for the GIF can be found by inspecting the embedded image. Replicating
this URI is relatively straightforward using the id provided in the Giphy API response.

Why does this matter?

Twilio can handle a max payload of 5MB for the entire MMS message being sent. Using
the default URIs provided by the Gliphy API are too big for Twilio to handle, even
when using the smallest size returned. The resulting error code from Twilio is 30008
which amounts to a generic error from the carrier partner with no further details.
Here are the two documents, that helped me resolve the error:

https://support.twilio.com/hc/en-us/articles/115005750588-How-to-troubleshoot-messages-that-return-a-30008-Unknown-Error
https://www.twilio.com/docs/api/rest/accepted-mime-types

Since SMS and small random images I found online could be sent and received, the
most likely cause of MMS sending failure was size. Figuring out the actual URI for
GIFs on Gliphy drastically reduced the size of the image payload which, in turn,
reduced the total size of the MMS. As a result, Twilio was able to send an MMS with
the GIF and a message.

## TODO
* Move Twilio into its own service
* Determine GIF size before displaying or dynamically choose appropriate size when sending MMS
* Use jobs to send MMS
* Tests need to be added for controllers, services, and system.
* Add ActiveRecord and choose database to allow for authentication/authorization.
* Use Angular or React to make this a single page app.
