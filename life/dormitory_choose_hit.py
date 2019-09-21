import urllib
from urllib import request
from urllib import parse
import json


SESSION_ID = 'CC37B04D9F7D8D20C983EF457B90391F'
token_url = 'http://hqfw.hit.edu.cn/hqgy_common/home/getToken'
choose_cw = 'http://hqfw.hit.edu.cn/hqgy_xs/xsxf/chooseCw'
xfjhid = '52d5b538b2ab4b2ea2e112fcda1d27a7'  # 选房计划 ID

token_headers = {
    'Cookie': 'JSESSIONID={0}'.format(SESSION_ID)
}

cw_headers = {
    'Cookie': 'JSESSIONID={0}'.format(SESSION_ID),
    'Content-Type': 'application/x-www-form-urlencoded'
}

cw_info = {
    'C111-2': '877b001acb4348548646b51077983415',
    'C111-2-2': '91f2cfe03f984e1e870c89c1824ec37b',
    'C104-1': '7464b6a93c824b2e841e5c3d109b6b3a',
    'C109-2': '2e1396a5775246b4a896a8dc7b46dfbc',
    'C112-2': '5687f5ab0f734c2b8fa475154d90c98d',
    'C114-2': 'a821901af39d4648a032243ff71e033f'
}


is_finished = False

while not is_finished:
    for cwid, cw in cw_info.items():
        print('Choose', cwid, '...')
        req = request.Request(token_url, headers=token_headers, data={})
        token = request.urlopen(req).read().decode('utf-8')

        cw_form_data = {
            'info': {
                'sjjlid': cw,
                'xfjhid': xfjhid,
                'token': token
            }
        }
        data = bytes(urllib.parse.urlencode(cw_form_data), encoding='utf8').replace(b'+', b'').replace(b'%27', b'%22').replace(b'%2C', b',')
        req = request.Request(choose_cw, headers=cw_headers, data=data)

        response = urllib.request.urlopen(req)
        response_text = json.loads(response.read().decode('utf-8'))
        msg = response_text['msg']
        is_success = response_text['isSuccess']

        if response.status == 200 and is_success:
            print('Finished')
            is_finished = True
            break
        else:
            print(response.status, msg)
