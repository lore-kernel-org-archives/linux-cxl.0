Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF192C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiAXAwm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:43260 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwm (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985562; x=1674521562;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7zMNhRBjiTSQdaDY2CzV/22LPa2Lkl0nVWHtOQVMAIA=;
  b=FcV5/0lO1iKzSky4bjFNSOVDPDHZytydphBN3khMB3e1u+t5Mx3cF0+E
   ZHQeDQA8LlRPpjxzRvmUawjho9TDifnAzgkFAk5EI7WBr9zE20EHCrHDr
   aMA4qPXFI2usxobwmmeOjyeVmiHBn+6ZjvmLEp4rGBCN3jAaCP08VPQ30
   oFl331VxBeqWaMnR0d8NJv7q8lOkwYORDC9oGHqDmuCVPoRcvzq/K/+Dk
   jwcS74OqmtCKjDsLgvpflrnmCpyxRiP3de/7x63Z4Xaw4bCIrF5AdHd6r
   dXpjIba/zIloVRQ+gK8OER8KS9IPi2ejP0ZEUjoTA484A+FTiEVQNFbv0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244768252"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244768252"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596630632"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:41 -0800
Subject: [ndctl PATCH 10/37] cxl/list: Add filter by serial support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:41 -0800
Message-ID: <164298556167.3021641.5470955268978068465.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Given that serial numbers are intended to be unique device identifiers,
enable them as a memdev filter option.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-list.txt |    4 ++++
 cxl/filter.c                   |   38 ++++++++++++++++++++++++++++++++++----
 cxl/filter.h                   |    4 +++-
 cxl/list.c                     |    4 +++-
 cxl/memdev.c                   |    2 +-
 5 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index bd0207e942cb..224c972498ea 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -64,6 +64,10 @@ OPTIONS
 ]
 ----
 
+-s::
+--serial=::
+	Specify CXL memory device serial number(s) to filter the listing
+
 -M::
 --memdevs::
 	Include CXL memory devices in the listing
diff --git a/cxl/filter.c b/cxl/filter.c
index d1ff4b62c806..26efc65f4dd7 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -21,15 +21,45 @@ static const char *which_sep(const char *filter)
 	return " ";
 }
 
+static struct cxl_memdev *
+util_cxl_memdev_serial_filter(struct cxl_memdev *memdev, const char *__serials)
+{
+	unsigned long long serial = 0;
+	char *serials, *save, *end;
+	const char *arg;
+
+	if (!__serials)
+		return memdev;
+
+	serials = strdup(__serials);
+	if (!serials)
+		return NULL;
+
+	for (arg = strtok_r(serials, which_sep(__serials), &save); arg;
+	     arg = strtok_r(NULL, which_sep(__serials), &save)) {
+		serial = strtoull(arg, &end, 0);
+		if (!arg[0] || end[0] != 0)
+			continue;
+		if (cxl_memdev_get_serial(memdev) == serial)
+			break;
+	}
+
+	free(serials);
+	if (arg)
+		return memdev;
+	return NULL;
+}
+
 struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
-					  const char *__ident)
+					  const char *__ident,
+					  const char *serials)
 {
 	char *ident, *save;
 	const char *name;
 	int memdev_id;
 
 	if (!__ident)
-		return memdev;
+		return util_cxl_memdev_serial_filter(memdev, serials);
 
 	ident = strdup(__ident);
 	if (!ident)
@@ -51,7 +81,7 @@ struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
 
 	free(ident);
 	if (name)
-		return memdev;
+		return util_cxl_memdev_serial_filter(memdev, serials);
 	return NULL;
 }
 
@@ -82,7 +112,7 @@ int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
 	cxl_memdev_foreach(ctx, memdev) {
 		struct json_object *jdev;
 
-		if (!util_cxl_memdev_filter(memdev, p->memdev_filter))
+		if (!util_cxl_memdev_filter(memdev, p->memdev_filter, p->serial_filter))
 			continue;
 		if (p->memdevs) {
 			jdev = util_cxl_memdev_to_json(memdev, flags);
diff --git a/cxl/filter.h b/cxl/filter.h
index 664b74b23b0a..12d934474554 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -8,6 +8,7 @@
 
 struct cxl_filter_params {
 	const char *memdev_filter;
+	const char *serial_filter;
 	bool memdevs;
 	bool idle;
 	bool human;
@@ -16,6 +17,7 @@ struct cxl_filter_params {
 };
 
 struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
-					  const char *ident);
+					  const char *__ident,
+					  const char *serials);
 int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *param);
 #endif /* _CXL_UTIL_FILTER_H_ */
diff --git a/cxl/list.c b/cxl/list.c
index 17303073b49a..6bc48df0ea84 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -24,6 +24,8 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 	const struct option options[] = {
 		OPT_STRING('m', "memdev", &param.memdev_filter, "memory device name",
 			   "filter by CXL memory device name"),
+		OPT_STRING('s', "serial", &param.serial_filter, "memory device serial",
+			   "filter by CXL memory device serial number"),
 		OPT_BOOLEAN('M', "memdevs", &param.memdevs,
 			    "include CXL memory device info"),
 		OPT_BOOLEAN('i', "idle", &param.idle, "include disabled devices"),
@@ -47,7 +49,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		usage_with_options(u, options);
 
 	if (num_list_flags() == 0) {
-		if (param.memdev_filter)
+		if (param.memdev_filter || param.serial_filter)
 			param.memdevs = true;
 		else {
 			/*
diff --git a/cxl/memdev.c b/cxl/memdev.c
index d063d51cc571..b9141be62c87 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -248,7 +248,7 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 			continue;
 
 		cxl_memdev_foreach (ctx, memdev) {
-			if (!util_cxl_memdev_filter(memdev, argv[i]))
+			if (!util_cxl_memdev_filter(memdev, argv[i], NULL))
 				continue;
 
 			if (action == action_write) {

