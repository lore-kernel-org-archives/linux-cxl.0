Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D786269D04;
	Tue, 18 Feb 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885099; cv=fail; b=IhZICNWwUY2INQo+BMLN64YK3YEYJvrJ2lFR9MwJYJ9ySYMDF9Syn+LQQjeSVm4NtHUYLS9PP4H7cH6S+XGZqR/8SBjeBmp/3vUHbpt7j7KeTpKjQ234H/YO/F3Y7h7OKLuOZ3QrdkdGQWACpwouA4rTkuRIgwUAo3WN/llsxgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885099; c=relaxed/simple;
	bh=Bs4sg2GuTZ/nKIFS5aMvA4Qmw36UltQZndXuNugFFxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ5knSRhLJ9TUfmuWTTV210T8Th4lm5rYpESXdKHlhn9xAHJakQpEX6Y6qwPaKOy8P4UtS7idFDs5xviPaztMIjmz8xuA2QI7TPDR/0zwDF5l7iXigLwuATw0yE2P4uLgIZGr/sg9dSFiSbsqdc1XJqwiX3QSpk0IlPJIGZcPVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n+o9/oS6; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n+o9/oS6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hL/wI9VsrKk4XyfkMRtNnjmekRgm9gzK2r/2UqpzZsWxQxi9k4C1D4aGfbKelszF9fncQbcL4Y8T4W32Zc0JnIwmYwKoH6fnxv37jftzsHGfU3MCDfcDHIz+/6I4VnUVB/rrDfwwzswF88Qsq+76LpqYvcacz345WKD77+TJXMyomgJZoc2Mhe0s3OziKUeQh+KIqF6LXMoX0Iy1bWBRAjGl/9QVmH5abXbc4nnIYX3SZD+LangLTTFNIFDHNsSq3XRx7dSGOr+RB7/EVzzEfaVEro65cOQWrV+XTQuf6wBAQZ2bPx3ahcI2VQWDqUQiC8RZOtZ2Ul9qr37hc8SGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBrWz29Twm0NeXpepOnixx8PshnL9DqCRgP6Hz9v2Ok=;
 b=NwWnTTbrLRQVtOd3Ici9y10EtRYoeUmUTK0VXK8mJOIIESwtkpmL8BbSfMkWtiHtNTP7a5CWlMuBVOMDLSjU/iRicmGHXcpRduAiPhpqf9ToVm0R6XQt5RtnU04WBlTRQ7upuvJlx8F5PHEaoPjJBUD8OwEOVknM9MeA/ZWQAOqoPr8HMX8GQjbVLCTFfGlXzW72kunkdgreJQVw1l7AoFU8PSjBr3kLOMeqxFh6+J+AFvrP1Ahy2+GbgehFlM+sIdIxgDmvoqiMXvduhkAVANJB9y5v3nbbJbCUz3TX/HebczbvH66FSPZwX9tAppkSoAxdXY0SUltdzTH0j2CT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBrWz29Twm0NeXpepOnixx8PshnL9DqCRgP6Hz9v2Ok=;
 b=n+o9/oS68iaM2Px8gktByfkisB0NGaQv8g+7L4kza/TKoiAoGSI1FoBewVRA8NXkCN+ru8laMUs5aVIOhMeVdDDN81f/Bj9xCbg4Qp/s4esOXLUvb7U4bxW72zWT9HqEOm5zDCoEnXiZGJktYCaAUYph9ML3fiIH2x0o2cvwgZY=
Received: from BN1PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:e1::6)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 13:24:54 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::d1) by BN1PR12CA0001.outlook.office365.com
 (2603:10b6:408:e1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 13:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:24:53 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:50 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 06/15] cxl/region: Use endpoint's HPA range to find the port's decoder
Date: Tue, 18 Feb 2025 14:23:47 +0100
Message-ID: <20250218132356.1809075-7-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b23a6e4-985f-490b-0144-08dd501fa128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emNtCuR62L0ZG1UxHpDuYfmKJESTqxEFE8pBEINir6pQZxzV6u+sbx2gYOqi?=
 =?us-ascii?Q?/BWEcWxgdUY0M1L1MUbvhVKLS7SturrY3TYuaRbZ6eoQhODyslxAbCzpZ3eY?=
 =?us-ascii?Q?FE+lyZg0MJPx9T5nVGICZZ/58YkHH+bqkPbGk59d3sTcyVd42xHqMOkKcbSv?=
 =?us-ascii?Q?fbOV3JPsdpPJ7GUhJxGg5Z3ESS2cGLPV40/hyQd4ie54Agohroou3fhPZbD+?=
 =?us-ascii?Q?auatYl1CF2zIusyCysqQnTRGeCUvhlmn33W+QP8a9HLmMQn4OjCdlguJ8ZNk?=
 =?us-ascii?Q?qETSDeN6hS7vAq9zUn/KwS2QZ7M2QLXR1dzAYBK7Z9OVBYsdu+zeMQbWLvnK?=
 =?us-ascii?Q?VP4OjQJ3gXIXhRHTMEeAmHHmaZ4H+5W7sWKrF2r3XAec9RHPUXyDyLA2rBK4?=
 =?us-ascii?Q?FtQn4jWU5xNjkqafKx7Px8CogcwNh+AT9sCJvMywDZqneZ9bgrunnT6cg0yo?=
 =?us-ascii?Q?RxGEhzcXikthrHs4WYiq3nROcyHL+TPPzE3g4NnT8ideebD4atg4pp2YtxwF?=
 =?us-ascii?Q?WKkHWdZCQdyaxdopn+O2yQAXbZ5U4XDnDuKG3zOKpOhTmqeVcKyigJ5iPrMO?=
 =?us-ascii?Q?Hyi4dS3pp7AX6uDukidur7hdxSYMj66xFoNHHlaELOCntTmpZm2ULjSfFf9h?=
 =?us-ascii?Q?j9xF1QtvtoxmlAGeSQFlDkt2euMQxPlsULDZ9q1ueEE5NaG2w/veNoObFFSc?=
 =?us-ascii?Q?v9zDrluoBMzpQM6aWES5GUjNWDlReGqYufJOS42QeaCCXQrCRgg97wzPK8Oj?=
 =?us-ascii?Q?4V6vd26MzxZgxp8kSM3wC6RX4TenyUP3/hlnNW80o2IXs7E6zpy8fOPOtgn6?=
 =?us-ascii?Q?VSSX+YPqx+IYQuYh0YT2x+hQ8EKvBFasnsrWbSIFPwBtsEp8hs8JQkHZuxHe?=
 =?us-ascii?Q?klDUJZMtoyctEqq3OHfXMarB/GQQvziCytzsWWTHjhA5B5MfWyK3q3uShTYw?=
 =?us-ascii?Q?sr33gQHTXhiuvt09ZssBYduvgdU2vxayb479qR22tFEksF+JXts2fFIWEdnm?=
 =?us-ascii?Q?yRYjm7afgjK8Wl7aKa+mAvX5w/fmY3Q4ls6L0Lb/+bTydqQ6ENVP7FkpH/LX?=
 =?us-ascii?Q?3X1aS+cW7E1cG959q8+xj/iKLGsynD3ubK2y8M/VmGlIwTFEpf7ktWQ/6sI9?=
 =?us-ascii?Q?tuNz6FVqAusTS9EkJdU/l/rnqQwXw6oEbvaI3HV9E/mgHgGHlvZb7X7zdt+6?=
 =?us-ascii?Q?XxC9dF9fow8IzXhC0RhRJP7npnPRlthwD01635elu6rS1UIX34FlJm0PFJ9i?=
 =?us-ascii?Q?c2l3QjXvWmQKoluQVuFiY4zb5/B/Anw1uaC8RHO9Q5YkODJo19rU8DDH89z7?=
 =?us-ascii?Q?GgJ4+ATq/kxyaMiuvweZx6dvNKLvrCj7wsH74dmENOn2+lplyCgJCvtdoCoq?=
 =?us-ascii?Q?f0f3A3WWApfe0gMO0wZJzznHlZCeZyBcGeC1kd+j4FxWO/bOo4Ysthmf/XRF?=
 =?us-ascii?Q?I4f2fsIon/p78Ag/3rzwX+o1mB+vc6tsdZ1Yodsi7TgWsg6BkTfeULDxGoKM?=
 =?us-ascii?Q?mY98GCThRHW/1p0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:24:53.4127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b23a6e4-985f-490b-0144-08dd501fa128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052

For the implementation of address translation it might not be possible
to determine the root decoder in the early enumeration state since the
SPA range is still unknown. Instead, the endpoint's HPA range is known
and from there the topology can be traversed up to the root port while
the memory range is adjusted from one memory domain to the next up to
the root port.

In a first step, use endpoint's HPA range to find the port's decoder.
Without address translation HPA == SPA, so the endpoint's HPA range
can be used since it is the same as the root decoder's.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d898c9f51113..5048511f9de5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -872,9 +872,8 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
 
 static int match_auto_decoder(struct device *dev, const void *data)
 {
-	const struct cxl_region_params *p = data;
+	const struct range *r, *hpa = data;
 	struct cxl_decoder *cxld;
-	struct range *r;
 
 	if (!is_switch_decoder(dev))
 		return 0;
@@ -882,7 +881,7 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	cxld = to_cxl_decoder(dev);
 	r = &cxld->hpa_range;
 
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
+	if (hpa && hpa->start == r->start && hpa->end == r->end)
 		return 1;
 
 	return 0;
@@ -906,7 +905,7 @@ cxl_find_decoder_early(struct cxl_port *port,
 		return &cxled->cxld;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
-		dev = device_find_child(&port->dev, &cxlr->params,
+		dev = device_find_child(&port->dev, &cxled->cxld.hpa_range,
 					match_auto_decoder);
 	else
 		dev = device_find_child(&port->dev, NULL, match_free_decoder);
-- 
2.39.5

