'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "d9ab621a073106e21d4f98ed041b68f2",
"version.json": "042ad4331501481b5ccedcdf106cdeaf",
"index.html": "fbb510e97b968c0932f84306479c70e7",
"/": "fbb510e97b968c0932f84306479c70e7",
"main.dart.js": "17853e5ea4f9be1d8c3e6e03af655043",
"ar.css": "133b209fd372d4ffd312de8f04bcd4b2",
"anime.min.js": "572d66e85091711b6ee76609573a8364",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "45ddfb3b870093dbd1d71654b76908f2",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "902587e345abe53c2fc7d901cb96d19a",
"assets/AssetManifest.json": "96b550a31e6055e1b93cc2f486e9b113",
"assets/NOTICES": "ebc03b472251cf8a981e332ac1f1088f",
"assets/FontManifest.json": "a5cb4a475fe32e8fc4aa632022a36a44",
"assets/AssetManifest.bin.json": "880fdb733cbfa2819d2ddd2074374685",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "04f83c01dded195a11d21c2edf643455",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "e489e038387c095de48a17586d516b7d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "17b8dda6365383a29a7e8e3673bad8d0",
"assets/packages/model_viewer_plus/assets/model-viewer.min.js": "4226392bee9372f20a688343e51e7b54",
"assets/packages/model_viewer_plus/assets/template.html": "8de94ff19fee64be3edffddb412ab63c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "8d71d1a240297dbe62077bf8a95e7855",
"assets/fonts/MaterialIcons-Regular.otf": "f5d7e41d2fbb06c2362d993e4804e5ed",
"assets/assets/images/space2.jpg": "8bf72e7f3fdbd433ca05d7160325d53d",
"assets/assets/images/space3.jpg": "ad727a2ae5194926837012184eab0f73",
"assets/assets/images/space1.jpg": "ef81a615a9c0849a94ae043b3b5aa141",
"assets/assets/images/gsoc.svg": "9c936c6233b02c3cc6cac7107c56b4cc",
"assets/assets/images/jane.svg": "fce02bb613e868ce3a07ac56c1dfc2e9",
"assets/assets/images/lyf.svg": "f6dcdb44fb9e0b83aad23ffcf3bbae22",
"assets/assets/images/covbot.svg": "b96ac9c404e76e03a8cc0b70a32df43f",
"assets/assets/images/ar.svg": "eb666db46e4b23f08bf553c1dd690223",
"assets/assets/images/bugheist.svg": "0a25d6ba0e78cc779d513c16d6135bad",
"assets/assets/models/lyf.gltf": "7b384a3b370c82a62385c70bf756d7c2",
"assets/assets/models/CovBot.gltf": "97d0573335de7e1747b149e36d9840b3",
"assets/assets/models/gsoc.gltf": "8e3f189520ea4fc14a4b24bb13e7228e",
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
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
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
