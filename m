Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C32578
	for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iz0Q6npN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703292465; x=1734828465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ln+jxg79Kf2dLsTCFemtPkiS/JpRSnWodY5aHCKJL0w=;
  b=iz0Q6npNtl2G8BS9YxWKi1BuOUMxeGXcbm40BKzPUptoo8hfuLlCSDtU
   dZdxMPMdORvZh9qHH6FbmryUQkJaGS9fINSWbTBeXAR8ke1NJae22le9W
   /BDxITHT18zbfPEhPqIvn69lAWmkfF9jrB1wRyjpXXXcHl+N7sgW8k87l
   Zz116c6prBshbS7maA9fYiaWZVmm5J0TQSKMplnlepyZjz0j7ab9EjTe6
   XXdEn6L6V6yQSKFRqwaAjHrLSBnJzfXLJyiHr2OUWbqKDME14NPQfWfcy
   aCPY6cPyogsgIZwG7lJiBL+IFgWzxDgjLfwCcyadinxG1GPwGBN9ksGot
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="381152709"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="381152709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="920839374"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="920839374"
Received: from jbjohns2-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.160.53])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:47:43 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3] cxl/region: Add dev_dbg() detail on failure to allocate HPA space
Date: Fri, 22 Dec 2023 16:47:40 -0800
Message-Id: <20231223004740.1401858-1-alison.schofield@intel.com>
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
cxl_core:alloc_hpa:555: cxl region8: HPA allocation error (-34) for size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]

Now the debug user can examine /proc/iomem and consider actions
like removing other allocations in that space or reducing the
size of their region request.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
---

Changes in v3:
- Add parens around error number (Vishal, Dan)
- Link to v2: https://lore.kernel.org/linux-cxl/20231129003953.1252985-1-alison.schofield@intel.com/


 drivers/cxl/core/region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 56e575c79bb4..a7b695db5dfc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
 				    dev_name(&cxlr->dev));
 	if (IS_ERR(res)) {
-		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
-			PTR_ERR(res));
+		dev_dbg(&cxlr->dev,
+			"HPA allocation error (%ld) for size:%#llx in %s %pr\n",
+			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
 		return PTR_ERR(res);
 	}
 

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3

