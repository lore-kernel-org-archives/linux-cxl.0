Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA01BDAB0
	for <linux-cxl@vger.kernel.org>; Wed,  7 Aug 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037206; cv=none; b=YihsyqkGkqp5MWq07Hsq1mesMsKrjKtx8NJVjx0g2/Xnturr3S+8SxyfBgCXoxQcD0ZSccmwlz55YtyYaz7XMlwSChMq2hxpTYN68JeECbaTMro42Zc2zi94Fu2WwaDWvVhXmPJWWm82TY6XajdN6kmM7pTDJtlZQx/wfm+cnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037206; c=relaxed/simple;
	bh=3o4URN7i0Bg17bUtTjZuHlQc2rZcZLzIyP9TBSAlQKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AoWEC1sCCyRFFwBzl821j4N9nCzCkv5ZysrneCCn9KQp8xY7I+jVaISUdVWwOa5x83wrgTxHmyJAWmweiaL78zqSIfARsTwExc/qTFmo+/S9EnLwo2CQ5hsKoWGHiVnDU1/oaLGRj0YeB2DkxxrLklD7vw1ZrGyzQKJefRinydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7E7mM6U; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7E7mM6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723037204; x=1754573204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3o4URN7i0Bg17bUtTjZuHlQc2rZcZLzIyP9TBSAlQKM=;
  b=Z7E7mM6UNMePE1lHDyB//pgn+U1BEHy4Hb4QANxpKRF6u4l1djJZMmMm
   DhlqxjpameX4iVSGxNacyqVHZErdSDn4b3BxDyOKiB77vtM6Vx4h5GC+X
   n/w+lu98///iYRu71AWM365Bc/GGePH3wgWteS234MVxf5D1AoyLDXRxD
   I9EzuQj6VZ4kMlnnmq1leSNvilkR+FE1iC1Dqv7rndY26x9ZM7RbvnjuW
   GHQxoi9fFz/xUubzWaL1aEtU+QHkUYSW4+Y0Z4RK3ED8Nrkc2giZc/e21
   uWuZP6gj9CKFzgMStPQF6OzwWwgWUCNEjyHXM568/y1Z4V5WGtxXL49Ar
   g==;
X-CSE-ConnectionGUID: YZlFG0VYRCSYBbC8tx0DEA==
X-CSE-MsgGUID: kLX+f0wgRW2lCmihf2t3SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20961029"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="20961029"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:26:40 -0700
X-CSE-ConnectionGUID: DJpdkA9RSuqrwi1KD86BlA==
X-CSE-MsgGUID: Y7IaP8mVRWuK5Js0mf4WxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56799025"
Received: from tower.bj.intel.com ([10.238.157.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:26:37 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [PATCH] cxl/pci: Fix DVSEC ranges validation to cover all ranges
Date: Wed,  7 Aug 2024 21:19:08 +0800
Message-Id: <20240807131908.303600-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_endpoint_dvsec_info.ranges means the number of non-zero DVSEC
range, and it will be less than the value of HDM_count when occuring
zero DVSEC range. Hence using it for looping validation of DVSEC
ranges in cxl_hdm_decode_init() and looping DVSEC decoder initialization
in devm_cxl_enumerate_decoders could miss non-zero DVSEC ranges. And
we should only create decoder for the allowed ranges.

Initializing content of all dvsec_range[] to invalid range and moving
the check of dvsec_range_allowed() in advance to cxl_dvsec_rr_decode()
could address that.

Other non-functional changes, refectoring cxl_dvsec_rr_decode to
improve its readability and droping wait_for_valid() to use
cxl_dvsec_mem_range_valid().

Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
Background: Found this issue when reading the CXL code. I didn't encounter
the discribed issue in real environment.

 drivers/cxl/core/hdm.c        |   2 +-
 drivers/cxl/core/pci.c        | 121 +++++++++++++---------------------
 drivers/cxl/cxl.h             |   5 +-
 drivers/cxl/port.c            |   2 +-
 tools/testing/cxl/test/mock.c |   4 +-
 5 files changed, 53 insertions(+), 81 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3df10517a327..65f5fd2e4189 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -768,7 +768,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 
 	cxled = to_cxl_endpoint_decoder(&cxld->dev);
 	len = range_len(&info->dvsec_range[which]);
-	if (!len)
+	if (WARN_ON(len == 0 || len == CXL_RESOURCE_NONE))
 		return -ENOENT;
 
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8567dd11eaac..c8420a7995f1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -211,37 +211,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
 
-static int wait_for_valid(struct pci_dev *pdev, int d)
-{
-	u32 val;
-	int rc;
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
 static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -322,11 +291,14 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
-int cxl_dvsec_rr_decode(struct device *dev, int d,
+int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 			struct cxl_endpoint_dvsec_info *info)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	int hdm_count, rc, i, ranges = 0;
+	int d = cxlds->cxl_dvsec;
+	struct cxl_port *root;
 	u16 cap, ctrl;
 
 	if (!d) {
@@ -357,10 +329,19 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
-	rc = wait_for_valid(pdev, d);
-	if (rc) {
-		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
-		return rc;
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
+		info->dvsec_range[i] = (struct range) {
+			.start = 0,
+			.end = CXL_RESOURCE_NONE,
+		};
 	}
 
 	/*
@@ -373,9 +354,15 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 		return 0;
 
 	for (i = 0; i < hdm_count; i++) {
+		struct device *cxld_dev;
+		struct range dvsec_range;
 		u64 base, size;
 		u32 temp;
 
+		rc = cxl_dvsec_mem_range_valid(cxlds, i);
+		if (rc)
+			return rc;
+
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
@@ -389,13 +376,8 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 			return rc;
 
 		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
-		if (!size) {
-			info->dvsec_range[i] = (struct range) {
-				.start = 0,
-				.end = CXL_RESOURCE_NONE,
-			};
+		if (!size)
 			continue;
-		}
 
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
@@ -411,11 +393,22 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-		info->dvsec_range[i] = (struct range) {
+		dvsec_range = (struct range) {
 			.start = base,
-			.end = base + size - 1
+			.end = base + size - 1,
 		};
 
+		cxld_dev = device_find_child(&root->dev, &dvsec_range,
+					     dvsec_range_allowed);
+		if (!cxld_dev) {
+			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
+			continue;
+		}
+		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
+		put_device(cxld_dev);
+
+		info->dvsec_range[ranges] = dvsec_range;
+
 		ranges++;
 	}
 
@@ -439,9 +432,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
 	struct device *dev = cxlds->dev;
-	struct cxl_port *root;
-	int i, rc, allowed;
 	u32 global_ctrl = 0;
+	int rc;
 
 	if (hdm)
 		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
@@ -455,30 +447,16 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	else if (!hdm)
 		return -ENODEV;
 
-	root = to_cxl_port(port->dev.parent);
-	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
-		root = to_cxl_port(root->dev.parent);
-	if (!is_cxl_root(root)) {
-		dev_err(dev, "Failed to acquire root port for HDM enable\n");
-		return -ENODEV;
-	}
-
-	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
-		struct device *cxld_dev;
+	if (!info->mem_enabled) {
+		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+		if (rc)
+			return rc;
 
-		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
-					     dvsec_range_allowed);
-		if (!cxld_dev) {
-			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
-			continue;
-		}
-		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
-		put_device(cxld_dev);
-		allowed++;
+		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
-	if (!allowed && info->mem_enabled) {
-		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
+	if (!info->ranges && info->mem_enabled) {
+		dev_err(dev, "No available DVSEC register ranges.\n");
 		return -ENXIO;
 	}
 
@@ -491,14 +469,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
 	 * Decoder Capability Enable.
 	 */
-	if (info->mem_enabled)
-		return 0;
-
-	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
-	if (rc)
-		return rc;
-
-	return devm_cxl_enable_mem(&port->dev, cxlds);
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a6613a6f8923..6d9126d5ee56 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -790,6 +790,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 }
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
+#define CXL_DVSEC_RANGE_MAX		2
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
@@ -801,7 +802,7 @@ struct cxl_endpoint_dvsec_info {
 	bool mem_enabled;
 	int ranges;
 	struct cxl_port *port;
-	struct range dvsec_range[2];
+	struct range dvsec_range[CXL_DVSEC_RANGE_MAX];
 };
 
 struct cxl_hdm;
@@ -810,7 +811,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
-int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
+int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 97c21566677a..a8c241cb4ce2 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
-	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
+	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
 	if (rc < 0)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6f737941dc0e..79fdfaad49e8 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -228,7 +228,7 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
 
-int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
+int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 			       struct cxl_endpoint_dvsec_info *info)
 {
 	int rc = 0, index;
@@ -237,7 +237,7 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 	if (ops && ops->is_mock_dev(dev))
 		rc = 0;
 	else
-		rc = cxl_dvsec_rr_decode(dev, dvsec, info);
+		rc = cxl_dvsec_rr_decode(dev, port, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
-- 
2.39.2

