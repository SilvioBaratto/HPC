#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

void ring(int rank, int nproc);

int main(int argc, char *argv[]){
	int rank, nproc;
	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &nproc);
	
	ring(rank,nproc);
	MPI_Finalize();
	return 0;
}

void ring(int rank, int nproc){
	//const int one[1] = {1};
	//int neighbors[2];
	int left, right;
	const int one[1] = {1}; 	

	MPI_Comm  COMM;
	MPI_Status status_add, status_sub;

	//int ret = MPI_Cart_create(MPI_COMM_WORLD, 1, &nproc, one, 1, &ring_comm);
	int cart = MPI_Cart_create(MPI_COMM_WORLD, 1, &nproc, one, 1, &COMM);
	if (cart) {
		perror("MPI_Cart_create()");
		MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
	}
	//neighbour[1] = right
	//neightbour[0] = left
	/*
	if((rank+1) == size)    right = 0;
        if(rank == 0)           left = size - 1;
	*/
	
	MPI_Cart_shift(COMM, 0, 1, &left, &right);
	MPI_Comm_rank(COMM, &rank);
	int msg_left = 0, msg_right = 0;
	int msg_counter = 0;
	int itag = rank*10;

	if (rank == 0) {
		int add, sub;
		for (int i = 0; i < nproc; i++) {
			add = msg_left;
			MPI_Recv(&msg_left, 1, MPI_INT, right, right*10, COMM, &status_add);
			msg_counter++;
			MPI_Send(&add, 1, MPI_INT, left, itag, COMM);

			sub = msg_right;
			MPI_Recv(&msg_right, 1, MPI_INT, left, left*10, COMM, &status_sub);
			msg_counter++;
			MPI_Send(&sub, 1, MPI_INT, right, itag, COMM);
		}
	} else {
		for (int i = 0; i < nproc; i++) {
			msg_left = msg_left + rank;
			MPI_Send(&msg_left, 1, MPI_INT, left, itag, COMM);
			MPI_Recv(&msg_left, 1, MPI_INT, right, right*10, COMM, &status_add);
			msg_counter++;

			msg_right = msg_right - rank;
			MPI_Send(&msg_right, 1, MPI_INT, right, itag, COMM);
			MPI_Recv(&msg_right, 1, MPI_INT, left, left*10, COMM, &status_sub);
			msg_counter++;
		}
	}


	// I am process irank and i have received np messages. My final messages have tag itag and value msg-left,msg-right
	
	printf("I am process %d and I have received %d messagges. My final messagges have tag %d and value %d (msg_left), %d (msg_right)\n",
		rank, msg_counter, itag, msg_left, msg_right);
	
	//printf("I am process %d and I have received %d messages. ", rank, received);
	//printf("My final messages have got tag %d (from the right) and %d (from the left), and values %d (from the right) and %d (from the left)\n",
	//	status_add.MPI_TAG, status_subtract.MPI_TAG, payload_add, payload_subtract);
}


