Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA38C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiERXev (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiERXev (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B4F5B8
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916889; x=1684452889;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0txnpiNgKU960RtpRDCG5Egk18rtOJMhbyXRBJhLV4=;
  b=kU6E44EX15ZnlCfb7mboY1s1Cgg36vMRrL1+5BCgMdad3h43+aRr/jkG
   X1NK9iH3mmx5uwvC5xNuwythXXHoXXetRf+i8va9XK1xRJjmBw0zzOuLr
   3TrljysBHZvnE5XJ+HXU7IOegn14d9XIxjK25wvxvN2cwNIYv869WQsud
   CPwNRNAWcsFacDnS2jJSYmzKMbefNm0TWK7SaopAGi86itA6ivjTwiaYO
   lseHn+FnA2sR4pLQm5/TSWUtyMzTNGRsxzFwxMWwoe7981mqkj84zr1/D
   WqJyesDlr+r5jQilJXR2+xZ0XnTeQio5HWp7ssMz1U3QpFTzxgPWGLAKB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="332557944"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="332557944"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="606166805"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:49 -0700
Subject: [PATCH v3 07/13] cxl/mem: Consolidate CXL DVSEC Range enumeration
 in the core
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:34:48 -0700
Message-ID: <165291688886.1426646.15046138604010482084.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for fixing the setting of the 'mem_enabled' bit in CXL
DVSEC Control register, move all CXL DVSEC range enumeration into the
same source file.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |  129 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h          |    1 
 drivers/cxl/cxlpci.h          |    4 +
 drivers/cxl/mem.c             |   14 ++--
 drivers/cxl/pci.c             |  135 -----------------------------------------
 tools/testing/cxl/Kbuild      |    1 
 tools/testing/cxl/test/mem.c  |   10 ---
 tools/testing/cxl/test/mock.c |   16 +++++
 8 files changed, 158 insertions(+), 152 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 603945f49174..ea6711721901 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -142,3 +142,132 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
+
+static int wait_for_valid(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec, rc;
+	u32 val;
+
+	/*
+	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
+	 * and Size Low registers are valid. Must be set within 1 second of
+	 * deassertion of reset to CXL device. Likely it is already set by the
+	 * time this runs, but otherwise give a 1.5 second timeout in case of
+	 * clock skew.
+	 */
+	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
+	if (rc)
+		return rc;
+
+	if (val & CXL_DVSEC_MEM_INFO_VALID)
+		return 0;
+
+	msleep(1500);
+
+	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
+	if (rc)
+		return rc;
+
+	if (val & CXL_DVSEC_MEM_INFO_VALID)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * Return positive number of non-zero ranges on success and a negative
+ * error code on failure. The cxl_mem driver depends on ranges == 0 to
+ * init HDM operation.
+ */
+int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
+		     struct cxl_endpoint_dvsec_info *info)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int hdm_count, rc, i, ranges = 0;
+	struct device *dev = &pdev->dev;
+	int d = cxlds->cxl_dvsec;
+	u16 cap, ctrl;
+
+	if (!d) {
+		dev_dbg(dev, "No DVSEC Capability\n");
+		return -ENXIO;
+	}
+
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	if (rc)
+		return rc;
+
+	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
+		dev_dbg(dev, "Not MEM Capable\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * It is not allowed by spec for MEM.capable to be set and have 0 legacy
+	 * HDM decoders (values > 2 are also undefined as of CXL 2.0). As this
+	 * driver is for a spec defined class code which must be CXL.mem
+	 * capable, there is no point in continuing to enable CXL.mem.
+	 */
+	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	if (!hdm_count || hdm_count > 2)
+		return -EINVAL;
+
+	rc = wait_for_valid(cxlds);
+	if (rc) {
+		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
+		return rc;
+	}
+
+	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
+
+	for (i = 0; i < hdm_count; i++) {
+		u64 base, size;
+		u32 temp;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
+		if (rc)
+			return rc;
+
+		size = (u64)temp << 32;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
+		if (rc)
+			return rc;
+
+		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
+		if (rc)
+			return rc;
+
+		base = (u64)temp << 32;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
+		if (rc)
+			return rc;
+
+		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
+
+		info->dvsec_range[i] = (struct range) {
+			.start = base,
+			.end = base + size - 1
+		};
+
+		if (size)
+			ranges++;
+	}
+
+	info->ranges = ranges;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dvsec_ranges, CXL);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 843916c1dab6..60d10ee1e7fc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -222,7 +222,6 @@ struct cxl_dev_state {
 	u64 next_persistent_bytes;
 
 	resource_size_t component_reg_phys;
-	struct cxl_endpoint_dvsec_info info;
 	u64 serial;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 329e7ea3f36a..ad1b62843195 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -72,4 +72,8 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 }
 
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
+struct cxl_dev_state;
+struct cxl_endpoint_dvsec_info;
+int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
+		     struct cxl_endpoint_dvsec_info *info);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 8c3a1c85a7ae..0cfbde134fc7 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -58,18 +58,15 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
  * decoders, or if it can not be determined if DVSEC Ranges are in use.
  * Otherwise, returns true.
  */
-__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
+__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
+				struct cxl_endpoint_dvsec_info *info)
 {
-	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
 	struct cxl_register_map map;
 	struct cxl_component_reg_map *cmap = &map.component_map;
 	bool global_enable, retval = false;
 	void __iomem *crb;
 	u32 global_ctrl;
 
-	if (info->ranges < 0)
-		return false;
-
 	/* map hdm decoder */
 	crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb) {
@@ -125,6 +122,7 @@ static void enable_suspend(void *data)
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_endpoint_dvsec_info info = { 0 };
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *parent_port;
 	int rc;
@@ -165,6 +163,10 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	rc = cxl_dvsec_ranges(cxlds, &info);
+	if (rc)
+		return rc;
+
 	rc = cxl_await_media_ready(cxlds);
 	if (rc) {
 		dev_err(dev, "Media not active (%d)\n", rc);
@@ -175,7 +177,7 @@ static int cxl_mem_probe(struct device *dev)
 	 * If DVSEC ranges are being used instead of HDM decoder registers there
 	 * is no use in trying to manage those.
 	 */
-	if (!cxl_hdm_decode_init(cxlds)) {
+	if (!cxl_hdm_decode_init(cxlds, &info)) {
 		dev_err(dev,
 			"Legacy range registers configuration prevents HDM operation.\n");
 		return -EBUSY;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1bf880fa1fb8..5a0ae46d4989 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -386,139 +386,6 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
-static int wait_for_valid(struct cxl_dev_state *cxlds)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	int d = cxlds->cxl_dvsec, rc;
-	u32 val;
-
-	/*
-	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
-	 * and Size Low registers are valid. Must be set within 1 second of
-	 * deassertion of reset to CXL device. Likely it is already set by the
-	 * time this runs, but otherwise give a 1.5 second timeout in case of
-	 * clock skew.
-	 */
-	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
-	if (rc)
-		return rc;
-
-	if (val & CXL_DVSEC_MEM_INFO_VALID)
-		return 0;
-
-	msleep(1500);
-
-	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
-	if (rc)
-		return rc;
-
-	if (val & CXL_DVSEC_MEM_INFO_VALID)
-		return 0;
-
-	return -ETIMEDOUT;
-}
-
-/*
- * Return positive number of non-zero ranges on success and a negative
- * error code on failure. The cxl_mem driver depends on ranges == 0 to
- * init HDM operation.
- */
-static int __cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
-			      struct cxl_endpoint_dvsec_info *info)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	int hdm_count, rc, i, ranges = 0;
-	struct device *dev = &pdev->dev;
-	int d = cxlds->cxl_dvsec;
-	u16 cap, ctrl;
-
-	if (!d) {
-		dev_dbg(dev, "No DVSEC Capability\n");
-		return -ENXIO;
-	}
-
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
-	if (rc)
-		return rc;
-
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
-	if (rc)
-		return rc;
-
-	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
-		dev_dbg(dev, "Not MEM Capable\n");
-		return -ENXIO;
-	}
-
-	/*
-	 * It is not allowed by spec for MEM.capable to be set and have 0 legacy
-	 * HDM decoders (values > 2 are also undefined as of CXL 2.0). As this
-	 * driver is for a spec defined class code which must be CXL.mem
-	 * capable, there is no point in continuing to enable CXL.mem.
-	 */
-	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
-	if (!hdm_count || hdm_count > 2)
-		return -EINVAL;
-
-	rc = wait_for_valid(cxlds);
-	if (rc) {
-		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
-		return rc;
-	}
-
-	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
-
-	for (i = 0; i < hdm_count; i++) {
-		u64 base, size;
-		u32 temp;
-
-		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
-		if (rc)
-			return rc;
-
-		size = (u64)temp << 32;
-
-		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
-		if (rc)
-			return rc;
-
-		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
-
-		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
-		if (rc)
-			return rc;
-
-		base = (u64)temp << 32;
-
-		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
-		if (rc)
-			return rc;
-
-		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
-
-		info->dvsec_range[i] = (struct range) {
-			.start = base,
-			.end = base + size - 1
-		};
-
-		if (size)
-			ranges++;
-	}
-
-	return ranges;
-}
-
-static void cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
-{
-	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
-
-	info->ranges = __cxl_dvsec_ranges(cxlds, info);
-}
-
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -583,8 +450,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	cxl_dvsec_ranges(cxlds);
-
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6007fe770122..2ea6fcb8baa5 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -9,6 +9,7 @@ ldflags-y += --wrap=devm_cxl_setup_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
+ldflags-y += --wrap=cxl_dvsec_ranges
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index c519ace17b41..6b9239b2afd4 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -242,14 +242,6 @@ static void label_area_release(void *lsa)
 	vfree(lsa);
 }
 
-static void mock_validate_dvsec_ranges(struct cxl_dev_state *cxlds)
-{
-	struct cxl_endpoint_dvsec_info *info;
-
-	info = &cxlds->info;
-	info->mem_enabled = true;
-}
-
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -286,8 +278,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mock_validate_dvsec_ranges(cxlds);
-
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 2c01d81ab014..d6aa644822db 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -208,6 +208,22 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
 
+int __wrap_cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
+			    struct cxl_endpoint_dvsec_info *info)
+{
+	int rc = 0, index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_dev(cxlds->dev))
+		info->mem_enabled = 1;
+	else
+		rc = cxl_dvsec_ranges(cxlds, info);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_ranges, CXL);
+
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
 MODULE_IMPORT_NS(CXL);

