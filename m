Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDC2F8BC9;
	Fri, 14 Nov 2025 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107157; cv=fail; b=lVZgU+OC5rMdVBMzQV65Pj1sD3giLMo9X3rF3CD1qwIsS3+krdcV8t37MEihy/mx4D8VSPOxkjUsDPkSxL+qS+2AIvDAUxmdAam0OjA+zfNnmThND5skV+n5dyINWFEKMioyrSNvwpSJzGed+vTwP0HyrUnHGeW9PrChg6RyWUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107157; c=relaxed/simple;
	bh=PL8ITFznVcnFsoVyRxP1ChYgGXBauGz3lrz54K10M+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RWrfr3t/faUtrBvGWTZHmNdwsHaO6Zuz11DDdvEKQE0EmO3fdqcKIFFm3/lkSgGRABM2MfidougIka+Bck5gF96nn/rlOf2l9MA5Mgr2vt2vIJ98Y+SKbQlx+8euZY6023RSgInTXIDsEnT+ekLGoAThU1iKelKCTlWo2KdWJHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZaNsl2fM; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZaNsl2fM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H64+nQU1AIpwj2zf0VoMfGTyXBGQJX7lkbBovRH71X9vfw+RqP41DLLKnirOYl8/npF08NrxSDAEnxIIo1MEH14+gkxcCydJ3KUuch6aFVorXDPN7GOH7Wp2PZS2Rd0tRcnxFSVg+Bs8vqei2P+awoZURAY7md2eSVUavDHm6o6KZ/Jc1oYUuOXyh8DbNVRLJncWRj4T+fFAmLYj1H/HTwEJSMPm5V+jhS9LpkPUHM24BcK7HEuOlSwKfbf/3GGUDNppHhkKC69hrBrwHbmnIBeq7cZ9eTavaCPDBaWmXsSlh3hSfl3BTfJ7FAQonQBLNrr8LMYLhqWxLNGHzG2yxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UguK5VvtaYaPMYDZRxqDU3ozq16u2dKdvtTYiWSayRk=;
 b=VuME7XltWaZY8Gpm0yBHn+HYUGkdbBV4TFSMB7mfSpiVWWnlDqd1bWzX3OWm7tzxGtR8xNtU9qBPSarbpWUy4fySHux83sqzOJsDt4qhuCSH6aqnyq0iMLunpv6ogoSTqL6YJJTCvs4dlq+VL3iV01xBzxSfgwuV29jt+QCVCp4zirtG3iSjXYRL1MhrgEND5Zydz0CiU+AU3StQhjN6AgXz6rww/H2lIZdYIhtl98IFEwJziDE25vl5d1dVCUubFGOEOAYbEIrwoWbltnR2ENOfG4kdmZYxWeuHap5tx6+z3ulRbG9BR09EtgrW3x3+GKcrPlseCHM4GbeXYIcVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UguK5VvtaYaPMYDZRxqDU3ozq16u2dKdvtTYiWSayRk=;
 b=ZaNsl2fMosj9/ZgXJKLKM76rCVHLVsd16B2I8jGuIGkjwKbuP6QBNjlDvgqNy2DSiJaOSv9JWDGEVWLB99jX1ABPucu1PvAFTDmiR/TSSt01kqudXdnrMeH9qHdfTXPQvOGafv7Q1t9G2eOc2R/0fZ4ALCY9fg9Hv1IGxKLSi0I=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 07:59:11 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::ac) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 07:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Fri, 14 Nov 2025 07:59:11 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 23:59:08 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 0/3] CXL updates for v6.19
Date: Fri, 14 Nov 2025 08:58:40 +0100
Message-ID: <20251114075844.1315805-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c3c5e3-3f07-40ed-edaa-08de2353b286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NgcgWIdAiMmLII1xXRPdeYzdfb40lfuG6yheRSoXNdyiVCoNeKqQf4ePg0Io?=
 =?us-ascii?Q?dT/UfnYhjdEekFSdDyT8KCPxeVuLQzS/TXldXQ4sQg3rK2fGVmfM9vE8FUQg?=
 =?us-ascii?Q?qOvPDKhT4c++bKPogMRBAB72mRX3MWYqIlRsQe5m1K/jUezExWqnvB8FZLwS?=
 =?us-ascii?Q?zXTkS7E4y6k7epuRG5lrMHFyM7bqDRzdtXoYp/S5azJrFwONYqeflYHxWahy?=
 =?us-ascii?Q?3I+ft25yasVix1JwXgY7YH8+GkeNjnLz1s7D9BmW4mGWP5+QDzSz9oJuhsUB?=
 =?us-ascii?Q?R2MCTgBoA9CIBxF1RvDv542VRPCKDd8hHhSvHC0KXey+l4v/lphPQWlul3P7?=
 =?us-ascii?Q?z2aITDMeQVIW8rT+ZtxNKKUh1GooI5LM8KL35r14wY1TDV1jhXqF7dcre7Mc?=
 =?us-ascii?Q?/SPxKgiSjJ5QQ3s0jeZqZ/2K0GzNPNV5qdgcmaR9SdX0LylJZytzqowQEdAe?=
 =?us-ascii?Q?KHqCDvwrZJzKAfuHiB0pRwbIs37EeOUgJSBdYEKFMoqaAZ8BhXPRBTMbPpBa?=
 =?us-ascii?Q?aZAF8QPCryY4D3Sz4ubHGvae2mvIWPi/sZYPDVn5MhazQRPgVoDZ/UUYC8Nn?=
 =?us-ascii?Q?vGS95gnnoG12WNa5o1NMQavex5SapKI3xmV6DhkdYRlK01Gbs1pHKlUa1XkF?=
 =?us-ascii?Q?UV8qqq1HxfdWfNtExGRe+cZfF6s1jq65NuDdJsGKwSOXEGrQJNRNRsIW2m12?=
 =?us-ascii?Q?RzAPexBVhDdrrpETkKBRyL4HuSTOsD6Fj14Qghb3Gy96j3Z0TKZp6+jWphD9?=
 =?us-ascii?Q?35peTdFBkow0j69C1oUXI5TG2Ztt2k6YpvpSjFrD1phYhTa24ekmvRSWjoAF?=
 =?us-ascii?Q?QIFddkNkRZLujhQnXqeiSs8D3h4NjBDHXxACxF88+yfR5HSHzXEzJl73XN6J?=
 =?us-ascii?Q?dEhygm2qqpf+Q7D27qhpmb0BG0vONZKpxVzZOntBrpbihAlkiZh34IEHz+as?=
 =?us-ascii?Q?JhGATMsx3PjhRxXmJaMxp1csjD/T4wDLjeiu5j50qaMeUM6DAJHJIzbQENBD?=
 =?us-ascii?Q?1JegqaiuyGF9+KOQPzhcWAFBzlBh1mkw2rVm+9sAGO2Ul7XeHBYIJ35wER0u?=
 =?us-ascii?Q?RAPqhPRst0ZcOhEwvioXc8337TlSSMkrobrMEXh3ftg7JGXkQfGnF5eNHy+U?=
 =?us-ascii?Q?vM8ZxPszWRJ0H5VKxuMUE4LDQVlZPQXqQrGYvYJLR5Gz1oSHq/+4yos9GCRQ?=
 =?us-ascii?Q?pso5CTzdHNXYh85zzLEZSU90efm6mnCzvW9nQBzFLpq5QGrJNaPUbiX1AMW3?=
 =?us-ascii?Q?vcd1ekgOlUwMqqtTcfES7YYJ2r7ALy8AASl6Cacn5pVAUFtpOSAx+35Kgjfd?=
 =?us-ascii?Q?dJ8nVa+VxKO2os+JggQJ/q7KbW8blTWthFEFA0DbSlMYmlQDnNqp/lVF7e7Z?=
 =?us-ascii?Q?pzK/ScPUx3kIhv7siJOZD6Ix74TJOSsxlB+ex1UjeXQA55ns2Oj+nBWgwwhv?=
 =?us-ascii?Q?0aQENd9TtJCgW9SqDCmL5zUVm9utDvVqhPsG2cCHWclDZiw99POFfRZ6Ub/I?=
 =?us-ascii?Q?EeO6IBfVDMlFSPo7dlGw6SBfC3dBDgx+7MrywbSxjWWEbV7451t/m0pfDtAn?=
 =?us-ascii?Q?5jgkmnlph48nQ2wxz7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:59:11.6298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c3c5e3-3f07-40ed-edaa-08de2353b286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718

Sending optional and rather independent patches from v5 of the CXL
address translation series [1] separately in this series.

[1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/

V4:
 * resend with coverletter that was missing in v3,

V3:
 * rebased onto v6.18-rc5,
 * fixed kfree() in cxl_root_decoder_release(), it was wrongly in another patch,

V2:
 * updated sob-chain,
 * spell fixes in description of patch #1,

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

