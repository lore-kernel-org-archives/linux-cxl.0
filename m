Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEE224FA
	for <linux-cxl@vger.kernel.org>; Wed, 18 Feb 2026 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395338; cv=none; b=UQo7tKGOeR9v8lX5OEeEdfo5ftuTKBxEg5HFqUrgUMgr/vWug0pn74by/hzrn4CIEuKMcFCzHMh3OOx/uyRLmRJakvGk5scGqV6DyoQjaxet6vyU8g1o32M1gA54/VpR3FD1Ar3P9+P9rs/FfMMhPygUFq11nCLjP7ghfN2YTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395338; c=relaxed/simple;
	bh=3Ijgr3qcBpLVz5vSWoCWruNhIkVcDgJV5WLh0ZdYkLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HqfJuQOOfv/ML+WGlqnszR++UO+q737fTz/+5FuFb3ChQiv8rQqDgFXIThqCtoYSLFOGJTx+U0swMqQGfHaTJOp7dnKkA7F03GHxBXsERW1iXK/qyh+gUIqya5w/ZwdPxMzuQ1mGbWD73pKkQBjOkiCnGmjZhOMSY3iyP1iTr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVclQb8C; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVclQb8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771395336; x=1802931336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Ijgr3qcBpLVz5vSWoCWruNhIkVcDgJV5WLh0ZdYkLk=;
  b=dVclQb8C2M2WAty2DU/nPYEDXGgMyjtsXlbqaXb7lkD+kqan4i21rvKC
   POWg/GRTNR44Mw8wqap3Dzr5x4kRNhpcHvJNzFSC9qxeNw6X77ETR4dR0
   ESAWMVhFyEpxZiQEjGuAdZvMM2GEUb9vnOj0qyGhNArxgTwXgehpwXIEl
   U73vyJ3oyg5q7aZH/lmdhieUKW5RdLjxnnYE6DHdcQGMgiajtfUWS0I/9
   0qyH7qjw5C7LSdeat/UkcH730OWLR0iZ7RWjdh0M/Nd38mWYG6TmMyHaq
   09NSdBd16f+qWHDyNAcJNzzrWlxlCQUpJ8nR4H29+rhWNFwtz19/1GYH2
   Q==;
X-CSE-ConnectionGUID: dzBwzLePS5OA7VoU7R58sg==
X-CSE-MsgGUID: seTZOqT2QPSc85UYjf6GkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72359274"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72359274"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 22:15:35 -0800
X-CSE-ConnectionGUID: sCDfG6yZTiaiVRRikknOcw==
X-CSE-MsgGUID: P+42h+VISLqvPs0EbiRLGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="212495007"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.24])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 22:15:35 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/port: Fix use after free of parent_port in cxl_detach_ep()
Date: Tue, 17 Feb 2026 22:15:30 -0800
Message-ID: <20260218061532.1461436-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_detach_ep() is called during bottom-up removal when all CXL memory
devices beneath a switch port have been removed. For each port in the
hierarchy it locks both the port and its parent, removes the endpoint,
and if the port is now empty, marks it dead and unregisters the port
by calling delete_switch_port(). There are two places during this work
where the parent_port may be used after freeing:

First, a concurrent detach may have already processed a port by the
time a second worker finds it via bus_find_device(). Without pinning
parent_port, it may already be freed when we discover port->dead and
attempt to unlock the parent_port. In a production kernel that's a
silent memory corruption, with lock debug, it looks like this:

[]DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
[]WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
[]Call Trace:
[]mutex_unlock+0xd/0x20
[]cxl_detach_ep+0x180/0x400 [cxl_core]
[]devm_action_release+0x10/0x20
[]devres_release_all+0xa8/0xe0
[]device_unbind_cleanup+0xd/0xa0
[]really_probe+0x1a6/0x3e0

Fix this first case by adding a check for port->dead after acquiring
both locks. Unlock and release the parent reference before continuing.

Second, delete_switch_port() releases three devm actions registered
against parent_port. The last of those is unregister_port() and it
calls device_unregister() on the child port, which can cascade. If
parent_port is now also empty the device core may unregister and free
it too. So by the time delete_switch_port() returns, parent_port may
be free, and the subsequent device_unlock(&parent_port->dev) operates
on freed memory. The kernel log looks same as above, with a different
offset in cxl_detach_ep().

Fix this second issue by taking an extra reference on parent_port
before locking it, preventing the memory from being freed across
delete_switch_port(). Release it after device_unlock().

These easily reproduce with a reload of cxl_acpi in QEMU environment
with CXL devices present.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---


This was found while trying out unit test cases to backstop DaveJ's
latest finding where QEMU devices with CXL unit tests exposed an
nvdimm bus race. I post this with a bit of skepticism of the
likelihood it appears in the wild. Maybe it would but just not in the
way my test invokes it. A Fixes tag was not obvious, but I can find
the best tag, if any, in a v2.


 drivers/cxl/core/port.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fea8d5f5f331..94cf6b248e0d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1533,8 +1533,18 @@ static void cxl_detach_ep(void *data)
 		port = to_cxl_port(dev);
 
 		parent_port = to_cxl_port(port->dev.parent);
+		get_device(&parent_port->dev);
 		device_lock(&parent_port->dev);
 		device_lock(&port->dev);
+
+		/* A concurrent detach may have already removed this port */
+		if (port->dead) {
+			device_unlock(&port->dev);
+			device_unlock(&parent_port->dev);
+			put_device(&parent_port->dev);
+			continue;
+		}
+
 		ep = cxl_ep_load(port, cxlmd);
 		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
 			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
@@ -1553,11 +1563,19 @@ static void cxl_detach_ep(void *data)
 		device_unlock(&port->dev);
 
 		if (died) {
+			/*
+			 * Hold an extra reference to parent_port across
+			 * delete_switch_port() since unregister_port(port)
+			 * may cascade and unregister parent_port, freeing
+			 * it before the call to device_unlock().
+			 */
 			dev_dbg(&cxlmd->dev, "delete %s\n",
 				dev_name(&port->dev));
 			delete_switch_port(port);
 		}
+
 		device_unlock(&parent_port->dev);
+		put_device(&parent_port->dev);
 	}
 }
 

base-commit: 49d273f81f3dad288b7748c6cfb973705ae026d2
-- 
2.37.3

