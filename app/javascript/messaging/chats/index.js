/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to the behaviours to be implemented in
 * the index page.
 */

  import { Modal } from "bootstrap";
  import { AjaxBuilder } from "../../packs/ajax_utils";
  import consumer from "../../channels/consumer";
  import init_subscription_for_resource from "../../channels/messaging_channel";
  import alertify from "alertifyjs";

  const ajax_builder = new AjaxBuilder();
  const modal_container = document.querySelector('#modal-container');
  const modal_container_observer = new MutationObserver(()=>{    

    let modal_new_invite = new Modal(document.querySelector('#modal-new-invite')); 
    modal_new_invite.show();

    document.querySelector('#add-new-friend')?.addEventListener('click', (event)=>{
      event.preventDefault();
      let form_user_invite = document.querySelector('#form-user-invite'); 
      if(form_user_invite.checkValidity()){
        let form_data = new FormData(form_user_invite);
        ajax_builder.post('/messaging/user_invites/create', 
                          Object.fromEntries(form_data), 
                          (data)=>{ 
                            //new Modal(document.querySelector('#modal-new-invite')).hide();                             
                            modal_new_invite.hide();
                            alertify.success('Successfuly sent an invite');
                          }, (error)=>{
                            alertify.error(error.message);
                          });
      }
      else{
        console.log('Preencha o campo');
      }
    })

  });

  if(modal_container){
    console.log('Applying mutation observer');
    modal_container_observer.observe(modal_container, { childList: true });
  }

  const buttons_select_chats  = document.querySelectorAll('.btn-select-chat');
  if(buttons_select_chats){ 
    buttons_select_chats.forEach((button)=> { 
      button.addEventListener('click', ()=> {
        let active_list_item = document.querySelector('li.active');
        if(active_list_item){ 
          active_list_item.classList.remove('active');
        }
        let parent_list_item = button.parentNode;
        let chat_id_field = parent_list_item.querySelector('#chat_id');
        parent_list_item.classList.add('active');
        consumer.chat_messages = init_subscription_for_resource(consumer, 'chat', chat_id_field.value);
      })
    });
  }
