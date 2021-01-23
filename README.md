# PDFer
A PDF converter using Ruby on Rails web application without conversion and storage history.
This app was designed for a sole purpose of maintaining confidentiality of the documents uploaded for conversion.
The app upon conversion automatically clears out the uploaded doc immediately and the converted doc after a specified interval.
Currently as of now it supports singular uploads and multiple at a time batch processing is unavailable as of this initial build.
Supports only for .doc and .docx to PDF and other formats are not currently under consideration

> Note: This is a complete Web application and not a plugin or a gem.


PDFer version: 1.0.0

# Build steps 
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.7

* Rails version 6.0

* System dependencies
  - Libre Office 
  
* Configuration 
  - Set env for soffice commands
  - Active storage (optional)

* Database creation (Not needed / Optional)

* How to run the test suite (Not included , in future RSpec)
 - RSpec

* Services
  - Active Job and no add-ins for job queues as of now

* Deployment instructions
  - TODO

# Usage
This application is under MIT licence. From the owner's perspective this application can be modified and used for any purpose with no restrictions. Just give a e-mail as notif when being used as mentioned just for info.

# Contribute
This repo is open for contribution as it is general purpose with the main objective of privacy maintainence of the documents that are uploaded for conversion.
Use the Discussions for any feature suggestions and raise Pull request for implementation as per general open source methods. 