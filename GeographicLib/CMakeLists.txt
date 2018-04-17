cmake_minimum_required (VERSION 2.6)
project (Tutorial)

find_package (GeographicLib 1.49 REQUIRED)

include_directories(SYSTEM
    ${GeographicLib_INCLUDE_DIRS})

# add the executable
add_executable(Tutorial main.cpp)

target_link_libraries(${PROJECT_NAME}
    ${GeographicLib_LIBRARIES})
 
