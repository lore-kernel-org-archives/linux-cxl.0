Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAE16727B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196583; cv=none; b=mJk9YhzpFN2CvIOxllNTu9L0QDCD5TBDyeyg7nUn+oCHwyGXWYQL8rdFaE+xOqjikaNKHQ+sFrDFNxeDhMUDpoY2LH1D4FJUUokw53xt1ZVXhk1pECREETv5HPbKK6xwA23x0vd3TOn8MHmQc48KAZk5govsa37S+eaUPVijzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196583; c=relaxed/simple;
	bh=UIRyh2ZYXZHQcHkloLWuDIWhuQjkFjacaO7GSaeC1bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLAdtTctLp5mdrE96gEtGs0EZcR/QqfYixoaRmzb4ZvHfozXyCRZAn4c8aO6Nh4xrOJtchsli0VDqxUd6UTyJmrVqSKKyF1O90N/YaKLUXF2oG6jmUB3+7sIZ3j+bWPR7d3BCx+j+2AcRdyY+2Z0iWpAWAnPva6gJzztg0stYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IURqzsLb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IURqzsLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723196582; x=1754732582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UIRyh2ZYXZHQcHkloLWuDIWhuQjkFjacaO7GSaeC1bk=;
  b=IURqzsLbsTPtLRagyLdsGNDWsZvrY5qMirgks4DloeiUyDxrXw7ZI+fb
   r7qcQOtRp2ucfNdwzo7zcNxd6UVTxVL4O02Uh857z/GxbCAi+bb+/LHur
   lRzHHassOAKafkee2iq1CXr7L1JYbA45dTGnOM9YkRiX8cYxON7a+BLnV
   4rECPLD7dkn5r3byUpt/LO8nUkt3qTbVZLhTu5EjYO+GSNVdsRTj7jX+M
   DKgThpRVjSiFcyudfXNLB8TPSE0RIH7tioXhwS+28myq0O8vbupF5rOEo
   bcN2rDINwAGlUBx+r9h7SriA0ks4NtpGDevtNAwfQnUoNwR/4pi0pOfFM
   w==;
X-CSE-ConnectionGUID: qTI/VxvvSJaaG6aEfiUKZw==
X-CSE-MsgGUID: CgRotvqfSJGyQxUjnPHFDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38869660"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="38869660"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:43:01 -0700
X-CSE-ConnectionGUID: Llmgg3MkRj+E5ItgF3Y0YA==
X-CSE-MsgGUID: dfsgZY4SRWm2M0v7SwGiIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62352841"
Received: from tower.bj.intel.com ([10.238.157.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:42:59 -0700
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
Subject: [v2 3/4] cxl/pci: Check Mem_info_valid bit for each applicable DVSEC range
Date: Fri,  9 Aug 2024 17:34:41 +0800
Message-Id: <20240809093442.646545-4-yanfei.xu@intel.com>
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

The right way is to checking Mem_info_valid bit for each applicable
DVSEC range against HDM_COUNT, not only for the DVSEC range 1. Also
the functions to check the Mem_info_valid bit are repeatedly
implemented, drop the rough one.

Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 41 ++++-------------------------------------
 1 file changed, 4 insertions(+), 37 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0915fc9e6d70..e822cc9ce315 100644
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
@@ -356,12 +325,6 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
-	rc = wait_for_valid(pdev, d);
-	if (rc) {
-		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
-		return rc;
-	}
-
 	root = to_cxl_port(port->dev.parent);
 	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
 		root = to_cxl_port(root->dev.parent);
@@ -389,6 +352,10 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 		u64 base, size;
 		u32 temp;
 
+		rc = cxl_dvsec_mem_range_valid(cxlds, i);
+		if (rc)
+			return rc;
+
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
-- 
2.39.2

