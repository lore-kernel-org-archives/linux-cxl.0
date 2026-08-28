Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782D397323
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954249; cv=none; b=Z23qLXP/aIOzppgn+iGYWc2NFd05sWhhX4+8jWDt12d7vpH3pgrw+7f867fNBztHt8PDKiG3ZaMsXzQKOq8679mo2FK8etzXYCloyLRxjVV7C9PiCwXKSfgg326+b6u3ZsuFVn62qUYYKq9RnRNYnEVtFLWzsswQThRR3ep1tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954249; c=relaxed/simple;
	bh=spSryp+YsIuyZVHK3o2+N8FQqEqIJH55W7fNvMejNz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9l3WgjbGGOfcZdF+KaPwxgR8/70qq7pRHgnGdGXGQXGkv+dgE31ohwTgZN36zreM2buVKWI0n/Po/INCl5e06WMAXRLXni1puGfGq8P/Kedl+mUO3u27mkAxXFpmKHpUfASKVH6NmR9v+viD4N7ugOzHtIZAAKvTBvfWDf/Ulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071121F000E9;
	Fri, 28 Aug 2026 21:57:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	terry.bowman@amd.com
Subject: [PATCH] cxl/ras: Pass the PCI device's struct device to match_memdev_by_parent()
Date: Fri, 28 Aug 2026 14:57:26 -0700
Message-ID: <20260828215726.1077498-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_cper_handle_prot_err() hands bus_find_device() the 'struct pci_dev'
where match_memdev_by_parent() expects the embedded 'struct device'. The
comparison never matches. The lookup always fails and CXL endpoint
protocol errors reported via CPER are dropped without a trace event,
leaving only the root port, downstream and upstream cases reporting.

Pass &pdev->dev, and rename the callback parameter to match what it is.

Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/ras.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index c91db125a971..a2c7c9479f2b 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -70,9 +70,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
 }
 
-static int match_memdev_by_parent(struct device *dev, const void *uport)
+static int match_memdev_by_parent(struct device *dev, const void *parent)
 {
-	if (is_cxl_memdev(dev) && dev->parent == uport)
+	if (is_cxl_memdev(dev) && dev->parent == parent)
 		return 1;
 	return 0;
 }
@@ -108,7 +108,7 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		return;
 
 	struct device *mem_dev __free(put_device) = bus_find_device(
-		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
+		&cxl_bus_type, NULL, &pdev->dev, match_memdev_by_parent);
 	if (!mem_dev)
 		return;
 

base-commit: 751627a8c5cde68e0b396126449749e8bfbe592d
-- 
2.54.0

