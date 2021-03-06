/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * Methods used accross the application specific for the messages
 */

/**
 * Sets up the click behaviour for answering a messate
 * 
 * @param button HTML button
 */
  export function toggle_message_answer_for_button(button){    
    button.addEventListener('click', ()=>{
      let message_text = extract_message_text_from_button_parent_note(button);
      let answered_message_node = build_answered_message_node(message_text);
      prepend_message_text_to_send_message_form(answered_message_node);
      set_answered_message_value(button.value); 
    });
  }

  /**
   * Extracts the message texts from the message container
   * where the button is
   * 
   * @param {button} button html node button
   * @returns {String}  message text extracted
   */
  function extract_message_text_from_button_parent_note(button){
    let user_message_container = button.parentNode.parentNode; 
    return user_message_container.querySelector('.message-content p.message-text').textContent;
  }

  /**
   * @author Ismael Cesar <leamscesar@gmail.com> 
   * 
   * Build an answer message container to be positioned
   * just before the send message form
   * 
   * @param {String} user_message  The content of the message to be answered
   * 
   * @returns {div} The div containing the answered message content
   */
  function build_answered_message_node(user_message){
    let text_node = document.createTextNode(user_message);
    let div = document.querySelector('.answered-message');
    if(div === null){
      div = document.createElement('div');
      let p = document.createElement('p');
      p.appendChild(text_node);
      p.classList += 'answered-message-text'
      div.appendChild(p); 
      div.classList += 'answered-message'
      div.innerHTML += '<button class="btn btn-sm"><i class="fas fa-times"></i></button>';
      div.querySelector('button').addEventListener('click', ()=>{
        div.remove();
        set_answered_message_value(null);
      });
    }
    else{
      div.querySelector('p').innerHTML = user_message;
    }

    return div; 
  }

  function prepend_message_text_to_send_message_form(answered_message_node){
    let message_list_container = document.querySelector('.messages-list-contaner'); 
    let form_container = document.querySelector('.messages-list-text-form');
    message_list_container.insertBefore(answered_message_node, form_container); 
  }

  export function set_answered_message_value(value){
    let answered_message_element = document.querySelector('#answered_message_id'); 
    answered_message_element.value = value;
  }

  export function remove_form_edit_from_message_container(form_tag){
    let message_content = form_tag.querySelector("#message_content").value;
    let parent_form_conainer = form_tag.parentElement; 
    form_tag.remove();
    parent_form_conainer.innerHTML = message_content;
  }