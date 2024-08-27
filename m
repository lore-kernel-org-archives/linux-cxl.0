Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEEF132132
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736500; cv=none; b=uneg+dVDmzGjLIAF3hdfjvP8FgSHyK/vO1piSnN3aOV38UJcXYxGjqONlG+eQycbTpTF/JGuweEG/QjWEMlrZoSOdefe7CxMF4FfjlL/tJzuOlpQxvZBCdGfc8Xd3bFXEl7lfcUzfppNFPmr6PoJ9Gp/cu0evovQZBdIUIu6YdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736500; c=relaxed/simple;
	bh=I+nJQc/HxjlQKkoNoN8r/+y4va53o5OSwejbFz8FlLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njnIUbpkEry2GI+0ZPp7cnOA7WtNIyjID6A/aHJLlrb4kErpa41j7Qc0OSb8rPqS1imaRHvoyd9++1K/XlYCgTj24E1exZ8x+Vo45FAfSpxfT1jSZeTHsknBOUoMRzIk8zZHDKMZPeINbj8CZ6USrAML9ydG5IF1CWKmXbbMfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L62XbQx7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L62XbQx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724736498; x=1756272498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I+nJQc/HxjlQKkoNoN8r/+y4va53o5OSwejbFz8FlLQ=;
  b=L62XbQx7MjNjMO1gHAxb0d7wrquatfP3xGbUpwV3nQtu9kIjLVz+dxRS
   thxecak1MZZxx7Qr6CvrSrduPyENED1vFyUTuz2pT4pLAdIWgOAgopH2V
   kPTcLinJdaE6etglGqVPPE8eIdt7rJHjvpEQEK0M44nVhp2nHebyWlyZG
   ONsa+hZY0t3efqsJDSclCKKHQIYxg0B6kvbdaYte3H3fJcI8Pb5DVWO6r
   A9bkTRtywO4aBfxqFk9Y/oFVqYGcHyZtNHWep/J9QNMuaw2ej8Itq4Jfo
   c9smZ3/Fi6Ls3gcBBTafY+d3nKo0p1DpAKkMTywBvn1TGkbsdG1jrEyYo
   g==;
X-CSE-ConnectionGUID: SdtiMVIaSOWt57ZxSRiMNA==
X-CSE-MsgGUID: TvAhdifYT/WQz468qA0+bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22715158"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="22715158"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:28:18 -0700
X-CSE-ConnectionGUID: jpGk9+KWRxeYqjgTVpoRmA==
X-CSE-MsgGUID: SBFkt5mKQ3mvfmGMBqkl3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62577900"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:28:16 -0700
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
Subject: [PATCH 2/3] cxl/pci: cxl_dport_map_rch_aer() cleanup
Date: Tue, 27 Aug 2024 04:57:54 +0000
Message-Id: <20240827045755.1837473-2-ming4.li@intel.com>
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

cxl_dport_map_ras() is used to map CXL RAS capability, the RCH AER
capability should not be mapped in the function but should mapped in
cxl_dport_init_aer(). Moving cxl_dport_map_ras() out of
cxl_dport_map_ras() and into cxl_dport_init_aer().

In cxl_dport_init_aer(), the AER capability position in RCRB will be
located but the position is only used in cxl_dport_map_rch_aer(),
getting the position in cxl_dport_map_rch_aer() rather than
cxl_dport_init_aer() is more reasonable and makes the code clearer.

Besides, some local variables in cxl_dport_map_rch_aer() are
unnecessary, remove them to make the function more concise.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pci.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9761178372b6..118db6a577d7 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -772,19 +772,17 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
-	struct cxl_rcrb_info *ri = &dport->rcrb;
-	void __iomem *dport_aer = NULL;
 	resource_size_t aer_phys;
 	struct device *host;
+	u16 aer_cap;
 
-	if (dport->rch && ri->aer_cap) {
+	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
+	if (aer_cap) {
 		host = dport->reg_map.host;
-		aer_phys = ri->aer_cap + ri->base;
-		dport_aer = devm_cxl_iomap_block(host, aer_phys,
-				sizeof(struct aer_capability_regs));
+		aer_phys = aer_cap + dport->rcrb.base;
+		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
+						sizeof(struct aer_capability_regs));
 	}
-
-	dport->regs.dport_aer = dport_aer;
 }
 
 static void cxl_dport_map_ras(struct cxl_dport *dport)
@@ -797,9 +795,6 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 	else if (cxl_map_component_regs(map, &dport->regs.component,
 					BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(dev, "Failed to map RAS capability.\n");
-
-	if (dport->rch)
-		cxl_dport_map_rch_aer(dport);
 }
 
 static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
@@ -838,20 +833,18 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
  */
 void cxl_dport_init_aer(struct cxl_dport *dport, struct device *host)
 {
-	struct device *dport_dev = dport->dport_dev;
+	dport->reg_map.host = host;
+	cxl_dport_map_ras(dport);
 
 	if (dport->rch) {
-		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
-
-		if (host_bridge->native_aer)
-			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
-	}
+		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
 
-	dport->reg_map.host = host;
-	cxl_dport_map_ras(dport);
+		if (!host_bridge->native_aer)
+			return;
 
-	if (dport->rch)
+		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_aer, CXL);
 
-- 
2.40.1

