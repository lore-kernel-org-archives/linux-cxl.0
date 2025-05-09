Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4F2356C9;
	Fri,  9 May 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803276; cv=fail; b=LZBdQ0UlHNPxosBmMGUt4/UmQl8rKTrx2RJCrZx2UPFZVH8sBrrZAcqYqdkBpEQjLZCiZOrTMtkX3gn/7+p1dS1XPs1ekuDZcAfRvYNgNdl8SzOiUG3g4m3OJvF+3UC//tGBgkQ07nUSRrgqXorL8DvBXY77S5c2WISF0Vm/iCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803276; c=relaxed/simple;
	bh=Uwtk0cqnD+QEAXmj/V0yToLfY+sQ9BOzlrWGFF1lSlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5TG86YMo/98gNaDORdpSwXq5wOIi8aBIx/bDJhJI89Y3BoWhEBxA+qwNJIeGBLtkwDh74ca0CzDgFqKeN75myZvL9ZtUeKjB0RHJ9vzJUx4nMOh9+7Mr7O87Wn97Vf81kY5b+0C03HjPHO3tIgsFe8eos03xr7L4Ft6bX79frI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WWbcK4/2; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WWbcK4/2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwIvv3xMVe4iRf56KggJCAWZV+bRjdSgfqdjCv0pM0kyebiejKrwY4ThDAa3+15Jbc7gy4RMvrDx0QDwF0DV7ilpcqHJFXnwg/nUGDeh3EsU+LtkhcKK8xagiMVGkLuEXtNLBR0OwjdodSPmbvkwh6Ngn2cMRvNvfHerf4bF6giJ5SieRgd7/59x5zp1s0QntNcfbnmCTZYiAkgeDYBvcPMmWUDpHgR4vRScpWnid3jQR6ae5p34ftaSwERUfenTbEvgSYItzpfrSH2IUmjmSdw8uCmPjolBK+5AjFuMIy07juFTXXAALNJ7aP65i1xs82CNlXuFQ7m8R3/A9Z9BMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp3HauOx3PtLWFHiD5R4IEeXO/Vc/vLevXC3Y+vqwCo=;
 b=nmqEVAMF6gEMvmE7g2KlMcCeELa5yhxfwXeLOmTQwtLrqkoK2XNRTBxW31eqBH79lw4yXn35gU4Q6UFxlMmmFenMus34Bg67PL4Lt3NUf6lU3WBV4H9iVCJraXIqwfMsHn/mF/9GYgB5+DmPEFGXaLxIbpS9Ef+7/ZCbsfa07RrPbfZTX9e2FTQ7XCDbKhVVzP6XpZifVLlE2Vo2m7/pzYSpkzzN3iCqWmGkNCxAKhE+o03RkCwGm1lIdJQmqNYR1op/lrZjNVz2kFWwBVJPIM1pG8Bb4gPPZeK9N3t39uTPXFw76SHZQqHsn22yhAK3v/Q2TUpfNz3/gLwodMfBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp3HauOx3PtLWFHiD5R4IEeXO/Vc/vLevXC3Y+vqwCo=;
 b=WWbcK4/243OUUfMHp1S69/S3SaYID12CMzbgr5V1vNUX61Ke+6cWcctvYXFpYEKL/8DYTBh5VBTKmZuCz9wcZJB2a01tfGm/RIvXziIMtP7Kz73k5Ti5NiDDokafLSsbRI4gERmiMTUzG9z8MC7cifHDQzOvU5jW9rQ6EFlxVsQ=
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 15:07:51 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::76) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Fri,
 9 May 2025 15:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:07:51 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:07:48 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 04/14] cxl: Introduce parent_port_of() helper
Date: Fri, 9 May 2025 17:06:49 +0200
Message-ID: <20250509150700.2817697-5-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a022093-34f8-485d-f523-08dd8f0b449b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e8+h+J4QDQfPMEHOYiV0HdMgWNefPLk0NCxaRnd0cO6Oxhp73w/OseYFcrC7?=
 =?us-ascii?Q?Tzph+Qt9gDgYbhxse7s6lAVLEuuTFKC4X0Udh99JSpxQDOfjM/G/3w32+73I?=
 =?us-ascii?Q?heaOiZ7XmhXi477+Uit3AlpYqEAVHYlq+FjCsbWfwvKXV5nEkyvjdkaip36L?=
 =?us-ascii?Q?1TUonwe7gomTsNx4XqF3SeVyejjDUfFWwokme63GnQ8zEsgjqLRt7nb4iWMs?=
 =?us-ascii?Q?Pk6kfkclz92K3RC+y+PBi3jG92kBgMV7LNQG5sa/4U/LxlZlFN4S5rLTIh74?=
 =?us-ascii?Q?fk/2ERm5qJW3exJWb54vnADGdLI2wsrWowKlclpNDT/TGho5IgwQroXANAL4?=
 =?us-ascii?Q?e3+nIbZzxWIZuQfUGP1mAoSHXmUUgoRTtqeekbjywnUOYWy7s6pOzfJ3vJb0?=
 =?us-ascii?Q?EFkmWeOwkvoY4UHojgoWlH+hhAJ5JgqTuCr8TygjJnDo6UxrLEss4huAE4DM?=
 =?us-ascii?Q?GgIyTMT710JKgx3bjL5zHTTj1GQPsXiKSzclBV6eU3JnWekFp37d3tWCpkhe?=
 =?us-ascii?Q?gBTKBigaj1P/jdZt92q+RMZptmfxwQMGYD++exly9S6Od1eSmLxwshaL6m1H?=
 =?us-ascii?Q?JCTclSqzIJ4UIsH+fYzgKef2KBFX/hByOhBwm7sv6ayaohCEK8+3IWMct6/x?=
 =?us-ascii?Q?137hCfLCoSKsJ+pbLsXgn55I9yQcugTDk6fit7vAuWoRE0ud/w83d76NGL7v?=
 =?us-ascii?Q?gyPIb5lNv9z5yLW7thTUzJzFtKzifHm6TwaoKN8C+U7pV6oXqI5Z3CJ7i/9a?=
 =?us-ascii?Q?NeuUZCIRDSkKtG3Dzzdg3rwpyWjA9yP3RFZH6gGDOQLRMBHGz9YYCVQkqL/z?=
 =?us-ascii?Q?m1xYB/ovqGA/GxFJA9o25ghsKVGxhLASLrnPE0ytR92TL96wKbAZmYHqUFx5?=
 =?us-ascii?Q?NxiHPS4uadcVGYxUAuJYsqxmDmyObM1zoV03SAzjiJu9UCQMZcLu+ZEWNzx8?=
 =?us-ascii?Q?QLBPBDto0PTMoBddvA1Dnqw4pAJWGho/eXkeWTEPuYJBwFakDo9Qpi06DZU7?=
 =?us-ascii?Q?hBeX15a6k2YEwe89q7xxD4UDnGicOyjREMZ9ySU55dF9gN5mvn73wbLgYqax?=
 =?us-ascii?Q?stlD+xF+QpuxCgTyMs45yxcJW9BUCRmD7QwJ9nvepnDx4ETmE5kE0Jx30SdT?=
 =?us-ascii?Q?w4OYlEXsIwP2AWsHdTzR68bJC/qOGl7+7QkWNIWEUU0RHwE8hIooJsigY9WA?=
 =?us-ascii?Q?n/X00p02JfIyKNIexRPF5xiwPd5Z0ModQnFVdzftV1DJ8cQ/2XCm2Rk+j+iO?=
 =?us-ascii?Q?b9wZREPtRpWZSRIjbSUN+TsBdCOErA6Na0eCz99RAky+gKZUpTI0uz8xhuh1?=
 =?us-ascii?Q?3rfO3mOouPLtE8ePhT2XWg1KOxb/JkuDAZ0rhiXRh579mINwksx4bgv5ywqE?=
 =?us-ascii?Q?OE3D46rGfPNO9StjuVYz6m1Q3ikOYLv4aCX7bHdBaRShw0kk4u0dqaNB7cI5?=
 =?us-ascii?Q?DlXL3W/UIED3W1O2QrD7rMk/LS4B++eGhN81b7DzfFPzYfcBZ+bWp4L4QYk6?=
 =?us-ascii?Q?aBulpxazGxGmAfFhUtenLFyY9gi96nyHYLYF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:07:51.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a022093-34f8-485d-f523-08dd8f0b449b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716

Often a parent port must be determined. Introduce the parent_port_of()
helper function to avoid open coding of determination of a parent
port.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/port.c   | 14 ++++++++------
 drivers/cxl/core/region.c | 11 ++---------
 drivers/cxl/cxl.h         |  1 +
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 726bd4a7de27..83cfebe8d3e9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -602,17 +602,19 @@ struct cxl_port *to_cxl_port(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
 
+struct cxl_port *parent_port_of(struct cxl_port *port)
+{
+	if (!port || !port->parent_dport)
+		return NULL;
+	return port->parent_dport->port;
+}
+
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
-	struct cxl_port *parent;
+	struct cxl_port *parent = parent_port_of(port);
 	struct device *lock_dev;
 
-	if (is_cxl_root(port))
-		parent = NULL;
-	else
-		parent = to_cxl_port(port->dev.parent);
-
 	/*
 	 * CXL root port's and the first level of ports are unregistered
 	 * under the platform firmware device lock, all other ports are
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 25d2419179e0..569a56afd527 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1747,13 +1747,6 @@ static int cmp_interleave_pos(const void *a, const void *b)
 	return cxled_a->pos - cxled_b->pos;
 }
 
-static struct cxl_port *next_port(struct cxl_port *port)
-{
-	if (!port->parent_dport)
-		return NULL;
-	return port->parent_dport->port;
-}
-
 static int match_switch_decoder_by_range(struct device *dev,
 					 const void *data)
 {
@@ -1780,7 +1773,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	struct device *dev;
 	int rc = -ENXIO;
 
-	parent = next_port(port);
+	parent = parent_port_of(port);
 	if (!parent)
 		return rc;
 
@@ -1860,7 +1853,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	 */
 
 	/* Iterate from endpoint to root_port refining the position */
-	for (iter = port; iter; iter = next_port(iter)) {
+	for (iter = port; iter; iter = parent_port_of(iter)) {
 		if (is_cxl_root(iter))
 			break;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a9ab46eb0610..14e20b44f2f4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -724,6 +724,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
+struct cxl_port *parent_port_of(struct cxl_port *port);
 void cxl_port_commit_reap(struct cxl_decoder *cxld);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
-- 
2.39.5

