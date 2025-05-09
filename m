Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0423535A;
	Fri,  9 May 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803293; cv=fail; b=EOtwXg3kbLWpAZNq04nCxVFYzB4yGNUOXKbURpnmrDsC0r8+SIgYWwZE702MSDySeYNS2dNtF9qDMl1daTCf+/6vZjP3VSp2Rc/unKVj/g9w6ucmkjmaFd4NpbggHHaGnSg6HTtYpi5JqDayZEYaa5v7nK6lTuK4q71QBGp1tss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803293; c=relaxed/simple;
	bh=LiOyBR2t0TVGy6/e19+mLy4sccL9nPWWrgfubA5muO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQdyA3Rjq9SaJ2cHZATGaFtp7N4beddLiE5/pYzisdl+ZbbY1ycse9moDtYAkbISLqqeS9lEwW9eKOFIeSmfJg5zZcwCURRb8E8dBwMmZxR0c3ZN79vnNmvV73wwqF+Elas9tTHfjDZaaOQWp8oRsUA18Xpvhb+OgdmiViy4o0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2gl3X4lM; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2gl3X4lM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8xUOSeeVMX5MW6DcAWn7u0YSCCioHJz//EP73zOvu3MpYC2eAOu4yKlMlTJiB1geUi5P1l5FGmYA96aUTa6KWwLVyURKbPvhkodA5k4Sc7VtIWEkuLj7V75lHsWxQUMUgKmxVNj28LWwgs1FBRSdjViaPd+m8yO9tbJ7dQ8cek3N1hTWzrTHnsMx83rMjJwf47/05uoaQOBpKCHWwtDlSudbJtiGiFNNSgbdig8WhAQmAp9kOXJ08qYkmoTMPri3XCF+u/dZmab6d756ofVjDuT2zBTguugA0PAvE+HkQZkl8rYSbPftNG/SJLLobwtVxydgx7rw7HvjAbEmhSE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OmkTjrCBqZhbkIgmxNkr2R9LO5tocoxGipADkPZYe8=;
 b=ABN8jzy3rSk8abpP3OpQFfBKDe3giVwfNoeS/1SjCZprm1Oz/W9ymJPC4AMWdAdh3Cyv5atvZetwja861IET6kxqXw/x6gGOTZQVEJ1KPtHzFHLx0pHVd2dWWg5RrWPUIsCP0EJaoDP/8tF36AgfTqhvMbVifBlb1rCudh1hbvoJnYD+kZ/xGmC5JC2Qt2V08COdGOvPMgaF0OVui4JR7XK0yIwjJbH657pg412qgy3T/m9LYwmxbg7BOAS8kmzvgHIbHTAzKPYqdm+D25T1Hy2Pex0L2ayzS4aNEUy55p8HtB/v6O2/+7nWxU1hOW+K8JzQ+X2DiKF+3l9Zp0cm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OmkTjrCBqZhbkIgmxNkr2R9LO5tocoxGipADkPZYe8=;
 b=2gl3X4lMIQAjH97bpK8YsLPtk6+oSwzYLcReNSRcOFpzgj5vQtNCoMcXSax7HzH0LWTA7+DH+i2Thcc6oRVhdEpn7I9IQbK1wzuwjtHwJSEEs6McnVbyWPLtIUn3PiynIiLKqJpGDbmQZYhN+jyYNEFSmE5+w1vO4OC4piHOnJc=
Received: from BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::14)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 15:08:08 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::6) by BL1P223CA0009.outlook.office365.com
 (2603:10b6:208:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 15:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:08:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:08:04 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 08/14] cxl/port: Replace put_cxl_root() by a cleanup helper
Date: Fri, 9 May 2025 17:06:53 +0200
Message-ID: <20250509150700.2817697-9-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 069ecd2c-e371-42c7-6c95-08dd8f0b4e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F6zcw7xOC5Yp48dXmPYZBbHHTYDZ0lz/e6cfvO+pcaMXMhiVpCqxeMFjXP9N?=
 =?us-ascii?Q?csWn9UxyOfOWwjTjXp70z3IK2PCG9OX/jfzQuanfdXIXwgvLR/McVn0qXj1W?=
 =?us-ascii?Q?616tpnIXnM8HtuoaXiw4t2HATOYJbZVJCnM2OdwBKzttX19YL7ga1RswZ15d?=
 =?us-ascii?Q?khe/xtuwpX1YuR3UuDga/pjrayqehEAF2mVXCppTw3yopjj6Z5cOmqMICuu/?=
 =?us-ascii?Q?tdkT4vHzCcaAeWW7jj3+M3bBQgzqDmYcwJSp754m8C7TKvbO23c9vV+rXw6t?=
 =?us-ascii?Q?PZdsfiP+yPn8e/H6IxYxg6vZAbB+MLRCgj8s2tNjBy6U9VhL5TmomxF72fr+?=
 =?us-ascii?Q?PmGceddTwpwF6CSDHK39XyXtMoumAMLzXP6GzPjt7txwfIzZzr7bUHzpoxDZ?=
 =?us-ascii?Q?XV5Br61D0Rq6I0woisiWBFpiqkSKj09aGTE7s1bPHWvKs/uBhqz821YnJei5?=
 =?us-ascii?Q?f9qbxPXaa7HxQdJicxB0o4VRahvT1xqEtdExgaqqBt93Ln4uN3UTT/FpbfG6?=
 =?us-ascii?Q?wSYEy0+ZQtv3Sek9rHI6xWNnHPSXYaTgG9kFcZEI7u3D8d/ueGK3+LKwQOxq?=
 =?us-ascii?Q?oRoJ3Gp0D9dKXNiQLx1PBfrYtluw+yFHPkjGjYcbyIL3kXUcQyE9pzwYxzJv?=
 =?us-ascii?Q?FAFls8nJLe01dZDxffoQFyLHidUWXjzCFL7N8mJjgYSdZeqIX4Gs8gp5ncaA?=
 =?us-ascii?Q?P4H3y8ZXzQxPVzRK/ooftpc//2BWQF4NJbU+Eojce2SBAOLdfImGZwFQVjQ1?=
 =?us-ascii?Q?xOyydd+SMKTMtGoy8ePqk278vv45L1A/iKkZc/n8kjfYbrtfSsRwrL0r737l?=
 =?us-ascii?Q?mPK1Qm18JRKuQdvePFxh1k2eyx86Yt716Y5kOXUYB4xGc4YKs0TM55GVaiQf?=
 =?us-ascii?Q?n2UoI0tjcEJtoFyAELV2Eh/PDV67amiIdFHozIOQFDxGjmskcw2GB1HXKVpT?=
 =?us-ascii?Q?3TkdhJ09WXWRqpTCNfiPFkxdisjjFxLSx15HXr+00L935BeX83Qkq7EbB49Z?=
 =?us-ascii?Q?iwL96PCJDOzN3h0+NWpNwfrfQgYYU4cdEGyNPVCm3HVpqqiLhiuAgG1U+nWh?=
 =?us-ascii?Q?SrCOObjuYtZgxGfLWzyk2ebn6/pe0QbZv/MtN3iT+tO8LB/nymCcaIroIEBk?=
 =?us-ascii?Q?T9g30CoD5Ly06XsTaQYsfr2YtenlEx61GvXitjvEhZKjYU+4aKCeGFwZaGQS?=
 =?us-ascii?Q?azRxv8jAkfPcJSiNTFDiIBM5gcHOx+wsEfN9DcePkcoqCjq+hvouuOntwDma?=
 =?us-ascii?Q?d3tPAUVj5xAIvc9Jfn43WuMDFGighdGjMIED9wH4X3noj7Rczg/PqRIdsqui?=
 =?us-ascii?Q?PdHPEg+RKT6QqXN+/6RbIIhQ/BRGdTehuMKFDhrB3VEURmmkG+r+ofqkIseW?=
 =?us-ascii?Q?tmCFc7XTETVHbYBWrF6H1I6eAkYXX0FhhNj3YTW0ILBamsENBTtvyTu+sqlr?=
 =?us-ascii?Q?vhY9jaf8aDb0EP6Gx+DA4D6JogTsoayCYSgSTpMkFgi+EnL7r+AzdMHxODeq?=
 =?us-ascii?Q?OTkQZ94eZjh9XBefEWwYvI72Bai8xZsfPFsG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:08:07.8402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069ecd2c-e371-42c7-6c95-08dd8f0b4e60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

Function put_cxl_root() is only used by its cleanup helper. Remove the
function entirely and only use the helper.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/port.c | 9 ---------
 drivers/cxl/cxl.h       | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 83cfebe8d3e9..eb46c6764d20 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1037,15 +1037,6 @@ struct cxl_root *find_cxl_root(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, "CXL");
 
-void put_cxl_root(struct cxl_root *cxl_root)
-{
-	if (!cxl_root)
-		return;
-
-	put_device(&cxl_root->port.dev);
-}
-EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
-
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3266be2fe5ea..c3f50f2d5933 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -737,10 +737,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
 struct cxl_root *find_cxl_root(struct cxl_port *port);
-void put_cxl_root(struct cxl_root *cxl_root);
-DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
+DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
-- 
2.39.5

