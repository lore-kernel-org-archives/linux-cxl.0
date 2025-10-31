Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40492652A4
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931954; cv=none; b=je/DtSbZi9khy2QT3GIVMLjvZ++3+ldkHwNf8nQn1MAtU1sckimmIjQM8ab6poreKz6wFr2f4BXPPUR4mADqDFU4o80NirEG3qNtt5vG6do5eRxckS3r237R/4/MGt6XeDqMWI1UEoprB1dADTzwFfYRpR3JlorByvQYGAhBLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931954; c=relaxed/simple;
	bh=9Tjg5fadWpO5QImyzmw57+bQ9LxGskGx0qtXRJC7rR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKhQzp5f/BhARTh/AuCi5SKUOumhIcbWPSKXkZu6XtchAy60UcsTNHQEIWN1wGC6Rjxdwm4/VqWszhEvNm1uJM7fDjAdFL2JO+PfZTtxnrL2rNWNw4vF+2Xna36gMmwr4OZg0EYwjOWBW3fWlMcDY190KzAawdiE59/9Po0GccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D0FC4CEE7;
	Fri, 31 Oct 2025 17:32:33 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 4/4] cxl: Adjust offset calculation for poison injection
Date: Fri, 31 Oct 2025 10:32:24 -0700
Message-ID: <20251031173224.3537030-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031173224.3537030-1-dave.jiang@intel.com>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HPA to DPA translation for poison injection assumes that the
base address starts from where the CXL region begins. When the
extended linear cache is active, the offset can be within the DRAM
region. Adjust the offset so that it correctly reflects the offset
within the CXL region.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 095f5dcd17a1..eaf085aa44c4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3731,6 +3731,7 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 	if (validate_region_offset(cxlr, offset))
 		return -EINVAL;
 
+	offset -= cxlr->params.cache_size;
 	rc = region_offset_to_dpa_result(cxlr, offset, &result);
 	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
 		dev_dbg(&cxlr->dev,
@@ -3763,6 +3764,7 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 	if (validate_region_offset(cxlr, offset))
 		return -EINVAL;
 
+	offset -= cxlr->params.cache_size;
 	rc = region_offset_to_dpa_result(cxlr, offset, &result);
 	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
 		dev_dbg(&cxlr->dev,
-- 
2.51.0

