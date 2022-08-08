port=$(cat $1|grep brokers\ =|cut -d":" -f2|cut -d"'" -f1)
newbrokers="      brokers = {'ganymed.ffnef.de:$port','kallisto.ffnef.de:$port','amalthea.ffnef.de:$port','himalia.ffnef.de:$port','elara.ffnef.de:$port','pasophae.ffnef.de:$port'},"
echo newbrokers: $newbrokers
sed -i -e "s/.*brokers\ =.*/$newbrokers/g" $1
                                                                                                                                                       