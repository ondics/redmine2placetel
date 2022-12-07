#
# Redmine contact export to csv
# used for Placetel phone service
#
#https://licenciaparahackear.github.io/en/posts/filtrando-mis-contactos-del-celular-con-awk/
#

function processPhone(line,pattern)
{
    phone = substr(line,length(pattern)+1)
    gsub(/[ \t\/-]*|\(|\)/,"",phone)
    gsub(/\(0\)/,"",phone)
    if (match(phone,/^0[1-9]/))
        sub(/^0/,"+49",phone)
    return phone
}

BEGIN {
    print "Name|Phone|Mobile"
    num=numSkipped=numCoverted=0
}

{
    vcfField[$1] = $2;
}

/^N:/ {
    name =  substr($0,length("N:")+1)
    split(name,matches,";")
    name = matches[1] ", " matches[2]
}
/^ORG:/ {
    firma =  substr($0,length("ORG:")+1)
}

/^TEL:Arbeit:/ {
    telArbeit = processPhone($0,"TEL:Arbeit:")
}

/^TEL:[^A-Za-z ]{3}/ {
    telArbeit = processPhone($0,"TEL:")
}

/^TEL:Tel:/ {
    telArbeit = processPhone($0,"TEL:Tel:")
}

/^TEL:Mobil:/ {
    telMobil = processPhone($0,"TEL:Mobil:")
}



/^END:VCARD/ {
    num++
    if (telArbeit == "" && telMobil == "") {
        print "SKIPPING " name > "/dev/stderr"
        numSkipped++
        next
    }
    printf("%s (%s)|%s|%s\n",name,firma,telArbeit,telMobil)
    numConverted++
    name=firma=telArbeit=telMobil=tel=""
}

END {
    print "Ready. " > "/dev/stderr"
    print "processed: " num > "/dev/stderr"
    print "converted: " numConverted > "/dev/stderr"
    print "skipped: " numSkipped > "/dev/stderr"
}

