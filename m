Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216018FDCD;
	Mon, 17 Jun 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654768; cv=fail; b=CmT6V+Eww3U6mVxR9jOhvYtd1kfamd7HeupXPOoBxUII1PwSur1bXe+NK7YPLKENM8RR8ePOfU1KzJHishslQ0ZOoK0WGtQ6/QfXLvX60qVVUh9QcuncBLDJIURwm3FTlH+2phtbjJBDZ8RvX0PqZcjquov3NRNlnxdjbQ7wy7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654768; c=relaxed/simple;
	bh=6FdwMlb9PTpqhBN7ZRCboi+YKCb8NjmX/vTY2UROd78=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6lVR6rdVSn+j2S9LWMpOTIqhOlF/PppbE9zaz5QDOjJm0/DA5m7BZ4sMnMStema2hngx3dLXhLtlwZ92wp5CZJCCyTd3xHqnibMa6cAJzf4XJBSvp9Yk1HNd6COJoPH2J0yYOIgrcfihD/G4czPHRqdxcR1+s3IbKdf6vqnZVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MmUlPfVX; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmUlPfVX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh/TLs5wBTBPqKVjhnE6fjJOr5iCu8I+O/7CIarXvtJTH+9prQqdj2HR7o9bUNNaqd1gGcGUQbenBlQiNKcm9tiXRP/8O92IdrtL8aDzK2cDfzvNxXMRZzJUKA3NBwiBEXzkV3R7vuNLB0uKMVQ3m17ZlYGf0qB8wbcwt3eUbqkJgEyFuBr/OcbhxzTj7MgtLae9DYjdLEdlJU7MK/5nw5mjjwpaBpMo0FMAoZEf0no22N39d6aHauEMHQnBGpO1eqJJ/usYWiRfPHhn8Cv2zbdehEfocwAlut9LtTClhMHRGVU3CJ4rv9qhVoiTy5hDUBshFJTqhbmCsdD8zraKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfjI9rw9dxmXO1fk15wQcsHTJ74Ow2Vwn+HbohIAklY=;
 b=EC5hGO2YhpCb3mJPvvoqcXgiiBkZzwNchIf/QosP9tRvXWtTbrbHgPfubjrPoGuQKbGpvm/ZKzvlioC2u6E/PDGHyYjp81XvSZ/q1ENXic4PgRsTdSX/lNSzDUS9Tv+5jGhYT56LtCnKRWbALKVDZgxYFB7Oq4Im3zayR3MIioL7F70HmR3PiIulahMc0wATb55BUpfTP6YUg3q2YtBPK2e2LOcROurmNhgoSjldswpdYM/hRYedZCANbd6154uf7memi3OuEdjxmt4sTSXqbYA/HcuFb+/3Mf8LfZWu+TLg//C5Mm/osHU5vfLOIod27OVwZAnSaNPd6IIqz8dxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfjI9rw9dxmXO1fk15wQcsHTJ74Ow2Vwn+HbohIAklY=;
 b=MmUlPfVXINzfmp6SBmii9RZLgJoxMtsVzR5VIX6fJWJKu9nGGw+8YfqGOgCW0rZXFeSuSX65GzTBZNMq+EOGW1dxSQeF/DLrAqc1I6DmUaSncjdB2IjBkfmrzB96Ag/I0sMaOMNrvpCFgdxcDP7umx9tHGsX+7cbAiH1EeZ4LVE=
Received: from BYAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:74::16)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 20:06:04 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::8d) by BYAPR05CA0039.outlook.office365.com
 (2603:10b6:a03:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 20:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:06:04 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:06:03 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
Subject: [RFC PATCH 9/9] cxl/pci: Enable interrupts for CXL PCIe ports' AER internal errors
Date: Mon, 17 Jun 2024 15:04:11 -0500
Message-ID: <20240617200411.1426554-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1ae36e-3097-488e-9f0f-08dc8f08eadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U8iCPKh2nNwoqVLMzpirLYCl+Q+TeRDT5HURUMePdoG3wj4hIWWfVQyJTZEb?=
 =?us-ascii?Q?z6Ae/uRzj/V6ItMv9TfCJY1ZaW/wHHrrXsllpcQ19bJWYTAJQ/qx62xrPsho?=
 =?us-ascii?Q?sA0iMXvQ49nzb49iW/kOga6XRT+fYSW/E9S/NZtsTxBjI+id9pEyHBKhYRXo?=
 =?us-ascii?Q?m5NN/ZlHTrGN9lmmvKZPysTReImFH+tjzPAmhRmUOTlzFmbW2gtsESXxZhiV?=
 =?us-ascii?Q?r3pA5tBQWCeVfW+1BjajgNASIiV+7dG4RSPxz8fgAe8TlqiK+TfSM7RaULUU?=
 =?us-ascii?Q?SnuuU5u5yPrc3QAB0LngeeX7W9SIWvfoJzbpQJqkZUSJXW8AuyD89Q6Zla+3?=
 =?us-ascii?Q?aDptiLo5DsyG0iPdLO+RYHheCNUWaOo1Y9Dl0hFVQYnJJ0RAzqMxOzAol+jx?=
 =?us-ascii?Q?dSJP8Tu7H79qTIJcXanjD4ov1MO1uuYfhBuy/a22yeVLP12mtey5gPhH9oOM?=
 =?us-ascii?Q?sNZJxjEZ2Ly8uqKjkEA+rQInX1eaxi5umlsibf1MvNVFQBUMB0Ga/jNIs7mO?=
 =?us-ascii?Q?kgGHVBdLlGZKrMbFMn6RGQDfDT6OW5/SCdLgi/vymOTgvW6r+xR3BXBx5iZz?=
 =?us-ascii?Q?TzEoL0ed0Q67fpaWezk/aV2cTwdQELRBVioD6DGzJ0HVOgU4mOjAzJRnFrtq?=
 =?us-ascii?Q?7qlezsKfCH6BLdbK7PrZ5vm61unCKArcOp8MDaxiFwBVhAwHR2cp1giz0fuZ?=
 =?us-ascii?Q?dmMqy9PInrKLfLWRfaflLyKG6dc65EiENmAG8JzpoqRQzHrz4L8tz1OXKmup?=
 =?us-ascii?Q?kSZCzNQas4QBswv61QllHL5KSJ85/+jNjwTG2IakU7nt+RGk65sQSEro1C1t?=
 =?us-ascii?Q?DzaBapaIdds3G92UiOlSVjB4dGCaykwP7phP3gUH6IlbManN4ij+WcnwYMlZ?=
 =?us-ascii?Q?ZFdDI2oANX0Wycc7Na28tTGZBDDUTJkqjhq1nOFcoiKBuKhqyyr8LsXt8Ec5?=
 =?us-ascii?Q?oKrpUjecMPjqO1ayfj60fFZ4zFewsyS0OtDtAlTxI7vzSLWPtMWSDGfUjhy3?=
 =?us-ascii?Q?6KKVZ7pdlqRp33GNn/5JAHFzLHIfA3CA3yp4pkWzC6Up87VJ9tpqyOJVdchx?=
 =?us-ascii?Q?p6cJ8UPbE189pKspO35kHZlaQzI3Swdqa6mMBqoocI1ObDaXLFLiqDjj8oU0?=
 =?us-ascii?Q?X+hiVtXlEd2WfDLfXHDKl0GIfCv9O09GqPoweLwKifDEOVPHxsCQn/qn2zCC?=
 =?us-ascii?Q?7gCMy9yDruKjbyPcjvPvB0dxk+LdReCN1ZIXmZNffXTO7AgwyijUvjL2KTyz?=
 =?us-ascii?Q?ZUGsoik/TU6LBF/F0qRbkhyEfdW2rDhRjfhVAR06CwkSe7UeBy0pNQQJEH+b?=
 =?us-ascii?Q?hSKt07DI7POYJLmaqlkEvhC0Vx3AMnU9Sb3+X9k/69ReDarWA3s0j6x8pIes?=
 =?us-ascii?Q?0dqTnutvqgLtfdhO4+/vDgUQVyIVPWJM6sb3JyYlmYk4S7EwwINXvJ6elrB5?=
 =?us-ascii?Q?4qdh23dJjus=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:06:04.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1ae36e-3097-488e-9f0f-08dc8f08eadc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

CXL RAS errors are reported through AER interrupts using the AER status:
correctbale internal errors (CIE) and AER uncorrectable internal errors
(UIE).[1] But, the AER CIE/UIE are disabled by default preventing
notification of CXL RAS errors.[2]

Enable CXL PCIe port RAS notification by unmasking the ports' AER CIE
and UIE errors.

[1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and Upstream
             Switch Ports
[2] PCI6.0 - 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h),
             7.8.4.6 Correctable Error Mask Register (Offset 14h)

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e630eccb733d..73637d39df0a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -861,6 +861,12 @@ void cxl_setup_parent_uport(struct device *host, struct cxl_port *port)
 	struct device *uport_dev = port->uport_dev;
 
 	cxl_port_map_regs(uport_dev, map, regs);
+
+	if (dev_is_pci(uport_dev)) {
+		struct pci_dev *pdev = to_pci_dev(uport_dev);
+
+		pci_aer_unmask_internal_errors(pdev);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_uport, CXL);
 
@@ -878,6 +884,12 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 
 	if (dport->rch)
 		cxl_disable_rch_root_ints(dport);
+
+	if (dev_is_pci(dport_dev)) {
+		struct pci_dev *pdev = to_pci_dev(dport_dev);
+
+		pci_aer_unmask_internal_errors(pdev);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 
-- 
2.34.1

