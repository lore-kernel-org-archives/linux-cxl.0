Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F56215F42;
	Fri, 14 Nov 2025 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080024; cv=fail; b=uUCHkiRcrdf3it12gbjFfbLgQdGlfxNuSnqhn3hebO67YvWvtgHw6ev3k5k2wWaOw0Y6oVRScfTD9jzcGa0g7HO385rji65TMxBJvbvWzUC4klHIS3vg3veL0CPwZjSQcvfmeUmgTYHjW3Le+4Zc2WJbFd2rzD46HGxLzrjW5B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080024; c=relaxed/simple;
	bh=JRTnxSxF+/mehg+W+Xwvi0zwNC/mRmr0cp3lxvqwZ5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cZ17yQhkzTbLiCwdcw28TvoGFJvyf9M8zPwuKGK6rZSqSGzGyRmjie3j2fkFt1KqgTBoOsBC4YVaF/8Gwrw9mdwUCxJOEvseXWTdrE2DAF9vceZLcY1h+6JvkG4k3chq9IGnVc/49B7/ZgpkkNdh5zhZ71uE51+I29IKZ/rniTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DRmc3nv2; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DRmc3nv2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynZU7XJSAoZH94GhJB4DD33Ny9UrsG02mN3knngVsu6DKt/tbs+QmXezYcI9zNrWAgjaVBqq83YYUsZVgCaxiDe5Dx/Otl8igie50AuFnK/Ksu0C0+K6kw1mb4Ti8Lpd51lHWWNOVn1Ho4C4P5uMZodeZ213DIyNfPfbBJerVEIMzt4nKMiaRXMfD2Fbg8Q3LEu2kvllr6zNrOQgXzO3W+IMSLfoW9m+fyYgH5pMy/cJ/T6Y4jSCxeQPeiV0RrGX0UccU7MaKA+1UXSEfPzqjgP5t7sKuHubCn0CTTZn2RGUx8XriwYwyna4m4/g46YpwNkx8Mkejh12oezyN+5vpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5gzFYx3mqB65ZMyyzPUwm25I/IT5DZozbsYRmyZyeM=;
 b=tSSN50uOMS4rjzGp6aogZo1uXXCkXqkw4hFo/n4wZo4Pop9Ex2Ua//JbkRX51C55LspaOhM9DWHVjxAkWtMXbH32abBv9P+VqWJcCQZTfMffP3X/onC0JPPKyIzjLP1lvp3z02+fkI6AP/44fsBmfTqutspfBWUJKJT9Qt27oJnxIRtpVDwIDFiaJj/39E7O0Grnuph/6oFrs8yt/LC2n+UhMhac2UDOU68Rez45nw336JbZ+J9Dek1oinqHgDABNjrD7Cm+AWNBr4BaYtgFQWaKBSc0XTumQgPsIryIzSfuzdefLRn+efrRwILqzIfS0TrF9XR49yyVnT8xbJ+EoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5gzFYx3mqB65ZMyyzPUwm25I/IT5DZozbsYRmyZyeM=;
 b=DRmc3nv2FZtkXWSHO2HzKT3Y3lCaFhJXFzxAPbfAO+EE2fsu9Zj7K2z25+zlvpP9ylG56T3udZjfHefvJyTocfl67Kiny4O0/WarUPLlQkIs2DbmJbHmrnvI38F0/zjBesPVDp8cVVeBbGKREOoHWkkc8zSVGrfjYn9mxlfTUwc=
Received: from SN1PR12CA0078.namprd12.prod.outlook.com (2603:10b6:802:20::49)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 00:26:59 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::57) by SN1PR12CA0078.outlook.office365.com
 (2603:10b6:802:20::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:26:52 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:26:48 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 0/3] CXL updates for v6.19
Date: Fri, 14 Nov 2025 01:26:27 +0100
Message-ID: <20251114002632.1309139-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6be9e1-a316-4b68-f910-08de23148268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ftpATR6aO409rOQbHE50ZCVPAJXOnIxbuigKP1mJdA+LbRwVpXdR1thl4330?=
 =?us-ascii?Q?icVsY7qIYWQ2NpeJ4HKHBtb4EjFLOXOeSMLT7eHZfdoZFJLhGGT8dLt4ACzY?=
 =?us-ascii?Q?093eeCcdrnGcRnsHUEi3bnFsG1TYJbv+ZUDvnTY7zqvnaQiRS4/G42RWOst9?=
 =?us-ascii?Q?LFRQo7wbpGL2xPgjdbyhcn3bcrYGwEhzQnoYZ0jozPG7SrVedPmaAyqSsdVv?=
 =?us-ascii?Q?8MMXhTRfSpHENr5rt9M0Zj1FDqU83nqwbJrOCV22ISSzZxMzAM1pJxAAfZr4?=
 =?us-ascii?Q?zpmYOxFP/NVa/CuM+IOActCDmfshvojnEAnp71jCwTPHWFvLJghZ7DQ+KR0f?=
 =?us-ascii?Q?Jk1c5aOx0NQ5IwIRia4I2HiX08pZA2zWlC/do/Pog8/hex2lrcbmZEKQ0TMl?=
 =?us-ascii?Q?T/1BtudUJjJV8q65ygAy8GhIdVuqpZQSwTpQUjiQV0v9vHM1ZUXQPgpJ4/iD?=
 =?us-ascii?Q?1sT8n0ZWBD59NNyof0RGZtIn5avBqpqjdxx8iZq1tIqaJuVX3fzs4NoL2qiJ?=
 =?us-ascii?Q?cz8Jgd5ohyhLBB+INtUhHZSLLXdZtTvDHCz8l472S5WPXS+DYzd/oHBDEJu+?=
 =?us-ascii?Q?WikqrvSKFxmJUFFqjWSTHplpmPhaGiyF7hSczhm7A+FTiG3fVJrZLbGsfHTW?=
 =?us-ascii?Q?MV6sw6rDc/YkwVYz5dNlQ9cHmq0ZLX2Rao8GP0q/aU2AwrSSYZH7rGP9dmnS?=
 =?us-ascii?Q?kS19f1Po/iZmgOIcStoRlkeY20JNmJLzkKxQijwFgBMRpape8aLYPeVlCaXL?=
 =?us-ascii?Q?tSKTs8bGfFOPpdb3j4EOjjfytn0RR6qGB3eIIR+5AYFE662NY/71YcA5bS5i?=
 =?us-ascii?Q?yitDbYSa7Uzeve9gn8me16V5BIwMeF2kizmntJB161bvp59eTMMxBLNCf8jN?=
 =?us-ascii?Q?aEhrOHSosCRcw3iu4gWST+RoXZs6aufqsMrF2tWsWzCA4PbBA9r9TxpLnTKZ?=
 =?us-ascii?Q?niwaHleYo8WnMjuqC2AWm6yZNMXeJN6E88ef2F1/dvsY3wMBF/dlYSaHGRlz?=
 =?us-ascii?Q?mObbYeNqrB2pMg722w0xNjuv7QswVXI0BRLVfAGi5t/IySY5lHkUo9x6aoQM?=
 =?us-ascii?Q?TU4DrRO/+65QndErJalcvgsNTYvb85iTbjHc7ZA4virXFzfSqjWEYhqsRGox?=
 =?us-ascii?Q?EHChugTJC4AClsTyZn55UyIiKudd4i5unx7KzzT/8GbHojVe5IAzs8VbLhB5?=
 =?us-ascii?Q?1Dlj5aB6zO6MFM3wvcNbR4TFp7ukdC9HTsgiEqvl9aC0SDuvXGE2Ne5NWNS9?=
 =?us-ascii?Q?p2yaUoWIccf4AN/QZz+0pOkay5kzxhvhCeb8phoWoWiJ7Vc10EAWF/YeL90O?=
 =?us-ascii?Q?L4EQWcQoA+X/y5Di1ZWdm2/0ut0o6y91ltF/6feuEoENzlfLwJMSTZ/LJIqP?=
 =?us-ascii?Q?VzD47q/0MzsFI0bJEenSfPA4AMln0v3C7SlU96hs/gcz9uo+G6Kv29BokuT2?=
 =?us-ascii?Q?qamyQB10Ig1oSXY9ZyxZiSwRu+0uQzGWe/Ys3wDWRooyR/ingcT5rI/o0qcU?=
 =?us-ascii?Q?CIDUUBL3Gysf+aj1DTCyDZr00fx1OPodghQFq6rp0PIghIMoUtkAFVd3bSx/?=
 =?us-ascii?Q?U65cyOB9xsplxbmumaA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:26:52.6788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6be9e1-a316-4b68-f910-08de23148268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

*** BLURB HERE ***

Robert Richter (3):
  cxl: Simplify cxl_rd_ops allocation and handling
  cxl/acpi: Group xor arithmetric setup code in a single block
  cxl/region: Remove local variable @inc in cxl_port_setup_targets()

 drivers/cxl/acpi.c        | 15 ++++-----------
 drivers/cxl/core/port.c   |  1 -
 drivers/cxl/core/region.c | 25 +++++++------------------
 drivers/cxl/cxl.h         |  2 +-
 4 files changed, 12 insertions(+), 31 deletions(-)

-- 
2.47.3

