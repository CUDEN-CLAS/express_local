#! /bin/sh
BEHAT_PARAMS='{"extensions":{"Drupal\\DrupalExtension":{"drupal":{"drupal_root":"/data/web/express/testing"},"drush":{"root":"/data/web/express/testing"}},"Behat\\MinkExtension":{"base_url":"http://express.local/testing"}}}'
export BEHAT_PARAMS
