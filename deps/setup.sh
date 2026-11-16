set -e
cd "$(dirname "$0")/../deps/"

[ -e "relo" ] ||
git clone https://github.com/tst2005sh/relo

[ -e "muta" ] ||
git clone https://github.com/tst2005sh/muta
