---
layout: page
title: Development
---

Basic set of rules and common practices used for Rails development in Prograils.com.

Feel free to contribute (with pull request).


## GIT ##
1. Always use GIT. Always.
2. Use [Git flow](http://nvie.com/posts/a-successful-git-branching-model/). If by any means you refuse to use Git flow, use feature branches. Each feature branches should be created from develop branch. Features should be merged into develop, then into master.
3. When possible, use pull requests. It's always better to have your code checked and accepted by someone else. Also - by doing so you're not the only one responsible for your feature :)
4. Commit early, commit often.
5. **Never** commit directly in master branch.
6. Code in master branch should be always stable and ready for deployment.
7. Avoid direct commit in develop branch. Hotfixes etc are allowed by any means
8. Merge using `git merge --no-ff`
9. Know difference between `git pull` and `git pull --rebase` [link 1](http://www.derekgourlay.com/archives/428), [link 2](http://geekblog.oneandoneis2.org/index.php/2013/04/30/please-stay-away-from-rebase), [link 3](http://jrb.tumblr.com/post/49248876242/git-pull-rebase-until-it-hurts), [link 4](https://coderwall.com/p/7aymfa)

## Git Workflow ##

### Information: ###

All commands assume tracking remote branch is enabled for master, develop, production, and staging.

When you checkout to branch which name exists in remote repo tracking is sets automatically:

	$ git branch -r
	  origin/HEAD -> origin/master
	  origin/master
	  origin/newbranch
	$ git checkout newbranch
	Branch newbranch set up to track remote branch newbranch from origin.
	Switched to a new branch 'newbranch'

When you created new branch you need to add -u parameter to git push:

	$ git checkout -b newbranch2
	Switched to a new branch 'newbranch2'
	$ git push -u origin newbranch2
	Total 0 (delta 0), reused 0 (delta 0)
	To [path]
	 * [new branch]      newbranch2 -> newbranch2
	Branch newbranch2 set up to track remote branch newbranch2 from origin.

git help (`git help pull`, `git help branch`), and internet resources ([http://gitready.com](http://gitready.com), [http://git-scm.com/book](http://git-scm.com/book)) are your friends.

---

### Workflow ([Git flow](http://nvie.com/posts/a-successful-git-branching-model/)): ###

#### Requirements

You have cloned repo with master, develop, production and staging branches

#### Create a feature

1. pull develop branch (`git checkout develop`, `git pull`)
2. create feature branch from develop branch (`git checkout -b feature/A develop`)
3. write some code, do commits
4. (optional) It is good time to squash your commits with git rebase [http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html](http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html) - do this ONLY on commits that haven’t been pushed to remote repository
5. (optional) You can place your commits on top of current develop branch using git rebase (`git checkout develop`, `git pull`, `git checkout feature/A`, `git rebase develop`) - do this ONLY when you didn't pushed this branch to remote repository

#### After feature is completed:

6. You need to do one of two:
  a) If code review is needed push your feature branch to repository and create a pull request(to develop branch)
  b) Otherwise just merge feature branch to develop and push develop to repository (`git checkout develop`, `git merge --no-ff feature/A`, `git push`)
7. Merge develop to staging and push staging branch (`git checkout staging`, `git pull`, `git merge develop`, `git push`)
8. deploy to staging environment (`cap staging deploy` or something)

#### when all features for upcoming release are accepted in internal review system

9. create release branch from develop branch (`git checkout -b release/v2012-04-14-10-12-ml develop`, `git push -u origin release/v2012-04-14-10-12-ml`)
10. work with release branch (minor bug fixes and preparing meta-data for a release) - Adding new features here is strictly prohibited
11. merge release branch into master branch and master branch into production branch. Remove release branch (`git checkout master`, `git merge release/v2012-04014-10-12-ml`, `git push`, `git checkout production`, `git merge master`, `git push`, `git branch -d release/v2012-04-14-10-12-ml && git push origin :release/v2012-04-14-10-12-ml`)
12. deploy to production environment (`cap production deploy` or something)

### Bugfixes

  Bugfixes can be fixed by creating bugfix branch from master, and merged back to master and develop branch.

## CODE STYLE ##
1. Use [Overcommit](https://github.com/brigade/overcommit) to help you follow code style guides. Example config file: https://bitbucket.org/prograils/dotfiles/src/master/overcommit.yml. See also [rubocop config file](https://bitbucket.org/prograils/dotfiles/src/master/rubocop.yml) and [haml lint config file](https://bitbucket.org/prograils/dotfiles/src/master/haml-lint.yml)

## GIT commit messages ##
1. Separate subject from body with a blank line
2. Limit the subject line to 50 characters
3. Capitalize the subject line
4. Do not end the subject line with a period
5. Use the imperative mood in the subject line
6. Wrap the body at 72 characters
7. Use the body to explain what and why vs. how
8. Read [http://chris.beams.io/posts/git-commit/](http://chris.beams.io/posts/git-commit/), [https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message](https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message)

## Ruby ##
1. We're using latest Ruby 2.x release (2.5.0 at the moment of writing this text)
2. On development machines rbenv is preffered
3. On servers rbenv is used with newest 2.x release
4. Code style guide as described [here](https://github.com/styleguide/ruby)
5. Use Ruby >=1.9 hash syntaxt: `{ a: 1, b: 2 }`, *not* `{:a=>1, :b=>2}`
6. Use Safe Navigation Operator (`&`), avoid using `try()`

## JS/CoffeeScript ##
1. Write new JS in CoffeeScript
2. Use soft-tabs with a two space indent
3. Always use camelCase, never underscores
4. Don't ever use $.get or $.post. Instead use $.ajax and provide both a success handler and an error handler
5. Use $.fn.on instead of $.fn.bind, $.fn.delegate and $.fn.live
6. Try to prefix all javascript-based selectors with js- or use data- attribute. More reading: [https://coderwall.com/p/qktuzw](https://coderwall.com/p/qktuzw), [https://roy.io/dont-use-class-names-to-find-html-elements-with-js/](https://roy.io/dont-use-class-names-to-find-html-elements-with-js/)

## CSS ##
1. Use soft-tabs with a two space indent.
2. Put spaces after : in property declarations.
3. Put spaces before { in rule declarations.
4. Put spaces after , in attribute declarations;
5. Use hex color codes #000 unless using rgba.
6. Use // for comment blocks (instead of /\* \*/).
7. Don’t nest selectors more than 3 levels deep.
8. Use a blank line between selectors.
9. Don’t use units in zero numeric values
10. Never put multiple property declarations in one line.
11. Use hyphen-delimited syntax for IDs and classes [http://csswizardry.com/2010/12/css-camel-case-seriously-sucks/](http://csswizardry.com/2010/12/css-camel-case-seriously-sucks/)
12. IDs should never be used in CSS.
13. Don’t use !important to solve high specificity problems either.
14. Read [https://github.com/styleguide/css](https://github.com/styleguide/css)

## Rails ##
1. Always keep Rails version up to date. Update to minor ASAP, to major - when possible.
2. We're using HAML as templating language, SCSS and CoffeeScript. Erb templates are allowed in plain text emails only.
3. Never assume, that localhost:3000 is default host:port for development. When you can, use \*.dev mapping (use invoker). When you need to use host in app, try to use `request.host_with_port`
4. Readmes shoud be updated, edited with [markdown](http://daringfireball.net/projects/markdown/syntax). We should put there project specific technologies, how to run in development and to test the project. Good practice is to state browser compatibility requirements.
5. To bootstrap app use [Prograils base app](https://bitbucket.org/prograils/base) whenever it's possible
6. Basically Admin area is always required. If you can't use ActiveAdmin, use Twitter bootstrap as base layout for it.
7. Code and docs should be written in english.

## API building ##
1. Use proper http status codes for responses. Never use 200 http status for failed request. Use 422 http status code for validation errors
2. Use json content type.
3. When request is failed return response with `error` and `error_description` keys (consistent with ouath2 error responses):

```
    {
      "error": "some_error_code",
      "error_description": "Some human readable message"
    }
```

### Gems ###
Recommended gems

* [airbrake](https://github.com/airbrake/airbrake) Notifies developers about uncaught exceptions. Connect it to [robactwo.prograils.com](https://robactwo.prograils.com/)
* [sidekiq](https://github.com/mperham/sidekiq) Background processing
* [cancancan](https://github.com/CanCanCommunity/cancancan) Authorization library
* [carrierwave](https://github.com/carrierwaveuploader/carrierwave) Library for file uploads (we DO NOT use [paperclip](https://github.com/thoughtbot/paperclip) any more). For image processing use it with [mini_magick](https://github.com/minimagick/minimagick)
* [devise](https://github.com/plataformatec/devise) Authentication solution for Rails with [Warden](https://github.com/hassox/warden)
* [decent_exposure](https://github.com/hashrocket/decent_exposure) A helper for creating declarative interfaces in controllers. [inherited_resources](https://github.com/josevalim/inherited_resources) is deprecated now. Maintainer of the gem suggests to use only [responders](https://github.com/plataformatec/responders) gem as a replacement, but I recommend to use responders gem together with decent_exposure. See [integration example](https://gist.github.com/Bonias/4ce18e30881480f42a9d)
* [geocoder](https://github.com/alexreisner/geocoder) Geocoding solution for Ruby
* [ransack](https://github.com/activerecord-hackery/ransack) Searching library
* [kaminari](https://github.com/amatsuda/kaminari) Pagination library (we DO NOT use [will_paginate](https://github.com/mislav/will_paginate) any more)

#### development ####
* [better_errors](https://github.com/charliesome/better_errors)
* [rails_panel](https://github.com/dejan/rails_panel)
* [invoker](http://invoker.codemancers.com/)
* [pry-rails](https://github.com/rweng/pry-rails) Pry is an IRB alternative and runtime developer console. Learn more at [pry wiki](https://github.com/pry/pry/wiki)
* [guard](https://github.com/guard/guard) Toogether with [guard-rspec](https://github.com/guard/guard-rspec) automatically runs your tests (much like autotest)
* [annotate](https://github.com/ctran/annotate_models) Annotate ActiveRecord models

#### test ####
* [vcr](https://github.com/vcr/vcr) Record test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests
* [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) Cleaning databases for Rails < 5.1. Can be used to clean database in capybara tests. For other tests default rails transaction strategy is sufficient
* [factory_bot](https://github.com/thoughtbot/factory_bot) A library for setting up Ruby objects as test data. For integration with rails use [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
* [capybara](https://github.com/teamcapybara/capybara) with headless chrome. Do not use webkit or poltergeist anymore, existing projects should switch with earliers possibility
* [simplecov](https://github.com/colszowka/simplecov) Code coverage analysis tool

#### production ####
* [puma](https://github.com/puma/puma) HTTP server for Rack applications

Some of these gems are used in [base app](https://bitbucket.org/prograils/base). Look there for examples of integration.

### Testing ###
1. Do test. A lot.
2. All new features need to have full test coverage.
3. Unit and integration tests are most important.
4. Use [rspec](http://rspec.info/) when possible. Choosing different test framework will require acceptance of other team members.
5. Make use of [rspec-rails](https://github.com/rspec/rspec-rails)
6. Try to follow [Better Specs](http://www.betterspecs.org/) suggestions
7. All code pushed to master and other branches will be checked in CI.
8. Do not test functionalities provided by other gems (like email/password validation in Devise) (as long, as you did not overwrote its code / behavior)
9. Use [factory_bot](https://github.com/thoughtbot/factory_bot) for fixtures.

#### Screencasts ####
* [Railscasts 327 - Minitest with rails](http://railscasts.com/episodes/327-minitest-with-rails)
* [Railscasts 275 - How I test](http://railscasts.com/episodes/275-how-i-test)

## Code responsiblity ##
You're responsible for every project you contributed to in last 12 months. This is important if in doubt who should install critical update (Rails or from other lib). If you ware participating and you're still wonderign who should do it, then just do it. Time is critical in such situations.

Critical bugs should be fixed ASAP. Time of day does not matter in such cases. Critical bugs are those, which limit basic business functionalities of application (ie. no possibility to upload video in video-sharing app).
