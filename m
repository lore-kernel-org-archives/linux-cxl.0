Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F12F068B
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034282; cv=fail; b=u86Ia81jfd6wVjwHIZKGnYIaWau5AwqaMZngtrFvllQIwf4jorkbHP29tfVynOzhdRcaCFW3Ck4KIQyup00P4ARFz9poBFWmLPYCzRAapMslNzK/7Z7ovPHi729vcjMqudP3xik6DXMl3EYEdk23i8QeyGjWIW8mc/6W03JzgJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034282; c=relaxed/simple;
	bh=yO+xbzooIIlrXIQmPau7Zi3h5JYzUbcct3ITw9xaymI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQsfgveyRvibAkQgWNY4t1r/8Fw06S6TB+XptRDNfPbjTS5AkowJDLoTxxfZXryGWSEag6yQV9BrewiKWb/aB+pvmC1m6yxqOtEzEOH4wD40Gn2+DNwTUDm/2b+meBUx2xEXomTqFg76zuOsJ/zEDsdlDETDoqE/WaoZsl8uo+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dqPwrFDX; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dqPwrFDX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvgIvBBrsDNO717Um7Uq/54zfbW0iWbljLSO195x+wmdH4cnLBdqE0M1X8pkniwcU3VC6adKlzGpXZIzBRD227LdbySGg53lIcnxP+Pnd2X8s5XOm62+9mmvkRPVTjcoRFnzo5cKErpS+w01GrPtBTOOWdhfZdM+jPpvM4G6RN9arQwCj0/bW9lLc3czIssIsrbh7NkwWXUbwT71RCauVK25fe8e06NPfigBOxHzNHsmCNgQGf2GrrniBosSQoNBL0OjgkTorEqg6wwGtkHPnoMItYTA/N4DZGlgK5CBXofrEn3NpnNZ1Ian2u9rWuXAXBAiEIG2xajyilgN3tAxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYhH0k3kJMl5EOrThT4MUGNyeB/XrdlA9ZSRs55GmHo=;
 b=ybVG6APR7cfh9y3SZDehFybPZWSqSTrM8OljXpc9AEU1GcCKgb4C1Hyyc0RrZzOMmjQ4qBJAT45pE6twpbQIJ7znvMeyjh2l8AJ4X8SvdeYKfYqFqpUwGKpltL7aVvqJWewbuhkw/qCL1Yy7nQiuHpV4B1zdPrDBfaIsaKgrBRpoe/1wDkJ55Y25pIF4pCivA0yqfpVTYzn3Y24gjlrWLGRzEpf5cgjvmmaQZgfoy/3Xk+aNQpX0DlLB6QH29DalrVjeF1Zxel3U0QY0LTsf4EqIlGRoBgiAUT603amSDImkHc6BJ1NP2BheBqJq4jNEoWDn8q55hF3cIcYdpCjffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYhH0k3kJMl5EOrThT4MUGNyeB/XrdlA9ZSRs55GmHo=;
 b=dqPwrFDXd+WPbWVM0tMR+35CfEXkgryzpe+hlSt36erY1kgbAjZQJpkifCtaViwCOiltJ3B0o/U8TC95dlhkPJwr4bC5v5lGZoac1ykLIjxc2AW8SGSmQ8jCXop5U/IblA4Q+J0VNIJFY7vOmBDP8kpU3puFecSv46lU/71co9g=
Received: from DM5PR08CA0047.namprd08.prod.outlook.com (2603:10b6:4:60::36) by
 SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 21:31:18 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::ad) by DM5PR08CA0047.outlook.office365.com
 (2603:10b6:4:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 21:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:31:17 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:31:16 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 07/18] cxl/port: Split endpoint port probe on device type
Date: Tue, 12 Aug 2025 16:29:10 -0500
Message-ID: <20250812212921.9548-8-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c217c8-c5ff-416b-edb0-08ddd9e7926e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7UdECKEqBbPagfNvFQQ3ekElIh4hSelV6dBxazfvLgZRA5hLESISzU3fJiEA?=
 =?us-ascii?Q?0AxR+hoog/Cw8TpZiZiirH+JiSpZp1qM4V5fBZ5KV+gntI5ywRQipvxrf/Os?=
 =?us-ascii?Q?YGH//fA3FGM8cA0LNhkCNTFACFTgyvPVRrThi1PZQXWA4avW/n2INEW+e1Bo?=
 =?us-ascii?Q?F3/fZNVjPhGiC6mTpcfNMIwAy0/RUnoLoyx9RWGjBq9tdpQq7WJ+OPwr30jo?=
 =?us-ascii?Q?BdMggTmYJsMzOAdaawLiSbqC9rYWpHKDV3FrEO/6jfGJLKZraQvd4muPflL8?=
 =?us-ascii?Q?KogExdg8WI3PAmqM+9Ho7Cyl6uw9U1mXV/BQKcpzl4s0F0G75ia4afbgOSit?=
 =?us-ascii?Q?mXxNMg3qny7jPerkn1nLNf4mqbD1O05W9q8Bpu58rNrbTcb7SHLUCFV5y/C7?=
 =?us-ascii?Q?ieVuF95GFa2i1lRw5KUlobrGzA4Nl/IMptrIqaqYMuXGGq8vMyNMPXCnhcPB?=
 =?us-ascii?Q?nT7wp7J5+2hZIA8gIHZMFOsXrfRwf95XozyU4QZB2ZIiiLZjoPR+dOpKH03W?=
 =?us-ascii?Q?42c679bDQnt8gWC9//ywpOcqmh3aoXzd7/rHqE9yHTZs7Bgqvs2fUXiMPywd?=
 =?us-ascii?Q?RrP44G9ezeAPV+PX/Pz4Ez1ty6sKi9C9h9sYvba8uufLfa3ewjZV/stFrUpi?=
 =?us-ascii?Q?6v5eWlgXU/yLtSk3TJKHXsaape4tOKiPw6G65yu2qeXHgKlQFQPsZs8Svf+8?=
 =?us-ascii?Q?lKi4UAHsIIBZBwLpOXnIh9smxoCJeo+H6lPGGqzUGwAc6a+Xdwdh6InnopwG?=
 =?us-ascii?Q?PuX3gRsAiy3t8po6E5LwtSD+0TaGPhLoiNF9UnE5sy4cfM4Q/lpRHamjOckI?=
 =?us-ascii?Q?MvcHKIs6qgUFLS9xzQUCZnlyjcHKIdtaGw5ZZXCaBHdJON84+MXCpkfSSrMb?=
 =?us-ascii?Q?TzxNyvRr0UD4MFJL2hltIsY91IcmIMws1ouV2vL6mnLjD52M4jp8GP/oXB7n?=
 =?us-ascii?Q?d3GQFXTFbz0O7Fnscr5g9PAHWX5BaUYNzd6UuRVWiBsqoAMCQYRafQT50bIQ?=
 =?us-ascii?Q?cQoRSuC5f7X/GXLRYqdJU8iBtTC8HPA/vPk2Ce7VpfBGcixQ0gjVytRCctrN?=
 =?us-ascii?Q?QDINVOw6t2QU2gFwi5+vRBCvkz7BOs8Kluv42lgi9ic6TcwZKTOZuR8f8rMB?=
 =?us-ascii?Q?RPPrLXfODD7Vy5zf2c0X82arxiopPP4+qQefgw8Z31+/eNhGDjEqO7bw4WLs?=
 =?us-ascii?Q?NKFme3O0IvbMpvYJiYURNZEQobzhve18kPEWMet6XWLVE38TuuKD4mRZXe4X?=
 =?us-ascii?Q?GbIOE1fG+ck4vKS1/Qlr3OMSUR5V0AyfXXzZyF7BLq6gzYKh+QHXyevhJmC/?=
 =?us-ascii?Q?LJbrqFUAd8wmwlJO4gVUjinbdFKjLffwD3yg+IC1c+ohFjBICwLePawZ5ub8?=
 =?us-ascii?Q?yEVS+q8afOKZPaRxuBn6qS60igGnCQNR91TLSfBmo+mZbHnAha6QFr83bGIu?=
 =?us-ascii?Q?yLDy4ShA0Hzw68FmA8DMu0rdnuSxrXMDrZawL5qX33A9uHiq4j7ectwdf4ue?=
 =?us-ascii?Q?Gjsp+N6vgFSiifoyVBO4nsCsEjVqiIOUEqmf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:31:17.3083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c217c8-c5ff-416b-edb0-08ddd9e7926e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475

The current endpoint port probe assumes the device has CXL.mem
capabilities. With the addition of cache devices, this is no longer
gauranteed. With this in mind, split endpoint port probe into separate
functions for CXL.cache and CXL.mem endpoints.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/port.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index aa6ee6cc714e..fbff4900c69d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include "cxlcache.h"
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "private.h"
@@ -88,7 +89,15 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return -ENXIO;
 }
 
-static int cxl_endpoint_port_probe(struct cxl_port *port)
+static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(port->uport_dev);
+
+	get_device(&cxlcd->dev);
+	return 0;
+}
+
+static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
@@ -133,6 +142,17 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	return 0;
 }
 
+static int cxl_endpoint_port_probe(struct cxl_port *port)
+{
+	if (is_cxl_memdev(port->uport_dev))
+		return cxl_mem_endpoint_port_probe(port);
+
+	if (is_cxl_cachedev(port->uport_dev))
+		return cxl_cache_endpoint_port_probe(port);
+
+	return -EINVAL;
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
-- 
2.34.1

