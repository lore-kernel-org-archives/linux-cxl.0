Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FC3043AA
	for <linux-cxl@vger.kernel.org>; Mon, 25 Aug 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143329; cv=none; b=NXdic9IN6S06sBdtMFdnEolN/9gGd9Kc8vQy9gUyfGQRmxdRDgnVPNZhXUfq+BCQPrvg15RbEzzzi+Y4LkBndAA/ifzUo8PcAGFjctOXGVD/0w+365XK1Y7hrTxQTxPLBiGAL49QI1R+1yM4frquBh5ZORkRS5yYKUEsQ4pZYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143329; c=relaxed/simple;
	bh=gvLihAeW/OGdvjejNCB3K2tqbrlq3Qfu/GIWH/iBDq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVnOlGLv/noHJC1FkleT4ZbyHHE2ZfMuJ97Uxu39dx/yeRpcn6vtnX9N7CEGHbmDSNYDkKulyoDfYRyaSvDq9WbJ6bmBHJPHd6vxBIFX4l/U3mNkTP7mFrgYKU2IaEFR0RMS0AIewz0DfPF0rH8QGcp7UpoVb1Wrp6bgMK+QJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45940C4CEED;
	Mon, 25 Aug 2025 17:35:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl: Demote extended linear cache missing emissions
Date: Mon, 25 Aug 2025 10:35:21 -0700
Message-ID: <20250825173521.2788927-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Demote extended linear cache missing emissions to debug level as most
systems do not have this feature enabled and the complaint about missing
feature is spammy.

Suggeted-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c        | 6 +++---
 drivers/cxl/core/region.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 712624cba2b6..e56b3d96cdef 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -359,9 +359,9 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
 	 */
 	size = size >> 1;
 	if (cache_size && size != cache_size) {
-		dev_warn(&cxld->dev,
-			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
-			 &cache_size, &size);
+		dev_dbg(&cxld->dev,
+			"Extended Linear Cache size %pa != CXL size %pa. No Support!",
+			&cache_size, &size);
 		return -ENXIO;
 	}
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..6d28ba2c2f29 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3306,9 +3306,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 		return 0;
 
 	if (size != cache_size) {
-		dev_warn(&cxlr->dev,
-			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
-			 &cache_size, &size);
+		dev_dbg(&cxlr->dev,
+			"Extended Linear Cache size %pa != CXL size %pa. No Support!",
+			&cache_size, &size);
 		return -ENXIO;
 	}
 

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1

