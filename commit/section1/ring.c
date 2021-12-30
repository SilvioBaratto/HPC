#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

void ring(int rank, int nproc, FILE *fptr);

int main(int argc, char *argv[]){
	FILE *fptr;
	int rank, nproc;
	fptr = fopen("./times.csv", "a");
	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &nproc);
	
	ring(rank, nproc, fptr);
	
	fclose(fptr);
	MPI_Finalize();
	return 0;
}

void ring(int rank, int nproc, FILE *fptr){

	int left, right;
	const int one[1] = {1}; 	
	int n_run = 100000;
	MPI_Comm  COMM;
	MPI_Status status_add, status_sub;

	int cart = MPI_Cart_create(MPI_COMM_WORLD, 1, &nproc, one, 1, &COMM);
	if (cart) {
		perror("MPI_Cart_create()");
		MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
	}
	
	MPI_Cart_shift(COMM, 0, 1, &left, &right);
	MPI_Comm_rank(COMM, &rank);
	int msg_left = 0, msg_right = 0;
	int msg_counter = 0;
	int itag = rank*10;
        double start_time, elapsed_time, time, sum_time;

	for(int run; run < n_run; run++){
		start_time = MPI_Wtime();
		for(int i = 0; i < nproc; i++){
			if (rank == 0) {
				int add, sub;
				add = msg_left;
				MPI_Recv(&msg_left, 1, MPI_INT, right, right*10, COMM, &status_add);
				msg_counter++;
				MPI_Send(&add, 1, MPI_INT, left, itag, COMM);

				sub = msg_right;
				MPI_Recv(&msg_right, 1, MPI_INT, left, left*10, COMM, &status_sub);
				msg_counter++;
				MPI_Send(&sub, 1, MPI_INT, right, itag, COMM);
			} else {
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
	
		elapsed_time=MPI_Wtime();
		time = elapsed_time - start_time;
		sum_time += time;
		
	}
	if(rank == 0){
		fprintf(fptr, "%10.8f, %d\n", sum_time/n_run, nproc);
	}
	printf("I am process %d and I have received %d messagges. My final messagges have tag %d and value %d (msg_left), %d (msg_right)\n", rank, msg_counter/n_run, itag, msg_left/n_run, msg_right/n_run);
	
}



