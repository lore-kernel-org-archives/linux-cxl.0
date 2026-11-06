Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937659;
	b=YwMNOqI2vYPKDYhUPXNENlK13/KmnwqxsSqasdZLiFDkxX/MxKlsx1a2ONRHdhySvkne
	 HS1Mie2f8qBNRgb5A+slwMtzDALkISsNQj7GuxXKdkOSnvw8tKkT1Bq6v981ehxUyNIz/
	 1WoRZWa9q1gsfORxubvnuRIJKwwekbmoxFM7xuBayHMJ3Bv08N3xet7H8IzehpbRpARyd
	 9QYqXF75uWbmY4SiozKbyu7zol3rBMxktwStcAidjzb7o98v8ZZKUNy9unhJhPir1Z37Y
	 4fYqJGen+FV0j0nXdfjqdFaEL0PxGFDaGU8UzqCZfmJzFkeeMNiaAKe56DosDJ1StaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937659;
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
	bh=AiiN1V/PdRBUWVhP6R0qpADqjlY+Wt6F4iEMfMsruEE=;
	b=Jj5CPI8kCIVICv5r+s0M0rGOKJbdsHqcKv5yWSz/GR9RBxA9Q80RKe05BkunLiYf8vw6
	 wmiZA+bbW+t0FfjOqms+3usbAvgvv1RRuRR2G77dClegZZhFQ6ljXoVplXN3wNZfruuqG
	 XlkHLvdh3/66C23zEeCA1UUH1xs6gov/B9P6YXLeIGYJZUuB14M5mzbzS+kcF4+uBVaBL
	 8S5qSqtiDt2QrXWToh4zCoZBgmSAhBmiURIMLUCXhwEaXiOga1EQUqnSfCT3VUVbmxkLh
	 jc0PHdqiPqeYZw63ZZNG/yG2FKE2jz0Yh9UrLVaOySR1kLxPhjmgBaZyYG9timccpWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UISQqjSM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.26
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAD606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84BAD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UISQqjSM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgY87R9+WpY/N5o1b/7WNXgf1MZvbO3Gk29IqM21ck3vCfYV1PAxNVtVYW2quNia8S+toa7aSsQuaKkUHCXsI61tO54oZVH07Kixj1kZR90HrByBfsMDyc0Fj5xeLSxIAIHHyTwOPjoNuUw5cJvgp8USgPCzpAeWDIVMIHYh+5T21We+njra2qfeMmsFAjgvGrL554fwJY7T7/h3qkyHVD+PyIYwAYZaiFXLMWyPXD7O6ucs+GyOVMd3mAmMoWV/GKj82ZMoLPjB0+PdUv5On+eWubOCoHC8hpZCJGoczFtIK471n19d7dchi6Y77GvnqLDo093YrV/qj9QAWQYQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiiN1V/PdRBUWVhP6R0qpADqjlY+Wt6F4iEMfMsruEE=;
 b=FrKn1m7ol1pdAL0DCZna/8SCRrykfXELSqjH2L/jteCzWfI9f8kgyx/p6QkJhUxook7hRc6wBPHIhhgKdnG9OKjfRX1MDS88bDNpCNDEeBFCQlVEosW6CrzWjPQijuxzWA6nUXJMV2njzbYwDum12xEo5jCBYQY63VtZ0iBMKh5Un0BeOtsrpDjE7lxk2ARO4WrHIalo0E/kTELtZVPy7VbQ/g6F60yrIyi+6gR7K7dREKsTMMij/UfddQifn6K1gBPU/bMRcj9z60rDmg/PQDFwF9qoksH1BM7+3ydNZm1b9LKxwxrYUDhWaHGRcOd2qxpl7eSIh8UkeuyzDJuEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiiN1V/PdRBUWVhP6R0qpADqjlY+Wt6F4iEMfMsruEE=;
 b=UISQqjSMeyY91sR636j6OqP8ned/IO0kDK95QVA6MSAD3rlpVYLcCHCTJ+aUfJeAUTsXrIzW3NoHQNshlo7e/m5fRlSvT3JHK0R3rKzJsKBiZ+eAA6+IgP0kkx2fuuWGNgBGGsAYrT6udmKxOwC+gNZtef/oX+kUoWZ0Odatt2nLCZFhoPappytND8FhQMeTcmPcBO8dDU/ijZgxfsdVAi0Pv7vshN9b/OeR5iYh/gUKGoRBeRSu8aebbVTex6ohpKq+vFWrPeS7g+2V5vUnLooJwkZMMCmKi7A5Kict9/1p5HY9QtwdHCXmjxlQui+Z/A/vUpqWx6IgcKStB4a4Gw==
Received: from BN9PR03CA0313.namprd03.prod.outlook.com (2603:10b6:408:112::18)
 by CC6PR12MB388577.namprd12.prod.outlook.com (2603:10b6:170:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:00:53 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::9b) by BN9PR03CA0313.outlook.office365.com
 (2603:10b6:408:112::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:00:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:33 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:28 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 11/18] hw/mem: Require a CXL root port of a pxb-cxl for cxl-type2
Date: Fri, 6 Nov 2026 09:29:04 +0530
Message-ID: <20261106035911.1280066-12-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CC6PR12MB388577:EE_
X-MS-Office365-Filtering-Correlation-Id: 418f99ee-8c5e-47a0-b974-08df3bba8d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|22082099003|18002099003|10067099003|921020|11063799006|56012099006|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261021123027099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	L9rP2W2nCh6RsDCuuhor+NIXFGBPwdIwbuCRQQV3BPj3AMYyFSy/pE/3+DUyQ1hRtcpXmcbHix2o6K85LvmVvppRIsLC+qCpMLfttwCAKCEGOPEBy50OvdiNYqSxIkqkQvOK7l6D/hFH43UE2uU6nvj4liYmYCIjF+IMIBZm6+3t2xWZ0ZtR0N4kNTF5GRPIRRAEv2FVJNPYLK/fu9NEEtARN7L8Wzgo3BbUNAXY7R2hHPqE2dem6OdrFtv1C/siivxTaSEAgtl+kwOWCs8DSm6OJG+LaBqUIVCf5Km10k4ybgLt58tCYzvKnkaz1HTZoFebuFPe0tUFzfjycAao9MdOyEEmzFGP2v6nn6VXD9PexNqAkTqfl6aJbi7jDayLyO/uJQgHHSndbM7F/nJudw/dAaVZ8PLnkadd8wpHxhZ//APolhsQ/cUJUTBY2EmRVJTy2VujjALazWzSJD3U87Hre4u/V31qhfnaMo5Vw9ujEN8fi4/l13/f9AIOsYMrpzXGZle2ZatQsspFsAB+27xOXzWlPlGToCM6dPsiP1nPSWqvOzYCiMbPI1S7NXPha5FiBQri05HikoWtrAUqbon64y+j0Hkdk5yn3/mYnmdskPW58km1DEYtNRHxQmUBZhdH0+7CDjIdRuT07zjvP5KE1hBPKRy98tLTPWXIloWWzrIz2CHvsGrKupNUTfZTFg5P0RJh8NNqwadWKBpcC6PTsYiMj23k0tvD58zrZrLLY2Mr9QRkIEqRWq2vw+VD
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z8Lf9JDs9uItUP/wsphwE0Wa5zGQ1pO7JGyCXHPeimEcFQ+3GkRc1mTJhmxBnuXW/5DGi6POafDoXEpk5u63B3086E65fSOlcDE/em2TFyOFGGD8iG4RwsJ0B9kJOkE4Wcj6UoLTGknAkRMRExo5VKQ5owKGeOejU93lln/FZlF6tBs+J7IqvIwtkeLTlCKyzjzHBcGTMcm5ciBYIUR3NLZBLYVzNmz781wxKlzsitIrHrtlrt2KshBeopnK0yZ+/BOlguhgds476TMaOEGUXKsaaIlu97/8qHlW1RyfHBbf1X5JKvlDPcFbZpgEzt4HzoF2zdwhApwq6i6aXa4wmLsTjWk0IHvXjfFkgUmMT9TojLvEgFoK0H3vNRdS0EVraxj82X+KHQB4bWPG/SjFF6Gjm78GgwyrgCmxi4GqsW7hUWsYnAtzHt+lfms4XgWH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:53.1408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418f99ee-8c5e-47a0-b974-08df3bba8d75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR12MB388577

From: Manish Honap <mhonap@nvidia.com>

The firmware decoder setup added later in this series commits only the
pxb-cxl and device decoders, and cxl_cfmws_find_device() routes only to
devfn 0 below a port. Refuse any other placement.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/mem/cxl_type2.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
index 60f3f04679..ab89d332dc 100644
--- a/hw/mem/cxl_type2.c
+++ b/hw/mem/cxl_type2.c
@@ -11,6 +11,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_port.h"
 #include "migration/vmstate.h"
 #include "system/hostmem.h"
 
@@ -22,6 +24,29 @@ static void clean_memory(PCIDevice *pci_dev)
     host_memory_backend_set_mapped(ct2d->hostvmem, false);
 }
 
+/*
+ * The firmware decoder setup covers only the host bridge and the device, and
+ * cxl_cfmws_find_device() routes only to devfn 0 below a port.
+ */
+static bool cxl_type2_check_topology(PCIDevice *pci_dev, Error **errp)
+{
+    PCIDevice *rp = pci_get_bus(pci_dev)->parent_dev;
+    PCIDevice *host = rp ? pci_get_bus(rp)->parent_dev : NULL;
+
+    if (!rp || !pci_is_cxl(rp) ||
+        !object_dynamic_cast(OBJECT(rp), TYPE_PCIE_ROOT_PORT) || !host ||
+        !object_dynamic_cast(OBJECT(host), TYPE_PXB_CXL_DEV)) {
+        error_setg(errp, "cxl-type2 must be directly below a CXL root port "
+                   "of a pxb-cxl");
+        return false;
+    }
+    if (pci_dev->devfn != 0) {
+        error_setg(errp, "cxl-type2 must be at slot 0, function 0");
+        return false;
+    }
+    return true;
+}
+
 static bool setup_memory(PCIDevice *pci_dev, Error **errp)
 {
     CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
@@ -190,7 +215,8 @@ static void setup_cxl_regs(PCIDevice *pci_dev)
 
 static void cxl_type2_realize(PCIDevice *pci_dev, Error **errp)
 {
-    if (!setup_memory(pci_dev, errp)) {
+    if (!cxl_type2_check_topology(pci_dev, errp) ||
+        !setup_memory(pci_dev, errp)) {
         return;
     }
 
-- 
2.53.0

