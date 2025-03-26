Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1819D88B;
	Wed, 26 Mar 2025 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975119; cv=none; b=lgkAMpX0Gd1gU4Ara0tLYq5Xb/Z8/zwuGTLrYKSZ1CrO+ju4qG1c77gUwfip3ubsJ6mtQDoNpaHTjWhfyNn5bK7AbtkgoWebPnbSBndxTwwTEdJh6p59DVMsZyl/+ZKyqM0yGXvjuKyKrU4M5Shm/UTlIWC4ZQuX/r+l449gUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975119; c=relaxed/simple;
	bh=v2Lx9oxis+pdzxQKqGW8fY4+egeidnubKddrV6FElWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e8Ky2Mz3IqiUk4/zbZ5Z4nJG6Ti93oZpt+lHFu/DBTUE5/IXaNjNuaV9oV9paUVlS/pGSZt9jNDPbLurRA8Il+KNI3MXFiZymr1reSm2vUPFZOP0EnqYGA/kE9aEY1PQKdAY/o8Ut3dPiDy4QvgSYeYWR6707l0mJtTqnQbleJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SYuC/w9Z; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SYuC/w9Z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742975118; x=1774511118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v2Lx9oxis+pdzxQKqGW8fY4+egeidnubKddrV6FElWs=;
  b=SYuC/w9Z+ruHuPofz7Tobw3JYBvnmbvl57E7JNC6l14zGR7R1QZCfct8
   nP/FQ/GJ6PPajG2tx5HYsESFSucB25f3XOoTTOvuqWo0nIZGei5sGST+P
   x1uY/TgWjFjAV8HZUUuMXEp0aNMqGiRKAZuhXaFJu3w0wuVbptYsDkg9W
   uCm/dBtmKOgIbf+GNQxuBd1fDvS+q2ZhEnVaak18+RDPd2uuvp5L6v0k5
   VDq5Vi4r8Iy/RexLqsdPEYkqJ2V/TMgKoYL9nSx6WrQWPv4riyclOyiYX
   HLUbmM6QVgqY3lOoLQWiey5W3B1BNlLXGGUTfnEA3nYw+4bh04SWAX2Fl
   w==;
X-CSE-ConnectionGUID: wm3s/aebQqi2v0XSgcewNg==
X-CSE-MsgGUID: Kau2CLaeTaS6lo7R5rRXSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="194328042"
X-IronPort-AV: E=Sophos;i="6.14,277,1736780400"; 
   d="scan'208";a="194328042"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 16:45:08 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5445EE8529;
	Wed, 26 Mar 2025 16:45:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D404103F8;
	Wed, 26 Mar 2025 16:45:05 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E74BF1A0078;
	Wed, 26 Mar 2025 15:45:03 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Date: Wed, 26 Mar 2025 15:44:50 +0800
Message-Id: <20250326074450.937819-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
own length, verify it to avoid an invalid CHBS

This patch also wraps some sanity checks into a function.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/cxl/acpi.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..4a82d2d8b547 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -11,8 +11,6 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
-#define CXL_RCRB_SIZE	SZ_8K
-
 struct cxl_cxims_data {
 	int nr_maps;
 	u64 xormaps[] __counted_by(nr_maps);
@@ -468,8 +466,35 @@ struct cxl_chbs_context {
 	u32 cxl_version;
 	int nr_versions;
 	u32 saved_version;
+	u32 length;
 };
 
+static bool cxl_chbs_verify(struct device *dev, struct cxl_chbs_context ctx)
+{
+	if (ctx.cxl_version == UINT_MAX) {
+		dev_warn(dev, "No CHBS found for Host Bridge (UID %lld)\n",
+			 ctx.uid);
+		return false;
+	}
+
+	if (ctx.base == CXL_RESOURCE_NONE) {
+		dev_warn(dev, "CHBS invalid for Host Bridge (UID %lld)\n",
+			 ctx.uid);
+		return false;
+	}
+
+	if ((ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
+	     ctx.length != ACPI_CEDT_CHBS_LENGTH_CXL11) ||
+	    (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
+	     ctx.length != ACPI_CEDT_CHBS_LENGTH_CXL20)) {
+		dev_warn(dev, "Invalid length for Host Bridge (UID %lld)\n",
+			 ctx.uid);
+		return false;
+	}
+
+	return true;
+}
+
 static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 			     const unsigned long end)
 {
@@ -478,10 +503,6 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 
 	chbs = (struct acpi_cedt_chbs *) header;
 
-	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
-	    chbs->length != CXL_RCRB_SIZE)
-		return 0;
-
 	if (!chbs->base)
 		return 0;
 
@@ -502,6 +523,7 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 
 	ctx->cxl_version = chbs->cxl_version;
 	ctx->base = chbs->base;
+	ctx->length = chbs->length;
 
 	return 0;
 }
@@ -570,17 +592,8 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (rc)
 		return rc;
 
-	if (ctx.cxl_version == UINT_MAX) {
-		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
-			 ctx.uid);
-		return 0;
-	}
-
-	if (ctx.base == CXL_RESOURCE_NONE) {
-		dev_warn(match, "CHBS invalid for Host Bridge (UID %lld)\n",
-			 ctx.uid);
+	if (!cxl_chbs_verify(match, ctx))
 		return 0;
-	}
 
 	pci_root = acpi_pci_find_root(hb->handle);
 	bridge = pci_root->bus->bridge;
-- 
2.47.0

