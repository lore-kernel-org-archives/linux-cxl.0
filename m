Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C51991B4;
	Mon, 17 Jun 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654741; cv=fail; b=R/XFJW9J42gb8g4x2KQNEllG6X+vttRePEkRxp3RrwLniO98DRcIiAqyXgwhJEQhYR+m9QNLPvdVVhBiqHL6NNOxAN+Tt82b8N7ZIVJ6lZB5g8ibiIHWbwPX+mDVyeXiRMWaRoBy6JtnVd9vEvrMZ+bRZPtZMX+hYtETjD9BXH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654741; c=relaxed/simple;
	bh=YhwI4ehx/hIFI3OEBGt82LbwNZCVpIwpbCBc8WMcFuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd7rqaNFLFg+aymEEi3tqHUQYhPTElH7fvg+ZvhEoPsJQgqzWO3fzClN8WLTEMBWwHc4m7LcW30TGTru/saQQ5/KHnCl5AqsOuAMiStUCzK/dmASgFnttJM5myPOeMRB3960VpVRgLoJXyTnmdqb4VGd1iHGFdYQqy6hsLbOeSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G5qqNolS; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G5qqNolS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwnrNTqig2ZQm8yO9YF/cGMevVKe+tzzireNMB72CsmnQvCKcZ92sl1yKmHcZWvleDEUspsOGY5PaNuwqojNvyasupazosMVE4pcc30bveF8gJ4+2ZrAssqaQW0DK4y4G7ju7A2sGH6S/eSqcweq/76cN1T5slU73Eq93lLRrof9HmlkDhgaETB+/f428RFIyuFS9Qbl+c06zy+0It6j/cowxJlBXhzDW1sKZcMW9lCBsgp0pBJ5UsArd2CxegAUPRpNl8KzMXg2PbvwjPTVvPMW++0O3zySnsn/j6DN4P1j2+833+0SWmptNYEqMiCKoyMfR3LLmaldXG/odqwmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shfodHw6jfZM88Zzznv+XtjFFw271NPr29HmNje4DcM=;
 b=VW59GajNtlW4H0pB7agVXxcqzVq6EBFXpE5fXxC22Q0N16/UbuFQzhm569HUgKhbdDOiJWSYRqlCz5xXzhDG+4rbesurfe/MxSrhSYW4O3jdUgzW+/YfCwQBR5gC/IEKcG9UUvtdFzbgb0gQ9dFBK7FsWu2vWZfGl2iwNoPVWV39m552qm+YYoC9l86y6DK6RFYomMK/EM35Jimzit2bPL33X5SDaVsdn2WHLZrO/Gu3K7mjvORpzsiI9ZJrgHURyZkmiLwQ/eEmYgBIZPuyAIi3olcpbY08Xqz5mn1SgyORfcmc81mYaqVkloxckHSydq7IA94R4gX7XmpSQYD/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shfodHw6jfZM88Zzznv+XtjFFw271NPr29HmNje4DcM=;
 b=G5qqNolSeJm7qIjeDlOd1dwO7ca9i8yY9pbDFcy067n0f4LleBqmoUKN1rpxyTuHEbHMdoT14/fG2rFuEsICZ465o4n8Qx+btdSBsfy6ZaYqj9KS9ryzT1QtTckiga6SSuYwYk4UOQhgtqt2OnCXaG3E0w012ZhHm5YL3fmg/fE=
Received: from BYAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:a02:a8::28)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:05:32 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::59) by BYAPR03CA0015.outlook.office365.com
 (2603:10b6:a02:a8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 20:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:05:31 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:05:29 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
Subject: [RFC PATCH 6/9] cxl/pci: Add trace logging for CXL PCIe port RAS errors
Date: Mon, 17 Jun 2024 15:04:08 -0500
Message-ID: <20240617200411.1426554-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617200411.1426554-1-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: dffeb003-480b-4610-1455-08dc8f08d750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r2UYczTk3XNFDdBNxSyg55ALPKe+LISxe74koy9CCUcX7KudDPQ4I+zYeGti?=
 =?us-ascii?Q?xRL+wBMiJ8ms0VutyBd7VzeW2yRKIsMV8kUIc1NptN+Z9iCB0ccFjjFOrM44?=
 =?us-ascii?Q?DjS48wRbBeI4ESKbVPoZ6n+KTzlwZbbot+6tA3Y9r2/SVmkVagJvdvqNpbma?=
 =?us-ascii?Q?kp8dedEnxAwLycspppMQdVWEjswitfDXwVK/G4BXMEZ7RzwsoriZ+n4ulC/4?=
 =?us-ascii?Q?p9lOr2swDqHDJmob8e//Lm2xZ5i2/oV/U9HaR7/GUps2yfyt+Yqgl2E3XsGa?=
 =?us-ascii?Q?q07XJCsZb5X2o2PB5jTsZKXlc3WAoA6auA7Nvn0l8asSEiXWcbprppuEuGKR?=
 =?us-ascii?Q?6JQrPa06mXrRTMl09kstVsKXCEubXR7qp2zBbDDYpXBN716r0CWExUqaeyor?=
 =?us-ascii?Q?wOYU6GYVBUUR4jQ6T7jHTC7hnXAJJipej06v+T7OH8432P2lpB+EM7fc2IpU?=
 =?us-ascii?Q?H5ue3DBgMRBg0DL0aHV1c/jAZe3MDMJicTJvzxrV0GyH8G2BHoSYRDIeiSEN?=
 =?us-ascii?Q?vUwSW+BpzxopjRS9S+XLZkYKibZrO3wg0O6syQfDX68bfsKarGHDP7tc84Yx?=
 =?us-ascii?Q?Qgb7RHxF7zs9C7HkqSniLoMODdTvNUp2Qx+YH6USgmnIX2us4V6qLbBmfV/9?=
 =?us-ascii?Q?uqFaXCFn3+fnRXX8IBofNjVzcgKMyPVL1W/xNi+MwiBzuMGavtA/5iml01jc?=
 =?us-ascii?Q?5SLdwFXafJbAjueEHTUDd6hBnvNB7S6BsASUoEffhLa/n99lajTSzDSslX48?=
 =?us-ascii?Q?3OboGWiQ+6dxnMyb6JG+4C0McS8wLBH7xFOg2myrY2HrAk85KrRDlqjbagKu?=
 =?us-ascii?Q?QFJsACTNq42GRAprVw8bm/4VfrRTLqaITahI1blevlcmCGPSEwc4Ih1Cpeoc?=
 =?us-ascii?Q?1mVA5wuc1m3isEpY0dhMZUyOyDB8BWoKjvKfvpH3rqlRTxqgFz2XXddDsBsU?=
 =?us-ascii?Q?/MsGTCdyY+k2s2jTVPHezySlO6r3oWWf2ft9Z8zsUps3m/wDps+ttL8U4emg?=
 =?us-ascii?Q?WvetfINic59cyKluIDQ33kUEllC6ESlv4YbI69JL6fcp5QLj+gzZbP0Sgcob?=
 =?us-ascii?Q?DrCx5aCcJcuNl2h98gHbqfZdJHvxZUI7xL3PgQPR1tvdabqLXwj67hZ0ONfa?=
 =?us-ascii?Q?BUYyeuAuHO9zKwx24sjn2JpE54/blD9CwKDFDIFSRlJIaSkg0UebiINwhfkY?=
 =?us-ascii?Q?adit+aoKAEFlXKjQ1FUAzhu5VtrNZzXdQexeMKnfHYbz9lIgtpuDZVfjxUJP?=
 =?us-ascii?Q?cVV29DfmpKcP/2cnZ5CIiOyxKlIHrSVb9p2tFDTxtLz5toV60/kGWe44q7VZ?=
 =?us-ascii?Q?Dh6hQmwkmJrsSmJ7Mf0ECW8+YZPN2xlUH34oLU3RBoy+rftvXbgJTnwCBrre?=
 =?us-ascii?Q?3SRCKur16xanKwU0WCjrPIQH0Z2f9sTZx7Zbvg2pRBmvDp/lhbqcm0S3r0Qp?=
 =?us-ascii?Q?Gb5kmQa0wz4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:05:31.3065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dffeb003-480b-4610-1455-08dc8f08d750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

The cxl_pci driver uses kernel trace functions to log RAS errors for
endpoints and RCH downstream ports. The same is needed for CXL root ports,
CXL downstream switch ports, and CXL upstream switch ports.

Add RAS correctable and RAS uncorrectable trace logging functions for
CXL PCIE ports.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/trace.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e5f13260fc52..5cfd9952d88a 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,6 +48,23 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
+TRACE_EVENT(cxl_port_aer_uncorrectable_error,
+	TP_PROTO(struct device *dev, u32 status),
+	TP_ARGS(dev, status),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev))
+		__field(u32, status)
+	),
+	TP_fast_assign(
+		__assign_str(devname, dev_name(dev));
+		__entry->status = status;
+	),
+	TP_printk("device=%s status='%s'",
+		  __get_str(devname),
+		  show_uc_errs(__entry->status)
+	)
+);
+
 TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
 	TP_ARGS(cxlmd, status, fe, hl),
@@ -96,6 +113,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
+TRACE_EVENT(cxl_port_aer_correctable_error,
+	TP_PROTO(struct device *dev, u32 status),
+	TP_ARGS(dev, status),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev))
+		__field(u32, status)
+	),
+	TP_fast_assign(
+		__assign_str(devname, dev_name(dev));
+		__entry->status = status;
+	),
+	TP_printk("device=%s status='%s'",
+		  __get_str(devname),
+		  show_ce_errs(__entry->status)
+	)
+);
+
 TRACE_EVENT(cxl_aer_correctable_error,
 	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
 	TP_ARGS(cxlmd, status),
-- 
2.34.1

