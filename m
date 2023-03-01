Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0BC6FA9D
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 16:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCAQ7q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 11:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCAQ7p (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 11:59:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D644D2A6F7
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 08:59:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PRgSd2tSSz6J75v;
        Thu,  2 Mar 2023 00:59:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 16:59:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linuxarm@huawei.com>
Subject: [PATCH v2] cxl/mbox: Drop extra (struct resource)
Date:   Wed, 1 Mar 2023 16:59:38 +0000
Message-ID: <20230301165938.6403-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

DEFINE_RES_MEM() is a wrapper around the DEFINE_RES_NAMED()
macro which already has the (struct resource) for the compound
literal.

Fixes warnings with W=1 C=1
  CC [M]  drivers/cxl/core/mbox.o
  CHECK   drivers/cxl/core/mbox.c
drivers/cxl/core/mbox.c:1064:18: warning: cast to non-scalar
drivers/cxl/core/mbox.c:1064:18: warning: cast from non-scalar

Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/mbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..dce16088ceee 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1052,8 +1052,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 	struct device *dev = cxlds->dev;
 	int rc;
 
-	cxlds->dpa_res =
-		(struct resource)DEFINE_RES_MEM(0, cxlds->total_bytes);
+	cxlds->dpa_res = DEFINE_RES_MEM(0, cxlds->total_bytes);
 
 	if (cxlds->partition_align_bytes == 0) {
 		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
-- 
2.37.2

