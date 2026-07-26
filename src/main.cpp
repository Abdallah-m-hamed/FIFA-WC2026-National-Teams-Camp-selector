#include <sqlite3.h>
#include <iostream>
int main() {
    std::cout << sqlite3_libversion() << std::endl;
    return 0;
}
