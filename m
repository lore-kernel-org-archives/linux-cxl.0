Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937638;
	b=McYDJAu/zNmBh6MjrFIpMaTwzv4uDmz5ZPG2kk1Bghhuu0ojWjvuGLqB8oCVmgxIIFBz
	 Gghy3PxTP9k080bJ/Evn4qZqdEMnD0bCRAFaEb+5TD4/JY0JH35fZMERcN6HhZ0wdjxRZ
	 +TLFgnQAx8by1da4Wpud2szzJbasG+yqgNsccY1Zcrqb8JdmPd9g86VLZZ3PyAP2K6AmS
	 UYS6lgHMoXa9erUg/pSK3KBSJKREnrJN9g6O5n4ozvcQycTeZzS1Wei0KQMJWeDfbeFBZ
	 1IwmP7H8W+gQSJwL+zpJZQdPmhDLTqb/C5RoO5SHoTdyDT7CG+T+pivE6ZXg2cmI0+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937638;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NGXHuXMOwD6isjCcdZIHpqNy6JanT1XI06VaKvUxu+s=;
	b=mmBXNEQvs9MnnBk1prpkaKzPyINPwvIj9rM4ga8Lyy4oE4sgGp/0MtYII4dC3DbNHfyB
	 /PvHMr0Gx4Kio1jDyN4/MTwfjkD9sMDsCjB9An2p5TO4gUyoEqyk09n6csCnPEpUEoboA
	 I9o5cdhwUcmtsJTmL5LzIiT3llm2oWGPdC0Ln1s8Z4dvnlwMEDzxn5knazIqFa27nOq/v
	 T1fMXOHOLhyxRbxrIACaoErnK5KdUT5qhNbI0r7FnovbKf8gZ1v9sgsFgvqsw0MkQoAXB
	 eA4Fo7CxeW4WVSAPCPVn8e86Pz8IhuNcJL6SLkAkwKwMZmxwr8Zh6jSwJF8NccN9tnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m5MI67DM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.39
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CB606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A49CB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m5MI67DM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9K5rRVDOIoyASZqpgTzsx9La2n5rMVLdXb3+jEKFDn/+XYJNAQL0HTUK2wDNBNmQijgXyE/t/Dy6YQIZWhgsUb5lY0VRqwMXxAOhiGsQc10Ca0xeMovE4XtjcKhSS4P/7SC9ubyR4ftDkCNkjLo1o/U5d8QxniircQDY6puLXowibqgTWPfR7T3YZ99FX2l5U0txNKQGxh3VvO/YEBxchp18B3lrPiFjAHPWTDmvMUl9T6XYy2gz0GZHlpe4TjyAEtbpDb/829x4CCtirLuD3B20jk8FwPazWfZxta+jOmzD/3OMhRWMCi4/Hv4uhkUTAW7cl3L21q6G6iCgfKJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGXHuXMOwD6isjCcdZIHpqNy6JanT1XI06VaKvUxu+s=;
 b=C1xJAmqFubVan1xH6YIjWqEuom0s+B5UPjVVF9DFAgtQIKQtuLLzeU4+rqqq4JsSUwKnwN2IZk60VgCqSF2MXn1VGt0tFEMuOcZjez5LiHMq9cpviAbF0ynNJm57HdPZlk8w09ZxlwipS6ysfd2+xk/v5uIXLbvM0gLrQXB6e9QMhSDpORL/qUeU+giyBsYyB+UX3bBXYN/ftQniRT8+ERbL+cxp/INTH62D5FKMqkT36h5MSHyw5wyGrEjbOnoex6yf4lLxO2GHzG05kz9ASV64uC0KyxifvMeAf7kP/Ah9ZyzzYvP+DX5HdoFBKERT1tFnA2mnqz5X6pI0GhgZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGXHuXMOwD6isjCcdZIHpqNy6JanT1XI06VaKvUxu+s=;
 b=m5MI67DMOXENJvfXBzlsruz6eeCJdaQ1tpD4b+C/ZoVeHeDG/q3aSlLaGFSxZlsUSqFTL1iwkyBOiUQvp3LPavNMvCnTUhajQY7F8bk3Q/wHfKPwhVfk46jLSJ3qgkNTme8cL87Rs6evGByy00NEX85AJdCF1vY67T3RhBj+8f5Tgr8oZeP6TWeC8SFv1FpcTc7fjepWZ9FIa+0R8sASp+vahnuHVf5o4XtMqwRYjVxB/7p4RF3AtzpTmdu2g8OuHLHtXkU5yn5E3vEVOKpcQAn2TeYc2NNO9dGf//uHjKS7bjjgFCeRn5UYsq/dgToQsdgwWWyNpr9g3Yi39SWuSA==
Received: from SJ0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:a03:2ef::11)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:00:33 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::2d) by SJ0PR03CA0186.outlook.office365.com
 (2603:10b6:a03:2ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Fri, 6
 Nov 2026 04:00:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:11 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:05 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 07/18] hw/pci: Add PCI IDs for the CXL Type-2 device
Date: Fri, 6 Nov 2026 09:29:00 +0530
Message-ID: <20261106035911.1280066-8-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 4672c832-31db-4b90-f465-08df3bba8153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|921020|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tv4VBI1drQG823ZcXH3DfV9IUdClCjIEzyjpQav5R4woMr9jwyaXq1HfibiKq8V53rkckM7lkhzAetjWqJpaSaNfpS7k+8XvOzjWDfONmSB8oAeqZ9M4jA4/83lb46u1fmaiWV6neAWMXU45GYLdT+jLyUgZhZq/ctr/tKQnvOe1jEgT80Nyn5UBWQdzkfHDcL10PRsh/6Hi4+pmLzz2JTF5j/sv3D6zdXVcF3nhiCWHvvinwTyS94MXxpHKPFQFWHe6Rag0b/PUfIOrSpOXFk3M6ulit0I6pjs+bNkPLYcOrxSSjU1e4O1Q0cFNGzxp/PE1VMuYG0bcyM7w86u/8b4YsnLojont6qhqEPj5MVoKGd4MdyyE1LGx9QU4tGoUE56KfQWOzhMp8CJ4TiHwcyfO56B6pQRzHz+BfSd8K8/oqmlS5pyxt8rAPglWBFB6gwUX52LoDV65gjygcue9lih+wAM5DXp/o25F8/wx7gJRArSrhNnnv07fViJMTfdHj6ma0YWFcEbrErSSc/PIEuml/cxPcr/VTdHcFYvNMnIRfz+C/y1GJU6nampSaDL9j8tgVrw0nSljDrmsEWuPcF+al9c7SMoVqeeCgXPe9KXrNYezIx57AzBUocsULSmIkH0kp6hh3LgaDWfIQoPk8DihAk6KMGqH7RyQNaY5oFyeawVV3PhyUfu2r5464VfnHknjnUg7gWz/8HnVmEpmtVFPrLwNmpmBGvJi2YEjGYZz6qnBZ56q8VtwDGcUgeVC
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(921020)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Db9m9qrNAXgr3gsdHVvJYeKTKehsWiQg9hYmt2q5FC+PyJyuLSRIW3Q8kOMGHxXLE0xOfISlrSv1+T7I9m/mUM1DiN/qBDVkC0kLpsSiJnJRqKA8i7p8Nk0pnNavqHhLU1Hb7W8VFv8nkpVJhlxweYLKnXl2fwlxf0a0IfTNk2BEd/BDbScEBWV5AMEefijcgOXulKK89UAPLaPg0jFoG881uBM3v8b6HcwbuBxzJZZyHx15VTS4yaYdZP7V2lDmDjF6i8mLdicCY9NHK7KR6xiAmnF1MtKAKS81lc+L33995PlrR0xAAyVp/x7+cxFGrIFBCtfFlUiH2H7Cr8tdxdnZBZsO8/w0mPJoJDwo53qBj1FYyVRp9PCeAZ96a5HljwTboJbkJ6h595IIK6kcxuVgPsGi7LQm0R7ci7Vr6jIKc5sBw3jL3YCJYQTpcS1h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:32.8709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4672c832-31db-4b90-f465-08df3bba8153
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624

From: Manish Honap <mhonap@nvidia.com>

Assign 1b36:0017 to the CXL Type-2 device added later in this series,
and add the processing accelerator class code 0x1200.

The CXL memory device class 0x0502 with programming interface 0x10
would bind the guest cxl_pci driver, which treats the device as a
Type-3 memory expander.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 docs/specs/pci-ids.rst   | 2 ++
 include/hw/pci/pci.h     | 1 +
 include/hw/pci/pci_ids.h | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 74460bb19e..1443830ad1 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -109,6 +109,8 @@ PCI devices (other than virtio):
   PCIe Upstream Switch Port (``-device pcie-upstream-port``)
 1b36:0016
   PCIe Downstream Switch Port (``-device pcie-downstream-port``)
+1b36:0017
+  CXL Type-2 device (``-device cxl-type2``)
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 359331102f..4ca1548771 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -123,6 +123,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
 #define PCI_DEVICE_ID_REDHAT_PCIE_USP    0x0015
 #define PCI_DEVICE_ID_REDHAT_PCIE_DSP    0x0016
+#define PCI_DEVICE_ID_REDHAT_CXL_TYPE2   0x0017
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 477609ed62..c35b7b99db 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -154,6 +154,9 @@
 #define PCI_CLASS_SP_MANAGEMENT          0x1120
 #define PCI_CLASS_SP_OTHER               0x1180
 
+#define PCI_BASE_CLASS_ACCELERATOR       0x12
+#define PCI_CLASS_ACCELERATOR_PROCESSING 0x1200
+
 #define PCI_CLASS_OTHERS                 0xff
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
-- 
2.53.0

