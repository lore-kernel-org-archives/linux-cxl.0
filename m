Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3C6C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Feb 2022 15:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiBAPel (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:34:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4602 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiBAPel (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Feb 2022 10:34:41 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp84n10nrz67bNC;
        Tue,  1 Feb 2022 23:30:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 16:34:39 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 15:34:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        <linuxarm@huawei.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] cxl/regs: Fix size of CXL Capability Header Register
Date:   Tue, 1 Feb 2022 15:34:37 +0000
Message-ID: <20220201153437.2873-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In CXL 2.0, 8.2.5.1 CXL Capability Header Register: this register
is given as 32 bits.

8.2.3 which covers the CXL 2.0 Component registers, including the
CXL Capability Header Register states that access restrictions
specified in Section 8.2.2 apply.

8.2.2 includes:
* A 32 bit register shall be accessed as a 4 Byte quantity.
...
If these rules are not followed, the behavior is undefined.

Discovered during review of CXL QEMU emulation. Alex Bennée pointed
out there was a comment saying that 4 byte registers must be read
with a 4 byte read, but 8 byte reads were being emulated.

https://lore.kernel.org/qemu-devel/87bkzyd3c7.fsf@linaro.org/

Fixing that, led to this code failing. Whilst a given hardware
implementation 'might' work with an 8 byte read, it should not be relied
upon. The QEMU emulation v5 will return 0 and log the wrong access width.

The code moved, so one fixes tag for where this will directly apply and
also a reference to the earlier introduction of the code for backports.

Fixes: 0f06157e0135 ("cxl/core: Move register mapping infrastructure")
Fixes: 08422378c4ad ("cxl/pci: Add HDM decoder capabilities")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alex Bennée <alex.bennee@linaro.org>

---
 drivers/cxl/core/regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e37e23bf4355..125303ac2a6f 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -35,7 +35,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map)
 {
 	int cap, cap_count;
-	u64 cap_array;
+	u32 cap_array;
 
 	*map = (struct cxl_component_reg_map) { 0 };
 
@@ -45,7 +45,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 	 */
 	base += CXL_CM_OFFSET;
 
-	cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);
+	cap_array = readl(base + CXL_CM_CAP_HDR_OFFSET);
 
 	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
 		dev_err(dev,
-- 
2.32.0

