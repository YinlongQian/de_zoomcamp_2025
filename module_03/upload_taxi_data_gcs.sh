#!/bin/bash

months=("02" "03" "04" "05" "06")
for month in "${months[@]}"; do
    trip_data_parquet_file=yellow_tripdata_2024-${month}.parquet
    echo "processing ${trip_data_parquet_file}"

    wget https://d37ci6vzurychx.cloudfront.net/trip-data/${trip_data_parquet_file}
    gcloud storage cp ${trip_data_parquet_file} gs://zoomcamp-misc/yellow_trip_data/2024/${trip_data_parquet_file}
    rm ${trip_data_parquet_file}
done

