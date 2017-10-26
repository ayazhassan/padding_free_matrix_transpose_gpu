SRC = transpose.cu 
OBJ = $(SRC:.cu=.cu_o) 
LIBCUDA = /usr/lib64/libcuda.so 
LIBCUDART = /usr/local/cuda/lib64/libcudart.so 
LIBCUTIL = /usr/local/nvidia/C/lib/libcutil.a 
CUPTI_LIB = /usr/local/cuda/CUDAToolsSDK/CUPTI/lib/libcupti.so 

TARGET = transpose

all : $(TARGET) 

%.cu_o: %.cu
	nvcc -c -Xptxas -v $(INC) $< -g -G -gencode arch=compute_20,code=sm_20 -o $@

$(TARGET): $(OBJ) $(LIBCUDA) $(LIBCUDART) $(LIBCUTIL) $(PAPI_LIB) $(CUPTI_LIB)
	g++ $(OBJ) $(LIBCUDA) $(LIBCUDART) $(LIBCUTIL) $(PAPI_LIB) $(CUPTI_LIB) -o $(TARGET)
