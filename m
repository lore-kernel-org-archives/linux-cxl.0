Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C8C00140
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Aug 2022 16:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbiHRQmT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343955AbiHRQmT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 Aug 2022 12:42:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BC7C2298
        for <linux-cxl@vger.kernel.org>; Thu, 18 Aug 2022 09:42:18 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M7rF836ppz67KPP;
        Fri, 19 Aug 2022 00:39:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 18:42:16 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 17:42:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <linuxarm@huawei.com>,
        Bobo WL <lmw.bobo@gmail.com>
Subject: [PATCH] cxl/region: Fix null pointer dereference due to pass through decoder commit
Date:   Thu, 18 Aug 2022 17:42:10 +0100
Message-ID: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Not all decoders have a commit callback.

The CXL specification allows a host bridge with a single root port to
have no explicit HDM decoders. Currently we assumes there are none.
As such we create a special pass through decoder instance without
a commit callback.

Prior to this patch, the commit callback was called unconditionally.
Thus a configuration with 1 Host Bridge, 1 Root Port, 1 switch with
multiple downstream ports below which there are multiple CXL type 3
devices results in a situation where committing the region causes
a null pointer dereference.

Reported-by: Bobo WL <lmw.bobo@gmail.com>
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

We could fix this with a stub function perhaps as an alternative?

 drivers/cxl/core/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 401148016978..c49d9a5f1091 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -174,7 +174,8 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 		     iter = to_cxl_port(iter->dev.parent)) {
 			cxl_rr = cxl_rr_load(iter, cxlr);
 			cxld = cxl_rr->decoder;
-			rc = cxld->commit(cxld);
+			if (cxld->commit)
+				rc = cxld->commit(cxld);
 			if (rc)
 				break;
 		}
-- 
2.32.0

