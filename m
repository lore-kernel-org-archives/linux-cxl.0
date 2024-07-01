Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9816F0D8;
	Mon,  1 Jul 2024 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856125; cv=fail; b=E5mRXSb7OaIwEa/bR8559h1KRLrzw1CMju03+TgMDfhMSfcGrsejPkEcjmj/oOvt32S7fpA3XPLGHM2kUgpRtVOrKCUpRaucAQD6/jeD+E5idQb+Fa79n8HaFCtKY9r/p3SliDWvuc1mlQFjonJ20bWqK922w/15WM9IR8ND2Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856125; c=relaxed/simple;
	bh=CpM7Vs/2nA21lLEDS5zFQlDltZxLar1+tK60xO2Z7UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThkaeS6c+L+zY/Pr4LXtG3qII87PD/7ftjEUfy/BMa7H8b61sC+iGEFzFT7sM5FP6moltC2FObR1dJn3uHA4CjYsyO/UBpv13UeMpyCgBuyMhJArS4rfgt9BMJFJuX8MGNjmsjeiKfI6GIXHTSPNZFIJUf+lDBDCYyoL74gj774=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIRl8WZ8; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIRl8WZ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mECA10oX69ZoVg6sp6fX9Ii8h+5hJrJlNhIUAKZcQpn7nhoIEf2cOoBT9W+e93bv+6bSrkpexQsW5nkxklvU+87X2DwG6ab+1yhOaBsDpjqd8D241FAdoUKQJ8UqhuihlNoZMHpHNw4pnLSVNYvYUtlvLK5fGigdd9T9TINL18bnTKT1IOvh7Itlvpbpgt7YHPXBrN/pLHJ3Fqq4Lt8mV11VGs4+qOOaqAZY8CJUQI0OWnoPG7pfQ/X76Gv85fk+ijxiLcVHQM/0aU+aXoAfpsprcSuDG7rv/o5WpzJvH8cXevh0enTqAf/XCEaRP+DFxHQkDkRoIiHhCvWKWCHakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwPOFx61JWJuphJdc/uphWuP+jljOvmMztOko9/5wN8=;
 b=gwV9iYVkSbYyEHkbXFu+LJxlpo4NwA3025+Kctb/pJbZoiIKRTFpJSMiZ19ra78GQklysXSQYJdf665y/riSvvfJZdIaq8u9XYQW/VtmJXLRTzES6Jfny2c5hGqs0wTPcv8rvaDgjZVB47jzQD2FojT1NGwO8k2bUsE86pwuivMrM1rCQNv6UqvGTJIcjElOoGqCnYSoHqOmL/rqa8H3kInADaACARgpSgKdPknUlC8Fzmi16+TfUvOiAYjumPDmoHvIcQnq6oo1BJG1ULq99JVRTefF34eGyZ5QfG1jvBREX9UM5VUybuXVgtw2Fd+0IRoA+vEe8xE8Myel6fgWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwPOFx61JWJuphJdc/uphWuP+jljOvmMztOko9/5wN8=;
 b=cIRl8WZ8w0i3WUvA+iOv/7c3eYmMCMXIqY00ZInZwd1oAeF0Qqt+kq8MrqABIVKgqVGi5UifZR2CGMfEV/vtyODdXRpUBOB88hZZRXLkGp9WT/uaAd4NLboJXHG1UK/HCKSL73ZWPUj1zz19lwP26Chf8EqQxf+2PcrdaH9ABjI=
Received: from SA1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::9)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 17:48:36 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::62) by SA1P222CA0002.outlook.office365.com
 (2603:10b6:806:22c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 17:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 17:48:34 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 12:48:31 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH v2 5/5] cxl/acpi: Enable address translation for Zen4 platforms
Date: Mon, 1 Jul 2024 19:47:53 +0200
Message-ID: <20240701174754.967954-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701174754.967954-1-rrichter@amd.com>
References: <20240701174754.967954-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1de2f4-4636-4d60-ac68-08dc99f60770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z2a566AnEd7FNnNDOLXe/K2bODuV3UyWi5ng+5LVsz2RNWTMhzQ9bNoHhipS?=
 =?us-ascii?Q?Jh5WSDEFSEd4/e0z4+a+HpMpzfhsj1lmw/Oicvq3Lz3ax2mLjj2wMG2+hbn8?=
 =?us-ascii?Q?Yk+7zgWU1ZbbHS01AYoWv8+GCc7a10GAX4JDZ8sVzm+BZpyk/g3F2I3sbnAu?=
 =?us-ascii?Q?hJXTUvFuGghGoRKwGuKTyDyqRmFZnNzmqTXD5RXgOhqDl9ekzkBFSGT9z1zA?=
 =?us-ascii?Q?TfQVU1/BE4l4SPNzd8QWFSj3HGH0UFTMD/9hYm75ZISKHWbJizitsbwfFF71?=
 =?us-ascii?Q?Ktl28BGOLjDAGD7lDT8jJLWpBu6QxRbUNZu1NWBaGDakvELH6OCPCsBe20Ds?=
 =?us-ascii?Q?+/jgHCmKclQLKCei1lZwu6Z4t5SU0XySl1Y2zkYnmF48Zjki+0sL1FI3hgND?=
 =?us-ascii?Q?5cPq2qo0EU+JYlsBRjNLnWvkJvCgQhqdaU0z5qfM6R+RjGSF1ma4YhDLFV8e?=
 =?us-ascii?Q?jLsuElmnwEbpK4kuHeEEQZQl+Y8AAbfCD0HuA7SUZoeKpEEz2m65JtAgpf4q?=
 =?us-ascii?Q?cDyOjCdAAIEM/RswS2IK7ND5yr/UBqXM748ZMmlT8bNLOelJqs6OcQQ3RUqn?=
 =?us-ascii?Q?XpEhf6UmpO5gQLEqFINXG2I/yssuWXrv08pgLwrTKqhUKM5rtrP+ogR2vFUi?=
 =?us-ascii?Q?Yc0Q3I9RjpqzBXeEivyMg7YyyLSLKPTdtkvAcJyyrsZvaqWKVP0hpvU6Aya0?=
 =?us-ascii?Q?MFDTOXnqQSlf5nIvYLbOWswXlgW9/nRSSyQJlNNU73cu6HURbwTtNaFoLhcq?=
 =?us-ascii?Q?bIHPg/7PeX35Chc8/4Z8YNuWc4XzfNRzJgRhXJNz5g6ORSS+HHEctIfMm28W?=
 =?us-ascii?Q?We4Ljizakot73WWKjONrR1FttepvSTsnXvPxzIIfALh18eAVvBv0A7W50Tj0?=
 =?us-ascii?Q?QWlhGdmMzajqXWMVWUu5S8jNMrIrDzATw56+PqH96f/FZRwnmPBtBd6BAqE2?=
 =?us-ascii?Q?Cqm6zsf9VJ0CwbBkKqB6zBYgAoVq4ARESmtmeR8Wc+OXPYaw4n78xeB2opki?=
 =?us-ascii?Q?F15/snIVVRKPdN0tPKsokGNErMhZ7yKG5Ga1wHmbW9huPlL/glkfbCGjKABh?=
 =?us-ascii?Q?G4RD+mykGxbbvpN4FDVSricJyTKPKMhN888VwGDck7s85+cBsTk6ErSHZnmm?=
 =?us-ascii?Q?BlPuGbguRHGTLIF9NzFeKW3xGtpFzPKWXq8fb7TUWDODnjPUl2oYF+6JMIt5?=
 =?us-ascii?Q?bQlk4x9VlZomnAHCdYUGh5UUX4w/U0hmwO2PTyZT+H0xWH60JzkcbfBK2/GC?=
 =?us-ascii?Q?7rtdfsLC18W1zNvmZeGGaU3eEtjCp1xAsiE4AQrbtvvw4vDo01CJsEGg626K?=
 =?us-ascii?Q?Dzzg9R8HbMEelq3w7GGhLsgBwISlHlMqWJRpvfz5vm0Jg3bSbLLOQ68v3mTl?=
 =?us-ascii?Q?cZoABHLEozxWkJ2CdmHnW6gGeU5BEuraIPr9gXOeZ3DX/s+rlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:48:34.4659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1de2f4-4636-4d60-ac68-08dc99f60770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139

Enable address translation for Zen4 platforms.

Link: https://lore.kernel.org/all/65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch/
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 67f73a831bd3..70fdb806016e 100644
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
@@ -538,7 +542,12 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 
 static void setup_platform_quirks(struct cxl_root *root)
 {
-	root->hpa_xlat_enable = 0;
+#ifdef CONFIG_X86_64
+	bool is_amd_zen4 = boot_cpu_has(X86_FEATURE_ZEN4);
+#else
+	bool is_amd_zen4 = false;
+#endif
+	root->hpa_xlat_enable = is_amd_zen4;
 }
 
 static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
-- 
2.39.2

