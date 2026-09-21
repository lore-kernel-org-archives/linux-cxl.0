Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558734F053B;
	Mon, 21 Sep 2026 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013369; cv=fail; b=nj1oqB6QcHy0ftrh0V5Jclq/b73E+uDJ9CKiGms1V8Ytozx1V/YtYGZ1AKq0vCcaqIGE8FUcytfxfud6oviwbomxKjGFYWTqIn2fjcddsHAZOQJkoaWlT0JGb/q+G3dEIcPyVyeseVpg6p6AiyPzBcQ/0fNtuLWDudPpZdXbV3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013369; c=relaxed/simple;
	bh=Cecz97LfMK9RxqyjIMMLW1ZVIKoaLkz3HlOhpodC9yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECjWQBr04D7AGjqoZOwB6YkM7iqpMK9s2NQUFm7k8CbdARR6prhksxtg3nh78Pwxc+O1aD1tNOShneRDAHxqQ+fpVlog863Qm3oQVA+XcgWKamPQtQrdSH5sGYb0sdFcjeJuo3GRumO4fsvhuCU5mQQIc1cS2KTRpV09LFfGJbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FazYQ+BV; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FazYQ+BV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkbb61WIK0Pf7USkUKxa42kWg1KKfzuAAxTFPzykE/CB6LAP1gUW/G+P6X5VSJ/iDXRPapPzDPZ4dYaFn3JvwsBOafmPAN4dkc5yxoXwJTbT+WATe8+kCQFyrmLs20mBjLvo0mPoIfmyWj7/8CCDz6C4ci4zmR3GY30TpCaE5Ui04JQoLwOAbY/kWfTjsge8i3AZNDgjfhLZaTWkGtyv3qC+USy5NnoUnnY/xR4W4sH47tztF1e3C9ktiGBfSTdBkHhVTQz6qJzUq0n/XKbrs7AI4PQoi9U6DqKGduDxwjKs3R9BdACyw9YkIZ0ugVOxei188b5xReJUQDCe/fgqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfQ45X4PR4nPUE/0o2AzaOBQks4oQT8z4P4UtN3USs8=;
 b=aQaFYZ6ER7dYxeOr6DVxHq1f7Brp6+XgkX2Q+eV1eerE2xMLvnJhOOrA4o5HXEcdEmFOahg+x8ZsJMxxxGQKzQ4i8ZNX+r4xUJuvIisTHetiLtnfuGZFiod44PFlfwR4cyJrZ23bdDkKl5v3dDA9mfA680NcAV1JeQ3emuWGb7O9l7XfOdd9CeKHQXzPKRtr5D/19pBUGl2YEMEEWS0259V8LDSOrmRcFzJQykPznLblOD70JUZd2ihAjv6Jg0tb88arNUwk8cKJAxY2sWrPaSeS1Sqswo5MoxEF82sKDy3ndrLLPo29zlyHFudhmFW3Ru4EKTHg6+8WOXKrx5wKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfQ45X4PR4nPUE/0o2AzaOBQks4oQT8z4P4UtN3USs8=;
 b=FazYQ+BV/q9X86WXfSZQI44d2K/fCknVVR098FsNOguNyvwREdR17mg4z2PTde4IOp94NmOvupqMo50i0Xdm7mANc4RmAjNcA4frkeyVOk5x0Keixmqhmc7SSNNk/gTytVP/6Z/KSGAuwkKdTY0YUzjniGL2mn45RGpBwZgaGlY=
Received: from PH7P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::34)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:55:57 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::99) by PH7P223CA0003.outlook.office365.com
 (2603:10b6:510:338::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Mon,
 21 Sep 2026 17:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:55:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:56 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 21 Sep 2026 12:55:55 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 4/4] sfc: add multipf support
Date: Mon, 21 Sep 2026 20:12:39 +0100
Message-ID: <20260921191239.4249-5-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921191239.4249-1-alucerop@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 20916540-ba01-4215-24c0-08df1809968e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uw4MWgRWgKlVGbLOM7tr1KAx65gr+FRRaXFGVkqTpeyBPdWysGKc2VICws4lZHktUJ+HjA86pA9VaustfSBWbTNGKaStliG+uoVW9YOVQVWOQMjmf/gFUOE2/mgTzQLK5UpFyjs8eaz0aKcFF2qil3ZrxysLsM5XEn+q8d4Dk2FIHhFqdJ0hutUP8h6gzcmmFHutGECDVYW/MSKdO1avKxQ9X004Uz8izotTd+QCn8ur/19uQMC/urui5tnR5syIB+bUMcP9u7Gs3iAEJ62RHnBNotaa1dkQ32NrL8GgX0WT1CRCh2KvBvUaWnF77NYFxhlzKf6QH/oiOz8ePN6G5vn0NBujA0VctnskJ4hSuX9GwW4yYwbpyFP7kVoF8LuvsJixLqqGK9X0vcO1bkK2dSi3miA+2YngdmKnX9dNzbsrvRZ/c4DixPvp9VqD030cIOHAAriOkzg30tmgCIgOUWGcoNamN3RfSr8uZpKLxwqxXJPZmWntb39cYbONT5BaxiRO3RTlQ8RuDZEF7H7J/DymHqAgATWEgyHYAne6VQ0vnN70pkY0rNxmfZqDkKQwOlcBZAW8aYUZRxUO0wzeUgX9mptPLPfkwUUv2ax9ERRaR3DrBKLGUjOyF43VlLh//eslFd/UNxjGvIfl/0y7BMvyUJd73JrUB2NivyrbdXQAvsgida3DbsZlrF9xIlTPogP9nCyCAv4ul2AGT9vdRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1bc6naaw9fr5d7OxA313BF/FhVw85dhuBNRlgEWdX2DGwuMkbrwNyMYKsm7hhH14IG905quJo96Y7EebP2rHReIhP2JPtDCfAm76gK7PqBBxepfabh8LJ711os+GYoD1VGZCZwfJfoTwzfuKDL9a/hJE7D2klMG/HZ0IO/iaS3JEuT/ZMnw3AfHewA61c3qQsVv7XY3NJYZ2wKNVnYk0MdUW9LgXayOQCzrwnOqKmmUX391u9IW8h29Zs+4IIZtV3vzSlxmD6H4BPXgn6dJrEmEyijXRq6FBZid+JDPl1XuwZWfs5ZjYlPorGI0e6TGe7C0PT2gMNJ6douVI9U7hRKoVcH9lNOGlxx73Gvt/aSaIcnv3fOgIMURjPrzeKQvqnl+5rSfpO/dNaNcETci2ROc07ehvWQ8MyduBkrKhvhzPbjYU5pQuNEqfxRYwEih5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:55:56.8830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20916540-ba01-4215-24c0-08df1809968e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385

From: Alejandro Lucero <alucerop@amd.com>

Use CXL core accelerator API for registering non-PF0 PFs to the memdev
linked to the PF0, along with its complementary unregister.

Adapt the ioremap call per PF to be an offset based on the PF function
index and a hardcoded per PF CXL.mem slot size.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 75 ++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 348d7404cd7a..bed8d9c59185 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -13,6 +13,31 @@
 #include "efx_cxl.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+#define EFX_CTPIO_BUFFER_PER_PF_SIZE	SZ_8M
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
@@ -21,8 +46,48 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct range cxl_pio_range;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	u8 devfn;
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
+		pf0_pci_dev = pci_get_slot(pci_dev->bus,
+					   PCI_DEVFN(PCI_SLOT(pci_dev->devfn),
+						     0));
+		/* This should not happen! */
+		if (!pf0_pci_dev)
+			return 0;
+
+		/* Is the PF0 device configured with and using CXL? */
+		if (!pcie_is_cxl(pf0_pci_dev))
+			return 0;
+
+		cxlmd = cxl_get_pf0_memdev(&pf0_pci_dev->dev, &pci_dev->dev,
+					   &cxl_pio_range);
+
+		if (IS_ERR(cxlmd))
+			return -EPROBE_DEFER;
+
+		cxl = kzalloc_obj(*cxl, GFP_KERNEL);
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
@@ -80,16 +145,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
-	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
-				    range_len(&cxl_pio_range));
-	if (!cxl->ctpio_cxl) {
-		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
-			&cxl_pio_range);
+	if (!cxl_map(probe_data, cxl, 0, cxl_pio_range))
 		return -ENOMEM;
-	}
-
-	probe_data->cxl_pio_initialised = true;
-	probe_data->cxl = cxl;
 
 	return 0;
 }
-- 
2.34.1

