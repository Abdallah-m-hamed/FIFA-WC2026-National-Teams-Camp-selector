cmake_minimum_required(VERSION 3.20)
project(FIFA-WC2026-National-Teams-Camp-selector)
add_executable(build_check src/main.cpp src/db/Database.cpp)
target_link_libraries(build_check sqlite3)
