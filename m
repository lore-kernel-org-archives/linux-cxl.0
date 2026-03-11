Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC1367F4D;
	Wed, 11 Mar 2026 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261458; cv=fail; b=OjSC6NRz7J3huMR37BWJwp8y+nL30bMkPdI+EdhWujseRmozdi6DzTWGKthlVCNOpHAENZiF0IgzWC8q0fGhRRLdobTf9wQIMOHDmFbDDewtNZE/GlboE4sw5dS0x0lDccPx4mWKKV8cxvlp2BL/dxa7U3ntstMnys5O13SBNXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261458; c=relaxed/simple;
	bh=5SU0ahdaQkyXW5T5VEukJYi0M/85eh5BwodpNnwZMUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZ3MuGmAceusyqOoPQQfui0uZeWXL5qQHQBzL8fTMHbFWTpk4IErIhJCaawUpi7PzbSQPeVW3JvK0HaEkUd4a9vK5SKZmHSYQvetLibW04+tgD/glOw/VOnTAbqduGd2DRK4F4ko/O5tYV/ccZXpyk5UTJpdMiStdyS1CEVVv24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJdVkZKL; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJdVkZKL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF9nwdaS0+yK7YdCZikvzfFie4pz872gMV3Apmx/pVlSEtKfLn4QIfo/0FKz5wZl+bTZZQGOclTZJA5z6YjQLvTVbJaY7mK1Jtkm4v9yaThklhRcNHZNKyA2LiR+AdUzG2GKpt1ZUegvc+JrI/P78Bm+OBy0z+U4VrT9zR3qCIiTMBn6NJpXCIddKeSLZqA5eZq64x99asFa6Q/X3Q0uq7ZDdyY74tpp0vn9ln6o61N2WEIC4ACuA4RzlQIlsjpfPT8W4YrVW5dCRkbV/IfdTRZqwAgCcWEaJiPx0cW7gWXroZZJ0eG/cy5uI6sIXw+e3nrILaHO+AeoksreJWZ+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSFoev65w4Fm1q7D3J977J1dWOrpHXUhrfvR4c6AZQE=;
 b=qsKiOs/+khQcmcpF86tHf7P6sWHkICb2BiQfyOTp5o9ewBCJNN99k9wg83d3MUqpQLgwTeqe9AOpzeXqyYlDaPh4MtIqACo6MWBiK/meshl3YH1rw/cqUnjb9GPT0CdxF+Xh7CDGliPgUGeReCvFm+Jkmntcb0bpavUQCh7TvHuczAaAwOnNpF29TydR2uW2nVONw+MwLzn8OyBvyrdbxVH4gRkxMm8ToF7jZX7A53IqcuwRG0RTg4b/v9nA1BYnh0XvmTnGGWF3cNdRJgFzlZ1e1nPcYHllXTecJMiFo3P+X4ZdO42ncuHFb/WP4enY/tlkNNwNUnaNLjHisRvYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSFoev65w4Fm1q7D3J977J1dWOrpHXUhrfvR4c6AZQE=;
 b=iJdVkZKLJ4l8Gb30/b03EzuUkM0x4VRa2J8q9AwkYehdAFxKAqp7yGt1lD7gDfiJ3ZUZ9MBhFR5vWwTzz3WPYMITesO7l0CRQhC0gOklOOyXiY6G4HZ2Hf98+J/r4awYA4QYoGrcmhWMDu3mr9YgH7iDonXlqhxL45qJZOfwQ6vXDjrw9K/8AC+RJfVuD0NnNM4N2d4vPU1PS6249vMmiJn2lJ7kJpTQgDNVNt1VF2ks58H8eLec8hZoBZfg5FT4ERCW6wc8BAsZiWZItfPylOs4wVDUjcry6ylBWm046qUXMK7oYBIyUtWwgH82CuUidOk4raXFsnT3PLU+64q3oA==
Received: from CH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::24)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:37:29 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::3b) by CH5P222CA0003.outlook.office365.com
 (2603:10b6:610:1ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 20:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:37:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:37:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:37:05 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:36:58 -0700
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
Subject: [PATCH 17/20] vfio/cxl: Provide opt-out for CXL feature
Date: Thu, 12 Mar 2026 02:04:37 +0530
Message-ID: <20260311203440.752648-18-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 175a8db4-bc00-441d-90e3-08de7fae033a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|3122999024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j5Sspkrt+fmHgt5tdkL2aIi9OwrHWk+2Ktr9avJSmr7lqhssjyZ5cd3PRjG35HmJ6+2IW1r6MfprXVczeZhiwBel8YQ9bGrm94YibZts45sq29sxlYJ10f/2kMF6CSjGRhB0MOIHYbZ7Xfx56WeDZrwHDYWI1atkDkqQ8bIGmyOMsdWprsQ/9QbSBk6fc0e45RQykPfdZ1ApPazlJ0wopHus/qcKnGqXjnuz7IUaV21G0iohyF+zsLBYEkW4tOQFqRdxbldlFy+Kwr53boxd/+b11iXXn8ruQG0JvGBJYaoVs/4m7v4DyLcUmgo/kKEtELfzJjR5QqLPQ3+AN/3fvMZlFBcMytdCC+v+D5vRjNm08ummTImc5ZeGvU1DCFMgkWA+/njldDc/cia/05PU5mvk1bMVuVoUxp0T6a5BzaISf4QDzjB1fwo1NW9rwdBAraPofACEWWSib3Zqe3AzD7BWCNXzukDaHD4rG/ckLXUmw5wbOg7a7Nl5mCvm4P2nQ+iE1ZyFQ76WuGNE7vMPhYN5eKBUkTcmnIFoQGipyHKfMQ+rWWgntcDrWni9OtiS+EL9RD0rv/bzkcYFf+CwS13XkX2Xifhg1FLE85f/yfoAvSnoqB96MgKRRw2u3Hqd6C0j/pZI0eBjRqzd9SyI40G3mJJGkqhLWgbawyg494s6Nj3Fq6y1/ywBlVUAU4JJqjdUC5Qa0DA2z9P+27WjJED0meGT8sdWzlAGfX+34RLYjRsN17su4d/3VwvBx/Nm42c37ZtJjkCrgN4I0rVhVBBeqBJIF6ENz9ya7NP9Y1F/EJlSzZaQV19K+oiMv/UW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(3122999024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2XThmRr4xZ3iXR63/l7TuLR9+Ov/YzEOqpbHRnekFrzbuAgyRuX4bWZTj4wuZiiuP5nh8nDlGW3jvMH04jesCMsMGz0ElTmTHgnytMSmy8QNTQI+42OGZdO/xwEeHwcs/ZKagQf14dNBLqyXHhmJfQGS3VwTqUkDw4Bn+m5o+b13UeGxkreFF4HH0iPeqIlCWyDmvWA9gcIFyXO4Owq3J7qJp8bp8YRwNcEUeLEx6qcv67lSN103zM5Q1sNB06WhUdkq3cPnTtKiEcZMJL0B44FiV2r1gP8GlwPofNSqxBocZR/yGNASZmQfTM3OldqGavnqyaWej9OxAzze4TjQ3HDhKnP1qgzI7LGQCT0h/jqA+LLS8lfT6RX5UNNPHcyOfV3291WbN9NAXW0aaLhowsuoQuIApfw0C8eokaxFCKEPrHqh1etsSAKA2VF4FVOB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:37:28.6876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 175a8db4-bc00-441d-90e3-08de7fae033a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422

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
index bda11f99746f..8b42ac05a110 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -373,6 +373,10 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
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

