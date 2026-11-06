Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937652;
	b=WEny+f2TQZ2aInKxFYznDQNqG8rqA0L1EoLWS9/9BJiN7RCS8ILu3qMaxjELQKqi+iTZ
	 X5RUu3BeZ1nweZDm4/vRdRG5S1qS7wSDYOKGVlXKXikVl/jwvvBme7/y6NShnOWBPXBHp
	 WxpHgrJQ8c7ovihlecKW3PpLA/LelVWrTnHlOnrgE5FbdRsFXK/4Jlr5YHj+tbjWogze9
	 MA+iwNDSWai7Ls+WO6SvjmgEL86K0TX7MexTcJwRMAelix826I+Mw9e6VGXn2hbGqrrrF
	 lh6O3+rtS56PC2SdR04iVFZVcMLoHFfhjvhan6iQ/0mScz5XgWhDYfDGFHWUsyeMnOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937652;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
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
	bh=Ef5iCUAOPL/XsmVR2A7ZOVm2u5CzXq82x8JWIiDj52M=;
	b=H6dfNWk/+mdZ81IVS6e1upmwRAxWdsaId4c5Ite8CwHBGX1/gvVvs5FYFiXfV0E8vhcM
	 dR04IwVxgXly1AvACC3JHIvGyFPGLK+lrsGF9rZts91f19oVLK5IDFTPy1nKmRzGR+4To
	 6pM9quGSDE68eIq7eKUTM6afRSLT7GGCMupwDzirm3Z7U53yZ16V2FveM4ry7Nng+CV0E
	 FhAWQvASIUPb3Oc5ZT/PfqLRXTzoHNgTjbYxUOFee2MU9agLvnwR0MKGpojLnlOHsUswm
	 dV+a03wYMeugLDgAhrqjYJKueApS80iCwcZ5WIa3s2txBwyLN94HuuJywATBnwB56DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K513trPu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F49606A329
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F49606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K513trPu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hu13OZsXWXxckE14KVuTSpkinT6Dwxp4YbzonCs5y5jvlcVT4f03+PsvINpvaEnlamjzBhXRr2P3VoUmw5MyEXl+XGlb7naas7fsnbCfZCtGxoo3thejUgYA6OssMVtO1IKL9xfJGYaT4lmA2LRuKoK4lFQwL0lhjwKVPmEgOsOY/WSABHTDT44mQX/b52/hRxivEg9gd3GKNDqo5dQRRm2xnYvSt1XuqWUPxEi/dhbcntdhRzE9eI8eJwjFA+nhdvQms8+cJw/C9R4KIMuwIeit/b69ZlowpHa4+5uh2VPjysSR+ksMm3nTDUF28n8jCB1+/BseGmUZ0gBzj0nZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef5iCUAOPL/XsmVR2A7ZOVm2u5CzXq82x8JWIiDj52M=;
 b=Ke/+cGu9tie6uUrWSjVklm4yQdHi6TP9vkIcmn0zbg8r8t3GsYAO12UjA4utCTssGDcTRHLg5QEjSTJS0EjM2kwMiIjKuB6R4OV1KN5hshZGuQBD6iX0lx7DZ+E3KHVSTSQkP6q/t6bv8qwVqwsIxD2g2sucNAMGVbxxpXFXAMkIwiD4s6Gnd1es4BlloMQLD5Q8zGho4EIbp3vul5Ih2Upbya10jt2rARSoTMyQ8yBjOiITFXa4i7bMg//yCiJ0WCb9vD8wdPnx2dJLMc0LCoVNy86wja6d5ci2rS2Rbth/gbM6qqpRpeAEjM0E0/mHw+CMq+c8c08EzKTsZ+zEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef5iCUAOPL/XsmVR2A7ZOVm2u5CzXq82x8JWIiDj52M=;
 b=K513trPu1fRZE2OaIG1OaKuUXBuRIg1vf46w6b3ID3IRHyC/LsjNFrdpbsNvHr9fWoq+CvsEkYSvQWgd/wGoRRoNgEMRxgQ7tYhnhmFpJy4V1I5bx9jxdY5m2kwozgYHCko4zCF1sFkLo/+yvrT5D2EnwOIQf+ev4RkLsJL0QZ2xyQ9/kQYF5k+RPklnBnFC4zYEBzAiM53v9ca+4S0GPJOki702EpL0xrzmo65wBMToA+kjXARu6j2AsY1FSKgYBEYafsnqA8vKux1MritvTPLJGaYZpLTkhcEE3VnuLFQUBylFVcDD+uzY4P4J0+OV1qZVEbf990zFSmKmrBBpMQ==
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by LV2PR12MB569619.namprd12.prod.outlook.com (2603:10b6:404:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 04:00:46 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::4d) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:00:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:28 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:22 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Zhi Wang
	<zhiwang@kernel.org>
Subject: [RFC 10/18] hw/cxl: Map the CXL type-2 device memory through the fixed windows
Date: Fri, 6 Nov 2026 09:29:03 +0530
Message-ID: <20261106035911.1280066-11-mhonap@nvidia.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|LV2PR12MB569619:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e5ced4-7821-4dcd-0c1b-08df3bba899c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|82310400026|36860700016|921020|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hBVRLOhUt+VwvTrUX6Ei34V62tuwuX9z8SyUV3nE/p4iT+3YlgLsy8mOMu5awVCy28eUgq64wgVK2sQ1lU2VbptKPtTVJDmO9cplfu00C54FjpdYjt94eeau7fDgfU72zl/umg9s9hIPCZ9b4JrnBnsZK2BRgiSCAHw8kjaipE6755u9Uc8MSs1iWQ7I6Ba2//9qX4aCyEjkjNOtlA8NwZx/Qpj4qxmFzYXz4VA/9G3nVrQFwJMIYH4aNZrjAVo7HYqpwkH1+ZTqrHeF2GuKB8a5YN2I5jSS9AcCAydZm23zbPByn4GTNP+N95npoLl7HKyw/6PWNoLP9pZvNWBHpIdADQXUiBfjsQZ1l5d0QmzQKgBlHyeQ/FDb6bCx2snTiUqf+mlkXiXs8MTPwn+6pHoM4yUrZb8CxpSXLXjJXvloxS3bwLH2TCNhiCYRtT8FnusED+FrAcv3HBIB2LJgI5km0ztoCxW1fZfrNNiA3oXjD/qXLG1YcG1ch+8zQoAMq1Nsht64Ar948+9t/D5aS9uWvWeTdp+oSiQ23+3/D1sJPxqRMSBlqrwTZi0G61L92oyhknY4/YqAkjz9XH7iNCFTUYa2JFImgN9d3XnRctr53kqjVgAMZH6TwUJBQpbSkpiSla3+8iuuJ7AX+nj3C30FqQ3fbCwhpLp9r69xko+MCTkKCA2GTUxEFyLsq0IucyWM56ehNnZsSggUNUYpUqmiVsdObsha3I2XNCvcH9CBOowPuHLbXuoBIQThpAzI
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(921020)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zLuh7Vv8qdWnw7YV1zsAbzGdqJkPo52GIdT5ozwYzZuVShMqGCjy8alb47kEcqEqMOEv9iugT0/HMnO2CtWxzhw4kyJREnBu3y+Sud7VRknt9LmLdSLc4YjohnLAC78C7eZonse6nV1JjDtRzy8NapcGLoG1naZM+68BArgCbzjk5TeEr3suWpIWvkS7RX2wjckZSJdnw83WsUjcW/SI4kP4jaeOcsADHuK0F5QmPS+hcnELbvFZ84RdJZUz6XP8SHyorLuAkDqoRHkEJl2wc/AVjbf8bNRe/9baUIN0x8UesET64cLGuBQ1CGLDBnSDL7q7I/NDB4d0k30/Es2lCjJqSbvWRshsySCezk2s/AF9SMFeSUrEVj8ziWg8CSxsV8Mi1G0mEBg6ICzBmR04M2cwJegzcnMLFpr4wQ9pUkSvO9DqO6ABBEGtN9fktPcC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:46.6842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e5ced4-7821-4dcd-0c1b-08df3bba899c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB569619

From: Zhi Wang <zhiwang@kernel.org>

Let guest accesses to a CXL fixed memory window reach the volatile
memory of a CXL type-2 device. The device decodes the host address
with its HDM decoder and accesses its memory backend at the resulting
DPA.

A committed, non-interleaved decoder also maps the memory directly
into the window, as for cxl-type3.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zhi Wang <zhiwang@kernel.org>
[ clg: rebased on upstream ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
[ mhonap: - third part of the original patch, renamed to cxl-type2
          - add the device to cxl_mem_device() for the direct mapping,
            and remove its mappings on reset and exit
          - stubs for builds without the device ]
AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                 |  2 +-
 hw/cxl/cxl-host.c           | 20 +++++++++++++++++++
 hw/mem/cxl_type2.c          | 39 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type2_stubs.c    | 20 +++++++++++++++++++
 hw/mem/meson.build          |  1 +
 include/hw/cxl/cxl_device.h |  7 +++++++
 6 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 hw/mem/cxl_type2_stubs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 57a78bc6a9..fba3e29ee1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3399,7 +3399,7 @@ R: Anisa Su <anisa.su@samsung.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
-F: hw/mem/cxl_type2.c
+F: hw/mem/cxl_type2*.c
 F: hw/mem/cxl_type3.c
 F: include/hw/cxl/
 F: qapi/cxl.json
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index d9c7599679..4bbbcda14d 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -223,6 +223,20 @@ static bool cxl_mem_device(Object *obj, CXLMemDevice *md)
 {
     CXLType3Dev *ct3d;
 
+    if (object_dynamic_cast(obj, TYPE_CXL_TYPE2)) {
+        CXLType2Dev *ct2d = CXL_TYPE2(obj);
+
+        if (md) {
+            *md = (CXLMemDevice) {
+                .pdev = PCI_DEVICE(ct2d),
+                .cstate = &ct2d->cxl_cstate,
+                .hostvmem = ct2d->hostvmem,
+                .direct_mr = ct2d->direct_mr,
+                .direct_mr_fw = ct2d->direct_mr_fw,
+            };
+        }
+        return true;
+    }
     if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
         return false;
     }
@@ -577,6 +591,9 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE2)) {
+        return cxl_type2_read(d, addr + fw->base, data, size, attrs);
+    }
     return cxl_type3_read(d, addr + fw->base, data, size, attrs);
 }
 
@@ -593,6 +610,9 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
         return MEMTX_OK;
     }
 
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE2)) {
+        return cxl_type2_write(d, addr + fw->base, data, size, attrs);
+    }
     return cxl_type3_write(d, addr + fw->base, data, size, attrs);
 }
 
diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
index b179d1e884..60f3f04679 100644
--- a/hw/mem/cxl_type2.c
+++ b/hw/mem/cxl_type2.c
@@ -48,6 +48,43 @@ static bool setup_memory(PCIDevice *pci_dev, Error **errp)
     return true;
 }
 
+static int cxl_type2_hpa_to_as_and_dpa(CXLType2Dev *ct2d, hwaddr host_addr,
+                                       AddressSpace **as, uint64_t *dpa)
+{
+    MemoryRegion *vmr = host_memory_backend_get_memory(ct2d->hostvmem);
+
+    if (!cxl_host_addr_to_dpa(&ct2d->cxl_cstate, host_addr, dpa) ||
+        *dpa >= memory_region_size(vmr)) {
+        return -EINVAL;
+    }
+    *as = &ct2d->hostvmem_as;
+    return 0;
+}
+
+MemTxResult cxl_type2_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
+                           unsigned size, MemTxAttrs attrs)
+{
+    AddressSpace *as;
+    uint64_t dpa;
+
+    if (cxl_type2_hpa_to_as_and_dpa(CXL_TYPE2(d), host_addr, &as, &dpa)) {
+        return MEMTX_ERROR;
+    }
+    return address_space_read(as, dpa, attrs, data, size);
+}
+
+MemTxResult cxl_type2_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
+                            unsigned size, MemTxAttrs attrs)
+{
+    AddressSpace *as;
+    uint64_t dpa;
+
+    if (cxl_type2_hpa_to_as_and_dpa(CXL_TYPE2(d), host_addr, &as, &dpa)) {
+        return MEMTX_ERROR;
+    }
+    return address_space_write(as, dpa, attrs, &data, size);
+}
+
 static void update_dvsecs(CXLType2Dev *ct2d)
 {
     CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
@@ -164,6 +201,7 @@ static void cxl_type2_realize(PCIDevice *pci_dev, Error **errp)
 
 static void cxl_type2_exit(PCIDevice *pci_dev)
 {
+    cxl_fmws_direct_passthrough_remove_all(pci_dev);
     clean_memory(pci_dev);
 }
 
@@ -172,6 +210,7 @@ static void cxl_type2_reset(DeviceState *dev)
     CXLType2Dev *ct2d = CXL_TYPE2(dev);
     CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
 
+    cxl_fmws_direct_passthrough_remove_all(PCI_DEVICE(dev));
     update_dvsecs(ct2d);
     memcpy(PCI_DEVICE(ct2d)->wmask +
            range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]),
diff --git a/hw/mem/cxl_type2_stubs.c b/hw/mem/cxl_type2_stubs.c
new file mode 100644
index 0000000000..8962f55552
--- /dev/null
+++ b/hw/mem/cxl_type2_stubs.c
@@ -0,0 +1,20 @@
+/*
+ * CXL Type-2 device stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cxl/cxl.h"
+
+MemTxResult cxl_type2_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
+                           unsigned size, MemTxAttrs attrs)
+{
+    return MEMTX_ERROR;
+}
+
+MemTxResult cxl_type2_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
+                            unsigned size, MemTxAttrs attrs)
+{
+    return MEMTX_ERROR;
+}
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 0b2c193a78..0d20588636 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -7,6 +7,7 @@ mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
 mem_ss.add(when: 'CONFIG_CXL_TYPE2_DEVICE', if_true: files('cxl_type2.c'))
 mem_ss.add(when: 'CONFIG_SP_MEM', if_true: files('sp-mem.c'))
 stub_ss.add(files('cxl_type3_stubs.c'))
+stub_ss.add(files('cxl_type2_stubs.c'))
 
 stub_ss.add(files('memory-device-stubs.c'))
 system_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9c83421d0f..22ca2f5978 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -838,6 +838,8 @@ struct CXLType2Dev {
     HostMemoryBackend *hostvmem;
 
     /* State */
+    MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
+    CXLFixedWindow *direct_mr_fw[CXL_HDM_DECODER_COUNT];
     AddressSpace hostvmem_as;
     CXLComponentState cxl_cstate;
     uint8_t dvsec_wmask[PCIE_CXL_DEVICE_DVSEC_LENGTH];
@@ -846,6 +848,11 @@ struct CXLType2Dev {
 #define TYPE_CXL_TYPE2 "cxl-type2"
 OBJECT_DECLARE_SIMPLE_TYPE(CXLType2Dev, CXL_TYPE2)
 
+MemTxResult cxl_type2_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
+                           unsigned size, MemTxAttrs attrs);
+MemTxResult cxl_type2_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
+                            unsigned size, MemTxAttrs attrs);
+
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs);
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
-- 
2.53.0

