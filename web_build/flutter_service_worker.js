'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "f61f4b4001befe8e8eff8047b3206871",
"splash/img/light-2x.png": "4ca1b6987d0162979048afc2395bf4cf",
"splash/img/dark-4x.png": "80dc49c3e644b4c39fb4305ec53a1f27",
"splash/img/light-3x.png": "34f692641c4048a16e835d45d34e1fde",
"splash/img/dark-3x.png": "34f692641c4048a16e835d45d34e1fde",
"splash/img/light-4x.png": "80dc49c3e644b4c39fb4305ec53a1f27",
"splash/img/dark-2x.png": "4ca1b6987d0162979048afc2395bf4cf",
"splash/img/dark-1x.png": "bcb365012cb19e9fbfc8fe5ebc4f61b2",
"splash/img/light-1x.png": "bcb365012cb19e9fbfc8fe5ebc4f61b2",
"index.html": "7524f2ece1c23d3401c87021fcf91af7",
"/": "7524f2ece1c23d3401c87021fcf91af7",
"main.dart.js": "c2384f3df6012818de8be48c049d1e94",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "d3f6572fd80215a39b819853284a74b1",
"icons/Icon-192.png": "2d911c5ce13f1fdd0d199a63932c362d",
"icons/Icon-maskable-192.png": "2d911c5ce13f1fdd0d199a63932c362d",
"icons/Icon-maskable-512.png": "80dc49c3e644b4c39fb4305ec53a1f27",
"icons/Icon-512.png": "80dc49c3e644b4c39fb4305ec53a1f27",
"manifest.json": "0f9cfb1bec1f6db7196dc237804c8db7",
"assets/AssetManifest.json": "19755c02804e39a67a3247ba2ad95c8e",
"assets/NOTICES": "32eb9c5f3477fd3b5b9aae43b66afcf5",
"assets/FontManifest.json": "4a5f5eecae33fc0ad62caef5dfe078ce",
"assets/AssetManifest.bin.json": "f929f77d992f3ecf8f4a8e8d2996c167",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/syncfusion_flutter_pdfviewer/assets/squiggly.png": "c9602bfd4aa99590ca66ce212099885f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/strikethrough.png": "cb39da11cd936bd01d1c5a911e429799",
"assets/packages/syncfusion_flutter_pdfviewer/assets/highlight.png": "7384946432b51b56b0990dca1a735169",
"assets/packages/syncfusion_flutter_pdfviewer/assets/underline.png": "c94a4441e753e4744e2857f0c4359bf0",
"assets/packages/fluttertoast/assets/toastify.js": "18cfdd77033aa55d215e8a78c090ba89",
"assets/packages/fluttertoast/assets/toastify.css": "910ddaaf9712a0b0392cf7975a3b7fb5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1db1390478bb29dd3793a549dd103852",
"assets/fonts/MaterialIcons-Regular.otf": "666c89832adfdae2a663f44329c8ce3f",
"assets/assets/app_icon.png": "16167c6e4eb960742ec05a6cd4b78f11",
"assets/assets/images/check.png": "c87ba8c858cdcf41583800e00f1a62bc",
"assets/assets/images/user_management.png": "1fbc5777ff1234f6ace7c55c66b044a0",
"assets/assets/images/auth.png": "84f264ad514a787022be9c6dd38d2786",
"assets/assets/images/settings.png": "35c279ef9c74ceccda6a819f54a32969",
"assets/assets/images/home.png": "4e90f979eba9e7be68d260a915b3adf9",
"assets/assets/images/skill.png": "d5f136e16c57341d5dc8b88ec32920b8",
"assets/assets/images/block_chain.png": "196ac4d6594c7babb02a7b4244f57587",
"assets/assets/images/profile_dummy.png": "6769c6e665350d692d97f870997cbd2e",
"assets/assets/images/test.png": "16313bc7b643245cbeb037b2664caab6",
"assets/assets/images/skills_added.png": "b4e96137e5f0d901b287c2a91364c04d",
"assets/assets/images/add_skill.png": "53b22e10cec53f82d7bcfef0acf7f9b8",
"assets/assets/images/institution.png": "05f81492436ef2aae7086b37c1e6b5f2",
"assets/assets/images/skill_approve.png": "911314fb0f44599e2e63cf81d13fcf97",
"assets/assets/images/remove.png": "dc8a298218b01cb39958e045e14036f8",
"assets/assets/images/profile.png": "40264292c685064f57505a34a8c62963",
"assets/assets/images/sk_logo.png": "297dfb292abe15ba6a7528cbc38f2169",
"assets/assets/lottie/empty_user.json": "6f709d32993b232629fe71421ac9a99b",
"assets/assets/fonts/montserrat/Montserrat-Medium.ttf": "128c3c68ca7303b88442a347292291fa",
"assets/assets/fonts/montserrat/Montserrat-Light.ttf": "bcf14e7123e6a0a873151c78e5c316c6",
"assets/assets/fonts/montserrat/Montserrat-ExtraLight.ttf": "324a0e0cec3a73b38b58703bc5747b17",
"assets/assets/fonts/montserrat/Montserrat-Thin.ttf": "250b795c8fe6f7add514bc8af2050b8f",
"assets/assets/fonts/montserrat/Montserrat-Bold.ttf": "c4bd22ebfc4d76f100ebefd2cf916227",
"assets/assets/fonts/montserrat/Montserrat-SemiBold.ttf": "cbdecee7a45d92a998429b0290bf02b0",
"assets/assets/fonts/montserrat/Montserrat-ExtraBold.ttf": "bf087000dc560f8f2a318d4ddad4720f",
"assets/assets/fonts/montserrat/Montserrat-Black.ttf": "976649f5b0b109bfc06c008372d90094",
"assets/assets/fonts/montserrat/Montserrat-Regular.ttf": "430be0dd245faf1cc788fac6680c2d71",
"assets/assets/white.png": "f6473b6ab62b1cae14c480efed1bf5e6",
"assets/assets/bg.png": "491dae7562e51758cabe7875433a9d86",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
