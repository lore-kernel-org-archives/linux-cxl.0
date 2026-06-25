Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504C3AEF44;
	Thu, 25 Jun 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406533; cv=fail; b=FBnrj4AysxoiKLfvWiqxbc0CA2UMdeyKnei59JeQh3D3IYCiQXX29AXIgsqcD9Xh7EHPoptUXLz07Uvzm7cYK49YxNLJjoFhU/lLVaoWUhJMt94inc8F9BOCgArG0VSRElo6gbL2bRz/6BJpl7HIwNlgmQnh1JKbFOr7vibxDho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406533; c=relaxed/simple;
	bh=2D6uicPC+9eKBr0M5IFDd8uvE7WAbssLjG8KRNrZ0e8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFVo5E208fHjcK4puPAwBtcsSU2SOeSZ/qZImIQ+Qs9oantQJt5FSq0n5+pJtV9Ge3pCH+apSdUz9iVGrgz/JKGua2hCGOlSpdKMBrewmWMzzcd1C2ij1Xr/d1SRKIMT1VCXcJsdrEthjlMnxjsKt030objKInpVALPEePKiG14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N79wDs5i; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N79wDs5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWB1EFyfOCRJ81ZfGZ7Rh/r+JV3AD3ASZP9PLQ4RvxIW+zeD8pJscBzBbB7ddF43kZI1tulCB0k3k16rEyCTvh8BRyEQosvx8UZLFmCGgeVLLoBMuZC6dcEgfB4Uv1f6juzQ7buMUt+vPfHJgzLMTGtM+z3Hr+wbxmM2uc9wiKCKPLohZZCOXn9/OsKGLepYvZVqx5eV5rqXJm8cAyd1nByIs2AqCE9GVd14W5q99aB3msafCj24ovSuUER9ByoxhrVAmZkupUrF+sSFQ0Yjk7fWv6Y8wSG3PO5VVy5unNZjamb5gQ+i6Vd03VvdPU7mLCU8pFit8NVdtW10DCKrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25yBn9LQ8juKKcwF4kGekbXuR1EuRy7JMetkAvaH6b4=;
 b=XvhcyZuLJAInTPzimrl7NDx9HY+GufcPtCtutBuTPzZuXPZg3ZQdTLc2XOJYLntSCbpgCN2sYzASB/ZZOcVbmLZz2s7I7E7450kWrR8iQvf35fAOPP0YWtX5cHyxs3yR5sVIm0Vwd4yvk94GdEWco8XHcNhaoiVp7fTBWzqPswClcaIjNCthU2ROUvf13svBQhQ0vpoEBO9pZGicTG7fJI1C5+djrJWnYhnutnrXuPGCIvpiiv0UfWEduD9Bk8bbbARt7LWuPwuhkBcgJis3MuPtb8HEP6n7xr36HoJ00I2PG+JhQi1eZuhK4R5NP+BvUUKhrc17/OXl0Gdgdq1ppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25yBn9LQ8juKKcwF4kGekbXuR1EuRy7JMetkAvaH6b4=;
 b=N79wDs5ipnnzDpRXXWUPy+vZvIPM4vwX3ip8PLmhUNA1rcjMStJ7qyLndDZFH4Smlc0oa5TgnVIV8r3wp3YRFhkP/QgLhJwIfIcQQReppG6mgIMquyJ01l1B/ywhEPAzjq1VCvFZnSuQ/EoQxohdU6Uw0SvmOdF/uvrBtRGjHrWDcvHiWGSOx+OPd5JFv5BnLJuYW3nubizrq5DNdN0UtCK8ChQjv7Zl51LK61RM1cInGCh6bfd9WI96UZhRFGBP40LBUm1YeKZE/bsottzKdls4ePya3T16PEnmPTkn0sZNED/RcnUfzA9iK3JNl6xeH+ogw+iZV8xQMGcZF0fSZQ==
Received: from BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 16:55:26 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::64) by BL1P223CA0030.outlook.office365.com
 (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Thu,
 25 Jun 2026 16:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:55:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:55:00 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:54:52 -0700
From: <mhonap@nvidia.com>
To: <djbw@kernel.org>, <alex@shazbot.org>, <jgg@ziepe.ca>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <ankita@nvidia.com>,
	<alejandro.lucero-palau@amd.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <dmatlack@google.com>, <gourry@gourry.net>,
	<ira.weiny@intel.com>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 02/11] cxl: Split cxl_await_range_active() from media-ready wait
Date: Thu, 25 Jun 2026 22:23:58 +0530
Message-ID: <20260625165407.1769572-3-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 922a9040-8119-4d3b-3e93-08ded2da8e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|22082099003|18002099003|56012099006|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	kG+fEfq2YGsBQaAl5ON5kaPQVZHk33C5qiA+Q0KJjjSMeec8RRT6lpUDbqOgiKslWkXmHV7k/Y9zr5+KTRsSDaxu9Fx2CeyHT6jjIiz+rJ7eE35RPZKc4wgTh+yB2pJDdurf0bGwDKYaMmZ/7kJNMCz0ctxQlikBTZdjpqbLLFEpR04JubtZzaSq2Z7YpnakmALhoEE5vAzdL1CBe1m+Nh4gEseJm46rxGLdUnQ8N1ZC6R4kOVlAa3FEza2CwL7TcSIfrlHdg6ncUGXdbv9LsAf0U2rQ3nwaC7zK+t0LVIs/KNijEII4Zw9LjeLFUjtUrfXvXXehw4dJQVDoKhq7Wlp7FHjTY0sT6J/uuhltqJ+1xuWlgg5YTIySN3NuB4h5jwBFQSZEFQZ8/Tl0+qoaCFuJfOfpjubF7JHZmrU2pRyusWiHzFADsAtmj+w4XprLofXPjmyQqzQ4Bgpzo881DIfs5OQsIICWfchEksRGrOxhBzWVnVsxsQp7IpxXdjNIThd/6qvhrchCpGlZT+77H4jdW9p+a9rbo+7/DuB8QBzp9U4hGXFAFMpZvlIjZfRFsAUZ7MopfUoJyHQ/RND00d3MBgYBod55UyREGHNYJ+DA2oB+8tuj4ZaqjwUT8UNHr82lwBsWX77dqccBps02Q+dmBmrelkYagJcHp91z7pWK+0jg2CD+00yskeZJ9XYvKszbAC0imCIYuM72TBOsvwBLuxbSdG8vdM9pdNM109IBdh/oPS6Zi3bqNASafDrW
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(18002099003)(56012099006)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R+VMjHdcVidjMf97akGH1eYIO1aHHV3IMCGMw0wAmEvVRJwG+VrooVnwXxruVbJHu9dc64n4/CIv0iD08WK/0Qh77cQbxNBOb/qpE0Gn1z1bconAQXcXftXgqgHJxJwdqRgVZTU3x5E2WhI49a1RAEW8PChxvJx4thAx0CZXBN60P+ZndFZV//i0KwNjk+ulho6Si0tCjyC/aw2QDJX8e0+yHCZIh1LxJrrPvlXJAQKt3Js9ydULvgqROvMzFdyPFmeQsNpkrohcNz+8d5gKl+rVz1wlS1iA4itrvqD0LZwabpP2llPI0oI2Uu0+B6u4m69jcg5NtqNc88s46jdotFBfJthKlDIijG4/YWy/qmMK8Rk51jTQr2y4GRTHBfxn6kfQwXGk7vOXCgxnQB2r0zlgtpu2ytjj7USYarLDuNARQwyceUjDsQdy2snegLtG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:55:26.3963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922a9040-8119-4d3b-3e93-08ded2da8e54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

From: Manish Honap <mhonap@nvidia.com>

Before accessing CXL device memory after reset or power-on, the
driver must ensure media is ready.  Not every CXL device implements
the CXL Memory Device register group: many Type-2 devices do not.
cxl_await_media_ready() reads cxlds->regs.memdev.  Access to memdev
registers on a Type-2 device that lacks them can result in a kernel
panic.

Split the HDM DVSEC range-active poll out of cxl_await_media_ready()
into a new helper cxl_await_range_active().  Type-2 cxl drivers
(vfio-cxl, in-kernel accelerator drivers) that lack the CXLMDEV
status register call this directly.  cxl_await_media_ready() now
calls cxl_await_range_active() for the DVSEC poll, then reads the
memory device status as before.

The 60 second per-range timeout from cxl_await_media_ready()
(media_ready_timeout module param) applies.  Export under the CXL
namespace.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/pci.c | 35 ++++++++++++++++++++++++++++++-----
 include/cxl/cxl.h      |  2 ++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c917608c16f9..c44595447bd8 100644
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
+ * For each HDM decoder range reported in the CXL DVSEC capability, waits
+ * for the range to report MEM INFO VALID (up to 1s per range), then
+ * MEM ACTIVE (up to media_ready_timeout seconds per range, default 60s).
+ * Used by cxl_await_media_ready() and by cxl drivers that bind to Type-2
+ * devices without the memdev mailbox (e.g. vfio-cxl, accelerator drivers).
+ *
+ * Return: 0 if all ranges become valid and active, -ETIMEDOUT if a
+ * timeout occurs, or a negative errno from config read on failure.
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
index 440ab09c640e..3dcc034360af 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -232,4 +232,6 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 
 int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
 		     resource_size_t *offset, resource_size_t *size);
+
+int cxl_await_range_active(struct cxl_dev_state *cxlds);
 #endif /* __CXL_CXL_H__ */
-- 
2.25.1

