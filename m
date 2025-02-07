Received: from outbound.mail.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA322500C1;
	Fri,  7 Feb 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942769; cv=fail; b=SQTNefkPWpMJyPi9Gk4UtUXCXCxVBN+cApjqiZVc3+EmtLHcfO8YLMKoJfhSvwJTCvmZjI8eGzY+Yh0OvzrEYw7Z7lH21CPwKzEl+OstJWrETRwiViNY3duzpFJaZc3z5P4H6iZ165QkyuOWKsr62BNBm5TtX2Aa2HLo7HYmTzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942769; c=relaxed/simple;
	bh=vaRXiTTTYdl9QdrDViWZv8abaSXPXnW9cVQ5TPD/mE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3XmXj+qoQ2O1ftFUNxbMmZA3NXbxysnvH6sKbtGpW5LT1IDKBLxz6Y0ImdA1GREo1/7W0QRYh0k5LNxPZvyCXzsHGZ5KfjFUnroOjoOSDkkmbEdk0No6EgQmV0W1h8qIc/c1wWPsvxxArqaTQG02x170fAwnZSnQir6ZFxlGaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M5JGdgu3; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M5JGdgu3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeQrTHYv+Orv3emDPujmaSTfscL7F7Nc+l/q193RuPuc/qax/31zC/expVAE4y35K4JYNm4HUwZdBDZcAqV60wF8FVETzZH0aJJ/iKnYPhwg3U1PV7tTy98Zl9hmWBjPAgDPSdmpbuvA6edtu+OIkV7h1pcCMQysptK2toeEOa64hI+v0Z80uv9uE4ItQ9dlekEW7tD3Lr+c2RuNIwlspj5L3p/wYbZdIvYAh84PBCf5NO1M+EuOK957laFSgZzMZI7W46PtI9qxCleGyZNhwTUZs0HNZ5PVkOemWdwZd7JLt6aYm4VoXBWYdscat9mGL67ZvSZY6qJt4QEk1p1uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0w2fMhd4DD1eD2nixGLYLH6kh82RTcJv05MJF5WZbM=;
 b=xt0DDfbwY/+WrwlYOUTAwhcWKeFC1DSgoyTqxpelJI0n7FLzhk0aJXa3O0Hp/02OoYaeFKPC55riT8ZutQLwyeRW03gIfpKnp/9NqabOD0giF6PA7D6ZkXpYDoKiAp6S5/IBFj5fhf7iHDZ55PFaxCyjwOLTegM2IuGr9YRvD/zCz3JXRIF1iVIRU6U4z2URVK93dxyB5hmT7PDKEHREKgTmAFt84O/bnrCVKm2007thZfyoXirhVjnk+YFacy6Z6r5O5ZlMVZWx+E+UZqU3lMZ3N31j6/tlhm0AahViH2wml+Iyvu5HLEt3HJ7LbsSTawkQqmADTVl6Vp4mfnH5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0w2fMhd4DD1eD2nixGLYLH6kh82RTcJv05MJF5WZbM=;
 b=M5JGdgu3PL5TmT4yo86t1v6YLfsOYkgsAL110nrQYYEW3eR11QY6HG302KZBn9Zy4MKO8JRNy27iC6WOOHl2lAMUe9fZb47FGCbDJXhkYTHy+y+ox5nkNnOwxZcRLbXxdMNYs+TVCXaUTsTvEMmbZiLiI0SPaTggWqCxrtnpjng=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.15; Fri, 7 Feb 2025 15:39:22 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f6) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.7 via Frontend Transport; Fri, 7
 Feb 2025 15:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:39:22 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:39:18 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 18/18] cxl/acpi: Unify CFMWS memory log messages with SRAT messages
Date: Fri, 7 Feb 2025 16:37:53 +0100
Message-ID: <20250207153753.418849-19-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 557298e1-2f22-4100-13a1-08dd478d97fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kYqXyOkEHc6DNKGqd9H3pbLW4hq+Qwy/XY0fxyja55G8kG/u7cUlEvZDoVg4?=
 =?us-ascii?Q?fJCbBg4/jhZZQJLVRoQk8Db+hvK5kdrvqBHuwL0XyLdUb9o6b6rxr/bryWf0?=
 =?us-ascii?Q?JJsj1wgfmLrwfiTi4VgmzNXlfTOwWcVpDjMOj6bXTgzI6lymJiiqHCsQiAVo?=
 =?us-ascii?Q?V9+/gPvSmKXKNDyMzAqJp+Mzof2sAyRGsPh3Mwp3Um/UsiiqkI247riqjUm8?=
 =?us-ascii?Q?Ia/yJ4I+loLoTUlHeckutwYH2FJ4APaw5t3SDK3PX5WtgQoasS5P/nW3Nyc7?=
 =?us-ascii?Q?//Zzun4k5BmtslB1xEe2/lVH/MtitJcUCgmqdcnKuxEIKox6MPgt7Nw4dkHC?=
 =?us-ascii?Q?oPgffavdwdwhuaYo8NK6F3uCgmhWg9ISv1UYyIu2bu2rXpuq/vC4WzrFb4DM?=
 =?us-ascii?Q?1+6q5aK9qfSo6L7TFqIUznsCQ0oKAPHWrQmYS8c5Pr4bYteCctctnwK058Ev?=
 =?us-ascii?Q?JpeLL9/kPR2QS/uXHvlgJYXmP1ZRiU3sQ43PCzcJ6t/wuEnehbqe7ifptyJp?=
 =?us-ascii?Q?2Ao/FjakwdbrULhNNvv/dlzuXU0GwrdJ2sHheAYSAnotGEcmzn+zN717ZlXM?=
 =?us-ascii?Q?dK2qzZadfAupc6dds9/Dylgf/LfcAJfoqHfse7qLyQTBFvJeZpDUI3YFUfZm?=
 =?us-ascii?Q?1NK0/UTCliQ/uLxPVE2GSecMLjW8dl80AHEmAnoPsinG9oWVD4lk8qAErd7E?=
 =?us-ascii?Q?8ZYbV5QbWFpUsjvFK6uSACXegW3YbGxTaJlaMfpYfTGkQ/mP+DTA+wjmVwbh?=
 =?us-ascii?Q?fJmJbKI0vUMwM24+PHxG2wgeFKcq6eXVqUK2EIbPVd45ZtK/e1xg89ISzWeS?=
 =?us-ascii?Q?fb2MJR1Ch2M9EPiSt6HxvMA/EOEF5F6B1iOHr5AINVnRsEiaFiXFttyrqFd6?=
 =?us-ascii?Q?Nar+gdfMEcyl/d2nbzavOxh3cQnWLNVnxCaM0uRgN/91RyBDsub2apW4Dfei?=
 =?us-ascii?Q?AeI56jFRRSCtF87kdYuvrf/vt1e7578H03glYDHYF+sBB3Q/G3nD6gqKeBE3?=
 =?us-ascii?Q?7BM3/uUlKxpw+AKQP9/kJigokW5KIt9pTf8JFGlmbIrOivWl27dyp7ZDQ0r9?=
 =?us-ascii?Q?3jPOVdGtNV98BaRpCU+w8cgiXzFZeueuPLzBJ0d8FKSh6r+FHlRODRhJgXWF?=
 =?us-ascii?Q?3ZktCxXX/7/ZPfC1DZfwPhEhQAaAVPuGJZI02Yty1hsGggeYEyMMq+8iZ0IR?=
 =?us-ascii?Q?J+WzoKcVf8MSwFMfvVTHY6u7GOn79K0WfCzu8feS7wCBBZfnwf5MOfHc2jJh?=
 =?us-ascii?Q?LicZPGJok3RqWA9OsJLkS2HYTmq1HLbaprzRojp7wFNtKIjMbwSUHr67Ttny?=
 =?us-ascii?Q?iUzkJ3W2EFBGRmDpcPqdPj1u8pGZmLDUqJYaO0WhYQeFCtcrD16FnRv9o3rR?=
 =?us-ascii?Q?/1rgbcFxnxPWkXSROEX7zBDOeDOjkDMPa2h5tKS9dJfrMzdzsxBufVhb8Li0?=
 =?us-ascii?Q?RqlTFC2XtrZa+sl+99mwvHzRgLAQOj8fYFq/U0WGQbinXvD3hbwmKW6YZawn?=
 =?us-ascii?Q?Ps7Yh6GrZFdBN7w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:39:22.0444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557298e1-2f22-4100-13a1-08dd478d97fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416

CFMWS entries have a similar importance as SRAT table entries to
describe memory regions. For CXL error analysis and memory debugging
information of both is needed. Unify output of both messages to
improve logging. Change the style of CFMWS message according to SRAT
output. Also, turn messages into a dev_info() same as for SRAT.

SRAT pr_info() for reference:

drivers/acpi/numa/srat.c:
  pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3e75e612cbc4..93c73b163c28 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -447,7 +447,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 			cfmws->base_hpa,
 			cfmws->base_hpa + cfmws->window_size - 1, rc);
 	else
-		dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
+		dev_info(dev, "ACPI: CFMWS: Node %u [mem %#010Lx-%#010Lx]\n",
 			phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
 			cfmws->base_hpa + cfmws->window_size - 1);
 
-- 
2.39.5

