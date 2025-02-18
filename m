Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69526988B;
	Tue, 18 Feb 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885094; cv=fail; b=uHpd8L2RodP+b+rhqi53SFJuz8cOL8zYnjX6pVfJO0asSyW98ZWpUa4SUJvC1YvPuaP2+Hkz0G1+hoBAHJ7s4w0q6Gg3MCNaoJhQMLUkZc48To7hoQ6BkbmhSNvAEu4Z/di++TNPHMOhg2UE9kjXTv+MAxMlD5lVCyr4JJIaCWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885094; c=relaxed/simple;
	bh=GFu7IoX0gez4VTAj76InlsNbJsbgqe63BpKWelks1tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/H/6xOfIc67daHNLeRL35vZFA2CHuOPKmPpeJCKatbl5gOWC4/nZj65LDdapikwQ4EUPdTiGk2JDs7uHabNphh27hXWJ4F4HvRNIavqXclZzNcxMyCpbFCWLf81Z6TKrpFlOkFKHw3d9hea+VOF01v1fTpySqp/AkW+7XIbm7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TH1jD6TU; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TH1jD6TU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Luq8U9lpXuOh0uhPlFO4PP/1xNzN9KMf9cX9NSPpV+8lcsCVbyMPn6CZA//SfZofJ34tDpHHkq0aPtHL+iS8a5dowtPVLBDzsKdrFeSVhyyPAjKXdDx0QzTBqTqm8XCZxPSf4wM2NzY1BjpGWEQhWh7W10wTxHoiDyTl/pTuIjiwkO6gLmCisR8oNiPymEKA5BlQ12h/2vFDnKHKyQtmu7ub0q2xnQe4HVR8DFbICQeVXV+JG4ikqadOP2gK53Cqd8XDyn284MZkfo/si82MnYufC/P4zdf51G0ATGt+BgF8k1I9dwNr+OLaEIgMFGzorElm/bmPl0HWPc/PM+ryvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlpGrIz9TEfHTLdX5N8gI2kBJe0+9t5v7HEzq/wxVAs=;
 b=ek1u03vpS+y0qgndtITdQlnbG/RUkqB7PsUutSVSiove2sNd1T/3ZuL8/A39UKtOdY0JbGEeIFBtAGgxDRJelRRZJup+o2b3AotJ2bPsZa2O/Gzpe8cshmbiwsTRwHy8Ygh7IxF43qpYR8ZoHRvnWLnyZs5P+z40O2p2CZjacFTy1VOYA3VCPrvmNZXv8CwSNZP7UgfdkWhBRbebYHNDvWf+pONPchGUR9oQdhywxmwawXgAucKzF4R90Ht3Y3+tfujW8H9rjvL3QMhBKfgBBiqK0QWAE7TzBYIWHdLPR9VW3WR4hi9/lN8e91eUSrIHFnk4fH+OsQIC4tIrN6BUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlpGrIz9TEfHTLdX5N8gI2kBJe0+9t5v7HEzq/wxVAs=;
 b=TH1jD6TUEMUSqV5K5hlGDebO7vCV8ub8MAJioEOgpa6YFSzVRaqmS9fFggdvJAjnkWxL3CiSWBiNM8/FheSz+W75VVkbcJquwHNJCQdFIYvA+pbaCId1RqkQqVBYZHZwfOrSFUUuHs32RmHEEnIHn5M9yAkOSbwWFQl2UVFHDW0=
Received: from MN2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:208:15e::33)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:24:49 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::90) by MN2PR17CA0020.outlook.office365.com
 (2603:10b6:208:15e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Tue,
 18 Feb 2025 13:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:24:49 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:46 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 05/15] cxl/region: Calculate and store the SPA range of an endpoint
Date: Tue, 18 Feb 2025 14:23:46 +0100
Message-ID: <20250218132356.1809075-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: ea81596a-7be8-4c7b-0b52-08dd501f9f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iz78sn5QWnLjJT3SQBInOUfWTV7lSRJnWW42AshzB9leO0yw08z4Wu5tXcet?=
 =?us-ascii?Q?lKKkB2Ylk4eBBsdO4fS3/m1pWbEqw7B4Cl6M9E8KHpNABaOU62X2kmluUpBD?=
 =?us-ascii?Q?yXWu1Bhv9FaSl1Ypq0Cx+5todnms+ClPVoXusu/kkVy2i2U1cxBMJHfzZnme?=
 =?us-ascii?Q?d+aSKpSHY/2MPzOwgf+NGnHRKXGiIVGIp2Bd3L7Ywz/z3dhJ0mf/aP9XqNPu?=
 =?us-ascii?Q?Vp8UJiWNGxj8Y34S6PWAQYacsUkLsUrjkLgAEU8/tg7BvQhjEMx6spOhbAoa?=
 =?us-ascii?Q?w9OGrb4R9dGqIQh0XtnLcWUO3+uw9XteSGdDqcEY8+R0TmOifxyIb8FeuPGm?=
 =?us-ascii?Q?sZZFWNgVVznGQmzZKkc4lETzCoeeHcuyhEB2ASLyTz1zSGbQ3qBvRYyTKzHG?=
 =?us-ascii?Q?cn4L0FjNTN7qTY4uH2BNYfKPM8tgMe6XeUirdRsjqHpJ9kHpCxVLFa3ZusBv?=
 =?us-ascii?Q?862D32K0oVhKlK3AzQgoPTFvuhUNZ3Yl+4Tqu7twl98tV8fsjhb8/ntg5ObQ?=
 =?us-ascii?Q?oHDDckMBKCh9yQQI5krMAjj4ha1wC+9WOPE5JK7XWrqCkJdm5tys5Jim3xVB?=
 =?us-ascii?Q?FgQpj6N1YdALKT34K/M3cuqnMNwgWvSM29ZpNMoHlBKikIjRoSEobiWWk+l3?=
 =?us-ascii?Q?P9Uja6yaiuBn/72O1ZqQgJ/bGGyJZmbpgkzghIt3FriOXZ+0bDzq2rbkv21N?=
 =?us-ascii?Q?QhMhO7ZHOoFZgKiazYOCBjbyumw+FPWI8D/KqneeRZZdc6OApCIj289jBt7U?=
 =?us-ascii?Q?XQtEfE41LojxJd9/Z2q54vlPbpmJD83w12nqyY2HIQ9spubMvwoV9qQ4/aLD?=
 =?us-ascii?Q?hx2CZLL7B+cKpu9jYa7gk9u6u0i2lqiN9q0ysjoYzGDmp7WLL/VnWysuIYMw?=
 =?us-ascii?Q?Zn1g8GIIeMdxpyfYKFnlZUQc95JgjVMPQL/0f/PIxRSXaq1bwNzcoABk+/FF?=
 =?us-ascii?Q?aLAceDz2mhQWTEMymSF8oi4Hv5bzKGDSB+NpWG+gOkDgobCJvVlKjK6zKxl9?=
 =?us-ascii?Q?g1bZscQgMBQo3/yE+6sbEo/umIxrsATz05t+GEMqj+6IUsbu5YZ4KfoQCMiw?=
 =?us-ascii?Q?o0tHnAVoiA9JgTM5XogtJp5D2c1U81oAkQusy4rC40T7kxlYWdaQmMzJrHxb?=
 =?us-ascii?Q?a/k4+35XRsuRWgvbXi7uF7isFkzenW6BPafaIfHhbBhJYS38jn++3l7juDbY?=
 =?us-ascii?Q?3W5ggsheYPzUB9Bim1LKdSPBf9/MQ74M8DfiXDlBh9vTvKwyA9NabCMldU2W?=
 =?us-ascii?Q?u2YB0mrrjZ20QAjncUCqGrohNd9A3y/ciub6Opc4GOr2+pNSmvxzwz3Kni06?=
 =?us-ascii?Q?AJX9RrtlN2OKf90qqmF73UjMn59Y4LvUPmmOHklLovelIKsZMKGvtdu4sEpy?=
 =?us-ascii?Q?b+jcsNsTvhQes+mi7uewDny5+c50clltGPlCwE70v9PiNy1GrYmEf8po7JXB?=
 =?us-ascii?Q?7itihgPTU/2Febom6XZXtY4Xd/JwtU0lSSuAIAx7vnlYm1Gmtx242CysvHgX?=
 =?us-ascii?Q?D+hkkUWFcBD7S08=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:24:49.8740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea81596a-7be8-4c7b-0b52-08dd501f9f0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437

To find the correct region and root port of an endpoint of a system
needing address translation, the endpoint's HPA range must be
translated to each of the parent port address ranges up to the root
decoder.

Calculate the SPA range using the newly introduced callback function
port->to_hpa() that translates the decoder's HPA range to its parent
port's HPA range of the next outer memory domain. Introduce the helper
function cxl_port_calc_hpa() for this to calculate address ranges
using the low-level port->to_hpa() callbacks. Determine the root port
SPA range by iterating all the ports up to the root. Store the
endpoint's SPA range for later use.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++++++++++-------
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6f106bfa115f..d898c9f51113 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -832,6 +832,44 @@ static int match_free_decoder(struct device *dev, const void *data)
 	return 1;
 }
 
+static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
+			     struct range *hpa_range)
+{
+	struct range hpa = *hpa_range;
+	u64 len = range_len(&hpa);
+
+	if (!port->to_hpa)
+		return 0;
+
+	/* Translate HPA to the next upper domain. */
+	hpa.start = port->to_hpa(cxld, hpa.start);
+	hpa.end = port->to_hpa(cxld, hpa.end);
+
+	if (hpa.start == ULLONG_MAX || hpa.end == ULLONG_MAX) {
+		dev_warn(&port->dev,
+			"CXL address translation: HPA range invalid: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa.start, hpa.end, hpa_range->start,
+			hpa_range->end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	if (range_len(&hpa) != len * cxld->interleave_ways) {
+		dev_warn(&port->dev,
+			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa.start, hpa.end, hpa_range->start,
+			hpa_range->end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	if (hpa.start == hpa_range->start && hpa.end == hpa_range->end)
+		return 0;
+
+	*hpa_range = hpa;
+
+	/* Return 1 if modified. */
+	return 1;
+}
+
 static int match_auto_decoder(struct device *dev, const void *data)
 {
 	const struct cxl_region_params *p = data;
@@ -1882,6 +1920,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		.hpa_range = &cxled->cxld.hpa_range,
 	};
 
+	/*
+	 * Address translation is only supported for auto-discovery of
+	 * decoders. There is no need to support address translation
+	 * here. That is, do not recalculate ctx.hpa_range here.
+	 */
 	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
 	     iter = parent_port_of(iter))
 		pos = cxl_port_calc_interleave(iter, &ctx);
@@ -3262,7 +3305,8 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *iter = cxled_to_port(cxled);
-	struct cxl_decoder *root, *cxld = &cxled->cxld;
+	struct cxl_port *parent = parent_port_of(iter);
+	struct cxl_decoder *cxld = &cxled->cxld;
 	struct range hpa = cxld->hpa_range;
 	struct cxl_interleave_context ctx;
 	int rc;
@@ -3271,25 +3315,33 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 		.hpa_range = &hpa,
 	};
 
-	while (iter && !is_cxl_root(iter)) {
+	if (!iter || !parent)
+		return -ENXIO;
+
+	while (iter && parent) {
+		/* Translate HPA to the next upper memory domain. */
+		rc = cxl_port_calc_hpa(parent, cxld, &hpa);
+		if (rc < 0)
+			return rc;
+
 		/* Convert interleave settings to next port upstream. */
 		rc = cxl_port_calc_interleave(iter, &ctx);
 		if (rc < 0)
 			return rc;
 
-		iter = parent_port_of(iter);
-	}
+		iter = parent;
+		parent = parent_port_of(iter);
 
-	if (!iter)
-		return -ENXIO;
+		if (!parent || parent->to_hpa)
+			cxld = cxl_port_find_switch_decoder(iter, &hpa);
 
-	root = cxl_port_find_switch_decoder(iter, hpa);
-	if (!root) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
-		return -ENXIO;
+		if (!cxld) {
+			dev_err(cxlmd->dev.parent,
+				"%s:%s no CXL window for range %#llx:%#llx\n",
+				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+				hpa.start, hpa.end);
+			return -ENXIO;
+		}
 	}
 
 	dev_dbg(cxld->dev.parent,
@@ -3297,7 +3349,8 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
 		hpa.start, hpa.end, ctx.pos);
 
-	cxled->cxlrd = to_cxl_root_decoder(&root->dev);
+	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
+	cxled->spa_range = hpa;
 	cxled->pos = ctx.pos;
 
 	return 0;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 17496784f021..7303aec1c31c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -394,6 +394,7 @@ struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct cxl_root_decoder *cxlrd;
 	struct resource *dpa_res;
+	struct range spa_range;
 	resource_size_t skip;
 	enum cxl_decoder_state state;
 	int part;
-- 
2.39.5

