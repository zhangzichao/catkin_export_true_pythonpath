cmake_minimum_required(VERSION 2.8.3)
project(catkin_export_true_pythonpath)

find_package(catkin_simple REQUIRED)

catkin_simple()

catkin_add_env_hooks(export_all SHELLS sh DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

cs_install()
cs_export()
