#include <boost/lambda/lambda.hpp>
#include <boost/version.hpp>
#include <iostream>

int main() {
    typedef std::istream_iterator<int> in;

    std::cout << "boost version: " << BOOST_VERSION / 100000 << "."
              << BOOST_VERSION / 100 % 1000 << "."
              << BOOST_VERSION % 100
              << std::endl;
    std::cout << "Type in any number: ";

    std::for_each(
            in(std::cin), in(), std::cout
                    << (boost::lambda::_1 * 10)
                    << "\nType in another number: ");
}