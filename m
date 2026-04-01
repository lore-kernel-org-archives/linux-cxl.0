Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109A2DAFB0;
	Wed,  1 Apr 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054444; cv=fail; b=kYIGuGoYrRfE2KbMECT9XD4umMh+cnhYzihl8mUHYvByZ/XsaHMTbBw3JqXTrRfnWeKWkhLg/vNU5pfN3JPDgEEsWceIROwjIfNKo1Wh4SzMhShtT0yuIRfjLmHSc+jK0P15PnhhYZj9zTQ0s28OpyNHGZykPl7XolAidP6IstU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054444; c=relaxed/simple;
	bh=+4VMsaGbdAGIflmjQrJ4//NBcja1D5ttQmBKNuw20TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMfnCMcsCr6q+Hs7euNkst1X/70BjBTc3+oVjGfkhNqCVlA7rf2bH5TjXAH3qd3NbzAPH8g8+lXeF3TuDCLiLgsfhs/16yqjUA/n/i/uIzoWgPzGX9CJqqCyrV8REh65TD5FU1nw7oSwacYNMfRPVAtNRx8Ipo/fccr0BQejoB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ChrW8dyj; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ChrW8dyj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIGOUgromeEuNCXLtNCOcgQv++hJJmeoyTfSBd3Z+MHrtNz7aYr10hmxS3u52v67fZSYWN7IgmzlZPJCoh70lx2vksFC1Gj+n4/5N2YVaX3vgF5VEulVeIgbR8Bw7iYq0xvNfuAkPSuk9vI5HNcPT89lIzwCEK9ByJWegTklF+Xkd2JjxNO+Q0SkkAf73zKw95zryOcyreo4yhOiDQLqf3ygd+I5k50ug6KT7gfT7lBRRw6dC26+IDqQiuoMKGyFvcoXBIIEx8JjfK5ARPCFuNkIS9IBrNsq+EI6RAF6ptiG8LpNPY4m+g6fqQz5BariJEm1A3UZHpMMeqUv7TfZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aXLmxkS0OPtOM3vbtEXezb677ZOXe+bFO3IFD3xBFw=;
 b=GRDAO2mHHPFaj4oF0FUIkwD2RTXw7y9ztE1fvVWqXJAlmuJyYTjkFWEHcVOu9k43oQPTUkrrHXKuGtVD9ujS7MOND1R6MuoIEAiCI/lKqXArkkVLPz09WSOmPw2g3sagB7u3PQ8PKav4i1fayDBt5agiGqIlbAN5jUYpFQLHw7SFSTwjpiUtYTYv41K4GEMBJ8YaqB7LrZUfBFY7gJg53PqxSFRnXPEtKjaA+CjDMwhOu/+Dst/f7I7bI6PhakK0zKL4ze5Y2wiYBS/Ui3NATvpk6ftCFsDuZW81Zubx+IlBIZiEAsY0kwGiZmQSAUfEYUBResBoBtPfHd4W7PqfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aXLmxkS0OPtOM3vbtEXezb677ZOXe+bFO3IFD3xBFw=;
 b=ChrW8dyjE+npcFv+E/g/m7BcrVHdaa4r6O9VaEoufQMZq6DMfGeB3dFCQ+LX/hGVcucb8AtCJR2TIqfKohcrKqQiR+l9NFgUCTreRrfZlClE8FQkPSGjFKcheqEzTtjF/BdwUPq4RJUyRfhSOLd4m/dcPNQpemFxHZiFQIGOI1LwIPOvcurSVt74F3ieSnTh/SgTVV6zzmPtIwV1kNHWmID66RA1YNVW/kwxg7UAVKvU6qikVx9FHrfOS4frH5MrAJDzQKz590G7Fd2RA4ZI/mY1UhkVwH7NrQTO8fSNvAIte+EqxFlLB5RNCWrCYFT+ZP+gEOmbJvCxdzP9dhhG+g==
Received: from MN2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:208:236::31)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 14:40:32 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::10) by MN2PR05CA0062.outlook.office365.com
 (2603:10b6:208:236::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Wed,
 1 Apr 2026 14:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:40:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:40:08 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:40:01 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dmatlack@google.com>, <shuah@kernel.org>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH v2 04/20] cxl: Split cxl_await_range_active() from media-ready wait
Date: Wed, 1 Apr 2026 20:09:01 +0530
Message-ID: <20260401143917.108413-5-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8fe79c-3268-4c25-902d-08de8ffca0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UmAdL43qGw6hfhs+AoxULDZCHbWE8HVKwY0erEOijqO4Hndvw3r1d/SvSfLW9iaNMY5s+lJhBIWJD0wlA6bGKhBC+fjq37C1BDvheXHQL1gFYQ5r2LWOvem7ad2FRAqfLF8UXsWIHPcMYnNwmwPq4IrvI0HdSLUqc2O9Zgt/u3gcXsN+n/3hdVpeY0yazEsivcGVIKyvGwfEcmrEyuAHcx2sggCNsTUQeUe6d9roAflkJznilGfuZcbKqaVm5lsH6DkeW0yMQS+Nzb9S5JJyumS6S6gKt/ooIXF3g+0cjfGnS40/y2Pf6rikxkxpVxm16/YXif3yEV09LTXzDuS6KGu6J3FR672g5VRjKpQsvSGcHwYL0igtmIBf122RB1Z+yJcPO2bJdp2iBngyQfoamlXXjqXcXA0RBlovHWWQMsXyiZ3iMGILz+3Ds9XJJccrz2dpxJEKG4VLbIq52xq8YTyS+p4spdbJC1kVOJVV7qvhSbF+fRwZJ8SsxbkR1nzRBAf3X2OE3GcMf0bRp/FsJpnkHgroW4dwu7G4JzH7NDfkVg+gMaUhq2gB2HDS0xUSeSWDY7qfmjitBdavSvSCNS/YhJDqwHkR0fNKgzxTe0EjEVgPaSbp5tEbC/9/0O+X5eAPTCVbS5tdeR7YTccnNT0TNyfjjDHW9hRi23BBM54WZvWIYfBzyb/jfGP6VfM2izPzm/dPT2MHe3kqQCrSur54z2BPEF2syebaOSRS5bN6TiD6emJgb0T28LEjcJKXPmrCKa4FlHrosYaPCTVgsLpwMQym3Gj3c7RBXtiP7UGmsR0Ge0UjOHTRbP/fLEQR
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KH0OA3QeoFp/Y5SBqIK1wJCUKoonq0YDo3v7q0rqZ6v6i9smRe8to3u5KdpD1miy6lXh9yaitA5355j6wJt1NlKd1c3jkbB51X+rpfKXNC5bxu/HXCTeCOZ4YQmRgU3sqlSrBdB57n5bZcZlFyCsM7v3WAQjAt6DHEn8V120avD8FtalQWAhLHPPWN1aSjE68vsFGgsc9kbFvTWwYxKKjHvn9oxEypCtyR36m/qPGpGZijMUuuPUYW9RWPDEWT728qyv/yl3mhkyjlY9Egg7Yli/hBvZd+i8QJJ3Ad2dyzdAPfVI+rikrLnyY2qCG3xewjUE6XeuYEo2Afi00XurbCX+Nk2meIxcRHlIA2cG4Ih1RNaYhXs2hqwcIM5XKFsa+Z8K3ul3IrakDcZ0ktIq4tO3+a/97m3r1mDDCpE9ejWM8LZufNE5LTr6pvfYdotV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:40:32.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8fe79c-3268-4c25-902d-08de8ffca0d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803

From: Manish Honap <mhonap@nvidia.com>

Before accessing CXL device memory after reset/power-on, the driver
must ensure media is ready. Not every CXL device implements the CXL
Memory Device register group (many Type-2 devices do not).
cxl_await_media_ready() reads cxlds->regs.memdev. Access to the
memory device registers on a Type-2 device may result in kernel
panic.

Split the HDM DVSEC range-active poll out of cxl_await_media_ready()
into a new function, cxl_await_range_active(). Type-2 devices often
lack the CXLMDEV status register, so they need the range check
without the memdev read. cxl_await_media_ready() now calls
cxl_await_range_active() for the DVSEC poll, then reads the memory
device status as before.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 35 ++++++++++++++++++++++++++++++-----
 include/cxl/cxl.h      |  3 +++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a5147602f91f..1fbe3338a0da 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -142,16 +142,24 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 	return 0;
 }
 
-/*
- * Wait up to @media_ready_timeout for the device to report memory
- * active.
+/**
+ * cxl_await_range_active - Wait for all HDM DVSEC memory ranges to be active
+ * @cxlds: CXL device state (DVSEC and HDM count must be valid)
+ *
+ * For each HDM decoder range reported in the CXL DVSEC capability, waits for
+ * the range to report MEM INFO VALID (up to 1s per range), then MEM ACTIVE
+ * (up to media_ready_timeout seconds per range, default 60s). Used by
+ * cxl_await_media_ready() and by callers that only need range readiness
+ * without checking the memory device status register.
+ *
+ * Return: 0 if all ranges become valid and active, -ETIMEDOUT if a timeout
+ * occurs, or a negative errno from config read on failure.
  */
-int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+int cxl_await_range_active(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	int rc, i, hdm_count;
-	u64 md_status;
 	u16 cap;
 
 	rc = pci_read_config_word(pdev,
@@ -172,6 +180,23 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 			return rc;
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_await_range_active, "CXL");
+
+/*
+ * Wait up to @media_ready_timeout for the device to report memory
+ * active.
+ */
+int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+{
+	u64 md_status;
+	int rc;
+
+	rc = cxl_await_range_active(cxlds);
+	if (rc)
+		return rc;
+
 	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
 	if (!CXLMDEV_READY(md_status))
 		return -EIO;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f48274673b1b..45d911735883 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -299,6 +299,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
+int cxl_await_range_active(struct cxl_dev_state *cxlds);
 
 #else
 
@@ -314,6 +315,8 @@ static inline void
 cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			 struct cxl_component_reg_map *map)
 { }
+static inline int cxl_await_range_active(struct cxl_dev_state *cxlds)
+{ return -EOPNOTSUPP; }
 
 #endif /* CONFIG_CXL_BUS */
 
-- 
2.25.1

