/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * Methods used accross the application speficif for the messages
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
    return user_message_container.querySelector('.message-content p').textContent;
  }

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
