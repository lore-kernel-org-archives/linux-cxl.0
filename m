Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEE19C540
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496994; cv=none; b=bxgTd0BRYxR8R7PQ69j8Avvwvd4l18EVrHQzUcIsR+1tyBmRzmgLc3IgwgeC82qZrZLlvvplfNiwlddmcAJrfKQ5zCadg8y3Bw24oo7avrTl4/XK0DCtZ3aUBM8gLfDNvWunGYTejeZAsFzle+qn3bC3PNLVdVHNHt8m/wySePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496994; c=relaxed/simple;
	bh=QyadZfLTvlp5agXGxBIAQOu7lnEpIxFHSPKKjdXS3uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8JHmyrZGckaNDWbPOwMA8A/hopJo2+8SOrDzw3jzYBXWJ00B1pRDVCC9X5s5IDHlMgXKTsx1PPgIdbqGutPRaJMytTuYkS13RBQaRigd5CVMlR+DiQJSv/k8YwAcf3AeUtoEfE4zP6VlYRJ9laXjlegiGfMLbO3u70NJdm8hAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyMSzSW9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyMSzSW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496983; x=1804032983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QyadZfLTvlp5agXGxBIAQOu7lnEpIxFHSPKKjdXS3uI=;
  b=ZyMSzSW9VUGxqA4HrlaotbooCj7tDWnSLtsvscTQtDtGspA6GbC4iIjw
   89TRAczRIB3jayk9tJC9hRI6p5TsFWLbkIN2seFtMi+DthK5Xz0/ZBFOx
   daVWNDiNwB2Jml7qZVpMfnNG/SycDicUFQTj2PZTUJZ5uT7QdtpiyHkUN
   iOv5/+KyeZBgVRZ6BdRNii8rJalxplK68slebgCSlzbMUCSiN0ybuBTH9
   xOLBL9WDatlCGYbMmSe774ik+ddJkdoJCO2PjH6PQCSXjQIk4CV1lF7jg
   P/e6ekNhsNCa6AUB/jlT8AFAb4RgH06U4z8aBGHRYSnfUlhDY0qGGgA1p
   g==;
X-CSE-ConnectionGUID: tnThYVWFQ5i1NNgACe7fnA==
X-CSE-MsgGUID: UKOc15hAQeaNxp7r1p0GrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="91092921"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="91092921"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:16:20 -0800
X-CSE-ConnectionGUID: 7gi673ntSWmkbht33Rzz+A==
X-CSE-MsgGUID: IGzUdGsbTHCtabLqx4KgPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="240834019"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.32])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:16:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v5] cxl/port: Fix use after free of parent_port in cxl_detach_ep()
Date: Mon,  2 Mar 2026 16:16:15 -0800
Message-ID: <20260303001616.1821728-1-alison.schofield@intel.com>
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

Second, delete_switch_port() releases three devm actions registered
against parent_port. The last of those is unregister_port() and it
calls device_unregister() on the child port, which can cascade. If
parent_port is now also empty the device core may unregister and free
it too. So by the time delete_switch_port() returns, parent_port may
be free, and the subsequent device_unlock(&parent_port->dev) operates
on freed memory. The kernel log looks same as above, with a different
offset in cxl_detach_ep().

Both of these issues stem from the absence of a lifetime guarantee
between a child port and its parent port.

Establish a lifetime rule for ports: child ports hold a reference to
their parent device until release. Take the reference when the port
is allocated and drop it when released. In addition, pin parent_port
across the parent device_lock/unlock in cxl_detach_ep(). Together,
these ensure parent_port remains valid across unregister cascades and
eliminates the use-after-free window in cxl_detach_ep().

This is easily reproduced with a reload of cxl_acpi in QEMU with CXL
devices present and visible with CONFIG_KASAN enabled.

Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v5:
Pin parent_port across device_lock/unlock() in cxl_detach_ep() (Ming)
Note that issue is visible with CONFIG_KASAN in commit log
Update commit log

Changes in v4:
Move the put_device() into existing if-else logic (Ming)

Changes in v3:
Scope fix as a lifetime guarantee btw child port & parent (Dan)

Changes in v2:
Remove stray blank line (DaveJ)
Rebase on 7.0-rc1
Add Fixes Tag (DaveJ)


 drivers/cxl/core/port.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b69c2529744c..b93d327e1195 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -552,10 +552,13 @@ static void cxl_port_release(struct device *dev)
 	xa_destroy(&port->dports);
 	xa_destroy(&port->regions);
 	ida_free(&cxl_port_ida, port->id);
-	if (is_cxl_root(port))
+
+	if (is_cxl_root(port)) {
 		kfree(to_cxl_root(port));
-	else
+	} else {
+		put_device(dev->parent);
 		kfree(port);
+	}
 }
 
 static ssize_t decoders_committed_show(struct device *dev,
@@ -721,6 +724,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 		struct cxl_port *iter;
 
 		dev->parent = &parent_port->dev;
+		get_device(dev->parent);
 		port->depth = parent_port->depth + 1;
 		port->parent_dport = parent_dport;
 
@@ -1533,6 +1537,7 @@ static void cxl_detach_ep(void *data)
 		port = to_cxl_port(dev);
 
 		parent_port = to_cxl_port(port->dev.parent);
+		get_device(&parent_port->dev);
 		device_lock(&parent_port->dev);
 		device_lock(&port->dev);
 		ep = cxl_ep_load(port, cxlmd);
@@ -1558,6 +1563,7 @@ static void cxl_detach_ep(void *data)
 			delete_switch_port(port);
 		}
 		device_unlock(&parent_port->dev);
+		put_device(&parent_port->dev);
 	}
 }
 

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.37.3

