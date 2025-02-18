Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5C269AFA;
	Tue, 18 Feb 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885119; cv=fail; b=Tj4MXNaJ3pgfyZA2w/RwwfybckiWYKmwVA9fcOZTQ97/qPQmtMP1d3ExeiUJm+BA5GrfCWBhjdFFr2BTaDBHOHWnO2J6c4hbZWj88Bz56Kh3PZu54/avfT3kAuMPVbOnxPM8XPBR9rsmiociL/kU3YGT0/kod6gWYMgphJ5rD0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885119; c=relaxed/simple;
	bh=aU/c9k0N5UFcDvOICAk1rD1tXKIvrqfbBGl4+gPhnAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EshOcRrj+TcgLdIl8bjlHLU7YgmLbfbD4MYRp4nj+sVgECraTEFqKz0PRB7GeCmyzU5lrgNidom4VGw6pBz3WMp1Vr1LRRnIAm7OStqsfc0vpUgP9gjBjswjaAV5pJiRseML97EcnDlMXG27H5xLIbaLAADJq7ErZQrCcJkxVHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rQxg8vBt; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rQxg8vBt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkvZE4HSNrGLlx1QDuwxWPDy94akrgv8gnNYHtaMpbz9VGEl7m0dc3+xEc1H3uGehkHMWUmYZo5sQsMCVm+42JTP/EE1sKAyaU7JzhP+645bWFTkMYF1yZgL5kKegY89VOKZ2M324hcGGdn2skgXueQqbQGz5GDruESjpCY2Epv//XFNUh1/r53XbI1Acv7m4PCo3jKA8ke7p7OaZGx4YtEPvqUqxsWhYH4+pUp9M9MSA/LSiWHCK6NCP6JjhX135Dp3ieTIWrKAVX06Yr+xwotpVR0w2Zis5vVV0JJnnYo/7ttkGOcz73PQjBZFf90eVckCC7XSc7dMAzVEtwkv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/znQZvuXVmyTN6MVnXKDkzuuWCouvPrWHmKx67mR3qw=;
 b=ejGZSlY0PBQtkf2kkNRc4k+w49VPyvknQ9sEsxqPk8bhYUllNgGiwnRvnefXjf0IwHNrEkPp1yOX638ow5AbL+rTT4WzRTrrpJ41YOZi2aKuHoTvBbRzyLtZhjk6dKH2wNvH7LILj6sj9WbAZHtmrwNFR5jCWp/CTd2bf6Y8D3gPVvmb+81/YeW2e7LB+8QkL761TJlPPH5dcWMhlSO2gfNDz8QBpfMEpt0hY+1n66Fq1gk1m0fkyKp/Z7bc2Nle+lDN8dQIniFGxvd4peRJuMS2qTVobBVL4CQeNdeQ05PF/5j+uKj8GRQfpYJp+pm/+4gR+SaKL4Mhh+U5iaVsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/znQZvuXVmyTN6MVnXKDkzuuWCouvPrWHmKx67mR3qw=;
 b=rQxg8vBt5uOg2zxAAXRaLnw3cJTbpcHWwV9qxaBOS5jEEeGx8qMEQNAYglXewS7uDP0H1VpIrKhxPTcguoT3R3LGknt90paodF44IsZnQNw74PHndiInJ1gVJ6mpAIdJ4b1URwvULHemjviFrayKtRCHTC65G6xbkDQ/fGwuQ/c=
Received: from MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:25:15 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::fb) by MN2PR05CA0053.outlook.office365.com
 (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.13 via Frontend Transport; Tue,
 18 Feb 2025 13:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:25:15 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:25:12 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 12/15] cxl/region: Lock decoders that need address translation
Date: Tue, 18 Feb 2025 14:23:53 +0100
Message-ID: <20250218132356.1809075-13-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab2aa52-e6fe-454b-d465-08dd501fae63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XNsWv3mDl6c4hnH803oz6fNguMMwQfcwepBcNZvB7tr9h48vD0lTOEmzWK63?=
 =?us-ascii?Q?any8bI9ur8CV8wTmamoQRLZthKiz/6/b5rfmo7/tQ7GEaC21z/1BMCIb37ci?=
 =?us-ascii?Q?IBfx4EaVG5ji+gRk8uYMs/UoLTDNKRHqBJqWIDV3GtqF5BrtK6cZPSpOGXAA?=
 =?us-ascii?Q?OnGq+kz6QOnhlMPbGNnKXHx+6gw35b1LkrLLaRtr1BB4GjIHSWwPbX17Wa5J?=
 =?us-ascii?Q?TDKqqQty0zIW743GySPjCG+YqpOSZ+CiVPJQgrZ/yLeNoLOqgnhVUCPFTmoC?=
 =?us-ascii?Q?xFZZzxSU2C2fc4TrYNf9ZFxkDW92dZTvyQMxznktqL05W53jsUGYS1474V8h?=
 =?us-ascii?Q?JK1Bya1B1nnKZh2zZ8jiKYuBIodAYPgig2baqhgMX/gqbMbpUMx1cLW4l7ZP?=
 =?us-ascii?Q?NGDr/++6Fpb18r0+hGwf0djg5ITAc0LDyBWsWt9cYqy4cp+BOBew4nHN4Q6J?=
 =?us-ascii?Q?9K8LTjbQpcVfLpeEcV+8SgmV532+w8hWYI2r74PkHFkoPbKcLZDLNKSMFTq2?=
 =?us-ascii?Q?Zo2fk3xqKHz1IYDQWlGW1xwM6xQf/u9Um42QntbljYM7LESV4LOtvZ/IGSJ4?=
 =?us-ascii?Q?TR0FzUJQt9tNm5dXcBboumzWWzW2An/9L6fhAmLl6rav+x1Adj+fkqWn7y/9?=
 =?us-ascii?Q?UW2BpRe5Dy/xkmBYzr9bwbU/ToYqLusamw1Jie/8WKdj4uyBYObB6o2pRFvb?=
 =?us-ascii?Q?9s/jAbIPXv+K8Ywksg1Zj/ycivWOf3VGridhsLyispkppMEf95ZwNyS0ACqN?=
 =?us-ascii?Q?QYncYADKSY7pY7IDdokYNRZDn4TDbBl5lX4RBdlw9Hoc6an7sJ20eSMxtIrr?=
 =?us-ascii?Q?WHhJZAhUZbrXJwLpFAgx+UmdOV5P12EDV8Lch2vublE+Zuhrg0aey3v8pJkb?=
 =?us-ascii?Q?tyx3ouW4BMhRL+EG0hpy+T3E4ZKxFbEJ+DrPsAcrN558U0cQd/vO4M5qec1Q?=
 =?us-ascii?Q?+lNqUqYX5FuU5/QcJp0V2AaDmGOBsiTAEtKMVkDvF+b9kVb9H1s6L6P0Mm1o?=
 =?us-ascii?Q?watQRoc+CP9ubL1ScrCHzMPUuebQSmEW/pCguDBpLPHVDYq0n8Nd1Ak6Nyoq?=
 =?us-ascii?Q?m2fBJZnEw+TTronlKZPSx7kiizoHvmidWC0PsBe0iA10/B0D34gZDeYzxIwi?=
 =?us-ascii?Q?Fsrh4sB7rkftk1yp9iYvQWwkSr0vdXZTkIa+z1zwNSJb14YInv26L7co5VqH?=
 =?us-ascii?Q?NhkFnTfd8zelBLlgYs6lMtA/pwQflOEpUs63eJ82qBWOY+sN1rB5mKK62VOp?=
 =?us-ascii?Q?sCVu4PM97MeUItnZNanqS63ooN1e6sLWZ5/QG6one+FciT9G0k1LKkpzBT88?=
 =?us-ascii?Q?aVTvgkc1vE93dkwFWTvhoNzPs066jp8U3Z6OwyF90q98POXFyFrk2i+NEHeu?=
 =?us-ascii?Q?X0NofjrKTDgyY17yS/N62hn5CI6sxj5iG8nwsUwHsLbp8Bmxg0VT+S496i4Y?=
 =?us-ascii?Q?A8hF90chNlCS/aFdQA9UGHjHKN2eI+4Q36+KWBZFgf5n6kChCXrLxNBS2Ksk?=
 =?us-ascii?Q?ebuVAUe8qCCkj+o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:25:15.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab2aa52-e6fe-454b-d465-08dd501fae63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F

There is only support to translate from the endpoint to its parent
port, but not in the opposite direction from the parent to the
endpoint. Thus, the endpoint address range cannot be determined and
setup manually. If the parent implements the ->to_hpa() callback and
needs address translation, forbid reprogramming of the decoders and
lock them.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2ca24565757a..dab059ee26ef 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3410,6 +3410,17 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 		if (rc < 0)
 			return rc;
 
+		/*
+		 * There is only support to translate from the endpoint to its
+		 * parent port, but not in the opposite direction from the
+		 * parent to the endpoint. Thus, the endpoint address range
+		 * cannot be determined and setup manually. If the address range
+		 * was translated and modified, forbid reprogramming of the
+		 * decoders and lock them.
+		 */
+		if (rc)
+			cxld->flags |= CXL_DECODER_F_LOCK;
+
 		/* Convert interleave settings to next port upstream. */
 		rc = cxl_port_calc_interleave(iter, &ctx);
 		if (rc < 0)
-- 
2.39.5

