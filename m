Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE209657A0
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jan 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535873; cv=none; b=h9qwRV4za6TtkBDLoTVTrQbtQkBx2sldJofDZpATzV/+0t1MysTBvs3+4PJeBsal+aV3W1Yl2OTygChuVuuHzvxT/v7ESu5+yJWT76Z5n/yLX/iHGCXnzrNv0Eag8XZewEyDwqah8811u43GdVmbXQ6WmL0un/h6p5AtQbMg724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535873; c=relaxed/simple;
	bh=de1AjcmWYMKfa+Ib3/H854WHJIeZ0QkUxZ889mVFD2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uj1ke909snbIO42cngyfbCdViA17Q+t48FQn5AcTTVKUojHJ6kK7MpgOGgunNe9rTrWtjXuee3NUQ/CqmutsE3T8UkEdyV6kJQEh7TYoqEWAswh71b3YFgSrgYi+AQWgEY0DtybISGrs+qRQ6CMFGR/Ehs4E7I3LqYQDHEt8wTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJlzIo9w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJlzIo9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706535871; x=1738071871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=de1AjcmWYMKfa+Ib3/H854WHJIeZ0QkUxZ889mVFD2s=;
  b=cJlzIo9wXgjcBITBDoKBpVeLuescVWENE6dQOZv3tITd7ZS8R7Oe3cJ3
   lzqPJxbU1Zj7s3l9wCt2SoYwPpgKs3+Fy31RtmdRw6XXY/d3nl//nRE9U
   MsntU1N24DQbdHOnRoHqblkwIrpGgKf3pebGT1YFVgUTCEjz+FKc96kEk
   rO4vXL60WJ2XcSfdEBCcJSV6A2ILK5y9c32d5d5yuUi2Zn3/9PczNJ51n
   P9uEELEmV5NjEvHUB9cXwQKA7/cuj6x0PFI8WABDbDN4oMrn/VW46p8eq
   QpClsWVrUF8jPYVpQ6Fez/5UJjwG3IvZyF7c2KOz7CZTx8kwZT9HXcH2u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16479978"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="16479978"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="29524222"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:44:27 -0800
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	terry.bowman@amd.com,
	rrichter@amd.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	Li Ming <ming4.li@intel.com>
Subject: [PATCH v2 1/1] cxl/pci: Skip to handle RAS errors if CXL.mem device is detached
Date: Mon, 29 Jan 2024 13:18:56 +0000
Message-Id: <20240129131856.2458980-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI AER model is an awkward fit for CXL error handling. While the
expectation is that a PCI device can escalate to link reset to recover
from an AER event, the same reset on CXL amounts to a suprise memory
hotplug of massive amounts of memory.

At present, the CXL error handler attempts some optimisitic error
handling to unbind the device from the cxl_mem driver after reaping some
RAS register values. This results in a "hopeful" attempt to unplug the
memory, but there is no guarantee that will succeed.

A subsequent AER notification after the memdev unbind event can no
longer assume the registers are mapped. Check for memdev bind before
reaping status register values to avoid crashes of the form:

 BUG: unable to handle page fault for address: ffa00000195e9100
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 [...]
 RIP: 0010:__cxl_handle_ras+0x30/0x110 [cxl_core]
 [...]
 Call Trace:
  <TASK>
  ? __die+0x24/0x70
  ? page_fault_oops+0x82/0x160
  ? kernelmode_fixup_or_oops+0x84/0x110
  ? exc_page_fault+0x113/0x170
  ? asm_exc_page_fault+0x26/0x30
  ? __pfx_dpc_reset_link+0x10/0x10
  ? __cxl_handle_ras+0x30/0x110 [cxl_core]
  ? find_cxl_port+0x59/0x80 [cxl_core]
  cxl_handle_rp_ras+0xbc/0xd0 [cxl_core]
  cxl_error_detected+0x6c/0xf0 [cxl_core]
  report_error_detected+0xc7/0x1c0
  pci_walk_bus+0x73/0x90
  pcie_do_recovery+0x23f/0x330

Longer term, the unbind and PCI_ERS_RESULT_DISCONNECT behavior might
need to be replaced with a new PCI_ERS_RESULT_PANIC.

Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
Changes in v2:
- Reword changelog for more context.(Dan)
---
 drivers/cxl/core/pci.c | 43 ++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c9c8d92f8f7..480489f5644e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -932,11 +932,21 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct device *dev = &cxlds->cxlmd->dev;
+
+	scoped_guard(device, dev) {
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return;
+		}
 
-	if (cxlds->rcd)
-		cxl_handle_rdport_errors(cxlds);
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
 
-	cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_endpoint_cor_ras(cxlds);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
 
@@ -948,16 +958,25 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
-	if (cxlds->rcd)
-		cxl_handle_rdport_errors(cxlds);
+	scoped_guard(device, dev) {
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+		/*
+		 * A frozen channel indicates an impending reset which is fatal to
+		 * CXL.mem operation, and will likely crash the system. On the off
+		 * chance the situation is recoverable dump the status of the RAS
+		 * capability registers and bounce the active state of the memdev.
+		 */
+		ue = cxl_handle_endpoint_ras(cxlds);
+	}
 
-	/*
-	 * A frozen channel indicates an impending reset which is fatal to
-	 * CXL.mem operation, and will likely crash the system. On the off
-	 * chance the situation is recoverable dump the status of the RAS
-	 * capability registers and bounce the active state of the memdev.
-	 */
-	ue = cxl_handle_endpoint_ras(cxlds);
 
 	switch (state) {
 	case pci_channel_io_normal:
-- 
2.40.1

