-- Run this in your Supabase SQL editor once

-- Table: single-row JSONB store for all grants
create table if not exists grants_blob (
  id    int primary key default 1,
  data  jsonb not null default '[]'::jsonb
);

-- Only the authenticated user can read/write
alter table grants_blob enable row level security;

create policy "auth read"  on grants_blob for select using (auth.role() = 'authenticated');
create policy "auth write" on grants_blob for all    using (auth.role() = 'authenticated');

-- Seed with your existing data (paste the JSON array from grants-data.json)
-- insert into grants_blob (id, data) values (1, '[]'::jsonb)
-- on conflict (id) do update set data = excluded.data;
