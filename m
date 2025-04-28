Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408320E706;
	Mon, 28 Apr 2025 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876668; cv=fail; b=ZdHXVhThGlAro/6Ri2MF7uDtCDEu148Eyg07/m/llH6Dzrfsl4UKuKcVYv0Cu4VQtLBs5UP2f5GNiPHXT08+rPjMpmtPpa21J6sWRZ4zyYfSCiZ8/7sv+acpiEHoZkedYc+5DD6mgIr39o+iUg46WqWvdLuOv4xmlJysv9ldDKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876668; c=relaxed/simple;
	bh=MADQ+/YK7VPQijeSrfO8jcgaCOxsqTFp1CY+7cibaZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+yeHBlO2VMUE5emd55toRw8MF0+camVQfA/rqGQ/NCFzwCskwTp4tzHssJRezJ8jjA+8VXuSpmyjclU48E1067xvvCbHWLcfNPaUPMbaNF+0qNGs75RH6yvSMvDV9rO4UkIYxRbxob1d4f57vXr/Q3t8sBJ3nVra1wfTnaG8nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uati5CWi; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uati5CWi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1OQWlW9GcRXqu4Xz2hWunHRHNmjuMGTY2maxh2Zc2+NDiUHwORZYy5p367V+5AiQmRAz2p4DueQC8A+23loWPhBM60DpQY4tQQmiRII8RyUB13YHkjUxXKr8TPkC/KZ3eglKcdPQyxM9nsKxz7YFYkB3pKWeFr3FYP7gPKnC+3PTgcCwyxcY74Vo9e/bspkJDvGtPFmD/Qo/rzWEaN+26lfCsoXiBj7PAWcdxU2j58Q/ZYoDf/EI4YXrXNt4w0odeV9M/IgQLWVSP5nT6Cc/xRIsXclyyAKqzFDKm8Bxg6xMdnmzi+PMGroMkKhbsYsBnlkvVIIsFQNhW0kFrZwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9JPq43OINXqU5rnfDBVFG1eWXNONRDTDy0RDFSMUSQ=;
 b=ravuwxwjP2dIKjgTdDmdjUvW8OZ9LzJayXWqhXSF5rRgr+/mm8/jamsMfmZkQKkYDwHOfTxzjBL5nkjoxv0ayj/bl5HPum306FOJnzSlj8XGDW3PI3EYqs2MlEMqhTGXkQes33LcKRbuQLP/SuodaRbZaiQpW7qROjxzTN1ZOwa55iFAKTDafCwxfYPPK/8nvUu/IwGixEWJm+sonXoeYp3Bi1KuyF+m1YOS29RGPH8y2qmWIqz8HPvwUku0VRZg93Ml6ySHqN6UV8ftnEjAGibkJhtaGFL/3a/RtEhgCZGMG7SC/MuORoxFyn4trHRDlS0eJK9XEBjfbyiMGMdztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9JPq43OINXqU5rnfDBVFG1eWXNONRDTDy0RDFSMUSQ=;
 b=Uati5CWiivtkp2YyXmibE/2+ZgJRFQ49zmBLM20c4l7QrFtDofgPWeK2VDLCHl85JjV6XBet/CL0fmWR22Uz3++L8MvBcw/ev+s1UlTb0eSX0kUwWSpNqnS3HTV1tUzkhWoAeUZzNtO3PMKlQ1OmTBe/2NfgM3k3jAAp4RBYrv8=
Received: from MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::33)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:44:22 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::f3) by MW4P220CA0028.outlook.office365.com
 (2603:10b6:303:115::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 21:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:44:22 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:44:13 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 10/14] cxl/region: Factor out code to find a root decoder's region
Date: Mon, 28 Apr 2025 23:43:13 +0200
Message-ID: <20250428214318.1682212-11-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2b64c3-76f9-4fa1-6aea-08dd869dd694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1EymnYHwFnn38elVfVtq3/GbRU0A8JPfMBQoeNfN4x2lHejybUtbnLkR32R?=
 =?us-ascii?Q?nCSUYpx4Phy1KkPjLKi/1dvA1HSLAP2B9DVsopPEGthHL/KujY/BZ8m8fyFG?=
 =?us-ascii?Q?j6btx6a8m1kIVL0HzCyY1BsDJWJxZLh5N5Mq2UU+Lhgm2cTh1Uai0fqSflEw?=
 =?us-ascii?Q?N3BfjJ9LTks1ouaNVcgz0BP6KNzKMLovonK4WXT7p0fptJ/iTHh2HKN3ZBZe?=
 =?us-ascii?Q?08rM72YuO7a/ygdyYzKF9S/yuyh8+6StE52tv2L6O989zsro6bBtkkpzezha?=
 =?us-ascii?Q?RldiYwINCWy7t+zr0DPqjuU39ghWwSCwy5l1kU2fThKYvKtNmkL6qiPD0lEd?=
 =?us-ascii?Q?5cZhlA2azkY4M822m3M+xh3hV9XQ83SoiZRBn8z6WbSKoOEe1P0THAOaRQND?=
 =?us-ascii?Q?jNSQ+agLmOGl4jcBnQHg2vqpvG82JV5GEnGhNbND/m7oHBdt6M/TXb1DTmkj?=
 =?us-ascii?Q?57cQg+ioF85H0MuINbaAgTla0tz79Z0aedGjg7Jx4J+3ydKyO/vatFLdR6MG?=
 =?us-ascii?Q?xxLrjB0H+10U44xhoI5/XGsKlsM3/l2LW168Ni14kr38jKlov9IbKlNc3enP?=
 =?us-ascii?Q?466LQTmh3GYwsElUxjWvDpo9IhaUR8qeRrVI3dxaewrO88OGYWP8ocbM58pn?=
 =?us-ascii?Q?AlC2pr+ea75UcTXvXYU7soyr5flhrJ6U6Z+/LBOdD6mxIyveX8Jrjn6gma9c?=
 =?us-ascii?Q?RyDzHwzFa+KDyBkAqWUW5RUw1tI43uXSIRxEGxGr/3NVRFtcMKT2t4r4VzLh?=
 =?us-ascii?Q?1TkfDpWRYxtunyzZ7AI8k/VCpy3Xj9qRy58dgn71Pz5sgAJZahLnKm9dbUcN?=
 =?us-ascii?Q?v52RvqRU9c9MUSAOwZTqweZQSIR3WdPJd6uwTkoID5SOy3jgE1n+oJ+OAwWf?=
 =?us-ascii?Q?jwSa/GQPcy4lQj2azU4rKfi04qQFXcT7wqs1YRCBiWpIIxK8mCRO+0bm64Va?=
 =?us-ascii?Q?foRqAUTd370VQJtC7URETrQmYunLMJcQHnPP0/MtCbIidGBw3p8VeY92cUBn?=
 =?us-ascii?Q?4KO9fsmZ26v9+WCFPFruTH+5+TNgjTuLPmxeKJLd6zkF6mDjRk6svtS8JZD2?=
 =?us-ascii?Q?2bUVRvM6ip3q9D/suerDA6aymSg53PV9h329+vVsWPIPq+Hi6D2fYVnZni6s?=
 =?us-ascii?Q?9CPpzu6X4IUdpRxXITMFNG7RFYWy063JFKGc8J6mzG92bHF2YBZhciqw9v4F?=
 =?us-ascii?Q?dO+qncXHWHEQTsEK8eO1rKmf0b5G6Aw2mP1OIw1sz4SIwKhMPs/Gu2M93cPa?=
 =?us-ascii?Q?q+T2vGM5TZVAUn2+ZxA8atKXEb2lJEad+Y5utUwCYdbOZ1Bk/tWeZgjPIVlU?=
 =?us-ascii?Q?z0NfsDwSOoNytzLvAyzv7krHTJ4UY1v80WOERBS/vWBlPyBocckqJbYxq+9T?=
 =?us-ascii?Q?9+p9mnVH3CFcGFW9HKCpoZDAPyy/sw3GKxvthtSe3tYe1zAMli/zF65TH7wx?=
 =?us-ascii?Q?vy4zMjwNHo+XZfK9yx4V2RLmyP9c0q6eTuXVDssfRQ8IWIDrCVKZ8wDNByDO?=
 =?us-ascii?Q?XJIEplIlKxuQL7uiPq855uPIxQOmkk5nj5/N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:44:22.2978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2b64c3-76f9-4fa1-6aea-08dd869dd694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

In function cxl_add_to_region() there is code to determine a root
decoder's region. Factor that code out. This is in preparation to
further rework and simplify function cxl_add_to_region().

The reference count must be decremented after using the region.
cxl_find_region_by_range() is paired with the put_cxl_region cleanup
helper that can be used for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 26 ++++++++++++++++----------
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0128dec80274..a292d5c4c4a9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3408,13 +3408,25 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+{
+	struct device *region_dev;
+
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+				       match_region_by_range);
+	if (!region_dev)
+		return NULL;
+
+	return to_cxl_region(region_dev);
+}
+
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) = NULL;
+	struct cxl_region *cxlr __free(put_cxl_region) = NULL;
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct device *region_dev;
 	struct cxl_region_params *p;
-	struct cxl_region *cxlr;
 	bool attach = false;
 	int rc;
 
@@ -3427,13 +3439,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
-				       match_region_by_range);
-	if (!region_dev) {
+	cxlr = cxl_find_region_by_range(cxlrd, hpa);
+	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
-		region_dev = &cxlr->dev;
-	} else
-		cxlr = to_cxl_region(region_dev);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
@@ -3458,8 +3466,6 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	put_device(region_dev);
-
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index acfda0cf3f70..4565d8131c5f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -741,6 +741,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
+DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
-- 
2.39.5

