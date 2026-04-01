Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D82DF13E;
	Wed,  1 Apr 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054547; cv=fail; b=h9Sp1oj5wgHbTBvANCPSMbc4Tsm9UrnBbxvjRFTK4crvIU5DGCtCSe3341jSz/vxx1A5cW9RAJay5niJVjtgL2H+BawD4K99Euf0hetPkS0t7otHvIj/QwkPYLGDZhNm/L4remvmFyum5LoMN0Kx0/be4CVK5MpiaPRU4mviu2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054547; c=relaxed/simple;
	bh=egjyr3GbsoMvn7WsClO7k+OE707H60ktwXkjJCLf6uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe4abfGw19yHsg6JFE+Gwvnrlc5p9egtp8YH9Gax7umbuFctuE2sV7PeXbTSUeqKH5eg6wUdlqw5X6sk0JH4togBsB8nhH4VOBliY9EFB0o1yGCCduB/YH4PAJy4Te78hR2s5yngD/SXiB5d6Y4yDXMzX9zTEO12pMKS7W3WpW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tOcmzGyX; arc=fail smtp.client-ip=52.101.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tOcmzGyX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR77uN73gx8x/KmAat/J5nnv0eCavBDtjLxxaIc7+iU7a77SJJSqH64j4gJggk0z81l1Q5PkpZttYCezBaW44WmLPcVrFC7g9Itk/Cnl6KopF8wEPxDV5tURvsee3bxDHrrbxrDxxwqQFFwh5pDxd0Wgz23GWnBlbH8FsvpwU4mX0TPVecSZmuLS4r97208Wz7HUQIH+cGXwhx2YcvNXQyyQwRBRUHhuQFZds4Lkc8dYkFHLHK+pnUBVZnOON3/99EHMhcLqE1uC8ESX/8VaAdpLu9rxht2oFlJppFC9ORT0LkxJENq93ogqbRUkOu8yvi8oC70FHynP4OjRUOaSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdyX/7RUtGQl+Ba9T6SmhTibqhAy83U56DgoiDuL/0Q=;
 b=KgA1yATYH9niQ7BWi/0J4sxhlfH9IyU9vNoq/jT63qFkS5Fj6mMFJRs/s6zsqxiAU1tuWv5gHP3PjFm16Gf+cacyTieCxE27izkDlEXITyP7DzRp3dAHjN5uD9GFa3xgdDpeb63r+pqL9v1YQKW76SIKb7wK5LoEQvyM0AtgMpHFdh9k91iDE6IafgwAeBZCx1JQLFK/FiX9Fc0dH89NOW2j1MFoyQFPiFonVZBtVIderLnCRDMlbxHqr/2Cr0HqGwT6nuzrRbPeFh/M5CPQJtZlzZLvyI2dhugKD4v+5HUySsqqvMRTEeOzXM4jyZQEDkuvpO1topiR6GudwFiwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdyX/7RUtGQl+Ba9T6SmhTibqhAy83U56DgoiDuL/0Q=;
 b=tOcmzGyX8hB0Qw5yfkEU+KvfQIRKAqQTuceRYbDgUxdr3PkTzzTii045IHgDF588sfs8NLUM1dBCANEfyk4O8+6v8kyInkQkx1ONPDqEM7o1Vn0e39FCa3xEm4o5YPH7ngnIRKjGuNBpTs+T2qXB/1GStIcS0xh9uzP6XnOOj10Oz3uaE+zyL8hN/JT1c5kBNH4bJS9+d0VfNwWlryDKrGGkAYZczA37J0BJ6FNIhnMg9fCUfKUUJHOnquI1P/Ge1efRKRcf0ruxErYCEHISCi4Da8YstLkPzE3jsnwMtYlQXD41WtVgbVkJ+kBVuh+nOPjRqYeuLe40e607OrKzNw==
Received: from BN9PR03CA0259.namprd03.prod.outlook.com (2603:10b6:408:ff::24)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:42:14 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::da) by BN9PR03CA0259.outlook.office365.com
 (2603:10b6:408:ff::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 14:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:42:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:41:51 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:41:44 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dmatlack@google.com>, <shuah@kernel.org>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH v2 18/20] vfio/cxl: Provide opt-out for CXL feature
Date: Wed, 1 Apr 2026 20:09:15 +0530
Message-ID: <20260401143917.108413-19-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: b418ab56-ea39-4251-0394-08de8ffcdd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|921020|22082099003|18002099003|56012099003|3122999024;
X-Microsoft-Antispam-Message-Info:
	m4PrXcGdeCqG41VyEVdfNAjMo1a7prx/hSBo1BS4Yg0Y9wHW4AlImkQtomZ45UZ6Xva3O0ts2lVjZDAOwbo0MCsF86tCevnbnWmzICQ0Sar7PDv3H6nJql6abroZjYKdBZaym8qg3pBpxC6AC8aNauPdcly4Cv9q2HLHplNcd3IE4YpMbU1fhzs1cvicepUzrXgQcVQxmwwnXy7yhl/TYxTllFkQvLuDd6XHDwqXHp2OVrEqAqyRFdXxal6oXTTwgtRFzXh2IfGEHtbRu04+Y28TwYOlcId2PNRpyUeBSsh0hC3QW7EPYlemg4bS5dwQyHNCqUx7vuJqRaO7Ps49BA7LkykerW4NUCAa5XypJrba/fkFbgwAZrAxbW+NLKoVx1VG7Mqbux7cVQ7AxYN1p6t9tPvZJ3aOZExFPKOyOpq0wdpvaAZr2frH6s3tnLa17f48aZsXsfQkE6vX5NvHi9gjMvqcV4MFjcjbIMBjkFT/WikH/a3WMBBvqjDQcGoR6mmHMIbognmuo9g082eUceYceJnVskn03t9cAufIZCD4uS+l3pKew+Ii7gu1cPATACYGU8ls+AlIQBGoWEThq516mpeSncTd2FddQOytxyiVNSkeuGfUnPDnTwLnP2zFYVKYKAE3SyiZGFiGFxlf+URAJXH4aA+GTUuSQR2qdfmlGBM/pYe1Mvq0JXH3OptSzxeSr52AWBwKdozG6Kor1Z0IB8fpAQLFZDp7N8bamn1gmH7fzM79dG+bUsKkX3xydR7xf8REUCrh6CZB/S1C5Ch9CQU577RmQh9AqRBulRRf3p6+6lxTJC5x+t2o7HrK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(921020)(22082099003)(18002099003)(56012099003)(3122999024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MY9AhCxtXaDXBTVYkDqpp9PSBKi0looNWjdV+X4REnzI9+GCs+PyjKCAlXCtdwPD021g1xr/GItMQl+OgiBIOuOEQNZI6URKiLA2iml47yTyousnxJWiD3oyZ5K31u/KoBMP+LnsXt2Qc1Yt6H1gqAPZV87DlyQQVClEH1FElLoQATmFEJyEy0iRLuERQqvkAvBPlQqh/2u0Px3t5IE4KDqMDWsCpKWeDx9XNcjVg0wCClNG9xGOFb87quUszm+y06b53EwcFeTYmXUor+NdaDiaN+DSdDxa77y5JqTbYMmCp38idizW+yD7s9sPXg0bteV/Fv4e9TTssTKOs6QKfv41la7H3Vi2GdPx5/qKQBRrH0l/KmetPqwOYV+Aslq2Cb74UccRFduEb9pgrejszykRfKNQaE5tseXDpYusd6JmqoL7oQma3xZV74TIATtI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:42:13.7502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b418ab56-ea39-4251-0394-08de8ffcdd3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965

From: Manish Honap <mhonap@nvidia.com>

This commit provides an opt-out mechanism to disable the CXL
support from vfio module. The opt-out is provided both
build time and module load time.

Build time option CONFIG_VFIO_CXL_CORE is used to enable/disable
CXL support in vfio-pci module.

For runtime disabling the CXL support, use the module parameter
disable_cxl. This is a per-device opt-out on the core device
set by the driver before registration.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 4 ++++
 drivers/vfio/pci/vfio_pci.c          | 9 +++++++++
 include/linux/vfio_pci_core.h        | 1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 46430cbfa962..3ffc3e593d04 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -479,6 +479,10 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 	u16 dvsec;
 	int ret;
 
+	/* Honor the user opt-out decision */
+	if (vdev->disable_cxl)
+		return;
+
 	if (!pcie_is_cxl(pdev))
 		return;
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 22cf9ea831f9..a6b0fb882b9f 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,12 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+#if IS_ENABLED(CONFIG_VFIO_CXL_CORE)
+static bool disable_cxl;
+module_param(disable_cxl, bool, 0444);
+MODULE_PARM_DESC(disable_cxl, "Disable CXL Type-2 extensions for all devices bound to vfio-pci. Variant drivers may instead set vdev->disable_cxl in their probe for per-device control without needing this parameter.");
+#endif
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -189,6 +195,9 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return PTR_ERR(vdev);
 
 	dev_set_drvdata(&pdev->dev, vdev);
+#if IS_ENABLED(CONFIG_VFIO_CXL_CORE)
+	vdev->disable_cxl = disable_cxl;
+#endif
 	vdev->pci_ops = &vfio_pci_dev_ops;
 	ret = vfio_pci_core_register_device(vdev);
 	if (ret)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index aa159d0c8da7..48dc69df52fa 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -130,6 +130,7 @@ struct vfio_pci_core_device {
 	bool			needs_pm_restore:1;
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
+	bool                    disable_cxl:1;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-- 
2.25.1

