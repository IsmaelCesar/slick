/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to the condin of the behaviuor for when the user
 * has selected a group in the group list
 */

  import consumer from "../../channels/consumer";
  import init_subscription_for_resource from "../../channels/messaging_channel";
  
  document.querySelectorAll('.text-channel-option').forEach((text_channel_option)=>{
    text_channel_option.addEventListener('click', ()=>{
      let text_channel_id = text_channel_option.querySelector('#text_channel_id').value; 
      consumer.text_channel = init_subscription_for_resource(consumer, 
                                                             'text_channel', 
                                                             text_channel_id);
    });
  });
