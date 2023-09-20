Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597A3CD4935
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Sep 2023 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjITW5x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 20 Sep 2023 18:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITW5x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 20 Sep 2023 18:57:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA64C1
        for <linux-cxl@vger.kernel.org>; Wed, 20 Sep 2023 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695250667; x=1726786667;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QkC/y4/2NQg3uYm6BWWtgtb4APj7mQXM+aIwQ9VqJNk=;
  b=BBoNwq2g2uoQSoTQE0k5RcYpTEhhr7zUlPw2o09F9v1pZBsRird/0zGt
   k31J8nRKKEN5pcaQLFHNCtzi5B9u48AiLzJ9yjewd+tTOE8XFKP/r5LZD
   SiyWGjkbgL2IW5OsRljk/FXM5fhjxP+/CDB6ori0RSJU0dS9xbAVRXpQF
   2I5F9OFkMu4egUAx1MxtsEgLQHUm5Fd7gdClqNKfquldRXwE3e+1sMh2L
   fO08mH8s+g6UatfZt58efL96vHjjoXvuWVGNAjjTrCok5gCC7/sRo0SJl
   l0+atz9gcix2WOaMvZG+vm9+MiZuXPeQ1IHFW1tOdVZ2xnC9+sMbRqjO/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444462139"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="444462139"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 15:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="781905440"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="781905440"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.114.229])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 15:57:29 -0700
Subject: [NDCTL PATCH v2] cxl/region: Add -f option for disable-region
From:   Dave Jiang <dave.jiang@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Wed, 20 Sep 2023 15:57:29 -0700
Message-ID: <169525064907.3085225.2583864429793298106.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The current operation for disable_region does not check if the memory
covered by a region is online before attempting to disable the cxl region.
Provide a -f option for the region to force offlining of currently online
memory before disabling the region. Also add a check to fail the operation
entirely if the memory is non-movable.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Update documentation and help output. (Vishal)
---
 Documentation/cxl/cxl-disable-region.txt |    7 ++++
 cxl/region.c                             |   49 +++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/cxl/cxl-disable-region.txt b/Documentation/cxl/cxl-disable-region.txt
index 6a39aee6ea69..9b98d4d8745a 100644
--- a/Documentation/cxl/cxl-disable-region.txt
+++ b/Documentation/cxl/cxl-disable-region.txt
@@ -25,6 +25,13 @@ OPTIONS
 -------
 include::bus-option.txt[]
 
+-f::
+--force::
+	Attempt to offline any memory that has been hot-added into the system
+	via the CXL region before disabling the region. This won't be attempted
+	if the memory was not added as 'movable', and may still fail even if it
+	was movable.
+
 include::decoder-option.txt[]
 
 include::debug-option.txt[]
diff --git a/cxl/region.c b/cxl/region.c
index bcd703956207..f8303869727a 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -14,6 +14,7 @@
 #include <util/parse-options.h>
 #include <ccan/minmax/minmax.h>
 #include <ccan/short_types/short_types.h>
+#include <daxctl/libdaxctl.h>
 
 #include "filter.h"
 #include "json.h"
@@ -95,6 +96,8 @@ static const struct option enable_options[] = {
 
 static const struct option disable_options[] = {
 	BASE_OPTIONS(),
+	OPT_BOOLEAN('f', "force", &param.force,
+		    "attempt to offline memory before disabling the region"),
 	OPT_END(),
 };
 
@@ -789,13 +792,57 @@ static int destroy_region(struct cxl_region *region)
 	return cxl_region_delete(region);
 }
 
+static int disable_region(struct cxl_region *region)
+{
+	const char *devname = cxl_region_get_devname(region);
+	struct daxctl_region *dax_region;
+	struct daxctl_memory *mem;
+	struct daxctl_dev *dev;
+	int rc;
+
+	dax_region = cxl_region_get_daxctl_region(region);
+	if (!dax_region)
+		goto out;
+
+	daxctl_dev_foreach(dax_region, dev) {
+		mem = daxctl_dev_get_memory(dev);
+		if (!mem)
+			return -ENXIO;
+
+		if (daxctl_memory_online_no_movable(mem)) {
+			log_err(&rl, "%s: memory unmovable for %s\n",
+					devname,
+					daxctl_dev_get_devname(dev));
+			return -EPERM;
+		}
+
+		/*
+		 * If memory is still online and user wants to force it, attempt
+		 * to offline it.
+		 */
+		if (daxctl_memory_is_online(mem) && param.force) {
+			rc = daxctl_memory_offline(mem);
+			if (rc) {
+				log_err(&rl, "%s: unable to offline %s: %s\n",
+					devname,
+					daxctl_dev_get_devname(dev),
+					strerror(abs(rc)));
+				return rc;
+			}
+		}
+	}
+
+out:
+	return cxl_region_disable(region);
+}
+
 static int do_region_xable(struct cxl_region *region, enum region_actions action)
 {
 	switch (action) {
 	case ACTION_ENABLE:
 		return cxl_region_enable(region);
 	case ACTION_DISABLE:
-		return cxl_region_disable(region);
+		return disable_region(region);
 	case ACTION_DESTROY:
 		return destroy_region(region);
 	default:


