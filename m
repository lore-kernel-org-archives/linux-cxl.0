Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3D1D86FF;
	Thu, 14 May 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725983; cv=none; b=CwHK/M/wzt0xXC4DBh7dBtdGe72Iar+uk3aFgAJ+YBMU98nmnbGOA9xh/M+uVBqDZHf/WJTO649zeibLmcmHrQsPJ/HrcpInAxTa2WwWoDMnHoy0HQHwQNJJCep7/ZAIoo2mYMyOtVcDxtuiopZ6dxFSXHBDhS7LaViDJkZzATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725983; c=relaxed/simple;
	bh=iIonJ8mGCab/GN+Er5sWbLAMioDzCPkDvICt99Jihfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2bObcR8YeHkxDKPlBN0jjIB9hMu7S1lUpb3bKQ3REuQcsPGCe/rnhI/G71G/QQPnGMImtziocXIDjX6xQQaY6HigqIyrfKHCvb+tv2aQPgI0R/tCzyS3A7aWH8eO5XOjgX/Pm7pyW+mBkjrI850vK+8xBtkjKqnFDUAbFrzZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bpy/ew6I; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bpy/ew6I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778725971; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lbCagZyy3GUT0s2ScDbSsTXULb/YxLy55rgWTPCSXWs=;
	b=bpy/ew6I+qbNFGCemRONUkVrMZqJ8eBsgZMweCqrBzwV7WUrTrz8ojSz/lU+X4d6Ei90epzzSyVplbmM7T/bZyjZJq3FE6NsvMl++l1fNyButP0NnQ/fK0YNsb2Um5l3jsL7G6cNBF1XxN4studAtZB2ixnWecvPOtobLARUA1s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2vNJ7M_1778725961;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X2vNJ7M_1778725961 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 May 2026 10:32:50 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org,
	guoren@kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is not ready
Date: Thu, 14 May 2026 10:32:38 +0800
Message-ID: <20260514023238.49984-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some platforms (e.g., RISC-V and ARM64) that use the generic
pci_acpi_scan_root() implementation, cxl_acpi_probe may run before
acpi_pci_root driver has bound to ACPI0016 (CXL host bridge) devices.
In this case, acpi_pci_find_root() returns NULL, causing
to_cxl_host_bridge() to skip the device silently. This results in
incomplete CXL port enumeration on first boot.

Fix this by detecting the case where an ACPI0016 device exists but its
PCI root bridge is not yet ready, and returning -EPROBE_DEFER to trigger
a deferred probe retry.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 drivers/cxl/acpi.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 127537628817..9952d0cff903 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -631,8 +631,21 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	struct acpi_pci_root *pci_root;
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
-	struct acpi_device *hb = to_cxl_host_bridge(host, match);
+	struct acpi_device *adev = to_acpi_device(match);
+	struct acpi_device *hb;
 
+	/*
+	 * If this is an ACPI0016 device but acpi_pci_find_root() hasn't
+	 * found the PCI root yet (driver not probed), defer the probe
+	 * to allow acpi_pci_root to bind first.
+	 */
+	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
+	    !acpi_pci_find_root(adev->handle)) {
+		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
+		return -EPROBE_DEFER;
+	}
+
+	hb = to_cxl_host_bridge(host, match);
 	if (!hb)
 		return 0;
 
@@ -688,7 +701,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 {
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
-	struct acpi_device *hb = to_cxl_host_bridge(host, match);
+	struct acpi_device *adev = to_acpi_device(match);
+	struct acpi_device *hb;
 	struct acpi_pci_root *pci_root;
 	struct cxl_dport *dport;
 	struct cxl_port *port;
@@ -697,6 +711,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	resource_size_t component_reg_phys;
 	int rc;
 
+	/* Same deferral check as in add_host_bridge_dport() */
+	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
+	    !acpi_pci_find_root(adev->handle)) {
+		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
+		return -EPROBE_DEFER;
+	}
+
+	hb = to_cxl_host_bridge(host, match);
 	if (!hb)
 		return 0;
 
-- 
2.50.1

