Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21A1A0BF3
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829042; cv=fail; b=eKHqnswAV+oXH7noLdkQ3T6fppnk66OlTspZgPUs4Vr2QSOsyZbrt1GSK+G3KfowYbtPiF0b4GFKWndwTwev71b8XwiXqqwzYLlhCXPFc9pygLypMRwiavw/1xnGdXidS4FaBIEhJcqWJM3YrhJTW2bj6+jxOj59W4uW7R3qh/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829042; c=relaxed/simple;
	bh=MrE0T8/LLOAWq8xMfN1hwPJaoveMMUOgbFq046uE9Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+B3AY3FTFDSEfkwOasoP997v/lxW7pTc1um+FWGRJrOuaS+y+Kkt2hKoLkk6sZxCqejTJgTn66XooV9ZeQuHtsmiIakmdujo/97m3r3CbTcm9CLBWjUR5k9BTxpClTrkopbkpSBuGkByk/sZRr136JgEPAvxBBkUurcWGOprbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KOa+OS2S; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KOa+OS2S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmcGrntvDpC5HLfJ7NUyrgPTkMoIJ4tAlLxX4yQTRSKttXDQYlnaR8Xg767AYD4JSx2r8RpfbR3cXBhCwB5OFbFf1JgoN9rh2jvoBUAFJOKVCZrmoLaaNHE8aPnb4Th4uEuEH7hJaVFHxroGjR6GtjFbHAkxecdyeqyshfACSft2YzPSxUrAdAQI1NUmLObJFbTgLUl6vzRDaQhY4yN35aH9u4yuHr0lUQsF8UppQoRwBYrWDjGD6cnje46EKmn7JE2gRMhJA+tIy4O2R5Oi6R7QdaAILTyF6ImMnd0o8QVn9fMhD3svXuuiSGkjzhqSrDLfRp568S0WQoGBAHjrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe6vbR5a9FdMKZGDKM6K0e3IUYubzLRAxcZEPhNq44M=;
 b=Be7EMOjgzokbw0MCbhtQIXOdvONmI8kfv5tJEYEnhyuGuPgOzbP5zmo7wMW1RsBdJQU193CvqKvKXuOz8R+uxUE+YpL9Uf0wD+unvue1smgoXMZcPC06CXx3V6fvIXbCGueqQKKcWjL8lk89RByR6OaqlnBMCaYzlFW0qRHTTNfUZrJ4hk8h9up3eE+E7atbP/vRcFEA8/cn1GUxwwHPfe/Fn4Qm7fMtgZ3hyzSNore1Vjy8mPbfSbq/Yq4WNHakbjIIbKHdx/Xvkl4vaZWK2y/9l8GFQNYPx6k+EXAlPY5CA8tJf10bn2f6ROOt54Id5wWnU3gByoSWPXUvkBv+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe6vbR5a9FdMKZGDKM6K0e3IUYubzLRAxcZEPhNq44M=;
 b=KOa+OS2SUO/JKRtSIKb4UlsEw/i0reQoPTuhBei1Zm2s08OktbmmelnoLNbvTrGs+HLr1TtYIepE9np1frppfujZ40mt1qcVXetQEFtFu/UmyjEgw1P3+sbdp4rwsW1+1mOIIpxRmIkB3MIbAgMDGmqYu7gaE0alu3G9GCc7Ufk=
Received: from SA9PR03CA0022.namprd03.prod.outlook.com (2603:10b6:806:20::27)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 14:17:15 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::93) by SA9PR03CA0022.outlook.office365.com
 (2603:10b6:806:20::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 14:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 14:17:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 09:17:14 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 30 Jun 2026 09:17:13 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>,
	<kuba@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v31 4/5] sfc: obtain and map cxl range using devm_cxl_probe_mem
Date: Tue, 30 Jun 2026 16:13:45 +0100
Message-ID: <20260630151346.31201-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
References: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3dca60-4bd7-48b4-098a-08ded6b24946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|11063799006|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PmSEE1xLewCWTn8YcsU2HzG5I0wvk7ZiW7qhvQC/5bHF1pH1EmP3E/ALxTxEBPP/ezqdUAweIdCIRjZ3Mw9Vl6TkAzxmP7j9JahnLfTy/NI0g/jdgkrWw1Y7SQ8kg9SR9aLYqeLAf44AAKANlvILdPP6TqAdBdCJXXMd+H/fEb4tcbBQZCPwu3Ocn1IJGxZ0wrWUXBn1WstRxcs5aE1YfK4f8N600QbYWUiiMZmnvwj1gvyIJ/tElN0cKRb+ac0AKNfs/OxkqO8B9LeUqEUJQdwX06P5cbFc5Zs+lo4xIPjaILA9v+avMLlgb8vj6Uwrw0JLsGLzeZoELaFH84h8DarpF8XiAxOM6scKxccELgRXxuJLxjplQmen4v5r402S1ahTjqzuZIZoRlMUoxxnIxOZtJEnsqjz0zImeG/jx5uSN9el4lKNCvKHa+sb2vIFvOrC/rs5zUHa8l8X1X/BVQmwLMygIV68VuBNrqcHhRB2lsiXXbyh6TbkgJ8+n91jff+/eQ5A7C8lzmHIA/Sez5qHWbHELVUvlZ1F1GMWCBq8oA5L+6PYy9B3PtLOwfmiLR6gRCytxWZBdTDUqK6qEKKaAHieTnKnEO35XGRpUrLvYE3PkOd37+Sp2fLak50eQ5qi6ubsCo6u0OLF9m43J4a6WGZxcEcvCZn8GwnkdNCRaPAStl38K/9GAwy6/n4Gr+EKK9LMVpf2KG4BqAzexw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(11063799006)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EzKyFZzTcTHspJnhtlYpf9OjNhOLVaq/8mBs2NA4RE3+f4lrbKK0J6p1jZ0PKccA3o0oAflb5jl6zwPSblnXToI4CSXzYmKezkgI91c1zY8PXtzMdfkLPJDai7KVPte1PTMSGDs8IQzsIYK6wGiqxczeeJMk3kckyEmYQZNrlfY5qHH8NKZEFlwP8P2d0TjGbiajNo3KHpua/TbQhOhTLZfXuYCOAqVqb/2GozY3J7depFDC71puisEKUTSsrMrKhBh7AMiqO7VThg6Ezm9oPWyq1TZJm47ib9M8Z0yzUJ+h/ir+yB6xqQ9WkCxuUHfXjgTva6xkIDT2ItymKVSnwplPFLLr/f5x9NdbUaA2yt4I4ort3dKdXe8HKc5YvS1NYwPk1+Q+AXQNGEwv6n0RtghfiqTVBVKAsd+QKbx9DhPJIj9mAtqDXNxcSiQxM9Eu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:17:15.4404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3dca60-4bd7-48b4-098a-08ded6b24946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595

From: Alejandro Lucero <alucerop@amd.com>

Use core API for safely obtain the CXL range linked to an HDM committed
by the BIOS. Map such a range for being used as the ctpio buffer.

A potential user space action through sysfs unbinding or core cxl
modules remove will trigger sfc driver device detachment, with that case
not racing with this mapping as this is done during driver probe and
therefore protected with device lock against those user space actions.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c     |  2 ++
 drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 61cbb6cfc360..3806cd3dd7f4 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_fini_io(efx);
 
 	probe_data = container_of(efx, struct efx_probe_data, efx);
+	efx_cxl_exit(probe_data);
 
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
@@ -1242,6 +1243,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	return 0;
 
  fail3:
+	efx_cxl_exit(probe_data);
 	efx_fini_io(efx);
  fail2:
 	efx_fini_struct(efx);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 18b535b3ea40..3e7c950f83e9 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	struct range cxl_pio_range;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed\n");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
+	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
+				    range_len(&cxl_pio_range));
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
+			&cxl_pio_range);
+		return -ENOMEM;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 }
 
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+	if (!probe_data->cxl)
+		return;
+
+	iounmap(probe_data->cxl->ctpio_cxl);
+}
+
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
index 04e46278464d..3e2705cb063f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.h
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -20,10 +20,13 @@ struct efx_probe_data;
 struct efx_cxl {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
+	void __iomem *ctpio_cxl;
 };
 
 int efx_cxl_init(struct efx_probe_data *probe_data);
+void efx_cxl_exit(struct efx_probe_data *probe_data);
 #else
 static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
 #endif
 #endif
-- 
2.34.1

