# Wootton Linux Club website 

This site was built with the [Jekyll](https://jekyllrb.com/) theme *[Beautiful Jekyll](https://github.com/daattali/beautiful-jekyll#readme)*. *Beautiful Jekyll* is licensed under the MIT license.

## Set up

Do these steps *once*. 

1. Install `ruby`.
2. Install bundler: `gem install bundler`
3. Install dependencies: `bundle install` (make sure you are in the same directory as `Gemfile`)

## Run a development server

`bundle exec jekyll serve` will start a development server on http://127.0.0.1:4000/twlinux/. Links to the homepage will not work on the local development server (they only work when published to github.io)

The best way to run a local development server is to use the Docker container. I have no idea how to do that though. Reference the [upstream documentation](https://github.com/daattali/beautiful-jekyll#advanced-local-development-using-docker) for more information. 

## Writing blog posts

[Markdown](https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf) is much easier to understand than HTML, however it may lack more advanced features. [daattali/beautiful-jekyll](https://github.com/daattali/beautiful-jekyll/tree/master/_posts) features some other non-traditional widgets that can be used in kramdown. 

Some ["safe" HTML tags](https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/sanitization_filter.rb#L40) are backwards compatable in a Markdown document. 

Blog pages must be named "yyyy-mm-dd-FILENAME.md" (HTML is compatible but not recommended). To use site templates, files that represent web pages must include [YAML front matter](https://github.com/daattali/beautiful-jekyll#last-important-thing-yaml-front-matter-parameters-for-a-page).
