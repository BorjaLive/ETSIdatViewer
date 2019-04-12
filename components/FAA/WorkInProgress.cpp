#include <iostream>
#include <cstdlib>
#include <fstream>

using namespace std;

int main(int argc, char** argv){
    if(argc < 2){
        cerr << "Se necesita un parametro.\n";
        return 1;
    }

    ifstream file(argv[1], ios::binary);
    if(file.fail()){
        cerr << "Error al abrir el archivo.\n";
        return 2;
    }



    system("pause");
    return 0;
}
