const express = require('express');
const fs = require('fs');
const path = require('path');
const app = express();
const PORT = 3000;

const videosDir = path.join(__dirname, 'videos');
const imagesDir = path.join(__dirname, 'images');

app.use('/videos', express.static(videosDir));
app.use('/images', express.static(imagesDir));
app.use(express.static(__dirname)); // Für index.html etc.

// API: Liste aller Videos
app.get('/api/videos', (req, res) => {
  fs.readdir(videosDir, (err, files) => {
    if (err) return res.status(500).json({ error: 'Fehler beim Lesen des Video-Ordners.' });
    const videoFiles = files.filter(f => f.match(/\.(mp4|webm|ogg)$/i));
    res.json(videoFiles.map(filename => ({ filename })));
  });
});

// API: Liste aller Bilder
app.get('/api/images', (req, res) => {
  fs.readdir(imagesDir, (err, files) => {
    if (err) return res.status(500).json({ error: 'Fehler beim Lesen des Bilder-Ordners.' });
    const imageFiles = files.filter(f => f.match(/\.(jpg|jpeg|png|gif|webp|bmp|svg|pdf)$/i));
    res.json(imageFiles.map(filename => ({ filename })));
  });
});

app.listen(PORT, () => {
  console.log(`Server läuft auf http://localhost:${PORT}`);
}); 