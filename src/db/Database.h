#pragma once
#include <sqlite3.h>
#include <string>
class Database {
public:
    explicit Database(const std::string& path);
    ~Database();
    void execute(const std::string& sql);
    Database(const Database& other) = delete;
    Database& operator=(const Database& other) = delete;
private:
    sqlite3* db_;
};
