cmake_minimum_required(VERSION 2.8)
project(KNNL)

set(BOOST_ROOT "C://Programs//boost_1_60_0")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

set(KNNL_BINARY_DIR "./bin")

include_directories(./include ${BOOST_ROOT}/)
link_directories(${BOOST_ROOT}//stage//lib)

set(SOURCE_FILES
    include/basic_activation_function.hpp
    include/basic_neuron.hpp
    include/basic_neuron_fun_spec.hpp
    include/basic_weak_distance_function.hpp
    include/data_parser.hpp
    include/debugger.hpp
    include/euclidean_distance_function.hpp
    include/functors.hpp
    include/generalized_training_weight.hpp
    include/kohonen_network.hpp
    include/max_type.hpp
    include/neural_net_headers.hpp
    include/numeric_iterator.hpp
    include/operators.hpp
    include/print_network.hpp
    include/randomize_policy.hpp
    include/ranges.hpp
    include/rectangular_container.hpp
    include/std_headers.hpp
    include/training_functional.hpp
    include/value_type.hpp
    include/weighted_euclidean_distance_function.hpp
    include/wta_training_algorithm.hpp
    include/wtm_topology.hpp
    include/wtm_training_algorithm.hpp
    source/configuration.cpp
    source/configuration.hpp
    source/main.cpp)

#link_directories(${BOOST_ROOT}/)

#link_libraries()

add_executable(KNNL ${SOURCE_FILES})
