Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F423F26E;
	Fri,  7 Feb 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942763; cv=fail; b=I2bhCVvgfX5jtpy67K/G5/x6rFEE704p0NiSdcyEbeFZASEe0USkWH06mIl6FSGAksxh55HS/0kR/zNyDiKTYr6VWypaTvk4x2ZMswYwyoNb7sClsf/p0M+3ClWJwMvo+mOPmCusWhmzp1PdhBB04mYFJa99rE6rDIa95/+UWp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942763; c=relaxed/simple;
	bh=iU7ztykZnCD5hnV2z3VtCYxLsHSbMxsRfKEIUkikkCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZCx85AU+o8T4q93JZideCNdZRyMXesysuC1czkv3i0p0sS8T1cc8/fInZSCuydfV9ucqIh7i9K0O1AU4GSU32TqN2p/nrOsJX+s2JzmSQwDYbCkhn5Mez8qe6yya5A6Jwr0bSyjBW1k3M5b9iYkMvtpBtZHqCio5begRnNia44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z4Wy6cr7; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z4Wy6cr7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf0AVIhUtKkZMMHvr7kYVXkDJH8nv+ByAP20FidlcI4p8y7wEv/qqQNFwVfO2GqwG8vnRFgcJDdy1o7jKnBcT8Eeb5MPATHigMcwuiBS7d2cHPSRYPz0eok7yKYW5Y3g+FbqlCuJfPW83uzZC9jWs49H8vhu2JBP4M4u+1ODiPNvGeeFAcM/DAhLxjWnR7nacIT6RqkFbmCFc8GGEPsCzELkI/FQoqSA8kwwvDVU7fVA2IwyaWCVtq9Kwaf1L9cyjdhKWAHFNO5Jve0yG53zVsr9YV2hKlpJNuw+2+yuA8EKfUhs1t5y9H4mKXh035adbSdHgbtEEZ7Yz2NBBFnGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeZ62KrAec7yXIh8HcihmhFEDW3h5nQ5exboGJ1tjTo=;
 b=PEX0U8QC7GJVTk0sPcoN9albw3Ms1w3oF6SAktPKcNMbiIfIylezVKfvQBgbJg3xbgLUNqBS0WeH/aIkq2Hm54N9PhF/057UQUS7yz9aoHxY07A7xXc59rSPSWIXq8rWmumQ3drMZqNiv68L3wAB9HW9fAh/bV6GS8nlUKSfJX04plt9mokTSF2GEIkymrS9KzymbtqqfP8QUj8PrqcXx6laryokBEpd+WootP9upB8lAQHqq7wwPEL3f0dwB/YVykwxaMBuseTVa71bEgo9RYDdrAUb4BJyZxaOB+0QfDxqGotqlcS/LR8t6FA6qjJWZ74YbHC3roMPRR2+2nJFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeZ62KrAec7yXIh8HcihmhFEDW3h5nQ5exboGJ1tjTo=;
 b=z4Wy6cr7FaVIS03LF8HeHHcEBOK7SnfsdQwRpfWwAuSbIilGUlTjdbRLza64ZPy7hFQ2LT1bI8TMBUl3ITbTbCIHMVf51kTCgwAZt+x1G0GXlnbbWXhdU3ZC+H93bTrzsYnZtXd3t6XO8XqycSAYSOyVEslO+ZSTppdfs0LZHjw=
Received: from MW4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:303:16d::31)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 15:39:18 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::47) by MW4PR02CA0021.outlook.office365.com
 (2603:10b6:303:16d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Fri,
 7 Feb 2025 15:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:39:18 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:39:14 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 17/18] cxl: Show message when a decoder was added to a port
Date: Fri, 7 Feb 2025 16:37:52 +0100
Message-ID: <20250207153753.418849-18-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: e2824428-8b67-4757-b732-08dd478d95e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNzNSM7CkF8/m3eqS7vMaaJYCw7mKkB8LQ0lfx0twc3tIGRdlA4U4pO0CmoQ?=
 =?us-ascii?Q?iWld/qXwQIglKEItE1RUdCeG451Of0KmVJoqcX2PkA6as22399fZufgOV1qP?=
 =?us-ascii?Q?ftVDhPWvksfNF+5dwnMBISwzYEPGfTwMG2M8F2QptlKMihUxwN+ktC6+X6tO?=
 =?us-ascii?Q?aunPRug/USDE5iLCZC/iPckzA8jc1B3M+6zIIM/WorDTJ6+8Iz8go7g5ah6T?=
 =?us-ascii?Q?/JFuy+NiLzJw+KSit7jKVpgPCjBG06fObj9bJSRvt47pXKpI/1UexK9m2yGY?=
 =?us-ascii?Q?FBItnh+cBvQpMpNg26J7XQmSyTL1clNBlno8d4WSeFQpEEbSxfsfA1BQPyW1?=
 =?us-ascii?Q?2n21sQIWfD/R8CV2sliN9vC4Xt6zN16iguradqnrfkuR4Am1IRbxmksXqbQ3?=
 =?us-ascii?Q?HbtfRg9fUU2jsbbjkFpPynoxi+p3EVw21u7DVihC7ZNC06WpKLJm2W5XdH2P?=
 =?us-ascii?Q?kz/Q4ll5N/ypH0sMVioKXxjCDKlnLff/bTV7y8yN1Tv2agHvb75UjWY5LyYs?=
 =?us-ascii?Q?yuC4rdRLqgX+voiYzfwAx5MgOhnU3dce8MYY/HcnVQUH80CoTzPpJN12FtTg?=
 =?us-ascii?Q?leC3bI20y6NxZNVTWbnMVKr0cer4EUNtXhsRLrs04Opmt9xICuDFXO5pVNiR?=
 =?us-ascii?Q?W9Lgi2qSoNgV2/hRLJerdpvQZNH4zuE8PSDrX9bwANylZRYMJbWuYX1QvVeK?=
 =?us-ascii?Q?HZ3OPKigjjYQfHrG+PEOTNXpbmxLfe+ZuS2402Nsce/BCZ6priWy0wEzX398?=
 =?us-ascii?Q?vlkB/1qkrVQMygUSR/bVpqfCoSH0yeD7n7pUZwC/95gC9QEkqm29bJpgHvu9?=
 =?us-ascii?Q?5aUtTv0MxC2D14QkKh4uDSfWnckPA0QnBzrtLJI45uS9bRIpqawNHj8UPqr3?=
 =?us-ascii?Q?ulDkadTikj9GUhq+EQriLtJ2CIY21Pk8rmXozPmGqTM6xKEzkcjvLs6PsQIF?=
 =?us-ascii?Q?QGrSKfTKnS0I+Gp+brb5ySWG4uKg6W6dIh8c6N7XNaqsl3n/y3hp7q61bETi?=
 =?us-ascii?Q?fxyCDwnjCr3cx0/UIc/FiDy6pGQ/nk4Az2U8k1GhVYDB8g2LC0VsQnTn3Z1V?=
 =?us-ascii?Q?OKyBQW3XDKr4E1uKunMpH5oYvZwtOVYl+WZhK8RaBXWLKR3d6M+pjS8j3FG/?=
 =?us-ascii?Q?tx8xsY7Ojzwc7BiTrxc4efeUmAlRtr32WizVaSl28sLKJ80OXTmk7XoIMjLq?=
 =?us-ascii?Q?16jEy8G/O01AqjIJHQdrVEC9SXu7xDrxxotA78Ghh/MEszaqcefxl1fEFqU/?=
 =?us-ascii?Q?ba5zF8v8FasbYDvye9GUqxVLWIYzQJTTnGH3gOdsznoOo8qX7WRp75v+D8T0?=
 =?us-ascii?Q?94PMoAighFAxXv+mCorXFKHTJ3KMNPVktnfuoK+CTQWh5vzM1JkYt0anz61S?=
 =?us-ascii?Q?tvRDzHLnPOJH0ovaX9nrIBAZWIJcJ07/oPWCvIWRdoq1Aa9dqiyRfpEbCVQa?=
 =?us-ascii?Q?/KL8RK/jcfOmN6LHPhdsbPDPyqCS7iFLs7w8ghYuzs4fcDGTzhZxnezsnPzY?=
 =?us-ascii?Q?mtvFDtYxo1Fztdc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:39:18.5711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2824428-8b67-4757-b732-08dd478d95e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052

Improve debugging by adding and unifying messages whenever a decoder
was added to a port. It is especially useful to get the decoder
mapping of the involved CXL host bridge or PCI device. This avoids a
complex lookup of the decoder/port/device mappings in sysfs.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
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
index d705dec1471e..467e4fef6a53 100644
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

