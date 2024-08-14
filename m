Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F06566A;
	Wed, 14 Aug 2024 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657795; cv=none; b=FeVFA+zGOEDTglhtbVl+viPAvXY50FJYjks0Apmbik1D7DGrdGMnvHB5frChcZifKg33vYvdniInXN2DR/HBC+YaYjT1QqAzDlRfRlG4s2Gsc9tREiOy5UrPsZyoA1XQ+Fqh2GTxdeZZPnxpE0TiirqxaINCbKQJ4sOXGjCGrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657795; c=relaxed/simple;
	bh=7Kig8+LDSPEdSjGC360OezgR5t+AxhfIthSl98qftO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eVQQCRmbNZBDKGPf+VKB6z1kppOQ7clFqmGtIkobaK0LLZDZL5NOc6Ez/7EQiozq3t2qf6sKdjEwHk9n/S9/DWFNSOZP5y8lgHrMnZ09c30ZEiXrAGe78Mdz5u0/AjyOwlmSUWRNpX1HFhtE4Ze4EVDYlBIumIzBBWjr7ox1I6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPlioNc5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPlioNc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723657793; x=1755193793;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=7Kig8+LDSPEdSjGC360OezgR5t+AxhfIthSl98qftO8=;
  b=lPlioNc5eRtlAMBzOxRKI/0gma8pmsW/65TViEEnLZul60h+VCnzZocI
   drRSxp8JLAfESzzcVcFidtPYuqmnvdpfrBdAgkOb3/7vVw4604673/sm4
   bCr6qM5oUE+56EkR+g8pykcyZT3pCKS8udwm4421mshklnL481Qc5hZ1m
   +wkfDWdE678z0gZZ4evVfmCKhJCa4SRPTZzfqPvqlzC/iLm0fu1wC3is4
   5GBBEVFCLbR6ghTkCRTD38dTQv9Dt1M4NVVM4jZUonIRWbp+3HN8/7+0g
   cpOIBnEdZ75zNOCosNZ4F+wR5/bEmx4YQmwnqXOZA08E6qP258dHIap7M
   A==;
X-CSE-ConnectionGUID: GRw1Yzp1RVqAujo/JjHZMg==
X-CSE-MsgGUID: 8JXfHUOXRWi5hcHFlJjMEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="25757438"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="25757438"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:49:53 -0700
X-CSE-ConnectionGUID: 9ylW5xX1RsmNSa41dolpDg==
X-CSE-MsgGUID: g0e0J6bTSVyuM0LjU4Qtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="63750436"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.110.97])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:49:51 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 14 Aug 2024 12:49:39 -0500
Subject: [PATCH v2] cxl/region: Remove lock from memory notifier callback
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com>
X-B4-Tracking: v=1; b=H4sIADLuvGYC/3WMyw7CIBBFf6WZtRheGurK/zBdIAx2EoUGSKNp+
 Hexe5fn5p6zQcFMWOAybJBxpUIpdpCHAdxs4wMZ+c4gudTcCMUCvVlMlQJhLmwcnTrxO9faSuj
 OkrEf9t5t6jxTqSl/9vwqfuu/0iqYYBi8VFaYszH+SrHi8+jSC6bW2hdijUOPqgAAAA==
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723657790; l=4730;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=7Kig8+LDSPEdSjGC360OezgR5t+AxhfIthSl98qftO8=;
 b=0cC1vjRF+p44Si7lE8qwrFJJNFTMTeEgm+lFR3O/TH69vKj/fvY0pvJYiVqWFbS0PPi+Vep+O
 4vb2D0FalpyCF+3hsMUOyBHmdDQQ1+2ILsxyIgf6Krh2eQSUlnPUZjl
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

In testing Dynamic Capacity Device (DCD) support, a lockdep splat
revealed an ABBA issue between the memory notifiers and the DCD extent
processing code.[0]  Changing the lock ordering within DCD proved
difficult because regions must be stable while searching for the proper
region and then the device lock must be held to properly notify the DAX
region driver of memory changes.

Dan points out in the thread that notifiers should be able to trust that
it is safe to access static data.  Region data is static once the device
is realized and until it's destruction.  Thus it is better to manage the
notifiers within the region driver.

Remove the need for a lock by ensuring the notifiers are active only
during the region's lifetime.

Furthermore, remove cxl_region_nid() because resource can't be NULL
while the region is stable.

Link: https://lore.kernel.org/all/66b4cf539a79b_a36e829416@iweiny-mobl.notmuch/ [0]
Cc: Huang, Ying <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- [djbw: remove cxl_region_nid()]
- Link to v1: https://patch.msgid.link/20240813-fix-notifiers-v1-1-efd23a18688d@intel.com
---
 drivers/cxl/core/region.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..588add3536c3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2313,8 +2313,6 @@ static void unregister_region(void *_cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
-	unregister_memory_notifier(&cxlr->memory_notifier);
-	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 	device_del(&cxlr->dev);
 
 	/*
@@ -2391,18 +2389,6 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 	return true;
 }
 
-static int cxl_region_nid(struct cxl_region *cxlr)
-{
-	struct cxl_region_params *p = &cxlr->params;
-	struct resource *res;
-
-	guard(rwsem_read)(&cxl_region_rwsem);
-	res = p->res;
-	if (!res)
-		return NUMA_NO_NODE;
-	return phys_to_target_node(res->start);
-}
-
 static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 					  unsigned long action, void *arg)
 {
@@ -2415,7 +2401,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
 		return NOTIFY_DONE;
 
-	region_nid = cxl_region_nid(cxlr);
+	region_nid = phys_to_target_node(cxlr->params.res->start);
 	if (nid != region_nid)
 		return NOTIFY_DONE;
 
@@ -2434,7 +2420,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 	int *adist = data;
 	int region_nid;
 
-	region_nid = cxl_region_nid(cxlr);
+	region_nid = phys_to_target_node(cxlr->params.res->start);
 	if (nid != region_nid)
 		return NOTIFY_OK;
 
@@ -2484,14 +2470,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	if (rc)
 		goto err;
 
-	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
-	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
-	register_memory_notifier(&cxlr->memory_notifier);
-
-	cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
-	cxlr->adist_notifier.priority = 100;
-	register_mt_adistance_algorithm(&cxlr->adist_notifier);
-
 	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
 	if (rc)
 		return ERR_PTR(rc);
@@ -3386,6 +3364,14 @@ static int is_system_ram(struct resource *res, void *arg)
 	return 1;
 }
 
+static void shutdown_notifiers(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+
+	unregister_memory_notifier(&cxlr->memory_notifier);
+	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -3418,6 +3404,18 @@ static int cxl_region_probe(struct device *dev)
 out:
 	up_read(&cxl_region_rwsem);
 
+	if (rc)
+		return rc;
+
+	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
+	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
+	register_memory_notifier(&cxlr->memory_notifier);
+
+	cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
+	cxlr->adist_notifier.priority = 100;
+	register_mt_adistance_algorithm(&cxlr->adist_notifier);
+
+	rc = devm_add_action_or_reset(&cxlr->dev, shutdown_notifiers, cxlr);
 	if (rc)
 		return rc;
 

---
base-commit: 6b0f8db921abf0520081d779876d3a41069dab95
change-id: 20240813-fix-notifiers-99c350b044a2

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

