Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7AC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352606AbiETSaS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiETSaR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 14:30:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D59170F10
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653071416; x=1684607416;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R7LiUjlbmDkm4bVCLMo39A40tUGBH5mA7jN2eOgkMQg=;
  b=M1ewFrwewkI+RQjSI1w3tKCEt+iIgj0oGwYUg5UJKdPG96lJFeLl+gGB
   1Av0HsuWhBbLsXDhRb+txkmYMxysTkmvruLgUJ/DTMdh9axkWfBOy9RuL
   HN99yhLhB4NOyECkdHCSI3Ic8NOs5brBqCbemuAGn1TTHeTgNlUksl0lx
   huzJVBnjkdISPw4rrJ3Kk3QdtPx6RZ4FOckETKsgQcuOzTyiMSAfjiMCd
   qL3dueFqqFhfqBVA+vHUNg3OWuvWVp4av0pfLeWBNTQoTTpplnjd1jM4n
   mWh0A8eSFw78uLkilNWn0K06KpEJF2c8ME5RuQor1cG6SGdfzXuFQmdCE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="253213359"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="253213359"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:30:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="607139299"
Received: from akaldous-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.24.18])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:30:15 -0700
Subject: [PATCH v5 13/13] cxl/port: Enable HDM Capability after validating
 DVSEC Ranges
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ariel Sibley <ariel.sibley@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 20 May 2022 11:30:15 -0700
Message-ID: <165307136375.2499769.861793697156744166.stgit@dwillia2-xfh>
In-Reply-To: <165299979159.2207134.5045405239146790589.stgit@dwillia2-xfh>
References: <165299979159.2207134.5045405239146790589.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL memory expanders that support the CXL 2.0 memory device class code
include an "HDM Decoder Capability" mechanism to supplant the "CXL DVSEC
Range" mechanism originally defined in CXL 1.1. Both mechanisms depend
on a "mem_enable" bit being set in configuration space before either
mechanism activates. When the HDM Decoder Capability is enabled the CXL
DVSEC Range settings are ignored.

Previously, the cxl_mem driver was relying on platform-firmware to set
"mem_enable". That is an invalid assumption as there is no requirement
that platform-firmware sets the bit before the driver sees a device,
especially in hot-plug scenarios. Additionally, ACPI-platforms that
support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
Table). That table outlines the platform permissible address ranges for
CXL operation. So, there is a need for the driver to set "mem_enable",
and there is information available to determine the validity of the CXL
DVSEC Ranges.

Arrange for the driver to optionally enable the HDM Decoder Capability
if "mem_enable" was not set by platform firmware, or the CXL DVSEC Range
configuration was invalid. Be careful to only disable memory decode if
the kernel was the one to enable it. In other words, if CXL is backing
all of kernel memory at boot the device needs to maintain "mem_enable"
and "HDM Decoder enable" all the way up to handoff back to platform
firmware (e.g. ACPI S5 state entry may require CXL memory to stay
active).

Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Cc: Dan Carpenter <dan.carpenter@oracle.com>
[dan: fix early terminiation of range-allowed loop]
Cc: Ariel Sibley <ariel.sibley@microchip.com>
[ariel: Memory_size must be non-zero]
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v4:
- Fix __cxl_hdm_decode_init() return code handling in the 'mem_enable
  disabled at boot' case. (Jonathan)

 drivers/cxl/core/pci.c |  167 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 152 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3305e9b750af..c4c99ff7b55e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -175,16 +175,149 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
 	return -ETIMEDOUT;
 }
 
+static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	u16 ctrl;
+	int rc;
+
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	if (rc < 0)
+		return rc;
+
+	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
+		return 1;
+	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
+	ctrl |= val;
+
+	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static void clear_mem_enable(void *cxlds)
+{
+	cxl_set_mem_enable(cxlds, 0);
+}
+
+static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
+{
+	int rc;
+
+	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
+	if (rc < 0)
+		return rc;
+	if (rc > 0)
+		return 0;
+	return devm_add_action_or_reset(host, clear_mem_enable, cxlds);
+}
+
+static bool range_contains(struct range *r1, struct range *r2)
+{
+	return r1->start <= r2->start && r1->end >= r2->end;
+}
+
+/* require dvsec ranges to be covered by a locked platform window */
+static int dvsec_range_allowed(struct device *dev, void *arg)
+{
+	struct range *dev_range = arg;
+	struct cxl_decoder *cxld;
+	struct range root_range;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+
+	if (!(cxld->flags & CXL_DECODER_F_LOCK))
+		return 0;
+	if (!(cxld->flags & CXL_DECODER_F_RAM))
+		return 0;
+
+	root_range = (struct range) {
+		.start = cxld->platform_res.start,
+		.end = cxld->platform_res.end,
+	};
+
+	return range_contains(&root_range, dev_range);
+}
+
+static void disable_hdm(void *_cxlhdm)
+{
+	u32 global_ctrl;
+	struct cxl_hdm *cxlhdm = _cxlhdm;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
+	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+}
+
+static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	u32 global_ctrl;
+
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
+	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
+}
+
 static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 				  struct cxl_hdm *cxlhdm,
 				  struct cxl_endpoint_dvsec_info *info)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	bool global_enable;
+	struct cxl_port *port = cxlhdm->port;
+	struct device *dev = cxlds->dev;
+	struct cxl_port *root;
+	int i, rc, allowed;
 	u32 global_ctrl;
 
 	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
+
+	/*
+	 * If the HDM Decoder Capability is already enabled then assume
+	 * that some other agent like platform firmware set it up.
+	 */
+	if (global_ctrl & CXL_HDM_DECODER_ENABLE) {
+		rc = devm_cxl_enable_mem(&port->dev, cxlds);
+		if (rc)
+			return false;
+		return true;
+	}
+
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return false;
+	}
+
+	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
+		struct device *cxld_dev;
+
+		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
+					     dvsec_range_allowed);
+		if (!cxld_dev) {
+			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
+			continue;
+		}
+		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
+		put_device(cxld_dev);
+		allowed++;
+	}
+
+	if (!allowed) {
+		cxl_set_mem_enable(cxlds, 0);
+		info->mem_enabled = 0;
+	}
 
 	/*
 	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
@@ -192,21 +325,19 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 	 * are ignored by the device, but the spec also recommends matching the
 	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
 	 * are expected even though Linux does not require or maintain that
-	 * match.
+	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
+	 * Decoder Capability Enable.
 	 */
-	if (!global_enable && info->mem_enabled && info->ranges)
+	if (info->mem_enabled)
 		return false;
 
-	/*
-	 * Permanently (for this boot at least) opt the device into HDM
-	 * operation. Individual HDM decoders still need to be enabled after
-	 * this point.
-	 */
-	if (!global_enable) {
-		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
-		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
-		       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-	}
+	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+	if (rc)
+		return false;
+
+	rc = devm_cxl_enable_mem(&port->dev, cxlds);
+	if (rc)
+		return false;
 
 	return true;
 }
@@ -261,9 +392,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 		return rc;
 	}
 
+	/*
+	 * The current DVSEC values are moot if the memory capability is
+	 * disabled, and they will remain moot after the HDM Decoder
+	 * capability is enabled.
+	 */
 	info.mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
 	if (!info.mem_enabled)
-		return 0;
+		goto hdm_init;
 
 	for (i = 0; i < hdm_count; i++) {
 		u64 base, size;
@@ -312,6 +448,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 	 * If DVSEC ranges are being used instead of HDM decoder registers there
 	 * is no use in trying to manage those.
 	 */
+hdm_init:
 	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, &info)) {
 		dev_err(dev,
 			"Legacy range registers configuration prevents HDM operation.\n");

