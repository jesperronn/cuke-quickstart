#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

test:
	node steptesting/server.js &
	cucumber 
	kill -9 `cat steptesting/pid.txt`
	rm steptesting/pid.txt

install:
	cd steptesting && npm install && cd -
	echo "node modules successfully installed in steptesting/node_modules"
	echo
	echo "run tests by typing 'make test'"



server_start:
	node steptesting/server.js &

server_stop:
	kill -9 `cat steptesting/pid.txt`
	rm steptesting/pid.txt
