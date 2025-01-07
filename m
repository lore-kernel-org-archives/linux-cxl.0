Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715801FA25F;
	Tue,  7 Jan 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259146; cv=fail; b=Rw2wFbchU556JWlJCOo3vG0Q6V6PvVX9hHhEcqIQoFfe8KYMoeJIFoisnu9p8Z7sW8ynb/h59ZbHAgYX1IAlUVqG5Kt4tGHm6BeuAErHx3qG1qUZGe9LekFCOvV2ejyrQp1y5jWdCcAdbwzu8FjYVlBgcOEwdT8eq6/VLl5kWRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259146; c=relaxed/simple;
	bh=0XwhWY3qxYnX9MTP3WL/usVaznhNRz09UNtcnLZxXHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cex/8C2jbMauSgJzcBwu4XgmRUiLqzaCfcLxHiNa2K6R+B9EDygER0ILTwRR2yy8Q599OKU+fwWSd+tmWq0UcfYaypQaSI9i4Z8tbTspxcoLHX0Jw5l6h2Fvo10kZEZjTRNsnMlWxhSolsDhYFECwZD1cIHC+esytarCuR05NUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tHeHc9FV; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tHeHc9FV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCkgfvyHxpsAyHUSNaL1WjFFIZ47b5KUgmnkXd8iB/WfnxiDMZx28DFXsGd6d4sJsUdfdzbwJUHvlVdf8+GItoxc7ag2TRPq0ZCz6sUz5ffY8o5AszgwZIHLOftsU0Y2mmxDOqiymwriK6yPTdUkA8hAF3HCm4bt7IoHHKk9O3l3cExQkEQHUxQnQoJxUUrCTR2hSZxu9uq/3Pe1gsSwUBB4/JCHEYnhiNg8gVgpODDANk0XxVmNFdgiclbVCzLPoelhHSuGLVX3C1WgZHVi4uofM+hoP+SfyTeJWFCOGrWIdjJWHrBdUjBOvwb5h+0CWwFmefkY07YAEKrn5mLZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Au3GOQ2k/hUYkvWG3AzsQoE4pMGOhp+COxtWTBaXwA=;
 b=s37XL03skGCP0UWrw5QgIsP9HgH5t48+i9DyAnQDiSXM4Z9Ve0ACeRUXx7kfDpk8HOQSp83Yg4WQApiwwyMeGBAXmL66BnwARmz9SHX920UC+zt/s26oCBHDkKBk2Vl3Ng5+1g4VpOF+xkqkHYjgOj/qq9vRXuChxJwXKA6kFJaid6yELq4IABpQnbSV9oO0CAkJ36RuQvUCHjErtpltlgBuUndUvDEaXRrFjyDsqHVmkjRVI9V5cnXqpfjVXV7lKLaYnR/Sq/p/pjL84hIa7djd/eJ/PYiU5s41poRz90dHv+yLtfLzYlZPsbl3kgS7vn0djQ3w2Lzkq/ebleZa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Au3GOQ2k/hUYkvWG3AzsQoE4pMGOhp+COxtWTBaXwA=;
 b=tHeHc9FVFmfM54tvEo7GiMhFfASpNDLtMBKNgAB0FUvLoNShVbHhmb2zt44779mne/5ic+/ThiSMyQkGGce4U+dLlvMQz0ntMOlVNCzAWNi4gr6S8lXXcHIXR5DUHqTf4xq6TjimPxWbSxyXy4R3ZWJh4ta++Xbv6nqTVuj0KxM=
Received: from MW3PR06CA0015.namprd06.prod.outlook.com (2603:10b6:303:2a::20)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:12:20 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::32) by MW3PR06CA0015.outlook.office365.com
 (2603:10b6:303:2a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:12:20 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:12:16 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 27/29] cxl/region: Show message on registration failure
Date: Tue, 7 Jan 2025 15:10:13 +0100
Message-ID: <20250107141015.3367194-28-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: eb654305-b5a2-4e8b-a46b-08dd2f254c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oJEbxCXe4omcODrPz+bGQrnP+wt3qiCgZejQPyAvsgVAXXCoGsi3WHEV1UbV?=
 =?us-ascii?Q?BPauD3CbRYf83thGqXvUI2khCiFPrAWh4nNp/+3dm+KddC+JUjIXzsLjDXeI?=
 =?us-ascii?Q?olxLYEvAIYAx1DMzdiIS+QPLnHXJ2ty6y1hcibEulNZh6Kque2/A3TFc0hkX?=
 =?us-ascii?Q?Xk2ZqBQS/Q1hSIMiqAhILtB1TAGeOXMj3wRAkZQp6rnlNbS7TSgBdv8NMAU9?=
 =?us-ascii?Q?VQKT/ZshrCRISkcXEwBjPsFpGQVbH5AChQCPX22wR6tVoRc8ZK52UhxW4TD+?=
 =?us-ascii?Q?wcAq1y2sl7Ip8f+2QlWpMtjd5rmHPhMOgByQvM8DR0V+pljZp/ckhOsXflgg?=
 =?us-ascii?Q?8z1yDpRA3S/+UMg1Y3fYUy8xUObSbZ+VmwK0yI55/dK26yG3K+z9NjGnPfmy?=
 =?us-ascii?Q?OfmDfll+o6/MFSLqifthaxDv6FHPgayCDnAhGUbR0NHd0ix0t769C/ZUsAMA?=
 =?us-ascii?Q?aCjqFVLXNXmomyjdj4GNdNY+7hcp+lJf6L676q19Ie50Hqu5EPW56QGiobaU?=
 =?us-ascii?Q?mBuDO/AGOXCTv/LF0tf1ppAjqCcllPBleIvw2SywaAm5j2R0Qt/Vzg5VEvk1?=
 =?us-ascii?Q?M8RAlyVrggdXyU5n3nc/4ady0mGUkRwRysffYVMZiMwExQ8bjM+hgDzlRcO0?=
 =?us-ascii?Q?jeTgiD6yeJ0cNNFWwKvkVSy24+B7yZbPmYUC+2FfPDViJMGhIGkAONZu+/xa?=
 =?us-ascii?Q?BlfcbYCoyhtB0KDOk1zLlmi3t0L1VbZtopx46+IgsrlPTXMqhsMHpbhtF3Fr?=
 =?us-ascii?Q?7NYPHILdGmkTWEM7AiELmHMIT1jk9zRLZ6VaIQ20XQMRRrFmmlgBlV5dl3Zm?=
 =?us-ascii?Q?+qrZMsax9AZ2auWwlzfryEnS5M25Qur/jRZDfgv4VUVdj0PTB47avlQ7tzXO?=
 =?us-ascii?Q?tFs2TacsLR7IdtcPNmOzjYW24LNftTa4A8RcOkqwOk6UEb9/R28BcqEMqlMt?=
 =?us-ascii?Q?FXlJ+7CaaSBP73ImrkjS4yCabkQztMhhhQIRJDnKdKPT4E6Wd7DdyPydY/in?=
 =?us-ascii?Q?KN8fqsAHdKb4jmkDYCEOVh2/JV+aDLzorS5vU0bLBw1bAvLppFb4Xh7pN4lX?=
 =?us-ascii?Q?i5CPRVQ6kKAOsv1OaHgtV5985m7b/hS6NuOEwdJzyRDvIlJw8IwZC4IQhI8o?=
 =?us-ascii?Q?sDVIhQmOouqUKxmKsWQITbtLqNgaWprgAKmczDDMOI7/0KavBO+g1k8HW2jI?=
 =?us-ascii?Q?f2rBvaJx1IrLIP/GENUueHAJkFMGAk+G1FgAikLcrqfDmnbFXQmgOQ4f4HoI?=
 =?us-ascii?Q?SDUurh3ak/U7I4AYahgXr/5fno+rafIMMKNvCpgf8bZHGgg39SnotnMEkKAu?=
 =?us-ascii?Q?6lJgfGtyUDLoiSMxB56thF+vJhTtbMJbhjdZhBdWwJJWptUe3fC1msxPDmvv?=
 =?us-ascii?Q?IEF186tNaiIzEoeW4O4UjT/1ncI7IayH2WEGDVbVwzTzCH4hAulY6qxub5XU?=
 =?us-ascii?Q?iBBmCz3/h33ERyXsxrsvzMRzkP3JsbWioxQWaHkLD9idP+OvdjRLzYP/V40x?=
 =?us-ascii?Q?QYzVccARskjKHw0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:12:20.0021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb654305-b5a2-4e8b-a46b-08dd2f254c94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

Esp. in complex system configurations with multiple endpoints and
interleaving setups it is hard to detect region setup failures as its
registration may silently fail. Add messages to show registration
failures.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1dae7d36d37c..775450a1a887 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2240,6 +2240,12 @@ static int attach_target(struct cxl_region *cxlr,
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

