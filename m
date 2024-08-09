Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833B19046B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196581; cv=none; b=esq0oYLaZBNJ1x5XdS8MP3D+XPqakyxCnfQ9ClanOJwBwWItWuJp0JKu1mwGn13S1Ju8vHc8/swrWEo6InV/VOA8WVA8evF0K9xVU5t6XA3M27p3GzQTa+rE2zs5CW4pknOmyM2VOrjsqayg4AgxmLxIT+HybRB/V/m5QdUSbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196581; c=relaxed/simple;
	bh=6OXyswSN4bsPHMABJi9i5ke+78Ap4oyNt2rdNrcKt0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcOT6XkIMWlscM8cRGnuhyYLGsFpJgSxEUYwbW5z65A/gvR5XAMdlUCi/q64N6CRpMxcgm6bTZ+KMlKGM83yzYPAITyQEsSxBeu1vlaabNsD4jyLp4KZPVwGENG3ikpYi4ghhHwGTfcZQbFDokSgcjyyVSI8qu7o55DRVRuwrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLBXn2JH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLBXn2JH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723196579; x=1754732579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6OXyswSN4bsPHMABJi9i5ke+78Ap4oyNt2rdNrcKt0E=;
  b=bLBXn2JH9z6lnWBB1ccQ3vHUZl4lJA8C6JH/iVU0OHg+wW3bh7SCRMQB
   ZluuMsr9iC9898mpbWk6fs7BDviMyevBxTfWOnWejzHsdmUFEiKbmxplE
   tnXGZ8907H4DVJSGEP7SmRQjAjEcYihyuTYff2tisKHo86ARowZpmbbl5
   thVYcBbcgqafobm7De4wNmQtyxNTl5u+qTW7NMTrZLn24h3SJko8g28fp
   q7nN0tHvo+bUBTV5JNfSbOCNNVtIci7munCG7WqtByYQUJ58UTo0zRw/P
   xiN3UupF+6iTGVgi4BILS2BabI4gKjr4gl35KZiRCVsVnBKG9/6fqFPr7
   g==;
X-CSE-ConnectionGUID: NSywSX2yShq6N+afeo68Dg==
X-CSE-MsgGUID: xHWVyCwcQt+zuC2yyijJ0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38869649"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="38869649"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:42:59 -0700
X-CSE-ConnectionGUID: ljDhc//hS+KGf1j6tCbWEQ==
X-CSE-MsgGUID: NtyQ21ofSICXV5m67rgwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62352832"
Received: from tower.bj.intel.com ([10.238.157.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:42:56 -0700
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
Subject: [v2 2/4] cxl/pci: Don't set up decoders for disallowed DVSEC ranges
Date: Fri,  9 Aug 2024 17:34:40 +0800
Message-Id: <20240809093442.646545-3-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240809093442.646545-1-yanfei.xu@intel.com>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since it shouldn't create and configure decoders for disallowed
ranges, move the check of dvsec_range_allowed() earlier into
cxl_dvsec_rr_decode() to filter the disallowed DVSEC ranges out
at firtst.

Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c        | 62 +++++++++++++++++------------------
 drivers/cxl/cxl.h             |  2 +-
 drivers/cxl/port.c            |  2 +-
 tools/testing/cxl/test/mock.c |  4 +--
 4 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2d69340134da..0915fc9e6d70 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -322,11 +322,14 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
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
@@ -359,6 +362,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 		return rc;
 	}
 
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
+	}
+
 	/*
 	 * The current DVSEC values are moot if the memory capability is
 	 * disabled, and they will remain moot after the HDM Decoder
@@ -373,6 +384,8 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 		return 0;
 
 	for (i = 0; i < hdm_count; i++) {
+		struct device *cxld_dev;
+		struct range dvsec_range;
 		u64 base, size;
 		u32 temp;
 
@@ -389,9 +402,8 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 			return rc;
 
 		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
-		if (!size) {
+		if (!size)
 			continue;
-		}
 
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
@@ -407,10 +419,21 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-		info->dvsec_range[ranges++] = (struct range) {
+		dvsec_range = (struct range) {
 			.start = base,
-			.end = base + size - 1
+			.end = base + size - 1,
 		};
+
+		cxld_dev = device_find_child(&root->dev, &dvsec_range,
+							dvsec_range_allowed);
+		if (!cxld_dev) {
+			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i+1);
+			continue;
+		}
+		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i+1);
+		put_device(cxld_dev);
+
+		info->dvsec_range[ranges++] = dvsec_range;
 	}
 
 	info->ranges = ranges;
@@ -433,9 +456,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
 	struct device *dev = cxlds->dev;
-	struct cxl_port *root;
-	int i, rc, allowed;
 	u32 global_ctrl = 0;
+	int rc;
 
 	if (hdm)
 		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
@@ -449,30 +471,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
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
-
-		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
-					     dvsec_range_allowed);
-		if (!cxld_dev) {
-			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
-			continue;
-		}
-		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
-		put_device(cxld_dev);
-		allowed++;
-	}
-
-	if (!allowed && info->mem_enabled) {
-		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
+	if (!info->ranges && info->mem_enabled) {
+		dev_err(dev, "No available DVSEC register ranges.\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..e2e277463794 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -809,7 +809,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
-int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
+int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d7d5d982ce69..861dde65768f 100644
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

