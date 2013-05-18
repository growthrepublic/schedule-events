# What is it?
It's a bootstrap of a rails application built using rails-api gem. It was prepared for a codility test.

# Challenge description
Challenge is to provide a mechanism to run callbacks associated with events at the certain time.
You should take a look at *app/models/stock_session.rb* to see how your concern will be used.
More details about EventSchedulable concern you will find in *app/models/concerns/event_schedulable.rb*.

Choice of the background processing engine is up to you. You can use e.g. delayed job, resque, beanstalkd and stalker or any other.

You should implement EventSchedulable to pass all given tests in *test/models/concerns/event_schedulable_test.rb* and then in *test/models/stock_session_test.rb*.
For convenience we've prepared a mechanism to make testing concerns easier but feel free to change our implementation of FakeActiveRecord class. You can introduce new classes, modules, gems.

Don't forget to implement helper methods in *test/test_helper.rb* and *test/helpers/event_schedulable_helper.rb*.

Good luck!