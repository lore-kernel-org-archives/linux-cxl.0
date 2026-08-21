Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C34486E45;
	Fri, 21 Aug 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323431; cv=fail; b=Mb8nKiZHZUlVrk0o/sgbWoymUznUbHeT49dzAAqpTfvVdDzNwURL83NVT6dcqbdqQRD7ERxaatXqfwgSsRbq/hcOaPKLPuEEYniuscmBqlP8ZafnvH186pg0FW6qIoZkS38MhqvBYJ6ZMpsUzDa9ElP5CMuPvpAnuvCqp1SFu2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323431; c=relaxed/simple;
	bh=M8LXwfrcBD4JyypzOOB6XaAX63LresNEK2Xxz1NWIS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXB880tvplOI5QPzwpK8nxIjgMPRWAV+Z8lHj/h6RAGe3e2MBVOzqmhdE/MG3VGFuyiFhDuQmvZv94z+S8NRjwHvgRIgNCbDuageAVoW/Ayc5AZrzZexEoZe4PWi8EV5yhMtZhzg3dqNo9zfLlS3RWz9MEAjxPI9B1OHdLgr8aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mtq07Y+a; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mtq07Y+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohDANZC5AOw4iu100M/BTSe0s3gv5OZJGqYPxCuKd55AgDsFCjJjUuCJqobSPsqkLmhMBZznliaRJTrd5I/95Ra60Fryi8dIM+flBdFEPwj0EJAqGVFmKxs+Slm3jiCDjS9WJgubXsw3MCfXvRkQp22Ant48arvn1gmXAHbKV+AKVTvMUCzFYoK0AbguUYlWaPZBBZnKTxz2/pGcXyAEQKyjjoCkwOTiEqpQx9zMQjPX8/mI+Q0mLQ3OeViCePHRs1LNo5XX9XZypi9HUcfq1l5h8mdtiqc4BU0Y29d+Z50ws/YHJMbf0s/mrXkXW1wp3dqUGRpj/ebTv2Jsbd/3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3KO+bzCPOFIwJKhTGyhKH5D+Pi30J9T3dhnC0YM6kM=;
 b=TdWVqgGBQj5unmrHOOOM12qwXtauM9At8GPL6a7kLE6jtJ9t9yaFBjBBknhiafkyNItMeO8W23034yn3CXXQobEYEQhfpRyHQmm1JEj1zjtbXxh2NyDFA5sZ+pJ9c+OTRueawubeShqWn2t8mTFMgGvFJ3MncY4bd0M8hWXxirt7/R/k3k89sTj3bFHa/Nz4aBbvf5uYXpPBnA4PO1wA1ErWG77F+lydHSjxuFu4H1YvDaqrtyFqaSN16BUVf1RsPkLAHxmGMWl7/vOHlmeQx0mx/PZW6pftzZd5TkWuB/AGiRzx1YLCzAKkhzk/FzJQr1vdMbyYySFkqsdbomo5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3KO+bzCPOFIwJKhTGyhKH5D+Pi30J9T3dhnC0YM6kM=;
 b=Mtq07Y+a4j6j3YoPb/Afo5UijnBKpt5+iBF/b5ujwe0s8fx0YgY+h11/lfq5nHmQA22HVgaTwWzGljYJd9iv69bghg5XWIU9MtNgvYkyxYvMNlkOnpujHyJo2oazGtURU/1VGtUr4MPgoMgAruYfc/V/0qFUcodU3erjGL83HHI=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 14:42:31 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::91) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 14:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 14:42:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 09:42:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 09:42:27 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 09:42:26 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 2/2] sfc: add multipf support
Date: Fri, 21 Aug 2026 16:51:34 +0100
Message-ID: <20260821155134.260053-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|DS4PR12MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ff3f2c-86dd-45db-7364-08deff926e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UttzqizCZnh78o9eU0uFZd7FvKDPVT/vot+0jQCxfEI2ftNVgqrcmwwy4Wf30cQFJQ+iEvvhutxibPPLwPSSl3Tyl17b/HNjQ95QYDagMz3Rz5YGoxtyUnHsh1KOAGNlu9r4JK+6s7mBeb8x3NbhDJkH9nXfwjXStYxJLMogIBf+RMn6PP4rshNKq2WmEOGsUAdYI7KU/RcnJFw9mAgYsZvTSa/UVfl9gR2cYD3A4UifpfnVWxR+0Ay/Yh5ZgrTizz/2QHoJY/NKyD51W+lsHq2Dk+rgy2ypR/tVaeuqyS/qJMniaXDlRxM7JoV6QnUaxsFjiJP1Jeweh1OKuUFVSzGBdSAINALwI8wphbJBWRpx/ENQz/rNehDplMYwbXJ+PRnMgeU3VNAX8snMUSLCg/ZDpwVZfvA6Zy0RCPozNbl/ONWZXozLdEMGl0PfrEM/pD04sGcZh+RBpManG7KFZrK47sL2/KtQ5NS5hnxRbyBagCVPKCXE96t/2ZZbhMt+nKD1FXonv9VTR3iDXuRRwHpJdowxmWxbgRZpzLSboHSdmnStVenx7b0w425xnjK0DjKg9OqdwwshL9J34IGlEugkrNuhUZv6Zp7UFRFj7I59Q0dH4VXUXFaPd3djiThcqGmqVvIhjEDGTltym5BCVEPuTJANOkyXw6nRw9CF4Pla1gP7JG7dl6pG0YPWfw3jPcYlokdLvQG+21ZkKY5IUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bQ+97uaF242KX0QKIpsD9DSqASRGWZ95ZE7Ap0Q85osast+nUjjxYYKQK/ZSmURdYw1FMJE/F2miXmCBjvhT2RfEHRmeE4ck6MujfG3kYZYowyJ+3BHQ0g6BAp1IjAk1qLOEEa3zZ6I4fLHVnffh4hAEKnp7FwLcNcCcUQ0vhg9DLLAotqbSzYmjvWW3kyotSY0qenxG2kqK5ouyjNgQTaOluH6dnFQX4jGdWhNqAeG1QnFcopsueI+beh8GtbrGyjjlwfjxRyO5ccYpPZ/e/h7T2Q2swHjTXYj14CIXQhz+EvvGKeSwIyU41mckBL/eOPuhoeZGQRyB/qYfY4XRbzDZT67TISjGIHFXVuxXFzuyORaFa2O+v8RQocYmSErg9Bde+jMugBuQYSxFaJmMELt5zU/OmFei8WWp6vXJpdEUxqFBHLhNhR0geQF0BIF+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:42:30.9904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ff3f2c-86dd-45db-7364-08deff926e22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9612

From: Alejandro Lucero <alucerop@amd.com>

Use CXL core accelerator API for registering non-PF0 PFs to the memdev
linked to the PF0, along with its complementary unregister.

Adapt the ioremap call per PF to be an offset based on the PF function
index and a hardcoded per PF CXL.mem slot size.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 106 +++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 348d7404cd7a..e45c8dd1969c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -13,6 +13,48 @@
 #include "efx_cxl.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+#define EFX_CTPIO_BUFFER_PER_PF_SIZE	SZ_8M
+
+#define X4_PF_DEVICE_ID 0x0c03
+
+static struct pci_dev *get_pf0_pci_device(struct pci_dev *pfx)
+{
+	struct pci_dev *pf0_pci_dev;
+
+	while ((pf0_pci_dev = pci_get_device(PCI_VENDOR_ID_SOLARFLARE,
+					     X4_PF_DEVICE_ID, pf0_pci_dev))
+					     != NULL) {
+		/* With multiple X4 installed check against pci_slot as well. */
+		if (pf0_pci_dev->slot == pfx->slot &&
+		    PCI_FUNC(pf0_pci_dev->devfn) == 0)
+			break;
+	}
+	return pf0_pci_dev;
+}
+
+static int cxl_map(struct efx_probe_data *probe_data, struct efx_cxl *cxl,
+		   u64 devfn, struct range cxl_pio_range)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	u64 cxl_pio_pf_start;
+
+	cxl_pio_pf_start = cxl_pio_range.start + devfn *
+			   EFX_CTPIO_BUFFER_PER_PF_SIZE;
+
+	cxl->ctpio_cxl = ioremap_wc(cxl_pio_pf_start,
+				    EFX_CTPIO_BUFFER_PER_PF_SIZE);
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
+			&cxl_pio_range);
+		return -ENOMEM;
+	}
+
+	probe_data->cxl = cxl;
+	probe_data->cxl_pio_initialised = true;
+
+	return 0;
+}
 
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
@@ -20,9 +62,48 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct range cxl_pio_range;
 	struct efx_cxl *cxl;
+	u8 devfn;
 	u16 dvsec;
 	int rc;
 
+	if (efx->type->is_vf)
+		return 0;
+
+	/* are we PF0? */
+	devfn = PCI_FUNC(pci_dev->devfn);
+	if (devfn != 0) {
+		struct pci_dev *pf0_pci_dev;
+		struct cxl_memdev *cxlmd;
+
+		pf0_pci_dev = get_pf0_pci_device(pci_dev);
+
+		/* This should not happen! */
+		if (!pf0_pci_dev)
+			return 0;
+
+		/* Is the PF0 device configured with and using CXL? */
+		if (!pcie_is_cxl(pf0_pci_dev))
+			return 0;
+
+		cxlmd = cxl_get_pf0_memdev(&pf0_pci_dev->dev, &pci_dev->dev,
+					   devfn, &cxl_pio_range);
+
+		if (IS_ERR(cxlmd))
+			return -EPROBE_DEFER;
+
+		cxl = kzalloc_obj(struct cxl);
+		if (!cxl)
+			return -ENOMEM;
+
+		cxl->cxlmd = cxlmd;
+
+		if (!cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {
+			kfree(cxl);
+			return -ENOMEM;
+		}
+		return 0;
+	}
+
 	/* Is the device configured with and using CXL? */
 	if (!pcie_is_cxl(pci_dev))
 		return 0;
@@ -80,25 +161,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
-	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
-				    range_len(&cxl_pio_range));
-	if (!cxl->ctpio_cxl) {
+	if (!cxl_map(probe_data, cxl, 0, cxl_pio_range)) {
 		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
 			&cxl_pio_range);
 		return -ENOMEM;
 	}
 
-	probe_data->cxl_pio_initialised = true;
-	probe_data->cxl = cxl;
-
 	return 0;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	u8 devfn;
+
 	if (!probe_data->cxl)
 		return;
 
+	/* are we PF0? */
+	devfn = PCI_FUNC(pci_dev->devfn);
+	if (devfn != 0) {
+		struct pci_dev *pf0_pci_dev;
+
+		pf0_pci_dev = get_pf0_pci_device(pci_dev);
+
+		/* This should not happen! */
+		if (!pf0_pci_dev)
+			return;
+
+		cxl_put_pf0_memdev(&pf0_pci_dev->dev, &pci_dev->dev, devfn);
+	}
+
 	iounmap(probe_data->cxl->ctpio_cxl);
 }
 
-- 
2.34.1

