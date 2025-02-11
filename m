Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7071F2B96;
	Tue, 11 Feb 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267675; cv=fail; b=dX3yqfQA7YVfZlPbrtYT/mo0hapOJ1x6Nf6IkguBSHezUulIIWkh4xmWGguMW3frhE6SYDBgpooB0bsM2goNU5bF1FFiRRyqyz83HLdsBlVkBzUim8R2nVPByPOLoH/ckyU7iKquA5RHUs3HWoS+C9ZfHEw3yNuv5/vRD6po8oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267675; c=relaxed/simple;
	bh=c0VMwGNZe+177siM9ZRBYbvqeYLNajjBHouaX8n70vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzQ3HEmvGSj9VF3FUMrzQAfB/xwXAwVGMdt4+c69PeZPk+uI0KuNtQPNG40vsa5go5nCsIyNsWYRLT67MTHxMdgzd5b/jrWH/ECRE7IyR0aa3BdFQRgM9/HTejtg1eKtxaZrVd+fh//Em6QsOusmwVGo28A48vx1EMESSOsXIZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gib6Uh8d; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gib6Uh8d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHgZAYpw54wxwWiuMa+NPLBLMl86s854xEccAb43wSG78qlMPCwr1erVxoxA901eoWkOrNGW5tnySPgUs5L+Bw3TgaF27gFj6DUp4id+emcLxDLiLva2GSbDmz4IXJmU8YUTphYb7B2bkxjsMVJsNmmjxJK6KAiaeELQGj2tNppxlXJy7sjrUys8dbxYktgZljxhKunFYUikMxeNgZOvPxVq/zZKewDvbPzcOrhcLIf2RsbvhGwikW42n+xFRlvclAlepASkKZuI4RKYSQHp9JNdiuk7d0lhnEGyg1w1tQfIpl1f4GOL166Gx0xO3PbkSEyWzxbtgloVLXNqjiIZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW3Se9gA+tmf+/D26GE0Enop4th8MhXZT1bpwLTSBtM=;
 b=u/eV+BGKFbAAZVmMovAUXUDrRBbpQHco1Weekk08OjMM+UiZVtNRzhKDJ+weGRJ6wltsLjjjuMdBm6MEYpejd04PRxqZL4vztl8ZdpbZ+9mo6HyNLHsuddvuWshZF9NCCTep23E3kSN+pt79NqcaPLSM1NZtLD/zVLcyXlVEQgmKBxnF7Ks/6APE/amc6mBe0WnMvJKM7k55XIgsRdtn4TC2iv+El1ikncZg6UGUO2GPU1tdla6JZxrv3c74R5iH4ZBOKnmEpdEKPJrKKeCsomeyr3s/rfpuVx7MtqwNHjFs16gKckhzyyqDC/O9Up2VvTNBV4fzF4hIWqsQEAdpzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW3Se9gA+tmf+/D26GE0Enop4th8MhXZT1bpwLTSBtM=;
 b=gib6Uh8dTfrLmzWn/9OB5hB4Rw68O3mcVv5VWPn4j4h88bSDLInK5OgmmqGAXJH6jqEy/WS0BuYiqahpfGHh2UGQAWzbS2l/Xjm8XXLVVU8e2sGATmCtACL807+0c95BDPUt7j04nUigZ3lHogRF2AMOcwsqr+bg1UrP9WPBMX8=
Received: from BN9PR03CA0681.namprd03.prod.outlook.com (2603:10b6:408:10e::26)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Tue, 11 Feb 2025 09:54:30 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::b5) by BN9PR03CA0681.outlook.office365.com
 (2603:10b6:408:10e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 09:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:30 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:27 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 04/18] cxl/pci: Add comments to cxl_hdm_decode_init()
Date: Tue, 11 Feb 2025 10:53:34 +0100
Message-ID: <20250211095349.981096-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fb06e1-d40c-44e5-8ff6-08dd4a82145a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXEsWNiABvCzB0rwINKOJOAnnBNZo6eTNy44ExdC/t1+AjNsbFO5oIbFFu90?=
 =?us-ascii?Q?X8AY9RlDm74pOhfTZzIXN/UqHn+Ig2PYcjhZC5FIkgQMe9Lzmg00q6fGNHvd?=
 =?us-ascii?Q?awK254mywAbt8ZQ/oBoFAljhSscQEqe3M5/6hDbid3rqoaAJbUZUEe/QSazW?=
 =?us-ascii?Q?2pILMFh+XaaQWdvslFnBlbXwRtPwjzIWZ9zZkVpm17xLVPOJHTopTx4zSdiR?=
 =?us-ascii?Q?2aCFAH2ayuHktOdq3g10fZd74A+xoQJ22KFygfvXvDtan2jNZ/FtCLdpVyvd?=
 =?us-ascii?Q?GUUSEZtsDferO440YBrxmmi7iYRtvbTYquO+YOkilPmeJmt0UcC9NMpikBj6?=
 =?us-ascii?Q?h4+a1XjmjwVFxDm+pC+WI1Z7upu+yK+7kWr/G0Mty5K6HSrcdCt0WPgyqnPK?=
 =?us-ascii?Q?16e+CRr4d161DltJNPhd/E9oLU/Q1I5zZhC8RUPB2xXSUY3RToWMRIPMqD40?=
 =?us-ascii?Q?oKM2X1pFuscRFn9h9a0H6tsyFABFlPkw5xnFfuvpsBtkT0K3R7dBiKTuTDIu?=
 =?us-ascii?Q?gwv/WXdyph52hMkOJkpwQvVu01Lri5apBdsOpNaLqoKpqSKC1d7i2MwnwgjL?=
 =?us-ascii?Q?9BZlpaxl5OBBPl2yesTbvIRl3M+Wow97KvlVUU2xm1RHoaQnGeoTtLkhgUf2?=
 =?us-ascii?Q?+K6Llw0NO8XZr5T1qHA9MyK+srQHAoygBjX26Fn6qwsS6vz/9nxDVB+C8Fwq?=
 =?us-ascii?Q?TsuCyOwfDFYsF38rX4pwHxP8ddDbvSk1vRWa9YFqm0POvULMRmd+vPpRTsoa?=
 =?us-ascii?Q?5astnIhO+ro0K9laFKfDkS9Zk8vLzqt+0WnVRS1YUrHIS6NZrFmtvQJFXuXU?=
 =?us-ascii?Q?30+7JboZEJQj0Ja4icJngZuIn0b7EnXyns6IE4oqIxDE92suF7rj0bamQxXO?=
 =?us-ascii?Q?hENpwzQhmYQAyGYeU8TeZcOdHMZ/BG4X4yjWG3ztpRNKwn7CefA3JWm4JdDW?=
 =?us-ascii?Q?67mGnAQO081/XHt1FlVrW+bnYOyTJ2cnG2UrMOOUqmBFtHvRkR3qBCyMFh/W?=
 =?us-ascii?Q?bX56BpM8zyFjkSA5uRjMvLhh9HTDHtjw+pZgdL1YAHT28G8oLiY8jsF/zH3K?=
 =?us-ascii?Q?BiMq+M4kTvGg8mQl+yqXAlkFf+POw3CzGAouK5fO43aTj4KW0Oju3XYTLmBH?=
 =?us-ascii?Q?IAOheEOljCBhq47cesVI5xQo/fekmFx+bsYlAKcu8E5uTqwLC5Z8h2mOyzGw?=
 =?us-ascii?Q?/aAh0LSsVHwam4SMZS0n5bCAs//te6U/5/NHln3fJMYnukQyxZqbyON4BSg8?=
 =?us-ascii?Q?VeyzqEVbonkMcqkySyL4Nneun8xwJgj6RdwLNw4XZaLg1Gaq0oOpUjwzLj3v?=
 =?us-ascii?Q?CqY3yFfoaCewlMt/ox6CSSQlyXUrnt0FFusYvdRANJxUaa9eeJMCkG+FZfdb?=
 =?us-ascii?Q?idRGhnx+745rFua7ebV6n0Q2Dsyqe0aMjJ8sj+s6C/p2uFE9Qzr7n2D3sBDr?=
 =?us-ascii?Q?suixHTSRg7KN951+t3tbs31mRYw0GsYW/b9SCAPD9N7jLI4WaoY+ZQVC8Um5?=
 =?us-ascii?Q?1iYdZWjb9NiX1lw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:30.3380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fb06e1-d40c-44e5-8ff6-08dd4a82145a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

There are various configuration cases of HDM decoder registers causing
different code paths. Add comments to cxl_hdm_decode_init() to better
explain them.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c49efc419285..6333a01e4f19 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -416,9 +416,17 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 
+	/*
+	 * If the HDM Decoder Capability does not exist and DVSEC was
+	 * not setup, the DVSEC based emulation cannot be used.
+	 */
 	if (!hdm)
 		return -ENODEV;
 
+	/*
+	 * The HDM Decoder Capability exists but is globally disabled.
+	 */
+
 	/*
 	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
 	 * [High,Low] when HDM operation is enabled the range register values
@@ -426,7 +434,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
 	 * are expected even though Linux does not require or maintain that
 	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
+	 * Decoder Capability Enable. Else, use the HDM Decoder Capability and
+	 * enable it.
 	 */
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
-- 
2.39.5

