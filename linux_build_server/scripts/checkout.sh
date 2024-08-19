cd ~/work
if [ $? -ne 0 ]; then
  echo "work directory not found."
  exit 1
fi

rm -rf SpringBootSample2023
if [ $? -ne 0 ]; then
  echo "remove work directory error."
  exit 1
fi


git clone https://github.com/Satoshi-Tb/SpringBootSample2023.git

exit $?