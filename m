Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F14D9F62
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584348; cv=fail; b=jD5LuWJkmr8Vvx+gbQslISic883O9+gPi12XlZwjbA8wJRIfdj+1sIkptTpOFT37VPCrBSOnSGFoYYgRKreJ3NdvtHqM7XlsvPMWCnKlt4mLvOdzYTLQ4nO3Ox/g9b/mctsCMXk1hIhdFW2e33G2gBvq2vdIeN42sl9K7y/SwNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584348; c=relaxed/simple;
	bh=GJuIpRZGqlqv5SWqrL7VpDJX2eaPEGoO+vicaI4eaWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTt0NiwMaLjCpsXh6wqzvGf5CO7I7bNw6H++PDk/HeIqhfga+I/hg1c45n1mMj0oF4ufA6ADa6tg4JV+Flm2u1y7OZMgNuXtcrapsz7gHD48C/Rts2X0Zv5Jm0EkCqnf/1r+QGbRr35LycAd1cx+5fh81+063p0kgw1vP65z00o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bmpERxx/; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bmpERxx/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzRQTFElohJ26qHBpEU+gv19qGrV2hI0m3dEY457wRD4Ht3UwZHmTuYorGaglgqipse08jpbxok9soVgsYWaILeHCIKvdYr+37pRa0o/W2zT7RQ/JNrcpGm591K2VRu6Cnk0ign/ORfiUjI4Qo67i7KZcgoPzXEpfyZGh33K10b6qUJrPaOOpx+9NIwVmOZqy980toPljbonO1wCWKOFNf5zO6VRF60UmyFhA8G2h44AppOq6GuQtEnn2jYrTUsQBWf4PffkuhWSJl/GgmAiN0+O4wU9do5CuwhAV/fslXDeeMMoE34JJITeS+O9G/TI5zNUkFw2dHu7nGejnnWZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJUN3ZbVnCx2yds0AQaLWk+34CUcYl1osu4CCpkjwKI=;
 b=LeInT1dRn2oNsWSwlsLnijiIER32mjZ9/FAoHqOCuy3ulXT3jMqij5goUxLxralT9mjwtVG0jxXpW9WZwg0evvCXhKVa1R3+BDjINyB5sjB2Qas2yQtc8QLXx7IOWA3DG18V2b7VS0WuEbR4ekEBZSYQYvSiVues9WHihWcz0GE2y4j2wG21pb9tuCJsvo4P+p1bqHwQr7X3I+tupAnNoluqswyrLG06usR6NKZwaq5zvMgGzavO0ceMeTgyXEei2SIjW/AHp9A8IILERio9W7Rw4gxnmZpJQ0xeN7/fc0BOYUsHgOrCKbyXb60GKA3Rg1itRKNyypPrV4ZhdFTLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJUN3ZbVnCx2yds0AQaLWk+34CUcYl1osu4CCpkjwKI=;
 b=bmpERxx/YgSmj0yNePQzPI9k4TsJWVeyImK+SM9llqPa1cR8Y5o31T74z5zgklJsv3mucEWtxGz1ifBFusCTmKKeZ1QJWyRwXxGQpE56b/DRJOSp57cX2MQQT0udb8zSfdZVeXpi7rkgEpjxnZu36SrLaTkM3fGR0qh0fqzLEXmmjBr6YKX1hXHqYe/QvjE4aKVeVCW+Mi7Vk44N14G+2OhmLVLy4BTAI/ScG7+TZXOToDKAua4CYs/g3yad0EQ7wR+lNSIxbDbQBh8KP9MvBwf2UELEV62JnJIgZTp57J47QPuv5ZJ5ifgmEyd9Gvvoo+9OapodGmMw+EQEFaRitA==
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:45:06 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::43) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:44:40 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:44:34 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
	<mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: [PATCH v2 01/10] linux-headers: Update vfio.h for CXL Type-2 passthrough
Date: Thu, 17 Sep 2026 00:14:03 +0530
Message-ID: <20260916184412.3825713-2-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916184412.3825713-1-mhonap@nvidia.com>
References: <20260916184412.3825713-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe102a1-f936-4039-8b12-08df1422a034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|36860700016|1800799024|921020|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TDPQmjEAkq5C2V/EAqrfetb+oZWKZdFlvIm5ChXiCiNXxS7zLqrvJvUPP4etG0Emw/OiM81C00Oyw+rVZjBrUVoYHraFBSWbuDwHpZ1SaF29Zen3KRcMFuLHQl3rCNDI3NWWokHVaoVOfv9l7FYKYE4fwRQT3o47QvTSmRBDCOoUlY7vPcR71HuLDPVziA0IEPpmnMy5gmGrQqcUHOCzARx75JP38COGQMhyd5190ReDa5ztX6pK6SUWbo1AWfuMPjgCuK46yxfh8IyZyRNDgWQ9v/KODdHGsyS+Q7V8ayHqeFagVfbq6ewaHOwzsfubMyfOyqnjhF0s5VP+gz+ITyh3I5C06U43QdVEGndpuIDe97sqrlC6IF6ChDMIS7hWvdRbOH3CEIDuligHqnClZAsvnj1UUgTjNKHBR97BVJ1XIMsZcawg2gL/VFekkP9tt7lpDuLaV7cQnDr8gDY40CPODeccly3HAj7CWXDBAnrtEOzEL5fBk9jBhKcst0Oj8Yoc5doIpT19a2GLeaOZWVb1t+qUdmI2O2oDX1TexqJNDb92P9ZSGV5alu9a1i0JA0Sg/PkFmfV54bW64oW+cEGAY50Hb+c798A1vKHcbrgtS9UR38btQFKN2ZgJ0llUBWm8ZsQ2W4HCxL+rTDz3GKEKmYHpAwTmcvPs4QiySzXzqx3EqoEyY0RS4fJZXpNyTWTMR1dgtoQdOosCJ97lQRFXnxagdDo39u5iSbsWHMq9NCxLeH8TdNPFpNCG3rYl
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(36860700016)(1800799024)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x3RknyRqcQeM7q3zrCvoxafx1v1vxcDWSnKwfLq6wiSJlKRg73yOopnsKo+T1BY1WTppFsham2R2KVl7pjDMhkaCKQttHxEnFWZlMgJkj6nx5KZNN0gIjrKEZRPN+HG2Z+mf3HKSQMYDB0puTtxqlpsJ1AqVw4xn0w88+FUQQXvhATchVCaBR0ELa8lU39r5qSyEE2nqKjp4uWQxeEQuLsepWdU9WON7f4q4HCOg55zKP6OngUK8z6hDyx65jwOs6YuJDrhkcZiWQPzjTv8sYrEbkmafG4u9U+/U7AT/IQajBWQ58+QohVhH1QPtSKq0/h8K2PeE/K2pFj46co3XBdBcDrGVqtMEOpiuYgwRCVRx+BBiw7Zs+ASVMxJX9+szSzvyiygonqFr8b/q78prVqxhw53LdWHekRk1N8jDO16d6AuzTnalVtlMur2Gb80V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:05.7627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe102a1-f936-4039-8b12-08df1422a034
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046

From: Manish Honap <mhonap@nvidia.com>

Sync the vfio.h additions from the kernel vfio-cxl series: the
VFIO_DEVICE_FLAGS_CXL device flag, the CXL Type-2 (0x1e98) HDM memory and
component-register sub-types under VFIO_REGION_TYPE_PCI_VENDOR_TYPE, and
the component-register geometry capability that reports the BAR and offset
of the trapped HDM decoder block.

The capability ID is provisional until the kernel series lands, at which
point this becomes a scripted linux-headers update.

AI-used-for: docs
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 linux-headers/linux/vfio.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index c85dcbfe30..c12e55426d 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -215,6 +215,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
 #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
 #define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
+#define VFIO_DEVICE_FLAGS_CXL	(1 << 9)	/* vfio-cxl device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
@@ -370,6 +371,12 @@ struct vfio_region_info_cap_type {
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
+/* CXL Type-2 device (0x1e98) sub-types for VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
+/* CXL.mem HDM region of a Type-2 device, mmap-able */
+#define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
+/* CXL HDM decoder registers: read live, guest writes are absorbed */
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS	(2)
+
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
@@ -497,6 +504,23 @@ struct vfio_region_info_cap_nvlink2_lnkspd {
 	__u32 __pad;
 };
 
+/*
+ * Geometry of a CXL Type-2 device's HDM decoder registers, so a VMM can place
+ * the trapped component register window where the guest expects it. The trapped
+ * region spans the whole HDM decoder block (every decoder), not just decoder 0:
+ * a VMM reads the decoder count and each decoder's committed base from the block
+ * itself. Additional trapped component capabilities, such as CXL RAS, are
+ * exposed as their own region subtypes rather than by extending this cap.
+ */
+#define VFIO_REGION_INFO_CAP_CXL_COMP_REGS	6
+
+struct vfio_region_info_cap_cxl_comp_regs {
+	struct vfio_info_cap_header header;
+	__u32 bar;
+	__u32 __resv;
+	__aligned_u64 offset;
+};
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
-- 
2.25.1

