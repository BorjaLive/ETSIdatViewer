#include <iostream>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <fstream>

using namespace std;

typedef char cadena[50];

struct cliente{
    cadena Apellidos;
    cadena Nombre;
    int Edad;
    int TipoServicio;
    int HoraLlegada; //almacenada en minutos
};

struct peluquerof{
    int Codigo;
    cadena Apellidos;
    cadena Nombre;
    int TipoServicio;
};

void printn(char c, int n){
    for(int i = 0; i < n; i++)
        cout << c;
}
int main(int argc, char** argv){
    if(argc < 2){
        cerr << "Se necesita un parametro.\n";
        return 1;
    }

    ifstream file(argv[1], ios::binary);
    //ifstream file("C:\\Users\\Arlin-T2\\Desktop\\ETSIcode\\ED1\\Practica 2\\inicial.dat", ios::binary);
    if(file.fail()){
        cerr << "Error al abrir el archivo.\n";
        return 2;
    }

    int nPeluqueros, nClientes;
    peluquerof pfTMP;
    cliente cTMP;
    cadena nTMP;

    file.read((char *) &nPeluqueros, sizeof(int));
    cout << "\n";
    printn(32,5); printn(201,1); printn(205,68); printn(187,1); cout << "\n";
    printn(32,5); printn(186,1); printn(32,29); cout << "Peluqueros"; printn(32,29); printn(186,1);  cout << "\n";
    for(int i = 0; i < nPeluqueros; i++){
        file.read((char *) &pfTMP, sizeof(pfTMP));

        printn(32,5); printn(204,1);printn(205,68);printn(185,1); cout << "\n";
        strcpy(nTMP, pfTMP.Apellidos);
        strcat(nTMP, ", ");
        strcat(nTMP, pfTMP.Nombre);
        printn(32,5); printn(186,1); cout << " Peluquero " << right << setw(2) << pfTMP.Codigo << ": " << setw(31) << left << nTMP << "Tipo de servicio: " << pfTMP.TipoServicio << "   "; printn(186,1); cout << "\n";
    }
    printn(32,5); printn(200,1); printn(205,68); printn(188,1); cout << "\n\n";

    file.read((char *) &nClientes, sizeof(int));

    printn(32,5); printn(201,1); printn(205,68); printn(187,1); cout << "\n";
    printn(32,5); printn(186,1); printn(32,30); cout << "Clientes"; printn(32,30); printn(186,1);  cout << "\n";
    printn(32,5); printn(186,1); printn(32,68); printn(186,1);  cout << "\n";
    printn(32,5); printn(186,1); cout << setw(30) << "  Apellidos y nombre" <<"  "<< setw(10) << "Edad" <<"   "<< setw(10) << "Servicio" <<"   "<< setw(10) << "Llegada   "; printn(186,1); cout << "\n";
    for(int i = 0; i < nClientes; i++){
        file.read((char *) &cTMP, sizeof(cTMP));


        strcpy(nTMP, cTMP.Apellidos);
        strcat(nTMP, ", ");
        strcat(nTMP, cTMP.Nombre);
        printn(32,5); printn(204,1);printn(205,68);printn(185,1); cout << "\n";
        printn(32,5); printn(186,1); cout << "  " << setw(30) << nTMP <<" "<< setw(2) << cTMP.Edad <<"             "<< setw(1) << cTMP.TipoServicio <<"          "<< setw(2) << (cTMP.HoraLlegada/60) << ":" << setw(2) << setfill('0') << (cTMP.HoraLlegada%60) << "    " << setfill(' '); printn(186,1); cout << "\n";
    }
    printn(32,5); printn(200,1); printn(205,68); printn(188,1); cout << "\n\n";



    system("pause");
    return 0;
}
