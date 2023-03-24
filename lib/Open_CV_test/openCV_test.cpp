#include <opencv2/opencv.hpp>

/*
 This uses Dart FFI  
 The FFI library can only bind against C symbols, so in C++ these symbols must be marked extern C.
 The other attributes that are added prevent the linker from discarding the symbols during link-time optimization.
*/

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int testFunction(int rows, int cols){
    cv::Mat testMat = cv::Mat(rows, cols, CV_8U);
    return testMat.rows+1; 
}