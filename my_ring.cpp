#include <iostream>
#include <mpi.h>

using namespace std;

void ring(int rank, int size);

int main(int argc, char*argv[]){
	int rank, size;
	MPI_Init ( &argc, &argv );
	MPI_Comm_size ( MPI_COMM_WORLD, &size );
  	MPI_Comm_rank ( MPI_COMM_WORLD, &rank );
	
  	ring(rank, size);

  	MPI_Finalize();

	return 0;
  	
}

void ring(int rank, int size){
	
	int left, right, msg_left, msg_right, msg_counter;
	int buf[2]; // buf[0] = buf_right buf[1] = buf_left
	MPI_Status status_add, status_sub;

	left = rank -1;
  	right = rank + 1;

  	if((rank+1) == size) 	right = 0;
  	if(rank == 0) 		left = size - 1;

	msg_left = 0; 
	msg_right = 0; 
	msg_counter = 0;
	
	// as first step P sends a message ( msgleft = rank ) to its left neighbour (P-1) 
	// and receives from its right neighbour (P+1) 
	// and send aother message ( msgright = -rank) to P+1 
	// and receive from P-1.
	//
	// it then does enough iterations till all processors receive back the initial messages. 
	// At each iteration each processor add its rank to the received message if it comes from left, substracting if it comes from right. 
	// Both messages originating from a certain processor P should have a tag proportional to its rank (i.e. itag=P*10) 

	int itag = rank*10;

	for(int i = 0; i < size; i++){
		
		msg_left = msg_left + rank;
		MPI_Send(&msg_left, 1, MPI_INT, left, itag, MPI_COMM_WORLD);
		MPI_Recv(&msg_left, 1, MPI_INT, right, right * 10, MPI_COMM_WORLD, 
				&status_add);
		msg_counter++;

		msg_right = msg_right - rank;
		MPI_Send(&msg_right, 1, MPI_INT, right, itag, MPI_COMM_WORLD);
		MPI_Recv(&msg_right, 1, MPI_INT, left, left * 10, MPI_COMM_WORLD, 
				&status_sub);
		msg_counter++;
	}

	cout << "I am process: " << rank << " I received " << msg_counter << " messagges. My final messagges have tag " << itag
	 	<< " process with value: " << msg_left << " left, " << msg_right << " right. " << endl;   	

}
