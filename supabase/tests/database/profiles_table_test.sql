begin;

-- Planned number of tests to run
select plan(12);

-- Check that profiles table exists
SELECT has_table(
    'public',
    'profiles',
    'Table profiles should exist'
);

-- Check columns
SELECT has_column('public', 'profiles', 'id', 'id should exist');
SELECT has_column('public', 'profiles', 'updated_at', 'updated_at should exist');
SELECT has_column('public', 'profiles', 'username', 'username should exist');
SELECT has_column('public', 'profiles', 'email', 'email should exist');
SELECT has_column('public', 'profiles', 'first_name', 'first_name should exist');
SELECT has_column('public', 'profiles', 'last_name', 'last_name should exist');
SELECT has_column('public', 'profiles', 'full_name', 'full_name should exist');
SELECT has_column('public', 'profiles', 'tunnel_mac_address', 'tunnel_mac_address should exist');
SELECT has_column('public', 'profiles', 'avatar_url', 'avatar_url should exist');
SELECT has_column('public', 'profiles', 'deleted', 'deleted should exist');


SELECT policies_are(
    'public',
    'profiles',
    ARRAY [
        'Public profiles are viewable by everyone.',
        'Users can insert their own profile.',
        'Users can update own profile.'
    ]
);

select * from finish();
rollback;
