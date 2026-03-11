Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40C37755B;
	Wed, 11 Mar 2026 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261408; cv=fail; b=Bbo+/sVEjewHDCa9IVA8ne/fj6Q4StIlHnAZmEiQvoKYftm07jmw4kpK8eTaLn3jKgRQO6JsJ4rQti62oV0lcBizjqnKnmMS/j8QgfIdfqWFcnhIXLRllgREkxHbdnEB5sA4X6slGJvuSBf9YUebzBOlE6xK28gsPbAlZn8lAik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261408; c=relaxed/simple;
	bh=bAZ262Ai/3xi8gXmym2r6a/kWOtOBfp0wTylWE08yxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcousrIsBe/NvlpRzmeG5qS6nGzYpTldVieB7P6aOz1hjQy5USZ+nPugBrAfojpisILVWdC+2tcLZPy8TmGFn5gVobNKphnvGoVqmskRBltFfpZ1lwE928Jk+sA9pcaOZbWVXnjqgwDiXMpt7xplenO6A9c0nox88J9DMpFIITs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mUm5oWPJ; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mUm5oWPJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYcDWpVrH2nf3rqbS/THq/xf9vKVYOb7Ik5pse4/cuT5SAKLlTkj1EWdfgZg45SudztMztsjc8UUwTC+wpsrLfVzoikVebuYhL1nMQINUciWIrcLnYSk/tkOxkQsQaniAgkmCaCIgiYdQqa3ZROZ1i2C4d3yhvHSUT4bcO1hysoAsCTqtca/CY21FA/0TiRjNaUdEokvr/SHqaLcEbPpN2sYsnZnCNoIjt6l0NS9vsWAiQtU1par6zio5RHUEJrkY4ue8sfmCYuwR+vlck50A8hCCSpal8sf/HwMxWeb3OriJOqjHIswdVShCPKmOw7u4WCRm2zAKg4ddZ5A8TPVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUzrkFU2XIVR1SnEtkDqb1nFZsMXxteX6hBdRzywfFU=;
 b=Vl+hWpzpOtcSgGtre4XdWrdRkNXHeZe5/nDvCLjdJUjosDJ4mhg9vmcMSYL3qfazrcYHVjPPsH6KRdGq3qmEuPCoBdrxpzRok3DiBciA+UND2VArpSmUyuSSP8xg2FgFZmYF/KhfeiVIJ9XTg5G73koPrnNIIQFi9AuiQfMDpkir2Xmd6eYKuKDAxvrgaDPvaX7X5cgnhriG7hpcJMCyBQQvkNUFuh+FodVIxicBZU9D+2TQi5kMZ1sb4rmVlwOZ0Y3gu6tTlDVOwOVX2kQ9E0BW9ZJ7Hk3DAldANymtLGIYu7I8FIPZNRmia4zUtI9xJRyX34I26Y/1JtTIH6Mz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUzrkFU2XIVR1SnEtkDqb1nFZsMXxteX6hBdRzywfFU=;
 b=mUm5oWPJ1B3ZUYxJMmvFij1493SKhIpEmqzNm9qaMJTGg1A1JPvfrfbmfH08BQWS1GhI1UANulTixjV9BduDrY363RfdJwMBDzc3ClO4DPxtAo9T5kEx9TWW3XL3AGS6hyfhA8IJ60gUnNl+fEia4OA8kKZMXhO6sHV2uiJ4vdOLGdWR1bKzVGN+BZZLnM0NlW+6O3vEpXdlL1Pqj1JL9H/32iwN4TF/7AGdjR2tuRyE2LpiNHTjfXltUvAm/iXu+fbGWPnJkXDUq4gtiZ03wNBlUUgZx5LVBnV9UCUZhFXFplzE8Z5XkbfXG4eg9Loq9m9I60Felr+hBnjiSAPdgQ==
Received: from SA9PR10CA0005.namprd10.prod.outlook.com (2603:10b6:806:a7::10)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 20:36:42 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::af) by SA9PR10CA0005.outlook.office365.com
 (2603:10b6:806:a7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 20:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:36:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:27 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:36:20 -0700
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
Subject: [PATCH 12/20] vfio/pci: Export config access helpers
Date: Thu, 12 Mar 2026 02:04:32 +0530
Message-ID: <20260311203440.752648-13-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: fc134fb5-e3b1-4236-c37e-08de7fade7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LU94g1nloX2L2G076ZAyq2IfB1SHLyCI8CLeaKeDX0Oci6p1S8DTzmJAkrdhvWcMkydzl8nVbBEthSzpD+AYeo63kRnCFsT/sbJyA4zXUgrSx7HlxdCtwlkD7mwyJTEAmmWo6Egr90PULlurhUrW70s+EhNUxiUM3Hji+o9ktqhgV6AQD716pI7AEkXofPGqEQZH2F3GhfoF1J8xouwd0NogR7oOO+CCps47RICDC0C3hv9kST73S062LY3MnpQ1ylUXT0TzbPYKlKntlMwL0EWNjaYGTsE2uyVCrvtCLJgNQw+QOAX4l/UJG2z/K/cllKK2Guw5TkYJvWYxsmLCKhpYhEirXyNQQct4PFUAxsTajHKFoW8XGXe14aOOwoim8ZKDLBMlKXf+2lRdHae2imVQhv/X3EsC1SPgDKFClDfVRTd4YUFPWDVLKcltl7II92sm34ZmggzwlF+1+6wxu9+ueEfjMeATKAaKZ9End2ZftGCbR4zFFBLmJoHfsPEPOhsQaPn2dSscmfLADwV6i1nbnd+/ZHyB/2DEdaCwJPSQSCRmpMY1Lp8vaWzA1V55xMm2lggsi8FHQHTNbZczz4CnDRg/kNS1aWcT59XFhSmrBWrlOIXk0cVAfwKwB5URNQY0HX90CgXBJRFzE2t7nWO6m4r+eA/kaGw9VdpzIU78u7Rj3E5DwKwyc+d1WFZmD4ZdsL+fpp3MnOFbofzOSnXDZ67Bf2ErgjJ3VlwPJ6m0s3ebgGRpAp4SeQQb8DiO4yvdMOMhwlpPnLx4Ht7dZC9bsjhZuUg8lVvnvp+FYQ8apL5wHPAsHTSI63SLxNwi
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y5+LSycvh1iHKsS2QugseQB5E7hNuwtBorN1bH/iC6ApUYcukICuR7IabWHTLS7Dhm2+s0Llrg+dPT1aDv9YfFHUhZuwGJhf31svsreAybbe9Da7N/bqntwqQb4Q0xRdPq6+QSeYs4UvndHSnBv1kEaUrXqP7VkPWzJ+bGzkmajg2VUKRkzhzkiTr+XLFvV5mTAS5CL9jBoxx7CuFphZptp8nxedU0gNZZ3ZIvy9CzEfj64f+C8SkdDGGfoC0+7aHpSrPsKP20lkhW1vU+kZmfPfDlQv8R36PqIteYvbxd+rXViRVZ4iqU3g38faRDqLGFuONncfSCiF6pAvBmWr7z4nwrWBn5xyucmmJyFtar3XdSgKFLQF8bHVbOtQ6hlUqeIVkdml4baxzLnKcsYBCSar4f9k+2l59bFi6dpxErN5xwiCQrHz2yd5bMJloSVm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:36:42.4447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc134fb5-e3b1-4236-c37e-08de7fade7a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

From: Manish Honap <mhonap@nvidia.com>

Promote vfio_raw_config_write() and vfio_raw_config_read() to non-static so
that the CXL DVSEC write handler in the next patch can call them.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 12 ++++++------
 drivers/vfio/pci/vfio_pci_priv.h   |  8 ++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index dc4e510e6e1b..79aaf270adb2 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -270,9 +270,9 @@ static int vfio_direct_config_read(struct vfio_pci_core_device *vdev, int pos,
 }
 
 /* Raw access skips any kind of virtualization */
-static int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
-				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
+			  int count, struct perm_bits *perm,
+			  int offset, __le32 val)
 {
 	int ret;
 
@@ -283,9 +283,9 @@ static int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
 	return count;
 }
 
-static int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
-				int count, struct perm_bits *perm,
-				int offset, __le32 *val)
+int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
+			 int count, struct perm_bits *perm,
+			 int offset, __le32 *val)
 {
 	int ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 441b4a47637a..8f440f9eaa0c 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -37,6 +37,14 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			   size_t count, loff_t *ppos, bool iswrite);
 
+int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
+			  int count, struct perm_bits *perm,
+			  int offset, __le32 val);
+
+int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
+			 int count, struct perm_bits *perm,
+			 int offset, __le32 *val);
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
-- 
2.25.1

