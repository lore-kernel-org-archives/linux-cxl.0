Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C1253F3A
	for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531601; cv=none; b=iTRNwIKvfLJ58GmjQ8TfjGB14wQ0GtKTBuPBPCFETS4RK4QQ4v7IC88w2/hbnJ5YkIOPailmVtEBziKy/L4fz2AUcdjzz5MTE8FaiOYnAjZU9N1fLLpNHnYpFFsxJlqMTSi7vQDgG/mvhxr33V+OiV/s14b9XrZ8I9vbbTKD0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531601; c=relaxed/simple;
	bh=rDP5dUi3ErdYHYMaD665CenFjvu3q7r45ydGfJeTN7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pt12FZAeS3X8pv766Cy/t0A9TGWrUWN5P1Hb/Hag84cc1G0ShU/lZTBepFuwhfxzUAMwCXyuOeOezCjg+csSRn6nxtc993ClI/i2QpOOuGj7hzifSoSxp0LAQbUmQOOogK83o2L1kUevjhYakxZ65Wa1GKGQLloisKFoIInPiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BDEC4CEEB;
	Mon, 18 Aug 2025 15:39:59 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] cxl: Fix emit of type resource_size_t argument for validate_region_offset()
Date: Mon, 18 Aug 2025 08:39:53 -0700
Message-ID: <20250818153953.3658952-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0day reported warnings of:
drivers/cxl/core/region.c:3664:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]

drivers/cxl/core/region.c:3671:37: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]

Replace %#llx with %pr to emit resource_size_t arguments.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508160513.NAZ9i9rQ-lkp@intel.com/
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c39e2c9942b..29d3809ab2bb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3660,15 +3660,15 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
 
 	if (offset < p->cache_size) {
 		dev_err(&cxlr->dev,
-			"Offset %#llx is within extended linear cache %#llx\n",
-			offset, p->cache_size);
+			"Offset %#llx is within extended linear cache %pr\n",
+			offset, &p->cache_size);
 		return -EINVAL;
 	}
 
 	region_size = resource_size(p->res);
 	if (offset >= region_size) {
-		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %#llx\n",
-			offset, region_size);
+		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %pr\n",
+			offset, &region_size);
 		return -EINVAL;
 	}
 

base-commit: d9412f08e25a5b66f9021739c090cc9b8f1089b1
-- 
2.50.1

