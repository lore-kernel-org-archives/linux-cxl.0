Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A48211A0C;
	Mon, 28 Apr 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876671; cv=fail; b=LIEx18B9JEYmdJvGXI1aqG4Qyxx/s1m9maGQ19Br9COcXsVmcVBsqEle5kSZaGqxeQqJ7W23CgsbI5IQMxRg6RD+f/cHoGGb/sqrU353kFCe/h2XDX8Bv4h/j8y0VRBe3QIkivX/HXBjpjDzH1P1ackTLdz2GVlpJr/r4Unf0Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876671; c=relaxed/simple;
	bh=4CLf638OjMScY4W2CVrxy51HvsggIqw0ZZ0oZJI/x7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dto1yiWkJfjr0Tsdq5UIfWUhtAEh8Gz9KyazQX4XNjmRWKbn8/a/dHCxDGYIsUmA4/9D5eq9mQAjbBoM6kruG1FGuAUQff/R7RgnJ3BFYuiLAUU81fm4DwDltcOnCdn21Hb6/8tTxwuokOp2vHi7l9myev5aUwauXy1EWSg3R9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tKphX1S3; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tKphX1S3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdNm102kf6h+vg+gBzYGgePhjY2bEFtu2xffrPlo2gzwfrhwt4UlCD1vAbCpSFvuZRVY99WZWcKnj37q9yCGbT/LvQsvE1MuGuokBWuh5V4nOreMC6+tgAYmb0Sy1URb7/x7vvh12T+rvM3AZmBeERVSdlgGhSCjK72PWzAEO3a3kItasxfNXgjMsEQdehyOJ2HPJenqMYjGqJ1znRszhiC/lgE279izQhPVqyTwnrL51u3BuzvPYvfRATl1rGTfT6F5Skpt3X4NPXh9DjbAbn1WbNZgkUwFd7Mu0HEeRbos3VfV+csTVEUufZt7zhg/aD0+Zt8NfeNJ9aOcHUwlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WznrfXShiLnY8YfHApKg4UKJgKOUc1LqdpZKx3qJjUo=;
 b=DN+hNyHi6zzmaIT2E8UhNx97mJjKw+1Ecs5NJbUSodWIlIUwjUGEgtelbbXlfpsnGLSlq6X+pPYAdC4gYxfdR500L0MqmUAD9YGBdFNNIEOq7VrnikSlLs1Vwpzxek0Jhr7bs19pOJ4FYnp9EB8poWzC/eUNW6Oq2OuhT4jZfdC7z/ogXMyZM8Wwtl0V0jORujQu3yZGT9fxKuaznj5NjMxzclUYW8/1FJN9CGbgf9ElErUw+igMy72Bk6pe3bIDE5dS1IL7eNdU9l5a/aQkgBSKRDqq1878Chx4adDqxqml9Ebe6tZtTukmvHMeCsCMmeJ5S6OrVmrWCDeSg/becw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WznrfXShiLnY8YfHApKg4UKJgKOUc1LqdpZKx3qJjUo=;
 b=tKphX1S38FeBpqxBU8UTL4IDapzTZ4aTTMHT3yXnnpF1cvwOI/0ONa16dQ5jCTpBzqxtT9rf4Y/NHE08ZeKQnU+SKxijYqpDTZWJn++nKym9qfH6hFt1zz9Bd4XxGXSX2ZxFV6zEeApf8Vg6pWBIU5g6blspHPj6xIEclDEnXMY=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:44:27 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::4e) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 21:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:44:26 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:44:23 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 12/14] cxl/region: Add a dev_warn() on registration failure
Date: Mon, 28 Apr 2025 23:43:15 +0200
Message-ID: <20250428214318.1682212-13-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e87d39-1766-4acc-cacb-08dd869dd95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W8wItRkI2Q4MiSqhsoe4iYTNrB64mXZZKN8AoFXePh2vxlSvknC41O1Ya132?=
 =?us-ascii?Q?V6rAPZgMzhdlKi/HKf+lXKMtghHXA8zYjqPP0L69r/bZ6i0WmtG3ejh6H1DG?=
 =?us-ascii?Q?bVOtaQZcKSybMM0RYYWWpaAKGQKr+vAK7NHL/iwVomSz84eFEqlbJtQzJnP8?=
 =?us-ascii?Q?9EW0MASysgIgm/CKr8sXvX55Yd1lyd7OwY0+g5ucjW6uWA+YpGG9LpRy/t1i?=
 =?us-ascii?Q?QE8sDcM7seKbgtEvvD/EZ5Oe59e4FhS6J5V4Ctv7ha7qQQ9frYXsdJdQkxEV?=
 =?us-ascii?Q?2ntlrXzpah5aQJ/tN0Wnqf077/k6op94cIrGItX066y3yMt1nASU2PZYcjcB?=
 =?us-ascii?Q?tLnuMJqsaEwt6UWtIzdXgq5x2DfuD6ssQQChoZti9NW3Wn8cf85+pJpThBC+?=
 =?us-ascii?Q?MF5Hft2DEciZ4Xklp4JNDDDekSa2Tgi4q3jdESfqaCADs889ofnvFZIuw2bW?=
 =?us-ascii?Q?5r/002yxPbaL0uysvdIdsHg5kQ6FnJ0o3Y2g1HNgv+oJrTrNmmz5SjoS/IaZ?=
 =?us-ascii?Q?tlkaE08ird4guGo1fhG7Qr47Sajci/AQG1DKTCYjtt93bD7R2Kyd7fcdx2dc?=
 =?us-ascii?Q?SVChwrrNa2O1MKiZBuuWh6zNZqX7lpiqzUuAzbovuZ3V2prtutm0dbwJ00+1?=
 =?us-ascii?Q?WeobHkaNGQ0f5A8iqsyK2IHLHQIScFVkTY3+/CtAOPWaZ3uqqipzY5PbLyqG?=
 =?us-ascii?Q?4a1jCYWlojKcJcAgxPkeosUHoqePKWHzQ/UcSJXrM7pAP7yE+12e12FG5gWr?=
 =?us-ascii?Q?mbsl14VzDzAn0YJci8XWpblt5lgRXJ4mKNXTxbdF0JQ/KL/FR69FBn+A2n8Q?=
 =?us-ascii?Q?CN92muD39YCzNhDP9yHeUld4Gu1MLKksiPjXTq2/znbxyta+za5rA9Mp/Eap?=
 =?us-ascii?Q?UGLBE7R3vLkJiS50JvVFP9RPZbcLqZO5xqyTsDoo/5BZymXak7zEnYpDKuzS?=
 =?us-ascii?Q?4vZw+Go75OCBgPgB/2hIheTsbY+Cqt0TCnLQeKLm/8BaHAh38pOZwwGaDZuj?=
 =?us-ascii?Q?yPLAHT4qYk0/mUO7v7Aeb3Ea1AsdeEq00p/6Qx/h2b8OyHK7dpY6+SVMGMHg?=
 =?us-ascii?Q?Pj/uZowkqPkgPyT+/otWggCsJeDpwWJbUHXH4xKZBMVCB6JnAniZp8xfsKyz?=
 =?us-ascii?Q?+0hN4RWILTx6fWxHsG/5KLHUf0aOhCHMdkDy1yO0TbAu3VdLGUQ/yIgq9kvq?=
 =?us-ascii?Q?88LlFWWuOuplLoyGwP4YbGUPxEetVoWiQ6Lm7oYFKfyeWYt8NZDlBM33BNqq?=
 =?us-ascii?Q?X3cN40rYHDwu4rLvyv2f8A9gLluyPkJhnsi3rsAruAhhG54VN6wxyQCRLrs8?=
 =?us-ascii?Q?3BD7YXBIbkx3YZPrz7nxR58AwqrqDva2xSO9rscMEBS6SQ6LrI/ZrwfNEu47?=
 =?us-ascii?Q?mOhtZh3aHRJwcLxSdFqdwStKPa4sZ1WWi4WPpHyBzbL8atnqI1thiEoAo/3e?=
 =?us-ascii?Q?5OcNGetIVyeGKIFtE4B8cVm4H7fMe9A1D4X3eHtbfS5s10nUI/49p0qLqWAY?=
 =?us-ascii?Q?yL4GKBmzUQq+dAeuL02JZ5tJksGXaUhj888O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:44:26.9795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e87d39-1766-4acc-cacb-08dd869dd95e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

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
index ef5408301714..560c447d8136 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2169,6 +2169,12 @@ static int attach_target(struct cxl_region *cxlr,
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

