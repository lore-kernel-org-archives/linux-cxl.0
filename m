Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591C1F8AF9;
	Tue,  7 Jan 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259117; cv=fail; b=SD8CM6WUISJzD2/SKQXB2eG6AzbkqBsWYBxNpqC+hgmt87VSNt+cFJujkcuUgRdMKuuAwsiBfe5eEQ7BqcveW21xXJJhBwJ57apVojX9PbPXpsO37DBUEs4afcEAf5rQtcQYmteLPg8Exd04EEir2ZNjSYl51ePbv+uI8JNDmrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259117; c=relaxed/simple;
	bh=q/VOQiZMA2ILDi5Ij9CpKNnl1y6sV8rlplRAAUaaD0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvkNsKelqcgyI8M7tLzJgAkt4j2okBDl+nFCx96avL5J0XAX6uq6K3zuNARqRAn5LyKdlm2ETTW5N6yd9GboND6c/muQHA29Y69C3vcxLaJIpe2lhRj64fX7Y+Eie1/iadm1i9BHQ063he6D11AxWDytvPR/rXnB9XrCUFfiNoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m3cV8lew; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m3cV8lew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVs5almOAQfQ8PDGGgis9LYdGf7PjMJFE3P8rdevaUCxG7H0ZfzRE75osP2CH30s9FPnQltlmSSujSx5acvO6fZNnfDRqy5BSFBBENVh8Ojw4/digrvmCV70krRi9ekX4lbJiyobvoJ3NiuJKZ4mpTmTGgqINiVVwticm6u/N39J6FgnJPLeCdxlsEEcu/Nc5RxYqgWoZstnY6zVlG5GiRf9C3RrOnEICQlWKvWkI7BiQj8CUdi9w/1yq6UzjkifKR5LfeOpgjfN8QYZslVjZhCdogxdMBHLX5rNZwjZB8mip2mGkeYOhSI17B0MDrkgWXMMYhiFvsq9MxnXmRvK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5b+6AHF+NusUsXe91xNLTCoHqSXgILzEZ8L8yfhgss=;
 b=cxUWPVj1Q7h8co9jbnH9xsZ45cHrmKmRcgnmrh/fbH0Jnot4hdLZC6SWpLlSW1xfmX3FIV9uFo4p/R4i+d3qBIA0PZAJbqF3QYx09oq+fHrS7Fu+ofIK5zbGy6cjOm1rTVpeCjdMcCIgp4N/Dkg7DcJeBsSoib5ivHzD7lp3Mucs+Uy9kR96DurLD5v9UjFaXori3Kl4Uyp3wBQeXHWcWVvppTtJNuKDy3Fi8omCgudiVYuqDHLNWGm/lbiqXgOB0PaWeigirNKN0rxs1CGT9l1PKL7VQpnT0sTw1bJ4d3fWOhq+LO62mMdt/ftH5116WObOgDR2/jtMbjAxGvM8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5b+6AHF+NusUsXe91xNLTCoHqSXgILzEZ8L8yfhgss=;
 b=m3cV8lewzPgDZUVopwyrsUD7+ZBIAZT8Fa4vF97Uc9GpqAqQnu3IeBY4rYZAUXbOooU7FXYNLKtDxYGLKQ4mxSjK6IR7cR/+4rKNMao3ig46eJgrgwY+KGA44oynZ+oJTUBHoa7oNE3gFumhdVDHa4slMdm6Ze5XRT91CIK/wUc=
Received: from BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48) by
 SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 14:11:47 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::30) by BYAPR01CA0071.outlook.office365.com
 (2603:10b6:a03:94::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:47 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:43 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 18/29] cxl/region: Avoid duplicate call of cxl_find_decoder_early()
Date: Tue, 7 Jan 2025 15:10:04 +0100
Message-ID: <20250107141015.3367194-19-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a6421c-bdda-4d18-fb01-08dd2f2538fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+D02BdQ1iUZ9X1p0VodaY+NumFZYNajXyUkaGzETGFqRVzscDycoX5zRKj4u?=
 =?us-ascii?Q?aLKB229aEZMVRDkPRlvYAAhp5Tn6XyvEB3M/NNLzYm8/EvqlgoUpTPSbwSMV?=
 =?us-ascii?Q?dK9fzCvv6aCZHCUhFsuSPT17oVzuNJp7MFQpUVftB34Fsp4ppP/TeXSX/agr?=
 =?us-ascii?Q?1r+Us/4D5jzvgJUxBSOwWpYpq+T9qXLytsC2v+8+xgUv3EvpOhLAUS0iNDeI?=
 =?us-ascii?Q?SkaHQkivMCJPgjOCGolxktj9bdompRU10W2c9U3o5rdsUcLI5dDkOrcaOpFd?=
 =?us-ascii?Q?/qPfKlKjBYbtLZCaXHgNrwwoImC+IBdm9AB+nKHpck8wwRiSXtCFwzd3c0Vn?=
 =?us-ascii?Q?wQ23OLoZ5VF/ZTvRAgiOl4wuWk06VfImqdgdXpCdMA6liYXgAdMaR2IAqz8j?=
 =?us-ascii?Q?RX7OFFJQKlsJcVzXlo2hxP2UFnEWgPVDhUbt5blgE3/pQqMscWesc5SjduRE?=
 =?us-ascii?Q?1rqA9e9fHy00XtOLDp6g8vDO0XQl/k+sESiMk0W2Vs8Zz8EMr79HzSAWM77i?=
 =?us-ascii?Q?jOcCcNLKnTTrIDgEDQlKP8XHEUhIlr9ymTmD+M5+moqMyXIqUt7fdaW50A7l?=
 =?us-ascii?Q?yqpwIJ24Eqyry9RX6hlP0cpFENIsYuK9F6hpSQx07R6C/9KCWgVwSSgSpKHE?=
 =?us-ascii?Q?zZokxmUlMapjnVdGfF11plkrWlBM/ETeLqhcRMAYUgQKMLWCram5exGFFZlI?=
 =?us-ascii?Q?mGlIiEuXB8UlBaYLJazhPo8uhiS0L9BLqIxzvfi72tPGZ/C/cWu5C4JlMO9z?=
 =?us-ascii?Q?vHYEyuQT2IOAHikOGXIpMBc5IfcWEjLrBWFJ0P9DbDEHZl6HQr9IbZkuEk9i?=
 =?us-ascii?Q?LnD8mHJlW7x8sdbBDqTEB0P/zfG9rBCx/jxIYb5yK9c8I7QMNWOCJkTxHM5L?=
 =?us-ascii?Q?wZ6Z1XOFDPa8QEAkJuwwxfdmwMaqUfHViKnOiyV/ilfodLNqZ8hAdV+/+qtl?=
 =?us-ascii?Q?/UIOxmqHR02u8ND2VGQ4IsWGgk45OD7ELdENW3qCseBUuKAdsJYwE3Ds74wN?=
 =?us-ascii?Q?s338rjLPSYxtdt8GUqek6Zs4ePX4umnx/FZn28mT1JXIQpYQXl4FccuUfdkx?=
 =?us-ascii?Q?fK3EXYoeqJ/R/D9yB+2xyzzqRzON2rNlTcDc38wVgePansIrmXHKFpCmY5e0?=
 =?us-ascii?Q?DWkB06qgzXuil8IuDTs3dUg3frq8gtjRJ+h4lgknol8LGNv/cI+sWan8u0hf?=
 =?us-ascii?Q?jPBhVj8M/xGig2ht1haDGLwmPAVhclD/+GE8qnJX+Cds3o3XCKrULI34WZfz?=
 =?us-ascii?Q?8qlMjsvn4WQ1LZ4/v6CniovPxPGQSWulRwiZjQE1AWU3kbxpHGq/FVhMcwFy?=
 =?us-ascii?Q?oRBQWOKeMfCJ8qby+J3VCJmsbTDoz4aAHeh37VAYFDnNDXU/vfCBJ8iCd9W4?=
 =?us-ascii?Q?MXr5b669UfEQxTQSih5TL8WkCMCG53zhfd3d9o2iBC2TpsrjjX4QM8fugcWv?=
 =?us-ascii?Q?dditDJKtaiB8ckZg1qnnOeWPBke0dCc1eJsTsWBVxSqEiirgTsb9IVAhr8BM?=
 =?us-ascii?Q?5lFF1jlyFbs+n4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:47.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a6421c-bdda-4d18-fb01-08dd2f2538fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792

Function cxl_find_decoder_early() is called twice, in
alloc_region_ref() and cxl_rr_alloc_decoder(). Move it out there and
instead pass the decoder as function argument to both.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2bc2028988d3..b7f6d8a83e4e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -928,7 +928,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
 
 static struct cxl_region_ref *
 alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
-		 struct cxl_endpoint_decoder *cxled)
+		 struct cxl_endpoint_decoder *cxled,
+		 struct cxl_decoder *cxld)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_region_ref *cxl_rr, *iter;
@@ -942,9 +943,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 			continue;
 
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-			struct cxl_decoder *cxld;
-
-			cxld = cxl_find_decoder_early(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1028,17 +1026,9 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 
 static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 				struct cxl_endpoint_decoder *cxled,
-				struct cxl_region_ref *cxl_rr)
+				struct cxl_region_ref *cxl_rr,
+				struct cxl_decoder *cxld)
 {
-	struct cxl_decoder *cxld;
-
-	cxld = cxl_find_decoder_early(port, cxled, cxlr);
-	if (!cxld) {
-		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
-			dev_name(&port->dev));
-		return -EBUSY;
-	}
-
 	if (cxld->region) {
 		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
 			dev_name(&port->dev), dev_name(&cxld->dev),
@@ -1129,7 +1119,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		cxl_rr = alloc_region_ref(port, cxlr, cxled);
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_find_decoder_early(port, cxled, cxlr);
+		if (!cxld) {
+			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
+				dev_name(&port->dev));
+			return -EBUSY;
+		}
+
+		cxl_rr = alloc_region_ref(port, cxlr, cxled, cxld);
 		if (IS_ERR(cxl_rr)) {
 			dev_dbg(&cxlr->dev,
 				"%s: failed to allocate region reference\n",
@@ -1138,7 +1137,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 		nr_targets_inc = true;
 
-		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
+		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr, cxld);
 		if (rc)
 			goto out_erase;
 	}
-- 
2.39.5

