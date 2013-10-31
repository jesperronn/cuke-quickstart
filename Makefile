#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

test:
	node capybara-test/server.js &
	cucumber 
	kill -9 `cat capybara-test/pid.txt`
	rm capybara-test/pid.txt

install:
	cd capybara-test && npm install && cd -
	echo "node modules successfully installed in capybara-test/node_modules"
	echo
	echo "run tests by typing 'make test'"
