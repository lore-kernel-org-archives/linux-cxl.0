Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191960EC4
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547591; cv=none; b=h6LaBU9L95Ye5SujnEFN7DysWN7vUk//Q/U8vgIrhK/IWPKFWjtIfwzJc9UhiNeixT5zWkkIWGfQU4mOT+xUMBTw47JWxB3QKv7CQoTKeb11T0P39tUDdawqJfGltXiiAefvvMQdR6SaJOs2ch/OKQpnjVmmeiyD0HE7a/qM6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547591; c=relaxed/simple;
	bh=cjyg3QVdjFxExYESW6PikqbPYX5Rl03jMOJ/Yn+E064=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIsT2Vm9tnwPliVEDfR2+9wzHYMA43gnzxrOtyknHLIah+HfoTehrhqWRNVcbm+kRI0h4qIAJSTtaGR08U8TDSOZkw+4OmJDAPX5NIujoS5BnfpePASwIxzf108YU3O/WPyhND3CkwWXwqNYydyx86fsTj42EHfIUuPpw+O1mB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3VcF3Ao; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3VcF3Ao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723547589; x=1755083589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cjyg3QVdjFxExYESW6PikqbPYX5Rl03jMOJ/Yn+E064=;
  b=C3VcF3AoUQmYG7paw+pTd36s7nNLmY1/U9FsGSnCX6HlMed8XzPzR2cJ
   XJV90x/pNTbMVRDfC9SqHSrf19wm1IxM2IJ612hhYDN1Hh9BUMM2+WC+7
   t1/EnPIkaJQxdPWTL0zAFLbpWE6iGghE6rJ9ngnE3FtHGE2UEXyRne9Kb
   KtvwvanQv7PZ4dfBGojp88u9HJUg3lpXdiXGxl24GWJp/cZzMz68KFcAs
   OCBKG5q1vF9qezV4wKwAMvCp/n9tGVR5G892+dn3MEUxJPc1Qio29wPGL
   HBshE3QHCJUA+0F+3UKCAGoPAgDMzltPdTRz5AisFnLrsfBMn6Z/0shlT
   g==;
X-CSE-ConnectionGUID: 8RMR8SH+TiymmI8yqB+jrw==
X-CSE-MsgGUID: iL+ss7IoSBqOmfHTMz6+og==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21262318"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21262318"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:09 -0700
X-CSE-ConnectionGUID: moZFYLtfQ0GLwM5gpyMMow==
X-CSE-MsgGUID: OTrRLb4sR2Gu6k7D1KgEpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58568783"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:07 -0700
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
Subject: [v3 2/4] cxl/pci: Remove duplicated implementation of waiting for memory_info_valid
Date: Tue, 13 Aug 2024 19:05:30 +0800
Message-Id: <20240813110532.870869-3-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813110532.870869-1-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory
related info") added another implementation of waiting for
memory_info_valid without realizing it duplicated wait_for_valid()

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c        | 41 +++++------------------------------
 drivers/cxl/cxl.h             |  2 +-
 drivers/cxl/port.c            |  2 +-
 tools/testing/cxl/test/mock.c |  4 ++--
 4 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2d69340134da..38c567727dbb 100644
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
@@ -322,11 +291,13 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
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
 	u16 cap, ctrl;
 
 	if (!d) {
@@ -353,11 +324,9 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
-	rc = wait_for_valid(pdev, d);
-	if (rc) {
-		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
+	rc = cxl_dvsec_mem_range_valid(cxlds, 0);
+	if (rc)
 		return rc;
-	}
 
 	/*
 	 * The current DVSEC values are moot if the memory capability is
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

