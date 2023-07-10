#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <math.h>
using namespace std;

int main()
{
  srand(1);
  vector <int> fitness (5, nan(" "));
  for (int i=0; i<int(fitness.size()); i++) fitness[i]=rand()%10;
  int sections = 1;
  int genes = 3;
  // vector <int> parent_location (5, nan(" "));
  // for (int i=0; i<int(parent_location.size()); i++) parent_location[i]=rand()%10;
  vector<vector<vector<float>>> dna_input(5, vector<vector<float> >
                                        (sections, vector <float>
                                        (genes, 0.0f)));
  for(int i=0;i<5;i++){
    for (int j=0; j<sections; j++){
      for (int k=0; k<genes; k++) {
        dna_input[i][j][k]=rand()%15;
      }
    }
  }
  


  for (int i=0; i<int(fitness.size()); i++) cout << fitness[i] << " ";
  cout << endl;
  for(int i=0;i<5;i++){
    for (int j=0; j<sections; j++){
      for (int k=0; k<genes; k++) {
        cout << dna_input[i][j][k] << " ";
      }
    }
    cout << endl;
  }
  // for (int i=0; i<int(parent_location.size()); i++) cout << parent_location[i] <<" ";
  // cout << endl;

  int i, j, x, y;
  int size = int(fitness.size()); // size=population=fitness.size()

  // original_location = [0, 1, 2, 3, ..., (population-1) ]
  // vector<int> original_location(size, nan("")); // preallocate memory
  // for (int z=0; z<size; z++) original_location[z]=z;

  for (i=0; i<size; i++)
  {
    double temp = fitness[i];     // used for sorting fitness (high to low)
    // int t = original_location[i]; // i'th individual's original location
                                  // temp <--> TEMPorary <--> t

    vector<vector<vector<float>>> location(1, vector<vector<float> >
                                          (sections, vector <float>
                                          (genes, 0.0f)));
    location[0] = dna_input[i];   // location: a copy of the i'th individual

    // Put dna_input in order
    for (j = i; j > 0 && fitness[j - 1] < temp; j--)
    {
      fitness[j] = fitness[j - 1]; // sorting fitness in order (high to low)
      // parent_location[j] = parent_location[j - 1];
      // for (x = 0; x < sections; x++)
      // {
      //   for (y = 0; y < genes; y++)
      //   {
      dna_input[j] = dna_input[j - 1];
      //   }
      // }
    }
    fitness[j] = temp;
    dna_input[j] = location[0];
    // parent_location[j] = t;

    // Fill in last individual
    // for (int a = 0; a < sections; a++)
    // {
    //   for (int b = 0; b < genes; b++)
    //   {
    //     dna_input[j][a][b] = location[0][a][b];
    //   }
    // }

  }
  cout << "after sorting: \n";
  for (int z=0; z<int(fitness.size()); z++) cout << fitness[z] << " ";
  cout << endl;
  // for (int i=0; i<int(parent_location.size()); i++) cout << parent_location[i] <<" ";
  // cout << endl;
   
  for(int i=0;i<5;i++){
    for (int j=0; j<sections; j++){
      for (int k=0; k<genes; k++) {
        cout << dna_input[i][j][k] << " ";
      }
    }
    cout << endl;
  }
}

