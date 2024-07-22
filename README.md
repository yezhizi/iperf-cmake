# iperf-cmake
Enhanced CMake Support for [iperf3](https://github.com/esnet/iperf)

This project forks from [icpz/iperf-cmake](https://github.com/icpz/iperf-cmake).
We have added detailed documentation to the README.md file， and fixed some bugs.

## Usage
```bash
mkdir build
cd build
cmake ..
cmake --build .
```

If you wish to use [iperf3](https://github.com/esnet/iperf) as a dependency in your project, you can refer to the following code and add it to your `CMakeLists.txt`:

```cmake
add_executable(your_project_name main.cc)
target_link_libraries(your_project_name iperf)
target_precompile_headers(your_project_name PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/iperf-cmake/iperf_config.h)
```
