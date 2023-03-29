import threading
import tkinter
root= tkinter.Tk()
import requests
import json
import time

root.geometry("800x500")
root.title("Bus Application")
label = tkinter.Label(root,text="Bus",font=('Arial',18))
label.pack(pady=20)

date = tkinter.Label(root,text="Date :",font=('Arial',18))
type = tkinter.Label(root,text="Type :",font=('Arial',18))
status = tkinter.Label(root,text="Status :",font=('Arial',18))
canvas = tkinter.Canvas(root, width=500, height=240)
rectangle = canvas.create_rectangle(100, 100, 400, 400, fill='blue')
canvas.itemconfig(rectangle, fill='green')
date.pack()
type.pack()
status.pack()
canvas.pack()
canvas.itemconfig(rectangle,fill="yellow")
isStart =  False

def start():
    global  isStart
    if isStart == False:
        isStart = True
        B['text']= "Stop"
        print("here")
        thread = threading.Thread(target=checkvalid, )
        thread.start()
    elif isStart==True:
        isStart=False
        B['text'] = "Start"
        print("problem")

B = tkinter.Button(root, text = "Start", command = start)


def checkvalid():

    apiId= "htAHjadYQOJf"
    cardId = "654321"
    api_url = "http://uviindia.tech/validate?apiid={}&cardid={}".format(apiId,cardId)
    response = requests.get(api_url).text
    response_info = json.loads(response)

    if("Invalid API ID or NFC ID" in requests.get(api_url).text):
            date.config(text="User Not Found")
            type.config(text="" )
            status.config(text="" )
            canvas.itemconfig(rectangle, fill="red")
    else:
        if ("No Data Retrived" in requests.get(api_url).text):
            print("no ticket")
            date.config(text="No Ticket Found")
            type.config(text="")
            status.config(text="")
            canvas.itemconfig(rectangle, fill="red")
        elif response_info['0']['is_ticket']== 1:
            print("FFF")
            date.config(text="Date : " + response_info['0']['to_date'])
            type.config(text="Type : " + response_info['0']['validating_parameter'])
            if response_info['0']['is_validated']==0:
               status.config(text="Status : Valid")
               canvas.itemconfig(rectangle, fill="green")
               response= requests.get("http://uviindia.tech/uviuser/isvalidate.php?int=1&api_id={}&nfc_id={}&action=changeisvalidate".format(apiId,cardId))
               print(response)
            if response_info['0']['is_validated'] == 1:
              status.config(text="Status : Invalid")
              date.config(text="Date : " + response_info['0']['to_date'])
              canvas.itemconfig(rectangle, fill="red")
        elif response_info['0']['is_ticket']== 0:
             date.config(text="Date : " + response_info['0']['to_date'])
             type.config(text="Type : " + response_info['0']['validating_parameter'])
             status.config(text="Status : Valid")
             canvas.itemconfig(rectangle, fill="green")

    time.sleep(5)
    date.config(text="Date : " )
    type.config(text="Type : " )
    status.config(text="Status : " )
    canvas.itemconfig(rectangle, fill="yellow")
    if isStart==True:
        checkvalid()


B.pack(pady=20)
root.mainloop()

