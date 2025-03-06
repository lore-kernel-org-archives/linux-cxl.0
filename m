Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E325C6F3;
	Thu,  6 Mar 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279566; cv=fail; b=j6XL0cT/1iMyfdjcqO6n8i09hIj50Z2VhJHVSHQJFOkhPyygahsSK1uyils1Qle1UZZNhyMnjl0Nz0ofSZzwFlilnpCNAnPp2pJIVlI3Tin5945JH9VjGqETNO1Yvv5xEiWtVz16sCKjVMUVEX6kGAEojRQUqzzdY6VgSO1OCB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279566; c=relaxed/simple;
	bh=qVFh4YQ7NnwWd3oXWLsO5Tim0fF/EzvZXZk/N34YAl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRm3JElUWlunvsT4185eqkQPkWOT6phF2TYCkTqJ+R/3F0MHHZFRsm4Gq/M/Yv/G39tHLV9M8pt7yOOAiwcUv6u+YUEJ8v2O8gohrVSOeOd2HWe35bjJmxfFPh9riFDKDBh1JF0ah4gYbjm0XeYZSjFfw9SmHu8PBdDZHSWHHTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EFZcWyu2; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EFZcWyu2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkpvXTMCws4I15/jiOCJkOuxmFZO38dNuqaerDbeIYJXSEiFSEwcB6Ch7T6vdZBHm6W2+J9ePZihs9UZy2x5JDN5/TPrMQvodsp3Agc/GI1POjjoFYsmbw0k1ArAyqs7koWJloEvlRReTb+m/bynFxm8SGO9BI16KnHecMhZLKvvH7GCP8/r3+jCmiGxMfinO26IP6WKev/htihc1i2H8XOJQSvLT6sysaYvwII1H+fyMpj0b3mMJD+CpPRUdbhPV4t45dIn+WA0so3gEQyRvWXa18As4QvDHK185TSp7pMhGxFiKP5Q8u7Zmub5ZSQ5xvcYNxII79bCP64qjPZtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJs+pBDGPROgLV/9EuIlde+khfaM/org3fI76/a14o0=;
 b=AtecVvzZHkpcCvbTHcRUCklIDs4zqWySTSlyhLquK1jOxAPjK262QShyJ76dgPSIQ7vWmVZtFu85iHDTG8cvn6d+OVSbz2kE2qjS8TCWumN44sWjrIaYPVqB4uMbSzJfD8uAZhBZH2Who7tReKCdL9mEwWtOEkcb4l+ofOoUJHR2LZ0fYZSYm4azKrQaZ3G7rIG0Klo5jTVnCD4kK9gwB+WIzNVmDejJW/4tpXkiS3CZ9eIL3Ps1xbaeqDvZpkuZYeOz22nirewxXhwMA70qtgWnObFKeE746y+kPqWfnzINp8rT08yQZo8a9Edg9BY0pY5mrlKjyvkcPyfte5JZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJs+pBDGPROgLV/9EuIlde+khfaM/org3fI76/a14o0=;
 b=EFZcWyu2AarJF+9DcxICvpA8FLFBL7FNJIS8tf0sA35i4Q/ho9E107hfUYICQW4J9e4vgQys2j8uXJ9ZkyXUFgzbBtIf+1vlKxHrWf8E6H/chC8FUvHWu90hxZiP1maTK9EDDI5i4Y98WRXDeG+weLKvXf+HWWz9fU0hoZ9d4mg=
Received: from SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:45:58 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::b6) by SJ0PR05CA0160.outlook.office365.com
 (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 16:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:58 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:54 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 13/14] cxl: Add a dev_dbg() when a decoder was added to a port
Date: Thu, 6 Mar 2025 17:44:47 +0100
Message-ID: <20250306164448.3354845-14-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: fb05fa13-065b-4567-9e77-08dd5cce5f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xac7YyEEzIDQ2ssH0pbAQxEOsg68ov52NIgBSoH+Ut+bWHfBv+PCmYkPadq3?=
 =?us-ascii?Q?/v0OOLrSnv+sPwP78WZJW0DDfuK65c6G/keAL8ONe9MOeh9pOECBvKyB3W08?=
 =?us-ascii?Q?IYxLzJ0Sl40SKDasqwrMJmCi1rh2X7s1CnLmvxj3rtDZQxtkdFmOl8XN70JF?=
 =?us-ascii?Q?LU990gfjVY1wLtLj7ZmmyGoi+1cDB/ejKBWhFVXjtUUfw9pkMLo8DYslEkOm?=
 =?us-ascii?Q?icQlYIAV3GinLtlWxDJgjErhyX+rIZcyCg6cvuuzanuXS1apFnODHy78j4oj?=
 =?us-ascii?Q?19OJCQBKkokA/GFjcI+oUctHTKVghOcFzlDTQbxWB4WPnpCwtIzNAsZBse0n?=
 =?us-ascii?Q?50AKxegHD3nC7+VeX2jq9REaDklITnQkZ2c15PXktYUcVhpJ1t/vGJs8cOXM?=
 =?us-ascii?Q?WGixExtH5PGU1WrlxjY3fTxngCTGxxB1uRVDKXy7M4G7FYyrT4I3zIkTgOma?=
 =?us-ascii?Q?enfXa3XOy/4W/TwOiU/E9jgwE7LEUw6QuxXiZAOrlkUmuzmjalmRgIqpyMF2?=
 =?us-ascii?Q?BFvXYVA6zC2t/5Xt3ru7pDKL2uwHX+S26Sp0t4AhdYDUd3GBwL5CmtjD4Wlx?=
 =?us-ascii?Q?3Bg308gaknDBrMhOnAY7pnOtPjRWdcH33HQh/F4K93slOAgWdmXpyQ4noqTT?=
 =?us-ascii?Q?XTWDDvXgs5Vx/okNQfJ3bgfOR+z7OVvwWZdLOMs+94tLPafAj6Pai2cxPEV0?=
 =?us-ascii?Q?Vyh5LulCX8HRqAt+6NmHeHrDsK4aNKHH3W+EFkzreqo8Sgb9GhMeL2KS88BB?=
 =?us-ascii?Q?Z9LbBaozLZAoTVl4N9UeLDKQdl1Rgpp/4V71gTuVN7mS6bcCFL8KAQHa23cG?=
 =?us-ascii?Q?50HxgHEy7G0KsOQceToV5kOrDgwXh/guNICUZA4Y14KRXoM3moB8vdH67Nvt?=
 =?us-ascii?Q?DQAHA+3a6P4SYcQ0nBtKgA8tgQ9hVO/1igLyzGOekKpyTxrSCYDIUtN3e5og?=
 =?us-ascii?Q?OBxo+mlA/szhb7JaILg+Lk/YHcOVkeJLq9uUYWj3LB5Y9Z7TDF35wZlMINli?=
 =?us-ascii?Q?9E6e/nyAbJ8/U7otkzbtI6QHHD2uCRvVGxd+I4fg+LwXV4Ygp92828KPZFbu?=
 =?us-ascii?Q?6Fu6hxp60euZcycXHVcuyISnyQF95ozRI4DJjpt+IinJYI2wh2aG/dp1xhZh?=
 =?us-ascii?Q?h57pk+sPXQq4vRoqGNEKQ8FbBhhGMK084FTL2Qon8L90mKqBe3KZHLMNTRz3?=
 =?us-ascii?Q?Cu/E38PDoO22Mlxyw3EDPcXZYRuPUaoSn3HNheU15aRW/jbcWWMkMyKn5jbR?=
 =?us-ascii?Q?bUZcp78O4zYSrler/gPm+bQmm5LKvCwoo1GUiFzXe3ozIgrit4nr7tghCRBs?=
 =?us-ascii?Q?LrkTaZfE6lV3k/yT3frRGCd/S0vFtzH8U+i4GSBBO0coEL3XVYx0h9TRdsqn?=
 =?us-ascii?Q?miNViJrnRJKB2he0ChB1iiK7/5qmJnZCEJL6oLDmzrmtGq6Zha0KBpKBbtF5?=
 =?us-ascii?Q?LBxoxOeu7Bdzw4t3iYS4t00xkvMvZVqrIYBGadbkVGbvhn4irKLWdOv0HbSk?=
 =?us-ascii?Q?vOrhIcgugwCm3wo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:58.5349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05fa13-065b-4567-9e77-08dd5cce5f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819

Improve debugging by adding and unifying messages whenever a decoder
was added to a port. It is especially useful to get the decoder
mapping of the involved CXL host bridge or PCI device. This avoids a
complex lookup of the decoder/port/device mappings in sysfs.

Example log messages:

  cxl_acpi ACPI0017:00: decoder0.0 added to root0
  cxl_acpi ACPI0017:00: decoder0.1 added to root0
  ...
   pci0000:e0: decoder1.0 added to port1
   pci0000:e0: decoder1.1 added to port1
  ...
  cxl_mem mem0: decoder5.0 added to endpoint5
  cxl_mem mem0: decoder5.1 added to endpoint5

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/acpi.c     | 10 +++++++++-
 drivers/cxl/core/hdm.c |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..3e75e612cbc4 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -421,7 +421,15 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
 		return rc;
-	return cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
+
+	rc = cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
+	if (rc)
+		return rc;
+
+	dev_dbg(root_port->dev.parent, "%s added to %s\n",
+		dev_name(&cxld->dev), dev_name(&root_port->dev));
+
+	return 0;
 }
 
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..00c2de629a34 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -34,7 +34,8 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (rc)
 		return rc;
 
-	dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
+	dev_dbg(port->uport_dev, "%s added to %s\n",
+		dev_name(&cxld->dev), dev_name(&port->dev));
 
 	return 0;
 }
-- 
2.39.5

