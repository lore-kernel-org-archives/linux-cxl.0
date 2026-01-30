Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12523D291
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769747003; cv=none; b=UrhT7CoIPlQP+JS9YbDXBZtzcPMcPm05MskYNS2fprw/eZ55wbU6t2SQzjf4QxYvXfbgUVEZY8OMgJ8XofuPj8IPZykLc8Q+F6QJuk3Wd8wBEEV+Rng2kGVg9gjyWyH0eU58yogXdnovpiNldtWOGXWUfElLJpAbWv14HUNkgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769747003; c=relaxed/simple;
	bh=keu4ZKP0EqKL8sYhXQo9Nm9d8DuaXZUvHjBEqk9HxHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCwDgHkySBbLA/YthNlapax9h6i+0qAHkvctshoSEM83CrjaS9+7tWo2COEcOSLHaOiopJwDlT00s/wN1EoGQfI02ZffgZLZky4u0WH/gYmeFbbsptPYEsgW93KGCy53rWRonZyfE3vBLU4jTPDa6TDVG97vgiBof27OBLeAbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuUxuX0u; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuUxuX0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769747001; x=1801283001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=keu4ZKP0EqKL8sYhXQo9Nm9d8DuaXZUvHjBEqk9HxHA=;
  b=BuUxuX0uDLOdxdFgfjq6DT7j1a/EK1aA4iqROVrxA0IFKmlQivDtR+Aa
   DWru8zOzN53ER9xO/ndeFb/ejtgvLgqhKB5lEYrQrXbJrkBeuLscQLiK7
   7FAziDJVkJlGESn/VM5MK5spFwFKbuhFYYo17q+zfE4MBQeIS5JSzukhp
   vrbpLjGPjFTZSh6vlJKPwzQolPcm0GMx354H9JHFDtc6CLW4MpOiif8Ht
   uqfRpMRQSDwdLzp6KDuIntXlB3Hy99cZoXGeHZUbDUTI9wj3107CGg4oH
   i7Eh8mYy5JdNfsaKqmeZQsPrnhbJ+38H74JuVJJygluxEBoflnc4LhHmi
   A==;
X-CSE-ConnectionGUID: k6hOALxuTdSbEWShHcr8uw==
X-CSE-MsgGUID: oDksuGxjSVW15UxAOPdTcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70713563"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70713563"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 20:23:20 -0800
X-CSE-ConnectionGUID: gQLTa3H8ToS5wHaGOBLxUw==
X-CSE-MsgGUID: 1eiYpQqeSRSdKuoHcXFbPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213251509"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.124])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 20:23:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl/region: Unregister auto-created region when assembly fails
Date: Thu, 29 Jan 2026 20:23:11 -0800
Message-ID: <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When auto-created region assembly fails the region remains registered
but disabled. The region continues to reserve its memory resource,
preventing DAX from registering the memory.

Unregister the region on assembly failure to release the resource.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 183cb0b49d8b..f222aa9cbda7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3714,6 +3714,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static void unregister_region(void *dev);
+
 static struct cxl_region *
 cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 {
@@ -3754,7 +3756,17 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	if (rc)
 		return rc;
 
-	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
+	rc = attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
+	if (rc) {
+		struct cxl_port *root_port = cxlrd_to_port(cxlrd);
+
+		/* Messages at the point of failure offer more detail */
+		dev_err(&cxlr->dev,
+			"assembly failed %d, unregistering region\n", rc);
+		devm_release_action(root_port->uport_dev, unregister_region,
+				    cxlr);
+		return rc;
+	}
 
 	scoped_guard(rwsem_read, &cxl_rwsem.region) {
 		p = &cxlr->params;
-- 
2.37.3

