#!/bin/sh
npm start --prefix frontend &
uvicorn backend.main:app --host 0.0.0.0 --port 4000 &
#uvicorn backend.main:app --port 4000 &
wait