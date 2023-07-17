Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB21EB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGQRX7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjGQRX7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:23:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533C2E51
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:23:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TNY28xKz67nhP;
        Tue, 18 Jul 2023 01:19:57 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:23:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 14/17] docs: cxl: Add example commandline for MCTP CXL CCIs
Date:   Mon, 17 Jul 2023 18:16:43 +0100
Message-ID: <20230717171646.8972-15-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
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

A lot more needed here on what these are for and what can be done
with them.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/system/devices/cxl.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index b742120657..62b6161474 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -406,6 +406,33 @@ OS management of CXL memory devices as described here.
 * CONFIG_CXL_PORT
 * CONFIG_CXL_REGION
 
+
+CCI access via MCTP over I2C
+----------------------------
+
+TODO: Add some more info here on what this actually is.
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
+ -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem0 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem1 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=7,target=cxl-pmem2
+
+Communication with the MCTP CCI can then be established using standard MCTP configuration
+tools.
+
 References
 ----------
 
-- 
2.39.2

