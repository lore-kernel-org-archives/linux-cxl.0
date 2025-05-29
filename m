Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFAF4C92
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551886; cv=none; b=ZCJe1h5T0PZmtvHQOknM9Ild13Q2ZOhbTvAwUr4l7cYvsKnGR0pNiGOmnOAqCuMRMzt45uSEXBmZeJdRZg1dX0b/l79Ai1gotTFiOTr4UHddrI5DA0+TgBlDzK94xPQ2M9RBz5V+SODxGDpgbYo19RlhU9nMVAJIbmrIINsz7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551886; c=relaxed/simple;
	bh=qp80IR+3oc97p5gF7Fz7nLQYTH19H6+1TSP4CEWWG1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQkR59hAoJWMcpt4WgSKCjo/lJf8C1CRvalGQIh2P6prutXPXGVkZlSV0RFqxAVhm0I78H6a7w5W6q1MnPpGifcrvb2KtM2/U31ugp0QYkEVN7oQppisojTYgNqC+9TdBQzvRGNfntyJbzeTgvQD+cfW2uVOpQyy8k+xMRga2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EB6IjMoe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EB6IjMoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748551885; x=1780087885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qp80IR+3oc97p5gF7Fz7nLQYTH19H6+1TSP4CEWWG1s=;
  b=EB6IjMoekxx1jEuGK4xwkUr92PicoS/rCxI+Jl+bqziMoYTnwZYvL4bB
   ioidH3fOHu6QVuKq9crtFcOSVscYTS1SNHBEXPcLq8jZE+DUEQE21f5DU
   /ojsrgZ7CVgLsmkp498ablvYx/i1cHShvJoqaPziLjf6ovD+d4i0zArHC
   57YqYyzvXwSUjMqcjgvbSrBJVeHxDqdjIqHJeIM1Yhbl9YrJhVEMZyQK8
   NFrgDRZaB+SFt9KL2AyybBdoBxHa2G3Bl/mWoyfVylmCHu4LttIEXnH35
   l2a4TqDoTk/YDtqIZW17fVBn0OoOYyG9GhgyXXVd8dBh5JnxQoKd6QEbD
   A==;
X-CSE-ConnectionGUID: qHTsmG5tQ7+n7jqoB8NucQ==
X-CSE-MsgGUID: Y0tZrQnKTZOQr6vV9Oua5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="53259607"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="53259607"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 13:51:24 -0700
X-CSE-ConnectionGUID: xff9bBTdQOGkx5x8V7ZPCw==
X-CSE-MsgGUID: uJIDlf6BRJqzhU68dolaAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="143502837"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.189])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 13:51:23 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: [PATCH] cxl/pci: Replace mutex_lock_io() w mutex_lock() for mailbox access
Date: Thu, 29 May 2025 13:51:13 -0700
Message-ID: <20250529205117.1990465-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

mutex_lock_io() differs from mutex_lock() in that it may call
io_schedule() when a task must sleep waiting for the lock. This
distinction only makes sense in block I/O or memory reclaim paths,
where giving I/O a chance to make progress is useful.

At this call site, cxl_pci_mbox_send(), the mutex protects an MMIO
mailbox. The task holding the lock is not blocking I/O progress, so
calling io_schedule(), as mutex_lock_io() may do, has no practical
effect.

Although there is no functional change, using the correct locking
primitive, that more accurately reflects the semantics and intended
use of the lock, improves code clarity and avoids misleading readers
and tools.

Reported-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Closes: https://lore.kernel.org/linux-cxl/0d2af1e8-7f1b-438c-a090-fd366c8c63e0@oracle.com/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 785aa2af5eaa..bd100ac31672 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -379,7 +379,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 {
 	int rc;
 
-	mutex_lock_io(&cxl_mbox->mbox_mutex);
+	mutex_lock(&cxl_mbox->mbox_mutex);
 	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
 	mutex_unlock(&cxl_mbox->mbox_mutex);
 

base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.37.3

