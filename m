Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339681F4299;
	Tue, 11 Feb 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267724; cv=fail; b=tEEBSYQc/hUpW20n8JHtkeUoh6cwGl38e0EQZoG2TBYe8bxZG9/1w/VcfrM8LxOyLD2PSL4NgpeN5FeBdF7lZWWCy0bO7Amo5vXReMVMkoctseBksKesA7rURfesUjMbDwlhajD8davCQg1GDfyW7oVziOxXUng3DAG8sm2ILsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267724; c=relaxed/simple;
	bh=E7asGtJVl6HjPRetRNiGnBvJSljUVMxeLbjWzSnVyso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKo7n+nFOEHbktDxLbxUtKLUeaeRX3rApmD7819i3BamJNDcciVqPXujFlFI0EvIBUWpI3gIvew6/1phsaYb1ZqhzNvusX6bFJkpEJyfzFeF7DY3GlUEUg151Dkdw655yjLO97Qf2EgZoDztSNBU4yMG4XuKFxyp4c8kRdapG6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rcEYRFrU; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rcEYRFrU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/+/Rkb5YarPZM4kcnIqQFWbr+8KyUH1BoUoOaDOy8O2U4JfqzohdtfQUcIYtEv/SWJ4wCnxtXTEJa2SRhx/Vz1maU46m1cZ8Ca+pN7lSuhd5TheIoLljVJmJhdp5ceBc7cumYIZuU3BkAOqv0smiMowUF9nzcWqvilfGU1u1R1u81upgdDXwO+JN0LhdVHU7yBIRmwx1eWQkJrLU7TXiJOSoacooS+Xr9oVNaETuD+HensONe21e64raBbN0/jE22ulg9dvRvQgSpDLbDOLoK7HNcgcDVz1CLsn2txLKYDXN/oxRWZun/Piyla9zhkBwcfSI4rv/X7TGWp8SLjr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5f7WXWMQij7qKzhse4+MeSRZci9P3MgWzcrktFztJg=;
 b=reCdmweZQaBgnKXvO9Blc90tr9LP5eHAvCDCLC/8lPB77C1fgoco6SfCa/LnbVA/f+bjjXmHA2rfg0D75B8ixvboo2h/4+Jd6AVW4K3eM2Zedkj6ml7x4QFbaR5QfKrJ+YikUUxQDUlJll9R7RC0HcH0J2Gwg8Xov7AbZ3fwqleg8YdC3jA9swN+pzpsBlOsm1QQCmyI9+TrVRWGdeWgJpqS2TNAowmVqADHygeYHAA7TahPUyxEOg3xPImbUIkXV/KsLb5lK89UOZpf1SYw4cc0kYx7i8tnoZMCK3D/HKsP+7048gErgw52kPdjhI3Bhq90rdi3yx9S5lpYa2Z1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5f7WXWMQij7qKzhse4+MeSRZci9P3MgWzcrktFztJg=;
 b=rcEYRFrUyu0H/a7rrReQRlxP4Vo8NjiiuayRK6FO7FGekh/CG8IT9/3qPtuWDLWZD7e9EOikzLGiIWcy5RBn/LUQBpNCdM/4K7LSQB4IkTRwkOCEPa6qlRKYWnn6hi2KCJnQL7IRfxeO6pFGaw9IuFDNY0+BkmsMHW8Taqa/U7g=
Received: from MW4PR04CA0255.namprd04.prod.outlook.com (2603:10b6:303:88::20)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:55:20 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::ec) by MW4PR04CA0255.outlook.office365.com
 (2603:10b6:303:88::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 09:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:55:18 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:55:13 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 16/18] cxl/region: Add a dev_err() on missing target list entries
Date: Tue, 11 Feb 2025 10:53:46 +0100
Message-ID: <20250211095349.981096-17-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c7dc09-f11c-4b0b-2317-08dd4a82311d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZRrZtEIYJTf47QgCHtblZuPlbzhhyz4FpJ9VYy7cNvdZMCoO8QI80Ks7JjB8?=
 =?us-ascii?Q?JJhQavjrOuoNJ52o5DeYcL7KRqyjitoNSLm5Z0Ezjfc5gkL6zLhe80QtpBNe?=
 =?us-ascii?Q?MaCIA0TS/6VF9ZKfaQdnpztlZWZpyimRA7OR6Goi8oXp2hWWo8zs0Ez7u2Bm?=
 =?us-ascii?Q?ak4iC7lPi1X+WqLupxsliFkPlF55bK5Yo4WvgmHv/ggHC0H687nEJWJlxzVD?=
 =?us-ascii?Q?CKYl54atckisHrfo5QieVr88fXtkPds3ekOa3DrHMCpbgqvNrXkCEtIDfFBU?=
 =?us-ascii?Q?E6Nl700S4ueCXle8Mrk+Gh/FcfNEbKWPV2BXXdkKIFc8EH9ytPc+t9QMYwoO?=
 =?us-ascii?Q?Lur8kPR1UpwB7JzBU9xpJ9qXh2HTQ6CxcLbhw7bO3gZWpM0TuZfyB3+uk7Dp?=
 =?us-ascii?Q?NLkYl3gCpgOvXo71g93EiPYJguCtN7/u68z49tJj0+d6TB8Dkltha2LPBLkx?=
 =?us-ascii?Q?oLKNCF6rtuckV7EUtmKMzv4QQbFaZ8Uegj5ZpAVYrh6HnPyUMBm+vnGCW54+?=
 =?us-ascii?Q?7hV+b/nwybEKkBESLWmTBr52D3i1fith1dGvZCKN5sgRT6YFupWLSsw1dpt6?=
 =?us-ascii?Q?gjmhyTO9uS8j8RidteJUkUZiFVoJ+vbXuJ0s+0Ho4KxSWfkUD9ik7T8L5QB4?=
 =?us-ascii?Q?cwGhEnjNDzLpg9WI0qbbpQg/yJusDEpPAApxK1Xh3qYk1weD3ZazelaBqlyz?=
 =?us-ascii?Q?iQFSAaxrAFoYQFw/mwyTxFWs06gnHtuLSTs6lb8uPiWmbvx6xN145yCmRwrV?=
 =?us-ascii?Q?j53SuKyBBXxNhD2mxTFWkkoPKwqEnmLTb6+QZa2ASKQLDiERuLc7NMVUCjPS?=
 =?us-ascii?Q?N+XhdRKio6HUfHnPtWI1QW0kduqOVCyAfrMuqD7kGRDJIZakgHoQYuN1iYDw?=
 =?us-ascii?Q?GgGcDXg+zuFqn1K3VJ5b4fTK9EeXlBnygzNFVt6/3MiKF9hU9zI3Kc8TwKlH?=
 =?us-ascii?Q?BG1LAoxyuyy9bTPB5BGT+Wv+0uNGQB3ydyG1gk6upyuiyKs2E7OO2bW16yUE?=
 =?us-ascii?Q?CfeXPJGljngEefD2MlEkcje6PRGTjkp27Ij6xpBHYRJb0NI6B+mP8ghAdu/u?=
 =?us-ascii?Q?O1/n/zjDh+KJDmhR3vd2IEHZSWQz4LvAYncsuJ8H8DRl4O5PbRtqKbUQp8Hl?=
 =?us-ascii?Q?CavwFM3jy2TdpKCNTnCH3wrJHzD6ZdLojpjFKzZhJrVF63BU/+JiE+zbAen0?=
 =?us-ascii?Q?pxcGwMpxfhw8wZxFP62JrEmhR7+n723WJw0hjFoEep0sLFvrNZr6WS7iUEen?=
 =?us-ascii?Q?ri6aIdQ+YImkgLkjqfznMIf3YJujDFi9l+aNe0jBisNzrXW4DgcfgYqcHADh?=
 =?us-ascii?Q?9Xe2oIrc/2m+ZWJyz/RTVdytrdm6lDUtfnDg+zGiVLUQ35j3uiapqZ+R/7HN?=
 =?us-ascii?Q?uXmcI+a1h9x87CGCW3jvO0379qzxuqdp4C6P2xfiYkCdW1Wy75zeG8FneX89?=
 =?us-ascii?Q?f3b9CMGhlEvVKOLgTAC1Nui7JF4hOeUCIHUoguBLzU8a4cvp8jVDmPqxPiTS?=
 =?us-ascii?Q?Qz0RFUoHHn2erEE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:55:18.5737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c7dc09-f11c-4b0b-2317-08dd4a82311d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

Broken target lists are hard to discover as the driver fails at a
later initialization stage. Add an error message for this.

Example log messages:

  cxl_mem mem1: failed to find endpoint6:0000:e0:01.3 in target list of decoder1.1
  cxl_port endpoint6: failed to register decoder6.0: -6
  cxl_port endpoint6: probe: 0

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3031d4773274..a56b84e7103a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1790,6 +1790,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	}
 	put_device(dev);
 
+	if (rc)
+		dev_err(port->uport_dev,
+			"failed to find %s:%s in target list of %s\n",
+			dev_name(&port->dev),
+			dev_name(port->parent_dport->dport_dev),
+			dev_name(&cxlsd->cxld.dev));
+
 	return rc;
 }
 
-- 
2.39.5

