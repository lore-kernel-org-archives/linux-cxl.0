Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C113D6661
	for <linux-cxl@vger.kernel.org>; Thu, 26 Feb 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131484; cv=none; b=dz7TE6A3/cXjq7qubRSR3k8fHONxsrBlOliKPnn07/cMiZYmqviWHtoUecc53jtnC22NCiM1Nywjdg1nxNyCuAQvlktJmSVHuo8jLQlAk+yw0AgfOgzg/N8F76/MxCmAdDxesdpeMXkCCcI6n8yaFN6Il4c0t73b896jK6bvsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131484; c=relaxed/simple;
	bh=ZZvULI05unYa96Ad6JbiPw5Ot2z/RaUtFzo2ODnZprM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IA4Phh67TEeauYbeS4tcLGJDvVBl6VJqzdD8aF1NStyCr55vfiZnLdIsCcMk6PnM5+SJMb5ntLASZe8jF86j/QiVZyeWY1UPlTCzQD7S032VL2hPyHdDMrJri2/zJdcrq7q6ETTELLM/SY8uY1d/XfVZ0BRnZn/XQXRgIlQiGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8evdNnF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8evdNnF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772131483; x=1803667483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZZvULI05unYa96Ad6JbiPw5Ot2z/RaUtFzo2ODnZprM=;
  b=a8evdNnFKux7JGLuckjZ3ULCknMPLOTaSSwieGpM+dhOKsotplvZx6tM
   UCkiJ9X1g6xqK9QzOEjc7OovaD9mpcmJLjr/1/GBCkp2OrxpQXN8IZGoN
   RimAKWaT59O0mLJW+i2FBBF+MCSfNi3zh46+HV458AcqXVaSZpXlRniwV
   +gzctkKtd7StNkHvX15oWbs3MDr4Q6VV95CFv47zxoZ2rVmLlrWtabzxe
   FZGXANIu/mwNpnHOiwGHurS1/NnOE8ovV+lC7ILoRpaM90B3ir+D+3FfT
   SgSPlvmRL3fZabgaR5UBajxPDGp7Labxp/Ru41SIZhxT6dUzbzoVe431Q
   Q==;
X-CSE-ConnectionGUID: ha2PRjYCQQ+eCkQ76SaKXg==
X-CSE-MsgGUID: tNwyVTTrRh221FolQejlIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84666211"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="84666211"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 10:44:43 -0800
X-CSE-ConnectionGUID: 9CoIIg5gTg64GKps47aLKQ==
X-CSE-MsgGUID: Yf82jLCbQbiO4JcLn5citw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="254426567"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 10:44:42 -0800
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
Subject: [PATCH v4] cxl/port: Fix use after free of parent_port in cxl_detach_ep()
Date: Thu, 26 Feb 2026 10:44:36 -0800
Message-ID: <20260226184439.1732841-1-alison.schofield@intel.com>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v4:
Move the put_device() into existing if-else logic (Ming)

Changes in v3:
Scope fix as a lifetime guarantee btw child port & parent (Dan)

Changes in v2:
Remove stray blank line (DaveJ)
Rebase on 7.0-rc1
Add Fixes Tag (DaveJ)


 drivers/cxl/core/port.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b69c2529744c..a004da8fbe55 100644
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
 

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.37.3

