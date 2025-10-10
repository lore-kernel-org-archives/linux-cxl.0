Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457812594BE
	for <linux-cxl@vger.kernel.org>; Fri, 10 Oct 2025 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129884; cv=none; b=kUmM9siM8Dhju3brpcP353fSYAqJnPT7g5WDsGP1n38DAf4QV0TKAUjYS7tiMNih4bc50qaw6/C0ZLLqiCFiJB/bEvGFgbiUagyi8nGlVa8Cr6lPL6gfV2u2MAS1s75KclpPvSdKn2RV2J0vbFTjYrwr/NH0cbzgIYzpAKmTqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129884; c=relaxed/simple;
	bh=mdR03Y722Y5W85BkZXFvprLiFR56gAai50pt1gB/pC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzOEnsmYLAt5LLGrQvT2Zzi2Q5WZ3ekncRi/BqaizEbv8HSz7z+rlT2xX35yn0tWGzsYNK2GPbBylzDPfmbbLrU2nY0cCxk61BRhSCWfei6dKHxXnQpOjupNKl8yeEbe6PZoOjMLw9MFl04uWhhesjyh5QFfM9SWLQt5bEV2ytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CF7C4CEF1;
	Fri, 10 Oct 2025 20:58:03 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	stable@kernel.org
Subject: [PATCH 3/3] cxl: Fix match_region_by_range() to use region_res_match_cxl_range()
Date: Fri, 10 Oct 2025 13:57:55 -0700
Message-ID: <20251010205755.205280-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010205755.205280-1-dave.jiang@intel.com>
References: <20251010205755.205280-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

match_region_by_range() is not using the helper function that also takes
extended linear cache size into account when comparing regions. This
causes a x2 region to show up as 2 partial incomplete regions rather
than a single CXL region with extended linear cache support. Replace
the open coded compare logic with the proper helper function for
comparison. User visible impact is that when 'cxl list' is issued,
no activa CXL region(s) are shown. There may be multiple idle regions
present. No actual active CXL region is present in the kernel.

Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
Cc: stable@kernel.org
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0ce50998c49f..be4521184328 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3287,10 +3287,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
-
-	return 0;
+	return region_res_match_cxl_range(p, r);
 }
 
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
-- 
2.51.0

