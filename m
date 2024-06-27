Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553481A38F7;
	Thu, 27 Jun 2024 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528431; cv=fail; b=UFgJPWBcueLW7tyVOHcvsGWSwJidSCchDiSHeqoUHLoEpPFwik3p2h8OrPBqmhLjxnQ/UgG96YrSylKhLdirUxuIkc12ptHI0jtAABqWVwRDZ85LGv0UZqqrTT5SS8qyOmnyipSJunqcMJEns0IYI2EFMzfyHFWH20LOvTZhu8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528431; c=relaxed/simple;
	bh=y1YlIocZOLHYqs64W3MaAOtOak9da4X81375izGzd3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHubQ4MQDTrJZsnp5MwP1Yr3p93lSEaQXAooLMKIPIfclyKOl4FrEumBlEaXeq10Fo+qHlBTOE1216kiTyQaUzeaFtpizN9RtKbgrSLkBPj6ZdlytVSmdLtGAwgJ2OMJBfLulwcUH4xt991Id/SzHjGKRvL2rakz+SekGW+uy4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YtEcPvVP; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YtEcPvVP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvly4M6+pCTXo33+CTuwcgFB9OtgacpNsgt9jEInHL9+JmEy6cWmlTzUTALCquMLOCWRvHh75Ai5ICkcFmF5eC7Dhrcwzw53cnr97u2OURAVSAlcj4ymziSfBlSE5BYK7lZDYtfTT4eTyjAF0VwpW41SdnMpnLamMgiYSZz9+Ho8eaP9+49zZ67ejrmgrdBlB3SL7UP2HOoS7+9964XOEpZFiiT9dMVzmRzNWvRJKI4a+2iC9kJhKmaquEW3XerHI/tnXMiQb8NnP3hH1IXNd3IhMt45XP7aHUBFcn6m2brvtXBSUfHGqzDAeIe/wvaUnA2NE97wjhcvl6iMxO95ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3qmXz4gZ0HjkEfCB1zzSsXWEpHs2j4+MXlhD9tpE/o=;
 b=NuFDhVm5477tjniJX8iPrnrQc5Fu2WX4KHE/TpK0cw7IHy7baQA+6k2vyY0LevyRCuB+ZQnTv4Q7I4sGE8IFdGJQcDum25gP+H1KIFCGuzBdPrn4XwuZbLzCbd7ZfM6mthMBabEUG+egOs9l1IYlkVvP3zEkL+AEZ+VReH3CtxcGBPlz6EX7xXVBI4/Q6FWZHbWx5cqO+i0HaB2C2b5I8ct9VheZzrVMJ4qZoh6HaVnyocFZfMZt7UMOpx8HnfTrRUAeAydco+jK4fYSA/8eKoHfQ6FeE2LLMJLzBWL/Yyy1kaNXyC0KA6syYr8XAgjHsfM6OYLenZdKs4aUCKwumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3qmXz4gZ0HjkEfCB1zzSsXWEpHs2j4+MXlhD9tpE/o=;
 b=YtEcPvVP1gpkc04ID59+AmY5b5Tj3YpHlkno1z3tLZkqwc9ne3RuZw/uMREaZ4A7IUJARxb/JhCfmHlzUUGXxRRuOPz5XgrIYTt2IHN+A8dyQzdwUe0qpXRFSJhXzRzAXiBZ4a7wG6J7bD/MXWC5bMYIlccp5t2woKlZfXr+nK4=
Received: from DS7PR03CA0279.namprd03.prod.outlook.com (2603:10b6:5:3ad::14)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 22:47:04 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::2d) by DS7PR03CA0279.outlook.office365.com
 (2603:10b6:5:3ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 22:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 22:47:04 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 17:47:01 -0500
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH 5/5] cxl/acpi: Enable address translation for Zen4 platforms
Date: Fri, 28 Jun 2024 00:46:14 +0200
Message-ID: <20240627224615.854162-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627224615.854162-1-rrichter@amd.com>
References: <20240627224615.854162-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ba8ae8-6b44-40c4-a03e-08dc96fb1108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KL5JbvHaL3EkObqoU/CKLea0OSeDxxcwamqYeCfLOd0lneLL1VfsVlcFTjaz?=
 =?us-ascii?Q?2rsU43Q6yvbQOZqpTqov13W3oiq7swmy2FnRC8QMWTgF5CjpvxL99b5omzP/?=
 =?us-ascii?Q?qcGoMmZ0KPrZJomUbgBUzSu67DDa+CgL534Y4JbhsuAeQg/tyLezWo4JLPy8?=
 =?us-ascii?Q?jO0pPL5l+5okdSo7/uHwW/BmKqkGjHDcKs8dOr4mYR2HR1rvdhwAcvBXxjlu?=
 =?us-ascii?Q?PBM8D252tvvoYdZXDWMM7s4drG9A8jW7Qo7Kk3hzHb5nO1SsPRDgOZ9cNtax?=
 =?us-ascii?Q?VBNAf/kIz2v7MQlERGNXz6b0GL6gTh8WLNn9eA2b79T5aTUIypaM+F4DhnT+?=
 =?us-ascii?Q?R+rem2LgxeM3+rU1sACRK7IRD1ak7utyjbhdZuEStvULoRLPrsmennE3FaZk?=
 =?us-ascii?Q?4kE02X9BObgaRIMehj9qQpkn8at8se7lRhmY3nT2iYlMA670ZCvIYibsCJxR?=
 =?us-ascii?Q?UEyTovAV9zYueo2N/DkqwLWDAXjGQheeFQiARz3Ei3LD6IOKk99rUfV0wiL7?=
 =?us-ascii?Q?EVyZl3cnKz3gtBeLbPL6T6M+OCBe81JW6bJTSeWu478jZf7633t3U8RUtCvy?=
 =?us-ascii?Q?56uJiNsG1QLUltEkh9oRKNl7YY/UMX4+QjQJd8KRpCoP5KTTtBkTK8XGvL9q?=
 =?us-ascii?Q?oPNpbLUhXqGo1x7BCnUy+uEm1HKa950dM5SNt1Z/bx/RbnV30VRLYMZtWSCG?=
 =?us-ascii?Q?7W0F9M6BpDIfpgbwspxzCtuK9hCnQHbg2SOOVe+Cz7mIxZXHcnZ3lDHJc1sB?=
 =?us-ascii?Q?4rrN8vxeNWvSPoYBvC076aXWnQviMM3wcK3kYRkp7vf1/veMlJmIx6ygj83V?=
 =?us-ascii?Q?XokOiSxLNRiZhw2v2GuHdWHPZVL6vLkTJy0IQAgVLZljy1y5YTtb2yGKRlkh?=
 =?us-ascii?Q?WHsF+d579WFxoY3UhSOLOYmwkA9CTaRzoi9FevjsKGtwvX4agZVQcZ+F3Iu2?=
 =?us-ascii?Q?Fh0IZgCdZ1Uv09gJZhF5pSs8OHX7Q+sym6x2Pgbyn/4RlG0OksNOW0BDozEj?=
 =?us-ascii?Q?lipaI45sx1wgT8P6xbi6TDWYQTdJjbFzNfkpirn2+ee2WRcEhDocGGjtAc9Y?=
 =?us-ascii?Q?6a9RAOZ6g54g8QFw0Dn8OKjhGOCbJro6kf3BowrkWBRoVW1WWVSE9Y9T89XK?=
 =?us-ascii?Q?kLdEKEOKdU4xVfKSJk/2rQ7LO5Axod4Of7w4+KE53287PCq1zZqS9XsDljnD?=
 =?us-ascii?Q?pf1GPG8ewfAPcQyeWhlpUo1JESTXe1N5Y3GSANTtQ1gMEz6VWdSvK9y3DrNz?=
 =?us-ascii?Q?nmXHYSTb9qqVPue4QUCmdEFoSBWMlxtkTp9hrwbYXesYY2VzNIyC4Jq9D+JJ?=
 =?us-ascii?Q?QV6NnJmKu7sk1TYOug8Isf/C0+2Y1uUJPi5BhMoopj0SCOQ5ufkR3XZ1QXEF?=
 =?us-ascii?Q?YGxCtRilxIUWu+OCa6lWIOidPVH8sfyuDHzkEzmVVzbFyrwJ8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:47:04.5565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ba8ae8-6b44-40c4-a03e-08dc96fb1108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

Enable address translation for Zen4 platforms.

Link: https://lore.kernel.org/all/65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch/
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 67f73a831bd3..9e7b9629b98d 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -11,6 +11,10 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
+#ifdef CONFIG_X86
+#include <asm/cpu.h>
+#endif
+
 #define CXL_RCRB_SIZE	SZ_8K
 
 struct cxl_cxims_data {
@@ -536,9 +540,14 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 	return 0;
 }
 
+static bool is_amd_zen4(void)
+{
+	return (IS_ENABLED(CONFIG_X86) && boot_cpu_has(X86_FEATURE_ZEN4));
+}
+
 static void setup_platform_quirks(struct cxl_root *root)
 {
-	root->hpa_xlat_enable = 0;
+	root->hpa_xlat_enable = is_amd_zen4();
 }
 
 static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
-- 
2.39.2

