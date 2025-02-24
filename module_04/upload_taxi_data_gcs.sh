#!/bin/bash

years=("2019" "2020")
months=("01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12")
datasets=("fhv")
base_path=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/
# green_tripdata_path=${base_path}/green
# yellow_tripdata_path=${base_path}/yellow
# fhv_tripdata_path=${base_path}/fhv

for year in "${years[@]}"; do
    for month in "${months[@]}"; do
        echo "processing ${year}-${month} data..."
        for dataset in "${datasets[@]}"; do
        
            trip_data_file=${dataset}_tripdata_${year}-${month}.csv
            wget ${base_path}/${dataset}/${trip_data_file}.gz
            gunzip ${trip_data_file}.gz
            gcloud storage cp ${trip_data_file} gs://zoomcamp-misc/${dataset}_tripdata/${year}/${trip_data_file}
            rm ${trip_data_file}
        done
    done
done

