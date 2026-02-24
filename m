Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88823A1E81
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958488; cv=none; b=HPqmW/Xzlp6L0x0fPLBsxapeoF3iE40OmDi722Nx+naHcp8FXkxEWJcxecu1yqi4dzs3dKdeR6jHskWCjurcjOeeHewItbleUevbOQdByKX2cGNyL7y6YUglv9H1DS18MkiJ2L4zsG6fwTnYnp4NjLze4RlJagpB5/Q6KiosP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958488; c=relaxed/simple;
	bh=mlE8Fqv/u+DDGp/S/eWOb7AEl/An8DChsml3IpItlec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUyYNiH7ydRG3SmSEzZBymGa4THd3pjjvF9MZ+rMCn0bURc+rAx+uCFYWtwtEMBCskb0E3dSD44mxzAe+nmuem5cMIUdIxrZjQMoWDLgv+o9GjPSTLibKfdr3Rd4NdcVc9+0rMrskpbgdONX3ObWRP//gnc0sLBQV7GRHFYt+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qo2yxcrl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qo2yxcrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771958485; x=1803494485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mlE8Fqv/u+DDGp/S/eWOb7AEl/An8DChsml3IpItlec=;
  b=Qo2yxcrlndGlXMQuvaebQ5DnimY7c7vRGdJwa8J0zNRTiqXprs0bUvRw
   8SBeCv+jByHYaZw+uI+A3Rx+dMLpyyNEtW0EMldpcpAB3e83Mk8MP0vLu
   i1CxAHrXmdgQlpvCT71JOsCRruf4cgGzJQjthamTa+5mL22NeazV7WZc7
   iooLTS1K10Ziv9XaljLLT3BqVwMU9pRMMbLNJbrgIh1LX1AhtFGyYCC2U
   AG27NzVljZK6gTCs3yWu9eAnbiCS/2qaH2FOldmYSi+/gVSn+7q8sPlh5
   lo7U5s46p2WOlywZN9s8Gzv3zbfiq3dVZUo3EhOlnmk2XsFZAZBQaP6W7
   g==;
X-CSE-ConnectionGUID: 7p5ezeDtQXmVTCW0YNHXaw==
X-CSE-MsgGUID: HJo0TFIeTD2VjoXova6Ibw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72193612"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72193612"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 10:41:25 -0800
X-CSE-ConnectionGUID: QHQAVf2vTBKTgdBq1zwtRg==
X-CSE-MsgGUID: NIzaNwqBQleQh2kScfm3bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="253737305"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 10:41:25 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/port: Fix use after free of parent_port in cxl_detach_ep()
Date: Tue, 24 Feb 2026 10:41:19 -0800
Message-ID: <20260224184120.1680624-1-alison.schofield@intel.com>
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

Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
Remove stray blank line
Rebase on 7.0-rc1
Add Fixes Tag

 drivers/cxl/core/port.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b69c2529744c..5a58336c2a2f 100644
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
@@ -1553,11 +1563,18 @@ static void cxl_detach_ep(void *data)
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
 		device_unlock(&parent_port->dev);
+		put_device(&parent_port->dev);
 	}
 }
 

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.37.3

