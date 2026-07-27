#include "Database.h"
#include <stdexcept>
Database::Database(const std::string& path) {
    int status = sqlite3_open(path.c_str(), &db_);
    if (status != SQLITE_OK) {
        throw std::runtime_error("Failed to open database: " + path);
    }
}
Database::~Database() {
    sqlite3_close(db_);
}
void Database::execute(const std::string& sql) {
    char* errorMessage = nullptr;
    int status = sqlite3_exec(db_, sql.c_str(), nullptr, nullptr, &errorMessage);
    if (status != SQLITE_OK) {
        std::string message = "Failed to execute SQL: " + std::string(errorMessage);
        sqlite3_free(errorMessage);
        throw std::runtime_error(message);
    }
}
