-- Запустите этот SQL в редакторе Supabase: https://supabase.com/dashboard/project/rnotzuhfdoopdawheztd/editor

create table if not exists leads (
  id          bigserial primary key,
  created_at  timestamptz default now(),
  name        text not null,
  phone       text not null,
  email       text,
  tg_linked   boolean default false,
  client_type text not null,
  currency    text not null,
  destination text not null,
  amount      text,
  comment     text,
  status      text default 'new',
  status_reason text,
  substatus   text
);

alter table leads enable row level security;

-- Разрешить вставку заявок с сайта (анонимный ключ)
create policy "allow_insert" on leads
  for insert to anon with check (true);

-- Разрешить чтение заявок в панели администратора
create policy "allow_select" on leads
  for select to anon using (true);

-- Разрешить обновление статусов в панели администратора
create policy "allow_update" on leads
  for update to anon using (true);
