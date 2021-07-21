
#include <opencv2/objdetect.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>

using namespace std;
using namespace cv;

void DetectFaceAndShow( Mat& frame, CascadeClassifier& cascade, double scale)
{
    vector<Rect> detectedFaces;
    Mat grayImage;
    cvtColor( frame, grayImage, COLOR_BGR2GRAY );

    cascade.detectMultiScale( grayImage, detectedFaces, 1.1, 2, 0|CASCADE_SCALE_IMAGE, Size(40, 40) );

    for ( size_t idx = 0; idx < detectedFaces.size(); idx++ )
    {
        Rect r = detectedFaces[idx];
        Scalar color = Scalar(255, 0, 0);

        rectangle( frame, 
        cvPoint(cvRound(r.x*scale), cvRound(r.y*scale)), 
        cvPoint(cvRound((r.x + r.width-1)*scale), cvRound((r.y + r.height-1)*scale)),
        color, 3, 8, 0);
    }

    imshow( "Faces", frame );
}

int main(int argc, char** argv )
{
    Mat frame;
    CascadeClassifier cascade; 
    double scale=1;

    std::string basePath = "/media/TMP-DSK/HOME/FaceDetect/";
    // Load the cascade classifier
    cascade.load( basePath + "haarcascade_frontalface_default.xml" );
    frame = imread(basePath + "FindFaces.jpg", CV_LOAD_IMAGE_COLOR);

    DetectFaceAndShow( frame, cascade, scale );

    waitKey(0);
    return 0;
}