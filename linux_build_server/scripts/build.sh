cd ~/work/SpringBootSample2023
if [ $? -ne 0 ]; then
  echo "work directory not found."
  exit 1
fi

mvn clean package

exit $?