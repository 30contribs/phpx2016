#!/usr/bin/env bash
: "${_30CONTRIBS_PHPX_GITHUB_USER:?Need to set _30CONTRIBS_PHPX_GITHUB_USER non-empty}"
: "${_30CONTRIBS_PHPX_GITHUB_TOKEN:?Need to set _30CONTRIBS_PHPX_GITHUB_TOKEN non-empty}"
: "${_30CONTRIBS_PHPX_CONTRIBUTORS:?Need to set _30CONTRIBS_PHPX_CONTRIBUTORS non-empty}"

CONTADOR=0
VALIDO=0
SOMA=0
for contribuidor in $_30CONTRIBS_PHPX_CONTRIBUTORS;
do
    # echo $contribuidor
    url="https://api.github.com/search/issues?q=author:${contribuidor}+type:pr+created:2016-03-01T00:00:00-03:00..2016-03-13T23:59:59-03:00"
    #echo $url
    #echo curl -Ss -i -H 'Authorization: token $GITHUB_TOKEN' $url | jq '.total_count'
    contribs=`curl -Ss -u $_30CONTRIBS_PHPX_GITHUB_USER:$_30CONTRIBS_PHPX_GITHUB_TOKEN $url | jq '.total_count'`
    echo "$contribuidor, $contribs"
    # sleep 1
    CONTADOR=$(($CONTADOR + 1))
    if [ $contribs -gt 0 ]; then
        VALIDO=$(($VALIDO + 1))
    fi
    SOMA=$(($SOMA + $contribs))
done
echo "==================="
echo "TOTAL CONTRIBUIDORES = $CONTADOR"
echo "TOTAL VALIDO = $VALIDO"
echo "TOTAL CONTRIBUICOES = $SOMA"


