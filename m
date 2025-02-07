Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3B240602;
	Fri,  7 Feb 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942716; cv=fail; b=Ai7RCZDit2tLPwsF8BykvISJ32CLXmjnOG5DCD5i8QBVTS9RPS3aFrk2iQaTn2O1/sPXGwWUSM7fC9p7N6sWwPjby02OVoC23EBT+mBOsePxePvsL0SCovSJYqJdX0lmfnCWUHMCr+AF4jwNQmyZjwfiDuCLDT/LWoNWOTQNgdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942716; c=relaxed/simple;
	bh=dioNjkoT90Atp7QGYjLwOzJCaYAhS2NycMd1Zj/e6Lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUm4PjKl1gWt4G/fXhN+NI4jYtO27zetVzwqWpJ/xq6HX9ksOHx0eh8z5ULOrJKmKayIFk0U1iEyHf5sCnAZkdjVPfJKJAugmzcivwvtWUpMIUm6DIm9U48E+2HaeoRHbDEC0dwhu5skQU7ob14bxsIqjXC9YSaStj2hS6LeMTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mJpeavkV; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mJpeavkV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG2AkAACAKqPwlDyrY4GyDrlPnN8rqnYrGYC23qae9mkPy60+pRvqZikvC6voMDJWVM5dZI2SQ6HS19TFXwzLVv3v/ukWogvwLTGr7/n6HXXZXJxmkqFuIFZiVsuvAPrRo4hRU0RUpwLcVZqGtZVon9HYujE2iWdecb5hh7c8q3UQr2ye69uiST4rar/Fvb+T2rDG98JmXn7UR6zHaxa+kWp4QdXuea4a0L3QI++risLkTQJkAWnEYpJeF/zWPRHEB1efjO9LdOOcGQ9ytetts7r8gzKuxv7Q51QpvNomqYEB+25B9QbHweoLNDxDo6v4V7kqF4zPdAmShTl4BpJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0Tk2h0WUjJRHWLlmiDGdxj8bfM0ksYPdcmBj1LGC1E=;
 b=gcqMB76C202Agz7m+vI2o6N2YzJHtC90pHippxr5RTXZ9NBIeQ0wm/GjFnhbcUXbXG2ccUufo3BKeI71k8XdFhXVrXq/nusp1fAMf0eJsJQoOGaercujF+YAZk/M6sTC5UuIUaTsgId4iEF7rUKW33caaY+2/STSOeS8MDIuPAO88lTzIs7f1Qe/yemUS5mKPG2gYC3IOGPMkpjrsW3Lfz5xBaNr41nGj4qPH0wkZ6VJRf5dXQilFAdQ49mqPYhluviJs9YmtFlnMjWk0M8kVcqwFwfzi9/706XhTK+MiNKlchz/BPtplVCoBIZpkVP5uvE3HYj+sumQ1593wD0C6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0Tk2h0WUjJRHWLlmiDGdxj8bfM0ksYPdcmBj1LGC1E=;
 b=mJpeavkVXK+IOrDEgzHqbFq/a+Rq6dRZdT7hmXq64fFNJz474W9iLvqZ/f/567dfFkGwvE460HkBHj0Cs4cAzyJeam/p3cDGGsGiaXv7vBC6ipdKngmmEg4f+ZNszt+EMneBg2wpDW9n8AN/4KNlk6SvHmixxWuoI4OLy/PjrmA=
Received: from SJ0PR13CA0117.namprd13.prod.outlook.com (2603:10b6:a03:2c5::32)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:38:31 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::df) by SJ0PR13CA0117.outlook.office365.com
 (2603:10b6:a03:2c5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.8 via Frontend Transport; Fri, 7
 Feb 2025 15:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:30 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:27 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 04/18] cxl/pci: Add comments to cxl_hdm_decode_init()
Date: Fri, 7 Feb 2025 16:37:39 +0100
Message-ID: <20250207153753.418849-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: c305bdbb-3853-49fa-b02d-08dd478d7968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?95HCFsLbgsr+3RFnqfxaiCYNlFBuoG+OZwBBASoNKy1NtIvB90lDxXK4FRNC?=
 =?us-ascii?Q?SQe5dSKlh4g9EPi63UditGssdUGm7KHlJtnVc1LIdD0y2Fv6bQf1um/yVbbG?=
 =?us-ascii?Q?n0eIXhFn+fhUK6yuvYwVHRYgvCfKgLQbeFGI2hi5zwf58ACEiUE5PVbjIShR?=
 =?us-ascii?Q?5mP2XgYb5kT0ImKgRXQTyFrrcgxrsEz14DRckliw9vv2s8bmutXIcpKYZDGE?=
 =?us-ascii?Q?aU76j/YCx55VcGBzuNETkrq7BrvTMgmdgKN9pw0wCPAezMKwKfPNpBzSW4HV?=
 =?us-ascii?Q?gXDSaWRp8CSoXuccyis11nlIIRtwtMmIXhtJNddkpc+FE/D2RC5Fb+yxfLDc?=
 =?us-ascii?Q?bEmbh9EQYJ1nFKIHRNHk44dsjo1YGfEvl2CRkkjIBUX2VW5UoKVyNQEl4xR0?=
 =?us-ascii?Q?GsmLpFwX06r1lzjcku4PUDiCwTeULIMcLS51iVRC2/THsxcrOTbQyDXVS/bA?=
 =?us-ascii?Q?4CbmlJXrGMrySyqXWb4DlvasBhK49c2eNgDuJpTPrd/Z09Nnd34Q0aqG8IRb?=
 =?us-ascii?Q?LzlarN0nAyospxF4vFVq6WvZgK3iAY9qYU7g7qxwusjTMG9CQpA1N1fDGbUg?=
 =?us-ascii?Q?f7GmX6vHhMJpVsNKAnHlEZRzAaTYu67C857AVcEKHBE8MCBBCmd6qiD7kw0u?=
 =?us-ascii?Q?YPFxkRzumTVYjJ1/UIlP9fWx1ctqRIk5fFWwbgWSwsZSrBPECQqQsQ7Zvea4?=
 =?us-ascii?Q?vIGhyBk+712AzBVpblPKP10W395pav4zxVm1XGhYo8R9gbTnHEcjQJHeS7e6?=
 =?us-ascii?Q?ugmdYYHXxIot2NbwZ+/OObFwt5VCh5ajNyof5S3FgtW/RT4Ii9TMtrkhLVvn?=
 =?us-ascii?Q?ZZpLE3B42otFOwlG3XMkOYv/qR9dMKgrrlWF+4lK0sIld6haeff00jcZ6smu?=
 =?us-ascii?Q?/s5bhIz9XWyguEQWCuqO4n2diiXE3HteCEP3Ie2C8tX7gXytgS88/CK3ZhJ9?=
 =?us-ascii?Q?bWYMHjbERGrrhFWT1wmG5L+qXJrYFGwkSQNCiQUP83vOMlcRdxOVsJ6fh/NW?=
 =?us-ascii?Q?ordgZ7GXV84QjW+0QcKu2W3ffFIwGYK4cq0BSOzMCsJwj0xrIfc2zeA7samD?=
 =?us-ascii?Q?Q+XRgRXia2Dp1OKf7goeDPHB1y6lxGvA3ynJsuNFYozs+HswmSeaR0ctzuyN?=
 =?us-ascii?Q?zbJLB/Vpp+47exNxbsXRyxBEVo2LBj2fZ5gVzCxOwirq/2NhzeRN0wDjCnZ4?=
 =?us-ascii?Q?7l5xBDnGxjTRCL5cjLmevaVuxDCUSGS5WRD5TJan5N7KyelCwPhHER/w19YC?=
 =?us-ascii?Q?2HDQk88jpaBmeFgS4zHchVtafIXZKDHqQq1mRZP63+kpJeeOuWjTlUyOzKVJ?=
 =?us-ascii?Q?Dj2HJc3ajkvaLr0YpTN/CCBzrb/fmdJMIta2XhPljscKaJhNWLrC98q+gWAI?=
 =?us-ascii?Q?TogVKBZGNbLv7DLe0a/jJZHhQjiPhSR3NSLpnMKCEcBJmACyJmHxUwnfTdBS?=
 =?us-ascii?Q?pf//h5Vq/n7s402GyK7wo1jP1T4R1NkrVn5T3WvldC6AWPfxBL/9frt1F+zd?=
 =?us-ascii?Q?RIbvht0P4ECTLeE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:30.7780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c305bdbb-3853-49fa-b02d-08dd478d7968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062

There are various configuration cases of HDM decoder registers causing
different code paths. Add comments to cxl_hdm_decode_init() to better
explain them.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

