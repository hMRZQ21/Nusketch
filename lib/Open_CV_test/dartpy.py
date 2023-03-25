import cv2
import numpy as np
from PIL import Image
import io


def pymultiply(a, b): return a*b

# def create_sketch_image(grayscale_path, inverted_path):
#     grey_img = cv2.imread(grayscale_path, 0)
#     invblur_img = cv2.imread(inverted_path, 0)

#     sketch_img = cv2.divide(grey_img, invblur_img, scale=256.0)

#     # Convert NumPy array to PIL Image
#     sketch_img = Image.fromarray(sketch_img)

#     # Convert PIL Image to bytes
#     with io.BytesIO() as output:
#         sketch_img.save(output, format='PNG')
#         contents = output.getvalue()

#     # Return bytes
#     return contents