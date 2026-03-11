Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C53750B1;
	Wed, 11 Mar 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261402; cv=fail; b=q1FtFvIDXpn4gSTM0bROTpyWtYUJnuqKwv1WRUPJYsyA4+PLVi15ljvEJ1OkQeKyNB4tr9RrmafJe3md/vzsjTqja1Za8Q58LRP+71+Q43A+J7x70t5YFXqRIJYrIvXZELUWsrEbG/LXyokSYjZJGkPlvU9cnYEhAJbVxj5u3Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261402; c=relaxed/simple;
	bh=wZuR0RUizxRtyEKK7ZCBPCczWbP4V7xIeNxSGPUnC+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8V8tnOzC1Rz59DqY550G9WVLN339OJmhqJ4Nc1Vs+eCfiS6FEGNgPYVH8JfG+4ff98pQreADCR74F3sT3pEIj8yWWT/Tl0/jhhX0vpKAUc13ku8v2GLf81xyYKCeyI6NRsaWQXsof2cuL8V3Cl4UHxqJ7e9bpEqHelFf+QpBbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mRoCor6t; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mRoCor6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l91y3/FWUOA6BIGv5v4npPTei2XWxDmDHgSZH3Nveci2c6QfXnmR+5+osHXBnYyG7lVC/GBeTAJLYW28bWwqgK7e1HjjeGBeX92egPrw37494ddaq9p8N7kkjFho2oTSXesrNVrhf1YKD2wKj4dt1IoE/RaG96Y/+ubrrLkXWuZvIBX5EAwaRSldJ1g2bW3tABt1imSAWL7eRttWBK6ZduQ544ZOpirQ/R8saSXzGhR1VQfkyPRPTaiehwj3kco7sNvY/Pr0dvmutwsIhiDMsRtTvIrFRSPE3vlg4cAk7BelZHPEfHSAUGCcXaqlVDoqBSpNS9FzX9zXsD1tr9owOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61te41hgIyp+QkI4n2sQJY5AIJUP6l5F48EAoO5c6NI=;
 b=TGhBFYmUoRDVll0Po/81IaP5OrzmxhzK8U6+YzhRkfEn0agMSWiO2OX+C8kDw2iX7pa4CNfdDfffipaIV2h+/q8PySEa4NYxfvyH7Ge/jPuHPlBqMJBx5mbl/Q6dTDlSlQcVmiEa/212cixhEUf+Pu/pmVgnbXxdGlELNMvHtfe3VbcLbk65535lrsM+OESb4Geh745sFOq5k0ZVnv6xd3sFY9n5A/BHUV+Tu1O5N8vtg6ebyruUjKyqjMh4hcC6LhkdyiIslTw+N0v+t22GokXQw9OAUvz3ZuITiFTDnfxiCRVU4lzQ6BE3qXPcPGUsfzcaa8/tS/5vCHLCftlzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61te41hgIyp+QkI4n2sQJY5AIJUP6l5F48EAoO5c6NI=;
 b=mRoCor6tYlvY3wDVZd/jpkuqUwF0nCVh5ETIZDUyJuMwQoAqeVsj0W1B5366AGIPZBBlyGW4T6U/WoLV417NRv8kskqi9zJDNYR5Vi1uUmB5UkDeZtXTLYN/97m9Ja3yY0hqgT657Wzy3YDxBpwum2+okLKyvpLPf+ib8wrs9QC3iWJup8160ldIfrVZFKSK/zCp4Pa9Tj/BpLzN3/RwUA8Cvo4vjW0EyUKDy1xh/8+4fUmMS6UbsFNaQgwQAX9yI+13iPSw8FcO43CQwqeGpkO+bOZocBvfISGJmStGwKxk+jnrU489O5hs6aBjJsfElpoyXSRNTPovPkyVJiw+dQ==
Received: from DM6PR05CA0040.namprd05.prod.outlook.com (2603:10b6:5:335::9) by
 CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:36:34 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::f4) by DM6PR05CA0040.outlook.office365.com
 (2603:10b6:5:335::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.14 via Frontend Transport; Wed,
 11 Mar 2026 20:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:36:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:12 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:36:05 -0700
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
Subject: [PATCH 10/20] vfio/cxl: CXL region management
Date: Thu, 12 Mar 2026 02:04:30 +0530
Message-ID: <20260311203440.752648-11-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 64561604-17cd-4fa8-0312-08de7fade2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rNNaxqcLeqgQeT+CRVT8Vovu5IlV87+fk9bv/XAY9KlSL5as3stsHr3J9svYnDM11JFoKRVT50mMIxUPrDO9/6NG4ZkdowPtMLCg/ppJNRswzxBMlWdsZeYQFWiedihN0M1zJlFN7DWm5TQ/mJLvwN1mQbNU4MkdVh7dK/4WlJc7azysfxqgGEXJOE9a8WagPFWAugZ1f1VwZLyuZOuOvaBntyPb1Sigo44sLCTPsJHM4Zw7e416ci3VDToUVssHXbM4HHdAD59xxN96BQurDJDBjp0a+JFT+WCEt1bcfPWW9yNAimrk/RVarmVA28hnRAwrdqqXMFTu0eOItCOsmHjyEJPksZYLOLij0s6k3+ChavgVFXkJVmpYMz90xKiEs6Xb14YauhKOh+qVbTnidDXipYuKg9DjiVw9E5zZ5KI6LyBgYE55ZX/c2t7mfMimzYNCLjvrKzsez8JWrer5JyWsln71H9JoY/vfuCTMoMCAn6v3I5wmy4zjKQU/FW8da6nDojptO8E56YsPdjSX9sNuGm6nNFH65BUkIgv1INqvqMuWW8njCHvS2OH3VrOat8tRgpfX61zHhWFUO3mN/Q9DTGXfbtOyrS2NnAusww1hVB9WGPFLvmtXQJ9GYpszcm4lOMs5QlPvc162g4qvBB/V6Xso8dGbGpvtNfwqRlaAUi7fgVTy7RQhA/Xbq31y0NY+wGIKkd+5JZMpjzl50NZMm7mB3RK+0Fsh3d9qhO96/ljdH0HADp4JfxSHlmZFpHSHeYFzgOvrnlHpyibJhbdkJ+3klonQmxJTgKszHoHWt7fwuONCtEhkgt2aVmum
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ule39oWfQzANv2v05uIOogdT+cAHyPqwb156r75RpG2prjdO1NMxOGyOzOS9ffkQ/vEtVScuuMcZQFeidE4XiWZzBHi/CHXstMBA5yRmvmnKyWfCmey35zxHrjxtH0llPj3HV1D7Gfg4+/rtHVoi8k8qUSfPeusCqrfatWGwKz7GGXZ1x+vAatNt7YlnSfozEqKhepJC+r6WFLJINFO8EtAOCPYneItVvuwxiR469O2BuotYkj7/hsa3KJg7bLwt/4Ay22MDq+WZ7YZvpblcRi7+5F6m7WJT4izHTn2rR7aT1lJnNjsYrxFoiloKRJw3nP2k57N2qYkC4/IW+zy5C3Wbb2xt/GMN7dbE45dLwpzl6QNaxT2venHubNidhb+YXD48+v1GtudkYgN6UIAu/jRD1vdIhG6oQSMO+k1OncA2fas93ujqOTty1rnYsdAy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:36:34.1767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64561604-17cd-4fa8-0312-08de7fade2bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

From: Manish Honap <mhonap@nvidia.com>

Add CXL region management for future guest access.

Region Management makes use of APIs provided by CXL_CORE as below:

CREATE_REGION flow:
1. Validate request (size, decoder availability)
2. Allocate HPA via cxl_get_hpa_freespace()
3. Allocate DPA via cxl_request_dpa()
4. Create region via cxl_create_region() - commits HDM decoder!
5. Get HPA range via cxl_get_region_range()

DESTROY_REGION flow:
1. Detach decoder via cxl_decoder_detach()
2. Free DPA via cxl_dpa_free()
3. Release root decoder via cxl_put_root_decoder()

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 118 ++++++++++++++++++++++++++-
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |   5 ++
 drivers/vfio/pci/vfio_pci_priv.h     |   8 ++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 2da6da1c0605..9c71f592e74e 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -126,6 +126,112 @@ static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
 	return 0;
 }
 
+int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev, resource_size_t size)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	resource_size_t max_size;
+	int ret;
+
+	if (cxl->precommitted)
+		return 0;
+
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM |
+					   CXL_DECODER_F_TYPE2,
+					   &max_size);
+	if (IS_ERR(cxl->cxlrd))
+		return PTR_ERR(cxl->cxlrd);
+
+	/* Insufficient HPA space */
+	if (max_size < size) {
+		cxl_put_root_decoder(cxl->cxlrd);
+		cxl->cxlrd = NULL;
+		return -ENOSPC;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM, size);
+	if (IS_ERR(cxl->cxled)) {
+		ret = PTR_ERR(cxl->cxled);
+		goto err_free_hpa;
+	}
+
+	cxl->region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
+	if (IS_ERR(cxl->region)) {
+		ret = PTR_ERR(cxl->region);
+		goto err_free_dpa;
+	}
+
+	return 0;
+
+err_free_dpa:
+	cxl_dpa_free(cxl->cxled);
+err_free_hpa:
+	if (cxl->cxlrd)
+		cxl_put_root_decoder(cxl->cxlrd);
+
+	return ret;
+}
+
+void vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl->region)
+		return;
+
+	cxl_unregister_region(cxl->region);
+	cxl->region = NULL;
+
+	if (cxl->precommitted)
+		return;
+
+	cxl_dpa_free(cxl->cxled);
+	cxl_put_root_decoder(cxl->cxlrd);
+}
+
+static int vfio_cxl_create_region_helper(struct vfio_pci_core_device *vdev,
+					 resource_size_t capacity)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+
+	if (cxl->precommitted) {
+		cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd,
+						       &cxl->region);
+		if (IS_ERR(cxl->cxled))
+			return PTR_ERR(cxl->cxled);
+	} else {
+		ret = vfio_cxl_create_cxl_region(vdev, capacity);
+		if (ret)
+			return ret;
+	}
+
+	if (cxl->region) {
+		struct range range;
+
+		ret = cxl_get_region_range(cxl->region, &range);
+		if (ret)
+			goto failed;
+
+		cxl->region_hpa = range.start;
+		cxl->region_size = range_len(&range);
+
+		pci_dbg(pdev, "Precommitted decoder: HPA 0x%llx size %lu MB\n",
+			cxl->region_hpa, cxl->region_size >> 20);
+	} else {
+		pci_err(pdev, "Failed to create CXL region\n");
+		ret = -ENODEV;
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	vfio_cxl_destroy_cxl_region(vdev);
+	return ret;
+}
+
 /**
  * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2 device
  * @vdev: VFIO PCI device
@@ -172,6 +278,12 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 
 	pci_disable_device(pdev);
 
+	ret = vfio_cxl_create_region_helper(vdev, SZ_256M);
+	if (ret)
+		goto failed;
+
+	cxl->precommitted = true;
+
 	return;
 
 failed:
@@ -181,6 +293,10 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 
 void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
 {
-	if (!vdev->cxl)
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl || !cxl->region)
 		return;
+
+	vfio_cxl_destroy_cxl_region(vdev);
 }
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 57fed39a80da..985680842a13 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -17,6 +17,10 @@ struct vfio_pci_cxl_state {
 	struct cxl_memdev           *cxlmd;
 	struct cxl_root_decoder     *cxlrd;
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region	    *region;
+	resource_size_t		     region_hpa;
+	size_t			     region_size;
+	void __iomem		    *region_vaddr;
 	resource_size_t              hdm_reg_offset;
 	size_t                       hdm_reg_size;
 	resource_size_t              comp_reg_offset;
@@ -24,6 +28,7 @@ struct vfio_pci_cxl_state {
 	u32                          hdm_count;
 	u16                          dvsec;
 	u8                           comp_reg_bar;
+	bool                         precommitted;
 };
 
 /*
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index d7df5538dcde..818d99f098bf 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -137,6 +137,9 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 
 void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev);
 void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev);
+int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev,
+			       resource_size_t size);
+void vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev);
 
 #else
 
@@ -144,6 +147,11 @@ static inline void
 vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev) { }
 static inline void
 vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev) { }
+static inline int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev,
+					     resource_size_t size)
+{ return 0; }
+static inline void
+vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev) { }
 
 #endif /* CONFIG_VFIO_CXL_CORE */
 
-- 
2.25.1

