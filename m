Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkKCB5Xe"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602F710C1
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 16:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701218396; x=1732754396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CmOpbSHRin+tjKzQW/3rN7J3toqysKmbtZ4hniRbSk4=;
  b=GkKCB5XeUGwaY/jjetrvGoXQptrzed6l5dMibtIvN2O7Jidik2vNg8os
   MrzF/ohjQZKLdOuYl6hH03/D0gRtTE1DSyiB9+2kj8lGFq8Uu4X8pibyH
   nH+8G5zp2tXSdIvKBkcaqDOdfMihs4nOLwxD4ORgcU9AEzYwfLfJFmdHr
   sL0R9KUzygD5Ti2AAchmqJEU+psvnuuRkJr43nyRf2G6U23UwKstBuHj/
   EN8PID9Ic5oH72Ntu/xaMQm7G9PM5pmMBPzdVThn26xEXpLcvAwWM87nz
   UeJedgMLEqPNmv1X5Dh/kehEzqwLW9sgBL82hA2Ru195kPtGixgsUfFXd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372431929"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372431929"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 16:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="942128889"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="942128889"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.26.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 16:39:55 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/region: Add dev_dbg() detail on failure to allocate HPA space
Date: Tue, 28 Nov 2023 16:39:53 -0800
Message-Id: <20231129003953.1252985-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When the region driver fails while allocating HPA space for a
new region it can be because the parent resource, the CXL Window,
has no more available space.

In that case, the debug user sees this message:
cxl_core:alloc_hpa:555: cxl region2: failed to allocate HPA: -34

Expand the message like this:
cxl_core:alloc_hpa:555: cxl region8: HPA allocation error:-34 for size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]

Now the debug user can examine /proc/iomem and consider actions
like removing other allocations in that space or reducing the
size of their region request.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
---

Changes in v2:
- Improve the message text (Vishal)
- Add reviewed by tags (DaveJ, Vishal)
- Link to v1:
https://lore.kernel.org/linux-cxl/20231114040147.1124696-1-alison.schofield@intel.com/


 drivers/cxl/core/region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 56e575c79bb4..ec792af873c4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
 				    dev_name(&cxlr->dev));
 	if (IS_ERR(res)) {
-		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
-			PTR_ERR(res));
+		dev_dbg(&cxlr->dev,
+			"HPA allocation error:%ld for size:%#llx in %s %pr\n",
+			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
 		return PTR_ERR(res);
 	}
 

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3

