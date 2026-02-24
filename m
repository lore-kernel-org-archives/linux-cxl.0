Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718BD39C626
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946821; cv=fail; b=OuKohN90vLnYbZ9U5WJJaL/spQe3HIrt5vAGBy9lZPAd2GqOXQydStGZPPo/SgF4mZDVoS/feqA5rawblJjVudCH13UMfJkbm7+xR345AXM0T4Vu/27/1ESZXmv0oG52H9te/B/ujDC8+94NafUcK8HLgRdQNUemUgSUJaFOpC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946821; c=relaxed/simple;
	bh=ab6uVyV5ztU92Tvb+XhP9abgj84P8ZuGowudgsnoM88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oq8RV2rO3n9yKrRnewNosC1LwgCHlaJO8c2zkgySA9RyeDMqdAH3+ZswMW8Oy8I61/Qtm2P+XClS01nuF9G3NkUVPCuUi5hoCucIZjorPh+csW3ZlL2GhX7n7NZ9O9Zs07i4d2GIQvyh9oIlJQC2eyKGpt6nMtX2M/WtbFfN30I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XJPGSBXC; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XJPGSBXC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0FCBLHcyc33aYZRIwBK5nKKmIfpJlHFmzNudIOK9nOVMrQJLK+QTTKMm20n9C6Xb9bvBxBfzI1TjakCa+PYdxijfHchpI6AsVTETxa1cZnv0iKO5qtVix9t2ppalkyYzh8WPxOIKfKXVu7XSiGHEB0ugv8dKKFbkjfGgF3obbjVT/SG+ARp5MzjEvYKre7wrSVAWuk7ZTyRgJLAFx25KU+cVcqn+0LnLGRkFZxE5Xnqo25IyAHgOrBossE46UjI1LN4gC3WBYLy/y+jBLztXQu15T4UR/zz4U2hGvFesF9/lyxJtamRgK69UiEsbQlo47rlBIMLVnCFZtJB2cdy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssGsczq2Yv8N+AjW3iqdVau1M35Tgp/ukOFeS1UiXww=;
 b=o6DjdM6dhs0izlSB4BAPM7c5vTfpgSBWj2kcK4a1gARU80rCgIeVHUXlnHEsBoE9O9zqQquw5LeLW7OApsEGd2aI6ECTGTYMo8VQ+f/3Lwh7HGsP6G54gpeoCAJoxtMTAsE6GNRobqoRFT+xGLqpYmVy/K7H9EDE/I/NcRhxKsPVk4Ah4KpOHKQxJwp5f4wHLUdmt5cp42O5wKDhFcEQzutJ81rftl6ckwgL6SvkyfvtO8sGs3otIUVVALoGZrTh/GlKKg4IQg6iIUHAzFPpUiNx7lscCk/9RYu1wOEsDvBD4vWM+uxzzCu0EVoGFPzNxrRm4M3hMjAMmV+HJ5NBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssGsczq2Yv8N+AjW3iqdVau1M35Tgp/ukOFeS1UiXww=;
 b=XJPGSBXCImFF2CAH2My1QrhhHYh6Rg+oKJfS/9+BZcl5NVEdbL/5iuocWdzsXaOwfdCx5aNklKrG6ygH/xw6UzYQgryacjn8bYE854aMh2om7PATu3ynVxqB9zzKYoc5lGgVwxUNMuRUZfj76iJziPVLoeqRCtyWXhkLIqVVrr8=
Received: from BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:26:56 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::d6) by BYAPR03CA0004.outlook.office365.com
 (2603:10b6:a02:a8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 15:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 15:26:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 09:26:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 09:26:54 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 24 Feb 2026 09:26:53 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>
Subject: [PATCH v1 1/3] cxl: Make region type based on endpoint type
Date: Tue, 24 Feb 2026 15:26:43 +0000
Message-ID: <20260224152645.3441489-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eb849d-8f14-43b7-e6c0-08de73b924e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/JqnWa0pqq11xgOOS/SLif5wslbtk9OlNc34I4Fiq0tZH4o7TYBMKDsbVjz?=
 =?us-ascii?Q?mcYyaLnnFmm5XF0pt46mSXzXp31QPF7gBo4HLbW8OcH4JuAzj75e/WDBfcpp?=
 =?us-ascii?Q?guZXcGBRdEAGDXoJyCn2aUPXMgC+zPYTNzHbAIRvyQ6/Y05u75m0u1bhYMlM?=
 =?us-ascii?Q?EqktMl7BcjYy0ns3MVQ4RoAyekCozfTbWAXnBTZ1rBhTvDH5+HvpIoomvqVo?=
 =?us-ascii?Q?54YFLk7L9bgRw+7doeDKQ2eyCvUhcbETRh4S/wGAUPTRGaCWj1m1TO1MWnFG?=
 =?us-ascii?Q?q7Lra84CgSxXbra13tsWAWcTrPpnrmiww0njkyG84OavzGvBeIUBNRcvL6kK?=
 =?us-ascii?Q?MeA1rtPRDMII83yGGopAAHskMnqZGerH8aaEZd7YSRW9Vx/OFKf12XfVZs49?=
 =?us-ascii?Q?wY7QnJCPfAgbkMBbdC6qaE/RavfNt6DLxeNeumqnnMgvcjhadXYwzbWI4Inn?=
 =?us-ascii?Q?kpMojx1KO20Y/czL+FWqgvzev78FNTKX+1AlsbfRjT/4TeqaU32bdTk/fHvh?=
 =?us-ascii?Q?v/LK3PD87Cs1lNn+jAAV1qCzmFRxhJSYp3matoXWNnRP1wN2XbQ+kDy73lFp?=
 =?us-ascii?Q?ghEXXk4N3OyZo5YMGHiP+ZOoZlhDJjlBfft+jsNlYUOt5Zxso44PfyqFjfvk?=
 =?us-ascii?Q?SUaHD04TAOb6du3cDOnbgwbdmyAErsIFlUEc21ow5bbFFvv4kmsMc/Hl9VEZ?=
 =?us-ascii?Q?obR+rLiNJTvlZL93glBD9p8dmYodd/h0s578g5fzg5ozrwIEZZLCqdVHqCsZ?=
 =?us-ascii?Q?ob0CCY1T6vBnRUewoittUB61vN3WjarcyGmYLKOlrGLCILT+F25b80HiSEnn?=
 =?us-ascii?Q?KsDO6w1UkgO7xV6/oa8XZU9ByBNaF5o2uhT1Dq92eLxY6D+5x7FenGJzx1RM?=
 =?us-ascii?Q?gIBSS3uNA34IOT550yE7qIXcmJfay5EMZLHyWpx5nbQV+w0sBGgvA8kCU4F+?=
 =?us-ascii?Q?d/cETb54GNO0XJsrZUz2T7ZXOqdzwZkcIyil775f49KjXgC78eyRpwpDWApR?=
 =?us-ascii?Q?dfF0SztsJa+5OB0K6jwkWicV3iDytMpA16TAmid+cZgOPlQ2h6xr3UimpBm1?=
 =?us-ascii?Q?mZvR2IqQsi0jXNoTxm7PagC7aeaDWqyzdsxw020Jtp/3p2cJQQAmJtOa6BT7?=
 =?us-ascii?Q?3xH4E9UyXI3d9tGBVKIeimJFzvVY1T8zZTKDsKEBdb00ATumLgLvyYHl9Ng4?=
 =?us-ascii?Q?RPTc2lHtagtvXNu6ZuwnIkSmFxu7fQjHzWAv4Iy/p03JdIYc0Q2fI3pyyK9V?=
 =?us-ascii?Q?3hyJJqhCST99pnGQyVrEzIeYeTjly6upPsBcMJBo1aEVSDj1DjCSuFzS9yMm?=
 =?us-ascii?Q?QimCD8+7xv062N2sobtgFFNo+dnB6xcZXciYPzrpGh07fShaqyX/L8zSwWnK?=
 =?us-ascii?Q?f3O4CHeHOkQwjKYQxeKOA6TgW/ia1h/rTAa11OjHwYmB/vLzR8ZJ8xm2MdM4?=
 =?us-ascii?Q?RhDqyac0q+UP8hR6H9UKcaqaii6X7iwarPC97ELXTWWnzvT5N0ZznoxUCE1u?=
 =?us-ascii?Q?QtDq2kQWFWzqhKwRw+edTubKhkcP5xDBJrrEYwNEbxlZ6wWxWYmQjrJ3M87A?=
 =?us-ascii?Q?bRUbFeEtRUaa58fezso4Yd+KsdVgXjX2w/FXDdr2Ee0pgPQrXxw7zlWdxKek?=
 =?us-ascii?Q?aedFfIUax8Cs8fqVZIZLVaugbJiinholgJMc2KdovfHtbNi9oTVsRG00MCmH?=
 =?us-ascii?Q?ephimg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N7J7ARQDCZRKTKHn7vcXyVcQJWGbO0RJQckEULOdGPWB+sjmTAR8X6lG6dQd67s8wqU1DVMkZkJx1jFbAs04xEAY2x6rTE+zbUPnQFT4+nwV3Or7wbfvMjOqu8m025EJOMrbRxfqLo7oIegR8y38wTklXv3oR7OkfvetoFz4YcK6U50GLfE8rOfZBNqvG8zb3tiFAIdl9GekVo70vUqjHcSp3OTBvJPVjlgvdJWScsecmOikm47xRuuQHCzKpCn3oU4OW+68g6kh0BTaP8I3DWxqBp1vvotjtjixQczU4RXY/U6ecQlzdqR0iR9Qjh8rQHnc/6NxQv40pafUWve/XPZuN8+yfE62yMU/5GYnYlU0UhaKGnpulJLp5Sinqr1SGdUUKHBPyGeGF+3BDxhgzcXqhMDoO8t/3yK41zOMREaU9obomv7OEjJLxQ7G6K2j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:26:55.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eb849d-8f14-43b7-e6c0-08de73b924e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fec37af1dfbf..cac33c99fe6a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2650,7 +2650,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2672,7 +2673,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2686,7 +2687,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3902,7 +3903,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1

