== README

# Slate viewer, but as a server instead!

I wanted to make a rails app, and I needed a way to display an API, so took the [lord/slate](https://github.com/lord/slate) code and turned it into a completely standalone rails app. Based on the idea of simplicity, I worked to make the app as easy to set up as possible so that anyone can clone the repro and get to work.

# Basic Set up

  Set up of Slate Server is as easy as slicing butter with a hot knife. In just 5 steps you can have your very own server hosting your API documentation.

  1. Clone the git repository! 
    `git clone https://github.com/e1337kat/slate_server.git`

  2. Add your markdown files into `/templates/` You need at least one markdown file in the root templates folder, but you can also have sub folders for larger documentation. More info can be found in the Multiple Page Support section.

  3. Add (or modify) the `data.yml` file in `/config/` to set up the configuration options and more. Configuration options can be found in the Configuration section below.

  4. Decide whether you want to run the server as a docker container or just straight up. Docker is cool!

  5. Set up your rack configuration and run the rails app! That's it, you're done. You now have a beautiful API documentation server that will never let you down!

# Configuration

  A number of configuration options exist for slate server. Most options are inherited from the original [Slate project](https://github.com/lord/slate). I have added a few that enable new features or make more sense of current resources. To save space, I will only expand on new features.

  * `forward_includes`: This is a list of filenames for include files that you want to have included on the front end of everypage. Usage is simple by simply adding the partial markdown files in the `/templates/forward_includes/` folder then using the configuration option like so:
    ```yml
    forward_includes:
      - errors
      - authorization
      - api_notes
    ```
  * `end_includes`: This operates much the same as `forward_includes`, but (as you guessed) adds the include files onto the *end* of the viewed page. Make sure files are added to the `/templates/end_includes/` folder to be used. For both of these configuration options, you can have more files in the templates files than are used by the application. This is by design for future development.
  * `resources`: This is a new list that one can use to specify the API resources and their simplified url for multiple paged support. For a single paged application, one can simply leave this option off and not worry about it. It is necessary for proper multipaged documentation, however.

# Multiple Pages

  The goal of this project is to utilize the beautiful slate documentation builder with multiple pages and as a standalone application. I saw three areas that needed coverage for multi-page support. I needed a way to specify how the sub folders should work. I needed a separate data.yml file that could store links to the pages and headers that I wanted shown. Finally, I needed to modify the layout file to support the new data file and to handle the new way of linking. It turns out I was wrong, and that I needed to modify a lot more. Modifications were needed for the Javascript to support multiple pages, the toc_data file to support multiple page (I actually ended creating a separate file and keeping the original), and of course to the structure of the application. 
  
  Utilizing multiple pages is not as easy as making a standalone application, but it isn't terribly difficult either. To start off, we need to make some modifications to the `/config/data.yml` file:
  
  * We will add the `resources` section to the file like so:
  ```yml
  resources:
    - Kittens:'kittens'
    - Puppers:'puppers'
  ```
    Here, we specify the name of the resource as we want it to appear on the table of contents. Then there is a colon ':' followed by the normalized name of the resource. The normalized name should be downcased and any special charaters replaced with an underscore '_'.
  
  * Next, a section will be added for each resource where the section name is the normalized resource name:
  ```yml
  kittens:
    - Get All Kittens:'get-all-kittens'
    - Get a specific kitten:'get-a-specific-kitten'
    - Delete a specific kitten:'delete-a-specific-kitten'

  puppers:
    - Get All Puppers:'get-all-puppers'
    - Get a specific pupper:'get-a-specific-pupper'
    - Delete a specific pupper:'delete-a-specific-pupper'
  ```
    Each of the resources sections specify the requests that are available for each resource. The first part of each request is the request as you want it to appear to the API documentation user. The second part is the normalized title where it is downcased and special charaters replaced with an underscore. Normalization can also use dashes '-' instead of an underscore. 

  * Finally, we add the markdown templates into the `/templates/` folder. 
  ** There should be one `index.html.md` file in the templates root that acts as an index file. This index file can look any way you want it to look, but I suggest it list all of the resources in the API and any comments or notes you want to add about the resource. 
  ** The sub-pages should be titled `index.hmtl.md` and placed in folders that are named for their normailzed resource. 
  ** Every resource specified in the `/config/data.yml` file needs to have a folder and file to draw from, otherwise weird stuff can happen :) The folder structure might look something like this:
    ```
    templates/
    ├── forward_includes
    │   └── errors.md
    ├── end_includes
    │   └── example_end_include_1.md
    ├── kittens
    │   └── index.html.md
    └── puppers
        └── index.html.md
    ```
    