Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1AC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbiAXAyN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:54:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:50319 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbiAXAyN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985653; x=1674521653;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N5krYuICLkseMYpurEurIFF8ViUohFRRZLYVobxhBIM=;
  b=XgEJeuyR84IyY3F45UtPs+CCGgfy0ZCZOg+h02rkSflguJ4cbDH21IJz
   fLMvQ3eT1LsKI8zVxwyKyQ69bakZgEupd6icl3ukzzSQXUKGBs4ctbVG9
   oCV1tGNRWf8USu6XP8RkUBDaZNjQuzalsrqMTlpkVPvafiofrXEIYS6j+
   aupNs54GFaE44GV6K1Ld2OrIJCIJTuudtwBpf71Rg1Bmi1lpYIxQwfuns
   VKc3SsRnpfJ/p28SrwhXphVYYg2BOPDzGWvBrR6NZiHu63B8gCiw9bpaw
   d+5KwC/v41IN36+NZGkgjFnipzlpZgksYtCmgGOYv4UfgCAhkFmU4VGg5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243530647"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243530647"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596630808"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:11 -0800
Subject: [ndctl PATCH 27/37] cxl/list: Add 'numa_node' to memdev listings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:54:11 -0800
Message-ID: <164298565156.3021641.14097226245654611710.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If the kernel exports a valid numa_node, >= 0, include it in memdev objects
listings.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/lib/libcxl.txt |    4 ++++
 cxl/json.c                       |    8 ++++++++
 cxl/lib/libcxl.c                 |   11 +++++++++++
 cxl/lib/libcxl.sym               |    1 +
 cxl/lib/private.h                |    1 +
 cxl/libcxl.h                     |    1 +
 6 files changed, 26 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index b0253d7be07c..de88d192523a 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -71,6 +71,7 @@ unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
+int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
 ----
 
 A memdev is given a kernel device name of the form "mem%d" where an id
@@ -89,6 +90,9 @@ The 'pmem_size' and 'ram_size' attributes return the current
 provisioning of DPA (Device Physical Address / local capacity) in the
 device.
 
+cxl_memdev_get_numa_node() returns the affinitized CPU node number if
+available or -1 otherwise.
+
 === MEMDEV: Commands
 ----
 struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev, int opcode);
diff --git a/cxl/json.c b/cxl/json.c
index b809332b8d51..51918d65f671 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -190,6 +190,7 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	const char *devname = cxl_memdev_get_devname(memdev);
 	struct json_object *jdev, *jobj;
 	unsigned long long serial;
+	int numa_node;
 
 	jdev = json_object_new_object();
 	if (!jdev)
@@ -220,6 +221,13 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 			json_object_object_add(jdev, "serial", jobj);
 	}
 
+	numa_node = cxl_memdev_get_numa_node(memdev);
+	if (numa_node >= 0) {
+		jobj = json_object_new_int(numa_node);
+		if (jobj)
+			json_object_object_add(jdev, "numa_node", jobj);
+	}
+
 	jobj = json_object_new_string(cxl_memdev_get_host(memdev));
 	if (jobj)
 		json_object_object_add(jdev, "host", jobj);
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 0065f6baeead..14c7db88ff5e 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -348,6 +348,12 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	else
 		memdev->serial = strtoull(buf, NULL, 0);
 
+	sprintf(path, "%s/numa_node", cxlmem_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		memdev->numa_node = -1;
+	else
+		memdev->numa_node = strtol(buf, NULL, 0);
+
 	memdev->dev_path = strdup(cxlmem_base);
 	if (!memdev->dev_path)
 		goto err_read;
@@ -445,6 +451,11 @@ CXL_EXPORT unsigned long long cxl_memdev_get_serial(struct cxl_memdev *memdev)
 	return memdev->serial;
 }
 
+CXL_EXPORT int cxl_memdev_get_numa_node(struct cxl_memdev *memdev)
+{
+	return memdev->numa_node;
+}
+
 CXL_EXPORT const char *cxl_memdev_get_devname(struct cxl_memdev *memdev)
 {
 	return devpath_to_devname(memdev->dev_path);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 29f34988e42f..b13a2d6d25d1 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -77,6 +77,7 @@ local:
 LIBCXL_2 {
 global:
 	cxl_memdev_get_serial;
+	cxl_memdev_get_numa_node;
 	cxl_memdev_get_host;
 	cxl_bus_get_first;
 	cxl_bus_get_next;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index b097bdfbfd6b..c00bb3600138 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -20,6 +20,7 @@ struct cxl_pmem {
 struct cxl_endpoint;
 struct cxl_memdev {
 	int id, major, minor;
+	int numa_node;
 	void *dev_buf;
 	size_t buf_len;
 	char *host;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index e7b675e5328f..be656ed0d90d 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -37,6 +37,7 @@ struct cxl_memdev *cxl_memdev_get_first(struct cxl_ctx *ctx);
 struct cxl_memdev *cxl_memdev_get_next(struct cxl_memdev *memdev);
 int cxl_memdev_get_id(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_serial(struct cxl_memdev *memdev);
+int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_devname(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_host(struct cxl_memdev *memdev);
 struct cxl_bus *cxl_memdev_get_bus(struct cxl_memdev *memdev);

