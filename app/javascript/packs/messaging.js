/**
 * this is the main pack file for the messaging module
 */


import 'bootstrap';
import 'stylesheets/messaging';
import './messaging_utils';
import { remove_form_edit_from_message_container } from '../messaging/messages/utils';
import consumer from '../channels/consumer';
import init_subscription_for_resource from '../channels/messaging_channel';
window.consumer = consumer
window.init_subscription_for_resource = init_subscription_for_resource
window.remove_form_edit_from_message_container = remove_form_edit_from_message_container;