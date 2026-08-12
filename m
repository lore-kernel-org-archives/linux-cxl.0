Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD86336886
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515050; cv=none; b=Hy6Qtj/5s7bbC9+CTtf+zNUnWumxdFgVJQqKGEHRNM/BHTpO+7hUmiMoXARwxBHkYv+Whrm+eDK8qMOq3Ojpn/UtE4UTvl+a3FgvvRKXo/GZOHy7rz+TwcX2vBsPwR7ZCVbEHdZp/DcjEdDa9n3Mb69XLugVMrXQvIri+J5YMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515050; c=relaxed/simple;
	bh=lwj4WfNA+ojHPoAvIRq1d94UM2XhhH8RZbJmYOT5lBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsfnhkYFUFj3LJciT4IRWdcYuPsu6TF3aJP7PsBS3N93GSggw4cNrLb1XobfNgcMkarDlCIR+pE7SICIBvUUoE3Z64t+WIoREDc/YQvoJWFZw1FGyoHSF4NHRI4gBgj3jIHSBoIDFQGKBS+u+2cF20KK7ojV25edtKzzttGRye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r+hc/mjL; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r+hc/mjL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786515044; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lIwpPDwbwgdyDEIYii8UagSDcT72tfaasdqMxwZfCNU=;
	b=r+hc/mjL+2kUrvf4kfuT8D76vYiSyq1zZY8Ak2gt3wZ3YirEq+upy8gdpgJE2SIR5xMNMF4XwcMAx5LlP/fu+kBsWLkux+sMz0YA0jguFiOChiCWfpgVKijChRWxKx9bJW/ANsHmysETGUgF+FZuyIABCdPMuwoScXOLraSNtFo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8qgQqP_1786515043;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8qgQqP_1786515043 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 14:10:44 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/region: Unregister the pmem region bridge on setup failure
Date: Wed, 12 Aug 2026 14:10:43 +0800
Message-ID: <20260812061043.57319-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_cxl_add_pmem_region() publishes the cxl_pmem_region with device_add()
and only afterwards, under the nvdimm bridge's device lock, arranges for
its removal - and only if the bridge has a driver bound. If it does not,
the function sets -ENXIO and leaves through err_bridge, which drops the
reference this function took on the bridge and returns. The device that
was just added has no owner at that point: no device_del(), no
put_device(), and no devm action to do either later. The sibling failure,
a devm_add_action_or_reset() that cannot allocate, is already covered,
because devm_add_action_or_reset() runs cxlr_pmem_unregister() itself on
that path.

An unbound bridge is a normal state, not an error state. The bridge is
unbound whenever cxl_pmem is unloaded or its device is detached through
sysfs, and a region can be probed in that window.

The added device then stays in sysfs, along with the reference it holds on
the region, until the module is unloaded. cxlr->cxlr_pmem still points at
it, and worse, the name is still taken: a later probe of the same region
allocates a second cxl_pmem_region and fails in device_add() on the
duplicate "pmem_region%d", so once this has happened the region can no
longer be brought up at all.

Call cxlr_pmem_unregister() on that branch. It is invoked from inside the
scoped_guard() that holds the bridge's device lock, which is what its
device_lock_assert() requires, and it performs the same teardown the devm
action would have performed, including clearing cxlr->cxlr_pmem, so
err_bridge is left with only the bridge reference to drop.

Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
This was patch 8/8 of the "cxl: Assorted fixes" series [1]. Per review
feedback that series is not being reworked as a whole; the fixes are resent
individually instead. Patches 1, 2 and 7 of the series are dropped, as those
issues are already fixed in cxl/next.

v1->v2:
- rebase onto cxl/next
- rewrite the commit message to describe the behaviour rather than narrate
  the code change (Alison Schofield)

[1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/

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

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

