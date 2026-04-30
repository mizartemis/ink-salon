-- ============================================================
-- 달빛 독서회 · Supabase 초기 설정 SQL
-- ============================================================

-- 1) 테이블 생성 -----------------------------------------------
create table if not exists reviews (
  id           text primary key,
  name         text not null,
  date         date,
  book         text not null,
  author       text,
  content      text not null,
  tag          text,
  created_at   timestamptz default now()
);

create table if not exists books (
  id           text primary key,
  title        text not null,
  author       text,
  recommender  text,
  color        text,
  comment      text,
  created_at   timestamptz default now()
);

create table if not exists daily (
  id           text primary key,
  name         text not null,
  date         date,
  emoji        text,
  content      text,
  created_at   timestamptz default now()
);

create table if not exists fees (
  id           text primary key,
  date         date,
  name         text,
  description  text,
  amount       integer,
  created_at   timestamptz default now()
);

-- 2) RLS (Row Level Security) -------------------------------
alter table reviews enable row level security;
alter table books   enable row level security;
alter table daily   enable row level security;
alter table fees    enable row level security;

create policy "anon all on reviews" on reviews for all using (true) with check (true);
create policy "anon all on books"   on books   for all using (true) with check (true);
create policy "anon all on daily"   on daily   for all using (true) with check (true);
create policy "anon all on fees"    on fees    for all using (true) with check (true);

-- 3) 샘플 데이터 ---------------------------------------------
insert into reviews (id, name, date, book, author, content, tag) values
  ('seed-r1', '하늘', '2026-04-22', '소년이 온다', '한강 / 창비',
   '광주의 그날과 그 이후를 살아낸 사람들의 목소리. 페이지를 넘기는 손이 오래 멈추는 책이었습니다. 침묵의 무게가 글자보다 더 컸어요.', '4월 정기'),
  ('seed-r2', '서연', '2026-04-15', '아주 작은 습관의 힘', '제임스 클리어 / 비즈니스북스',
   '"1%의 변화가 쌓이면 다른 사람이 된다." 매일 5분의 독서가 이 모임을 시작하게 한 작은 습관이었음을 새삼 깨달았습니다.', '자기계발'),
  ('seed-r3', '주원', '2026-04-08', '나는 나로 살기로 했다', '김수현 / 마음의숲',
   '타인의 기준이 아닌 나의 속도로 살아가는 일. 별 헤는 밤에 천천히 다시 읽고 싶은 문장이 많았어요.', '에세이')
on conflict (id) do nothing;

insert into books (id, title, author, recommender, color, comment) values
  ('seed-b1', '달러구트 꿈 백화점', '이미예',         '하늘', '135deg,#3b4a7c,#1f2746', '잠들기 전에 한 챕터씩, 좋은 꿈처럼 읽혀요.'),
  ('seed-b2', '밤의 도서관',         '알베르토 망구엘','서연', '135deg,#2e3b5c,#0f1a36', '책에 둘러싸인 밤의 고요함을 사랑한다면.'),
  ('seed-b3', '별, 빛나는',          '나카무라 후미노리','주원','135deg,#5a4a7c,#2e2046', '모든 어둠 너머에는 결국 별이 있더라고요.')
on conflict (id) do nothing;

insert into daily (id, name, date, emoji, content) values
  ('seed-d1', '하늘', '2026-04-28', '🌙',
   '오늘 밤하늘 정말 맑았어요. 베란다에 나가 한참 달을 바라봤어요. 이런 밤엔 책 한 권이 더 깊게 읽혀요.'),
  ('seed-d2', '서연', '2026-04-26', '☕',
   '심야 카페에서 혼자 읽는 시간. 조용한 음악과 따뜻한 차 한 잔, 페이지 넘기는 소리만 있어도 충분한 밤이에요.')
on conflict (id) do nothing;

insert into fees (id, date, description, name, amount) values
  ('seed-f1', '2026-04-15', '4월 회비',         '하늘', 50000),
  ('seed-f2', '2026-04-15', '4월 회비',         '서연', 50000),
  ('seed-f3', '2026-04-15', '4월 회비',         '주원', 50000),
  ('seed-f4', '2026-04-15', '모임 카페 (정기)', '공동', -38000)
on conflict (id) do nothing;
