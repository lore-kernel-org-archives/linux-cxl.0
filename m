Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937651;
	b=D4AMctfSZ4CLl3JRkoFdGLcTmUtbRwwHhKpKAhReMy5ad2hFRXrFtsWuat/hCgnDNI/8
	 Gx1+Pt5nt9RjBcP+DE+OgN/2znmCKuCJkoZ/CccKAfKePQP5gexzlUKA9SBPx8hx5BPRD
	 xU41W+7U1cMU01NMdp4ebklv5iL1sZtcS+Lt9SRMHiejIdgR2LQVMugV/WrRt1zFjs1FL
	 N4937KQcXN10DgYTlgIlWXJ62RZAmYOfz8A6Ud05od+A3uAX5Ks5pmypAKUziQ7lwhGot
	 5q3tK1YXSi/0zZ1onVKKAhYIj/qtubndbpWSi67/c38HhmEMMyccwlubyjy0eHaki1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937651;
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
	bh=Jz8rXauZuDNetlVUYeUra3Rx/iaDTurDfrVI/qF5WOA=;
	b=Jm3/zIpiw8C1dUHkjKVJdKHXot6bFEoFYwdj1tuxTPy24EaICw3HcZ+B7TrozZcBBLUd
	 FOdKmpBPEHJgTP//NAbVAi6eiPBQ2MEKqSvxFfWO+oeuACLmBwvMyoeDQOvZNd7LAJkbm
	 BsVFydYD7w6MPbq9S/gpTdPUIiUkjAjN6Wtx2tySvD7mN4wXMX1AgqpcVExp67H78/gXh
	 CIf++Y5p+feY1BHNeUSp++bYzOchrYqps35n9zZuQTCbJhMvnaTECIoB/l4DqTh6LXWzR
	 6RtFMDwEnNUpy0aulKv6MMmEG01du4tNwhHiP6LVaN+5R8THpmOIuq3ahAik+JIRZuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SalmEeUD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.33
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59546606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59546606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SalmEeUD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWrYV10LuGWjl6plprjveFi5k4fF31+LlAjxAIlCoU63HL/0hxOZr5iZWdTcm0kyLEmVYqlovCbR+xK1NgWZrx61Tw1FNo0AdRj/MxDWoANWy9ytNwNgkSVlONDT3pKgq3puLaT8LQfBc6utL30RKcHB2FkoIO8GskPxItv/heTTTT82I8aNI2CkW1x92YuJas8d1DcnuLRpabcC7T+ZM09wXgqNFIyqAS08AUpPBdZn9MhmkGWZwjmZ36GxRPqPmRPdSMRK0ZFOS4hh/Jbqg508/SHF6W7SViM8khrT715MupVTLOpuA1zK097MDAGedGk+ThkeNZcXoTxcLzMvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz8rXauZuDNetlVUYeUra3Rx/iaDTurDfrVI/qF5WOA=;
 b=BR4uzhgI5TtF1wseEGW+sLH0LTr5z5+lS239xooLDOpTh6DLcuE5AUzdDvhu5sTpfF52Q5aUvlFf4XI3Sc77XM2kIPvkCxGroC6p1lZTy6ppeCJRoXF1tfAbGYTUbj2HmrSf3rW1tYnPdDFy8tmmCT7T7hOpEiC6CfmRglvti1OP7QcwUXjDTAs2vlGPsin/xdxH33848FoJ67mQyzZWEPBQYhSyg60AihoQaWJXfU3p8PfGz/hKQiV3ynCOiW4rFhv9k2Su4Eyx2QnvwqmuP6C2bUpGfL+CzWgyfMKTplyCak3Jab+IIYIh9srZRqQWq0gXOLBNNWRZfYdAZydgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz8rXauZuDNetlVUYeUra3Rx/iaDTurDfrVI/qF5WOA=;
 b=SalmEeUDuel8mhAVnpgUKaisde38wiWEnefJbI9EIR1G99VNzY5NtpFClHJzHELUWXX7wSS/wXDxXGOMFcyfv1dKQWS6fjbKu3i+1dwcrA4TFrVo+r/eUVkhgjpQjpe3NPOtrrkwfH6P6L60Hcg0tNDAKDPKDZP9HkqcnvWWY1mjwX9npSXoAS8xi3KtQXcrPYws8LmNRQE3BRkT67SHtiuA6FVhFBJetqUoTJaBnITTkl2/94w3ZqMR7n8872SkT/N762V8OrcUcQirU0SxcgfLICfhye3JvvkARH2vFk3az+W64SBs6IDvEWyrQSs/0yR0Rbj8rqaP6MZyf7t2TQ==
Received: from BN0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:141::25)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 04:00:41 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::44) by BN0PR07CA0018.outlook.office365.com
 (2603:10b6:408:141::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 04:00:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:22 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:17 -0800
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
Subject: [RFC 09/18] hw/cxl: Add the CXL type-2 DVSECs and component registers
Date: Fri, 6 Nov 2026 09:29:02 +0530
Message-ID: <20261106035911.1280066-10-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a90b6b6-de59-49c3-e4bf-08df3bba8673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|36860700016|82310400026|921020|261026130827099003|261022115727099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261021130227099003|261021133027099003|261102123227099003|261009223027099003|261021135927099003|261022105027099003|261026140227099003|261022075727099003|261026135527099003|261022113327099003|261028144727099003|11063799006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IdcVpbT1PBGR2BF0AKm6RoZKRZkuULnO3RIQktLZQrV6MTNIJyKRO0vTzgPFpO8dUHh3ozOqw9iA3Acu4u0Gqm73YwkFS4QcDpt/NgC84R6859MfjulWAgVQtbqyAmWH194vJdFl8JaHzF3c3oZ4uet5StE5p5c/RXvrTDVqUrUCZS5BxkiLym/Y3H87w4ZRP8UKZCOutrB0mkULCEySQk26nRPYK364pVziV+MctRCDFreBFfAys03ksvyR/q6SzEN0JVzHy8/gynNzPm+T9VLO2Hsf1eePQwcPpcq5VtU8neN8p4D2AJNCBt+Arjhc4YrxC1kkQMS7V2z5EdDLG4M9TkWG8rmVMNm31agTk4/doSE6LhOm1VMAeCn7sTbcC1errIHZpMUdUwVHEX04NEFS5L9+/5aywsKayxoPXBrKr+YskdLCmhCv8cu0I8BtuuJPpQO02dBz/6b08geyNMs69/dEIt9J4QgrGce90MfQ92d8QMCzaq201+0bcUdD7ZnocjEhxgKkqavFMXT6IOxqyQLjUkd60Hg4Q9rZV8dKsFyBj2WVX20rfTjkSe5MtsPssaVWZC8rgUUnnC3UyLhZ3LSbK/FhuhDaG/MOo3yInjpGDNqi12KJGHDnF30kdT//V1KA7UTBr+RnbLar+p9i0/+D7zLUksZyNiFidouyDlAlDHe4+YigHJjCoYyltAkNjKnkJu2cy+CKthSwyM6pa6fVliKtWcv3IfPXa3/Yy9a+1P9ON+RG/hV1ds3x
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(36860700016)(82310400026)(921020)(261026130827099003)(261022115727099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261021130227099003)(261021133027099003)(261102123227099003)(261009223027099003)(261021135927099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026135527099003)(261022113327099003)(261028144727099003)(11063799006)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0jTCba3UjLUhhv6GIjh9KgyVoIc9pqQPnDWWXyClvU4p3vGPK/8JtU4mHL0zUqln8pKBdcaBZC7K+LimHU3jcwB/FFj5bPEBAFqscQgu2/924eQ4VwWCz0CfpQYUH7oGB42rQEqrX7bbQXxZXw532H4J89AS2YeoXz/8w7rEV4smiF7cuhbd6+gS5GbCC4oJxpagDaBlfjcTf0L2YaRviI9hMXu5xwDdFMuEK6PU/VsSCasMZIb3ppNLKZRg0MRzvnenwJ7YgVT/VvJ6ApnORQPcQ5IwsVXhfaT6f+3uFHc0RzJreJRNUKULNKWjZEQioElzRWuZ97K1PPt2evmmF8Id3d+bYbLNIqQFJ+qsLDjs0rV6ygxnF3hDO0mQkl3PT+o1le4DPKHtbR2nJWqQiSoiYju+n0V313ssD+5sqfYrxU0PDMGCWxG3WzZ3CCJn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:41.3923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a90b6b6-de59-49c3-e4bf-08df3bba8673
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

From: Zhi Wang <zhiwang@kernel.org>

Emulate the component registers of the CXL type-2 device with HDM
decoders, and its CXL DVSECs: the PCIe DVSEC for CXL Devices, the
Register Locator DVSEC and the Flex Bus Port DVSEC.

The DVSEC values are refreshed on every reset, so that registers such
as DVSEC Control return to their defaults across a system reset.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zhi Wang <zhiwang@kernel.org>
[ clg: rebased on upstream ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
[ mhonap: - second part of the original patch, renamed to cxl-type2
          - device DVSEC: CXL.io, CXL.mem, HwInit mode and one HDM
            range, with the bit names from cxl_pci.h; CXL.cache is
            added together with the cache flush support later
          - device DVSEC Status2 left at 0 and Control2 read-only, the
            device has no CXL Reset
          - CONFIG_LOCK makes the RWL fields read only until reset
          - one HDM decoder
          - fix "DVS Control" to "DVSEC Control" in the message ]
AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-component-utils.c   |   2 +
 hw/mem/cxl_type2.c             | 121 +++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_component.h |   1 +
 include/hw/cxl/cxl_device.h    |   2 +
 4 files changed, 126 insertions(+)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index f4a7fdb425..f9bb1684fa 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -362,6 +362,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
         if (type == CXL2_DEVICE ||
             type == CXL2_TYPE3_DEVICE ||
+            type == CXL3_TYPE2_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
             write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
                 0xf0000000;
@@ -449,6 +450,7 @@ void cxl_component_register_init_count(uint32_t *reg_state,
         /* fallthrough */
     case CXL2_UPSTREAM_PORT:
     case CXL2_TYPE3_DEVICE:
+    case CXL3_TYPE2_DEVICE:
     case CXL2_LOGICAL_DEVICE:
         /* + HDM */
         init_cap_reg(HDM, 5, 1);
diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
index 4769793e06..b179d1e884 100644
--- a/hw/mem/cxl_type2.c
+++ b/hw/mem/cxl_type2.c
@@ -48,6 +48,109 @@ static bool setup_memory(PCIDevice *pci_dev, Error **errp)
     return true;
 }
 
+static void update_dvsecs(CXLType2Dev *ct2d)
+{
+    CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
+    uint64_t size = memory_region_size(
+        host_memory_backend_get_memory(ct2d->hostvmem));
+    uint8_t *dvsec;
+
+    dvsec = (uint8_t *)&(CXLDVSECDevice){
+        .cap = CXL_DVSEC_CAP_IO | CXL_DVSEC_CAP_MEM |
+               CXL_DVSEC_CAP_MEM_HWINIT |
+               1 << CXL_DVSEC_CAP_HDM_COUNT_SHIFT,
+        .ctrl = CXL_DVSEC_CTRL_IO_EN,
+        .range1_size_hi = size >> 32,
+        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | (size & 0xF0000000),
+    };
+    cxl_component_update_dvsec(cxl_cstate, PCIE_CXL_DEVICE_DVSEC_LENGTH,
+                               PCIE_CXL_DEVICE_DVSEC, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
+        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+    };
+    cxl_component_update_dvsec(cxl_cstate, REG_LOC_DVSEC_LENGTH,
+                               REG_LOC_DVSEC, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
+        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
+        .ctrl                    = 0x02, /* IO always enabled */
+        .status                  = 0x26, /* same as capabilities */
+        .rcvd_mod_ts_data_phase1 = 0xef,
+    };
+    cxl_component_update_dvsec(cxl_cstate, PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
+                               PCIE_FLEXBUS_PORT_DVSEC, dvsec);
+}
+
+static void build_dvsecs(CXLType2Dev *ct2d)
+{
+    CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
+
+    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
+                               PCIE_CXL_DEVICE_DVSEC_LENGTH,
+                               PCIE_CXL_DEVICE_DVSEC,
+                               PCIE_CXL31_DEVICE_DVSEC_REVID, NULL);
+    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
+                               REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, NULL);
+    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
+                               PCIE_FLEXBUS_PORT_DVSEC,
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, NULL);
+    update_dvsecs(ct2d);
+
+    /* No CXL.cache and no CXL Reset, so no Control2 bit is writable */
+    pci_set_word(PCI_DEVICE(ct2d)->wmask +
+                 range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]) +
+                 offsetof(CXLDVSECDevice, ctrl2), 0);
+
+    memcpy(ct2d->dvsec_wmask, PCI_DEVICE(ct2d)->wmask +
+           range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]),
+           sizeof(ct2d->dvsec_wmask));
+}
+
+/* CXL r4.0 Section 8.1.3.6: CONFIG_LOCK makes the RWL fields read only */
+static void cxl_type2_dvsec_lock(CXLType2Dev *ct2d)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(ct2d);
+    uint16_t off = range_lob(&ct2d->cxl_cstate.dvsecs[PCIE_CXL_DEVICE_DVSEC]);
+    uint8_t *wmask = pci_dev->wmask + off;
+
+    if (!(pci_get_word(pci_dev->config + off + offsetof(CXLDVSECDevice, lock)) &
+          CXL_DVSEC_LOCK_CONFIG_LOCK)) {
+        return;
+    }
+    pci_set_word(wmask + offsetof(CXLDVSECDevice, ctrl), 0);
+    pci_set_word(wmask + offsetof(CXLDVSECDevice, lock), 0);
+    pci_set_quad(wmask + offsetof(CXLDVSECDevice, range1_base_hi), 0);
+    pci_set_quad(wmask + offsetof(CXLDVSECDevice, range2_base_hi), 0);
+}
+
+static void cxl_type2_config_write(PCIDevice *pci_dev, uint32_t addr,
+                                   uint32_t val, int len)
+{
+    pci_default_write_config(pci_dev, addr, val, len);
+    cxl_type2_dvsec_lock(CXL_TYPE2(pci_dev));
+}
+
+static void setup_cxl_regs(PCIDevice *pci_dev)
+{
+    CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
+    CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
+
+    cxl_cstate->dvsec_offset = 0x100;
+    cxl_cstate->pdev = pci_dev;
+
+    build_dvsecs(ct2d);
+
+    cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
+                                      TYPE_CXL_TYPE2);
+    pci_register_bar(pci_dev, CXL_COMPONENT_REG_BAR_IDX,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &cxl_cstate->crb.component_registers);
+}
+
 static void cxl_type2_realize(PCIDevice *pci_dev, Error **errp)
 {
     if (!setup_memory(pci_dev, errp)) {
@@ -55,6 +158,8 @@ static void cxl_type2_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
+
+    setup_cxl_regs(pci_dev);
 }
 
 static void cxl_type2_exit(PCIDevice *pci_dev)
@@ -62,6 +167,20 @@ static void cxl_type2_exit(PCIDevice *pci_dev)
     clean_memory(pci_dev);
 }
 
+static void cxl_type2_reset(DeviceState *dev)
+{
+    CXLType2Dev *ct2d = CXL_TYPE2(dev);
+    CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
+
+    update_dvsecs(ct2d);
+    memcpy(PCI_DEVICE(ct2d)->wmask +
+           range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]),
+           ct2d->dvsec_wmask, sizeof(ct2d->dvsec_wmask));
+    cxl_component_register_init_count(cxl_cstate->crb.cache_mem_registers,
+                                      cxl_cstate->crb.cache_mem_regs_write_mask,
+                                      CXL3_TYPE2_DEVICE, false, 1);
+}
+
 static const Property cxl_type2_props[] = {
     DEFINE_PROP_LINK("volatile-memdev", CXLType2Dev, hostvmem,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
@@ -79,6 +198,7 @@ static void cxl_type2_class_init(ObjectClass *oc, const void *data)
 
     pc->realize = cxl_type2_realize;
     pc->exit = cxl_type2_exit;
+    pc->config_write = cxl_type2_config_write;
 
     pc->class_id = PCI_CLASS_ACCELERATOR_PROCESSING;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
@@ -88,6 +208,7 @@ static void cxl_type2_class_init(ObjectClass *oc, const void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "CXL Type-2 device";
     dc->vmsd = &cxl_type2_vmsd;
+    device_class_set_legacy_reset(dc, cxl_type2_reset);
     device_class_set_props(dc, cxl_type2_props);
 }
 
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 3ed8dab92e..b38e81d129 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -29,6 +29,7 @@ enum reg_type {
     CXL2_UPSTREAM_PORT,
     CXL2_DOWNSTREAM_PORT,
     CXL3_SWITCH_MAILBOX_CCI,
+    CXL3_TYPE2_DEVICE,
 };
 
 /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index aeccf42855..9c83421d0f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -839,6 +839,8 @@ struct CXLType2Dev {
 
     /* State */
     AddressSpace hostvmem_as;
+    CXLComponentState cxl_cstate;
+    uint8_t dvsec_wmask[PCIE_CXL_DEVICE_DVSEC_LENGTH];
 };
 
 #define TYPE_CXL_TYPE2 "cxl-type2"
-- 
2.53.0

