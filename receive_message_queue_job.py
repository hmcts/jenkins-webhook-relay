import os
import asyncio
from azure.servicebus.aio import ServiceBusClient
import requests
import json
import logging

logging.disable()
logging.basicConfig(level=logging.INFO, format='%(name)s - %(levelname)s - %(message)s')

CONNECTION_STR = os.environ['SERVICE_BUS_CONNECTION_STR']
QUEUE_NAME = os.environ["SERVICE_BUS_QUEUE_NAME"]
CONNECTION_URL = os.environ["CONNECTION_URL"]
MAX_MESSAGE_COUNT = os.getenv('MAX_MESSAGE_COUNT', default=100)
MAX_WAIT_TIME = os.getenv('MAX_WAIT_TIME', default=5)

async def main():
    '''Reads servicebus messages and forwards it to jenkins.'''
    logging.info("started receiving message")
    servicebus_client = ServiceBusClient.from_connection_string(conn_str=CONNECTION_STR)
    
    async with servicebus_client:
        receiver = servicebus_client.get_queue_receiver(queue_name=QUEUE_NAME)
        async with receiver:
            received_msgs = await receiver.receive_messages(max_message_count=int(MAX_MESSAGE_COUNT), max_wait_time=int(MAX_WAIT_TIME))
            for msg in received_msgs:
                try:
                    # Safely decode message body as UTF-8 and parse JSON
                    body_str = str(msg)
                    body_json = json.loads(body_str)
                except Exception as e:
                    logging.error(f"Failed to decode or parse message: {e}")
                    await receiver.complete_message(msg)
                    continue
                
                if "action" in body_json:
                    headers = {'Content-type': 'application/json', 'X-GitHub-Event': 'pull_request'}
                    logging.info("Current msg: %s", body_json)
                    print(body_json)
                    try:
                        response = requests.post(url=CONNECTION_URL + "/github-webhook/", json=body_json, headers=headers)
                        logging.info("status_code: %s", response.status_code)
                        print("status_code: ", response.status_code)
                        print("\n")
                        if response.status_code == 200:
                            await receiver.complete_message(msg)
                            logging.info("Current msg has been deleted")
                    except Exception as e:
                        logging.error(f"Failed to post to Jenkins: {e}")
                        
                elif "pusher" in body_json:
                    headers = {'Content-type': 'application/json', 'X-GitHub-Event': 'push'}
                    logging.info("Current msg: %s", body_json)
                    print(body_json)
                    try:
                        response = requests.post(url=CONNECTION_URL + "/github-webhook/", json=body_json, headers=headers)
                        logging.info("status_code: %s", response.status_code)
                        print("status_code: ", response.status_code)
                        print("\n")
                        if response.status_code == 200:
                            await receiver.complete_message(msg)
                            logging.info("Current msg has been deleted")
                    except Exception as e:
                        logging.error(f"Failed to post to Jenkins: {e}")
                else:
                    logging.warning("Current msg will be deleted without processing")
                    await receiver.complete_message(msg)
                    
            logging.info("completed processing messages")

loop = asyncio.get_event_loop()
loop.run_until_complete(main())
