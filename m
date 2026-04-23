Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D735AC33
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965164; cv=fail; b=YD+awqNsH/0taYwnBZ7fkBlNfBwM5N3DOYsTdRcCmx31CQqxEUpIHnPnz+hTlNW4XeBOs2NqN2kJKOBpF5MYbktsNLb8odS517wU2eVlMEKFsPm80OR+FdQi/dHny62ULpRlHoobCOSTzvjrN2HZ8BRJFw4wNMTjwTwgPN5xR/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965164; c=relaxed/simple;
	bh=ssLN3/YggVSq5NOhv1e0ekoyrhqROvfYkrj9elAO9+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxQYu3sMwr4fGgQP++JK8OpW/7RsK1sdDaKoFlmshsRCIUETefXX0ohx2RMHzMDRWm05j5wDgVauc3eJld1Oa4wyybyGpv4Vie0hk1JgzxJw5rSOXbfpDJGcQHjJJw0Kcx2WEx7ATG3gvftTUVJpTg/jPrq5wgMxDh01J3a2RBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xMX0wHx3; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xMX0wHx3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn9w/KCXgv1+QVDJ8EGUd1o6zAKVbMrmpmhu8oHLonesLK67YjAlYku4TkMjGods4mIhdniDq5e8U8uSO/vv1HZEqmFwIz2Ligxn3dC0jCnf3nQyhBI4rs92x2gfbtvh5QdOY02ddcZpjU5gC1jMDGkceX/oqtWvmeV1yqKFyheftm3mT4PzZzuoAUpzbEOlEsFXca+Hy/ko5D0RQ4xXfwJ/BgHk9elwYnTv0WGw0O6hYQdXR3ifppenMM5IVMtV39P4zMGMaQ+EOzRh9TUnj8aSUjP6ChY5pEScz9UsJLkhAIi9D1yfPRZa8o3Iiq8WLfeejY/mscMMd8AN0KBS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9jKfCmCiUeKOTiOPIrZoRyb90UPEeMtbm7dl1TruYw=;
 b=g3qLEogfhvZJvgtb5jo7Sfhj8xbMJd/ZzG7YWQ2XVs3BTRD4+j3hekdZDwrsUemgOpbu8detitimX8h1dZanCP3ztajGWoYwg1QuXzeBAWGyf+jYYiO6Xov9jgbNTtQSlqGkRpRMuGddKAIw9AUbZEU4nXqUXHyfkGlTynli2CCJaiO9BFnmcpEs/LT2QpJGioboe4Y4QG67Bs6wvOcFragl9l9M60DljFMt1s6cIW9FXklU1bqywOi9fUMKAw8t1FkT0Tk3ozm4U9mAqd8fAsXfPw6OfD4B3OtJqH/HzjND+XzKctGO+RXBUyjKwdI6Geog1asIF85ESoJDzyUVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9jKfCmCiUeKOTiOPIrZoRyb90UPEeMtbm7dl1TruYw=;
 b=xMX0wHx3SnwPeBihhi5yxonIYKuEupalZwgC6zVxyBGhGk6UHhXLBqhOozhajkh5lc55QFeq80+mAPDIayQK78NfpME7TxTxMI5klLsycE9KaNDjeRfpOrzqVhkDR/nlJLEEa2nXiDxzR+liM8so6bK8dpJB/pWDhMRBEPVSuus=
Received: from BN1PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:e1::22)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 17:25:57 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::b7) by BN1PR12CA0017.outlook.office365.com
 (2603:10b6:408:e1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 17:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:25:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:37 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 12:25:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v26 8/8] sfc: support pio mapping based on cxl
Date: Thu, 23 Apr 2026 19:05:28 +0100
Message-ID: <20260423180528.17166-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 64239b15-1a86-4adc-91c2-08dea15d6150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ujs60VTsmIZKw5OxAzALs8l6YuI6vXCeKP9WHSnudGivJnrKgE7i4Hjebnra+U+uELOuK2kGaJw9v0+OiUpZLpYF2RpbqexvIq7zfHv2WyQlHc6x4HMei9NTc5DO7eXaLRFYn3iLmhU0/yCEA0/NTfpjXSstx6+67UP78nVoEULUyE7dqBtBUIAzKLl74atS6Caa2bnEEqaSozlipoaL0BmLvSO3wS111MDpWf7eYEen/k89v3684eDmajKg0oN75hoqhHat/byI5XnEc01VzgAHwy6TGcVxO9HQczaAj00fbwtFJ21hWXdxIvdlqi6jvm497nnUr6Kt3KZ/RlaBtVvub/3FzcXwzAXQHbir6dtt34eYKqzi6c0vobxqQ9H3lD/T82ZY8BVWAVSlqmnMF1K6qZxgsEpgoaxNdwMRclQb3iihHrJsIhLA1dNAL6BXqeCPu5FlaZSaOVn22Rz6jNbqg4Gq12guaDNoOjHDq/Z7kc2Ntv5GfkyfRTm0SRnTkPl9CZgpm88kxj2ltsaTlCFyWSCm8322hu3VmrD51M5VJftg84DDgGVJBhdnguNVnHh9e/WxUWxush7ZiAlBf9QKvYvikshl1amM/S10sZRHqUNNM2Voae+ELNzftpMKzElQ+3MZjnzxLzmZesKM4t/jv5wLXiodh8JzfIKlSBqXO/FPrFT0ZkMq6QICeDrrm3Vg7suIHQP7vOeFJ4QgL3GmEoTQMpkbAXLnBQOmppUgmDqItj/tUhFyVEQi1fE7DptGzUbZgz5yg7O/Jrwpzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	waqdOampUeo/pVHWWlbjChbkTDSZugshSj4h5YrMcw4m+mBdR8Bll4iEkyHjNo8JBbpsy5thdktFbPYGp9yCZFU6Tpek68ZxUbKSJYVRnQRGZiy2CFb0d72CqMCLN8Aq8jbSHoVkfVQfpIwOf5XKPJho+mxsBjez3uykrWKbT6c1crb7kB87gpYvvoE1XcydOFwnrkuO9yS8lF3taByVSvl7p3DrwvVQoUyXoAln1mtsPCbebQ3yM4NqfKxzrSts6hjh6PPhsv/sAj/hKM7WzMRBP8wezdOobyOOBBOWzeowwHmod+DX7Ph0PXEbloccxJNsxXSkM1Kwe8j9RfIyNPsp98jRacCKVfigJufjWbyPd+/tpWLY8azUw5wFuTRl1fss2pQW11j26aZhpBQXizmwNV/NsgSzAnoWFWi95GvEy4+S0EtgVBErUf3ZA6oB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:25:56.9463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64239b15-1a86-4adc-91c2-08dea15d6150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

From: Alejandro Lucero <alucerop@amd.com>

A PIO buffer is a region of device memory to which the driver can write a
packet for TX, with the device handling the transmit doorbell without
requiring a DMA for getting the packet data, which helps reducing latency
in certain exchanges. With CXL mem protocol this latency can be lowered
further.

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Add the disabling of those CXL-based PIO buffers if the callback for
potential cxl endpoint removal by the CXL core happens.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 72 ++++++++++++++++++++++++---
 drivers/net/ethernet/sfc/efx.h        |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c    |  2 +
 drivers/net/ethernet/sfc/net_driver.h |  2 +
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 5 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7e04f115bbaa..be9bd8d5aec9 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -24,6 +24,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <net/udp_tunnel.h>
+#include "efx_cxl.h"
 
 /* Hardware control for EF10 architecture including 'Huntington'. */
 
@@ -106,7 +107,7 @@ static int efx_ef10_get_vf_index(struct efx_nic *efx)
 
 static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 {
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V7_OUT_LEN);
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	size_t outlen;
 	int rc;
@@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 			  efx->num_mac_stats);
 	}
 
+	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
+		nic_data->datapath_caps3 = 0;
+	else
+		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
+						      GET_CAPABILITIES_V7_OUT_FLAGS3);
+
 	return 0;
 }
 
@@ -771,6 +778,35 @@ static int efx_ef10_alloc_piobufs(struct efx_nic *efx, unsigned int n)
 	return rc;
 }
 
+#ifdef CONFIG_SFC_CXL
+/* Invoked from cxl core when a cxl region is removed. This is expected at
+ * driver exit linked to cxl core devm releases which does not require the
+ * below sync.
+ *
+ * However, it is required when user space actions triggger such a cxl region
+ * removal forcing any cxl piobuf usage to stop. Setting per tx queue piobuf
+ * to NULL is safe if such a tx queue is not currently in use inside
+ * efx_hard_start_xmit() implying tx_queue locked.
+ *
+ * After this the cxl region physical range can be safely unmap.
+ */
+void efx_ef10_disable_piobufs(struct efx_nic *efx)
+{
+	struct efx_tx_queue *tx_queue;
+	struct efx_channel *channel;
+
+	local_bh_disable();
+	efx_for_each_channel(channel, efx)
+		efx_for_each_channel_tx_queue(tx_queue, channel) {
+			HARD_TX_LOCK(efx->net_dev, tx_queue->core_txq,
+				     smp_processor_id());
+			tx_queue->piobuf = NULL;
+			HARD_TX_UNLOCK(efx->net_dev, tx_queue->core_txq);
+		}
+	local_bh_enable();
+}
+#endif
+
 static int efx_ef10_link_piobufs(struct efx_nic *efx)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
@@ -1140,6 +1176,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	unsigned int channel_vis, pio_write_vi_base, max_vis;
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	unsigned int uc_mem_map_size, wc_mem_map_size;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	void __iomem *membase;
 	int rc;
 
@@ -1263,8 +1302,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	iounmap(efx->membase);
 	efx->membase = membase;
 
-	/* Set up the WC mapping if needed */
-	if (wc_mem_map_size) {
+	if (!wc_mem_map_size)
+		goto skip_pio;
+
+	/* Set up the WC mapping */
+
+#ifdef CONFIG_SFC_CXL
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	if ((nic_data->datapath_caps3 &
+	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
+	    probe_data->cxl_pio_initialised) {
+		/* Using PIO through CXL mapping */
+		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl;
+		nic_data->pio_write_vi_base = pio_write_vi_base;
+
+		probe_data->cxl_pio_in_use = true;
+	} else
+#endif
+	{
+		/* Using legacy PIO BAR mapping */
 		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
 						  uc_mem_map_size,
 						  wc_mem_map_size);
@@ -1279,12 +1335,14 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 			nic_data->wc_membase +
 			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
 			 uc_mem_map_size);
-
-		rc = efx_ef10_link_piobufs(efx);
-		if (rc)
-			efx_ef10_free_piobufs(efx);
 	}
 
+	rc = efx_ef10_link_piobufs(efx);
+	if (rc)
+		efx_ef10_free_piobufs(efx);
+
+skip_pio:
+
 	netif_dbg(efx, probe, efx->net_dev,
 		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
 		  &efx->membase_phys, efx->membase, uc_mem_map_size,
diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
index 45e191686625..37fd1cf96582 100644
--- a/drivers/net/ethernet/sfc/efx.h
+++ b/drivers/net/ethernet/sfc/efx.h
@@ -237,4 +237,5 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
 int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
 		       bool flush);
 
+void efx_ef10_disable_piobufs(struct efx_nic *efx);
 #endif /* EFX_EFX_H */
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 9ca16b051d62..8ba1645cfed8 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -10,6 +10,7 @@
 #include <cxl/cxl.h>
 #include <cxl/pci.h>
 #include "net_driver.h"
+#include "efx.h"
 #include "efx_cxl.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
@@ -40,6 +41,7 @@ static int efx_cxl_map_region(void *data) {
 static void efx_cxl_unmap_region(void *data) {
 	struct efx_probe_data *probe_data = data;
 
+	efx_ef10_disable_piobufs(&probe_data->efx);
 	probe_data->cxl_pio_initialised = false;
 	iounmap(probe_data->cxl->ctpio_cxl);
 }
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 3964b2c56609..bea4eecdf842 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1207,6 +1207,7 @@ struct efx_cxl;
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
  * @cxl_pio_initialised: cxl initialization outcome.
+ * @cxl_pio_in_use: PIO using CXL mapping
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
@@ -1214,6 +1215,7 @@ struct efx_probe_data {
 #ifdef CONFIG_SFC_CXL
 	struct efx_cxl *cxl;
 	bool cxl_pio_initialised;
+	bool cxl_pio_in_use;
 #endif
 };
 
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index ec3b2df43b68..7480f9995dfb 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -152,6 +152,8 @@ enum {
  *	%MC_CMD_GET_CAPABILITIES response)
  * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
  * %MC_CMD_GET_CAPABILITIES response)
+ * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
+ * %MC_CMD_GET_CAPABILITIES response)
  * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
  * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
  * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
@@ -187,6 +189,7 @@ struct efx_ef10_nic_data {
 	bool must_check_datapath_caps;
 	u32 datapath_caps;
 	u32 datapath_caps2;
+	u32 datapath_caps3;
 	unsigned int rx_dpcpu_fw_id;
 	unsigned int tx_dpcpu_fw_id;
 	bool must_probe_vswitching;
-- 
2.34.1

