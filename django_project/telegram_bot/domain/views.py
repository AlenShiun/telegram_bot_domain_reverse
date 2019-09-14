from django.conf import settings
from django.http import HttpResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt

import dns.resolver
import json
import requests
import threading

# Create your views here.

def send_message(chat_id, text):
    url = 'https://api.telegram.org/bot{}/{}'.format(settings.TELEGRAM_BOT_TOKEN['domain'], 'sendMessage')
    print('url: {}'.format(url))
    data = {}
    data['chat_id'] = chat_id
    data['text'] = text

    r = requests.post(url, data=data)

def resolve_and_response(chat_id, domain_name):
    # Get IP of domain
    resolver = dns.resolver.Resolver(configure=False)
    resolver.nameservers = ['8.8.8.8']
    answer = resolver.query(domain_name, 'A')
    domain_ip_list = []
    for rr in answer:
        domain_ip_list.append(rr.to_text())

    res = 'Domain: {}\n'.format(domain_name)
    domain_ips = '\n'.join(map(str, domain_ip_list))
    res += domain_ips

    # Send message back
    send_message(chat_id, res)

@csrf_exempt
def index(request):
    print('{}'.format(request))
    print('{}'.format(request.body))

    body = json.loads(request.body)
    print('body: {}'.format(body))

    print('')
    print('')
    print('')
    print('dumps: {}'.format(json.dumps(body)))

    # Get chat ID
    chat_id = body['message']['chat']['id']

    # Get text content
    text = body['message']['text']

    # Trim
    text = text.strip()

    print('cid: {}, text: {}'.format(chat_id, text))

    # Command not support
    if text[0:3] != '/d ':
        print('Command not supported')
        message = '尼在說啥我聽不懂=3=......'
        t = threading.Thread(target = send_message, args=(chat_id, message))
        t.start()
        return HttpResponse('OK')

    # Get domain name
    domain_name = text[3:]

    # Get IP of domain
    t = threading.Thread(target = resolve_and_response, args=(chat_id, domain_name,))
    t.start()
    
    return HttpResponse('OK')

