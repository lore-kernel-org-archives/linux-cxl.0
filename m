Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCE3E9C08;
	Thu, 25 Jun 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406554; cv=fail; b=UmwHDeSwDUqM0Lv7GAHrDjZslBDoUMlbZLzEV+Mymttgjv9ECz3eBmRzGcWWpUDNubCI6sGURVrARaaRQwdqiP9khvrdJHfqULeX8ItP4L3c82iZrg4qYhDxuCVa/LDyahnT6muPx/Rv0w9bC0mvuaiVVa8O0LY2vptLLXJ2zao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406554; c=relaxed/simple;
	bh=UGmMEeofg4dQt7dDB+gTPQPtfi1XCrJrbeDudMy4hBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPkoEEyQj8dtKoioQvbhKnaICJR8nwGi1er2cZDVigt93zAaqUT6tihR83YH00YfEDoHib5JLvz9Q7R23URUWs1eldpcjPXQbwMY7W6CSEjwwRAcrc8/uc09XH6KQuiFAGoo9vkuIvDNC3Z8WezAnnMO5p7AmR+KYB0ReI4cmuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KIWqMRA6; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KIWqMRA6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWYyjjzg6E4h0c1HMM1TcQCW/T6K8fWWJ3hIx5YUqkr8X2MTbln88dd5h/lItMsCuOANPVCyOvFCyp7Ga2BQ2bSF7eoX9Hp+61TXMbJ71GTLpJBkMISr8BLd39ZCpYAfPXCKb25wXacLpImktTkEOqhLh5oIX3Tb6UL5XhJPUag69LNzAOIOvP0kTru9R9YVav0a2dknrX3Hnul9l681Nk4U6P4c5x0gp0BTgtyPA5OMItiBPjpZc58F5YVTjzXgBp9DC7IYvUEwbhS1cSJL3H08qFPefFvdDuLudcih8VRjeu+X5qMz5e8SbpVXYl18vQwe0aZbl/+fE3BTqy4nHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFBfsyP50HRbkOzgBId9UxMTeY3+88ZI7NU0C8Timo8=;
 b=xvhdaZJ4ksngig4Ahgc99kTZ1hzn5+eSlIAS20K2WDk4F5UBbUqrtf4msinGU2G9qqdfO37rqrrtjYHZojYcxqMjYfDlwAMARfsWthE+ia+M4VFKNcxmp1B5y3WXqLSs9VFWkWyYkUR039a2NnNZGtx5CWoBnm3CxRZ0kpXQs8g8VM1KC3vgQ1vj4CiERGOjZ4JZUGQlJnD9xc4Hh/4zCvdFSepkgbpaN2QI7qqTmz8KEBDvoJW2N57h75eMPAhpfHjCLPprUH0+4E44N4F0qBMarQdKkvgYBAfnTzd/ptlSi/G+o1nvSWjWeMCDl33JPH6Z74H9wthRTGs12BCJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFBfsyP50HRbkOzgBId9UxMTeY3+88ZI7NU0C8Timo8=;
 b=KIWqMRA6onGAIXxT2+AHz7MAXlIKS1Di440LjkVvAEmApk9BxVfmvE28X3NU+2mqWTikaufG/t695sH0CzfBZz8GA8qKk1KZqpVmpbxiohEIvQxXYOS/evSXPq6cDYm+WnWt+Gwbt06xgtbftRdM5BwEE/aKmsJRM3m8VJrzg7p9AIyFUjDlrn7IKP3hQJYTUa9yU4TnJQwhBA88wj6eICjOABoU9bDmV9gR8KkGeD3+OiEHrreavh3aedQezgXfnljjOo6GTMIVY8gCsSAXLxJPxtJ3DlUsH97efV68/HX9Us+IyJGfBsP6ddiWxJrSnSbUh6HQNKn6a8jSX7EFvA==
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 16:55:43 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::7e) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 16:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:55:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:55:23 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:55:15 -0700
From: <mhonap@nvidia.com>
To: <djbw@kernel.org>, <alex@shazbot.org>, <jgg@ziepe.ca>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <ankita@nvidia.com>,
	<alejandro.lucero-palau@amd.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <dmatlack@google.com>, <gourry@gourry.net>,
	<ira.weiny@intel.com>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device passthrough
Date: Thu, 25 Jun 2026 22:24:01 +0530
Message-ID: <20260625165407.1769572-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecb2ca9-76e3-4570-ded3-08ded2da980c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|6133799003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	yQMa72/mHPeWvRMJdqgbq/8XT966isjrxPU/sOryrJzwTTIfpIuN9RKXqKtT3Ty4LFLbV+T7LU6aZsM/Skj1FsKQEizE/mPR3fqKG0txHaXa71B+yg3pRzszI2KWlFVJB6u+M3GDj7qfbI6ZpHoWspU9sXdaQsNDLJTvEffTIHlh/wBWy9eNYvLkJtskrnYpYqB0V/FEn1u/CU2Mq9aUTeepo8NvVf/A/OrtP23ROt1XcH7MK8ejRr2QeeloIcz8MEuvI8BXKxJxzqi9vnSnWCcvUWLOm2IZSOSmM9/Qz4nz6kWZbDkDNeIpbRk3A2SJlHfnbSROqO65LaxNFYQcZ5BkMV6ODEnUxSy9QvBFpe8MQMiDM9LVb/ugl0wkfmgSbKTAZfyEeiLdYDzVxKjfqwo3TdRj+A0LpIfE92ymhatlZgyfi0YkSoQKEhGf3YKqY/07Nv3lMhQZgOnTLDjhdhh2cGdkFRf9BvBqZQC8Z8XQjlqiuBI5PFLuOExG3oxx0lkwqUCChpC2QJfigQDPbTwSnFtv5HVTz8UmdbIT9uyev2CuWJV4r5ORVECsU/Z7B4Nz3HFOI8VtB7DYyJZgNGAyXla2X4s/JpW5DoH0SHEyIm5urCKZGR4dQ8rGSVZHkW/fO6Swvxrezk+gEH+qj/tuD2cXo9C6/IzwPH8fNVS2DUbIJPnL41TC6R/qqeV5jOypVLUmE5jON5OCQxG0fwGq5gu0/bG0pDYJ34HBBsvVU/okrL3VDdk2WWCF62Qp
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hycrxyteLHEqd+iAjiKrgKJg7lmMYke6gd8dAGPA8nGJ4f/BwBihRsYSMFhSthcU0012R4ODscqXXqn5eUAMB38XV1QhzOoDcjgGD5vjhuAjjC2yb3WBNCIRuWzI67W0LpoqtlZiIz/rIDR4LLUUGP90y069Un7i1FnHefgMJVRq4Hf1mQ5PoCvty5nDvMUibt4skbX0U4SSpiI6E3Ad1+ql1uHumWMrnPMnDj0AWRfhTBs1o95HcT49COQZw85QnLbB41sn87LP4M8/jA/DBo0XKeD0NaO7GPNa0/JolgD2TrmBKjoh3DbRcfQPmbHsc6VhaiWj+hT6/B1dCvUb9TqA81fjUpXc3s6zehHvN4wN7j2b8iSbgx9OWou6YrSQMeZR5sDl72f43cnCF9bo2M8v3ZHnrc7O/S3Z/C4HeoYxNyAhDvWaFIbBGr49Su9o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:55:42.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecb2ca9-76e3-4570-ded3-08ded2da980c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

From: Manish Honap <mhonap@nvidia.com>

Add the user-visible interface that exposes a CXL Type-2 device to a
VMM through vfio-pci:

  VFIO_DEVICE_FLAGS_CXL (bit 9) on vfio_device_info::flags marks the
  device as CXL.

  VFIO_DEVICE_INFO_CAP_CXL (id 6) is the capability that carries the
  HDM-backed memory region index, the CXL component register region
  index, and the layout of the component register block within the
  containing PCI BAR.

  VFIO_REGION_SUBTYPE_CXL identifies the HDM memory region.
  VFIO_REGION_SUBTYPE_CXL_COMP_REGS identifies the CXL component
  register shadow.

Only the HOST_FIRMWARE_COMMITTED flag is exposed.  Other CXL device
states stay invisible to userspace at this stage.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 include/uapi/linux/vfio.h | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..3707d53c4de5 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -215,6 +215,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
 #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
 #define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
+#define VFIO_DEVICE_FLAGS_CXL	(1 << 9)	/* vfio-cxl Type-2 device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
@@ -257,6 +258,36 @@ struct vfio_device_info_cap_pci_atomic_comp {
 	__u32 reserved;
 };
 
+/*
+ * VFIO_DEVICE_INFO capability for CXL Type-2 passthrough devices.
+ * Present when VFIO_DEVICE_FLAGS_CXL is set on vfio_device_info::flags.
+ *
+ * @flags: VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED indicates the host CXL
+ *	subsystem committed the endpoint HDM decoder.
+ * @hdm_region_idx: VFIO region index for the HDM memory region
+ *	(subtype VFIO_REGION_SUBTYPE_CXL).
+ * @comp_reg_region_idx: VFIO region index for the CXL Component
+ *	Register shadow (subtype VFIO_REGION_SUBTYPE_CXL_COMP_REGS).
+ * @comp_reg_bar: PCI BAR index that contains the CXL component
+ *	register block.  Get-region-info on this BAR returns a
+ *	VFIO_REGION_INFO_CAP_SPARSE_MMAP that excludes the CXL block.
+ * @comp_reg_offset: byte offset of the CXL component register block
+ *	within @comp_reg_bar.
+ * @comp_reg_size: byte size of the CXL component register block.
+ */
+#define VFIO_DEVICE_INFO_CAP_CXL		6
+struct vfio_device_info_cap_cxl {
+	struct vfio_info_cap_header header;
+	__u32 flags;
+#define VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED	(1 << 0)
+	__u32 hdm_region_idx;
+	__u32 comp_reg_region_idx;
+	__u32 comp_reg_bar;
+	__u32 __resv;
+	__u64 comp_reg_offset;
+	__u64 comp_reg_size;
+};
+
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
  *				       struct vfio_region_info)
@@ -425,6 +456,21 @@ struct vfio_region_gfx_edid {
 #define VFIO_REGION_SUBTYPE_CCW_SCHIB		(2)
 #define VFIO_REGION_SUBTYPE_CCW_CRW		(3)
 
+/*
+ * sub-types for VFIO_REGION_TYPE_PCI_VENDOR (vendor id 1e98 reserved
+ * for the CXL Consortium); used by vfio-cxl Type-2 device passthrough.
+ *
+ * VFIO_REGION_SUBTYPE_CXL exposes the HDM-backed device memory range
+ *   as a mappable region.  The range is allocated by the host CXL
+ *   subsystem and the VMM is expected to mmap() it.
+ * VFIO_REGION_SUBTYPE_CXL_COMP_REGS exposes the CXL Component Register
+ *   block (read-write via pread()/pwrite() only, no mmap()).  The VMM
+ *   reads and writes HDM Decoder Capability registers through this
+ *   shadow region instead of touching hardware directly.
+ */
+#define VFIO_REGION_SUBTYPE_CXL			(1)
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS	(2)
+
 /* sub-types for VFIO_REGION_TYPE_MIGRATION */
 #define VFIO_REGION_SUBTYPE_MIGRATION_DEPRECATED (1)
 
-- 
2.25.1

