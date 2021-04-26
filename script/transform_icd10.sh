#!/bin/bash
cp $1 $2

sed 's/./\t/6;' $2 >${2}_tmp && rm $2 && mv ${2}_tmp $2
sed 's/./\t/14;' $2 >${2}_tmp && rm $2 && mv ${2}_tmp $2
sed 's/./\t/16;' $2 >${2}_tmp && rm $2 && mv ${2}_tmp $2
sed 's/./\t/77;' $2 >${2}_tmp && rm $2 && mv ${2}_tmp $2

jq -rRs '{"data": split("\n")[1:-1] |
         map([split("\t")[]|split(",")] | {
                 "order_number":(.[0] | join("")),
                 "icd_code":(.[1] | join("")),
                 "hipaa_covered":(.[2] | join("") | tonumber),
                 "short_description":(.[3] | join("") | until(endswith(" ")|not; rtrimstr(" ")) ),
                 "long_description":(.[4] | join("") | rtrimstr("\r"))
             })}' $2 >${2}_tmp && rm $2 && mv ${2}_tmp $2
