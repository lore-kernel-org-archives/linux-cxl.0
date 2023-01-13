Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20757C54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 15:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjAMPto (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjAMPtU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 10:49:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6B42600
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 07:41:29 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntly54DSfz6J9Sj;
        Fri, 13 Jan 2023 23:41:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 15:41:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC:     <linuxarm@huawei.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [RFC PATCH 1/2] cxl: RAS: Multiple header recording support
Date:   Fri, 13 Jan 2023 15:40:57 +0000
Message-ID: <20230113154058.16227-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113154058.16227-1-Jonathan.Cameron@huawei.com>
References: <20230113154058.16227-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Similar to PCIe, CXL devices may support logging multiple headers
corresponding to multiple errors as reported via the CXL RAS capability.

Unlike PCIe, in CXL there is no Multiple Header Recording Enable bit
and the CXL r3.0 specification is sparse on details. As such, the
kernel should allow for any reasonable interpretation including
endpoints for which the capability bit is set that behave as per
the PCIe equivalent definitions (with assumption that the missing
'enable bit' is set). Note that behaving as if Multiple Headers
are being logged is also valid behavior when they are not so this
approach should be safe with all sensible specification interpretations.

By repeatedly attempting to clear a single bit corresponding to the reported
First Error (may need multiple goes if multiple records of same type
are tracked by the hardware) the additional header logs may be obtained.

Note that each trace record only records the FE in the status.
We could record them all as done without Multi header recording
capability but that seemed less intuitive to me.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 17 ++++++++++++-----
 drivers/cxl/cxl.h      |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 184ead6a2796..6fd311e313c6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -673,10 +673,13 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	void __iomem *addr;
 	u32 status;
 	u32 fe;
+	bool mh;
 
 	if (!cxlds->regs.ras)
 		return false;
 
+next_record:
+	mh = false;
 	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
@@ -684,11 +687,13 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
-		void __iomem *rcc_addr =
-			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
-
-		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   readl(rcc_addr)));
+		u32 capctrl = readl(cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET);
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, capctrl));
+		if (FIELD_GET(CXL_RAS_CAP_CONTROL_MH_REC_CAP, capctrl)) {
+			mh = true;
+			/* Report and clear only first error */
+			status = fe;
+		}
 	} else {
 		fe = status;
 	}
@@ -696,6 +701,8 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	header_log_copy(cxlds, hl);
 	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
+	if (mh)
+		goto next_record;
 
 	return true;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index aa3af3bb73b2..ee31a99073c2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -138,6 +138,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_RAS_CORRECTABLE_MASK_MASK GENMASK(6, 0)
 #define CXL_RAS_CAP_CONTROL_OFFSET 0x14
 #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
+#define CXL_RAS_CAP_CONTROL_MH_REC_CAP BIT(9)
 #define CXL_RAS_HEADER_LOG_OFFSET 0x18
 #define CXL_RAS_CAPABILITY_LENGTH 0x58
 #define CXL_HEADERLOG_SIZE SZ_512
-- 
2.37.2

