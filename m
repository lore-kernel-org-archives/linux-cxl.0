Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331E10A26
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172008; cv=none; b=FXgElpn9ZRTzNPs2XfEjJc9Wjt1zaJrdifZGYxD3b4h/qhoM753+ZTqEcHMyJFWL6qaR1rSYa8w8kIkDH8Xw/T/1JGARn23f4yaPCDOHvEfLPrwPkijCv+HTGOfC9eID9KUdriXhs1aZ3/7cnEyqteCA3EPPkvoOlaI8aXeoaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172008; c=relaxed/simple;
	bh=tVb1Q3nrwxSAjZ6RH9R+6NJOjRMXN2wvEZu7ldJZooI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eR/b4x7DASOhoJEyvzTXB2a4Bd7mR0F+hKSZwgDy7RBvh7W96NqSp0H5WCkBCFKsaHobz2eNOoj90C9/e9gw0E/MSwRyEawBOcGfzO/klOEymLT64KLdpA30iixjuX3kRWPuZdbjl+TWDoJRgjxBO7wAqq7fyw7GER+1a0bIOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giA65JVB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giA65JVB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706172006; x=1737708006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tVb1Q3nrwxSAjZ6RH9R+6NJOjRMXN2wvEZu7ldJZooI=;
  b=giA65JVBzQbxa1/WpLW2a8cyTFreZZyd/CRh5+sd3xHO37aoedhpYUcN
   Rs4k7NYg0ql+S7DRAlzWd4/dElKlJ9ge6CIh8BSDaSVOYH3yFHRDXh3I3
   WJt8T9hyKGk5w4hs1k60Wbof2RKjBtN7q7L8CHGQDOQyqFA8yYKsNtR5e
   Ka74JL86XxI6vXDpE5m/G5DP/bbQd+QGhHKMxlg8bi10qI7jbZJ2/83Uk
   9mBmQZFd5gcgr4Sgay0ef4kEQOcuOxoc1YdoYsetStS9zPUQcQM7Bgw4V
   Nw6NmNoBkm5mdakG9Y9GdcufRCksGAsGFCqZR7Kb7Tnq3lUXLBYjNTk10
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="20648847"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20648847"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:40:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929950545"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929950545"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:40:02 -0800
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	terry.bowman@amd.com,
	rrichter@amd.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	Li Ming <ming4.li@intel.com>
Subject: [PATCH 1/1] cxl/pci: Skip to handle RAS errors if CXL.mem device is detached
Date: Thu, 25 Jan 2024 08:14:14 +0000
Message-Id: <20240125081414.2189572-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL.mem protocol errors are logged in CXL RAS capability, if CXL.mem
device is unbound from CXL.mem driver, will not expect any CXL.mem
protocol errors happen on the endpoint or the dport connected to the
endpoint. Giving up these unexpected errors to avoid error handler to
access unmapped RCH dport's RAS capability. The error handler of CXL PCI
device helps to handle RAS errors happened on RCH dport. The host of the
RCH dport's RAS capability mapping is CXL.mem device, so the error
handler will access unmapped RCH dport's RAS capability after CXL.mem
device is unbound from the CXL.mem driver.

Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
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

