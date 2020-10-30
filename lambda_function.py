import boto3
import csv


def lambda_handler(event, context):
    key = 'data.csv'
    bucket = 'my-tf-test-bucket-227766'
    dyndb = boto3.client('dynamodb')
    s3_resource = boto3.resource('s3')
    s3_object = s3_resource.Object(bucket, key)

    data = s3_object.get()['Body'].read().decode('utf-8').splitlines()
    firstrecord = True

    lines = csv.reader(data)
    headers = next(lines)
    print('headers: %s' % (headers))
    # for line in lines:
    #     #print complete line
    #     print(line)
    #     #print index wise
    #     print(line[0], line[1])
    for row in lines:
        if (firstrecord):
            firstrecord = False
            continue
        EmpId = row[0]
        EmpName = row[1].replace(',', '').replace('$', '') if row[0] else '-'
        Dept = row[2].replace(',', '').replace('$', '') if row[1] else '-'
        Salary = row[3].replace(',', '').replace('$', '') if row[2] else 0
        WorkingHours = row[4].replace(',', '').replace('$','') if row[3]else 0
        Technology = row[5].replace(',','').replace('$', '') if row[4] else 0
        response = dyndb.put_item(
            TableName='EmpList',
            Item={
                'EmpId': {'N': str(EmpId)},
                'EmpName': {'S': EmpName},
                'Dept': {'S': Dept},
                'Salary': {'N': str(Salary),},
                'WorkingHours':{'N': str(WorkingHours)},
                'Technology':{'S': Technology}
            }
        )
        print('Put succeeded:')
