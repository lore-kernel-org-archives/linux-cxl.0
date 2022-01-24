Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEFDC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiAXAxm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:53:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:50286 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240660AbiAXAxm (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985622; x=1674521622;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EWL74daI4RE7U3oJ2loKOce0BhS8tpZ+25y8801Ll3s=;
  b=g9pfv3pL+TU9c6fZDfvNkPVCU4sB4rmwDwEpuatqOa8u2uAt9l7vOKYT
   xam5dhn/GcrHtYDjahwMN/Cv666vKThdN02Bncse6elJtmI0zx3Ka9dp7
   jlmAYpiQSneVS1I2tIIcZXnhJa06hO3eNMW/QuNxqK3pbNk+jYMmvsIZd
   FgkdLh5ikML1pyruaze2Lp9VXSENwK9tlHcLp88kRcT6/m9tjM69OuEJ+
   lsvlS2Ib94XxjG5T8a5VhuvzvCJxwplZSAiNHVNa5tvEyIUksEWFXeyRu
   zcDPVBF1GM9grtC1ZMXr7QdsW+UyT0z3/JefSGEw9QRY8//7RbJ8hHaQm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243530620"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243530620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="673456489"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:40 -0800
Subject: [ndctl PATCH 21/37] cxl/list: Add 'host' entries for memdevs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:53:39 -0800
Message-ID: <164298561980.3021641.9636572507721689266.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For debugging CXL port connectivity issues it will be useful to have the
PCI device name for the memory expander in the 'memdev' listing.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-list.txt   |    3 ++-
 Documentation/cxl/lib/libcxl.txt |    4 ++++
 cxl/json.c                       |    5 +++++
 cxl/lib/libcxl.c                 |   24 ++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |    1 +
 cxl/lib/private.h                |    1 +
 cxl/libcxl.h                     |    1 +
 7 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 30b61615644b..9c21ab7afd74 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -43,7 +43,8 @@ EXAMPLE
     "memdev":"mem0",
     "pmem_size":268435456,
     "ram_size":0,
-    "serial":0
+    "serial":0,
+    "host":"0000:35:00.0"
   }
 ]
 
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index e4b372d781ec..91fd33e8b1ae 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -40,6 +40,7 @@ kernel, or to send data or trigger kernel operations for a given device.
 struct cxl_memdev *cxl_memdev_get_first(struct cxl_ctx *ctx);
 struct cxl_memdev *cxl_memdev_get_next(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_host(struct cxl_memdev *memdev)
 
 #define cxl_memdev_foreach(ctx, memdev) \
         for (memdev = cxl_memdev_get_first(ctx); \
@@ -54,6 +55,9 @@ memory device commands, see the port, decoder, and endpoint APIs to
 determine what if any CXL Memory Resources are reachable given a
 specific memdev.
 
+The host of a memdev is the PCIe Endpoint device that registered its CXL
+capabilities with the Linux CXL core.
+
 === MEMDEV: Attributes
 ----
 int cxl_memdev_get_id(struct cxl_memdev *memdev);
diff --git a/cxl/json.c b/cxl/json.c
index af3b4fe6a0eb..18686867e0c5 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -219,6 +219,11 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		if (jobj)
 			json_object_object_add(jdev, "serial", jobj);
 	}
+
+	jobj = json_object_new_string(cxl_memdev_get_host(memdev));
+	if (jobj)
+		json_object_object_add(jdev, "host", jobj);
+
 	return jdev;
 }
 
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 5f48202d7b93..c4ddc7d80cff 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -63,6 +63,7 @@ static void free_memdev(struct cxl_memdev *memdev, struct list_head *head)
 	free(memdev->firmware_version);
 	free(memdev->dev_buf);
 	free(memdev->dev_path);
+	free(memdev->host);
 	free(memdev);
 }
 
@@ -297,6 +298,7 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	char *path = calloc(1, strlen(cxlmem_base) + 100);
 	struct cxl_ctx *ctx = parent;
 	struct cxl_memdev *memdev, *memdev_dup;
+	char *host, *rpath = NULL;
 	char buf[SYSFS_ATTR_SIZE];
 	struct stat st;
 
@@ -350,6 +352,22 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	if (!memdev->dev_path)
 		goto err_read;
 
+	rpath = realpath(cxlmem_base, NULL);
+	if (!rpath)
+		goto err_read;
+	host = strrchr(rpath, '/');
+	if (host) {
+		host[0] = '\0';
+		host = strrchr(rpath, '/');
+	}
+	if (!host)
+		goto err_read;
+	memdev->host = strdup(host + 1);
+	if (!memdev->host)
+		goto err_read;
+	free(rpath);
+	rpath = NULL;
+
 	sprintf(path, "%s/firmware_version", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
@@ -381,6 +399,7 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	free(memdev->dev_buf);
 	free(memdev->dev_path);
 	free(memdev);
+	free(rpath);
  err_dev:
 	free(path);
 	return NULL;
@@ -431,6 +450,11 @@ CXL_EXPORT const char *cxl_memdev_get_devname(struct cxl_memdev *memdev)
 	return devpath_to_devname(memdev->dev_path);
 }
 
+CXL_EXPORT const char *cxl_memdev_get_host(struct cxl_memdev *memdev)
+{
+	return memdev->host;
+}
+
 CXL_EXPORT int cxl_memdev_get_major(struct cxl_memdev *memdev)
 {
 	return memdev->major;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index dc2863e150cf..8f0688a95f5d 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -77,6 +77,7 @@ local:
 LIBCXL_2 {
 global:
 	cxl_memdev_get_serial;
+	cxl_memdev_get_host;
 	cxl_bus_get_first;
 	cxl_bus_get_next;
 	cxl_bus_get_provider;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index cedd2f2361a1..b097bdfbfd6b 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -22,6 +22,7 @@ struct cxl_memdev {
 	int id, major, minor;
 	void *dev_buf;
 	size_t buf_len;
+	char *host;
 	char *dev_path;
 	char *firmware_version;
 	struct cxl_ctx *ctx;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index a60777ed0c7a..5487b55d2fc0 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -38,6 +38,7 @@ struct cxl_memdev *cxl_memdev_get_next(struct cxl_memdev *memdev);
 int cxl_memdev_get_id(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_serial(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_devname(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_host(struct cxl_memdev *memdev);
 int cxl_memdev_get_major(struct cxl_memdev *memdev);
 int cxl_memdev_get_minor(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);

