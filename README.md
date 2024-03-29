# Code for www.ianbyersceramics.co.uk

## Prerequisites

NodeJS
Ruby

## Build

Run `./build.sh`.

## Deploy

Run `./deploy.sh`

## Directory layout

Full notes are in https://jekyllrb.com/docs/structure/.

Here's a quick overview.

| File/Folder | Description |
| ----------- | ----------- |
| _config.yml | Stores configuration data. Many of these options can be specified from the command line executable but it’s easier to specify them here so you don’t have to remember them. |
| _drafts | Drafts are unpublished posts. The format of these files is without a date: title.MARKUP. Learn how to work with drafts. |
| _includes | These are the partials that can be mixed and matched by your layouts and posts to facilitate reuse. The liquid tag {% include file.ext %} can be used to include the partial in _includes/file.ext. |
| _layouts | These are the templates that wrap posts. Layouts are chosen on a post-by-post basis in the YAML Front Matter, which is described in the next section. The liquid tag  {{ content }} is used to inject content into the web page. |
| _posts | Your dynamic content, so to speak. The naming convention of these files is important, and must follow the format: YEAR-MONTH-DAY-title.MARKUP. The permalinks can be customized for each post, but the date and markup language are determined solely by the file name. |
| _data | Well-formatted site data should be placed here. The Jekyll engine will autoload all data files (using either the .yml,  .yaml, .json or .csv formats and extensions) in this directory, and they will be accessible via `site.data`. If there's a file members.yml under the directory, then you can access contents of the file through site.data.members. |
| _sass | These are sass partials that can be imported into your main.scss which will then be processed into a single stylesheet main.css that defines the styles to be used by your site. |
| _site | This is where the generated site will be placed (by default) once Jekyll is done transforming it. It’s probably a good idea to add this to your .gitignore file. |
| .jekyll-metadata | This helps Jekyll keep track of which files have not been modified since the site was last built, and which files will need to be regenerated on the next build. This file will not be included in the generated site. It’s probably a good idea to add this to your .gitignore file. |
| index.html or index.md and other HTML, Markdown, Textile files | Provided that the file has a YAML Front Matter section, it will be transformed by Jekyll. The same will happen for any .html, .markdown,  .md, or .textile file in your site’s root directory or directories not listed above. |
| scripts/render_gallery_yml.rb | script to render the markdown files for a gallery from the YAML
for the gallery and its artworks |
| Other Files/Folders | Every other directory and file except for those listed above—such as  css and images folders,  favicon.ico files, and so forth—will be copied verbatim to the generated site. There are plenty of sites already using Jekyll if you’re curious to see how they’re laid out. |

## Adding galleries

To add a new gallery, first create entries for each artwork in `_data/artworks.yml` and then the
meta for the gallery in `_data/gallery.yml`.

Run `scripts/render_gallery_yml` with the index of the gallery.

## Adding an artwork to an existing gallery

Add an entry to _data/artworks.yml.

The artwork id should be the previous artwork's one incremented. For example, if the last artwork
had an id of 35, your artwork's id should be 36.

The id of photos should continue the sequence from the previous artwork's photos. For example, if
the last photo from the last artwork has an id of 54, the first photo for your artwork should have
an id of 55.

## Adding a new gallery

Add an entry to _data/galleries.yml.

The id should be the previous gallery's one incremented. For example, if the last gallery had an id
of 6, your gallery's id should be 7.

The number for each artwork and the photo_artwork are their ids - 1 (array indices).

Create the folders and index.html files for the gallery.

Add the photos to public/images (all sizes).
