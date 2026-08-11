Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA543B3D9
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448189; cv=none; b=pI5ixqqFmEbzj9Am1F1lOzLPHGSnz3Q4afzD2F/M/qFUW7OImK2tpspJq6xXUNYW46wukuEXuqufhmp6Fuk5Q1ljMiko9LyOeqD2WOlZm3DeN0XgbLIiQFnWRF1C755trTqeWJ9uLrxIAo0PamZNydZWOPwdxJdRTgyA7CIG5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448189; c=relaxed/simple;
	bh=r8kDbhyTWBRnDGNUaCSeMm1gvYyBvBPRlUCWSpcIDhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvz/Um3aTOi2/YsxKbm/vb8HW1KT9VMHW2eLBwy+9649A941EilJmBSUTRAToca6RD6fv5LotWUKHBnVF1Zw9gJJRjZoimgAyOEDLv5K1Yt+Qa41fUGhXw6YqtGuKbzoHasYRMzH3+oqqkybqzESDSPFapl77qzTAbuP/bh/VjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sinirRia; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sinirRia"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448183; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4WP3suhv2DMIq1gWCVVpjKiFCFjo5Xp474EKOmG0m7M=;
	b=sinirRiahVdIWkzBmg6+gAfBzsf1zl5SUsuu0Wb0D2F6dK0b9UOEwdFAr0dlz1IfmNSZufYPtzG2a+z4Ar7CpHQ0itwdH9IXpLhNfiaXVi/KPXBSKiTlE2Gsc5BICM0mNQJJAHh1vLiqDfjXlkUBMJe7hjIZI27mfMJ1pfaz48U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oKJ.9_1786448182;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oKJ.9_1786448182 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:23 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 8/8] cxl/region: Unregister the pmem region bridge on setup failure
Date: Tue, 11 Aug 2026 19:36:08 +0800
Message-ID: <20260811113608.2815625-9-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811113608.2815625-1-kanie@linux.alibaba.com>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the nvdimm bridge has no driver bound, devm_cxl_add_pmem_region()
bails out with -ENXIO through the err_bridge label. That label only drops
the reference on @cxl_nvb, so the cxl_pmem_region device that device_add()
just published stays in sysfs forever: there is no device_del() and no
put_device(), and no devm action was registered to do either later.

Beyond the leak, cxlr->cxlr_pmem is left pointing at the stale device, so
a later probe of the same region allocates a second one and fails in
device_add() with -EEXIST on the duplicate "pmem_region%d" name.

Call cxlr_pmem_unregister() explicitly in that branch. It runs under the
bridge's device lock held by the scoped_guard(), which is what its
device_lock_assert() expects, and it performs the same teardown the devm
action would have done, including clearing cxlr->cxlr_pmem, so err_bridge
only has the @cxl_nvb reference left to drop.

Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/region_pmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pmem.c
index 23d97e3d78b6..7ab1373a95e0 100644
--- a/drivers/cxl/core/region_pmem.c
+++ b/drivers/cxl/core/region_pmem.c
@@ -168,12 +168,14 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 		dev_name(dev));
 
 	scoped_guard(device, &cxl_nvb->dev) {
-		if (cxl_nvb->dev.driver)
+		if (cxl_nvb->dev.driver) {
 			rc = devm_add_action_or_reset(&cxl_nvb->dev,
 						      cxlr_pmem_unregister,
 						      cxlr_pmem);
-		else
+		} else {
 			rc = -ENXIO;
+			cxlr_pmem_unregister(cxlr_pmem);
+		}
 	}
 
 	if (rc)
-- 
2.43.7

