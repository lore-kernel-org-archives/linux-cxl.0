Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5323C384;
	Fri,  9 May 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803316; cv=fail; b=WzfL5bDhalFfQKK1CtbUCCKjyompzjWUd48raqobt4zlpS4JZnqUj+VMC/HQPqTo45aECtHcSlQWvUZHf/4jrHNIYEUhlcB2cWICbzs6j07LjdY1iVgw+WaL7jqA3gUrwl0Okv37bdopch2+x+idT62HDUuz0pxjDeOyFizW798=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803316; c=relaxed/simple;
	bh=Hk6Rzs9bsj0Xb6iJO+CzutYyfbPbYyDlx66+OL2Ye1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQqQQpWAmM+mDXSQKackzxYhOVnlBSSsZTNuHFXPRp6hFouBuNpX5Wm0mLHtcKzU0ye+r6tAhMNK2DGo79vR6qBzj1qkWfyJvh+vw0/X/oqCa/pK8N3+r5lwF3sjMnUMmlXjWBja5rWqyE2j5jtEvXBA1BGYXAhLn1zFDPQJC9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LVGTOTtg; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LVGTOTtg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5RznZKuBD5rleqBpvISGIGD/utcC2So3KoRw6qd67ZQHVWbDlDRr0BeLV2Ec6Pzjl99hOXoLNYoIkGvVaMhzjx64rmu/08E+VbzCDTQLdRyFc7B0Z7CBoKLNr0wkDvO9/G7KO+jg64H6lY8maGkx3JNYKk3wHqHG3F2HORxzpfcD/XA3CMpM/wQAqw+ssP0IJQ8gQBRBPStgTeIkXq1okplTIsRAljjirPY7a/VIEqHg27eCyIcu5ZzEJZT6KC8vmEEtPKuMYzIe+6n2ky/A04ZkLhV7n09EaJMRlaQ60KhYys+vTQotwQodEC0du6rcGLOC41CLGXh/qiLjUjOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeOk1dh3gae3ohCB7ddWkVbGzizQQUG3MQcfl4XOMxE=;
 b=LiitjevoOTPd+rmW0ALNO4E9ba3I11n3dUkAWziuZ7phDzpNg5IHNC7E43tb39oz14yWLOprqUSvbZ0BlAE7+XJY2YxNVN1lMV3wZ3haGQJqXbV48x8ctclMsJqNXGQanfdNJdm0WdEYlki8R93Tz910zbOt4JgcIMJCA4tJoeXne5C1QiRO2RGazU+yG/GcHEwBQ9hvk+EEukBh9RZ6vDlVdDhpqCStJyzuwPsVyRftAjRrGmUlzCK0mV9OlhbR9uOQFCPOS5ND7Xh01DDv+bzAA4SbVZeJeLEPcmL6P5HYx0qZA8a9X7panjUniN00mcWCcTSAK73o7hRpFAI/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeOk1dh3gae3ohCB7ddWkVbGzizQQUG3MQcfl4XOMxE=;
 b=LVGTOTtgEnzzyQKsqeMKh3LOAZnHvlTuktwkN/vL/TWEV0rtmAaiYZnH0IDvYHKEQ+1Prae9chz3qGuU5l/fA38HCM+xk91RAG7MDEls3p76s0vogoxH+tS/piZ63YQ/Z3diuUGdfVYGpkmPzWd4+fS99GiLCAs/qOzp6mxH7a4=
Received: from BN0PR04CA0188.namprd04.prod.outlook.com (2603:10b6:408:e9::13)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 15:08:31 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::1a) by BN0PR04CA0188.outlook.office365.com
 (2603:10b6:408:e9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 15:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:08:30 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:08:27 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 14/14] cxl: Add a dev_dbg() when a decoder was added to a port
Date: Fri, 9 May 2025 17:06:59 +0200
Message-ID: <20250509150700.2817697-15-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
References: <20250509150700.2817697-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ee568c-4a1d-4fe9-d148-08dd8f0b5c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Mm7UyNpYXVqfHb/k4GpAWPsS+GOIBHPfh3jcoxqv561W9/U/5arZvv/UWcE?=
 =?us-ascii?Q?Nr2U0wjJ002cXk8XumW6mJZ1YTULF23KK+rb4ESHIDzgKFgspfTcfG21uCgR?=
 =?us-ascii?Q?EmbpFIQYBD3zMQ+7/YWTYtqhWw20A7xp7byV30B1mj+yBhBQ5ycWJtGy6n6i?=
 =?us-ascii?Q?268TJqUIMDMWH9BXVM50CmZ15w7uzFgPdMM0SDpP41K2kcp9HAoAjgJxE0hx?=
 =?us-ascii?Q?M0FRSeVQlGpyytGIjBiHxJYU2iBBtOID/vVTYlMgHIabTSCZQ6H6saD5+nqr?=
 =?us-ascii?Q?eLrVZUSHu/oIsBTHPWApkH3qHh5I54/1csFwltO4g81zXymx8V3IazJn63jx?=
 =?us-ascii?Q?dPVAzrLXuYeRgCOzI6QlXvLodigzgQF7eTiJpK3qqgxyjD+1Nla40WgHqD5N?=
 =?us-ascii?Q?wJ/PRQbBzEp0pujvb7+4TTvIBLmsvdIbSJ7M3mvlyG41sTh6XcN1aEqhv4SM?=
 =?us-ascii?Q?g39sKExlaNavOKhqCTM44dmejTcf81kSreqM+8AMORwOINEKTsGiMEc+If3Q?=
 =?us-ascii?Q?eVJ2yaoDxPrlr+58zqvBpgNhdYzBrLBGJWie6xLFcfB/d8xlJNGvHW4enKyx?=
 =?us-ascii?Q?NsW6ilp5+heOgzRibgUiBnsFZW3lJn25YMJ3GLbVG8YQAnfYDjXQlivFXMY4?=
 =?us-ascii?Q?bQpjY9n0ParmxAky+WkoQxTIA83jibKRKrmkbYWwZyQ5XRmHT8FjfzKQ4llU?=
 =?us-ascii?Q?hCe7m1moOCqKb/OxbcM3fjsWCSVZxYUeOW4ehLiWah+YRkH0lWgrm4xbWr3C?=
 =?us-ascii?Q?ZBou/PAlqY0n5t4wby6o1TMwA5WI0ONM8RWmWLwTkautv2NcgcIfrujVjBPg?=
 =?us-ascii?Q?Zz4AJwvXWx+X6uBFyXPrfa/dxxBk8eYcS5j38QMtWd5/NZ6+Axlyhrg8p4ez?=
 =?us-ascii?Q?pB03d6dxxy5IJpyGg6cKhcgFsDB++JH7xDDeEkhfqMTi/sy3vJdaSsnpj0mw?=
 =?us-ascii?Q?uHpZHzT32C+gXoSb9Tytan87h4G3lMRrCyuhqfkOmLmmTmB8YIWn4Y3OBgie?=
 =?us-ascii?Q?538qUghA4HHg7g+YeRcNIymKk5bB54hBZrIt5LuXSgwETukEtXlzU8571dme?=
 =?us-ascii?Q?V/qM1etCWXXqHy5hhfMnk4gPOMeS5JfT429yTfIeO6nHZ6TgIj5gZoDXXzKw?=
 =?us-ascii?Q?2AN0OqFKmnsm/8VgGOyTbouBSeXkBM7kvFSX/sUdv+ZVfY0XrI0K0v2V9MAc?=
 =?us-ascii?Q?C4C/+QxbI/aLN7mKSG0Q9XyOsYMuS1T9jtGWhOJEM3i/GBFVgnvw8HpjV1iN?=
 =?us-ascii?Q?zYzDR3PDQKrbWbdPe5YmBt1lpZsasFermX28WXr5ajEjJIAHIJXRnbhPkpVD?=
 =?us-ascii?Q?gC6OyRJOgfTSvDVDtJ5DIo3PYvrhVbcjbKfC5d4hje0ujjta0zaiMhrYYgiP?=
 =?us-ascii?Q?BvY18Nctpy86hKz/gillPJveERi8tvLpmuYi/tgIvm2jP+33S1Tn8Es3KONt?=
 =?us-ascii?Q?tPX7a4UZTtO6Mxnmqe6Cj9SrRl9maKfJMTTRcH1IxgOu9FctV/dKCasQp1lU?=
 =?us-ascii?Q?+pGwB17wX7kOLox5rg99Q8Be2eoMJk0KLMb3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:08:30.9875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ee568c-4a1d-4fe9-d148-08dd8f0b5c2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808

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
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/acpi.c     | 10 +++++++++-
 drivers/cxl/core/hdm.c |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 4eac068a1803..587ad5289f7e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -419,7 +419,15 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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

