-- Run this in Supabase SQL Editor

create table if not exists suggestions (
  id           bigserial primary key,
  foundation   text not null,
  grant_name   text,
  deadline     text,
  web          text,
  notes        text,
  submitted_at timestamptz default now(),
  status       text default 'pending'   -- pending | accepted | rejected
);

alter table suggestions enable row level security;

-- Anyone can submit a suggestion (no login needed)
create policy "public insert" on suggestions for insert with check (true);
-- Only you (authenticated) can read, update, delete
create policy "auth read"   on suggestions for select using (auth.role() = 'authenticated');
create policy "auth update" on suggestions for update using (auth.role() = 'authenticated');
create policy "auth delete" on suggestions for delete using (auth.role() = 'authenticated');
