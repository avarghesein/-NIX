cmake_minimum_required(VERSION 3.0.0)
project(FaceDetect VERSION 0.1.0)
# specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

include_directories(.)

find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )
add_executable( FaceDetect FaceDetect.cpp )
target_link_libraries( FaceDetect ${OpenCV_LIBS} )