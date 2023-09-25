Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B65CE7A9A
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjIYQPi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjIYQPg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:15:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46746CE
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:15:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvSbB0zKVz6DBCq;
        Tue, 26 Sep 2023 00:13:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:15:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>
CC:     <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 08/19] docs: cxl: Add example commandline for MCTP CXL CCIs
Date:   Mon, 25 Sep 2023 17:11:13 +0100
Message-ID: <20230925161124.18940-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add initial documentation for the MCTP over I2C management device. At
current time this can only be used with the Aspeed I2C controller which
is only available in aspeed SoCs, though can be added to other
emulated boards.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/system/devices/cxl.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 6ab5f72473..dfe5577599 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -406,6 +406,33 @@ OS management of CXL memory devices as described here.
 * CONFIG_CXL_PORT
 * CONFIG_CXL_REGION
 
+
+CCI access via MCTP over I2C
+----------------------------
+
+In order to make use of this device, an I2C controller that supports MCTP
+is required.  The aspeed-i2c controller is an example of such a controller.
+
+Both CXL switches and CXL Type 3 devices support configuration via
+MCTP access to Component Command Interfaces (CCIs) on the devices.
+
+Example configuration:
+
+ -device cxl-upstream,port=33,bus=root_port0,id=us0,multifunction=on,addr=0.0,sn=12345678 \
+ -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
+ -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
+ -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
+ -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-lsa1,sn=3 \
+ -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem2,id=cxl-pmem1,lsa=cxl-lsa2,sn=4 \
+ -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem3,id=cxl-pmem2,lsa=cxl-lsa3,sn=5 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem0 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem1 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=7,target=cxl-pmem2
+
+Guest OS communication with the MCTP CCI can then be established using standard
+MCTP configuration tools.
+
 References
 ----------
 
-- 
2.39.2

