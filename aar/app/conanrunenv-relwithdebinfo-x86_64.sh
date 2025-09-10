script_folder="D:\github\OpenDocument.droid-main\app"
echo "echo Restoring environment" > "$script_folder\deactivate_conanrunenv-relwithdebinfo-x86_64.sh"
for v in PDF2HTMLEX_DATA_DIR POPPLER_DATA_DIR FONTCONFIG_PATH WVDATADIR
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder\deactivate_conanrunenv-relwithdebinfo-x86_64.sh"
    else
        echo unset $v >> "$script_folder\deactivate_conanrunenv-relwithdebinfo-x86_64.sh"
    fi
done


export PDF2HTMLEX_DATA_DIR="C:\Users\PC\.conan2\p\pdf2h86c1174c68f88\p\share\pdf2htmlEX"
export POPPLER_DATA_DIR="C:\Users\PC\.conan2\p\poppl7b8549bdd0928\p\share\poppler"
export FONTCONFIG_PATH="$FONTCONFIG_PATH:C:\Users\PC\.conan2\p\fontc6c455df2369b3\p\res\etc\fonts"
export WVDATADIR="C:\Users\PC\.conan2\p\wvwarb2f91e9c30400\p\share\wv"