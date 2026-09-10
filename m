Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497E3B6370
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033232; cv=none; b=l8cj29h8s9YUK5vpfv5Tzwy7haa0ciMScBiP0cuFRINIzxxshUr0kXvu8XLyeDUQl+Dd6BuIHuUfdEKX4mtfg0txX2Wg19aaU08rRVENCNT4ccHZPrNMqY3fiItvOR2hNVgL1JKuf8hSVUdHEoNdYb90dUz9+BhN9dcwGyLrfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033232; c=relaxed/simple;
	bh=+wv9FwLJSwW0aRIaTyeF+5xTurzNtY0hQsp73fdm77U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9uP367M1l5yJY3MU9PIGijkPUNrAMvkOYenX0eoOsc6KqKnfl2/HhvbXik8V5gg0Ly6ZjHFmOHF8ugjIBtPhICAvoHzbm61rqYk5A6Yt76Kng5I3WmbKe3OBtjwJJ+4ihTOecy2RVWSO8kB7J4grrKCns4lqj+LNLTN8wFTGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yb0ouvEd; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yb0ouvEd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789033227; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+DkbEshdHVqXzHe/I2hLea6J74x57DH3RpJEJZW0La8=;
	b=Yb0ouvEdfiWhd6Es3T72hUu3Sfnl4CJG0CK/Nc6UPqU+GHbMoiOgmUkgHIG3UpahsbEuT5YtGmgsMkNDTvuRhFTDMTzsrrvOP2YZ+a27RpEpyeOtbuATnDbcNCfBAkfQ1dTPqSLBmIFglERXxHl9DJh6/HK3IUxDIMoiOSYaJeY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XAhDijo_1789033226;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAhDijo_1789033226 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 17:40:27 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
Date: Thu, 10 Sep 2026 17:40:17 +0800
Message-ID: <20260910094017.4032170-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260910094017.4032170-1-kanie@linux.alibaba.com>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The poison debugfs handlers take the memdev device lock so that the
region lookup sees a stable cxlmd->dev.driver. debugfs holds a reference
on the file across the handler, and cxl_mem unbind removes that file
while holding the very same device lock, so a handler that waits for the
lock deadlocks against a concurrent unbind.

Both tasks then hang. The unbind side is uninterruptible, and it also
blocks the memdev detach work, which runs on an ordered workqueue and so
stalls every other CXL bus work item.

Take the lock with the trylock guard and return -EBUSY instead of
waiting. An unbind that wins the race removes the file first and the
write fails with -ENOENT.

Found by code inspection. Reproduced by writing inject_poison in a loop
while unbinding and rebinding cxl_mem, and confirmed fixed by the same
test.

Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
checkpatch reports "do not use assignment in if condition" twice, on the
two ACQUIRE_ERR() lines. Those are pre-existing: the unpatched file and
the Fixes: commit report the same two, this patch only swaps the lock
class on them, and the combined form is what all 40 ACQUIRE_ERR() call
sites in drivers/cxl use.

 drivers/cxl/mem.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 798e5c369cfc..3959ec963026 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -50,8 +50,13 @@ static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 	struct cxl_memdev *cxlmd = data;
 	int rc;
 
-	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
-	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+	/*
+	 * Never wait for this lock: the debugfs proxy holds a file reference
+	 * across the callback and unbind removes the file under the same
+	 * device lock, so waiting here deadlocks against unbind.
+	 */
+	ACQUIRE(device_try, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
 		return rc;
 
 	return cxl_inject_poison(cxlmd, dpa);
@@ -65,8 +70,9 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 	struct cxl_memdev *cxlmd = data;
 	int rc;
 
-	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
-	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+	/* Never wait, per the inject path above. */
+	ACQUIRE(device_try, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
 		return rc;
 
 	return cxl_clear_poison(cxlmd, dpa);
-- 
2.43.7

