Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7935894;
	Tue, 13 Aug 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573563; cv=none; b=dmKWvE4irQig/00E5enjqgIJgtBTSReg77zFXttRn0xJAb88rHRKC5ebZhyQlAn5nHKOuRvRyxLD+/ZMQgY6gdHGUU5eQFai+XzmNja3/Eu4s4V99npAPKJR/XT9EWJl9P9OvBzP/R95zpbjhbXrjuSRBQPSpreQNWIsTpKjjJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573563; c=relaxed/simple;
	bh=X/RhGHI5I+eLq6MIzW8PFCsIaPH0gvXDQbvnvsDnvcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RAJgQl5oa5q1n62WGc3ps9KpTXoMeQwmu6PRNl0kQiSYX3xEb6UXYLAk6yfJP43B1wPmjleEygqNqWmccI/X5Sl7rR2+dV4GfYox/fNJC7eW1niC3abwHOewWA+JTuwy8Ebw9nANUJ9BN3kbklcPjaNXcQOORGebJLsY3ET0stU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pa4Li6Uk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pa4Li6Uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723573561; x=1755109561;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=X/RhGHI5I+eLq6MIzW8PFCsIaPH0gvXDQbvnvsDnvcA=;
  b=Pa4Li6UkzBy4SZVMcbnC6qoKCUzh0AfrPdgZwavUwLCN6fsrqc6MHfJ3
   j42IiizXf3JT+rObmSVG1+Phlhzuhl1dJDugHMBCx8LzjkgVAR2JqNYKm
   o1+KaUnZKrrUT3FnVYoKNhFvDQqLQJg/PTWXhuupH5vG0chkkyC33pHUK
   tmkq5pO0VTaVHzoTT42dhWWzR2PFKVNHrPuhci22BZEae31ZFHq3BAomg
   OnFGpaGlTqiHwAIGlw/m1Ge+Ama+XAcrs54h2H9b2jmBIvpRrgyA+7nWx
   WPNEV0tKkO7VaJorV7FbKdF2MkiRB4kGsyFKhPwUSki1T6npGK8O72Fls
   Q==;
X-CSE-ConnectionGUID: qkPbto2lQRKk6Ow1qQywUA==
X-CSE-MsgGUID: 5ScsTmddRoKCA1jL9uKAtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="24667184"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="24667184"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 11:26:00 -0700
X-CSE-ConnectionGUID: 2lInno0gQNyovCmc8izrWg==
X-CSE-MsgGUID: M7AtvTALT/2ewlxSO+v4vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="62911307"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO localhost) ([10.125.109.241])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 11:25:59 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 13 Aug 2024 13:25:57 -0500
Subject: [PATCH] cxl/region: Remove lock from memory notifier callback
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-fix-notifiers-v1-1-efd23a18688d@intel.com>
X-B4-Tracking: v=1; b=H4sIADSlu2YC/x2MSwqAIBQAryJvneAvyK4SLcye9TYaGhGId09aD
 sxMhYKZsMDMKmR8qFCKHeTAwJ8uHshp7wxKKCMmqXmgl8d0UyDMhVvr9Sg2YYxT0JsrYxf+37K
 29gGjqmAJXwAAAA==
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723573557; l=3584;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=X/RhGHI5I+eLq6MIzW8PFCsIaPH0gvXDQbvnvsDnvcA=;
 b=Yxcp83IkiNMm99+GDSIQ1nNY/qPVzEw6VjRRKYBrVO2ZPhu++AfM5J2N1Hq4Vx6WQrUSaECGs
 H1h/l6a9n/uD8UdGZfN0x8KqMzMZMmCcMM4NBXVDY9soSZCzrDYhmus
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

Link: https://lore.kernel.org/all/66b4cf539a79b_a36e829416@iweiny-mobl.notmuch/ [0]
Cc: Huang, Ying <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/region.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..971a314b6b0e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2313,8 +2313,6 @@ static void unregister_region(void *_cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
-	unregister_memory_notifier(&cxlr->memory_notifier);
-	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 	device_del(&cxlr->dev);
 
 	/*
@@ -2396,7 +2394,6 @@ static int cxl_region_nid(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
 	res = p->res;
 	if (!res)
 		return NUMA_NO_NODE;
@@ -2484,14 +2481,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
@@ -3386,6 +3375,14 @@ static int is_system_ram(struct resource *res, void *arg)
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
@@ -3418,6 +3415,18 @@ static int cxl_region_probe(struct device *dev)
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
base-commit: afdab700f65e14070d8ab92175544b1c62b8bf03
change-id: 20240813-fix-notifiers-99c350b044a2

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

