Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F707C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiAXAxK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:53:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:46164 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240659AbiAXAxJ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985588; x=1674521588;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEzuoGO/1UwU2IYMoBZPOwl3z+8b5Pi3SGWpWbyq8rI=;
  b=egZIiV8AQc/lMxD2+wABHIvD9cIbBiwKVc5Q4DqB/lPHiivyU/ugLupt
   ERKi5xJDVwZTp4EDAHPdmT4dtfEpaRTIi/BySnuxOaimAxMOzM526TeJS
   FvhMGrpupDA3KbB/FQpanWzib+lsSG+l8qym0dv0GAPp8XSO8BzJWXV9v
   suYWJaLbTU7bzG9Jae16FQmQXRNL30D58AC0LGBgqFod4PuwUfwCBMSND
   4J3aUNFPYm4UWA9FHclqxOG9tKjy/f62wUhi2Am95WCDx/yCXr2ui5Lk9
   DxFywFQuqYVPn7oeKWlO4dcHO7DWfqBn3S2tI+bec2mdkASa+3LWtPi3x
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246153046"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246153046"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596630693"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:08 -0800
Subject: [ndctl PATCH 15/37] util/json: Warn on stderr about empty list
 results
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:53:08 -0800
Message-ID: <164298558814.3021641.13051269428355986099.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Help interactive users notice something is wrong with the list parameters
by warning that no devices matched the specified filter settings.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 util/json.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/util/json.c b/util/json.c
index bd5f8fc47a2b..f8cc81f6e706 100644
--- a/util/json.c
+++ b/util/json.c
@@ -3,6 +3,7 @@
 #include <limits.h>
 #include <string.h>
 #include <stdio.h>
+#include <util/util.h>
 #include <util/json.h>
 #include <json-c/json.h>
 #include <json-c/printbuf.h>
@@ -95,9 +96,11 @@ void util_display_json_array(FILE *f_out, struct json_object *jarray,
 	int len = json_object_array_length(jarray);
 	int jflag = JSON_C_TO_STRING_PRETTY;
 
-	if (json_object_array_length(jarray) > 1 || !(flags & UTIL_JSON_HUMAN))
+	if (len > 1 || !(flags & UTIL_JSON_HUMAN)) {
+		if (len == 0)
+			warning("no matching devices found\n");
 		fprintf(f_out, "%s\n", json_object_to_json_string_ext(jarray, jflag));
-	else if (len) {
+	} else if (len) {
 		struct json_object *jobj;
 
 		jobj = json_object_array_get_idx(jarray, 0);

