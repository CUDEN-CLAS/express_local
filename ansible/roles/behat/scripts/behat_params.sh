#! /bin/sh
BEHAT_PARAMS='{"extensions":{"Drupal\\DrupalExtension":{"drupal":{"drupal_root":"/data/web/express/BEHAT_TESTING_PATH"},"drush":{"root":"/data/web/express/BEHAT_TESTING_PATH"}},"Behat\\MinkExtension":{"base_url":"http://express.local/BEHAT_TESTING_PATH"}}}'
BEHAT_PARAMS=`echo $BEHAT_PARAMS | sed -e s#BEHAT_TESTING_PATH#$BEHAT_TESTING_PATH#`
BEHAT_PARAMS=`echo $BEHAT_PARAMS | sed -e s#BEHAT_TESTING_PATH#$BEHAT_TESTING_PATH#`
BEHAT_PARAMS=`echo $BEHAT_PARAMS | sed -e s#BEHAT_TESTING_PATH#$BEHAT_TESTING_PATH#`
export BEHAT_PARAMS
