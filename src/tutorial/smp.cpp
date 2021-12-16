#include "seastar/core/app-template.hh"
#include "seastar/core/reactor.hh"
#include "iostream"

using namespace std;
using namespace seastar;

int main(int argc, char** argv) {
    app_template app;
    app.run(argc, argv, [] {
        cout << "smp::count = " << smp::count << "\n";
        return make_ready_future<>();
    })
    return 0;
}