Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A4C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbiAXAwh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:8720 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwg (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985556; x=1674521556;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRZhMssWva2iAQrYOI28+YnglDuqKCXKGQfcfBO/qLw=;
  b=gbUGN5a3HVZJ/cc8WTYaCv8A/NOCVk2ccPnl0ZPfxdmEm1CS6D+tlP4h
   hcSgJ9Zh6RyE5JAsBZVgU+OD/MSTG2I6IHEUvDXOEo2d72M2MNwOp7YTp
   WTnD5ktaXqrvLpGr9fKuRk0/CzimrlkQA6/lXgU/WPUQm7TuwOMTTB8/J
   XKdOV1jgmO7FzzBPKQU4p1Tc2OfRMiAP4rjrNRtvj5uXAfSMAnR7n9Emx
   QOr5Br5nB30LwVjMW/dJ1qJAKrDm2lLOIYo4kj+kjTYwYfDuydNqQAp+Q
   eAW5KW/TIVElKbw/XVehPZraSEbKTMxGTGmuP+eLqjIA4yz56IGJEvoE9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332290515"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332290515"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="766233178"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:36 -0800
Subject: [ndctl PATCH 09/37] cxl/list: Emit device serial numbers
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:36 -0800
Message-ID: <164298555630.3021641.3246226448369816200.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Starting with the v5.17 kernel the CXL driver emits the mandatory device
serial number for each memory device. Include it in the memory device
listing.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-list.txt |   15 +++++++++------
 cxl/json.c                     |   11 ++++++++++-
 cxl/lib/libcxl.c               |   11 +++++++++++
 cxl/lib/libcxl.sym             |    5 +++++
 cxl/lib/private.h              |    1 +
 cxl/libcxl.h                   |    1 +
 6 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 4d409babb99a..bd0207e942cb 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -41,22 +41,25 @@ OPTIONS
   "ram_size":0,
 }
 
-# cxl list -m "0 mem1 2"
+# cxl list -M --memdev="0 mem3 5"
 [
   {
     "memdev":"mem0",
     "pmem_size":268435456,
-    "ram_size":0
+    "ram_size":0,
+    "serial":0
   },
   {
-    "memdev":"mem2",
+    "memdev":"mem3",
     "pmem_size":268435456,
-    "ram_size":268435456
+    "ram_size":268435456,
+    "serial":2
   },
   {
-    "memdev":"mem1",
+    "memdev":"mem5",
     "pmem_size":268435456,
-    "ram_size":268435456
+    "ram_size":268435456,
+    "serial":4
   }
 ]
 ----
diff --git a/cxl/json.c b/cxl/json.c
index 3ef9f7670510..d8e65df241a1 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
+// Copyright (C) 2015-2021 Intel Corporation. All rights reserved.
+#include <limits.h>
 #include <util/json.h>
 #include <uuid/uuid.h>
 #include <cxl/libcxl.h>
@@ -188,6 +189,7 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 {
 	const char *devname = cxl_memdev_get_devname(memdev);
 	struct json_object *jdev, *jobj;
+	unsigned long long serial;
 
 	jdev = json_object_new_object();
 	if (!jdev)
@@ -210,5 +212,12 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		if (jobj)
 			json_object_object_add(jdev, "health", jobj);
 	}
+
+	serial = cxl_memdev_get_serial(memdev);
+	if (serial < ULLONG_MAX) {
+		jobj = util_json_object_hex(serial, flags);
+		if (jobj)
+			json_object_object_add(jdev, "serial", jobj);
+	}
 	return jdev;
 }
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 3390eb91ecb5..8d3cf8092c8b 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -296,6 +296,12 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	if (memdev->lsa_size == ULLONG_MAX)
 		goto err_read;
 
+	sprintf(path, "%s/serial", cxlmem_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		memdev->serial = ULLONG_MAX;
+	else
+		memdev->serial = strtoull(buf, NULL, 0);
+
 	memdev->dev_path = strdup(cxlmem_base);
 	if (!memdev->dev_path)
 		goto err_read;
@@ -371,6 +377,11 @@ CXL_EXPORT int cxl_memdev_get_id(struct cxl_memdev *memdev)
 	return memdev->id;
 }
 
+CXL_EXPORT unsigned long long cxl_memdev_get_serial(struct cxl_memdev *memdev)
+{
+	return memdev->serial;
+}
+
 CXL_EXPORT const char *cxl_memdev_get_devname(struct cxl_memdev *memdev)
 {
 	return devpath_to_devname(memdev->dev_path);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 077d10434cde..4411035f962a 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -73,3 +73,8 @@ global:
 local:
         *;
 };
+
+LIBCXL_2 {
+global:
+	cxl_memdev_get_serial;
+} LIBCXL_1;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index a1b8b507225e..28f7e16dbd04 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -31,6 +31,7 @@ struct cxl_memdev {
 	size_t lsa_size;
 	struct kmod_module *module;
 	struct cxl_nvdimm_bridge *bridge;
+	unsigned long long serial;
 };
 
 enum cxl_cmd_query_status {
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 89d35ba957e6..bcdede8f12e8 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -35,6 +35,7 @@ struct cxl_memdev;
 struct cxl_memdev *cxl_memdev_get_first(struct cxl_ctx *ctx);
 struct cxl_memdev *cxl_memdev_get_next(struct cxl_memdev *memdev);
 int cxl_memdev_get_id(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_serial(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_devname(struct cxl_memdev *memdev);
 int cxl_memdev_get_major(struct cxl_memdev *memdev);
 int cxl_memdev_get_minor(struct cxl_memdev *memdev);

