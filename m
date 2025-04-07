Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C41C5F06;
	Mon,  7 Apr 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054070; cv=fail; b=JILtzCyILH5lJjMPMa7lnf8U9p2CFPk1fBDGqJYjqXz6alZUF1rsKuTNraWUEIM0XIbLA1QRhbF2JU6hDnQ6vfN1uRJ9Xilv3HKKk3a7QB3W5iCf9k5QxTUKNeQIc7qHEwl0X18B0+C5KZWXeK5+KPoviIKVQHk/Xr56U+Lup2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054070; c=relaxed/simple;
	bh=+9HO6Y1vtLkpV4QmOcFjlzVL1bgq0IY+z41KFsDOrWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkgkqHbRqu/QveNchAJREGNW5Yj+YWWVlFyVhb43Pmvh5JRo0/m7e7iqVVlLMtFJw8eBEKlyTsVFxg8MyZ/mBKYWbIfroxpXtJ0STmWKojnPZAXLbKxhQf+e3vn4wdIyrof+wuZVm3EhmsMR8ME+1DGSDs2dHx9savwiJeZwTXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2tnUR53V; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2tnUR53V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEr1qUmH9RXHXhAdCwWK7uRqkzczBToHXgU1Ekv5SWr3Y+6qxNR12RsYFLb9Ialpq7uCembSUcOmDDDSEE4/dDYNvQjwd8eXbrbY9lzxrBsSaljLf7kuUY4zPB+70TGYiI3xU2kFyVBYp/jgRRSVrAw3qsgAo2y1MxJqk7EvlUXUzsKIupnF14NkfrnLtjO+Z1Pyah6oE6BYEebzFcajJkl70JL90DTQtBHFH0LtQcWids343VXL7eQ4a9REGSPZtvv8qARiO98O6WcWtnKY5MX9TVbSaU3HWnDdIkZ5ErJbiYiL0xTlHzR42SFfjVth12ku/bahMW5GIb6ixZZVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyTOje+2N7tC0HjSB6zH58cfpLSFFHr703iEqTT3tPQ=;
 b=enzylHlqAbxPMboGO6BaWeQc+zLpml3StXrFz4va1nX4CB3x7kn1QunyQjO/dXNIJctqe09V1fx2w+PGpXFUxerSgDBpq0yzol+ECuTkg7y/5eu+MpO7cAHDjLLto6cdWqeNj2qQrSX90oBpOlHzLbA564zRi0Aq3bFsZJtK9K9ANA4s8ord76S+ZYboHgsxRkHVIAThmsLytPwIGGw2jaU4Md6jrFN0k0KL+5WlU4WmxhQTYpN1qeSdxh+MEjhIXNSpguD9n0ctYQF8zENLLIoRuONLDboh4D3OboOeMPwCDlakkxgFBV6e32Nn/P8hnJGgaNdIeOT2/FIZ78JdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyTOje+2N7tC0HjSB6zH58cfpLSFFHr703iEqTT3tPQ=;
 b=2tnUR53VCqaVEYOFiB8pFJ6Id38rCYdtLtWyOHUt3P0ei/3AnAZgdqcwyrjk8G5NeqLavAMv43Embz4w3LgWqmE9xCpEeKPioApt9hLOC+Easke/kLgqewdtcHA3pGqDIUcBqFXGG/UPzSZ2w4bqczdHYsnv6bWd+nJmkFnF63A=
Received: from CYZPR05CA0014.namprd05.prod.outlook.com (2603:10b6:930:89::6)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 19:27:46 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::f5) by CYZPR05CA0014.outlook.office365.com
 (2603:10b6:930:89::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Mon,
 7 Apr 2025 19:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 19:27:45 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 14:27:44 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH] cxl/core/regs.c: Skip Memory Space Enable check for RCD and RCH Ports
Date: Mon, 7 Apr 2025 19:27:34 +0000
Message-ID: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ef20cd-db3d-4307-5ddf-08dd760a4648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eafsp9V0JHhIhmJwtZroFL2fzGUhNB7LhQUZpy11aYvXoSVevFLM2DwSrZoC?=
 =?us-ascii?Q?PEVHbuWY3ROhBo4qWT9BvIuUsmMMmhysO3CZ5Y5sPXdaXatdm8Q+Sd2ayEh+?=
 =?us-ascii?Q?cjktXFZueOhbKECPbXR2RTCX6DA5z5mFGuseLs2khQvoiqBEpx02R1fnXk2R?=
 =?us-ascii?Q?KbnTWKmz6llM3Wwvawa0+GhEeE3sYjD+/UtEIRAeW3NESM0MQ0ZLzgB3TlKi?=
 =?us-ascii?Q?wrkLFP1Ls05VvQJ4WrGSFkSIX9v4be/KAHjT2H1smb8jUFneX3sHqr/3dnnY?=
 =?us-ascii?Q?aNK/Gayeh0LE1AvDcW6hEi8TSzDXtGB+awR7Q0X7Oc9lmc/lnrBVCun884f8?=
 =?us-ascii?Q?/0PMdZCcEKDnZ2JQYXxlGs/1eBciADl7v8ICGrjFo93IBmYjTMf7YIE3vswh?=
 =?us-ascii?Q?DRTqKmpnHjKL/G8ejML5AHQUfeNs1bGtTOCGvU849yitM4VDqYiywrE3zhUD?=
 =?us-ascii?Q?O0FEovLbnZWY0dDZV7xZXjAn7UWbkIxLMUN5hL8UxRxT8abB7DcxWFQZFW8X?=
 =?us-ascii?Q?LRzUup3ZZt7eJj1sququDEjs0j7FBDnSVs42lRQh133xAEXcGOKcbpLGtdWb?=
 =?us-ascii?Q?HdIZuyYyrHy2EuNr/OvV77iT1aiiSeZNG8BHg4CG7WzwfalxEc7uv8vGDW8B?=
 =?us-ascii?Q?wbWVq3Xh8gEBHNbtYpwwakjaDefSNQetBV1QX+aYTqSuoXo7bIJA6mxplUXz?=
 =?us-ascii?Q?ZOLlAWExZUo6iMXLwKCQld8pGyksjgsuOAklLIFLkJEWzLtCFpBUOWyJvx/t?=
 =?us-ascii?Q?0hQTYfarcISATOLyl8254QgzPurnFp0gRkl6vZxefIQnx/5ICvV8Vj8UcUXQ?=
 =?us-ascii?Q?4uQZi4FMFpqCjK6ChsEsdwfOgrepYeLLuWg5aA0tF/W+5upSWiugnene87fd?=
 =?us-ascii?Q?MUxOOqIkImLusDGpXGsMZPvJ4oFa5i86rUXzw4kGTyaIp+iy6izndAwcnaBn?=
 =?us-ascii?Q?BcyZwefeEeCo4lc7DL+dAXB3laAxZ0oLm0MMYDMPABExV3D2YnRD2QmqopI6?=
 =?us-ascii?Q?VAXsEIiYGW7AU6SxFoVCrlujrSfnI5ncyRruFEIH6849CPUFZaRvm0BbT4fU?=
 =?us-ascii?Q?dFU59ZXtU3rBwP10l9GjapjNDMsWNcFuhRP2nIPWXbm1/RlmBlP1LstYU9GK?=
 =?us-ascii?Q?D6+KH0+hRdiHjlwiVdEviB1S3Gl+y0pOdqouWJQE/N7fAygHeNWqkrabgOzS?=
 =?us-ascii?Q?W4s4auEKNLEfkavZVgw3HI3aj1HFHvfVSzNWwEBsltywYJIfn9UVBppZUNEb?=
 =?us-ascii?Q?XNfFedL/yE5m1ZBfM/VR/10sTjubbfPAY3SC9W+0mHumJbq9cshfG+8vVCZp?=
 =?us-ascii?Q?Jhzdta5pT3ZOkol6n5tNVz5O/scCfnDnQuHe8GZl00wy/er8/ZgMkMvK/3Td?=
 =?us-ascii?Q?AmR9Ih61jW5dW7hAsvCHyjli88nk+mOE0cl1X4mElyEVTrFHOfs821oLmZoQ?=
 =?us-ascii?Q?WY6Xqhtai8m6tsUh0rOuB/KFSmKUpPcxG3hURAFvvQoVMS9yWW5L+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:27:45.5814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ef20cd-db3d-4307-5ddf-08dd760a4648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

According to CXL r3.2 section 8.2.1.2, the PCI_COMMAND register fields,
including Memory Space Enable bit, have no effect on the behavior of an
RCD Upstream Port. Retaining this check may incorrectly cause
cxl_pci_probe() to fail on a valid RCD upstream Port.

While the specification is explicit only for RCD Upstream Ports, this
check is solely for accessing the RCRB, which is always mapped through
memory space. Therefore, its safe to remove the check entirely. In
practice, firmware reliably enables the Memory Space Enable bit for
RCH Downstream Ports and no failures have been observed.

Removing the check simplifies the code and avoids unnecessary
special-casing, while relying on BIOS/firmware to configure devices
correctly. Moreover, any failures due to inaccessible RCRB regions
will still be caught either in __rcrb_to_component() or while
parsing the component register block.

The following failure was observed in dmesg when the check was present:
	cxl_pci 0000:7f:00.0: No component registers (-6)

Fixes: d5b1a27143cb ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/regs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 117c2e94c761..5ca7b0eed568 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -581,7 +581,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	resource_size_t rcrb = ri->base;
 	void __iomem *addr;
 	u32 bar0, bar1;
-	u16 cmd;
 	u32 id;
 
 	if (which == CXL_RCRB_UPSTREAM)
@@ -603,7 +602,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	}
 
 	id = readl(addr + PCI_VENDOR_ID);
-	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
 	iounmap(addr);
@@ -618,8 +616,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 			dev_err(dev, "Failed to access Downstream Port RCRB\n");
 		return CXL_RESOURCE_NONE;
 	}
-	if (!(cmd & PCI_COMMAND_MEMORY))
-		return CXL_RESOURCE_NONE;
 	/* The RCRB is a Memory Window, and the MEM_TYPE_1M bit is obsolete */
 	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
 		return CXL_RESOURCE_NONE;
-- 
2.17.1

