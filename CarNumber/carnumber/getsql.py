import pymysql

def getCarInfor(carnumber):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "SELECT id from pro_car_information WHERE car_number = '{}'".format(carnumber)
    cursor = db.cursor()
    carId = 0

    try:
        print(sql)
        cursor.execute(sql)
        data = cursor.fetchone()

        if data != None and data[0] > 0:
            carId = data[0]
            db.close()
            return carId
        else:
            db.close()
            return carId
    except ZeroDivisionError as e:
        print("except:",e)
        db.close()
        return carId

def setNewCar(carnumber,state,priceMode):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "INSERT INTO pro_car_information(car_number, state, priceMode)VALUES( '{}', {}, {})".format(carnumber,state,priceMode)
    cursor = db.cursor()

    try:
        print(sql)
        cursor.execute(sql)
        db.commit()
        db.close()
        return 1
    except ZeroDivisionError as e:
        db.rollback()
        print("except:", e)
        db.close()
        return 0

def setNewVehicel(carId,entryTime,parkingState,photo):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "INSERT INTO pro_parked_vehicles(car_id, entry_time, parking_state, photo)VALUES( {}, '{}', {}, '{}' )".format(carId,entryTime,parkingState,photo)
    cursor = db.cursor()
    try:
        print(sql)
        cursor.execute(sql)
        db.commit()
        db.close()
        return 1
    except ZeroDivisionError as e:
        db.rollback()
        print("except:", e)
        db.close()
        return 0

def getCarMode(carnumber):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    priceMode = 0
    sql = "SELECT priceMode from pro_car_information WHERE car_number = '{}'".format(carnumber)
    cursor = db.cursor()
    try:
        print(sql)
        cursor.execute(sql)
        data = cursor.fetchone()

        if data != None and data[0] > 0:
            priceMode = data[0]
            db.close()
            return priceMode
        else:
            db.close()
            return priceMode
    except ZeroDivisionError as e:
        print("except:",e)
        db.close()
        return priceMode

def delCarVehicel(carId):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "DELETE FROM pro_parked_vehicles WHERE car_id = {}".format(carId)
    cursor = db.cursor()
    try:
        print(sql)
        cursor.execute(sql)
        db.commit()
        db.close()
        return 1
    except ZeroDivisionError as e:
        db.rollback()
        print("except:", e)
        db.close()
        return 0

def getCarVehicel(carId):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "SELECT * FROM pro_parked_vehicles WHERE car_id = {}".format(carId)
    cursor = db.cursor()
    try:
        print(sql)
        cursor.execute(sql)
        results = cursor.fetchall()
        db.close()
        return results
    except ZeroDivisionError as e:
        print("except:", e)
        db.close()
        return None

def setNewRecord(carId, entryTime, departureTime, price):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "INSERT INTO pro_parking_record(car_id,entry_time,departure_time,price)VALUES( {}, '{}', '{}', {} )".format(carId,entryTime,departureTime,price)
    cursor = db.cursor()
    try:
        print(sql)
        cursor.execute(sql)
        db.commit()
        db.close()
        return 1
    except ZeroDivisionError as e:
        db.rollback()
        print("except:", e)
        db.close()
        return 0

def upVehicleState(carId,parkingState):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "UPDATE pro_parked_vehicles SET parking_state = {} WHERE car_id = '{}'".format(parkingState, carId)
    cursor = db.cursor()
    try:
        print(sql)
        cursor.execute(sql)
        db.commit()
        db.close()
        return 1
    except ZeroDivisionError as e:
        db.rollback()
        print("except:", e)
        db.close()
        return 0

def getPayState(carId):
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "SELECT COUNT(*) FROM pro_parked_vehicles WHERE car_id = '{}'".format(carId)
    cursor = db.cursor()
    payCount = 0
    try:
        print(sql)
        cursor.execute(sql)
        data = cursor.fetchone()
        payCount = data[0]
        db.close()
        return payCount
    except Exception as e:
        print("except:", e)
        db.close()
        return payCount

def getVehicleCount():
    db = pymysql.connect(host='127.0.0.1', user='root', password='root', database='parking_management')
    sql = "SELECT COUNT(*) FROM pro_parked_vehicles"
    cursor = db.cursor()
    vehicleCount = 0
    try:
        print(sql)
        cursor.execute(sql)
        data = cursor.fetchone()
        vehicleCount = data[0]
        db.close()
        return vehicleCount
    except Exception as e:
        print("except:", e)
        db.close()
        return vehicleCount