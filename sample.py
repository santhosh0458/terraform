import csv


def Function():
    recList = []
    try:
        with open('data.csv') as confile:
            recList = confile.read().split('\n')
            firstrecord = True
            csv_reader = csv.reader(recList , delimiter=',', quotechar='"')
            for row in csv_reader :
                if (firstrecord):
                    firstrecord = False
                    continue
                EmpId = row[0]
                EmpName = row[1].replace(',', '').replace('$', '') if row[0] else '-'
                Salary = row[2].replace(',', '').replace('$', '') if row[1] else 0

                print(row)
                print(recList)
                print(EmpId, EmpName, Salary)
    except Exception as e:
        print(str(e))
print(Function())