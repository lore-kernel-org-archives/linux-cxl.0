Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F935DA79;
	Wed, 11 Mar 2026 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261336; cv=fail; b=ef04Pho14+bCOXFs1WKDqQx4gEMPjaRwjpKFz8BVhguiyP+i72RiHQdmVDFr2x1wfy37fmjNgPam/vk6cQssXNtZB7pxGY8v8gq5TVZR61H281RIJKc/bHJBwGfjFAwQ5mBgLIQl7LPNTuzXf0iOvQAjYYaF02jTD7fl9iUtspk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261336; c=relaxed/simple;
	bh=kQe9KEg/5yL4UbO0NYsWjqCszD7Pd/aYg2mQXn4j/BQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNotnXusUMLypLwfc1oKAmVneaop56EsbpVDOgcABgJ2o1daH8wTbv85kLco+36VS3gxnszB1VJz1ZDF8/H/Z6g2IKU0JBm5yt4IdLU62fXj5wpGO/u0dEmv0BcJ+fImzm2Qcjwl+NHB35wkVyoF4bUhsHRq+RvA1eef7NRG1tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JxggK+qs; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JxggK+qs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRZujm+M/tLSEmdeF8rXRaHzJMSkiDM72TGIeQcnMbRXzWkrPoEYleUSdW/6iuVxDxbSvDY8NTLRPPZ7cLaza8CNbiyMz1/aVWZVFFWSBjD+ddQ5bsAKMGUp1y23b1EvQ7v5ZFBut726vsb8fxzYSRW+qrkxosL36KosimZGz2rov9fziE2+ZXuri/1W7HVzOhNv3Iq+W4Gqgf/y3CionS63ySk+zNIjOjvgS3JM2Pffrz7EIO12RLCSL1IkJpzQ4ITNaLCsZNjqS8StLnPwhZ/Fh97VHPAczUEVF50lKiuc3xEgSHxbT5cC/gvE4v+b0CvAtdjUuYQWXa7xp5E5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGtVFsa8gK7uoYQyFpx7itmrfUYgqdSq+/1HvufG8m8=;
 b=H9UwhRV9/Bp78F1XDAVu3bSjxc2zpp3SBxHu/OzjprZxyce+8t3QE4KAMGuud2xYY2A4wOT3N0D6Qz9WMo604TvHMScBkDf7hXAkbHEDDUqw1P4RLhzhsy3yGV4IPWWE98Sj2eFekf9pgE3CAQ+zgTfn0DQbQlu9ZwIl0ZtJGavPHxZ01Dq61wEqi3kbDcKcqrSVqh0Y1PuPHwsgJv33Av4p1G9dinZG9Rkdb3PxMr21J7YJLALHSPeGt0BEtyEIbdm6hSCjOQvWumyoUGFF4YSyNb/SIjSbjvzk9wubjxG7PI8GXyzR2wvTUfw3+PdaZO9gVkXah/iRWRK22+6r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGtVFsa8gK7uoYQyFpx7itmrfUYgqdSq+/1HvufG8m8=;
 b=JxggK+qsgaJ6p/3vljmlUNNvWU305qrjjzjWjE57/Z/OUEbmLYZ5wgpDOAJmznXz+DjBinUoIdxj3uJVIc6t2Yv5usoInN4oQVDXLousZKJkuYLDwGPmaeQa30a6697hElE6bdbMYaptaMTY7rbrNuv82WX3IOzp7HEV7WGWWzQi9Gw0TMnYdnpmn1FrED/1xUD7kpOFiF/jW4W69hqigHOHFMjjc6Wax/Nv24cubDQsVO2lBUkmZDu8VFmUAAaCXEeywauy8vrr37NMWwKEuhMdOQjMpptSIE2EhSUPbruy/Le/heQCYTQXbI/YBof3hqThfG2XswRTQxjEj01LUQ==
Received: from DS7PR05CA0056.namprd05.prod.outlook.com (2603:10b6:8:2f::17) by
 DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Wed, 11 Mar 2026 20:35:31 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::33) by DS7PR05CA0056.outlook.office365.com
 (2603:10b6:8:2f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Wed,
 11 Mar 2026 20:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:35:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:12 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:35:05 -0700
From: <mhonap@nvidia.com>
To: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <kevin.tian@intel.com>
CC: <cjia@nvidia.com>, <targupta@nvidia.com>, <zhiw@nvidia.com>,
	<kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH 02/20] cxl: Expose cxl subsystem specific functions for vfio
Date: Thu, 12 Mar 2026 02:04:22 +0530
Message-ID: <20260311203440.752648-3-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260311203440.752648-1-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c79f25a-707a-49b7-cd81-08de7fadbd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	od3DbQD6rXBt7SgZwdHeXGgvDvmwv8pjto+awTF+Fa/CbxtBaWnbTi1A71aiH5jyLjVpfZlktaa2kMkEYCgpBfgolEmqpN2OMuKYx2tShy8wgkQXZ78r0NABLwtd5cT0cJpbbsmtTgdkKsJDcA7lbJX1wY75bVOvmO/rzQEUhI6aUFJZSDLzPaMWDQwPuCl5L+oLlNKwkq+0KEjqbJgtYoRe30966EjD9+8DMoXy2grq99pGpATdWa3sunGvYfgZYrl47TKX6xQQm6/73RDRHJJ/ezbPumEw/zM+gyu18AUbLLUmrKg2hBKVIRl/sQGY2ZsOX1ZTrEdE3pFYayulDWTVfknaNEpyyBSTM788oKp9Ryh1sk5fhjMshoRurTLHHAjuuFoIL968llfNgw5hO2oU/bzQWMsKnuh3fDenvVTtP5iET2eRcJXeiQJHDm8oLAz4yrtqxuAMe4XEeZl6TqcolTKCZ5hdvw8qddyynI5tP3pwMor/D1LP+/aYq7RlIQjyA8aFTBNCcrFIfj4Rn1XsTxQZhw/H978rt5Xags53UoXV2pK+zbHPPNMtt79uKAdiRLzZ6XStjJ/b6PxklLtC87AD/GheoqK1YmvmseIHzBGm2EGr2W1FgAbz8yiHEqUgBDbYyoZKl5GLpWMQo2hoXTzHGZcXq7XjjP9q8utGJPVeJMdJGinGYFdFM9paEdsEDrmolSvRp2tesxGGLjG2E4P77Q7kvjpwel05OIBu+HDn0kTx5VRHujahtdvXQXjvm1i1FjvDPLqoQmSqVHSdD0ZuPIZLLkQtRw0An12paaZqpUckluyGxygnVZGx
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o/Lj2iioPbZNCv/AGQOF3DG16Z/G33ri0nNGyf/+hamba9Jx8BSgMPlW9mkHxXDW3sg7dX/rMiWtxcNq2h8+Pwz6xp/MOPVAce609k1vwZ+htrmUxPPrh0AbVipEKyPQtKPtVesj6lvn4I7NXgvJ2M13Wwc5nqcTLaBn8FrdHOQ+Wjh5uqxbWdNOf71Nxs8axK2fxn9buCvmtJddc9XFLMW/Q7/0nuCg2ZPRch44XE9k6nXAtJpaNKuE+g9+k97vX1KHU2WZbjse2czK/t1GQClLjuNba1rha9yoqOwxp0j4ZqyGtP3YfIZpLwirATY5sMMqgZM+C0Ronv2a0eguTFa+qaBHob01/lFA/OFe/4Wl2NBmTHav8cEAjf5haPrjLs0EHKAoFwlnhr/LjMSPtMc4ryZ3FSEpPO7EH/XFESzubMLqujWWkd3BkBXKq0VU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:35:31.6072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c79f25a-707a-49b7-cd81-08de7fadbd71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

From: Manish Honap <mhonap@nvidia.com>

Below functions from CXL subsystem will be required in vfio-cxl
for supporting the type-2 device passthrough:
    cxl_find_regblock - To find component registers
    cxl_probe_component_regs - Probe HDM/RAS capabilities

Make these functions available via declaring them from include header
instead of subsystem-specific header.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/cxl.h | 4 ----
 include/cxl/cxl.h | 7 +++++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2b1f7d687a0e..10ddab3949ee 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -198,8 +198,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
 int cxl_map_device_regs(const struct cxl_register_map *map,
@@ -211,8 +209,6 @@ enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
-int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 8456177b523e..610711e861d4 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -287,4 +287,11 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 
 int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,
 			 resource_size_t *offset, resource_size_t *size);
+struct pci_dev;
+enum cxl_regloc_type;
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map);
+void cxl_probe_component_regs(struct device *dev, void __iomem *base,
+			      struct cxl_component_reg_map *map);
+
 #endif /* __CXL_CXL_H__ */
-- 
2.25.1

