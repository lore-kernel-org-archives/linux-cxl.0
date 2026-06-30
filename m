Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16972EBB84
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829050; cv=fail; b=iUVrl+wM/OU86O2DoD2kA8IiGCvDNaTsxMllImDOrK/KCFqTKEdkKKx6tNLN+9U8eoOmAkD7Pii8ZTw/yinC2KyGI2umOpS5iPYwCa2B2Q8H9Bj+F6fHMtNIcjaEQFwJpryU031kTpyKMCZ7E6wI61GDkWBIxLuD6Oci9IOyncE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829050; c=relaxed/simple;
	bh=ZrbMg1dKS0lsIyXw8wFtquR0MtJ36FDyXM5P8dyDfLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVWKmDgD/Y7GX+vL+EiEqn5O7XGGbp7o63MrDmx1a9QSM9f1EJEgyVaB0ogqfdDTBJ/BV39pLCfbspciy36KnUnR3zMw3wSM0+v3ryrYBNqQEKMpfkbyvQLB8ztje4PmtRMpB7/3ZVPFxCgLo88Y0pK4T+j1km3B1dRf1oiXteM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z4sOVqLr; arc=fail smtp.client-ip=52.101.57.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z4sOVqLr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzLAHf6quMh9TgpXLkaTD55+beo90hNkybt5SK6IkWReugJhxImm/sXRrcK4/2NU7nafFrx+sWvENl4Cbet8A7EavYdBp2OBQHS2mNdRzLE1Pkl62l+2eP1X6BIZ8vnfiSUNWG0tv58YOF1aK1ozCmFxCyouKtUf/RYPpSF4fsOGGnpPlsia+/Ge09GXO/rWFryZ8D1IPjFr4QFO8hgKt93ceBYZbAr/lQbNFjPZYvmgupKJCH1tYokOJIvChJQZ6itwOd3NJ0p9J5vGVZuvd4S2IXEbRjlNHim5XH4OXncqWWYxocWrEC2K4Fpw4yeXBd0+NXQl4NcyKJYvEyuQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbdSN6NUPAkAmgROzEAXbaYdC3h/MK01plmcZJBejA4=;
 b=owiaAESgz3mTfsrC233RGK30nb1femjHHMr86wyt6wzVKx4zvjKy16ctmgdj/Aa2T2WnYmpDY0x6ng8bexu9qQ49LiVNAT4J6xwj1JCT/sOVrt2F8hmcI8b6cIh1f7FQ9Lz5h3qK4ID7d/LPQKSUc3f48KAgR3HkPsJRxoxgbO4RocfQHylrZoTUfIGwIGyqh/0PlvZH4PqmgMv7BlQXt6hPbCT7LcVVwgZjPgheXpc4l0QlUc2OXbL996WxOjvgxbEVF21AbTHfa6TiB3otTroxD569W+kYOyFJ2Bf9c7z5jG17M2bgdHYCJBSlscjJbUdcovH7nhQyuxBscMPC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbdSN6NUPAkAmgROzEAXbaYdC3h/MK01plmcZJBejA4=;
 b=z4sOVqLry/33+Vmg9FoslCpT1mQU0L+vhDgBGAfNWFqv74iS75jxWgP8YOyuLaoIs88YoDFMU/jWUGT8I1ZIK+YdGP8UH35lVw9XvvBbIHqcgENtaUEOLaK8PozCBymL5lOwyEi2/ojp+sL6ByJ/wkJ2kzmfNu5XUgcpYqk1f6g=
Received: from MN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:52d::13)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 14:17:22 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::46) by MN0PR04CA0002.outlook.office365.com
 (2603:10b6:208:52d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 14:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 14:17:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 09:17:13 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 30 Jun 2026 09:17:12 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>,
	<kuba@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: [PATCH v31 3/5] sfc: Initialize cxl dpa
Date: Tue, 30 Jun 2026 16:13:44 +0100
Message-ID: <20260630151346.31201-4-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f515c3-817d-4ddd-1cc7-08ded6b24d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	tTHYvkXf/XV1e0LfcYJkB1MPY7maXMOh2sm8b4sNi+RiG5FR0cqEka+HAaWRaYuwRuLS/lT4QDAyotew9E5RoOjJAOMhuQwkLZSSUcGNLxhT5jv1jSR6g0VQ5CXLq+VxGacBtmLfMbvBYmwDSHsPgXb28WTGU2QneAxjRKwNS/wn48jkXOufVkfeZrF3CJYbVOCIg2t5oFJQ5r5V5P/6ZB7irO9mjDX2CzK3byygZyJ59kSECV7DXvV/QHlYFz0mFXy5OCGoMjpr7sehfjrREWq80eTKDLlWZB5SvITYHGf0z9eGNykEGUFbEKuoktCNR2mddrr7xIdoViBF04tbkjawwJRFxF1Yw6VXRA3BmmI/ADmvOnL0N00thRtPX4/f84JddKjj3ZUyeEgb2/o5tRW6nldVoL97p03qfUzrFrGMrgYbejsxMXlQZLYUek89n/aW5oWljAVnCkFHn7z1dL+FbSdrDxOXZT4JB1Kw21OwEvxAyMhLv7MJUKs3HttLq7QvNf0qAsY0Scn4B9RILUUDo8/lQY3N1XsnMH20Ow/uGE0rbSfSwPhZ0oPcMTIyHdjrwjoEeQBJHkWYywrkWidey6EOZcLYqlildWiOn8sQpF/RI0/xWq0v+RFN1glSz1+k5EqL3p4tqT7h9pjopFwwGkelJZTPNBIPpM1xMQGskZMp2NScXoCXeg6G6UuwYxGkuExJR2ovNfaisvZp7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k/tDLj2zYHsexX6tQ5uj18pm3MO/sL2LJk0RdffUJRcSiSZpNmcDYc7CZCQkWhjXs65MLFCg3GSb0wA8cqtbPpeiK6ZBGCPpD4OUnnm7OL4mL0X9BIS2l3fFac7aE1B/ZWrkN8UiIST+xK8fhFzUpzZSD4Yqj+767zQAo8O4RkACb5dVtf73qXc62AxD9yRnLOX33TqyAqm6Z01/ogcwyluPAjOjXstwX4niG02wp2bqHolaVVAXXZLJmFDnSl5T1ePh3U3l2ZeJgl8k+0Cv2GBXN4nL6h4XYVDXXF/c9YSZ0iA2lNcVBNmOzoeeClSZJi1rOClwL2IbP2vOX4xipDPKxDaANDY/NJPwJYK/qxTWnnRmitG74eyTqUceAksgpZg/I4x+atb9SRCmbLZgaoUbVB9hpnAx3nmmv+1Gu/YYB/n8maBebieKK8Uhq7wb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:17:22.4986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f515c3-817d-4ddd-1cc7-08ded6b24d78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622

From: Alejandro Lucero <alucerop@amd.com>

Use cxl_set_capacity() for DPA initialization as no mailbox is
available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 704b0ebae937..18b535b3ea40 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -68,6 +68,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {
+		pci_err(pci_dev, "dpa capacity setup failed\n");
+		return -ENODEV;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1

