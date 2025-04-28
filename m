Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18E215791;
	Mon, 28 Apr 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876679; cv=fail; b=l5v6AuOsicO5A9S4AE7/rTaYJBXoGnsVf2h6WHl9PXGQnFZHbyh295e8a+ekPpQETOvzVIqPqkH0/XGmXlsbFvG0y0gYKMC/sSeNJVEobbLAWXSFHRrxNm6z6/x1P28gnjSEt0hKWMY/J9T3EclBJ1Qs1vs4mx433lHmoUEAnx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876679; c=relaxed/simple;
	bh=Hk6Rzs9bsj0Xb6iJO+CzutYyfbPbYyDlx66+OL2Ye1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c69IdO9cVsnez3NFad5OHP5iNplDxFCKZsLLOdwDhX6EKjyTBNdmS/qCYPWwBWEuB/0H9V2zuAKUuVg/8yIGBMojtRAgfHqtSFdes7/GGja0Td8vqXGN4QpUxOie+4hDhxFxHkByjMJ2NvaTTFYLUKul8n35mCpOVNA9oeTNmaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AIOBKXjd; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AIOBKXjd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2iVKDnERXxNP7gKTr1Wu3fNEPZf5O+BAnR4FN4Hfx+Q0CK+V6EUrJlfHVi+o31d+bD9+qlcFSni4XiO1fvaVUdXKe3w/81qjFnz3MCxrn27CXZmaelZJxxeJFNbArfRF+UiVV9mUopGpvUH9s8qs+lCzSG56UFwZbuSZxxHQWLw9ygJxXZ6Hhe+iLDn4oT2sDob4LfjZQaBmPgopP+PxL+hAWQe2ue99B7JGQ+8AS5wzOswBHdhXH4LkKxeXO6u4rhOiVJ9rafAfiA9dayBhWPzvOjWFJLvohikPafnZ2UcXTMq1tFUKrDGG7SEH2HF+v7MttGUkeaHJ8i+gQEuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeOk1dh3gae3ohCB7ddWkVbGzizQQUG3MQcfl4XOMxE=;
 b=yoUmLvbjBlJcptC7U6uZkzLDyzKwoK98b+0yM/CFpGpzIxypUAyi0SwVWH+leW20MvNlQn74g9KRBQpGqDTX3tM+bwMHsBJqI3y0vIBCoCMkrL7/+VFN1RRJNjRkDeUisJFmtsA/ZW0rOdUCT2/rmHAQVIs6bVa/MAZoRxngp56y6DMOCZ4CzQ81IYuEOdOKy2pSQvFpWApXUimy1UV1FLcsTGTObg+EzrsLhCdj8yeuHeQZgC4pAhtAzOZ+HN3i0t+nC4Pwb+PAhH/BWeYrmDuA3Vfd6FCCSHBa8+SXF7C6uj0qyibHO7MJlJ/1MgAAgXRQ/eFqzKmfZivBaRtRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeOk1dh3gae3ohCB7ddWkVbGzizQQUG3MQcfl4XOMxE=;
 b=AIOBKXjdvZ7xD2trKyBn22OOvf3sWmTW0FXlxCamrJ4omPJltPjBjFFco9t+sFsm8q7kbg3hvXEr9EIMFOnKb0F8nWqlpR3DD/D3C57nKNgoueifI/yN/E/sVbE/OnfJDwXNm+VeTfj8S4mrFY6eXPrCPkc+Kt5ktxUiJIK3M1Y=
Received: from BYAPR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:e0::23)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:44:34 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::29) by BYAPR05CA0082.outlook.office365.com
 (2603:10b6:a03:e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Mon,
 28 Apr 2025 21:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:44:34 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:44:30 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 14/14] cxl: Add a dev_dbg() when a decoder was added to a port
Date: Mon, 28 Apr 2025 23:43:17 +0200
Message-ID: <20250428214318.1682212-15-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 29caada3-4867-4865-5a8d-08dd869dddc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XvkhtCldDHgZQMBses3IYexQ6ULBVMl5qhHH38xbhjkT2IqlivN7MRT1sZfd?=
 =?us-ascii?Q?IdZ9FnlK9C6sRMxb/Bh+KU159WXQrviihhg1O9UDhgMvmdqQCqZTOrx0fRlq?=
 =?us-ascii?Q?xthN5mCj1uc34VJZyG+u16DjxXd7ZEbJDvLehgnHAPEAPC48RUPan0y++rBv?=
 =?us-ascii?Q?dEcutVc0WHgwJr1a18jf2yZ4uhcIpjAS0vyFPxsOYAVb7ZepQ5H6LVliQW5C?=
 =?us-ascii?Q?caGRcnF2kcXnnk011DXgQIgP7EuuvZPTLgPrHrN8exm1DZDOP4Q4R6Q9Jupg?=
 =?us-ascii?Q?M4EvkPGT1F/l9RJ7Vn8xoTyuNC3FysAaW/QcOBcsR+ai/rzYOd3x7Lg2DKeT?=
 =?us-ascii?Q?VZW94HyUeqrqOHUeN7tg3ctjHm74RwmQ6sidQuhBdlMr8EdFaznmwURwecUw?=
 =?us-ascii?Q?AFZEAwuMl7RhhwGHbjpsc88tRCNOZHSq3M8gAGWGQ6C2zn5mM1HwCwVopwyZ?=
 =?us-ascii?Q?RIwsLEuWhIYuMd9Dq2WrQkXzTW2Nm5v3oZQ4S7KprWh83TBUua44bCRvUzKn?=
 =?us-ascii?Q?IaByZxo6DdFeeUEcEOe8fN2Novuuhx3LacFmAVouasXysm+N0JZ+ecNCluiV?=
 =?us-ascii?Q?Wq6ZnNTIPcHn/E0i3tNPAGcnF8mG2mpDBqEMl3+PMldqxxkM2ojkSAc3o3It?=
 =?us-ascii?Q?xO/2CLzEyRGUiSoSwGd13idy6pEHIOQ7q9CMb/pbwMREUQPwCpUlr8u4XozT?=
 =?us-ascii?Q?ACbFDYOJtJRonY29UmYLOVzw9+nnAQEqp6MZareFXLXlJQEysV/RmCI+TXeM?=
 =?us-ascii?Q?bDj5zC+N4G3jcq63htQfwODSgHifbqs/v0m0scPVn1Dz3+kX0FauAqbG7V1F?=
 =?us-ascii?Q?xaGFmZYhtN9Kz14NQ/pjPLxJlyo/G+Lc1lFxhLWp5iqqNKobq8nNXDvZwiZ0?=
 =?us-ascii?Q?F7txmUts0YacvuAdcBtcxYSHXfLtOz6unoVcfnYTYkh2+Se7hOM20suY7tEe?=
 =?us-ascii?Q?ZLQCPRkEgPFejbf2U853BuHiagC6XHiD4fr0cjq6uVQ3vEQzA8GQtO/pr0/I?=
 =?us-ascii?Q?zouROWAMaRyva9y9RtiY0YT8bKI1q/cMIHf6uN9yXDR7x/7+0Q3fwbKwM68p?=
 =?us-ascii?Q?B29K7oC+ex8YsABCCRVNff6TrzicHXaA9y8dP3YBasVEyE03BWQZ3V6U3aLb?=
 =?us-ascii?Q?cxmXUYcWJkxlhXOnVZxL4BI4/Ilz9+57M/G6cQ9D63sq/UfJ4q7XvqlHW7vI?=
 =?us-ascii?Q?7FqZsB8g7J5vM7b5tDx4IiaZpJ7BC4P1ApoBUrn+r5fgrq36QSKZA8k0mDUa?=
 =?us-ascii?Q?335B2bpkprqghX/pbla5h/udGt2+0khfw3pHHHYHm+FKF1OmaBHlNUM8P361?=
 =?us-ascii?Q?pbgdncSmImwdYNWux3PSlVnxa30+rBu3XCqHTt8Ipa7G/PYydiO7sRdl0j/f?=
 =?us-ascii?Q?s6HD9lLUIt4j85Lj3QMn7y+znR19eS2Yk3Q++WnAkZ1O3urcvGjlnFSwQNlL?=
 =?us-ascii?Q?rljlf2uGnUYRRKcdaY5WtGC4J8UukWFjArVdzIx1xAwIAXgOnf23Op9U4BfT?=
 =?us-ascii?Q?8emn7j5z8JzpZnB//eJ1KBfaYUl/R0ISIfA1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:44:34.3699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29caada3-4867-4865-5a8d-08dd869dddc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621

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

