Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752C8C43334
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Jun 2022 13:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbiFINpS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Jun 2022 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244380AbiFINpS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Jun 2022 09:45:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A3B4C7B2
        for <linux-cxl@vger.kernel.org>; Thu,  9 Jun 2022 06:45:16 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJlbG1Wmrz67Q0K;
        Thu,  9 Jun 2022 21:40:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 15:45:14 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 14:45:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH] cxl: Fix cleanup of port devices on failure to probe driver.
Date:   Thu, 9 Jun 2022 14:45:19 +0100
Message-ID: <20220609134519.11668-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The device is created, and then there is a check if a driver succesfully
bound to it. In event of failing the bind (e.g. failure in cxl_port_probe())
the device is left registered. When a bus rescan later occurs, fresh
devices are created leading to a multiple device representing the same
underlying hardware. Bad things may follow and at very least we have far too many
devices.

Fix by ensuring autoremove is registered if the device create succeeds,
but doesn't depend on sucessful binding to a driver.

Bug was observed as side effect of incorrect ownership in
[PATCH v9 6/9] cxl/port: Read CDAT table
but will result from any failure to in cxl_port_probe().

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/mem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c310f1fd3db0..a979d0b484d5 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -29,6 +29,7 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint;
+	int rc;
 
 	endpoint = devm_cxl_add_port(&parent_port->dev, &cxlmd->dev,
 				     cxlds->component_reg_phys, parent_port);
@@ -37,13 +38,17 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
 
 	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
 
+	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	if (rc)
+		return rc;
+
 	if (!endpoint->dev.driver) {
 		dev_err(&cxlmd->dev, "%s failed probe\n",
 			dev_name(&endpoint->dev));
 		return -ENXIO;
 	}
 
-	return cxl_endpoint_autoremove(cxlmd, endpoint);
+	return 0;
 }
 
 static void enable_suspend(void *data)
-- 
2.32.0

