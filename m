Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3DA3E317B;
	Tue,  9 Jun 2026 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039207; cv=fail; b=FYK0r3yZc+Yj9dDCq6z3jMTH6JdAt9+dKbKBapbddQ3FRQ6UEJqALkQbpaI54WWfTqkwB7tTTPbtdDwESECbuV29YdGLY1qvfHZInG4Jd3SxY/knQz3Fcp8vKdt+rqJcDWQdUwotsREJkJzti7YjLDt83F+LqhOWtzSc9+Y6xRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039207; c=relaxed/simple;
	bh=FSv0vTpL69gwbfplRucGmIqL/d635zYArjbyYBzedG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsyViNV1uz6U7k5dHtBvXBd+XbF8waAasfTmFyASAXznvfV48XL7lOYEakValCENeAXxt+tsZ+keavD9lZ3M2CT5GotzsY9aAoJXN3SM1BSrn3cdMGrCo9hhppNiKyjt9Imykj/dI/1BlRTVQFO+5zSjWh/Ch11ZhMrU+4oAZY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ucdsF96B; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ucdsF96B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXhnglzn6oPrbWaHd7659U1SKfrJsY+fP0skgVMhjbdKHOB+OKQElpuD80HEplukGKiCjzXyMUtOrQ36n37A5JCk225DVWh2wec/+qalQWhOi+qNB2z07Pm3SBvY8eFjnMw09BtMoIVhvmw1CLmA9Ty7XW/YI421oQvoxD78C2HGxlegLjVB/P6Gza4nTjwJ6DvSepyvYYPsGLzAnYQ+ryw9wfrQdhKl6fZ2wNAk4qUqCK1vfVjo/Q2FqnylEXZ+hwTVQVvyo+lQC6UEBK0QZky99Q9pSrgv6AzqnwOUu5K+KvrJpT1YT3kQtU96bOTOIlmG8Ap50+WdDL5jtWbc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPvL7dkTQ0j5xghX92gK3NH5r7AIi2ob2k2kFC/1aws=;
 b=sUjIQMeK+q6+BAUDjUUfAc94e/0aaS9/uGuZp5ScxVTrVCZlKQACddfxb++tw9jaWUugZKjDmIadcqLEt7flXYTUbigYSjkOuPxZPytUz8sSKTSNOz/WE7RcrgKs9guYeYEKnzVmSjOe8OvLWHTJq+SOkXJOCkEva5QvwyFxtLNk3B4CBMK1zxoj239MYXrQ3VrQIEzgTB0wE8CkcW9lnk7QAGhdBfE7e5dkuDU+a+zDGwqUCrqJq/1aQk++CEdStVboH6176hftRIxylwZLzrdWBrNANrpE7ndyF385giEewXTtUKXX3NEJAzG5Zl0g4H3EpuUoiNLoEad0tTC4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPvL7dkTQ0j5xghX92gK3NH5r7AIi2ob2k2kFC/1aws=;
 b=ucdsF96BA+qbuxANCyq0bhkf8wpf/sS3DbAQuGKxL5xTSNqCE6/lLlwUk5CbAD/aZ5Mm1mXLgTJHLmrH+ATPHHRORmjikBMztNOoLhFVQnUjQ8IpBUymtqXlQRLF5wSv3cFOFbA1lAYu0w6wjP+L1jmI4ub2tym8/Jgth9P3FxE=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 21:06:39 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::60) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 21:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 21:06:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 16:06:35 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 9 Jun 2026 16:06:34 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <djbw@kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v27 5/5] sfc: support pio mapping based on cxl
Date: Tue, 9 Jun 2026 22:57:55 +0100
Message-ID: <20260609215755.8685-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb0784a-3bee-42dd-37bc-08dec66affae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|6133799003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	H6Ie0fWnniqvWikSxOPXGVe+YympksISquIzu0Fm9ZSde8LEngCcS3M51Pat3jNQm1k3Y1Hgw7IEpk2tWyxEEDBuz6dEY1tiB5WSv6i9O+E1e9VsjsRYJhOGlLKeioR7OIv1jk5TcOA77fUqo6tuncdo0tu3fh1QhM+LyQ5oAhSk2SUmDUc/k3ujktcpVDb22nArEjC3eDltVjaPTn5N4ddLsmSq4imduLbwhFXAkyXBRRZ4YpZp53lRNAGVXvW8tM0Fx/larGPPEj6vOY0RczZV9+iIs69Vu6LKDQ59h5lKFbuCHmGhIB4LziAVEb1j4L5XA1Rx+OsT8F4FpwCue4UamvyRY4RWE9bBG3LzHHLv3sDsoBbkS9pwyWxBN1n7UnPJ3T74f0TA7CcVDYF94MZ1R1nwGgk/Vh/7oD0lhxV4OH3MCVxEuwpupQoFX+Wg5zZGG/VBggDGA47LrWDarVIOVGfTx9PCK45BbjgXHTLlu/8i8IYeX0IIznD691t4LiJAjGzuYAt7aAy/uQOzAl8qlZLNc13K3AT8MCC3xzzh/WnfaFz/pSeAMKKqx5PtawTeLJJF9ODFf4F358wtFzZnR8re7S+o0lp/6UQuHM2MaMgHNDaMRF2UIGwK+qOE+m4eVR2yohMBOOB8Y73CM8DcMReJTuiGM3onNNO41OVM+72nIgC51FFq0vgoh0kfBLeqhoYeJw+pyd3W/Lil0AyGlKgpWnr0U4a0hXhmei4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4ci2yHoAmFNyKaSnRlxlKgVRwkpTju9uMHWh8ykcd+96F7ag9wnmHhrAVoYSwP98Fo0AdteMvA8kYunJ42WyOAetEjFnGZYU3Q5/6jLMStk80CRm+5TqRlZk37w6MCZai6rGTL2yvNRYSPXqSiIwmAy+V5hv1Zx7CP1YxspZbzJ5ZEuAvfNmz5bGNx05uv1Ex8gquZWNlCG7OXZ024K76kZpDW0zAWMrXY+A3AZ8WOWq1sYfmyeo2cFLfTzQJOqJfN5i9KQMyy/f+Ls3wq47MJNiGzbeWoWvZAm3prnHc7exbCFfyeFdQF0TaXjvHxWf6LnLKkXbYf7jgs8LHLAV3LbJrib/qjt8PcYPqIRAykHS7D5tIz4uVmcYZV4VfAdPkHmAoy41wUsJ/8n8K9SS1Sh7vOAL1SPILOBWKnyMDIpzTeR53Ki/yAjYrsY4mgUd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 21:06:39.0314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb0784a-3bee-42dd-37bc-08dec66affae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

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
 drivers/net/ethernet/sfc/ef10.c       | 43 ++++++++++++++++++++++-----
 drivers/net/ethernet/sfc/efx.h        |  1 -
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7e04f115bbaa..b747411ffdd3 100644
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
 
@@ -1140,6 +1147,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	unsigned int channel_vis, pio_write_vi_base, max_vis;
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	unsigned int uc_mem_map_size, wc_mem_map_size;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	void __iomem *membase;
 	int rc;
 
@@ -1263,8 +1273,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
@@ -1279,12 +1306,14 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
index 45e191686625..057d30090894 100644
--- a/drivers/net/ethernet/sfc/efx.h
+++ b/drivers/net/ethernet/sfc/efx.h
@@ -236,5 +236,4 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
 
 int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
 		       bool flush);
-
 #endif /* EFX_EFX_H */
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

