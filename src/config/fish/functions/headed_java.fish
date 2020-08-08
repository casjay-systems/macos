function headed_java -d "Put Java into headed mode"
    echo "Changing _JAVA_OPTIONS"
    echo "from: $_JAVA_OPTIONS"
    set -g -e _JAVA_OPTIONS
    echo "  to: $_JAVA_OPTIONS"
end
