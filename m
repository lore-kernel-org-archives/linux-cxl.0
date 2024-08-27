Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD017BBF
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736502; cv=none; b=p4eST/fV6C1K74RRtkYWHxryQn5t3ni1j20/9qFW7VNIYdRMkQMyes3W7BG8H489CSxOz0RIUqGQYDAIrskTmjXNogWXcU+ndnR+zk42CrX/HUCdY4ybvp67Q4qKXJoaXtzeh11vAMWpsFA1CKSHR+7UzB3tGQrHeXWatWjs7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736502; c=relaxed/simple;
	bh=HL0ZzHFXEcdBAolH7YjGoPnmg6Y627narkh9fcz7ZhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LofXpQa1VNtUdisDJGkiAZ04UF2ukRB5bCl1IFZr4GuvLZL629h3/2q/yfP2U94l9W3lz1nAMPK0uKavs5CnQE0EQMx2Rm6CDj7xDXkSZT//jJVS4dcTpXczbFAkm+kNTJVX2nWTcpon/ZcEB6qheukxLCpLCvl3Q9E6FgtqhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRbeDY/P; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRbeDY/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724736501; x=1756272501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HL0ZzHFXEcdBAolH7YjGoPnmg6Y627narkh9fcz7ZhY=;
  b=YRbeDY/PNyiYw8mqUV5h8HPQGv9nuRF2gL+BtPxoGgQxabs60HSYVtLm
   AusnEGBQGyPpZtTjSK00n9D+CW+W3Si23vuVoIh7cTPc8a10PeQqZ8Low
   Jd2I26bU0K5d1UpEZ7F5lteqC598PrvV6Zio6+pfRif3DPQoda4GrmrDP
   ly+4PxqwaBb8T+IC5r40Cl7sNA0VuwkSi4+qrpj4rLXr9bbrnn5jb1iVi
   eWj8q/HqfN1iMBGX36zt9nH0g4m9baQTAlK5mrvjiQCil51EWlr70a9NB
   n+Iq7/ygzDvLCsQZ8fo0JvoqVBROj/4xP8waPQIbKcRd4cRSpPUFCAgYm
   w==;
X-CSE-ConnectionGUID: 6G3N1TuDQ0aDPHe39G++Og==
X-CSE-MsgGUID: Q1S8YbsLTo6kD640HXNDKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22715163"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="22715163"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:28:21 -0700
X-CSE-ConnectionGUID: NISbm/iDS/OTJbkJXGwCUA==
X-CSE-MsgGUID: bNhvW390TcyOvHMx3qcjpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62577907"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:28:18 -0700
From: Li Ming <ming4.li@intel.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [PATCH 3/3] cxl/pci: Remove reduplicate host_bridge->native_aer checking
Date: Tue, 27 Aug 2024 04:57:55 +0000
Message-Id: <20240827045755.1837473-3-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240827045755.1837473-1-ming4.li@intel.com>
References: <20240827045755.1837473-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_dport_init_aer() already checks host_bridge->native_aer before
invoking cxl_disable_rch_root_ints(), so cxl_disable_rch_root_ints()
does not need to check it again.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pci.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 118db6a577d7..7234166df0df 100644
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

