Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59787C77B71
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 17:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDNRnn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDNRnJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 13:43:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B912A
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681494188; x=1713030188;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D17v21YpLM9pPZnMM4VddUr5WS5Dr7kwTGK5ugOy8oc=;
  b=k4PBU+2tvwSx6B7OtiQn2vAxJvyH3uEd2IXVq7kkGA4hHfHYu/iYIQ1q
   w17vrD8EofsvaHCu9VYOwNtGAOavhr23krAP17IYdGDSAe6Qeq5Z570wZ
   jO96WNBWyTw7Q5FuWdOtzWmQoQZdd/9YAO9OGaGKv1DaB033MOjb8TrHX
   7G04TGyldi8JFj/5pOOWRU3ZOc0CatYgQSdhFRNbPYltlKoBLCbwUgcet
   WVhwkBzGIpqNP4TPzfpYTKuwG3dPhm/yrVbCKPK4rc9ONF4Ec0RVNFkuM
   9vKxPwSaU4pgnJLJo0xWroJ8Bnd466nuy9zqC8ftWQNwE81cgOMPPL819
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="347247055"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="347247055"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="801281257"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="801281257"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.122.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:43:07 -0700
Subject: [NDCTL PATCH 2/3] ndctl: Add QTG ID support for the memory device
From:   Dave Jiang <dave.jiang@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org
Date:   Fri, 14 Apr 2023 10:43:07 -0700
Message-ID: <168149418730.4013891.3864941985901182081.stgit@djiang5-mobl3>
In-Reply-To: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
References: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add libcxl API to retrieve the QoS Throttling Group (QTG) ID for the
memory devices. Two API calls are added. One for 'ram' or 'volatile'
mode and another for 'pmem' or 'persistent' mode. Support also added
for displaying the QTG ID through the 'cxl list' command.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/json.c         |   12 +++++++++++-
 cxl/lib/libcxl.c   |   20 ++++++++++++++++++++
 cxl/lib/libcxl.sym |    2 ++
 cxl/lib/private.h  |    2 ++
 cxl/libcxl.h       |    2 ++
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/cxl/json.c b/cxl/json.c
index 8dd65f942c6a..9a508cf7950e 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -486,7 +486,7 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	const char *devname = cxl_memdev_get_devname(memdev);
 	struct json_object *jdev, *jobj;
 	unsigned long long serial, size;
-	int numa_node;
+	int numa_node, qtg_id;
 
 	jdev = json_object_new_object();
 	if (!jdev)
@@ -501,6 +501,11 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		jobj = util_json_object_size(size, flags);
 		if (jobj)
 			json_object_object_add(jdev, "pmem_size", jobj);
+
+		qtg_id = cxl_memdev_get_pmem_qtg_id(memdev);
+		jobj = json_object_new_int(qtg_id);
+		if (jobj)
+			json_object_object_add(jdev, "qtg_id", jobj);
 	}
 
 	size = cxl_memdev_get_ram_size(memdev);
@@ -508,6 +513,11 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		jobj = util_json_object_size(size, flags);
 		if (jobj)
 			json_object_object_add(jdev, "ram_size", jobj);
+
+		qtg_id = cxl_memdev_get_ram_qtg_id(memdev);
+		jobj = json_object_new_int(qtg_id);
+		if (jobj)
+			json_object_object_add(jdev, "qtg_id", jobj);
 	}
 
 	if (flags & UTIL_JSON_HEALTH) {
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 26985c9344b4..dca1683523a1 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1210,6 +1210,16 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 		goto err_read;
 	memdev->ram_size = strtoull(buf, NULL, 0);
 
+	sprintf(path, "%s/pmem/qtg_id", cxlmem_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	memdev->pmem_qtg_id = atoi(buf);
+
+	sprintf(path, "%s/ram/qtg_id", cxlmem_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	memdev->ram_qtg_id = atoi(buf);
+
 	sprintf(path, "%s/payload_max", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
@@ -1368,6 +1378,16 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev)
 	return memdev->ram_size;
 }
 
+CXL_EXPORT int cxl_memdev_get_pmem_qtg_id(struct cxl_memdev *memdev)
+{
+	return memdev->pmem_qtg_id;
+}
+
+CXL_EXPORT int cxl_memdev_get_ram_qtg_id(struct cxl_memdev *memdev)
+{
+	return memdev->ram_qtg_id;
+}
+
 CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)
 {
 	return memdev->firmware_version;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index d1c61f9252fe..60ad16e33f30 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -249,4 +249,6 @@ global:
 	cxl_decoder_create_ram_region;
 	cxl_region_get_daxctl_region;
 	cxl_decoder_get_qtg_id;
+	cxl_memdev_get_pmem_qtg_id;
+	cxl_memdev_get_ram_qtg_id;
 } LIBCXL_4;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index ac6f111b5956..dfd77ff2a781 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -32,6 +32,8 @@ struct cxl_memdev {
 	struct list_node list;
 	unsigned long long pmem_size;
 	unsigned long long ram_size;
+	int pmem_qtg_id;
+	int ram_qtg_id;
 	int payload_max;
 	size_t lsa_size;
 	struct kmod_module *module;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 66ce4a021c62..c89806cbbd57 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -47,6 +47,8 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
+int cxl_memdev_get_pmem_qtg_id(struct cxl_memdev *memdev);
+int cxl_memdev_get_ram_qtg_id(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
 
 /* ABI spelling mistakes are forever */


