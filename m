Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937608;
	b=UHPSUs1sQLO2WFpAoPOVZI8sJkfG0cBqgcrcLGJ4mHrh/8pir9jAFyb8855OzdUBU/K5
	 +2HcilNYpwLXzSP6f8JI8dXV8otDYqXQVbFQXjblH/o3EQqywZKnV34XuJsaS4oyJIpoj
	 bT10kdtTIKwDciYrp/nH0dZAFYT4uEUr6BYzW8Hz2VQgTwNXjjOHSZB3NvwnnDKQYO+NN
	 bxkh6Y9e7jeBeiI5NebHF1k9EbgbeZak0VkWnLcR5fXodmS7XeO7wguqYnAvRmWMzixe7
	 iRuosY/H6hOgtBr6xA1cQpWBEVmD/dZWmBEecT39+BpylGRDG7tl954ctBgxWfvDYLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937608;
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
	bh=E2oIRhr4+PpV8qL2ztAHDI1I/psYhZIPI965XzwrCJI=;
	b=3a19fhJTeOA36itQ3/65PEklFeRGZev631JLceByy9I9qM11s3kK6WUwnI6KjspMy44m
	 bgw4zAOjAIsHkjokDRfAgE0eA2OEJZW4aYqx/r+wVIcAgFzepgdcX4eVOHwxLC1sG/2SB
	 Rw76o1v3iJ2eJ2jcP16ziSHs5lMFagGmilSWIA86O6/O7sS908mxHXvqflZYvijj82qui
	 naoORXkWzTlEdZVj7MBXOyQISMzqSiCIx2y+cCRp/MLU1nxsGdghb7nf1n5dLeL8qJy+8
	 G7h+kqWRGvuEkBdMFNmSjtuSczJZAoaBdGV/PHNnLQeBpZGrUYtYKPdLQ4Zt03oTtOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=awYMyIcl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.59
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF680606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF680606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=awYMyIcl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPfahe/pwY0WicNrQZHLP5vYvMGqlWT31dRkS6NOj9lLd14JB1BWRGbtW0tlOKrR4OfiIG5PscAdl5S2cghz6vsh5j0N77ZNy3xDTw3yFzMDASxSpflVeKvkXnTtfIzkl8GPULA3J+Hzy0R72jZO3MofarBFFTn/zTkrCUbU0k5EvsZizSN0IElAnKeLC4ffBDuY8nOFgMaZZksRhrlKYYmpf92mxWMkh3iGvlH6EMyxAr3tNhMW2++3n6yskbfT+heO5aZEUfL9nEU/XuSnG3RWwOhnyiMtKbm4lftNi9vYuqJuCCY5oT3VGpGTk0gGWizlVHTNC+Omf/ZnMWpuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2oIRhr4+PpV8qL2ztAHDI1I/psYhZIPI965XzwrCJI=;
 b=bw4JVxm0QQtubsVwX278LOvFliiz36q4azKPd5JzRrEWOt5uRuFpE7U/hY6n9MiHOtJJLvAvvACD0OKF3D+0Pzjy+XwPKbaSsxrufsYDolsufozIXFOmQ7CtP0RgUcVBFqV3/Isjop6xB5HWOpTs7a3SHQZ4R5sCAw28z2vZQPGWZGyuRshHafhjRsHNanP9HAwPICa2JbY16a84OuCAIJWbw22KQW9Rc0yH6U2Rd0ZbQgo7A+Sksbzj32XzwBaJqp8HjferGZHT6wEQMVwK9eoJye5OwawFOAXRJO8fWLkigkALMnFKmyklNL5416C7lEW64HtA4sBrr+sVrwz1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2oIRhr4+PpV8qL2ztAHDI1I/psYhZIPI965XzwrCJI=;
 b=awYMyIclXE5e1hVnKya56GpOxMcB6wsF3agx5dS+bpuPmfk2aRIxdSVYSTUngaXvfcm19aqI5Q6ubkXJGcXNotG3mCG+7BdmdXC7/wjuko2Spx+2avJ3HcveNdOoShA34FHNEkkQTPzmYd3qUH6nxF8U0DIE4PIGCTrbo1dEjEAl2WPDhInSEi/ybPgLydfAPzTFipXPwYhrGYcs8bNq0wuWZy8lgZXLiBx7bz+yTrdM3iLKTyUIpdno15WH7cLKnx5BRSkTUXNh9N8A0PRSLph8lI3/1UWmjbucT1YD1a37jWEvuA1r7p+M5jxGaMa3TFN/DW00nQghhkjKIb2cCw==
Received: from CH2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:610:4d::14)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 03:59:54 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:610:4d:cafe::6b) by CH2PR19CA0004.outlook.office365.com
 (2603:10b6:610:4d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 03:59:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 03:59:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:38 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:33 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 01/18] hw/cxl: Give the component register .io sub-region read-0 ops
Date: Fri, 6 Nov 2026 09:28:54 +0530
Message-ID: <20261106035911.1280066-2-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: dcea80cf-d668-436e-7c8c-08df3bba6a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|10067099003|22082099003|18002099003|261021123027099003|11063799006|261026140227099003|921020|261026121527099003|56012099006|261028144727099003|261009223027099003|261102123227099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	5zEDCr8H4hOmKqeBqTXO99/HujlG9yFBm+hWnyi3/1qMUmOSAD49Aee4X+O0XUEHAsRn4YKep5LqVQ2MlwByBakf3GylV5+YhzfvpKrEDf4y4dBYMftywk9l9F7qOolb/08nRfGOHIwU0y18ZuzYkcHVYQAwNaHSgyEVHv0EZihYg+WW6q+mq+fh8NgVPMSdbQeWO/QG5MSKpCvT+knNcp+59f1BEmRxZS6Lw6eiONaEPXLbrYf7xIFUcQc8oghCwIY33bn/xAUcU/oJhZuiDEtXX2NRbU0tHT30t/ctW9/qQ/XtyR4zC12ZBnLfbpe+xmxnXEhZ468ZjMsGEYiE1WtZVp5d0D9i6hiKYqW8fuk94a0qKU/AH34LzYMbOaQz7mSImlvYguThjJ/AypiJ25lK06hFejVFv9jMmZe5WHBTrrymJWDY6UObxcXfkyR8hRlWlQ8wlPc7K7JDVPQ3hb9nU40B4XBwtyWb6pe1WQ4PNUktN57JGcQukVG+dBYrN3P7y9Xj0YHThNaXqzgoF4kLfNq5H2tc3inTB7/2qoaYj9i8Kbd7aIJM14wOScRVIIOXIruwaFM2jXH/LEPKC4Jk8Q6NohiaDKO2fPL6xNGOAVlQ/snBRC8IVbR0lKBtAdZM5OGUiAC1sZDnzs1ScI/Ec9jBQVE5Gb16GdOtpTI6K1cxGaalpi/fZibiVpdI7DcvuUzUZcpb1kzFpqa6OK6OuHs3CiF0Cxsqy+WSwB51HQBgs9T9P/4nawKqVTwS
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(261021123027099003)(11063799006)(261026140227099003)(921020)(261026121527099003)(56012099006)(261028144727099003)(261009223027099003)(261102123227099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EpHCs8TY60Zj7fWBedWG3rlGywqzBaYxx8HZ+wSSEq9A6e1WY6YQ4SEf0tv/4uaHxcvMxhhgrAYAW9xJNGJZXNDNPHNK3kyWWuKhZ/pEzKiJTpFLe8TpDYGT7hMM4aH7lwqtg330dR3l11KBrqG14KtJbQLlZma+492KruUngWLiAV50GbnBCtjauWwThJyd4gCfAV4HgwvsDXHX57Ee4oFB2ptaNXAcIfqwuGiFoaXQv+BZLCuy2Zysk8LPZuGguUvk4Fpv5CZwPQmNweytu4fu5OeMGAUSmHAIRY/fSPwbR6EGz7uJpzAox7LrgvBjZI9MQyd9BfvDDJ/wRdKjQDSqhIp5kYcaMoPlnU0TagpcsiSDObkteEPblm1O75fcYKc3sQQTk4+OZDSrW8ylr/m/WvjnMT8brsAE8yA1rxytRuMqFJYOUBsMua+KKKEu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:59:54.6387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcea80cf-d668-436e-7c8c-08df3bba6a96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

From: Shuai Xue <xueshuai@linux.alibaba.com>

The .io sub-region of the component register block was created with
NULL ops, so a read falling into it (e.g. a vfio passthrough pread of
a non-decoder dword of the component BAR) failed the bus transaction.
Under TCG this raises a synchronous external abort on Arm guests (ESR
DFSC=0x10).

CXL r4.0 Table 8-73 reserves the range, and reserved registers read 0,
so attach read-0/write-ignore ops to .io.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
[ mhonap: drop the comment above the .io region init ]
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-component-utils.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a624357978..fc32be77a9 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -264,6 +264,23 @@ static const MemoryRegionOps cache_mem_ops = {
     },
 };
 
+/* CXL r4.0 Table 8-73: the CXL.io range is reserved */
+static uint64_t cxl_io_reg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void cxl_io_reg_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+}
+
+static const MemoryRegionOps cxl_io_reg_ops = {
+    .read = cxl_io_reg_read,
+    .write = cxl_io_reg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 void cxl_component_register_block_init(Object *obj,
                                        CXLComponentState *cxl_cstate,
                                        const char *type)
@@ -273,8 +290,7 @@ void cxl_component_register_block_init(Object *obj,
     memory_region_init(&cregs->component_registers, obj, type,
                        CXL2_COMPONENT_BLOCK_SIZE);
 
-    /* io registers controls link which we don't care about in QEMU */
-    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
+    memory_region_init_io(&cregs->io, obj, &cxl_io_reg_ops, NULL, ".io",
                           CXL2_COMPONENT_IO_REGION_SIZE);
     memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
                           ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
-- 
2.53.0

