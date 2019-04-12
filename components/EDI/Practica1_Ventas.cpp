#include <iostream>
#include <cstdlib>
#include <fstream>

using namespace std;

struct Sfecha{
    int dia;
    int mes;
    int anno;
};
struct venta{
    Sfecha fecha;
    int unidades;
    int producto;
    float importe;
};

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

    cout << "-------------->LISTA DE VENTAS<--------------\n\n";
    venta v;
    while(file.read((char *) &v, sizeof(venta)) && !file.eof()){
        cout << "Fecha de venta: " << v.fecha.dia <<"/"<< v.fecha.mes <<"/"<< v.fecha.anno <<"\n"
             << "Producto: " << v.producto <<"\n"
             << "Unidades: " << v.unidades <<"\n"
             << "Importe: " << v.importe <<"\n"
             << "______________________________________________\n\n";
    }

    system("pause");
    return 0;
}
