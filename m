Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F53346FB3
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748789; cv=none; b=jJPTQxfSAANysOn87nn4WHEFWWPCbSZSYdhzIDjgSMDNwd6m6BawQebyUkTXjIGWKw4U9G1E5mPYPAItTnvbdw4g/xTRz+sZorXZZB5h55hiX3VNt/albbkqLpsjXLDRRXArJLmSqpvlpxZZBj05TX+t1UXVcljg12NYsiBQCZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748789; c=relaxed/simple;
	bh=ePrm4cFh+7qer2CmPbY0/48kYGJ7kRay5LUoqlIEFM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpcti6Sy2Q08edluJQlBGHPOIcG6EtxPkE9uT4yLqWvrGxEKX3fylCpiAFw3ForaOxHEqLewRuf5O86ZmIcbTvAfeqOVZPnG78EMsLipqVcamwo2Cbkr4Pz4w6Xilhu/+l7r8ARvPFTU7thFnaIN0zSHoZ1SFDfxujGQIqp93rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=So2QjkRH; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="So2QjkRH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787748773; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6B9z53UUaTpxV/Fq1gwcjEGhfN4dSJoMkoj4f2W/y+E=;
	b=So2QjkRH2fOTNqyZQTj0kCx8Yss4A5wll0PYJsAZvuXudxGceBVkTI0wCM+8ipQ09fFcH0wzI4Ppu1v2yY0dH5Z2y54Yt7DTu5yCbRvQ07kLZMT//GJZ3XOKSTc/NdlW2TPJN3Vh4t0WvR7sIYVGuvDBX6XPoDMImsqzehja8W8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X9gwmSJ_1787748772;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9gwmSJ_1787748772 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Aug 2026 20:52:53 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
Date: Wed, 26 Aug 2026 20:52:48 +0800
Message-ID: <20260826125248.4003792-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing to the memdev poison debugfs files while cxl_mem is being unbound
deadlocks. The unbind path takes the memdev device lock and then waits for
the debugfs file to drain, while the writer holds the debugfs reference and
waits for that same lock:

  unbind_store()                     echo 0 > .../mem0/inject_poison
    device_release_driver_internal()   full_proxy_write()
      <takes cxlmd->dev lock>            <takes debugfs_file_get() ref>
      device_unbind_cleanup()            debugfs_attr_write()
        devres_release_all()               cxl_debugfs_poison_inject()
          remove_debugfs()                   <waits for cxlmd->dev lock>
            debugfs_remove_recursive()
              __debugfs_file_removed()
                <waits for the ref to drain>

Neither side can make progress. A third task piles up behind the held
device lock: detach_memdev() runs on cxl_bus_wq, and since that is an
ordered workqueue the wedged work item stalls every other CXL bus work
item, so unrelated devices stop being rescanned or detached.

The write side only needs the device lock so that cxl_dpa_to_region() sees
a stable cxlmd->dev.driver. Nothing requires the caller to wait for the
lock, so use device_trylock() and report -EBUSY instead. That keeps the
debugfs reference from ever being held across a wait for the lock, which
breaks the cycle. A concurrent unbind now either completes before the write
starts, in which case the write fails with -ENOENT because the file is
gone, or loses the race and the write reports -EBUSY.

The unbind task sits in uninterruptible sleep and cannot be killed. The
writer can be signalled, which is the only reason the current code is
recoverable at all.

Reproducer, on a device that advertises poison inject support:

  while :; do echo 0 > /sys/kernel/debug/cxl/mem0/inject_poison; done &
  while :; do
      echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
      echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  done

This hits within milliseconds. Note that lockdep stays quiet: one end of
the cycle is the debugfs active_users completion rather than a lock it
tracks. The hung task detector does report both blocked tasks.

Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/mem.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 798e5c369cfc..01d2d5855694 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -50,11 +50,20 @@ static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 	struct cxl_memdev *cxlmd = data;
 	int rc;
 
-	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
-	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
-		return rc;
+	/*
+	 * The debugfs proxy holds a debugfs_file_get() reference across this
+	 * callback, and cxl_mem unbind removes this file from devres while
+	 * holding the same device lock. Blocking here would let unbind wait
+	 * in debugfs_remove() for a reference that cannot be dropped until
+	 * unbind releases the lock, so never wait for the lock.
+	 */
+	if (!device_trylock(&cxlmd->dev))
+		return -EBUSY;
 
-	return cxl_inject_poison(cxlmd, dpa);
+	rc = cxl_inject_poison(cxlmd, dpa);
+	device_unlock(&cxlmd->dev);
+
+	return rc;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
@@ -65,11 +74,14 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 	struct cxl_memdev *cxlmd = data;
 	int rc;
 
-	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
-	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
-		return rc;
+	/* Avoid the unbind deadlock described in the inject path above. */
+	if (!device_trylock(&cxlmd->dev))
+		return -EBUSY;
+
+	rc = cxl_clear_poison(cxlmd, dpa);
+	device_unlock(&cxlmd->dev);
 
-	return cxl_clear_poison(cxlmd, dpa);
+	return rc;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
-- 
2.43.7

