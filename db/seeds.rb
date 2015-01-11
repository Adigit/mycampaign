# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

INSERT INTO `mobile_campaign_filters` (`id`, `category`, `filter`, `is_active`, `qual_input`, `created_at`, `updated_at`) VALUES
(1, 'Version', 'Version code', 1, '--- \n- - Is equal to\n  - Is not equal to\n  - Greater than\n  - Less than\n  - Greater than equal to\n  - Less than equal to\n- input_field\n', NULL, NULL),
(2, 'App Launch Counter', 'App Launch Count', 1, '--- \n- - Is equal to\n  - Is not equal to\n  - Greater than\n  - Less than\n  - Greater than equal to\n  - Less than equal to\n- input_field\n', NULL, NULL),
(3, 'User Percentage', 'Percentage of Users', 1, '--- \n- - Is equal to\n- input_field\n', NULL, NULL),
(4, 'Internet Connection', 'Internet Connection', 1, '--- \n- - Is equal to\n- - All Mobile Users\n  - Wi-Fi Only\n', NULL, NULL),
(5, 'Location', 'Country', 1, '--- \n- - Is equal to\n  - Is not equal to\n- get_country_list\n', NULL, NULL),
(6, 'Activity', 'Show on Activity', 1, '--- \n- - Is equal to\n- input_field\n', NULL, NULL);
