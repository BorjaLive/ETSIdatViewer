#include <iostream>
#include <cstdlib>
#include <fstream>

using namespace std;

struct Sfecha{
    int dia;
    int mes;
    int anno;
};
struct producto{
    Sfecha ultimaventa;
    int unidades;
    int producto;
    float importe;
    int tipo;
    char nombre[20];
};

typedef char cadena[20];
const cadena TIPO_PRODUCTO[3] = {"Electronica","Papeleria","Otros"};

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

    cout << "-------------->LISTA DE PRODUCTOS<--------------\n\n";
    producto p;
    int i = 1;
    while(file.read((char *) &p, sizeof(producto)) && !file.eof()){
        cout << "Producto: " << p.nombre <<"\n"
             << "Ultima Venta: " << p.ultimaventa.dia <<"/"<< p.ultimaventa.mes <<"/"<< p.ultimaventa.anno <<"\n"
             << "Importe: " << p.importe <<"\n"
             << "Unidades: " << p.unidades <<"\n"
             << "ID: " << i <<"\n"
             << "Tipo producto: " << TIPO_PRODUCTO[p.tipo-1] <<"\n"
             << "______________________________________________\n\n";
        i++;
    }

    system("pause");
    return 0;
}
