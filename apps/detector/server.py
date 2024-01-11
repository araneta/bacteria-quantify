from flask import request, Flask, jsonify
from waitress import serve
from PIL import Image
import cv2
import os
#from imread_from_url import imread_from_url
from PIL import Image
import numpy as np
import uuid
import numpy.ma as ma
from yoloseg import YOLOSeg
from yoloseg.utils import class_names

app = Flask(__name__, static_url_path="/images", static_folder="./public/images")


@app.route("/")
def root():
    """
    Site main page handler function.
    :return: Content of index.html file
    """
    with open("./public/index.html") as file:
        return file.read()


@app.route("/detect", methods=["POST"])
def detect():
    """
        Handler of /detect POST endpoint
        Receives uploaded file with a name "image_file", passes it
        through YOLOv8 object detection network and returns and array
        of bounding boxes.
        :return: a JSON array of objects bounding boxes in format [[x1,y1,x2,y2,object_type,probability],..]
    """
    buf = request.files["image_file"]
    boxes = detect_objects_on_image(buf.stream)
    print(boxes)
    resp = jsonify(boxes)
    resp.status_code = 200
    print(resp)
    return resp
    
    
def detect_objects_on_image(buf):
    model_path = "models/bakteri.onnx"
    yoloseg = YOLOSeg(model_path, conf_thres=0.5, iou_thres=0.3)
    IMAGE_DIR = "./public/images/"
    # Read image
    #img_url = "https://upload.wikimedia.org/wikipedia/commons/e/e6/Giraffes_at_west_midlands_safari_park.jpg"
    #img = imread_from_url(img_url)
    #img = "c33_PNG_jpg.rf.0b443f79c46bb08398129118cd4af56a.jpg"
    #img_path = os.path.join(IMAGE_DIR,img)
    #image = Image.open(img_path)
    image = Image.open(buf)
    img = cv2.cvtColor(np.array(image, dtype=np.uint8), cv2.COLOR_RGB2BGR)
    # Detect Objects
    boxes, scores, class_ids, masks = yoloseg(img)
    #print('boxes', boxes, len(boxes))
    #print('scores', scores, len(scores))
    #print('class_ids', class_ids, len(class_ids))
    
    #mask shape (85, 640, 640)
    #print(masks[0])

    # Draw detections
    combined_img = yoloseg.draw_masks(img)
    box_shape = ma.shape(combined_img)
    print('combined_img', box_shape)
    
    detected = []
    idx = 0
    for cs in class_names:
        item = dict();
        item['species'] = cs
        
        total = 0
        for box, score, class_id in zip(boxes, scores, class_ids):
            if class_id==idx:
                total = total + 1
        item['totalColony'] = total        
        detected.append(item)
        idx = idx + 1
        
    
    d = dict();
    # img = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    guid = str(uuid.uuid4())
    outputfile = os.path.join(IMAGE_DIR,guid)+".jpg"
    cv2.imwrite(outputfile, combined_img)
    d['bacteries'] = detected
    d['imageID'] = guid
    
    return d

def format_e(n):
    print(n)
    a = '%E' % n
    return str(np.round(float(a.split('E')[0].rstrip('0').rstrip('.')),2)) + 'e' + a.split('E')[1]



def do_something():
    print('MyFlaskApp is starting up!')
    print("tensorflow ver:")
    import tensorflow as tf
    print(tf.__version__)
    
class MyFlaskApp(Flask):
  def run(self, host=None, port=None, debug=None, load_dotenv=True, **options):
    if not self.debug or os.getenv('WERKZEUG_RUN_MAIN') == 'true':
      with self.app_context():
        do_something()
    super(MyFlaskApp, self).run(host=host, port=port, debug=debug, load_dotenv=load_dotenv, **options)



if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
