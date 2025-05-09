Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CD239E73;
	Fri,  9 May 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803307; cv=fail; b=qlajfYz103i2quaVWAKkUgX8Nj0ZWsvmo2ZudevdJFE109MPYrbTzn4t82VBvl9qNyGkvoAqbeyX//0yrdZwTRCTEc+0HEDj9deUAwxKpjKclAWkuAYRrQazrosoxLeOo5pJf/NnLzBXp3g/1A3TaWrxu50FqKDOfWeabbHlno0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803307; c=relaxed/simple;
	bh=k0QFPMTO2PMxWuAw60B9khynwb61oBq+7bHjsIUUKnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGvPQ/8K3fu7wYTeJ/36GQZmE1jWDTCGQ9Lrt2yutjpsNb52UDLX+t2r/FhgfNiBFdaTRgBJf3OSoraOvZaIOjejcAokyhBmvUOmPHHCAdlhW6yVXv3pyLRmUNLIjxZ+Z5w83Il5b7bdZ8xIDu8wSTZgNlxq423PC3rUJHObsH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FVUDZ0iu; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FVUDZ0iu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qffzF9/p29pP3iu20uAMv39NyK9DpeZ3CoyPNMbrlaQwOj3fxfFZVMk3WNpoa/bQqYldfA04dnxsyQrnaPwQpbtn+SCXObJYYpbBMHj9vQo7FaQ1Rj8F44kM+18b7/q2uo1+fOaMaN9qQtClhISKsDLycLnf1e5OmbPJN1+8+0jgGRB8PeKDLdF5V8Ok+YYb30ablUtMQtUQ5QODNFmMgbdAE2498dRH2LQbF9OAnlVGt98M0wQ3UfxKtQZIFHUYvzYp+P1dvab84pQ+6fmMr5bpdrpoxMFY5vZ1OC6GLxvxsL++0YpSEihMNDvC/SJHpQt5ysrfL0If27cNgPSNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dBoJHXDKcO5nAbJXIiGgVr9bkGDnaPMhXTUTJiesBQ=;
 b=HuXRoVHm+40UCpNuy1xMZ0V2f7DxCmHZwE/JPhyUxgXmtFJrTs6336GW6pA9c9PCDkj91DnMYXLuB1y2dx3qRNBjdnyXak0zsqSdf/yl0aO3zlLfYKe+QVAQCbTzaP2NmYeAGB1QiNUh6Q5zfSNhG7+Bc19Xbwn0J9StFsEIaThx0KQLIszUHV29NCRxGx0rJRye9OlsLiMXhgUMh13GwEAOsUMTguYNyHTfJFAxoXyiPOaYGicxO0PVMMZSWE7WqbP0TRZTvNHNMU1CdPeYMhC8V//oQFjeWuSd9/Z21VF77sJfNof6LsVqCu5vMaq/l1G7NKkpG2sqEsJdQOODNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dBoJHXDKcO5nAbJXIiGgVr9bkGDnaPMhXTUTJiesBQ=;
 b=FVUDZ0iuaQRG4bvXCsAjcEr3+pP9M1Qscn9dKQoj8i1Db8dJadf5t6Z8iceLnJ/3DTT+ziAhkrso/7Sci+kMYdCDK566ovlDLPGt+6CkSSAaXIrby9z/vdho2JrJIq6VtggV+YBGfRU9KCu6dB3AF6FLc0uhFeuglMg9Ou1odUs=
Received: from BN0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:408:142::18)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 15:08:23 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::ce) by BN0PR08CA0002.outlook.office365.com
 (2603:10b6:408:142::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Fri,
 9 May 2025 15:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:08:23 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:08:20 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 12/14] cxl/region: Add a dev_warn() on registration failure
Date: Fri, 9 May 2025 17:06:57 +0200
Message-ID: <20250509150700.2817697-13-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 017fdf75-19ce-44e9-aa9e-08dd8f0b5787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TGBEMeQumrKZ7JCVPsFnYVdFIPAhvtrk4Ys65KMn9YfK4ZrAxY4KKzk8Atl6?=
 =?us-ascii?Q?UMoGDVrlUFnZcFgYJvJaYVaQcF3Aqg1e5FgzR5NP/3ez5116e4XpFyibM5n7?=
 =?us-ascii?Q?n8dqS7pvYi5hVZBZTtdlmr6Q0LuxsUI6S7B4KjPHGDhyM8KQ7gpG94kFZTzJ?=
 =?us-ascii?Q?GNpMojckrhxFvZAo1xGHOIhD5s2a3BFts29XIDj7EZ0i/93SQzqPV3/QSGpT?=
 =?us-ascii?Q?SWdCxAB4NpBTv68Uj3p3Wzh0dWdnG3YNqeu4CuortFVAdR/rFioENL7aIttR?=
 =?us-ascii?Q?jtMFNkXIgarQh8R4cWEvbZ7uIdXLDlbmZ2bviEedg5aI7Tyn9EtRKH5zQ6HV?=
 =?us-ascii?Q?mBu4eDrgmP2ahFg1ex83p+AUbJuk22wtjQPKDB7fX1EmXVmQORr3ZWsDoqOk?=
 =?us-ascii?Q?Rl1VULHUEJ8MmKmpynxzPuxcPOVbrTRKUgPWNhgIJB2/5j1WrReal/2EWYpj?=
 =?us-ascii?Q?wURoH/zTXtdQ33d3jDr/rbmQS99l15LZ0wYfoTE63ogd7ev+osrMm9x8Rclw?=
 =?us-ascii?Q?0i62BPFuMhneptSnn71RDKB+V/6P/2F+6jJWQVC+a90fFreLwAvm/v7EjN3P?=
 =?us-ascii?Q?8tWa0VXNNPzkSSLFDtsQheGEkxC7Nr6YdmAx219NfCPXCxpD7bfOGD5xI04X?=
 =?us-ascii?Q?zyIj1a3eA7M7ugPzg2qy2p2wFidHAsdnuZAwbXsUS+xEqruo9zudEj7EfCTs?=
 =?us-ascii?Q?eRM0fTFgFBRuIr64PwH923TavVJFKzN3F8YIoNmCB8EGg/Kv8a8UWEtbOEaW?=
 =?us-ascii?Q?9rFfiXWEBNoDfvkExlHMhHBs9uXnUfnFgJhHL4scBmDYuKtAgK4gMAURZSyr?=
 =?us-ascii?Q?wEFLZP+AKzKEipA6+/7M8gBKS6IpQFShsjyPF+GIkvYqH90FRq2GkKmEvm6M?=
 =?us-ascii?Q?VUp+sKohLcCBdrARsUE3qKsR+Lbo/Jc73exIfuE2pUI+J5+1uvQ5ceUQwAtc?=
 =?us-ascii?Q?fjd0ts4cSAPlDLsCWZHEGqg1a6m7yw7PdPQy7Gk1j7de+tNNRE8uBMIpNOKN?=
 =?us-ascii?Q?bjUFZZZghbkpEsiLgOcl4nAyWiLcqO4LHILumzmT1/rkj4jXrnK5jetQOqqk?=
 =?us-ascii?Q?CjEAgi6fXpMMOlg6LsRCMq6eGxKwZ/y/h0h4IyrNM1eTeq0P75UOea5FNeXR?=
 =?us-ascii?Q?KuXooPbIArD6m91iE8hePLGD8D4FdsCQMKNZA2lPF0u3RDQRox3r87koYO4W?=
 =?us-ascii?Q?lvSPfdO9rdA92diIRcZEytPuVGnGWL9hma2BDqBFX0wjMD0w0Xt3NOzovqVJ?=
 =?us-ascii?Q?22T+Zheq/1QU6pweWFlA5my2S7nim8E20NEo7/t/cc3VwjjWQYks/mHKcbQf?=
 =?us-ascii?Q?YjtBLGC3HfA/wduEfcpxiiPtyjhZYrOfkDbsOiJ/775dcgSSGjKP+hbOsnZ+?=
 =?us-ascii?Q?erzSO05iEvWFYkpedPgIAXe5aZTHysX+Ifc+M5d0w0gD8Kbc+P+9KIDsnyNa?=
 =?us-ascii?Q?f2wK2E7jVZh2NYBTqFYcdiNhagXtzhbQraOAeMbDyTJHB31Dp7HIqmKU6cK0?=
 =?us-ascii?Q?cfGWVlCD++FSq2zUQvNh/HMOEKwgxOCaoF5n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:08:23.1969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017fdf75-19ce-44e9-aa9e-08dd8f0b5787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251

Esp. in complex system configurations with multiple endpoints and
interleaving setups it is hard to detect region setup failures as its
registration may silently fail. Add messages to show registration
failures.

Example log message:

  cxl region5: region sort successful
  cxl region5: mem0:endpoint5 decoder5.0 add: mem0:decoder5.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  cxl_port endpoint5: decoder5.0: range: 0x22350000000-0x2634fffffff iw: 1 ig: 256
  cxl region5: pci0000:e0:port1 decoder1.2 add: mem0:decoder5.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  cxl region5: pci0000:e0:port1 iw: 1 ig: 256
  cxl region5: pci0000:e0:port1: decoder1.2 expected 0000:e0:01.2 at 0
  cxl endpoint5: failed to attach decoder5.0 to region5: -6
  cxl_port endpoint5: probe: 0

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9d3f97ed664b..861cf74d5c91 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2166,6 +2166,12 @@ static int attach_target(struct cxl_region *cxlr,
 	rc = cxl_region_attach(cxlr, cxled, pos);
 	up_read(&cxl_dpa_rwsem);
 	up_write(&cxl_region_rwsem);
+
+	if (rc)
+		dev_warn(cxled->cxld.dev.parent,
+			"failed to attach %s to %s: %d\n",
+			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
+
 	return rc;
 }
 
-- 
2.39.5

