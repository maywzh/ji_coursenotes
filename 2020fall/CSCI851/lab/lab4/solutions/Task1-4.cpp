// Check for memory leaks with bcheck ./filename
int main() {
    int *p;
    p = new int(5);
    // delete p;
    
    return 0;
}
