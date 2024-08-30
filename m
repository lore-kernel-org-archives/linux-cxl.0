Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6514D71D
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000199; cv=none; b=mOMnC+ny9XeJt4asPTVvSPOWY0wwmlL7W09ehA32z/nAAi01vS4+x2w0eGK+Drqd1a06+l9fd476Pditgnpp9MFFeHIY/eYWHJJesq4wkBK7iQulwNYCpcWTL7F6jXwcl4INiuTQ19+F4cd/i1jnYM/ZVgOw3PMznmRfwjJG5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000199; c=relaxed/simple;
	bh=9xYOA3icJFJAs7WRbkgrWkFSK/TugKealAkrMj13GHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckye+3tlbRHVLgcWUwZbiMKcjA8TedJ4j/Hh5SAWyy8NfU90L6+OkOMegGBSLRPcUBXJ0VlQey9Hc67mTdOdrudO06yVRSCLSZeJiY41YsPFWSFzUJ4wnVyGqv185wpdIeMApGvQqea0huvbigDd02Hm1PUvBpm4jn2qfDNZYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/MOJeW/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/MOJeW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725000198; x=1756536198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9xYOA3icJFJAs7WRbkgrWkFSK/TugKealAkrMj13GHg=;
  b=T/MOJeW/HLzXxJew7yAg50lQGH4KZpcGHKBXX1sRcxSVVKcE//wDV7Tp
   QphW9WrfouJqm9ePL2XROsl9sSVFwSDxr8ix3ikret8f4FcgkWms0YqTi
   w1F5t2867K5L+6SrEJoAHZPK1bjsmW8fghGaZB0UIF6Z51PUnTNpwuf0X
   9ky9lgFWrUw1j/G92A3SFhwv8cawKTtU7lN/6FcH6VeFXv6U2UKQdGuR2
   SOJ/0K7dph6Wjid+Hvsxl//23Qdc6npHN3aCOwlD/tyjK7lMzeSOGukX5
   EwoGEYvR+iGfSG/55Zu4RrglUkNqZTLOk/75ffPIQU4SV/WUcC+gQq6NG
   w==;
X-CSE-ConnectionGUID: yyyAHzjTRWqdHvPCzvK+7w==
X-CSE-MsgGUID: b6DN6XX2QjOccRsdd311uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27424904"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="27424904"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:43:17 -0700
X-CSE-ConnectionGUID: DwRC/f7/TWuadHUYY6wn0Q==
X-CSE-MsgGUID: N1A2f4MkTm2LJuRjVOLgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="94631077"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:43:14 -0700
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
Subject: [PATCH v2 2/3] cxl/pci: cxl_dport_map_rch_aer() cleanup
Date: Fri, 30 Aug 2024 06:13:07 +0000
Message-Id: <20240830061308.2327065-2-ming4.li@intel.com>
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

cxl_dport_map_ras() is used to map CXL RAS capability, the RCH AER
capability should not be mapped in the function but should mapped in
cxl_dport_init_ras_reporting(). Moving cxl_dport_map_ras() out of
cxl_dport_map_ras() and into cxl_dport_init_ras_reporting().

In cxl_dport_init_ras_reporting(), the AER capability position in RCRB
will be located but the position is only used in
cxl_dport_map_rch_aer(), getting the position in cxl_dport_map_rch_aer()
rather than cxl_dport_init_ras_reporting() is more reasonable and makes
the code clearer.

Besides, some local variables in cxl_dport_map_rch_aer() are
unnecessary, remove them to make the function more concise.

Signed-off-by: Li Ming <ming4.li@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 87f992a7f14a..c61b64162730 100644
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
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
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
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
-- 
2.40.1

