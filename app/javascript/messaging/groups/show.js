/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to the condin of the behaviuor for when the user
 * has selected a group in the group list
 */

  import { Modal } from "bootstrap";
  import { setup_mutation_observer_for_context } from '../messaging_observers';
  import consumer from '../../channels/consumer';
  import init_subscription_for_resource from '../../channels/messaging_channel';
  window.consumer = consumer
  window.init_subscription_for_resource = init_subscription_for_resource

  document.querySelector('.btn-toggle-group-actions')?.addEventListener('click', ()=>{
    let group_actions = document.querySelector('#group-actions'); 
    if(group_actions){
      let modal_group_action = new Modal(group_actions);
      modal_group_action.show();
    }
  })

  const message_chat_content = document.querySelector('.group-menu-selection-content');
  const chat_content_observer = setup_mutation_observer_for_context(message_chat_content);
