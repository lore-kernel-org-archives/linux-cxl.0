Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD22C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbiAXAwV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:8699 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwV (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985541; x=1674521541;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gIl0LMGiyWB84AFs7TueUh77sY+5EatOxuI43f2vfPE=;
  b=kpr3RKNz/buLeF4yE5fXyAHt6ace+9vjAVXNU2JHNbrBJalfcorgLvBp
   pyPMaevfvTQzJ/HiWxvSbty7QK11Ayi8uRu0IpdRNfnS+29W30+yI3OTT
   d3nIZ4d3BXoYKWXwBGPYvAWYkVMTJtqomNg3LfjRRwpLeifH6ReXMZMBF
   cuY21M7dbbxO/VfVRwj45r60rSOhgjl1ioaZ0RMDRtw1o/l8+Q7Rnse/E
   vhAFT1WS38Dy4bw/Kg5noYDQIgxDHH8XfZYyBVXA/w5QWyUtM3obxrGkg
   ShHt/t3LYzEyJj0r9cSksmq7GM78sE7h2fMz2SaJx4bIpNrTjevUaCEp5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332290506"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332290506"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="673456327"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:21 -0800
Subject: [ndctl PATCH 06/37] cxl/list: Support multiple memdev device name
 filter arguments
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:20 -0800
Message-ID: <164298554075.3021641.17678360870961637912.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Similar to 'ndctl list', allow for a syntax like:

    cxl list -m "$(seq -s ' ' 2 5)"

...to filter the output to just those 4 memdevs.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-list.txt |   21 ++++++++++++++++++++-
 cxl/filter.c                   |   38 +++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index c8d10fb5ef86..686e0ea768f0 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -30,7 +30,7 @@ OPTIONS
 -------
 -m::
 --memdev=::
-	Specify a cxl memory device name to filter the listing. For example:
+	Specify CXL memory device name(s), or device id(s), to filter the listing. For example:
 ----
 # cxl list --memdev=mem0
 {
@@ -38,6 +38,25 @@ OPTIONS
   "pmem_size":268435456,
   "ram_size":0,
 }
+
+# cxl list -m "0 mem1 2"
+[
+  {
+    "memdev":"mem0",
+    "pmem_size":268435456,
+    "ram_size":0
+  },
+  {
+    "memdev":"mem2",
+    "pmem_size":268435456,
+    "ram_size":268435456
+  },
+  {
+    "memdev":"mem1",
+    "pmem_size":268435456,
+    "ram_size":268435456
+  }
+]
 ----
 
 -M::
diff --git a/cxl/filter.c b/cxl/filter.c
index 21322ed4b4d0..efafaf5a3197 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -2,24 +2,40 @@
 // Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
 #include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
 #include <cxl/libcxl.h>
 #include "filter.h"
 
 struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
-                                         const char *ident)
+					  const char *__ident)
 {
-       int memdev_id;
+	char *ident, *save;
+	const char *name;
+	int memdev_id;
 
-       if (!ident || strcmp(ident, "all") == 0)
-               return memdev;
+	if (!__ident)
+		return memdev;
 
-       if (strcmp(ident, cxl_memdev_get_devname(memdev)) == 0)
-               return memdev;
+	ident = strdup(__ident);
+	if (!ident)
+		return NULL;
 
-       if ((sscanf(ident, "%d", &memdev_id) == 1
-                       || sscanf(ident, "mem%d", &memdev_id) == 1)
-                       && cxl_memdev_get_id(memdev) == memdev_id)
-               return memdev;
+	for (name = strtok_r(ident, " ", &save); name;
+	     name = strtok_r(NULL, " ", &save)) {
+		if (strcmp(name, "all") == 0)
+			break;
 
-       return NULL;
+		if ((sscanf(name, "%d", &memdev_id) == 1 ||
+		     sscanf(name, "mem%d", &memdev_id) == 1) &&
+		    cxl_memdev_get_id(memdev) == memdev_id)
+			break;
+
+		if (strcmp(name, cxl_memdev_get_devname(memdev)) == 0)
+			break;
+	}
+
+	free(ident);
+	if (name)
+		return memdev;
+	return NULL;
 }

