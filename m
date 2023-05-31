Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C5C77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 02:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjEaC1f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 22:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEaC1e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 22:27:34 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B51D10E
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 19:27:33 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="118392223"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="118392223"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 11:27:32 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 15138C68E2
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:27:29 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 51D12D506E
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:27:28 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id ACC786B824;
        Wed, 31 May 2023 11:27:27 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH] cxl/region: Fix memdevs leak
Date:   Wed, 31 May 2023 10:27:18 +0800
Message-Id: <20230531022718.7691-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27662.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27662.004
X-TMASE-Result: 10--9.618700-10.000000
X-TMASE-MatchedRID: XFcEXtZNE8Iv+0FNnM7lDQPZZctd3P4BP8UQejhp29pOmq2IYpeEBpCl
        VuR6WzhZc/72aFsOO+1riYUp3bAAfVxxDx5qbkR9FEUknJ/kEl7dB/CxWTRRu25FeHtsUoHuNGA
        VFJsT6jGz7xWGG8PAr6gBYzNz1UJ1EmEIVb0Fmqm+68HqACCvKA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

p.memdevs should be released in error path

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 cxl/region.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 07ce4a319fd0..7f60094e8b49 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -300,11 +300,11 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 		if (p->mode == CXL_DECODER_MODE_RAM && param.uuid) {
 			log_err(&rl,
 				"can't set UUID for ram / volatile regions");
-			return -EINVAL;
+			goto err;
 		}
 		if (p->mode == CXL_DECODER_MODE_NONE) {
 			log_err(&rl, "unsupported type: %s\n", param.type);
-			return -EINVAL;
+			goto err;
 		}
 	} else {
 		p->mode = CXL_DECODER_MODE_PMEM;
@@ -314,21 +314,21 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 		p->size = parse_size64(param.size);
 		if (p->size == ULLONG_MAX) {
 			log_err(&rl, "Invalid size: %s\n", param.size);
-			return -EINVAL;
+			goto err;
 		}
 	}
 
 	if (param.ways <= 0) {
 		log_err(&rl, "Invalid interleave ways: %d\n", param.ways);
-		return -EINVAL;
+		goto err;
 	} else if (param.ways < INT_MAX) {
 		p->ways = param.ways;
 		if (!validate_ways(p, count))
-			return -EINVAL;
+			goto err;
 	} else if (count) {
 		p->ways = count;
 		if (!validate_ways(p, count))
-			return -EINVAL;
+			goto err;
 	} else
 		p->ways = p->num_memdevs;
 
@@ -336,7 +336,7 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 		if (param.granularity <= 0) {
 			log_err(&rl, "Invalid interleave granularity: %d\n",
 				param.granularity);
-			return -EINVAL;
+			goto err;
 		}
 		p->granularity = param.granularity;
 	}
@@ -346,18 +346,22 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 			log_err(&rl,
 				"size (%lu) is not an integral multiple of interleave-ways (%u)\n",
 				p->size, p->ways);
-			return -EINVAL;
+			goto err;
 		}
 	}
 
 	if (param.uuid) {
 		if (uuid_parse(param.uuid, p->uuid)) {
 			error("failed to parse uuid: '%s'\n", param.uuid);
-			return -EINVAL;
+			goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	json_object_put(p->memdevs);
+	return -EINVAL;
 }
 
 static int parse_region_options(int argc, const char **argv,
-- 
2.29.2

