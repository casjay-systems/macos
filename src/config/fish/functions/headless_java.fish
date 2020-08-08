function headless_java -d "Put Java into headless mode"
    echo "Changing _JAVA_OPTIONS"
    echo "from: $_JAVA_OPTIONS"
    set -g -x _JAVA_OPTIONS "-Djava.awt.headless=true"
    echo "  to: $_JAVA_OPTIONS"
end
