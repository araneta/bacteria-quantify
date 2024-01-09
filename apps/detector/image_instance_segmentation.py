import cv2
import os
#from imread_from_url import imread_from_url
from PIL import Image
import numpy as np

from yoloseg import YOLOSeg

# Initialize YOLOv5 Instance Segmentator
# wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1yV6VUmG8LVGub9ICwQLLLj9i4oYIs8hv' -O best3.onnx
# scp best3.onnx root@app.amelaris.com:/home/amelaris/algae/algae/models/
model_path = "models/best3.onnx"
yoloseg = YOLOSeg(model_path, conf_thres=0.5, iou_thres=0.3)
IMAGE_DIR = "./images/"
# Read image
#img_url = "https://upload.wikimedia.org/wikipedia/commons/e/e6/Giraffes_at_west_midlands_safari_park.jpg"
#img = imread_from_url(img_url)
img = "c33_PNG_jpg.rf.0b443f79c46bb08398129118cd4af56a.jpg"
img_path = os.path.join(IMAGE_DIR,img)
image = Image.open(img_path)
img = cv2.cvtColor(np.array(image, dtype=np.uint8), cv2.COLOR_RGB2BGR)


# Detect Objects
boxes, scores, class_ids, masks = yoloseg(img)

# Draw detections
combined_img = yoloseg.draw_masks(img)
# img = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
id = "1"
outputfile = os.path.join(IMAGE_DIR,id)+".out.jpg"
cv2.imwrite(outputfile, combined_img)

#cv2.namedWindow("Detected Objects", cv2.WINDOW_NORMAL)
#cv2.imshow("Detected Objects", combined_img)
#cv2.imwrite("doc/img/detected_objects.jpg", combined_img)
#cv2.waitKey(0)
