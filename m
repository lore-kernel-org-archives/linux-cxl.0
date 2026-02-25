Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B073222590
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056993; cv=none; b=IlOTxYq1O73+7tvo6FMkPJEZyUSggKqgXupxz/3WrcWMABICZOE7s0q/oLCKptrHFBSNnz2qKd4OkRkKyrp4dBe8A9+ijKEOFusiQovzQIhgE3sPPJ0SqRbenM1/CBi+hyT3aivzHMK8w6Fu6U7OSjUa3an8OHn40QAlbUc+5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056993; c=relaxed/simple;
	bh=473h75ZdcO4+jrWBJCy9E6iRNylajXtbP98GDJfNT3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JhtU1hk7u9bF+gRpoqX4+D+S3AMtSrlkIa8wC2hW5JY+8dDxmh438kz9+V5eUUmjBICt0H7eoPZ5LTpkXu16WNHC28UQnuIuSVbfAUhDB/a63fTR/UWYPbDnsA3B1mQMjHdHwH/fI47Si+Cfsrf59Z69N0B3oRNT6dd2AhNcjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1LruVRQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1LruVRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772056991; x=1803592991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=473h75ZdcO4+jrWBJCy9E6iRNylajXtbP98GDJfNT3w=;
  b=J1LruVRQxFMGpOBuvHrtrsnW3mTU+tKnXLweWQRP+io6G+Nf0+Y4/EVW
   XFydw6kTM6ebzjhLt4Bbri+vvq3Ke0bLYZHfk7OYJsi+9eBjOuVFeD9Cm
   7wnNSm+/QqrQNICXadmQkGZGJMHmp+0SB83tuiXoBMd8IC+/OYHc3cFt6
   OyBx/2ndvG/sBMlVLkxu/ys8fLqdaHqNLc5X/o4bzIBDWVvQpmyFwW1qG
   ay3voPrh3uVk8y0W1Cc68KtGocmTu5iJ5u7w8CLyWf1Z0mOSBCdYaCsDo
   /reRGKfsrHSsN0JTp9djfM1LMetk/bOslF5uIlb/Qrhu12wND3wtjP4AG
   A==;
X-CSE-ConnectionGUID: w+jDFnAwThiUnLGZJAfD8Q==
X-CSE-MsgGUID: 1XX4Kmi3Qe+Iqh7q+zmYmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="98581535"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="98581535"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 14:03:10 -0800
X-CSE-ConnectionGUID: mt9Oh6fGS3+MkTOGKMX/OQ==
X-CSE-MsgGUID: SB9ttaBBSsOF1tcTskhNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="213993514"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 14:02:54 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3] cxl/port: Fix use after free of parent_port in cxl_detach_ep()
Date: Wed, 25 Feb 2026 14:02:49 -0800
Message-ID: <20260225220251.1708089-1-alison.schofield@intel.com>
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
is allocated and drop it when released. This ensures the parent is
valid for the full lifetime of the child and eliminates the use after
free window in cxl_detach_ep().

This is easily reproduced with a reload of cxl_acpi in QEMU with CXL
devices present.

Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v3:
Scope fix as a lifetime guarantee btw child port & parent (Dan)

Changes in v2:
Remove stray blank line (DaveJ)
Rebase on 7.0-rc1
Add Fixes Tag (DaveJ)


 drivers/cxl/core/port.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b69c2529744c..09fc08205ed5 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -552,6 +552,10 @@ static void cxl_port_release(struct device *dev)
 	xa_destroy(&port->dports);
 	xa_destroy(&port->regions);
 	ida_free(&cxl_port_ida, port->id);
+
+	if (!is_cxl_root(port))
+		put_device(dev->parent);
+
 	if (is_cxl_root(port))
 		kfree(to_cxl_root(port));
 	else
@@ -721,6 +725,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 		struct cxl_port *iter;
 
 		dev->parent = &parent_port->dev;
+		get_device(dev->parent);
 		port->depth = parent_port->depth + 1;
 		port->parent_dport = parent_dport;
 

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.37.3

