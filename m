Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259926AE4
	for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4MtkAOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703289631; x=1734825631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LYqTV2ECYldX4OqMmspOu6rI439ychpNxwfrdcl5/NM=;
  b=A4MtkAOn7QmOmjq1rPU8brUL8l8tBV9iTMJznwNzAGRsCs4u9cmRiWPs
   01vWwZG5v0XY4Cp6TFEd9/m90prgo+eTeRAXTgNHiui1CVe87z5LpO8k1
   i9bmFKmB1S3a6aGDdipSxjOCWf9NvOJGeQylPtg6w905xAclBUsb2Ck0T
   2v1XzedyQrrJjUehCIdmlIJaLoDYn8E48BuhwWuJGi8I/cRBK6bcJh5J5
   2GLF00w3Fdm4oBASlUu5ZvJgBJzTx5yB3oJXn6I7SNIlZBXHfumRXUqL7
   NPxVJqgOcfy0BnUnyn9JHz4+4P9JW5ZCqI93ahGuxokvUULMc8vx8LLe8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="376311103"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="376311103"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024385915"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="1024385915"
Received: from jbjohns2-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.160.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:00:30 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	"Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH] ACPI: NUMA: Fix overlap when extending memblks to fill CFMWS
Date: Fri, 22 Dec 2023 16:00:25 -0800
Message-Id: <20231223000025.1401076-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When the BIOS only partially describes a CFMWS Window in the SRAT
the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
to fill the entire CFMWS Window, thereby applying the proximity domain
to the entire CFMWS.

The calculation of the memblks to fill has an off-by-one error, that
causes numa_init to fail when it sees the overlap:

[] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
[] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
[] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]

Fix by making the 'end' parameter to numa_fill_memblks() exclusive.

Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 12f330b0eac0..b99062f7c412 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
-	end = cfmws->base_hpa + cfmws->window_size;
+	end = cfmws->base_hpa + cfmws->window_size - 1;
 
 	/*
 	 * The SRAT may have already described NUMA details for all,

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3

