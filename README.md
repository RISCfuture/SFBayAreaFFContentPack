# SF Bay Area Content Pack for ForeFlight

This content pack contains helpful data for San Francisco Bay Area general
aviation pilots.

## Installation

On the iOS device that has ForeFlight installed, open this link in Safari:

**[Install in ForeFlight][install]**

When the preview appears, long-press or pull the page down and tap **Open in
ForeFlight**. The pack downloads into **More → Downloads**. You may need to
force-quit and restart ForeFlight to get the new content to appear.

The link goes through GitHub's `releases/latest` redirect, so bookmarking it
once keeps pulling the newest version of the pack.

[install]: https://foreflight.com/content?downloadURL=https%3A%2F%2Fgithub.com%2FRISCfuture%2FSFBayAreaFFContentPack%2Freleases%2Flatest%2Fdownload%2FSan.Francisco.Bay.Area.Content.Pack.zip

## Contributing

Pull requests are welcome! Please expand this content pack with useful
information for your Bay Area airport. Please check the guidelines before
contributing, though.

Every change to `byop/` or `navdata/` merged into `main` is released
automatically: CI builds the pack with `build-pack.sh` (which also generates
its `manifest.json`) and publishes it as a GitHub release tagged with the build
date.

### Guidelines

- Location must be in the San Francisco Bay Area or immediate surrounding area,
  to prevent data overload.
- Data must be relevant to most general aviation pilots (VFR or IFR): no company
  procedures, military stuff, etc.
- Data must be relevant to air navigation: no sightseeing waypoints, cool
  airport restaurants, etc.
