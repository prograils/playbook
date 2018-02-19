---
layout: page
title: Development
---

Here you can find a basic set of rules and common practices used for Rails development in Prograils. If you’d like to add something, feel free to contribute (with pull request).



### GIT ###
1. Always use GIT. Always.
2. Use [Git flow](http://nvie.com/posts/a-successful-git-branching-model/){:target="_blank"}. If by any means you refuse to use Git flow, use feature branches. Each feature branch should be created from **develop** branch. Features should be merged into **develop**, then into **master**.
3. Use pull requests when possible. It's always better to have your code checked and accepted by someone else. Also, by doing so you're not the only one responsible for your feature :)
4. Commit early, commit often.
5. **Never** commit directly to the **master** branch. Never.
6. Code in master branch should be always stable and ready for deployment.
7. Avoid committing directly to the **develop** branch unless your change is a hotfix, in which case it's by all means allowed.
8. Merge using `git merge --no-ff`
9. Know difference between `git pull` and `git pull --rebase` with awerness of the differences between them: [link 1](http://www.derekgourlay.com/archives/428){:target="_blank"}, [link 2](http://geekblog.oneandoneis2.org/index.php/2013/04/30/please-stay-away-from-rebase){:target="_blank"}, [link 3](http://jrb.tumblr.com/post/49248876242/git-pull-rebase-until-it-hurts){:target="_blank"}, [link 4](https://coderwall.com/p/7aymfa){:target="_blank"}

### Git Workflow ###

Information: All commands assume tracking remote branch is enabled for **master, develop, production**, and **staging**.

When you checkout a branch whose name exists in remote repo tracking automatically set:

	$ git branch -r
	  origin/HEAD -> origin/master
	  origin/master
	  origin/newbranch
	$ git checkout newbranch
	Branch newbranch set up to track remote branch newbranch from origin.
	Switched to a new branch 'newbranch'

When you created new branch you need to add **-u** parameter to **git push**:

	$ git checkout -b newbranch2
	Switched to a new branch 'newbranch2'
	$ git push -u origin newbranch2
	Total 0 (delta 0), reused 0 (delta 0)
	To [path]
	 * [new branch]      newbranch2 -> newbranch2
	Branch newbranch2 set up to track remote branch newbranch2 from origin.

git help (`git help pull`, `git help branch`), and internet resources ([http://gitready.com](http://gitready.com){:target="_blank"}, [http://git-scm.com/book](http://git-scm.com/book){:target="_blank"}) are your friends.

---

### Workflow ([Git flow](http://nvie.com/posts/a-successful-git-branching-model/){:target="_blank"}): ###

#### Requirements

You have cloned the repository with master, develop, production and staging branches

#### Create a feature

1. pull the develop branch (`git checkout develop`, `git pull`)
2. create a feature branch from develop branch (`git checkout -b feature/A develop`)
3. do the coding, commit your changes
4. (optional) It is a good time to squash your commits using git rebase [http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html](http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html){:target="_blank"} - do this ONLY on commits that haven’t been pushed to remote repository
5. (optional) You can place your commits on top of current develop branch using git rebase (`git checkout develop`, `git pull`, `git checkout feature/A`, `git rebase develop`) - do this ONLY when you didn't push this branch to remote repository

#### After a feature is completed: ####

1. You need to do one of two:
  a) If code review is needed push your feature branch to repository and create a pull request (into develop branch)
  b) Otherwise just merge the feature branch to develop and push develop to repository (`git checkout develop`, `git merge --no-ff feature/A`, `git push`)
2. merge develop to staging and push the staging branch (`git checkout staging`, `git pull`, `git merge develop`, `git push`)
3. deploy to staging environment (`cap staging deploy` or something)

#### When all features for upcoming release are accepted in the internal review system: ####

1. create a release branch of the develop branch (`git checkout -b release/v2012-04-14-10-12-ml develop`, `git push -u origin release/v2012-04-14-10-12-ml`)
2. perform any final work in the release branch (minor bug fixes and preparing meta-data for a release) - adding new features at this stage is strictly prohibited
3. merge the release branch into the master branch and then merge the master branch into the production branch. Remove the release branch (`git checkout master`, `git merge release/v2012-04014-10-12-ml`, `git push`, `git checkout production`, `git merge master`, `git push`, `git branch -d release/v2012-04-14-10-12-ml && git push origin :release/v2012-04-14-10-12-ml`)
4. deploy to the production environment (e.g. `cap production deploy`)

### Bugfixes: ###

  Bugfixes can be done by branching a bugfix branch off master, which is then merged back into master an developed when done.

### Code style: ###
1. Use [Overcommit](https://github.com/brigade/overcommit){:target="_blank"} to help you follow code style guides. Example: [config file](https://bitbucket.org/prograils/dotfiles/src/master/overcommit.yml){:target="_blank"}. See also [rubocop config file](https://bitbucket.org/prograils/dotfiles/src/master/rubocop.yml){:target="_blank"} and [haml lint config file](https://bitbucket.org/prograils/dotfiles/src/master/haml-lint.yml){:target="_blank"}

### GIT commit messages: ###
1. Separate subject from body with a blank line
2. Limit the subject line to 50 characters
3. Capitalize the subject line
4. Do not end the subject line with a period
5. Use the imperative mood in the subject line (e.g. add, create, modify, perform, fix)
6. Wrap the body at 72 characters
7. Use the body to explain what and why vs. how
8. Read [http://chris.beams.io/posts/git-commit/](http://chris.beams.io/posts/git-commit/){:target="_blank"}, [https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message](https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message){:target="_blank"}

### Ruby: ###
1. We're using latest Ruby 2.x release (2.5.0 at the moment of writing this text)
2. On development machines rbenv is preffered
3. On servers rbenv is used with newest 2.x release
4. Apply coding style rules decreibed [here](https://github.com/styleguide/ruby){:target="_blank"}
5. Use Ruby >=1.9 hash syntaxt: `{ a: 1, b: 2 }`, *not* `{:a=>1, :b=>2}`
6. Use Safe Navigation Operator (`&`), avoid using `try()`

### JS/CoffeeScript: ###
1. Write new JS in CoffeeScript
2. Use soft-tabs with a two space indent
3. Always use camelCase, never underscores
4. Don't ever use $.get or $.post. Instead use $.ajax and provide both a success handler and an error handler
5. Use $.fn.on instead of $.fn.bind, $.fn.delegate and $.fn.live
6. Try to prefix all javascript-based selectors with js- or use data- attribute. More reading: [https://coderwall.com/p/qktuzw](https://coderwall.com/p/qktuzw){:target="_blank"}, [https://roy.io/dont-use-class-names-to-find-html-elements-with-js/](https://roy.io/dont-use-class-names-to-find-html-elements-with-js/){:target="_blank"}

### CSS: ###
1. Use soft-tabs with a two space indent
2. Put spaces after : in property declarations
3. Put spaces before { in rule declarations
4. Put spaces after , in attribute declarations
5. Use hex color codes #000 unless using rgba
6. Use // for comment blocks (instead of /\* \*/)
7. Don’t nest selectors more than 3 levels deep
8. Use a blank line between selectors
9. Don’t use units in zero numeric values
10. Never put multiple property declarations in one line
11. Use hyphen-delimited syntax for IDs and classes [http://csswizardry.com/2010/12/css-camel-case-seriously-sucks/](http://csswizardry.com/2010/12/css-camel-case-seriously-sucks/){:target="_blank"}
12. IDs should never be used in CSS
13. Don’t use !important to solve high specificity problems either
14. Read [https://github.com/styleguide/css](https://github.com/styleguide/css){:target="_blank"}

### Rails: ###
1. Always keep Rails version up to date. Update to minor ASAP, to major - when possible
2. We use HAML as the templating language, along with SCSS for stylesheets and CoffeeScript for JS. ERB templates are allowed in plain text emails only
3. Never assume, that localhost:3000 is default host:port for development. When possible, use \*.dev mapping (use invoker). When you need to use host in app, try to use `request.host_with_port`
4. Readmes shoud be updated, edited with [markdown](http://daringfireball.net/projects/markdown/syntax){:target="_blank"}
5. To bootstrap app use [Prograils base app](https://bitbucket.org/prograils/base){:target="_blank"} whenever it's possible
6. Basically Admin area is always required. If you can't use ActiveAdmin, use Twitter bootstrap as base layout for it
7. Code and docs should be written in english

### API building: ###
1. Use proper HTTP status codes for responses. Never use 200 (OK) HTTP status for failed request. Use the 422 (Unprocessable identity) HTTP status code for validation errors
2. Use JSON content type for both requests and responses
3. When a request is failed return response with `error` and `error_description` keys (consistent with ouath2 error responses):

```
    {
      "error": "some_error_code",
      "error_description": "Some human readable message"
    }
```

### Gems: ###
Recommended gems are

* [airbrake](https://github.com/airbrake/airbrake){:target="_blank"} Notifies developers about uncaught exceptions. Connect it to [robactwo.prograils.com](https://robactwo.prograils.com/){:target="_blank"}
* [sidekiq](https://github.com/mperham/sidekiq){:target="_blank"} Background processing
* [cancancan](https://github.com/CanCanCommunity/cancancan){:target="_blank"} Authorization library
* [carrierwave](https://github.com/carrierwaveuploader/carrierwave){:target="_blank"} Library for uploading files (we DO NOT use [paperclip](https://github.com/thoughtbot/paperclip){:target="_blank"} any more). For image processing use it with [mini_magick](https://github.com/minimagick/minimagick){:target="_blank"}
* [devise](https://github.com/plataformatec/devise){:target="_blank"} Authentication solution for Rails with [Warden](https://github.com/hassox/warden){:target="_blank"}
* [decent_exposure](https://github.com/hashrocket/decent_exposure){:target="_blank"} A helper for creating declarative interfaces in controllers. [inherited_resources](https://github.com/josevalim/inherited_resources){:target="_blank"} is deprecated now. Maintainer of the gem suggests to use only [responders](https://github.com/plataformatec/responders){:target="_blank"} gem as a replacement, but we recommend to use responders gem together with decent_exposure. See [integration example](https://gist.github.com/Bonias/4ce18e30881480f42a9d){:target="_blank"}
* [geocoder](https://github.com/alexreisner/geocoder){:target="_blank"} Geocoding solution for Ruby
* [ransack](https://github.com/activerecord-hackery/ransack){:target="_blank"} Searching library
* [kaminari](https://github.com/amatsuda/kaminari){:target="_blank"} Pagination library (we DO NOT use [will_paginate](https://github.com/mislav/will_paginate){:target="_blank"} any more)

#### Development: ####
* [better_errors](https://github.com/charliesome/better_errors){:target="_blank"}
* [rails_panel](https://github.com/dejan/rails_panel){:target="_blank"}
* [invoker](http://invoker.codemancers.com/){:target="_blank"}
* [pry-rails](https://github.com/rweng/pry-rails){:target="_blank"} Pry is an IRB alternative and runtime developer console. Learn more at [pry wiki](https://github.com/pry/pry/wiki){:target="_blank"}
* [guard](https://github.com/guard/guard) Toogether with [guard-rspec](https://github.com/guard/guard-rspec){:target="_blank"} automatically runs your tests (much like autotest){:target="_blank"}
* [annotate](https://github.com/ctran/annotate_models){:target="_blank"} Annotate ActiveRecord models

#### Test: ####
* [vcr](https://github.com/vcr/vcr){:target="_blank"} Record test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests
* [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner){:target="_blank"} Cleaning databases for Rails < 5.1. Can be used to clean database in capybara tests. For other tests, Rails' defeult transaction strategy is sufficient
* [factory_bot](https://github.com/thoughtbot/factory_bot){:target="_blank"} A library for setting up Ruby objects as test data. For integration with rails use [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails){:target="_blank"}
* [capybara](https://github.com/teamcapybara/capybara){:target="_blank"} with headless Chromedriver. Do not use capybara-webkit or poltergeist anymore, existing projects should switch to Chromedriver at earliest possibility
* [simplecov](https://github.com/colszowka/simplecov){:target="_blank"} Code coverage analysis tool

#### Production: ####
* [puma](https://github.com/puma/puma){:target="_blank"} HTTP server for Rack applications

Some of these gems are used in [base app](https://bitbucket.org/prograils/base){:target="_blank"}. Look there for examples of integration.

### Screencasts: ###
* [Railscasts 327 - Minitest with rails] (http://railscasts.com/episodes/327-minitest-with-rails){:target="_blank"}
* [Railscasts 275 - How I test] (http://railscasts.com/episodes/275-how-i-test){:target="_blank"}

### Code Responsibility: ###

You’re responsible for every project you contributed to in last 12 months. This is important if in doubt who should install a critical update (Rails or from other lib). If you were participating and you’re still wondering who should do it, then just do it. Time is critical in such situations.
Critical bugs should be fixed ASAP. Time of day does not matter in such cases. Critical bugs are those which affect basic business functionalities of application (e.g. impossibility to upload video in video-sharing app).


### Testing: ###
1. Do test. A lot
2. All new features need to have full test coverage
3. Unit and integration tests are most important
4. Use [rspec](http://rspec.info/){:target="_blank"} when possible. Choosing different test framework will require acceptance of other team members
5. Make use of [rspec-rails](https://github.com/rspec/rspec-rails){:target="_blank"}
6. Try to follow [Better Specs](http://www.betterspecs.org/){:target="_blank"} suggestions
7. All code pushed to master and other branches is checked in CI.
8. Do not test functionalities provided by other gems (like email/password validation in Devise) - unless you have overwritten their code and behavior
9. Use [factory_bot](https://github.com/thoughtbot/factory_bot){:target="_blank"} for fixtures
