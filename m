Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0789126AED;
	Wed,  4 Sep 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461279; cv=none; b=dpLynui114KttrBU642aVf0W6FEMwqA35DQDNvh6xZebj16kyGkh7hzEi2pgcwe8o9U03vGRzYGEcsv1Csyq+zARuI8FP1oIV4t2PM+YQbz5XY8HA2ZiOYvVafQxdAl46Gr0X2bErtLTdXQ7P2sGTDk2WMeMup10n3oDLFzsQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461279; c=relaxed/simple;
	bh=mU0KzA224qXoCbPfGh2pyAoZukwp+fmwa8j8BL/k5BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RpTthKTdAyNp7CzJ6cH7AhEggexkiSzMP/5sd08os2VqT6d/yOvjCmwRrf4eVFp2x1Ez6mTxqXruKuxFogA+XzoOm0tjxtjLvXNL9iFB7aRq/t6X9Bt6oxGYvS+DyJnVjjHp0S/9wpOVMI9cJvpmXzWNJhpsGh2fmmyB74lu2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AohnrcaA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AohnrcaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725461277; x=1756997277;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=mU0KzA224qXoCbPfGh2pyAoZukwp+fmwa8j8BL/k5BY=;
  b=AohnrcaAcUMJFmPuq5HfZSLN5maa3VFhF56fRt+o3XZH9Z0LJqzqBPAd
   IIiELCSYVBqzc4zzMI4BW3j5RpP3dhvrdAykOHzsevImbKA58aFoEEbvx
   joXsz3hrbkqD6bjEm3NZVyujxNnxg1W7b/cahq20tRYwXSUCTnre1Gryh
   114uLvmAb2uMNzi9/xtCg8v2Uu2f8jcHB9gPAJ1Mf1bSe3O7ZD8cysNzx
   RjRQX0AQH2Iqv0Rm0sRXAhBPXOnXvRpzB7DLd8SWRws4F3OjgF/i64pO1
   /e4fFXM7NRTLj/hhVihxLiXuuUMg8iyjHEpEH0S3BAqfQS+w9b40vEqk9
   A==;
X-CSE-ConnectionGUID: UTzq1il/RuqnoV/xOxQIQg==
X-CSE-MsgGUID: VMUervLYTEqszeHATX28/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24318084"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="24318084"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:47:56 -0700
X-CSE-ConnectionGUID: VIJxpYjoQHarQZouFm6ZTw==
X-CSE-MsgGUID: 7NU172oHQNihxkUVylelKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="65334086"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.109.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:47:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 04 Sep 2024 09:47:54 -0500
Subject: [PATCH v3] cxl/region: Remove lock from memory notifier callback
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-fix-notifiers-v3-1-576b4e950266@intel.com>
X-B4-Tracking: v=1; b=H4sIABlz2GYC/3WMwQ7CIBAFf6XhLAYWrNST/2E8ULq1myg00BBN0
 3+X9tSYeJyXNzOzhJEwsUs1s4iZEgVfQB0q5gbrH8ipK8xAgBZGKt7Tm/swUU8YE28ap06iFVp
 bYMUZI5bD1rvdCw+UphA/Wz7Ldf1XypJLjn0HykpTG9NdyU/4PLrwYmspw97WvzYUu25tq4xsw
 J3d3l6W5QuMEBw66AAAAA==
To: Ying Huang <ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725461274; l=5311;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=mU0KzA224qXoCbPfGh2pyAoZukwp+fmwa8j8BL/k5BY=;
 b=K7kpeyOuwtMsbzKbGbF2O/q3beeeM/CtRgdcnvJs50iCfrB48sDrhoaVGKYY0l8x8MSWqEiKe
 vxGoccys1ZwCXIBG+yZx1rIwa7ljYqloUTCdHc/HjWVazyDdWExB8h2
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
Cc: Ying Huang <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v3:
- [Ying: Add comment regarding cxl_region_rwsem]
- [iweiny: pickup tags]
- Link to v2: https://patch.msgid.link/20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com

Changes in v2:
- [djbw: remove cxl_region_nid()]
- Link to v1: https://patch.msgid.link/20240813-fix-notifiers-v1-1-efd23a18688d@intel.com
---
 drivers/cxl/core/region.c | 54 ++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..dbc9f8a4f603 100644
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
@@ -2415,7 +2401,11 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
 		return NOTIFY_DONE;
 
-	region_nid = cxl_region_nid(cxlr);
+	/*
+	 * No need to hold cxl_region_rwsem; region parameters are stable
+	 * within the cxl_region driver.
+	 */
+	region_nid = phys_to_target_node(cxlr->params.res->start);
 	if (nid != region_nid)
 		return NOTIFY_DONE;
 
@@ -2434,7 +2424,11 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 	int *adist = data;
 	int region_nid;
 
-	region_nid = cxl_region_nid(cxlr);
+	/*
+	 * No need to hold cxl_region_rwsem; region parameters are stable
+	 * within the cxl_region driver.
+	 */
+	region_nid = phys_to_target_node(cxlr->params.res->start);
 	if (nid != region_nid)
 		return NOTIFY_OK;
 
@@ -2484,14 +2478,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
@@ -3386,6 +3372,14 @@ static int is_system_ram(struct resource *res, void *arg)
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
@@ -3418,6 +3412,18 @@ static int cxl_region_probe(struct device *dev)
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
base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
change-id: 20240813-fix-notifiers-99c350b044a2

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

