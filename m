Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489C1B3F0E;
	Tue, 18 Jun 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700420; cv=none; b=uFVScr2V5NnZlbJ3IASGJZ2zbsARdsJQoSWXwAr0AzdXsN8YRiuE4rrRBudTain7ghOylrVrSRql14wF+miGfriRnOcjTPkzLzanTtF1I8M8lF+S5d593xv3c3DQniaYPVygY9TvGVV2Rjvm2tg3XB9pLcAkh6UP+rOIoRLPtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700420; c=relaxed/simple;
	bh=dqGZ+zgb+03wm391muYNQpvHA9L8X0zYB+1+wZSU0I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyNZBHiSMoVs7bsFNatbqt+Sl1kJyZs9qsWanPbD3BwaT7gqwJDTpSbZq/+ZRQwtoy3qhYKxqFg1ociKbh0fPgnu1lRIFdO+BjSUALErsVoi/Nzjerl2qaLdgzMb3+3W9qiNjHe2LRQiQI6GJ3rKBdsQN7Awzp6Vsz+yuz6bFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PR5HZoU9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PR5HZoU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718700418; x=1750236418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqGZ+zgb+03wm391muYNQpvHA9L8X0zYB+1+wZSU0I4=;
  b=PR5HZoU9rGmWUnf/1QcojLVVVS1PWc4dIAj8+AiYFS6D+q034Ec/43le
   eUiPLiInhhZMJJuwIudEG2LPn5jDKwbA/xMMtGv8H3BEIfycPWlKX48bm
   C3HoQkAwlRbOBPCO4jJBlilNo0Pr9enANjWMREfwi8xWF1vM/oVsEuwVA
   xKbzfqKUfkA58ljDVADYJ0n6XJAvEEIimWAmPwu7xemP0fPdgx7y9JY9M
   igOhrg7/U57Nrq0bHVqRhap6jcsmXwVGMrXtaPJxFuSint+m9M5J/pOfq
   5GdCIAwFUHFPbi8YgfP/ahun5n5SJYFPsl3X1GDbvU0eDVCiDlmT6uljH
   A==;
X-CSE-ConnectionGUID: 9Tn2R8eUR5mLcfg2wZAjZw==
X-CSE-MsgGUID: XLBMazcVSMGSdt7c5bMWdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15431596"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15431596"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:46:58 -0700
X-CSE-ConnectionGUID: rO6/Ob8RR/C9LFuqT5Y4Gg==
X-CSE-MsgGUID: 7TUZPmcASqaacqk1t+AVbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="78933633"
Received: from shilinmu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:46:55 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 1/3] cxl/region: Fix a race condition in memory hotplug notifier
Date: Tue, 18 Jun 2024 16:46:37 +0800
Message-Id: <20240618084639.1419629-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618084639.1419629-1-ying.huang@intel.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the memory hotplug notifier function of the CXL region,
cxl_region_perf_attrs_callback(), the node ID is obtained by checking
the host address range of the region. However, the address range
information is not available when the region is registered in
devm_cxl_add_region(). Additionally, this information may be removed
or added under the protection of cxl_region_rwsem during runtime. If
the memory notifier is called for nodes other than that backed by the
region, a race condition may occur, potentially leading to a NULL
dereference or an invalid address range.

The race condition is addressed by checking the availability of the
address range information under the protection of cxl_region_rwsem. To
enhance code readability and use guard(), the relevant code has been
moved into a newly added function: cxl_region_nid().

Fixes: 067353a46d8c ("cxl/region: Add memory hotplug notifier for cxl region")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/region.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c2b6144be23..51aeef2c012c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2304,14 +2304,25 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 	return true;
 }
 
+static int cxl_region_nid(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_decoder *cxld;
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	cxled = p->targets[0];
+	if (!cxled)
+		return NUMA_NO_NODE;
+	cxld = &cxled->cxld;
+	return phys_to_target_node(cxld->hpa_range.start);
+}
+
 static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 					  unsigned long action, void *arg)
 {
 	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
 					       memory_notifier);
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_endpoint_decoder *cxled = p->targets[0];
-	struct cxl_decoder *cxld = &cxled->cxld;
 	struct memory_notify *mnb = arg;
 	int nid = mnb->status_change_nid;
 	int region_nid;
@@ -2319,7 +2330,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
 		return NOTIFY_DONE;
 
-	region_nid = phys_to_target_node(cxld->hpa_range.start);
+	region_nid = cxl_region_nid(cxlr);
 	if (nid != region_nid)
 		return NOTIFY_DONE;
 
-- 
2.39.2

