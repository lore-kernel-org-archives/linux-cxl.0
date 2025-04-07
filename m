Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175BAD5A;
	Mon,  7 Apr 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013021; cv=none; b=d6Yaq7gptJgBXQKMWNFaFkRMGaHdtPTGxNQRFH96otzZ0gfr9T7vovY0AeOLnOHUMbbWWCT8MP25vWJTblJJhg8MYn2drc6XlaJNJX0sqtUQFq05wv/vs5fKxzNkoo2SsBRiLyyMEBiHwaOrmwMo+BSdFqa6FhaGP+NoCje7GWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013021; c=relaxed/simple;
	bh=bEsYDKsEeCem02wFhShv2lx/lA0WPayiWYXzd/tmYgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uBktTjlgOHhXs05+XKd3UV2Le5Ne6oiJSVpYr6jWo17OgjIqyTqSRsXtsHXTGOc9R8KEKr8nIfJyRuAVfa5qgCkZiO6mc0XApDmXXIMcMqnj49Rp3S5eZGyl9/CV7czM6RPYzC2GXvAarQKAo4T7cdRlBeBCThy60YBG6ltP4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KfKoE0+n; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KfKoE0+n"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1744013020; x=1775549020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bEsYDKsEeCem02wFhShv2lx/lA0WPayiWYXzd/tmYgg=;
  b=KfKoE0+nxdy2pLwWH00d4gtsTThzQlQc9dHt9R1olNGkWN2qirx08xLZ
   guKD7xm4DGS7T+baSw2jBwdy/DOFex4eqtp3+iZ+zL3H56qBhoTp9l9Ew
   wy+UO6IXm3JtGrVr7cOHFV3duq5Kmlmqt36WyRRvQOj+B/F8O8EVIjDk+
   BiqNkxmUbG331Rs8fqS1CJE0y0MojVk/+ATE5QZgz7eubcxTpTRRi7zaQ
   yJkJzKhwnPObce5aLSfJ7qqTIrR73gxoEmsVi/EqwIu1gquPSNRHNnxwB
   FOAJx+f8ZrRxL2gzix6T99IaFkur9grBaCqiw0aksz4Z/JTAoZGf5bDYV
   Q==;
X-CSE-ConnectionGUID: Tu+DfewJRKWe3g6ycnS0YQ==
X-CSE-MsgGUID: GoUJnCEBRWutC5y73okiSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="198427340"
X-IronPort-AV: E=Sophos;i="6.15,193,1739804400"; 
   d="scan'208";a="198427340"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:02:28 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 731CED4809;
	Mon,  7 Apr 2025 17:02:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 366C2D88D2;
	Mon,  7 Apr 2025 17:02:25 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 686EF1A0071;
	Mon,  7 Apr 2025 16:02:22 +0800 (CST)
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
Subject: [PATCH v2] cxl/acpi: Verify CHBS length for CXL2.0
Date: Mon,  7 Apr 2025 16:02:17 +0800
Message-Id: <20250407080217.76117-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
own length, verify it to avoid an invalid CHBS.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: don't factor out, just validate # Dan
---
 drivers/cxl/acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..2e63e50b2c40 100644
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
@@ -478,8 +476,10 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 
 	chbs = (struct acpi_cedt_chbs *) header;
 
-	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
-	    chbs->length != CXL_RCRB_SIZE)
+	if ((chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
+	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL11) ||
+	   (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
+	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL20))
 		return 0;
 
 	if (!chbs->base)
-- 
2.47.0

