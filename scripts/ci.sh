#!/bin/bash
set -e

echo "=== 1. Testing and Analyzing packages/dose_engine ==="
cd packages/dose_engine
dart pub get
dart analyze --fatal-infos
dart test --coverage=coverage

echo "=== 2. Testing and Analyzing apps/mobile ==="
cd ../../apps/mobile
flutter pub get
flutter analyze
flutter test

echo "=== All checks passed successfully! ==="
