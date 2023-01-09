Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B57FC54EBD
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 21:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbjAIVoM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbjAIVn7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 16:43:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1265825B
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 13:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673300638; x=1704836638;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJuhAWwHWZvWyHuRW8/PxhUex/oDdjRNpevV7WeyONg=;
  b=gDGBPfAVjvbfgq4Uc+B4kdFfBzj50X3VPjYgzJwPCa2IoNbBgAWamAg2
   Ru9TOlmKmb2MVs9QLqtg5lQ8VokNTxWBMxFBjIyql/F2fJCOJvsQ4PjI/
   H5+r5HVB8byEfqHo6V+0aZwZ83Sb7uIf07/tAHTALL+27YB6LFm6qKDqY
   M+hblseCiCAR2eq8UJt3hcBIB9QK5KCQt2arUqw2PioLDLMOcMH7qKqHA
   kB4qfg2vcYQYF01ouKo7ljQZUp0fdHKzb1sWXkyvsbQHECf59tCToDBpJ
   AYWZg11UlVSj5xDbSMsRy5BgQRyJE7ZXA5Z4F8M9ZUj/x+O7Umxp/AGYq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324996124"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324996124"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:43:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="780833594"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="780833594"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.37.174])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:43:56 -0800
Subject: [PATCH v2 6/8] cxl: create emulated decoders for devices without HDM
 decoders
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Mon, 09 Jan 2023 14:43:54 -0700
Message-ID: <167330063330.975161.12886268473522769039.stgit@djiang5-mobl3.local>
In-Reply-To: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL rev3.0 spec 8.1.3
RCDs may not have HDM register blocks. Create fake decoders based on CXL
PCIe DVSEC registers. The DVSEC Range Registers provide the memory range
for these decoder structs. For the RCD, there can be up to 2 decoders
depending on the DVSEC Capability register HDM_count.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Refactor to put error case out of line. (Jonathan)
- kdoc update. (Jonathan)
- Remove init_emulated_hdm_decoder(), duplicate of
  cxl_setup_hdm_decoder_from_dvsec().
---
 drivers/cxl/core/hdm.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 165c0f382ce1..ed5e9ef3aa9b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -747,6 +747,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (is_endpoint_decoder(&cxld->dev))
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
 
+	if (!hdm) {
+		if (!cxled)
+			return -EINVAL;
+
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+	}
+
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
@@ -840,19 +847,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	return 0;
 }
 
-/**
- * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
- * @cxlhdm: Structure to populate with HDM capabilities
- */
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
-				struct cxl_endpoint_dvsec_info *info)
+static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	struct cxl_port *port = cxlhdm->port;
-	int i, committed;
-	u64 dpa_base = 0;
+	int committed, i;
 	u32 ctrl;
 
+	if (!hdm)
+		return;
+
 	/*
 	 * Since the register resource was recently claimed via request_region()
 	 * be careful about trusting the "not-committed" status until the commit
@@ -869,6 +872,22 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	/* ensure that future checks of committed can be trusted */
 	if (committed != cxlhdm->decoder_count)
 		msleep(20);
+}
+
+/**
+ * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
+ * @cxlhdm: Structure to populate with HDM capabilities
+ * @info: cached DVSEC range register info
+ */
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_port *port = cxlhdm->port;
+	int i;
+	u64 dpa_base = 0;
+
+	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
 		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };


