#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <cfloat>

using namespace std;

class Point {
    friend istream& operator>>(istream& is, Point& obj);
    friend ostream& operator<<(ostream& os, const Point& obj);
    friend bool compare_x (const Point& lhs, const Point& rhs);
    friend bool compare_y (const Point& lhs, const Point& rhs);
private:
    int x {}, y {};
public:
    Point(int x_val=0, int y_val=0) : x {x_val}, y {y_val} {};
    int get_x() {return this->x;}
    int get_y() {return this->y;}
};

istream& operator>>(istream& is, Point& obj) {
    int temp_x {}, temp_y {};
    cin >> temp_x >> temp_y;
    obj = Point(temp_x, temp_y);
    return is;
}

ostream& operator<<(ostream& os, const Point& obj) {
    os << obj.x << ' ' << obj.y;
    return os;
}

void display(vector<Point>& vec) {
    for (Point& a : vec)
        cout << a << endl;
}

/* ===========================================================================================
**                                                                                          **
**                                                                                          **
**                                                                                          **
**                                                                                          **
**                                                                                          **
============================================================================================*/

bool compare_x(const Point& lhs, const Point& rhs) {
    return lhs.x < rhs.x;
}

bool compare_y(const Point& lhs, const Point& rhs) {
    return lhs.y < rhs.y;
}

double cal_distance(Point&, Point&);

double brute_force(vector<Point>& vec_point) {
    double m = MAXFLOAT;
    for (size_t i{}; i<vec_point.size(); i++) {
        for (size_t j{i+1}; j<vec_point.size(); j++) {
            double temp =  cal_distance(vec_point[i], vec_point[j]);
            m = m < temp ? m : temp;
        }
    }
    return m;
}

double cal_distance(Point& p1, Point& p2) {
    return sqrt(pow((p1.get_x() - p2.get_x()), 2) + pow((p1.get_y() - p2.get_y()), 2)); 
}

double strip_closest(vector<Point>& strip, int size, double d) {
    double m = d;

    for(size_t i{}; i<size; i++) {
        for(size_t j{i+1}; j<size && (abs(strip[j].get_y() - strip[i].get_y()) < m); j++) {
            m =  cal_distance(strip[i], strip[j]);
        }
    }
    return m;
}

typedef vector<Point>::iterator vec_iter;

double closest_point_util(vector<Point>& vec_point, vec_iter s, vec_iter e) {
    int n = e-s;
    if (n <= 3)
        return brute_force(vec_point);

    int mid = n/2;
    Point mid_point = vec_point[mid];

    double dl = closest_point_util(vec_point, s, vec_point.begin()+mid);
    double dr = closest_point_util(vec_point, vec_point.begin()+mid, e);

    float d = dl < dr ? dl : dr; 

    vector<Point> strip;
    int j {};
    for(int i{}; i<n; i++) {
        if (abs(vec_point[i].get_x() - mid_point.get_x()) < d) {
            strip.push_back(vec_point[i]);
            j++;
        }
    }
    double temp = strip_closest(strip, j, d);
    return d < temp ? d : temp; 
}

double closest_point(vector<Point>& vec_point) {
    sort(vec_point.begin(), vec_point.end(), compare_x);
    display(vec_point);
    return closest_point_util(vec_point, vec_point.begin(), vec_point.end()); 
}

int main() {
    int n {11};
    // cin >> n;
 
    vector<Point> vec_point (n); 
    // Point temp_point;

    // for(int i{}; i<n; i++) {
    //     cin >> temp_point;
    //     vec_point[i] = temp_point;
    // }
    vec_point[0] = Point(4, 4);
    vec_point[1] = Point(-2, -2);
    vec_point[2] = Point(-3, -4);
    vec_point[3] = Point(-1, 3);
    vec_point[4] = Point(2, 3);
    vec_point[5] = Point(-4, 0);
    vec_point[6] = Point(1, 1);
    vec_point[7] = Point(-1, -1);
    vec_point[8] = Point(3, -1);
    vec_point[9] = Point(-4, 2);
    vec_point[10] = Point(-2, 4);

    sort(vec_point.begin(), vec_point.end(), compare_y);
    cout << closest_point(vec_point);
    return 0;
}
