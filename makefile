auto_generate:
	dart run build_runner build --delete-conflicting-outputs 
build_apk_s:
	flutter build apk --split-per-abi

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format lib .
	@flutter pub run import_sorter:main
	@dart fix --apply

pub_get:
	fvm flutter pub get

flutter_gen:
	flutter gen-l10n --arb-dir="lib/l10n/arb"

gen_trans_folder:
	flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"

gen_trans_keys:
	flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

gen_icon:
	dart run flutter_launcher_icons