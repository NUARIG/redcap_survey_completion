import requests

fh = open('config/rc_credentials.txt')
myurl = next(fh).strip()
mytoken = next(fh).strip()
fh.close()

mydata = {
    'token': mytoken,
    'content': 'record',
    'format': 'csv',
    'type': 'flat',
    'fields[0]': 'net_id',
    'fields[1]': 'record_id',
    'rawOrLabel': 'raw',
    'rawOrLabelHeaders': 'raw',
    'exportCheckboxLabel': 'false',
    'exportSurveyFields': 'true',
    'exportDataAccessGroups': 'false',
    'returnFormat': 'json'
}

myreq = requests.post( myurl, data = mydata )

if not myreq.ok:
    exit(1)

fh = open ('input/mysurvey.csv', 'w')
fh.write ( myreq.text )
fh.close()
