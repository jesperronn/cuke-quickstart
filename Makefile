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


# creates list of available steps from the step definitions file
stepdefs:
	cat /dev/null > AVAILABLE_STEPS.txt
	echo "AUTOGENERATED.  by 'make stepdefs' " >> AVAILABLE_STEPS.txt
	echo >> AVAILABLE_STEPS.txt
	echo "AVAILABLE STEP DEFINITIONS"  >> AVAILABLE_STEPS.txt
	echo "==========================" >> AVAILABLE_STEPS.txt
	cucumber -p stepdefs -q | grep "/^" >> AVAILABLE_STEPS.txt
	echo >> AVAILABLE_STEPS.txt
	echo >> AVAILABLE_STEPS.txt
	echo >> AVAILABLE_STEPS.txt
	echo "UNUSED STEP DEFINITIONS"  >> AVAILABLE_STEPS.txt
	echo "==========================" >> AVAILABLE_STEPS.txt
	cucumber -p stepdefs -q | grep -B 1 "NOT MATCHED" | grep -v -e "NOT MATCHED" -o -e "--" >> AVAILABLE_STEPS.txt
	echo >> AVAILABLE_STEPS.txt


