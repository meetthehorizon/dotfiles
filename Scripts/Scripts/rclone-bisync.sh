#!/bin/bash

set -e
rclone bisync ~/Documents/conart onedrive:Documents/conart
rclone bisync ~/Pictures onedrive:Pictures
