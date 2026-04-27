Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221293E958E;
	Mon, 27 Apr 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313707; cv=fail; b=Ee4hPVc/RxH47YjW/AXAk8Q3+f1rHibczzMD3jalBpOgbFZZWAdOqyqXAG5n3UBtL0DQw+2fn4Fo57jJ8nvh8xl/ACV03xSfVTmFBSHJhquHDr/81iAAbjQWwV2q5/OKL7LlbE7AEBYR3Gsv0zaMaVt670w+n0vXKIble+BAyVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313707; c=relaxed/simple;
	bh=tAK7LeXi62+9us+0loZezlZIGouVH3YGkYeW9Dq2I3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fR4bXUMNHSoyEo3euKTRiElFx7O+RdZd+jegnn7exCHx0afMRe2dahDKdDFKMvpJSK1fuaRJ5rdPt0KYKAHleaXfrwjg4azTWRJ2A5CXP4CwMTc4sTBhPfMmPifAl0Q4X2USsywZ856lQ6sDG4EZr+iE6bNxq0xpig4zWnyCBGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RNK4V1H2; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNK4V1H2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxCmETYSDWy6SgsnCtRuPHfpBtVVIIvYAqRKwSCRdh3Fnxcf4kS+KkMAcgONZo61zZ+SyMGD/u8VZnkBRvn27+B5zjl7RLL4invXop+zpwlO2GrtiMhdHOHyw29/yFYSSf7kDvXLYYSG2Bje123Ge6JIxoIbCI/Nl2qeQWwwZDLl/DwkhiqVuRc3BEmAoZ2CFWQ+//KUCuPv9NbNabII+gM7KDGL+xmHphOb7G68n+hNZWv5xAkbqaPilfLwnLrXLgP1V7a3SjpEUwcVkokUapVNNCLjHLmQB9VeueX4fxgR+qno1NIRWjrSMjIMVo4Db8XsKf82bmcL6rjsbGPgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSkxixl6ty0mR2L2DuoSTBnD7O+GqEJhhqrxwvTBwvk=;
 b=Gquzuhr/uHM2ct8BsEtlG0Ycab+VrWv30UIu7fYtuMIOBDBpcM2Bsvd9SagDp4mw3b6d06o1SwMXYXkq7kBNRewh/6zUm+rjsPbCaweDa/NWLjOlVRGPxeAXQzbVoVplAo4DMjlrY4mnlwoQ+6HMmKWyCMs4l89E7iJiEV9WS1Ch1e1+Sj7/40oNxyP0JOCJ5/DmwoShA5emed/ld70tRrWRKdBHONLPdZeh4SlwP11ZF2iUQgxF3Zq/y62S7NZjHmNfpE7liDMXfBOPiZU7ZgDxjvOFf0EoAWVb/GA9VAjZBAPJa6yvw2zcbSlDcne8+1mv9Ka7AuqGZwjfYC/4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSkxixl6ty0mR2L2DuoSTBnD7O+GqEJhhqrxwvTBwvk=;
 b=RNK4V1H2E3t0I55AmTtYouGOzKINiMNWMUiivgVG8VMOiPZJuXhQZ/T1tcniMYIzKFJwGNH3E/VSVErR8Q5reG85zDF2khPxUIBkv5CIhmxaEF4pW6Skaj6GfrEEBHOy6c6Jm9ALlVS1FOb6gFDzVEKxgJ8mmFDwzsj+esgRyGYf9fWEsucERRn/kUGnvsBr8BrAflxh104JXk7AcOcqtZR4EYT+8rwwKVtzJVkveg0g/qkNyKPCKflYXjUPxsvFU3TYpugdWnSmN08XIpGaMAOsG8+sfZUQdSxnZpR70wMsT1yYYD+rg3IQ5L9QyTqAhhtCJ+z0GYhYrCH5fV9HSw==
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 18:14:55 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::96) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:14:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:14:33 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:14:25 -0700
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
Subject: [RFC 9/9] vfio/listener: Skip DMA mapping for VFIO-owned RAM-device regions
Date: Mon, 27 Apr 2026 23:42:35 +0530
Message-ID: <20260427181235.3003865-10-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 00024a03-dfee-4293-5e99-08dea488e204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mni4ZTlaNXFIJIicT8a0lBKLrUxIbdjXGVAtaxRuXSuMx7ctU8GXmCGIHtr7y+r3IgT9yVQKR1e+tCCRDf4zeh0NreG4cXe7DZe4f3ZMj9w0+salXzBHbVCZqRsxdjOuAvYCI8iGgYE58ZIVfBg6QJY25vHIownWmVy20GBPSSDmuQNq1EGzoGhVuVP5hJXSqix6gf5H8L8VZoaSxRbxEkJuHGvb/mWNMw8S16U9j3NluxPCX9LJhq2Jygb3oqHKCja1SpiD3lGfQeYPosmJvIOegMOzcTBt0o34bzphmsDMkvPCT5oEeYpkvRcTOu6mOK6HbenXKgEJnE1DgYuDhuWdvEL+Rd1YcpTUEyn4KmSt5TWUwQM+Kb6hJ7HyIWLnpH6c8mso/LzEEmw8taHHzr0l0inKZc+DvdaTFqwHWl1tpiK8hCBR3rWDR5tFkp537AENZaWEUfyIF8+C/P+kuvUUtc3Q0DHYvz2xx++GwiAiflR/U4pJ/ciR0JiCZpHdj+0OA3MeO2T+yR1RVR9/WsyHnyKoKc8XbaYtM0CJjPklEIy4kv8iNl0xIM4hLJmGAM4oF1XcSVMByV/sA3cw5KN1re/seucYHapedTTbCoT6m8z5U+Fqea0PqDfCt8XI1vB91utTsn9qxFC9Uf+/8bboM95COW+b8N2OnkhlX+sUHYHFe08gtY6CgPh3Gn3Ux+MSQH3nMnHEvRgCrk5gQSAXUAjk3UpUgowIgw9la7Bibek4Yc9Tq97ftji0C2nFf30FpY9WH52ct4T90K8dKNnZ5i2d8/yBWefX4fJZP4EdC4apY+VHa4OEzu/RYG47
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iJkJVTKPV21OueNuCeWULUALlNIcbEcEQSxGlRLVfaPS6+zSXVtp7vaktr9R0g3N5PJYCFDKiNUeu4SiVb05GpI3R5FdpGjCY6mrR11Sj/gQxoFNi/0BtSS8PfiY/nKE3JCMG5tMSJBc8Kd5CeaJby+DBu99cH3r99pI+0E8GZlorpLqpGs/cnTo26MfIem57vewvTA+BGuB4lqsobU3Q43atjh4gDCmMrp2QE66pF1CSozAtXE0vrfak9pBhnA8zH/N+9FHAx6R3UkIZj5s8LIWtoaO080Hv8UdiAyPuWbqlqSuUcKaWzXOzP2mebQ74md9zqS05OA6+2yTHFAOfvPq60IR+031ghl9fX5maXkE+FOKXdLqKEq2FDeBBVdFFUYiCvw7rcYnvmWFaZ3QI+uXORyNJ2UBxvZMT4zBw9/yf7jNI+GTp3c/b2BxKu9k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:14:54.6718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00024a03-dfee-4293-5e99-08dea488e204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

From: Manish Honap <mhonap@nvidia.com>

vfio_container_region_add() attempts an IOMMU DMA mapping for every
RAM section that enters the guest address space. For VFIO mmap-backed
regions (PCI BAR windows, CXL.mem regions), this mapping always fails:
the backing VMAs carry VM_IO | VM_PFNMAP flags and pin_user_pages()
refuses to pin VM_IO pages, so IOMMU_IOAS_MAP returns -EFAULT.

CPU access to these regions goes through KVM Stage-2 page faults
independently of the SMMU/IOMMU, so no IOMMU entry is required for
correct operation.

Add an early return for RAM-device sections owned by a VFIO device.
vfio_get_vfio_device(memory_region_owner(section->mr)) returns non-NULL
for any mmap subregion created by vfio_region_mmap(), since
memory_region_init_ram_device_ptr() propagates the VFIOPCIDevice owner
from the containing region. Matching on ownership covers both normal
PCI BAR windows and CXL.mem regions uniformly; non-VFIO RAM-device
regions such as NVDIMMs are unaffected and continue through the normal
mapping path.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/listener.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 31c3113f8f..46cad18357 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -608,6 +608,20 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
                 pgmask + 1);
             return;
         }
+
+        /*
+         * VFIO MMAP backed regions (CXL.mem) uses VM_IO | VM_PFNMAP VMAs
+         * backed by physical device addresses. Skip vfio_container_dma_map
+         * as mapping is not needed for this region.
+         */
+        if (vfio_get_vfio_device(memory_region_owner(section->mr))) {
+            trace_vfio_listener_region_add_no_dma_map(
+                memory_region_name(section->mr),
+                section->offset_within_address_space,
+                int128_getlo(section->size),
+                pgmask + 1);
+            return;
+        }
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-- 
2.25.1

