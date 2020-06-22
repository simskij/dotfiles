console.log('Hello worldyyy');

function waitForElement(els, func) {
    const queries = els.map(el => document.querySelector(el));
    if (queries.every(a => a)) {
        func(queries);
    } else {
        setTimeout(waitForElement, 300, els, func);
    }
}

if (Spicetify.Abba) {
    if (!Spicetify.Abba.getOverrideFlags()["ab_no_recently_played_desktop"]) {
        Spicetify.Abba.addOverrideFlag("ab_no_recently_played_desktop", "no-recently-played");
    }
} else {
    console.info(`Please upgrade spicetify to v0.9.9 or above. Then run "spicetify restore backup apply"`)
}

waitForElement([".LeftSidebar", ".LeftSidebar__section--rootlist .SidebarList__list"], (queries) => {
    /** Replace Playlist name with their pictures */
    function loadPlaylistImage() {
        const sidebarItem = queries[1].childNodes;

        for (let i = 0; i < sidebarItem.length; i++) {
            const item = sidebarItem[i];
            const link = item.getElementsByTagName("a")[0];
            const href = link.href.replace("app:", "");

            if (href.indexOf("playlist-folder") != -1) {
                const button = item.getElementsByTagName("button")[0]
                button.classList.add("Button", "Button--style-icon-background", "Button--size-28",);
                item.setAttribute("data-tooltip", item.innerText);
                link.firstChild.innerText = item.innerText.slice(0, 3);
                continue;
            }

            Spicetify.CosmosAPI.resolver.get({
                url: `sp://core-playlist/v1/playlist/${href}/metadata`,
                body: { policy: { picture: true } },
            }, (err, res) => {
                if (err) return;
                const meta = res.getJSONBody().metadata;
                item.firstChild.className = "playlist-picture"
                item.firstChild.style.backgroundImage = `url(${meta.picture})`;
                item.firstChild.setAttribute("data-tooltip", item.textContent);
            });
        }
    }

    loadPlaylistImage();

  new MutationObserver(loadPlaylistImage)
        .observe(queries[1], {childList: true});

    queries[0].querySelectorAll(".LeftSidebar__section:not(.LeftSidebar__section--rootlist) [href]")
        .forEach(item => {
            let icon = ((app) => {
              console.log(app);
              switch (app) {
                case "genius":                  return "lyrics";
                case "JQBX":                    return "addsuggestedsong";
                case "bookmark":                return "tag";
                case "reddit":                  return "discover";
                case "made-for-you":            return "user";
                case "recently-played":         return "time";
                case "collection-songs":        return "collection";
                case "collection:albums":       return "album";
                case "collection:artists":      return "artist";
                case "collection:podcasts":     return "podcasts";
                case "playlist:local-files":    return "localfile";
                case "stations":                return "stations";
            }})(item.href.replace("spotify:app:", ""));

            item.firstChild.classList.add(`spoticon-${icon}-24`);
            item.firstChild.setAttribute("data-tooltip", item.firstChild.innerText);
            item.firstChild.innerText = "";
        });
});
