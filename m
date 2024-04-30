Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0461A0AF9
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514343; cv=none; b=TQsLHCL2AXCA5TSJOA3mg3ATOUCd3yBVyEsdtCY6PDRFvpfYO1DcOELp1Y46/Vs7ptyayceLQ0sq2HTe0zA3ZgK2LPdXkWPWNEVmeDj50KfgbT0gAMxrOYEHcsy1Nv4ctXeGYDKSD5TZmbEZz+945CJ4s/uTHx1wtx0CbJAMrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514343; c=relaxed/simple;
	bh=UW15NPdktJcHHetgrISz8mlJ3BbcLOMwIT+D2804+rs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Lc4RUC4iCxpCW7kk5UCbOYuKepXWm/KyLIINobzXQXz26a4CmnVBCm2RgRSFQ5KjihLln8JQMJRoCG18FA7AMwhOuOjtzB2LriY2Ek2tp+jdDlqywuFi666ufbbaq88SLMgUbH80oWCjf+CDK6r3iPjm879FxcNJu7PDeYB/pBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIXcV8yU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIXcV8yU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714514342; x=1746050342;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UW15NPdktJcHHetgrISz8mlJ3BbcLOMwIT+D2804+rs=;
  b=aIXcV8yUIZO3bheJCHC9XIV0p4IFmVk8MvGGjkhGmLAs2iG8tKNmgUOl
   YckJxPt4tG95cv/hNMH07XICYKiJd/w2ZHgaSloB9QS9IjWy1d9UIcr7P
   6BBZenDB0DpWtWT5vCMDFrzwOUDy0EJnHoYZy2UbiS4DgdXzuZzJajg7E
   7wEy+vJogQf8o+jpLc5G8xRvGdUV+K4nzEgq02ZEbZ5dl+wonK0TzSWXc
   Vp/+SNf/IpmtalAc1gtrXpjV1WUdxdnigZKozvTVBrbO5NACIqJUVcW3k
   nHlWJSvhe5K2LePmf7ifEIfoqbKk+RAD/0RxF62V9AHvenGB1pWYj/hjx
   A==;
X-CSE-ConnectionGUID: iCRHJKguTvGrrT+7eaOfSA==
X-CSE-MsgGUID: RaPupLKdQaKIeqZkYf7lUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10174384"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10174384"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:59:01 -0700
X-CSE-ConnectionGUID: C4Nlj5NNQnCzbERp5SOBUA==
X-CSE-MsgGUID: Fz0+mxw6QoSmdikB03ccFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="49817131"
Received: from seastwoo-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.161.93])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:59:01 -0700
Subject: [PATCH] cxl/region: Convert cxl_pmem_region_alloc to scope-based
 resource management
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linux-cxl@vger.kernel.org
Date: Tue, 30 Apr 2024 14:59:00 -0700
Message-ID: <171451430965.1147997.15782562063090960666.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A recent bugfix to cxl_pmem_region_alloc() to fix an
error-unwind-memleak [1], highlighted a use case for scope-based resource
management.

Delete the goto for releasing @cxl_region_rwsem, and return error codes
directly from error condition paths.

The caller, devm_cxl_add_pmem_region(), is no longer given @cxlr_pmem
directly it must retrieve it from @cxlr->cxlr_pmem. This retrieval from
@cxlr was already in place for @cxlr->cxl_nvb, and converting
cxl_pmem_region_alloc() to return an int makes it less awkward to handle
no_free_ptr().

Cc: Li Zhijian <lizhijian@fujitsu.com>
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: http://lore.kernel.org/r/20240430174540.000039ce@Huawei.com
Link: http://lore.kernel.org/r/20240428030748.318985-1-lizhijian@fujitsu.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hey Dave, this applies on top of Li's fix.

 drivers/cxl/core/region.c |   43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 812b2948b6c6..e0577d99c4db 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2681,26 +2681,21 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 
 static struct lock_class_key cxl_pmem_region_key;
 
-static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
+static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-	struct cxl_pmem_region *cxlr_pmem;
 	struct device *dev;
 	int i;
 
-	down_read(&cxl_region_rwsem);
-	if (p->state != CXL_CONFIG_COMMIT) {
-		cxlr_pmem = ERR_PTR(-ENXIO);
-		goto out;
-	}
+	guard(rwsem_read)(&cxl_region_rwsem);
+	if (p->state != CXL_CONFIG_COMMIT)
+		return -ENXIO;
 
-	cxlr_pmem = kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets),
-			    GFP_KERNEL);
-	if (!cxlr_pmem) {
-		cxlr_pmem = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	struct cxl_pmem_region *cxlr_pmem __free(kfree) = kzalloc(
+		struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
+	if (!cxlr_pmem)
+		return -ENOMEM;
 
 	cxlr_pmem->hpa_range.start = p->res->start;
 	cxlr_pmem->hpa_range.end = p->res->end;
@@ -2718,11 +2713,8 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
 		 */
 		if (i == 0) {
 			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
-			if (!cxl_nvb) {
-				kfree(cxlr_pmem);
-				cxlr_pmem = ERR_PTR(-ENODEV);
-				goto out;
-			}
+			if (!cxl_nvb)
+				return -ENODEV;
 			cxlr->cxl_nvb = cxl_nvb;
 		}
 		m->cxlmd = cxlmd;
@@ -2733,18 +2725,16 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
 	}
 
 	dev = &cxlr_pmem->dev;
-	cxlr_pmem->cxlr = cxlr;
-	cxlr->cxlr_pmem = cxlr_pmem;
 	device_initialize(dev);
 	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
 	device_set_pm_not_required(dev);
 	dev->parent = &cxlr->dev;
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_pmem_region_type;
-out:
-	up_read(&cxl_region_rwsem);
+	cxlr_pmem->cxlr = cxlr;
+	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
 
-	return cxlr_pmem;
+	return 0;
 }
 
 static void cxl_dax_region_release(struct device *dev)
@@ -2861,9 +2851,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	struct device *dev;
 	int rc;
 
-	cxlr_pmem = cxl_pmem_region_alloc(cxlr);
-	if (IS_ERR(cxlr_pmem))
-		return PTR_ERR(cxlr_pmem);
+	rc = cxl_pmem_region_alloc(cxlr);
+	if (rc)
+		return rc;
+	cxlr_pmem = cxlr->cxlr_pmem;
 	cxl_nvb = cxlr->cxl_nvb;
 
 	dev = &cxlr_pmem->dev;

