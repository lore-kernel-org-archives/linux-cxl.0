Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D423B19B9
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527314; cv=none; b=ulAu3l628GoiDOwULIdNptghIJY6jLBUWDkJCSv99PPboDBYdzMiB0L8L8QchjKgc4ERo7x0Kzkghgm2dJpBg2yPy6T/vcv+yPch5GsUruIqMtfToEeC2jXZEL+w0hNFOjbbLspoMXHKnZqQ3dzJPjrVe7yfPlFBEfeCJbW5O+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527314; c=relaxed/simple;
	bh=rL1SlxlboT+xU3xDfLuqZVnsswgHWbnEJP9FpsUvB6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqMEf3eLWJw+QXhypCfwvOjkFm6mSnTjF7co8coaQza6V5bKq2Bg7g1bsAwLF/NLv0jGRhVin8x1ckfZHSF5o28vupip6HjcSNfTfhO1ELDk4OAImFyZ3URMreoskYPyHn9vjfNb+cdwTh3b7SPqmeOFJspZCe7ZH3jhrexMxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I1cqelpP; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I1cqelpP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789527304; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Si7iK59nmwwa75IabvkYisPeqH5JMlD9Vvc8Qm8oKGk=;
	b=I1cqelpPo4wVlDGWiTgCj0BS0YtOV2UVMzR5DDj8Rs79Mrsw1u00//KmwNe5aUJDBQMi2/ZPazJqJZOF5y+/uqdWIW4SxAmQCcepOZ51zVhL38kYhWzmkA/Ebq78TAKIxGE3enMqBDqQ1KiKQcpjIZEBAOFBJofckyxWNZetLQY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XB3dFVT_1789527303;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB3dFVT_1789527303 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 10:55:03 +0800
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
Subject: [PATCH v4 2/2] cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
Date: Wed, 16 Sep 2026 10:54:53 +0800
Message-ID: <20260916025453.3532614-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260916025453.3532614-1-kanie@linux.alibaba.com>
References: <20260916025453.3532614-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The poison debugfs handlers take the memdev device lock so that the
region lookup sees a stable cxlmd->dev.driver. debugfs holds a
reference on the file across the handler, and cxl_mem unbind removes
that file while holding the very same device lock, so a handler that
waits for the lock deadlocks against a concurrent unbind.

The trigger is any teardown that detaches cxl_mem from the memdev
while a poison write is in flight: unbinding or unloading cxl_mem or
cxl_pci, or removing the endpoint PCI device, including hot-remove.

Both tasks then hang. The unbind side is uninterruptible, and it also
blocks the memdev detach work, which runs on an ordered workqueue and so
stalls every other CXL bus work item.

Take the lock with the trylock guard and return -EBUSY instead of
waiting. An unbind that wins the race removes the file first and the
write fails with -ENOENT.

The poison inject and clear files are a debug ABI for expert users,
mostly device vendors, to test the poison capabilities of their
devices. Mixing a poison write with cxl_mem teardown is not a supported
use of the interface, but when it happens anyway the cost should be a
failed write, not a hung kernel.

Found by code inspection. Reproduced by writing inject_poison in a loop
while unbinding and rebinding cxl_mem, and confirmed fixed by the same
test. Also reproduced the same deadlock with those writes racing a
pciehp hot-remove of the memdev; with this patch the hot-remove flow
completes normally.

Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
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

