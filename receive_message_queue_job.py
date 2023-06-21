import os
import asyncio
from azure.servicebus.aio import ServiceBusClient
import requests
import json

CONNECTION_STR = os.environ['SERVICE_BUS_CONNECTION_STR']
QUEUE_NAME = os.environ["SERVICE_BUS_QUEUE_NAME"]
CONNECTION_URL = os.environ["CONNECTION_URL"]
MAX_MESSAGE_COUNT = os.getenv('MAX_MESSAGE_COUNT', default=1)
MAX_WAIT_TIME = os.getenv('MAX_WAIT_TIME', default=5)
async def main():
    print("started receiving message")
    print("=========================")
    servicebus_client = ServiceBusClient.from_connection_string(conn_str=CONNECTION_STR)
    headers = {'Content-type': 'application/json', 'X-GitHub-Event':'pull_request'}

    async with servicebus_client:
        receiver = servicebus_client.get_queue_receiver(queue_name=QUEUE_NAME)
        async with receiver:
            received_msgs = await receiver.receive_messages(max_message_count=MAX_MESSAGE_COUNT, max_wait_time=MAX_WAIT_TIME)
            for msg in received_msgs:
                print(json.loads(str(msg)))
                print("\n")
                response = requests.post(url=CONNECTION_URL, data=str(msg), headers=headers)
                print(response.status_code)
                if (response.status_code == 200):
                    await receiver.complete_message(msg)
    print("=========================")
    print("completed receiving message")


loop = asyncio.get_event_loop()
loop.run_until_complete(main())