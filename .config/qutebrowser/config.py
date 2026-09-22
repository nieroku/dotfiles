import platform
from os import path
from qutebrowser.utils import version

config.load_autoconfig()

noctalia_template = path.join(path.dirname(__file__), "noctalia.py")
if path.isfile(noctalia_template):
    config.source(noctalia_template)

user_agent = " ".join([
    f"Mozilla/5.0 (X11; {platform.system()} {platform.machine()})",
    "AppleWebKit/537.36 (KHTML, like Gecko)",
    f"Chrome/{version.qtwebengine_versions().chromium}",
    "Safari/537.36",
])
c.content.headers.user_agent = user_agent

c.tabs.last_close = "close"

c.url.default_page = "about:blank"
c.url.start_pages = "about:blank"

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "ddg": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.com/search?q={}",
    "jisho": "https://jisho.org/search/{}",
    "wiki": "https://en.wikipedia.org/w/index.php?search={}",
    "wikt": "https://en.wiktionary.org/wiki/Special:Search?search={}",
    "yi": "https://yandex.com/images/search?text={}",
    "yt": "https://www.youtube.com/results?search_query={}",
}

config.bind("<", "tab-move -")
config.bind(">", "tab-move +")
config.bind("\\a", "open https://web.archive.org/{url}")
config.unbind("d")
