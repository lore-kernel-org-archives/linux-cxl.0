Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8125DC77B7C
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 10:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjEaKHR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjEaKHQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 06:07:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F60E5;
        Wed, 31 May 2023 03:07:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWPty2FP3z6J7jf;
        Wed, 31 May 2023 18:02:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 11:06:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-i2c@vger.kernel.org>
CC:     Wolfram Sang <wsa@kernel.org>, Niyas Sait <niyas.sait@linaro.org>,
        Klaus Jensen <its@irrelevant.dk>,
        Andy Shevchenko <andy@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: [RFC PATCH v3 2/7] i2c: aspeed: Use platform_get_irq() instead of opencoding
Date:   Wed, 31 May 2023 11:05:55 +0100
Message-ID: <20230531100600.13543-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531100600.13543-1-Jonathan.Cameron@huawei.com>
References: <20230531100600.13543-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A cleanup in its own right.
This has the handy side effect of working for ACPI FW as well
(unlike fwnode_irq_get() which works for ARM64 but not x86 ACPI)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v3: Fix it's -> its in description.
---
 drivers/i2c/busses/i2c-aspeed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index d3c99c5b3247..21a2f139f445 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -1043,7 +1042,10 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = devm_request_irq(&pdev->dev, irq, aspeed_i2c_bus_irq,
 			       0, dev_name(&pdev->dev), bus);
 	if (ret < 0)
-- 
2.39.2

