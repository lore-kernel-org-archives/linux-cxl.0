Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A014D71D
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000202; cv=none; b=tsFKfbtM7a4YA6DkSz2bkpgbjwnswTUECCNwg6nYDX9Lqga47yXROmoz2adxt480a34ls59SNB0sXoLlUkTxo9EqZtGJdd90lUydjsocaG6hama3VSpaQOlqiUZ47fCmA3kunQfrYV74vcdYSGyCe32y7PwKcQKqPCRvneatvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000202; c=relaxed/simple;
	bh=LSpwzvY8Xx8sE6CH97HYEYsAWvy76JdXSKpOZVWi2cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KU3R1MUffBNzWLrKiSlTFYpRGz+N8xwEw1bKLgYeal/NVVy8Q74mvb4lR3I8F7ghIqoVr0jw1zb73bmXZsG/sZdX2pJ62p6refPvNhFgoTsbpic2imU+PTQMuSSc7Pr0PERZgNo7+fTBzBXX0LJMtxSR2Oud0RfaIi6OFFN0Vf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJYzfJ/t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJYzfJ/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725000201; x=1756536201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LSpwzvY8Xx8sE6CH97HYEYsAWvy76JdXSKpOZVWi2cM=;
  b=fJYzfJ/tguzo56VmNuqtXav0H9wxlxErHV3pA1jzZDJ0Oi5U/zUgkwgm
   463MLys4+erTuP6uC5IZAw/bpDU4mdm6VE3Dl0qMSth/V9DoclfpdfC0Y
   IzOIQBdl892nJ4KEk+1snrRtIHFAS41CVx5TJHngO5X3irp7AlDnS/KaM
   fJ5ZmU8hVqg2OnPk4mC+9G0DBugINKWvKHMwvyWWa3VWhQrhQ6m2N2kEz
   g5qvbwFz8k5uOs9L88iOzudwYAsgAqzs9SMkHGGmp0bguBJMJfoEmYnLs
   SKj9BmIDaoDoXHt87lXsbOfPjU7HuFPfOr++iuAd4fDnyqL4EiEJ1Xgvw
   A==;
X-CSE-ConnectionGUID: 2nnlT4c/QNye7kp8VGU7dw==
X-CSE-MsgGUID: bDcOi6jqRrqRbG65lP6e2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27424911"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="27424911"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:43:21 -0700
X-CSE-ConnectionGUID: t272AHdzQcmntNK6b4UCtQ==
X-CSE-MsgGUID: 1GmOI3zgQvW8iI7hgZIMSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="94631086"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:43:17 -0700
From: Li Ming <ming4.li@intel.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Li Ming <ming4.li@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 3/3] cxl/pci: Remove duplicate host_bridge->native_aer checking
Date: Fri, 30 Aug 2024 06:13:08 +0000
Message-Id: <20240830061308.2327065-3-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240830061308.2327065-1-ming4.li@intel.com>
References: <20240830061308.2327065-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_dport_init_ras_reporting() already checks host_bridge->native_aer
before invoking cxl_disable_rch_root_ints(), so
cxl_disable_rch_root_ints() does not need to check it again.

Signed-off-by: Li Ming <ming4.li@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c61b64162730..c84413ce0c6d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -800,14 +800,11 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 {
 	void __iomem *aer_base = dport->regs.dport_aer;
-	struct pci_host_bridge *bridge;
 	u32 aer_cmd_mask, aer_cmd;
 
 	if (!aer_base)
 		return;
 
-	bridge = to_pci_host_bridge(dport->dport_dev);
-
 	/*
 	 * Disable RCH root port command interrupts.
 	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
@@ -816,14 +813,12 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	 * the root cmd register's interrupts is required. But, PCI spec
 	 * shows these are disabled by default on reset.
 	 */
-	if (bridge->native_aer) {
-		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
-				PCI_ERR_ROOT_CMD_NONFATAL_EN |
-				PCI_ERR_ROOT_CMD_FATAL_EN);
-		aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
-		aer_cmd &= ~aer_cmd_mask;
-		writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
-	}
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
 /**
-- 
2.40.1

