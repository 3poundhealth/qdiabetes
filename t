#!/bin/bash -e

trap 'echo -e "];Failed: $OP\a\n[32m$OP[31m failed[\n35m"; cat diff.out; echo -e "[0m"' int term exit

rm -f *.out

OP="qdiabetes male build"
gcc -I. utils.c Q68_qdiabetes_2013_1_1.c Q68_qdiabetes_2013_1_1_commandLine.c -o qdiabetesm > diff.out

OP="qdiabetes female build"
gcc -I. utils.c Q68_qdiabetes_2013_1_0.c Q68_qdiabetes_2013_1_0_commandLine.c -o qdiabetesf > diff.out

#male tests

OP="male base options all booleans true"
qdiabetesm 25 1 1 1 25 1 1 0 10 0 1 > c.out || true #age b_corticosteroids b_cvd b_treatedhyp bmi ethrisk fh_diab smoke_cat surv town debug
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male age test"
qdiabetesm 84 1 1 1 25 1 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 84, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ex smoker"
qdiabetesm 25 1 1 1 25 1 1 1 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :ex, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male light smoker"
qdiabetesm 25 1 1 1 25 1 1 2 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :light, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male moderate smoker"
qdiabetesm 25 1 1 1 25 1 1 3 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :moderate, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male heavy smoker"
qdiabetesm 25 1 1 1 25 1 1 4 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :heavy, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity white"
qdiabetesm 25 1 1 1 25 1 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity indian"
qdiabetesm 25 1 1 1 25 2 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :indian, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity pakistani"
qdiabetesm 25 1 1 1 25 3 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :pakistani, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity bangladeshi"
qdiabetesm 25 1 1 1 25 4 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :bangladeshi, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity other_asian"
qdiabetesm 25 1 1 1 25 5 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :other_asian, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity black_caribbean"
qdiabetesm 25 1 1 1 25 6 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :black_caribbean, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity black_african"
qdiabetesm 25 1 1 1 25 7 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :black_african, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity chinese"
qdiabetesm 25 1 1 1 25 8 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :chinese, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="male ethnicity other"
qdiabetesm 25 1 1 1 25 9 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :male, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :other, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

#female tests

OP="female base options all booleans true"
qdiabetesf 25 1 1 1 25 1 1 0 10 0 1 > c.out || true #age b_corticosteroids b_cvd b_treatedhyp bmi ethrisk fh_diab smoke_cat surv town debug
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female age test"
qdiabetesf 84 1 1 1 25 1 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 84, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ex smoker"
qdiabetesf 25 1 1 1 25 1 1 1 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :ex, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female light smoker"
qdiabetesf 25 1 1 1 25 1 1 2 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :light, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female moderate smoker"
qdiabetesf 25 1 1 1 25 1 1 3 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :moderate, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female heavy smoker"
qdiabetesf 25 1 1 1 25 1 1 4 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :heavy, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity white"
qdiabetesf 25 1 1 1 25 1 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :white, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity indian"
qdiabetesf 25 1 1 1 25 2 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :indian, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity pakistani"
qdiabetesf 25 1 1 1 25 3 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :pakistani, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity bangladeshi"
qdiabetesf 25 1 1 1 25 4 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :bangladeshi, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity other_asian"
qdiabetesf 25 1 1 1 25 5 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :other_asian, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity black_caribbean"
qdiabetesf 25 1 1 1 25 6 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :black_caribbean, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity black_african"
qdiabetesf 25 1 1 1 25 7 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :black_african, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity chinese"
qdiabetesf 25 1 1 1 25 8 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :chinese, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

OP="female ethnicity other"
qdiabetesf 25 1 1 1 25 9 1 0 10 0 1 > c.out || true
qdiabetes.rb "{gender: :female, age: 25, corticosteroids: true, heart_disease: true, blood_pressure_treatment: true, body_mass_index: 25, ethnicity: :other, diabetes_relative: true, smoker: :non, internal_debug: true}" > ruby.out
diff -y --suppress-common-lines ruby.out c.out > diff.out

trap - int term exit
rm -f *.out
echo -e "];All Tests Passed!\a[32mAll Tests Passed[36m!![0m"

