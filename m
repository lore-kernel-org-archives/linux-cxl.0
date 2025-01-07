Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1551F4E50;
	Tue,  7 Jan 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259084; cv=fail; b=MzBYJMsO+lX7HXQy8CPa+NtqK+5K4fn3FtevAjCTHaQyLBfB9bWheCxTPyp5WPUVynMPN8MJkkK3iAQOFFDwLybNYrgeM+4wOSbI/rpVeIR97+L834xLFs6GUvEJYtO/LpNIlcmdbIxWzypSO+5lEIlknwhXHFLSsX6aVJCChJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259084; c=relaxed/simple;
	bh=KoKPF1vGlbPfl48GP3dZ+l7Bif0iVRlg4NOJ1+Sp1Yo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AK9AWjhqp2E8FLxV6dIFSPRAaVN/ZEvtNE8gHCqnalTmjeJS4zyIW2/RE/oFZjXQVU4FJsroeLpTwaHsi1lXZ5IxdhkbfEndrEhEDLMo/fPSWILQYHzV1OdM1Ncl+qk5m4esDPo8NfJh1pUmLJp1hGO26rLj+DIbXFY0lCWqlqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oz6aoU9T; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oz6aoU9T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQFH1ZAwwisdLpR2r2rpGojDT8BUE7AjWckN0+c7OCii+DbG6tb6y5hiR3OZ3ZYHK6szisOwWtN3Y5wv1CIJCyTZ91y/ifvHXRDT04WdlKGL3ep7E11wxHuHEVmxiKJalhEFe4V+6IicNsNSZ5a81ZfUZqyZrnD/KiyKkbGH0wrA7YjHiP8gsd4khLGm3xfeME2QBMif83NVDpXt6s3X1XR6UhQQqWypQiaFUbdeKWlhd6A35YTcB5wQ7Ibid75EbmHx5sbmoX/VM8XsDmbSUfLZ/v1ai4Czmb8DrFF55JCmPMkm4t6rrjZkan1yO57e+3uq+NHktaAhyE4TYxpQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9GZgDboK9f1t6dTj9Dr2LnfwxuZgxoMpReJXoWfotY=;
 b=Zz/oKJCiXGtHruJ17y7FFbMYq04IgOIbIpPuPLGGQFVFciEsz1TWOYW/ejCgIRTrw91PSEyeSOj4f4FJfgh9LROJ0AOXnomsrRCzl8pbZavo+TDChOjjKN3efdfuIVqysWzphDYzQRZi2Wz7e49H+BbNxHqv6F65PhCtjHpmW1ULUUn4y21CYFsoaGb3aa4KQ5R9kdQ53f4W5gN6eEC4qJlxPYIQKDt6pnDNQaRV1npHFLZF3xM6PraFzt2e7CZ+R5r7VA6Vo2rxIH01kdBmZDDbG9O9vjSHdxVfHaIf1Uha7snG+/TMoPbT7ioH7tiMXashG6orZTCe16Ho1t8lZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9GZgDboK9f1t6dTj9Dr2LnfwxuZgxoMpReJXoWfotY=;
 b=Oz6aoU9TbddjjiywMuzg5TZXoIxvZBp8FBcsZfwgcyDQKrgnT50ZsDYDVc8RKFzBZ1w2qAa05UgdpvLhpxTuaLY5XQcDm9mouNBX8rzBVMw3AG0pukh9TArknjvU2VzNrH23gHdCfRSN7VRUxh4R/mxTC7rjgDPw+CyqUInjo1k=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:11:15 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::d5) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:14 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:10 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 09/29] cxl/region: Use iterator to find the root port in cxl_find_root_decoder()
Date: Tue, 7 Jan 2025 15:09:55 +0100
Message-ID: <20250107141015.3367194-10-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c711214-ed84-4567-3179-08dd2f25257e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X1SHSPw1pTWMmOlwP7ZEjsvr1n6ic8hScbRCPiyj0mB/OH8jnY7vG6XDKM4m?=
 =?us-ascii?Q?s7JWCC00qdrS+sOmlpq3t6V7CuDyQ1YeVz8lK2bCEdPLT/ML7YJsEEEfC5pR?=
 =?us-ascii?Q?erX+RXUgFAnpAZdLQx1eVynQYbkgy1J9rCdH340TlkRXqjyXe+cuaqaq0bCK?=
 =?us-ascii?Q?wuZOEeAikKdd2KCOdJKAjQX48p5L5m0jn+ch0ZFNYWdzVAKpMXqO+VFHEcWq?=
 =?us-ascii?Q?kB52axnla3C4hUf60lCTirOSRNq85lidf5hP4AA7qD/61fphMBbIP2FVjOlX?=
 =?us-ascii?Q?GcR6l1D1rlMKLW60wJbXbkfHfWS9VTQT8Mek0BMdEQ1I7Pxfeds6oNkUYfje?=
 =?us-ascii?Q?nARswdG3GDWdlXTA/w01Z9hQcriLscHvhNwk6bYKZhC7K34H9KxNQnfc1Avt?=
 =?us-ascii?Q?XVJVXXm7HCE0ldj0OKGBJUOfsOv/7a7Cv2C8cr+NHk28jQVbutujs4/VdpC2?=
 =?us-ascii?Q?vHxl+Odcp61WgZDyNSppiiTCX5HGrh1EIqbH+fQo3uNGyJ22pezlMzoI0H8J?=
 =?us-ascii?Q?sZGH+bhU+KYWhLpkhPeYO7C7qMY4hvFdTU0oWLoQbg7E1wQqb4ZgC+gAsEPG?=
 =?us-ascii?Q?FcA4sY5ED8cNnkXbxwCGnTpmuwk2Hm4Uuit1XD7tV2z9Z2KunUGUPq6W0qkL?=
 =?us-ascii?Q?fg7eNjd4yvZf1IlAYV2Ep0W+7NAHPe0MnYSPnsMzQVaLY1r8I4yE7jL9Cgmc?=
 =?us-ascii?Q?dk/KI1LnggjP11q0r8+erBaIuOJbttxYus3FzCow46tJVdMSYIY4OL/hrrTm?=
 =?us-ascii?Q?OqILgDqijEh1Ga99XrP2jngY7Hx5wA1ouLiRaxFjg/gbJiyJXJRSppj3a5Gw?=
 =?us-ascii?Q?2v3LhCi2/0fxSxmK74AlAr0PYGsglhbxYfhgcUYDDws+KTmmNIJVHJ1aBjyK?=
 =?us-ascii?Q?WeQFqwNoD3IArqZI9sxJOnYtq6Q/v+3WnVf0te2B/EKWJ61Ur7ozyp8fyfAU?=
 =?us-ascii?Q?6fb8KNoEDwZV9jgQ9W7LyToZFhydY3sOiG/0woR4l4HvSuby25Ynt/TZe0AR?=
 =?us-ascii?Q?Onvn52oMy2iSZk1ePk3ab5px5LsLVrnL6yfp0AvpgDjAUTNlLJdODePb5VAx?=
 =?us-ascii?Q?6trJMvAc7wUVCU4Z0S5RJajFUPxzt7gioPFNRgbOQdHKyW5+/VZ44+2sFlwU?=
 =?us-ascii?Q?0PTjQODbiihoKP3lnFGSP6E1WVACy8EtaxgYWzy4A0e2GJzSiLVW+TTcWFwB?=
 =?us-ascii?Q?Gd++SRmqbKQbGhoAKUHGBmfkb0rKinw02udc+1WzNzjpCH+2qJ2u3OzqEQHn?=
 =?us-ascii?Q?FRTOnlW5yoiwsaKWB/XKA9SWtgPPmLabKq/AHzixYhZkDkZQawg/WXSB07zz?=
 =?us-ascii?Q?ipY3lba5KmG5n5ph05rewt7uM/i9Q2Yd4lUo0XuOhiuY+qKhnPImJ06i6CgD?=
 =?us-ascii?Q?uDH2d/W0MPdaz5TTT8IxaqzdLRyE5Pq6GQ7g5SWPHi8pd47xSm46Zl5QfdaM?=
 =?us-ascii?Q?QLJK+iSTkZkI+OoklBfyfpQ6rECPBz8ZS39dcvqfxn8DaJRGfHdO3qkh38X4?=
 =?us-ascii?Q?9VlCGFffuKChvnU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:14.4238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c711214-ed84-4567-3179-08dd2f25257e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155

The function cxl_find_root_decoder() uses find_cxl_root() to find the
root port. For the implementation of support of address translation an
iterator is needed that traverses all ports from the endpoint to the
root port.

Use the iterator in find_cxl_root() and unfold it into
cxl_find_root_decoder().

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5132c689b1f2..5750ed2796a8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3206,13 +3206,18 @@ static struct cxl_root_decoder *
 cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxled_to_port(cxled);
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct cxl_port *iter = cxled_to_port(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct device *cxlrd_dev;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
+	while (iter && !is_cxl_root(iter))
+		iter = to_cxl_port(iter->dev.parent);
+
+	if (!iter)
+		return NULL;
+
+	cxlrd_dev = device_find_child(&iter->dev, hpa,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
-- 
2.39.5

