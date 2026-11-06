Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937687;
	b=XpN86C6wYkG19atFem9apmHPyoCHUDWU2l30v+Qanm2fCLIvTBGLIzrbQd3yeRMmoy8k
	 h8jdeZqNMT9oXR2Npwpjz4M+cuuDbYls/eBDbWgQIhMDjlAmc0SWriXK119qHzjZ+gAOI
	 8UYpwEyj8HvZajrkEjF40GfH4MSDfPB/YDK+M+EmhMTY5b+l58jWuYr96m9J58N0DMgEs
	 606OeEdStUVyeaj+8dOlL9LxVgsK0VBEEgC/1hjTxddfi3hwXOwGFAWF/gxZxqpQJF7R1
	 HJgxGkYiyOSTeCP86XkKKBpThlDnjIBXG641UO76PyAyXvoMJQo6BKDHN1luJC0b7pQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937687;
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
	bh=oeeLwMFZTsKwVTIEP16VPKW6aekfEkE2QEyPoL+LWE0=;
	b=wRwaoW7/f5dSEzEr8MiJJaK9FfKfQ8ExKsyeYciXX2JV+stV3XfNO+kLVeTG/T9mum5p
	 eAO2xokt1HL1TYG6BjBNmj2UqKWjJFaTTaPKLmoEIdgdT2JAPsWG1U7NvgghLWs4ztyKK
	 ykFhmETSTOyxEUIiQQVrWxElj3MnjL1yOiMwveFWLdfH/efTcPlaFzAo/OkR1teY4AnDq
	 QNPxrWd+SSWgpTBizXtk5Zx8Ore7OsU/FTtDc80+3/w6KPVouKNhA9ly39PVxEi0luVuf
	 GbByQAfycItG7CFNVFgQbU1GvvTyhrlsb/3wK4+C4iMt3uPNMKYiDIrsqj9s90MM9zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qkjvwY3y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.28
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A9606A328
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B29A9606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qkjvwY3y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTjE/sskw5xgkHy8oNCbWaut687rheeucntazcocPvjxWY3jj6yhC68BCXkywxlUjxjMFA0vNHXDd58M5giMlZN+92P/EC1Ot94VR1KJegK20VlMlervNDxEirWP8Mn0oSFqGt3H7s2/+/bO1Cwt+68armewFH6RglJHu5ONbbqjhtyJDi2UxQOVw9KVc1vdOekrDJZKmqQlubuWvk3JQ43D2he73HDhNRw1EkcUfd7U13VwybB8VHmfm7868EVr569N4Q88P1HtNTSYlNLePvJPN0bwSsiRzsNWR/Gpv9+KJJyL3QQim1mfuv0uUYl8L2JehSxuktebM6cu5Fi5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeeLwMFZTsKwVTIEP16VPKW6aekfEkE2QEyPoL+LWE0=;
 b=nOWvYuwX/8m8IW9SrfKy+vh+WcFqC47Mro/Y27gVhbUnELB+wqon/OR36vNifD50F50AeNBrfOuTjE0TjZvvSSZu5JM9rr2GL31dqUrWCyWncbXfXHYtc2ggXN6jOCTJ1F5K37rkNxXSztZzbminqwOUKDXNMbYwGoG8Ucl9CQoc7UO4AbNjhFpjS2u2w6vvrh4XJm8I4+Mb4Iw+goKWd9gd/g+flNv4bltRxS0bQ6x1huoCIaPjDllfzlA1tpsDpX9DirJHhpWTlIPi9xpWK5yUqWw21oulyfGjuhyMxEvgLwbbSoXWFlKnoxkHYrg+i3+HIHZkJtZb8gPyPa2ADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeeLwMFZTsKwVTIEP16VPKW6aekfEkE2QEyPoL+LWE0=;
 b=qkjvwY3yGMnH1auwKRX8055SV/yHeMztjkyH/WlrKXBUoSxCHSwuZI7wCiqKVQlWBkj9aBv9cRq8UEEbQ136wIfO/SWwxhYoM1dMJYeO7Vlc0cNYrB1HuxpbX0kGRDOwJxEHQFwPeB+lG2VNPQPhV6TbI+1LTlwjnwnoy91qwhxFFwgAGQIZpn/XtNu8zix0YvyqOb/adYFzfpeb0OQReAYDCNJ1JNujT8fAH5k9EHcURPZ9SLGCW4P841VQeox3GKSAO6uRUjxBUxTU5vTINSaoKnc4evLLybUTuqzq+K/foYafDubXJl24fv4q7HuWBusOL3nkkNxzrZYjujwNOw==
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:01:14 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::5a) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Fri, 6
 Nov 2026 04:01:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:01:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:55 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:50 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 15/18] hw/mem: Add CXL.cache with cache write-back and invalidate to cxl-type2
Date: Fri, 6 Nov 2026 09:29:08 +0530
Message-ID: <20261106035911.1280066-16-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 32889502-b064-4b22-3122-08df3bba99f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|376014|1800799024|22082099003|18002099003|6133799003|10067099003|921020|11063799006|261026140227099003|5023799004|261026121527099003|261028144727099003|261102123227099003|261021130227099003|56012099006|261021135927099003|261022105027099003|261022113327099003|261021121427099003|261022115727099003|261021123027099003|261026130827099003|261021133027099003|261022075727099003|261009223027099003|261026135527099003;
X-Microsoft-Antispam-Message-Info:
	xQLUbQPZ9aJgPkxwh6dPZmzL2BF9P8wCoD9G3tjXx9AVrMJi3NAO/TIqAQU3HZ1El0p0tMM84nW9b0xG+fVzBSCNqnSOxmrFky21ufiVL85eShQtZKMXY32vwoLufiucklOLEVF9VHXZGseU7N9IGgrRhf9N0zcsPpeIoLWljGRs40KESVIbZHMa7N5m0C/F9ouHwy9Ob4MlkmZ7oUpYTwK/EfjQ0m6Cpz32vawrgIN0v4bkUKh1Scydetk8Iyqyx3v+0VulSVWh0vURcfPYNZENNIvc27f1Ef9fWDNhAb7hXApUer05eDNRT8ScnNgcShPrvK8CJGpJZRD/TEq2hgPBV7D8Qsfs6/Pc5L5LRRgPJpB/AlfHOnjVDjYL8k/avxbwhjgpYC5QswmyYg/PkDtxljceObaNr17C5jaFqnFWIWysLeSuWNrRSzJa7iEjv4lib/BnDiE0CXdPKafLPmfIXQzBygPDI+1/1qnB72bU+XYMfQrRcj4LJ3pYYsgmmbLVwktNfVrYHHlG/IepQIgYqW0zwUJWTSRLtCcFCfuXDbF0f5SrEijmEbqlz5uAI8xT7LInpK+9ZHyKCslERQaEWL7oCrdYFPPsX9ZFaOdQ7w0Qn6seG2Y6sLKagYD7o/znrRDwr1rgKkvN1wXRdfjszbgKyJEBxzgtZ9y+mZV0JJ1N4gWO1On79HNdBXvlx6vRoB9k7B2ZtirPdA14zumGNd+6t3xlm3EPsZ8uzMlNKK4k+WGdDvRuGnjw/gwu
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(921020)(11063799006)(261026140227099003)(5023799004)(261026121527099003)(261028144727099003)(261102123227099003)(261021130227099003)(56012099006)(261021135927099003)(261022105027099003)(261022113327099003)(261021121427099003)(261022115727099003)(261021123027099003)(261026130827099003)(261021133027099003)(261022075727099003)(261009223027099003)(261026135527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HFVc0d8JIHBmM+KpKm4joYH+8ynPd9c306w9EkEZUIw+8Y+33SAlqeQFo8vIJc+meY/YSvaKQIiCUO8Zj5Vz9l+n/anKmqXdT20fOGd2aV9K5YwDyO8iK6UvCCHAfKMsFI6Nbx64W8+YlusH9UJSg50PiqrxEIlZ7OYl1lJtGWs6aaGRysbL710otbt/Bpl40rcXDw3RGoovKcGb8zSYgu8dQ9CbmyLhUszaXx405duBwwV8iSAQJBQexQ0zP/g8SpfqDuAMnbX6g3Nf2Ap3J9eej/UDCBAH5cU/raIM/6gxZRlUDf0fQ0dcIUsFzvSBBJmL8YnNBXmVQO3h/NDkAhWu0TyMX/eSpsh4X4Zdj7h1mDmIEz5umZ8WTYp3vuznkOpN8XaGzM+gEqR3b0zQyJNKyYimx+a75WeqqUXEn+UvKizDcJw5jZHmFQqwOE15
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:01:14.2656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32889502-b064-4b22-3122-08df3bba99f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029

From: Manish Honap <mhonap@nvidia.com>

Advertise CXL.cache in the Device and Flex Bus Port DVSECs and let
firmware set Cache_Enable.

CXL r4.0 Section 8.1.3.1 requires a device that sets Cache_Capable, and
is not an RCD, to also set Cache Writeback and Invalidate Capable and
implement Disable Caching, Initiate Cache Write Back and Invalidation,
and Cache Invalid. The device holds no modified cache lines, so a write
back and invalidate completes at once.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/mem/cxl_type2.c | 66 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
index d0fe14afda..54d1b34a4c 100644
--- a/hw/mem/cxl_type2.c
+++ b/hw/mem/cxl_type2.c
@@ -170,6 +170,11 @@ MemTxResult cxl_type2_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa, attrs, &data, size);
 }
 
+static uint16_t cxl_type2_dvsec(CXLType2Dev *ct2d, size_t reg)
+{
+    return range_lob(&ct2d->cxl_cstate.dvsecs[PCIE_CXL_DEVICE_DVSEC]) + reg;
+}
+
 static void update_dvsecs(CXLType2Dev *ct2d)
 {
     CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
@@ -178,9 +183,9 @@ static void update_dvsecs(CXLType2Dev *ct2d)
     uint8_t *dvsec;
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
-        .cap = CXL_DVSEC_CAP_IO | CXL_DVSEC_CAP_MEM |
+        .cap = CXL_DVSEC_CAP_CACHE | CXL_DVSEC_CAP_IO | CXL_DVSEC_CAP_MEM |
                CXL_DVSEC_CAP_MEM_HWINIT |
-               1 << CXL_DVSEC_CAP_HDM_COUNT_SHIFT,
+               1 << CXL_DVSEC_CAP_HDM_COUNT_SHIFT | CXL_DVSEC_CAP_CACHE_WBI,
         .ctrl = CXL_DVSEC_CTRL_IO_EN,
         .range1_size_hi = size >> 32,
         .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | (size & 0xF0000000),
@@ -195,9 +200,9 @@ static void update_dvsecs(CXLType2Dev *ct2d)
                                REG_LOC_DVSEC, dvsec);
 
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
-        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
+        .cap                     = 0x27, /* 68B, IO, Cache, Mem, non-MLD */
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = 0x26, /* same as capabilities */
+        .status                  = 0x27, /* same as capabilities */
         .rcvd_mod_ts_data_phase1 = 0xef,
     };
     cxl_component_update_dvsec(cxl_cstate, PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
@@ -221,10 +226,11 @@ static void build_dvsecs(CXLType2Dev *ct2d)
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, NULL);
     update_dvsecs(ct2d);
 
-    /* No CXL.cache and no CXL Reset, so no Control2 bit is writable */
+    /* Disable Caching and Initiate Cache Write Back and Invalidation */
     pci_set_word(PCI_DEVICE(ct2d)->wmask +
-                 range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]) +
-                 offsetof(CXLDVSECDevice, ctrl2), 0);
+                 cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, ctrl2)),
+                 CXL_DVSEC_CTRL2_DISABLE_CACHING |
+                 CXL_DVSEC_CTRL2_INIT_CACHE_WBI);
 
     memcpy(ct2d->dvsec_wmask, PCI_DEVICE(ct2d)->wmask +
            range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]),
@@ -248,11 +254,49 @@ static void cxl_type2_dvsec_lock(CXLType2Dev *ct2d)
     pci_set_quad(wmask + offsetof(CXLDVSECDevice, range2_base_hi), 0);
 }
 
+static void cxl_type2_update_status2(CXLType2Dev *ct2d, uint16_t clear,
+                                     uint16_t set)
+{
+    uint8_t *reg = PCI_DEVICE(ct2d)->config +
+                   cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, status2));
+
+    pci_set_word(reg, (pci_get_word(reg) & ~clear) | set);
+}
+
+/*
+ * CXL r4.0 Section 8.1.3.4: the device holds no modified cache lines, so a
+ * write back and invalidate completes at once.
+ */
+static void cxl_type2_ctrl2_write(CXLType2Dev *ct2d)
+{
+    uint8_t *reg = PCI_DEVICE(ct2d)->config +
+                   cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, ctrl2));
+    uint16_t ctrl2 = pci_get_word(reg);
+
+    if (!(ctrl2 & CXL_DVSEC_CTRL2_DISABLE_CACHING)) {
+        /* Cache Invalid reads as 0 while Disable Caching is 0 */
+        cxl_type2_update_status2(ct2d, CXL_DVSEC_STATUS2_CACHE_INV, 0);
+    }
+    if (ctrl2 & CXL_DVSEC_CTRL2_INIT_CACHE_WBI) {
+        pci_set_word(reg, ctrl2 & ~CXL_DVSEC_CTRL2_INIT_CACHE_WBI);
+        /* Undefined unless Disable Caching is set */
+        if (ctrl2 & CXL_DVSEC_CTRL2_DISABLE_CACHING) {
+            cxl_type2_update_status2(ct2d, 0, CXL_DVSEC_STATUS2_CACHE_INV);
+        }
+    }
+}
+
 static void cxl_type2_config_write(PCIDevice *pci_dev, uint32_t addr,
                                    uint32_t val, int len)
 {
+    CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
+    uint16_t ctrl2 = cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, ctrl2));
+
     pci_default_write_config(pci_dev, addr, val, len);
-    cxl_type2_dvsec_lock(CXL_TYPE2(pci_dev));
+    cxl_type2_dvsec_lock(ct2d);
+    if (ranges_overlap(addr, len, ctrl2, sizeof(uint16_t))) {
+        cxl_type2_ctrl2_write(ct2d);
+    }
 }
 
 static void setup_cxl_regs(PCIDevice *pci_dev)
@@ -325,8 +369,7 @@ static void cxl_type2_firmware_init(CXLType2Dev *ct2d)
 {
     CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
     uint32_t *cache_mem = cxl_cstate->crb.cache_mem_registers;
-    uint16_t ctrl = range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]) +
-                    offsetof(CXLDVSECDevice, ctrl);
+    uint16_t ctrl = cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, ctrl));
     CXLFirmwareHDM range = {
         .valid = true,
         .base = ct2d->fmw->base,
@@ -335,7 +378,8 @@ static void cxl_type2_firmware_init(CXLType2Dev *ct2d)
     };
 
     pci_set_word(PCI_DEVICE(ct2d)->config + ctrl,
-                 CXL_DVSEC_CTRL_IO_EN | CXL_DVSEC_CTRL_MEM_EN);
+                 CXL_DVSEC_CTRL_CACHE_EN | CXL_DVSEC_CTRL_IO_EN |
+                 CXL_DVSEC_CTRL_MEM_EN);
     ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER_GLOBAL_CONTROL,
                      HDM_DECODER_ENABLE, 1);
     cxl_firmware_hdm_program(&range, cache_mem);
-- 
2.53.0

