Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B0DC433E0
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jan 2021 00:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792D222D58
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jan 2021 00:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbhALAgR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:36:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:52243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbhALAgO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 11 Jan 2021 19:36:14 -0500
IronPort-SDR: GhBzkOsAFlVXW6M8VPah/xZBUfSmibpbf9d4v04n6Bh1DxJlJ/6pX7NnEBJmV1LWWdmsCNw8WU
 RLy5uV18CFHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157736803"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157736803"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:26 -0800
IronPort-SDR: dLFy2R7vc+QxzXFpJ3FtCNo3ojkpsrMa2mHlysSznFSzBR3bKQULQm4NX5r7m1E9HvrWSuSpbL
 tonXzFrosXxQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381212107"
Received: from ecbackus-mobl1.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.212.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:25 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl RFC PATCH 5/5] cxl/list: augment cxl-list with more data from the identify command
Date:   Mon, 11 Jan 2021 17:34:03 -0700
Message-Id: <20210112003403.2944568-6-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112003403.2944568-1-vishal.l.verma@intel.com>
References: <20210112003403.2944568-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Augment cxl-list with some more fields obtained from sending an
'Identify' command to the device. If/when these fields are added to the
sysfs representation of the memdev, the command submission detour can be
removed and replaced with data from sysfs.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 util/json.h |  3 ++-
 cxl/list.c  | 29 +++++++++++++++++++++++++++--
 util/json.c | 22 +++++++++++++++++++++-
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/util/json.h b/util/json.h
index 91918c8..831f9bb 100644
--- a/util/json.h
+++ b/util/json.h
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <ndctl/libndctl.h>
 #include <daxctl/libdaxctl.h>
+#include <cxl/libcxl.h>
 #include <ccan/short_types/short_types.h>
 
 enum util_json_flags {
@@ -57,5 +58,5 @@ struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
 struct json_object *util_region_capabilities_to_json(struct ndctl_region *region);
 struct cxl_memdev;
 struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
-		unsigned long flags);
+		struct cxl_cmd *id, unsigned long flags);
 #endif /* __NDCTL_JSON_H__ */
diff --git a/cxl/list.c b/cxl/list.c
index 3d44244..7afe2b4 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
+#include <util/log.h>
 #include <util/json.h>
 #include <util/filter.h>
 #include <json-c/json.h>
@@ -16,6 +17,7 @@ static struct {
 	bool memdevs;
 	bool idle;
 	bool human;
+	bool verbose;
 } list;
 
 static unsigned long listopts_to_flags(void)
@@ -47,6 +49,19 @@ static int num_list_flags(void)
 	return list.memdevs;
 }
 
+struct cxl_cmd *memdev_identify(struct cxl_memdev *memdev)
+{
+	struct cxl_cmd *id;
+
+	id = cxl_cmd_new_identify(memdev);
+	if (!id)
+		return NULL;
+
+	if (cxl_cmd_submit(id) != 0)
+		return NULL;
+	return id;
+}
+
 int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 {
 	const struct option options[] = {
@@ -56,7 +71,9 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 			    "include CXL memory device info"),
 		OPT_BOOLEAN('i', "idle", &list.idle, "include idle devices"),
 		OPT_BOOLEAN('u', "human", &list.human,
-				"use human friendly number formats "),
+				"use human friendly number formats"),
+		OPT_BOOLEAN('v', "verbose", &list.verbose,
+				"enable verbose output"),
 		OPT_END(),
 	};
 	const char * const u[] = {
@@ -80,27 +97,35 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 
 	list_flags = listopts_to_flags();
 
+	if (list.verbose)
+		cxl_set_log_priority(ctx, LOG_DEBUG);
+
 	cxl_memdev_foreach(ctx, memdev) {
 		struct json_object *jdev = NULL;
+		struct cxl_cmd *id;
 
 		if (!util_cxl_memdev_filter(memdev, param.memdev))
 			continue;
 
 		if (list.memdevs) {
+			id = memdev_identify(memdev);
 			if (!jdevs) {
 				jdevs = json_object_new_array();
 				if (!jdevs) {
 					fail("\n");
+					cxl_cmd_unref(id);
 					continue;
 				}
 			}
 
-			jdev = util_cxl_memdev_to_json(memdev, list_flags);
+			jdev = util_cxl_memdev_to_json(memdev, id, list_flags);
 			if (!jdev) {
 				fail("\n");
+				cxl_cmd_unref(id);
 				continue;
 			}
 			json_object_array_add(jdevs, jdev);
+			cxl_cmd_unref(id);
 		}
 	}
 
diff --git a/util/json.c b/util/json.c
index a855571..24d4477 100644
--- a/util/json.c
+++ b/util/json.c
@@ -1432,10 +1432,11 @@ struct json_object *util_badblock_rec_to_json(u64 block, u64 count,
 }
 
 struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
-		unsigned long flags)
+		struct cxl_cmd *id, unsigned long flags)
 {
 	const char *devname = cxl_memdev_get_devname(memdev);
 	struct json_object *jdev, *jobj;
+	char fw_rev[0x10];
 
 	jdev = json_object_new_object();
 	if (!devname || !jdev)
@@ -1453,5 +1454,24 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "ram_size", jobj);
 
+	if (!id)
+		return jdev;
+
+	if (cxl_cmd_identify_get_fw_rev(id, fw_rev, 0x10) == 0) {
+		jobj = json_object_new_string(fw_rev);
+		if (jobj)
+			json_object_object_add(jdev, "fw_revision", jobj);
+	}
+
+	jobj = util_json_object_size(cxl_cmd_identify_get_partition_align(id),
+			flags);
+	if (jobj)
+		json_object_object_add(jdev, "partition_align", jobj);
+
+	jobj = util_json_object_size(cxl_cmd_identify_get_lsa_size(id),
+			flags);
+	if (jobj)
+		json_object_object_add(jdev, "lsa_size", jobj);
+
 	return jdev;
 }
-- 
2.29.2

