Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2E283FC3;
	Fri,  9 Jan 2026 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973293; cv=pass; b=HiFGPQGSu9/qCaijlPWqZaLUMm4I09J1yrnD/bfQgF+q7tmdpC7mdnZqtGCKOc5XX3cFSN+o2RABTlc+cQast1gRL1Su5xN7RjPkoWapZqDae+q2Ep+Xo6oztTPV+939zZ2bsGoT35CEymbNItLXCdKvVXsslUacrAFe/DFUq5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973293; c=relaxed/simple;
	bh=/T1bvl4florXPDEx3ri8oMWq1fNrRZrSNR8tvuXAvgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8Gt0Msd4sZhTiy/NW+n+H8T+xyjl2HfOR47EFRQmUgZntxKYqfihERbbnLf5g1WCGgp2Dv7/MEkQEX49rIkyIxvpR8DsEvgIIk0mdZDiTKASPJlMxjneqM6jtIxKFj39nr00T5J22VN558c2D04BEV8u5deoB8zINXxU6x/X74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Pt4K4yFW; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Pt4K4yFW"
ARC-Seal: i=1; a=rsa-sha256; t=1767973276; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X4tZz5l2BDj3WXbGIZxNPSn1khhIjsRLjBZdurT0hMPc+M81FybvKjRC5VHjVzgeo9bjZmjXuu4sxtBa1rRqmf3u9G7cDBBkXpycwQghPlJpc/Lr2nmG/00AjO729RbwdI/pOUF4bln6/IEOPStVItI0PJVOhFVMANHwMM6nWA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767973276; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FzvzFp0PqquyJxNLgxalsJCSih3CJKOyC7RufwWtxMw=; 
	b=RGhw1Qw1vsRvpmkWfnJblFVWTAooJcx7VU3GDRNyKDhIiMAqCLJB+450Nq2k2ao58rWKjUf6G/wAXv06XhRxfs2w4wZ8kCkNvMo9JFuKGTCjJRcNKtGQzl9vc3D2Dt2HzCvSnkYwx/WIslLaahK+p4aOEpKVuIBt0p6ZICP6FM0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767973276;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=FzvzFp0PqquyJxNLgxalsJCSih3CJKOyC7RufwWtxMw=;
	b=Pt4K4yFWOx+1UYjlZ35q/N2h7sD2rlLTQF2Qwxq5GVKmynA9KXRDOYMkt/SmDk8d
	rK933jHFRAOnEGrCZ3/sDwshplwQVw78vaGffak9GmwAD2Y23nKDM2XknEx3bz2mt5t
	FetCirq86IunpWFX3jgIqHv8RZ1G6gpjQ6QsQyrA=
Received: by mx.zohomail.com with SMTPS id 1767973274224125.1330695981311;
	Fri, 9 Jan 2026 07:41:14 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/1] cxl/acpi: Remove cxl_acpi_set_cache_size()
Date: Fri,  9 Jan 2026 23:40:42 +0800
Message-Id: <20260109154042.331296-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227bbb89f9435c71f79b02cb9a10000d6c68f190e458572bd853f2f219b392d818fbafe139c1397ec:zu08011227910b6a1bdf55c770a6e3dd5f00002f63ff6c4046446619df1f654dc85ae7b9decb3955d6a5ebdb:rf0801122d8bf4a031a4ac9c94daac374c00007a7261f2bb187e3648d7e5da956a84d9198533057ad82295c3fb0f60d037cd:ZohoMail
X-ZohoMailClient: External

cxl_acpi_set_cache_size() returns an error only when the size of the
cache range is not matched with the CXL address range. Almost all
implementation of setting cache size is in cxl_acpi_set_cache_size(),
cxl_setup_extended_linear_size() does nothing except printing a warning
in above error case, but cxl_acpi_set_cache_size() also prints a warning
at the same time. So can consolidates these two functions into one, keep
the function name as cxl_setup_extended_linear_size().

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/acpi.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 77ac940e3013..e65dfae42bde 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -357,7 +357,7 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
 	return rc;
 }
 
-static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
+static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
 {
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct range *hpa = &cxld->hpa_range;
@@ -367,12 +367,14 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
 	struct resource res;
 	int nid, rc;
 
+	/* Explicitly initialize cache size to 0 at the beginning */
+	cxlrd->cache_size = 0;
 	res = DEFINE_RES_MEM(start, size);
 	nid = phys_to_target_node(start);
 
 	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
 	if (rc)
-		return 0;
+		return;
 
 	/*
 	 * The cache range is expected to be within the CFMWS.
@@ -384,31 +386,10 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
 		dev_warn(&cxld->dev,
 			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
 			 &cache_size, &size);
-		return -ENXIO;
+		return;
 	}
 
 	cxlrd->cache_size = cache_size;
-
-	return 0;
-}
-
-static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
-{
-	int rc;
-
-	rc = cxl_acpi_set_cache_size(cxlrd);
-	if (rc) {
-		/*
-		 * Failing to retrieve extended linear cache region resize does not
-		 * prevent the region from functioning. Only causes cxl list showing
-		 * incorrect region size.
-		 */
-		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
-			 "Extended linear cache retrieval failed rc:%d\n", rc);
-
-		/* Ignoring return code */
-		cxlrd->cache_size = 0;
-	}
 }
 
 DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
-- 
2.34.1

