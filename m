Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD42D046
	for <linux-cxl@vger.kernel.org>; Tue, 19 Mar 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872110; cv=none; b=oM12ocFNLh+AtwUrJZpeWsiOiwbGedge5awODVPugIY7Ms00IYljtfXn0LP7huucy+Kpusln0zgBfmg+GQRAWYTfDYJl0U72jfmar931FAGblerqCaFdUjBYpWub2QRJqh3KYDeb/mcUUWDczQ7eAKBJQT1MAVVkhAIeYYK92pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872110; c=relaxed/simple;
	bh=/ACNik5rZNLC07RjhItowJReAKcAw8khPkP90t/tx4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6PRudtKD1I/739Ca+FpzvuKrI5oQXxBVKjrMH36H9Kdny9ZN95EFuSGseUX8C7TOqHQt27Z+bqyP1YuZmPu3R08XAi5Z7v+2xiYYn500XZiFLKFt4eTXKda3V673mETNx1rJd0OlZDjQ09m5IlbpjPw96K/UJTS1tkt10O1HwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2EBC433C7;
	Tue, 19 Mar 2024 18:15:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH] cxl/core/regs: Fix usage of map->reg_type in cxl_decode_regblock() before assigned
Date: Tue, 19 Mar 2024 11:15:08 -0700
Message-ID: <20240319181508.690837-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the error path, map->reg_type is being used for kernel warning
before its value is setup. Found by code inspection. Exposure to
user is wrong reg_type being emitted via kernel log. Use a local
var for reg_type and retrieve value for usage.

Fixes: 6c7f4f1e51c2 ("cxl/core/regs: Make cxl_map_{component, device}_regs() device generic")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..3c42f984eeaf 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -271,6 +271,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
 static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
+	u8 reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
 	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
 	u64 offset = ((u64)reg_hi << 32) |
 		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
@@ -278,11 +279,11 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 	if (offset > pci_resource_len(pdev, bar)) {
 		dev_warn(&pdev->dev,
 			 "BAR%d: %pr: too small (offset: %pa, type: %d)\n", bar,
-			 &pdev->resource[bar], &offset, map->reg_type);
+			 &pdev->resource[bar], &offset, reg_type);
 		return false;
 	}
 
-	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
+	map->reg_type = reg_type;
 	map->resource = pci_resource_start(pdev, bar) + offset;
 	map->max_size = pci_resource_len(pdev, bar) - offset;
 	return true;
-- 
2.44.0

