'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "8908459322fdafbc489797c2d8b61685",
"version.json": "48260382cef0c914d5f5572436e0b12b",
"index.html": "bc0dae39fd9cf1ad9c58b6314891a3d9",
"/": "bc0dae39fd9cf1ad9c58b6314891a3d9",
"main.dart.js": "6faab9aefd76bbc210818022850b11f2",
"ar.css": "805fb339128d9b11a7a0c0356726a783",
"anime.min.js": "572d66e85091711b6ee76609573a8364",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "45ddfb3b870093dbd1d71654b76908f2",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "902587e345abe53c2fc7d901cb96d19a",
"assets/AssetManifest.json": "d353b9c6749bfcdb5a0789684d71a10c",
"assets/NOTICES": "628a3c7f0eb616d3723f58005079c535",
"assets/FontManifest.json": "a5cb4a475fe32e8fc4aa632022a36a44",
"assets/AssetManifest.bin.json": "bcd948dc80b9b66f06d8bb4216a2f24d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "af1bc951c54eb3e60f2f154131159224",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "d1d42885635c3eee1102c4cc0b61ed93",
"assets/packages/model_viewer_plus/assets/model-viewer.min.js": "dd677b435b16f44e4ca08a9f354bac24",
"assets/packages/model_viewer_plus/assets/template.html": "8de94ff19fee64be3edffddb412ab63c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "6ef4b59516cfa16567f281a2005dd373",
"assets/fonts/MaterialIcons-Regular.otf": "afc762e43b75c89e0e26742bd45ce627",
"assets/assets/images/img.svg": "9eec650e409dd73b2ebdb2670d50ba8e",
"assets/assets/images/gsoc.svg": "9c936c6233b02c3cc6cac7107c56b4cc",
"assets/assets/images/jane.svg": "fce02bb613e868ce3a07ac56c1dfc2e9",
"assets/assets/images/noticeboard.svg": "44180a3a4018bf006fa43023260ea5d7",
"assets/assets/images/lyf.svg": "f6dcdb44fb9e0b83aad23ffcf3bbae22",
"assets/assets/images/covbot.svg": "b96ac9c404e76e03a8cc0b70a32df43f",
"assets/assets/images/ar.svg": "eb666db46e4b23f08bf553c1dd690223",
"assets/assets/images/amazon.svg": "c352e44351c439e4d935339b6e3be740",
"assets/assets/images/cdai.svg": "62f530a135e61f2f36e696de1913506c",
"assets/assets/images/bugheist.svg": "0a25d6ba0e78cc779d513c16d6135bad",
"assets/assets/images/placement.svg": "4a4abf846041ea1b374e597698ace8f1",
"assets/assets/images/ar_broken.svg": "4e3bc4e23b6d969be3a72fb4c899ad5d",
"assets/assets/resume.pdf": "9b458f2a0f1d3fe2057e4ec18f296d9b",
"assets/assets/models/jane.gltf": "07179f974f1f5bdcaf6cc9e110215a61",
"assets/assets/models/lyf.gltf": "3affe4be8db7f0ba39c623d2d7835560",
"assets/assets/models/img.gltf": "fddf8cceb27c923863dc011dc0da4614",
"assets/assets/models/cdai.gltf": "31b2beb259a404c93d4ea111acefe403",
"assets/assets/models/covbot.gltf": "9201220bf3fbea9a0df158ea402293cd",
"assets/assets/models/blt.gltf": "bc43c18b6f2574ace5cbc9876b48deae",
"assets/assets/models/placement.gltf": "2e1b33e862dd3e2bfb8adadd1bad0fb7",
"assets/assets/models/gsoc.gltf": "640b8d79b7d9cbdfcb8c29c8a9a10521",
"assets/assets/models/amazon.gltf": "8fc6b83bd629506d114ce30bbb3f61f4",
"assets/assets/models/noticeboard.gltf": "54db1c931f3e217d416e341bbea170e9",
"assets/assets/fonts/aBeeZee/ABeeZee-Italic.ttf": "edd03f664078e033f40495d57483f092",
"assets/assets/fonts/aBeeZee/ABeeZee-Regular.ttf": "cb714a0b844e87337aef21078fddcecc",
"assets/assets/fonts/itim/Itim-Regular.ttf": "4a3f2cf1ced5257b6af803f4b86bf427",
"assets/assets/fonts/Allison-Regular.ttf": "237a9ce39570240f90f04848e68e5bfc",
"assets/assets/fonts/caveat/Caveat-Bold.ttf": "5572b7521fe37a84f200b7ffc0a228dc",
"assets/assets/fonts/caveat/Caveat-Regular.ttf": "04c3547e70bd8d53833d325c37f9621f",
"assets/assets/fonts/caveat/Caveat-Medium.ttf": "b720a04723fd9e56c3e76c39298ddec5",
"assets/assets/fonts/caveat/Caveat-SemiBold.ttf": "ec80dc3f5008212d8481ae873814f3c4",
"assets/assets/fonts/ubuntu/Ubuntu-Medium.ttf": "d3c3b35e6d478ed149f02fad880dd359",
"assets/assets/fonts/ubuntu/Ubuntu-LightItalic.ttf": "b242f3fdf0e61d01f35f0dec0170b200",
"assets/assets/fonts/ubuntu/Ubuntu-Regular.ttf": "84ea7c5c9d2fa40c070ccb901046117d",
"assets/assets/fonts/ubuntu/Ubuntu-Bold.ttf": "896a60219f6157eab096825a0c9348a8",
"assets/assets/fonts/ubuntu/Ubuntu-MediumItalic.ttf": "89af35d9567dcc3a76f3db4f9544658b",
"assets/assets/fonts/ubuntu/Ubuntu-BoldItalic.ttf": "c16e64c04752a33fc51b2b17df0fb495",
"assets/assets/fonts/ubuntu/Ubuntu-Italic.ttf": "9f353a170ad1caeba1782d03dd8656b5",
"assets/assets/fonts/ubuntu/Ubuntu-Light.ttf": "c9d68f61bf89fde6a24da697bc45d6f9",
"assets/assets/fonts/coveredGrace/CoveredByYourGrace-Regular.ttf": "1acf9002df705e347e9f05238ce9731d",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
