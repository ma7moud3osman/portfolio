type App = {
  id: string; name: string; category: string; description: string; features: string[]; role: string; stack: string;
  meta: string; group: string; icon: string; screens: string[]; landscape: boolean; logoOnly: boolean;
  tint: string; accent: string; play: string; appstore: string;
};
type Data = { hero: string[]; apps: App[]; i18n: { autoStop: string; autoStart: string; screenN: string; shotOf: string } };

const raw = document.getElementById('portfolio-data');
if (raw) init(JSON.parse(raw.textContent || '{}') as Data);

function init({ hero: heroIds, apps, i18n }: Data) {
  const $ = <T extends Element = HTMLElement>(sel: string, root: ParentNode = document) => root.querySelector(sel) as T;
  const $$ = <T extends Element = HTMLElement>(sel: string, root: ParentNode = document) => [...root.querySelectorAll(sel)] as T[];
  const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
  const replay = (el: Element, cls: string) => { el.classList.remove(cls); void (el as HTMLElement).offsetWidth; el.classList.add(cls); };
  const preload = (src: string) => { const i = new Image(); i.src = src; };
  const meta = (a: App) => [a.meta, a.category].filter(Boolean).join(' · ');

  // counters
  if (!reduce) {
    $$('[data-count]').forEach((el) => {
      const end = Number(el.dataset.count), pre = el.dataset.prefix || '', start = performance.now();
      const step = (now: number) => {
        const p = Math.min(1, (now - start) / 1600), v = Math.round(end * (1 - Math.pow(1 - p, 3)));
        el.textContent = pre + v;
        if (p < 1) requestAnimationFrame(step);
      };
      requestAnimationFrame(step);
    });
  }

  // hero rotation
  const heroApps = heroIds.map((id) => apps.find((a) => a.id === id)).filter((a): a is App => !!a);
  heroApps.forEach((a) => preload(a.screens[0]));
  let heroIdx = 0;
  const heroSec = $('#hero'), heroInfo = $('#hero-info'), heroShot = $<HTMLImageElement>('#hero-shot');
  const showHero = () => {
    const a = heroApps[heroIdx];
    heroSec.style.backgroundColor = a.tint;
    $<HTMLImageElement>('#hero-icon').src = a.icon;
    $('#hero-name').textContent = a.name;
    $('#hero-cat').textContent = a.category;
    heroShot.src = a.screens[0];
    heroShot.alt = `${i18n.shotOf} ${a.name}`;
    replay(heroInfo, 'anim-info');
    replay(heroShot, 'anim-screen');
  };

  // showroom
  const room = $('#room'), list = $$<HTMLButtonElement>('.app-btn'), chips = $$<HTMLButtonElement>('.chip');
  const shotImg = $<HTMLImageElement>('#room-shot'), device = shotImg.closest('.phone-room') as HTMLElement;
  const thumbs = $('#room-thumbs'), detail = $('#room-detail'), autoBtn = $<HTMLButtonElement>('#auto-btn');
  let sel = 0, shot = 0, cat = 'all', auto = !reduce, tick = 0, roomVisible = false;
  const inCat = (a: App) => cat === 'all' || a.group === cat;

  const setAuto = (on: boolean) => {
    auto = on;
    autoBtn.textContent = on ? i18n.autoStop : i18n.autoStart;
    autoBtn.setAttribute('aria-pressed', String(on));
    detail.setAttribute('aria-live', on ? 'off' : 'polite');
  };

  const renderShot = () => {
    const a = apps[sel];
    shotImg.src = a.screens[shot];
    shotImg.alt = `${i18n.shotOf} ${a.name}`;
    replay(shotImg, 'anim-screen');
    $$<HTMLButtonElement>('.thumb', thumbs).forEach((b, n) => {
      b.setAttribute('aria-pressed', String(n === shot));
      b.style.borderColor = n === shot ? a.accent : 'transparent';
    });
  };

  const renderApp = () => {
    const a = apps[sel];
    room.style.backgroundColor = a.tint;
    list.forEach((b, i) => b.setAttribute('aria-selected', String(i === sel)));
    device.classList.toggle('is-landscape', a.landscape);
    device.classList.toggle('is-logo', a.logoOnly);
    a.screens.forEach(preload);
    thumbs.replaceChildren(...a.screens.map((src, n) => {
      const b = document.createElement('button');
      b.type = 'button';
      b.className = 'thumb' + (a.landscape ? ' wide' : '');
      b.dataset.shot = String(n);
      b.setAttribute('aria-label', `${i18n.screenN} ${n + 1}`);
      const img = document.createElement('img');
      img.src = src; img.alt = '';
      b.append(img);
      return b;
    }));
    $<HTMLImageElement>('[data-f="icon"]', detail).src = a.icon;
    $('[data-f="name"]', detail).textContent = a.name;
    $('[data-f="meta"]', detail).textContent = meta(a);
    $('[data-f="description"]', detail).textContent = a.description;
    $('[data-f="role"]', detail).textContent = a.role;
    $('[data-f="stack"]', detail).textContent = a.stack;
    const feats = $('[data-f="features"]', detail);
    const svg = (c: string) => `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="${c}" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 12l5 5L20 7"/></svg>`;
    feats.replaceChildren(...a.features.map((f) => {
      const li = document.createElement('li');
      li.innerHTML = svg(a.accent);
      li.append(f);
      return li;
    }));
    ([['play', a.play], ['appstore', a.appstore]] as const).forEach(([k, url]) => {
      const link = $<HTMLAnchorElement>(`[data-store="${k}"]`, detail);
      if (!link) return;
      link.hidden = !url;
      link.href = url || '#';
      link.setAttribute('aria-label', `${k === 'play' ? 'Google Play' : 'App Store'}: ${a.name}`);
    });
    replay(detail, 'anim-info');
    renderShot();
  };

  const select = (i: number, stop = true) => { sel = i; shot = 0; if (stop) setAuto(false); renderApp(); };

  list.forEach((b) => b.addEventListener('click', () => select(Number(b.dataset.idx))));
  thumbs.addEventListener('click', (e) => {
    const b = (e.target as Element).closest<HTMLButtonElement>('.thumb');
    if (!b) return;
    shot = Number(b.dataset.shot); setAuto(false); renderShot();
  });
  chips.forEach((c) => c.addEventListener('click', () => {
    cat = c.dataset.cat || 'all';
    chips.forEach((x) => x.setAttribute('aria-pressed', String(x === c)));
    list.forEach((b) => { b.hidden = !inCat(apps[Number(b.dataset.idx)]); });
    const firstIdx = apps.findIndex(inCat);
    if (firstIdx >= 0) select(firstIdx, false);
  }));
  autoBtn.addEventListener('click', () => setAuto(!auto));
  $$<HTMLAnchorElement>('[data-open]').forEach((a) => a.addEventListener('click', () => {
    const idx = apps.findIndex((x) => x.id === a.dataset.open);
    if (idx < 0) return;
    if (!inCat(apps[idx])) chips[0]?.click();
    select(idx);
  }));

  // listbox keyboard support
  $('.app-list').addEventListener('keydown', (e) => {
    const k = (e as KeyboardEvent).key;
    if (!['ArrowDown', 'ArrowUp', 'ArrowLeft', 'ArrowRight'].includes(k)) return;
    e.preventDefault();
    const visible = list.filter((b) => !b.hidden);
    const pos = visible.findIndex((b) => Number(b.dataset.idx) === sel);
    const fwd = k === 'ArrowDown' || k === (document.dir === 'rtl' ? 'ArrowLeft' : 'ArrowRight');
    const next = visible[(pos + (fwd ? 1 : -1) + visible.length) % visible.length];
    next.focus(); select(Number(next.dataset.idx));
  });

  new IntersectionObserver(([en]) => { roomVisible = en.isIntersecting; }, { threshold: 0.25 }).observe(room);
  setAuto(auto);

  if (reduce) return;
  setInterval(() => {
    if (document.hidden) return;
    heroIdx = (heroIdx + 1) % heroApps.length;
    showHero();
    tick++;
    if (auto && roomVisible && tick % 2 === 0) {
      const a = apps[sel];
      if (shot + 1 < a.screens.length) { shot++; renderShot(); }
      else {
        const pool = apps.map((_, i) => i).filter((i) => inCat(apps[i]));
        select(pool[(pool.indexOf(sel) + 1) % pool.length], false);
      }
    }
  }, 1800);
}
