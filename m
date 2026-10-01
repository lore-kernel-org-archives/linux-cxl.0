Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7A4BF95D;
	Thu,  1 Oct 2026 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856126; cv=fail; b=ZiCuvUYO3Ykni5CpUyGbn3/fO70OD4sTEkVjCPxupTjNYXS2PL/eWBPzqAKBXuEhwusoR7GFxJ1YJybc3IPXcSy2gYGoUgJr7QAWteATTrmusPb1wu5EiVPeTupRlXCUTGkTatdsMhoHrCquvMT0MhE2TWrNbwkmzJbKKOxiUls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856126; c=relaxed/simple;
	bh=u8ES1OJtNHcCB1z3H33MuwTatsDtJ68KJ11/QJLRni4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDhi5AttGNkEHnPwit+P46DvR6jpO+zCa+gWHZKpBB6pP4Bi5S/9VESUD5DEiCq6nB7prd3EUmT4WJCCtuINism+ftU724JOWxwzxU6Z1o7f8IV/j+pDWX8wkEzy9xL3EBkdNoR33R2OLmM7aMF2b+Cr1SauMUiZKUwBwqrjwEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oKMQvg7x; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oKMQvg7x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGJhdGTPO1prNnVNDELgH3l9gjzLbaX2918AEGWp9TKgSijw05a2pS9948hog79b+0oK4zCt8B0TYtjXQxTy5NMgX/ZOFhCWQZBmF2U+zN2BCHz9Ixg3JDcomZ9Ilq9vOdgHC4mMOBl1as8QztldWzEM1CG8bQfAq6hXsnt1AFlNIB+u82/y5md2gm8qBoWCQzyNxF301htdtDsqJLZs2x9oLPoBzQJ8BEiwlJV4HhDUmduCoWoZWwrUJLkDJfplwbr/ld46XiFMgpXmurfOl23hiEJZHTfzz1PThxGdgs8rkEtwFxLiHvrzBRDJkpnJJOXfEknowKVsrs5oFCfr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8z4gVZwvqgSisSrczj34lQlGcwdfF4bvrKb1tRk6P8=;
 b=D4eNDYKh7sfkPmU+ScQ4uuQkhduOSmAbm4ZIjMDRUFB0vcXiFafODj33te6PZyU6AQ/fy/RblDIrKZiiVkY2VqJoiPTPbbNdBhsUZ8w/1CgwPoDMLFTGdBZ2ZfmfqiNpVaw7fA24B21mG8Vu9Rz9i2bfo3ETZZyt7bM3Tgs2nH+udxk+sVYXeCxhDNY1Fte5/F4UTxnEmVlXIiGZWVkxaeUV4bCrlrUsG4ggi0CRUTf6ftSTWca/aG9CVKr6WkatBxSQ7ggOhKw71WHMDajb48//pkpaQz4RKLGcTnH3V5JRY9AhoOn9CDxi/61rY/AkuPncmisyAnUgPFmC1baTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8z4gVZwvqgSisSrczj34lQlGcwdfF4bvrKb1tRk6P8=;
 b=oKMQvg7xhbKEW4jdVlP/Hw2eF/yd8+xNmPZ49GFnbxSHe5PPDVTpVQEKQrDLSRzSdUoX7Ba+1x61Sm0mxkBrPloNAdfwVMIMeTvhpJT4/bilqGHsA4FwuFfWSZeqdCXgeFWkJ7XVO/CdWjP/mi8GCk0JkLuIn4MeK0hiwDRg5EY=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 12:02:00 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::81) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 12:02:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 12:02:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:24 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 07:01:22 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 4/4]  sfc: add multipf support
Date: Thu, 1 Oct 2026 14:20:23 +0100
Message-ID: <20261001132023.17032-5-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001132023.17032-1-alucerop@amd.com>
References: <20261001132023.17032-1-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 53893a32-9ee8-4ad4-74b2-08df1fb3cc93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YFtqJWxtAYYr7nRe5968yYKOCAUHaFXgtbDHqQ9eJC3uMmzBBo4QOiwIPAWhrvEMQD91oZCE1I49oUxcpEz2Bh0BjT3UY8Q4ZyCA3F30bP2124v4tYD/qw6DGsKPsDu6p2NcJDmLZu9BowdAli0GwuZ2ddZzBdXkiKJX01OcEBBQZiAr2/1cqjdhLF1/QFVHFq26l7yEG05Fe5zbfCUiwKz3x1h7O6ZZKz9YxEbFqx4IEUY2474Sqqc0aqgb8L8fR0Dp2a/1Tr777Cjk4jphfSqmqj++hby4qTpHsgOy+lfryHH85ropzyJ8N/j7T9KTCfuAJB4i2/xvK2Ij9KI05DAD4XUKXqUe132S6BlaRV0sBpBRh3HkqAzbw0XRLEzMtCHNpBa9gOc/A4z1M7lIjRdpWP6ttUxkDKTyP+yUUzPdFv2XkPJ/S65qnizH43g++IxAWEzQSP1MViSbHA7cvhQGoExFyLNzTZF9NjmkwKevP0/hvcVGJ+0ydyg37R04gI54PWt1vTHcmHB030uM18PgRn1axmOmJFQBnAg1YXi8Jq0yBK4WNRaqdXe2NMJv0AwkTazCJOiqTfr1sh4WRydg0pXvNslgjqfvhCwh4f7GhjLIztl8i35AI7jiHAxDGkgo2P3K6HvhH1YNT5adE6MJp7pVOFAIRmwuNWKs9sZ87j60YmJKdqVv7CzHeCwbIFPVNHMtvhTKvZ0YsH6/Uw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E6Mxb6iecH7q1zdkNC1hpiLi4fqWNc8LznPxAExKaxpIgvjN/f0wtcfO5R8sIbkFhZW5nM8supXRsdLIYelpN5Xh6jxWxKwB8Q6gZdSVRlazU02gUTiHeuYVd9tUgnnxVjTGimuIUxMannnA5RxdLHKlcgyB6ov+Zx0icTcFHyj5HhQW+IsjiGSPiAl+NNB6F7paAz/8fQ4MEdXybay0jBm9cUIW+D2ncCihqRfheBcVxWqrCwOygDznSTa/2Eky6NWu07JuI0G0HnrnTmU0RCJGSR5MpVtJYjqvqL6a9tyJMutNRe+iysDk1xlOJ+bpKxccVeUpM7vJK7Av1hWGhwtdo6eG1D95y7Po0FQ282qfDIyppsPIT9pIXgvN6dYpHYHvBC9+IL304NbN8HeG1Pof+o7i90vBmcyR9GPZe/QJUEthPbHX7A2pgwQBCjiX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:02:00.0639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53893a32-9ee8-4ad4-74b2-08df1fb3cc93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144

From: Alejandro Lucero <alucerop@amd.com>

Use CXL core accelerator API for linking a non-PF0 PF to the CXL region
its related PF0 CXL memdev is attached to, allowing non-PF0 PF release if
such a CXL region is released itself. This can occur in different
scenarios like PF0 release or CXL memdev release.

Obtain the CXL HPA region to work with and the ioremap based on such
HPA and an offset based on the PF index.

Refactor CXL initialization with different code paths for PF0 and non
PF0 PFs.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 100 ++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 348d7404cd7a..f884580cb528 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -13,8 +13,69 @@
 #include "efx_cxl.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+#define EFX_CTPIO_BUFFER_PER_PF_SIZE	SZ_8M
 
-int efx_cxl_init(struct efx_probe_data *probe_data)
+static int cxl_map(struct efx_probe_data *probe_data, struct efx_cxl *cxl,
+		   u64 devfn, struct range cxl_pio_range)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	u64 cxl_pio_pf_start;
+
+	cxl_pio_pf_start = cxl_pio_range.start +
+			   devfn * EFX_CTPIO_BUFFER_PER_PF_SIZE;
+
+	cxl->ctpio_cxl = ioremap_wc(cxl_pio_pf_start,
+				    EFX_CTPIO_BUFFER_PER_PF_SIZE);
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
+			&cxl_pio_range);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int efx_cxl_non_pf0_init(struct efx_probe_data *probe_data)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct range cxl_pio_range;
+	struct efx_cxl *cxl;
+	u64 devfn;
+
+	devfn = PCI_FUNC(pci_dev->devfn);
+
+	struct pci_dev *pf0_pci_dev __free(pci_dev_put) =
+		pci_get_slot(pci_dev->bus, PCI_DEVFN(PCI_SLOT(devfn), 0));
+
+	/* This should not happen! */
+	if (!pf0_pci_dev)
+		return 0;
+
+	/* Is the PF0 device configured with and using CXL? */
+	if (!pcie_is_cxl(pf0_pci_dev))
+		return 0;
+
+	if (!cxl_get_range_and_link(&pf0_pci_dev->dev, &pci_dev->dev,
+				    &cxl_pio_range))
+		return  -EPROBE_DEFER;
+
+	cxl = kzalloc_obj(*cxl, GFP_KERNEL);
+	if (!cxl)
+		return -ENOMEM;
+
+	if (cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {
+		kfree(cxl);
+		return -ENOMEM;
+	}
+
+	probe_data->cxl = cxl;
+	probe_data->cxl_pio_initialised = true;
+
+	return 0;
+}
+
+static int efx_cxl_pf0_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
@@ -80,26 +141,47 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
-	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
-				    range_len(&cxl_pio_range));
-	if (!cxl->ctpio_cxl) {
-		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
-			&cxl_pio_range);
+	if (cxl_map(probe_data, cxl, 0, cxl_pio_range))
 		return -ENOMEM;
-	}
 
-	probe_data->cxl_pio_initialised = true;
 	probe_data->cxl = cxl;
-
+	probe_data->cxl_pio_initialised = true;
 	return 0;
 }
 
+int efx_cxl_init(struct efx_probe_data *probe_data)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	u8 devfn;
+
+	if (efx->type->is_vf)
+		return 0;
+
+	/* are we PF0? */
+	devfn = PCI_FUNC(pci_dev->devfn);
+	if (devfn == 0)
+		return efx_cxl_pf0_init(probe_data);
+	else
+		return efx_cxl_non_pf0_init(probe_data);
+}
+
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	u8 devfn;
+
 	if (!probe_data->cxl)
 		return;
 
 	iounmap(probe_data->cxl->ctpio_cxl);
+
+	devfn = PCI_FUNC(pci_dev->devfn);
+	if (devfn == 0)
+		return;
+
+	kfree(probe_data->cxl);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1

