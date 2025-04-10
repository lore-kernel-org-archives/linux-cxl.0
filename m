Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B193647;
	Thu, 10 Apr 2025 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247230; cv=none; b=m1F7DJi3ZKyZzAoVKcGXBes7gYhQzxGARrYJ/tPCOQnUD+VktYvDAplumE3/cLVbl82wRmZdPaO+XhM27KsxA8i4DvRcptuVTo7Berh+zgpiByduFox3at4xli8F+2NuCpDL+h7dQwFv8LyGmoEMxhYrY/TlJWbIjdAjavH7P5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247230; c=relaxed/simple;
	bh=wRuMIIt25a8E6s46DgwKPIQAs72RHwhTOGUxithp+Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dz0rBeyIvW9aG3zMFXZC04VX9sl2CCS0bOGkIqujpbW18WMRiISBG1PbprnvlJyGLZQTGri8By/N0fI4yJYBz3GoiHS008/R9trxNLvR+TJdl1AZ6uBPUWp4NN+fk6vE7r1X2mHkL31FgPdO76ftzwmIWzjl7Lo5zf8uT/eVoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OYZdooKj; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OYZdooKj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1744247228; x=1775783228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wRuMIIt25a8E6s46DgwKPIQAs72RHwhTOGUxithp+Nk=;
  b=OYZdooKjz+2ZS6dKvbgXaO2dBBwScSyxwFV8l/4TFGvwkU+M/Sg1oRBr
   CH8hoxu5ww9Lrg7pzaOkliGQcwhnZk5JuREwegLrSXc7SVAImMQhPj6ff
   Vm1eVe4JuodjkYPXZQsx/v9SjfUmfBenh2/oRpqtMF9dq1ckzLYfVYh4L
   jbP76fmbTBaWouiNSg8u5AYxXWiFki6KjgfP5si6RubM0lmPy98JD7tX4
   vuNE7KANFcHCHPxlRxji4jnUgw6bQZu2iVxWU/b+HyTln1FfOJifTn5FB
   i7xFSaUh4r3yVzY/ZefeUMsw+kVLH1mEPLyXLrV72K2GdMp3LSBdhBYr0
   g==;
X-CSE-ConnectionGUID: HcFNwuIVQgSOsOR0u80EBg==
X-CSE-MsgGUID: zH4p1MYYQNq5LrFyv8KmZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="196306701"
X-IronPort-AV: E=Sophos;i="6.15,201,1739804400"; 
   d="scan'208";a="196306701"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 10:05:56 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 39019C2267;
	Thu, 10 Apr 2025 10:05:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id EC19BBF4B8;
	Thu, 10 Apr 2025 10:05:53 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B6E7A1A0078;
	Thu, 10 Apr 2025 09:05:52 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH v3] cxl/acpi: Verify CHBS length for CXL2.0
Date: Thu, 10 Apr 2025 09:05:45 +0800
Message-Id: <20250410010545.99590-1-lizhijian@fujitsu.com>
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

Additionally, this patch also removes the redundant macro CXL_RCRB_SIZE,
favoring the use of `ACPI_CEDT_CHBS_LENGTH_CXL11`, which offers clearer
semantic meaning.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
 - say more words in removing CXL_RCRB_SIZE # Alison
 - Collected Reviewed-by
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

