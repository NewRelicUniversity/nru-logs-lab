#!/bin/sh
if [ $(grep -c "YOUR_LICENSE_KEY" newrelic-infra.yml) -gt 0 ]
then
    echo "\nReplace YOUR_LICENSE_KEY in newrelic-infra.yml with the value of the INGEST-LICENSE key for your New Relic account.\n"
else
    sudo newrelic-infra &
fi
