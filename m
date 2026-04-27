Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD53DD50D;
	Mon, 27 Apr 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313661; cv=fail; b=BuOIuBoqrUUbiniY2RAs7zPcOOONIzvSk+/D/4x/QzWVliMJBvDjQywekgz46WHh2Ml0A3ZZwLsEuS98Tj5cE4Joi8m84S+klSAJV6d0jStyJxPXtF640Wk4zRbgk2OfF2Ylz5EtpyI0pK3uza/fnaJ1scQDLGjvOeFp0HyEkns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313661; c=relaxed/simple;
	bh=SLyZCAvE9ArljQO/Yvte6XgtV2z/K1IMvIZAUbhOxPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsJOAn2gFNX2oBzprcTJY1dYKvj9YyKDM09ehHQHyCI+wo0dSENkI/lv6Mu6YAY/cAqrzA0OrORfjX5Wrf8W/GYRZDmf77B7561rMgoaTd1fPIUve1zv04P/5NjsDMPwXxcSaJogFtNHOmVGMM4XxCSkd/CXH9b924ZXZ6GL2Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k+pyAjzL; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k+pyAjzL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzqMsi911SrgnB5pbfl79hWhLPOUf1sgn7FS6GAEwOXV//U9+UicHEo6UY9T7XdT8eNbtWeIcCQJGtHgdBavNGperu7vs4ysOLsMrFUFQL8S70bSWJb3Qk3c2b7j2QwdI1D2EBUzhlYXzFrX2F5KoeLjbiFbppDzH36ZJmkXmFah65eAj3IujwneF9vXQrc8yF8cko+2LZcypoS+72ynGaW/3PcdWgAUHv4Tw70kr4pB0M5XTsAwPuc892f64j24TUZJXvlEFS/sp8j7uzzocuzRNareesSnnyMRr3HgqUF20JU7TRDmp4J5eG/VJ9hPbwNxSJTxHCykistFM4VNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX1Nj7BB3BWHUjYgZUhGaqW1s17IUPGCCDQ39if0X14=;
 b=nL+LaaByKh4nG5miMFVCl1yZguMMWGHZE7bVlAyWbvRrzCuJzPbjb1STvEQbY1PHvz0ZsCAfI2+WXO/jFnfZ1+DS6DRzfQg4QkkHN9Eq+R2jfOB60VVs6VLszhzef+pIOBQ+JrorXLquxDpbx+a8scrKSbz3VkuhmzyIMYTKhXewZ6u3MiWr7q3Kpm0guV1AuGdkZdC785jkw9ZbZj4s0psl4nIeROoDmma2eTXyMmpk3ymuLIprB0iX2bFFgOF1i0SVgZ6nMZ0cRrJiMnyeiriArCbJIXvFoCDnmUd04DL2Hvx23Pt9rORrlrSwQTwZkCZLVkVuFwglMOm93gKthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX1Nj7BB3BWHUjYgZUhGaqW1s17IUPGCCDQ39if0X14=;
 b=k+pyAjzLD3EXXOzLvMs8yB+WcAq5+grDxhBsvBcVQtj6fhmKtakyjAp6YGvaqRf3bYy0BTgffgtKjP/rOc5IGVhPVZile0gDHVrLhJiBN3VQq9QddL+ERenPc9vMtUyFdLlPOMmEFgQCfpnhAryszCRhuvv2OX/nfa8gu6+WlS64fBjjRWbzJ1B+HMcfcm7ooh0KhJd/NuBoS94ky40eXbw8z2pcKC5FgB/AQXznGSkLdYW5GYP28A/zIvDBPMiy/8uTohdC6Rn+00HgsBNCVEG9t+jovBo4Tv0jbrh6GUebwZNaHmfCzNeU+n35HzlFGB5KUNV4sQS+z+s8XaMSBQ==
Received: from BN9PR03CA0883.namprd03.prod.outlook.com (2603:10b6:408:13c::18)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 18:14:07 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::b7) by BN9PR03CA0883.outlook.office365.com
 (2603:10b6:408:13c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:14:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:13:43 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:13:35 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>, <ankita@nvidia.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
	<fan.ni@samsung.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
	<marcel.apfelbaum@gmail.com>, <clg@redhat.com>, <cohuck@redhat.com>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	"Manish Honap" <mhonap@nvidia.com>
Subject: [RFC 3/9] linux-headers: Update vfio.h for CXL Type-2 device passthrough
Date: Mon, 27 Apr 2026 23:42:29 +0530
Message-ID: <20260427181235.3003865-4-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260427181235.3003865-1-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: c91c68aa-cc24-44e3-5072-08dea488c56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	NOirRJeu/eGYudNj1nciC3miNkxveyC/kzbA7mUla8C+PyYz3Yl8piMWRUJmzq6EB2JeDPQeK2UGoEAvWjQDi2HgVgE1BQb9MnbWPOiJ/GljAQs0gLAHLCtCHQPGDJgzswjr+T3S0oc2PHwJyzmTgYCbyIm89wrigzlh5RtZaOsVNADnmxjyIvQ0fxOYoxobQdtR/uv3pAi719GjovsWrjyX9QYABPrSEOM48ula4pnfthxhaQGtCge2532W+272jteWmSLzFmrTaL3yiExL3/eLm9f9kMyAoDyWAD5aMJpqhTcD6ZO0nghJfSkte+mnAtgNFe9yYHqphPSYC7ImanBlnt0MHCLUyb0hFk6XB0PO55+64QKKIlo/fqniOcwJiTecPnRZyv66j3COtmHwA1vO6omgBtKrSuLG/xwN6u45bP6X5UGYdfMqtlAcmh7vBnA9gpPJgNGrssMN8Mpg0jNJ2V60RrjMYqZZAD43cxYM/h5IcikYBNvn7LkADLjrmEoaEViphMIRthbkpRVjRWeILSzDC1uyFqTnbTmx9fAGs4PqdNN3BH6//s5+tfZhZWhp9WlorfQsDE399mLfo3aJ3MOtcSsFOWu6uAr71OpDjlmp0U5V00N0y8hXmlKDDlxqgAuo15z6mcw5ElsGFcxjmU+OiNkyk9i7eS/M7n4T1BLTqyw1OOjlaasB4/Qa+PeKb2qebfETuI7GTLdqguEmG72aftygUJwkn4c4Ovz1Vpa8A4BYda7ffyLfReFMPJjGAqRSg/0WKGbSZEkugPqpBXsBlaMfDs3HdXwCjYzhZGlgMe3VxpFvi+1RYL9L
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vEAypvaoCnu5fE7T0HAQvwoJf0Kl+qh0ohSGoc8kYEih9sRD+19lt4TVdG8sAGC9Mhp+kEHgO+JNSQ3P9kzoP63WV/jWkmBEzkDK1iLl0q1IMswVQe+bNu5lIRfpr+FtxAkiXXOZuvEhW+EpGNOazwopgwX1q5NjK5d3hOhvgg+7nrv8RgmQqVNqpxZr+7aL5NUvb1tMZWipxtaZXWUsbTZAMDYMncRiBNp4SHdaPG2aAYXoTKN2KJbxQZxpOnwMdlI2W+1FbR8KQkOuCa4fZK9EWz8fJ+yWF5qoszmHC4YJIc9In0UImujslkcmFNmp1Ra2hhrmlyje77JVxX4IbhPqe3ojFwXOQkIXEpOeZZiV3VqLmhU02OPsWfYBzJw+h7hIE5+NrpaAma907KZTFpBmN0qnfLJpoHkJ79bBOtR7Q07biyeKmN9BEM6K8OuA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:14:06.5928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91c68aa-cc24-44e3-5072-08dea488c56a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

From: Manish Honap <mhonap@nvidia.com>

Sync the VFIO UAPI additions from the kernel CXL Type-2 passthrough
series.

VFIO_DEVICE_FLAGS_CXL (bit 9) marks a device as CXL Type-2 and
guarantees the capability chain includes a vfio_device_info_cap_cxl
entry (cap id 6). That capability carries the BAR index holding the
CXL component registers, flags for firmware-committed and cache-capable
devices, the byte offset to the HDM Decoder Capability block within
that BAR, and region indices for both the DPA memory region and the
Component Register shadow.

Two new region subtypes:
  VFIO_REGION_SUBTYPE_CXL (1): mmappable DPA memory
  VFIO_REGION_SUBTYPE_CXL_COMP_REGS (2): HDM decoder shadow, r/w only

Note: UAPI headers are normally kept in sync via
scripts/update-linux-headers.sh once upstream kernel changes merge.
This patch manually adds the CXL Type-2 additions as a temporary
measure to unblock QEMU development. It should be dropped and
replaced with a proper header sync once the kernel series is accepted.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 linux-headers/linux/vfio.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 720edfee7a..62cd725a39 100644
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
@@ -257,6 +258,19 @@ struct vfio_device_info_cap_pci_atomic_comp {
 	__u32 reserved;
 };
 
+#define VFIO_DEVICE_INFO_CAP_CXL			6
+struct vfio_device_info_cap_cxl {
+	struct vfio_info_cap_header header; /* id=6, version=1 */
+	__u8  hdm_regs_bar_index; /* PCI BAR containing CXL component registers */
+	__u8  reserved[3];
+	__u32 flags;             /* VFIO_CXL_CAP_* flags */
+#define VFIO_CXL_CAP_FIRMWARE_COMMITTED (1 << 0)
+#define VFIO_CXL_CAP_CACHE_CAPABLE      (1 << 1)
+	__u64 hdm_regs_offset;   /* byte offset within BAR to CXL.mem register area */
+	__u32 dpa_region_index;  /* VFIO region index for DPA memory */
+	__u32 comp_regs_region_index; /* VFIO region index for COMP_REGS */
+};
+
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
  *				       struct vfio_region_info)
@@ -373,6 +387,10 @@ struct vfio_region_info_cap_type {
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
+/* sub-types for VFIO CXL regions */
+#define VFIO_REGION_SUBTYPE_CXL           (1) /* DPA memory region */
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS (2) /* HDM register shadow */
+
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
  *
-- 
2.25.1

