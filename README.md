# Code for www.ianbyersceramics.co.uk

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
