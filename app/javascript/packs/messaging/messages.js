/**
 * @author Ismael Cesar  <leamscesar@gmail.com>
 * 
 * file deticated to the submission of the text message being sent
 */

  
  let observer = new MutationObserver(()=>{
    document.querySelector('#form-message-content')?.addEventListener('submit', (event)=>{
      let form_send_message = document.querySelector('#form-message-content'); 
      let text_field = form_send_message.querySelector('input[type="text"]');
      if(text_field.value === ''){
        event.preventDefault(); 
      }
    });
  });

  let chat_list_container = document.querySelector('.messaging-chat-content');
  observer.observe(chat_list_container, { childList: true });
