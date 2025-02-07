Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E82475FD;
	Fri,  7 Feb 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942756; cv=fail; b=I78c/HOqS6M/6hBLoxhl13rwxBMFGBDggFnCLeZhZWXrJnY4rFFX+I5PS8bol5Wv7VyRlfy2GrdR9YEbj4eUmx4bbadXSx38Ws0wu1nnpyYIBu8GUxh6NcJU3CRjhobYNol6aBCIjJt0jZr4oAIw/EhKo5Hc+lFz4Y/XZi0zGN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942756; c=relaxed/simple;
	bh=d76fuEVzh0anBijk+8eolQ4WUD5ou2mYa2agAHh452s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3veSCzt43mBvYoj426wQP4WyHhwNusEkTPFjYzKaSgGXn06sn0eF20TkYMh7C/fOjlfqwbl0eBnSXnMX7UktNwrHU5nBeEnVoHG+jrbky52O7P/ql1n5AcrelkVD+YKSsUgFUg2i3hgmD070OBmtk7zkF2+vRZ0e2n4uxZVeVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oCOxUINA; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oCOxUINA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POmOs/jFEoPKBDVBsOcX7IA5APQLYYTmPdlS3HFvBNPv2DkbclizhZomhI8IMe5+3LCrOmOt1e6vFax7mXlFMtIAjC4ETTZK9n5ZXwDt669Guwu90o5xjs7ocGUcX0Bv31UBMC2Sxng5iSurtc4tzntwgYVpucyKQFbH+vhy0xbdTkGR1S3lqECV18bakB+oF6Z53sp/BGwsqY0C73h8BuqaBri5lNepbZE5ezhHx68mHRZVS0QgUhDNrjPKWdBzOgcB+7l1EFOquS/geYlag3DTgEEVgzDOTcGeCvj1TuBqmtHqX7jKo91JXn8+h969OiJnKYhIMuLbynyD7nPofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phVIGzXpFboeO07RCbLecw2c+NB/H+hupxKg+jN0jzg=;
 b=WK/baJ/+cj8mkAXvAxo3FrOX2+5Hpjh+YO1+wtACC50samJK1KfJvnQCvueIsTwbVQm9/1lHnTCwtigu03HyK+faLuQJX7LzsEsl2X82fDsEo8k9ts6ggErzbF0d0HkcgqFpcHAHD+If3SwWwzHVOdXEdummUPCb9b6ammwYucJ31Gz1knlyKC/QKnYIM6zYC+Op9jPxpwSPRBfpOr7St5XXX5yM3W3tmLFR+JXmDI9WVhKNgy0m5fT95MRYkaJhQ4n5sWegrzdqQq7qf6cFsS3YM/8h4667prsJtYUvrY3zE+/2d1GESeMW18yZEB03V29pKAx0Zy1Y9HSS9UWZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phVIGzXpFboeO07RCbLecw2c+NB/H+hupxKg+jN0jzg=;
 b=oCOxUINAW9LBdLitdcAVp/SS5nQyjhdHTkFj7Sl73mUotiCHQTFpzIphDM2UnQ4TUfIN0kLskUIzn+UzelghUpOXOPWtbJVogixNYIFx1A5a7twOSQZc7KlJ8kMf8qea4rxYivp0v09Nu7f6SMsQXCaDCs+ciKrK//9yvOQSImc=
Received: from MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::10)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 15:39:11 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::5a) by MW4P223CA0005.outlook.office365.com
 (2603:10b6:303:80::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 15:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:39:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:39:07 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 15/18] cxl/region: Show message on registration failure
Date: Fri, 7 Feb 2025 16:37:50 +0100
Message-ID: <20250207153753.418849-16-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d78018-caca-4e8d-0d24-08dd478d9184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/lN4VeDtmAR3BTmLAOPVuJuEgr2U7pMHu+2E3IJ3IkcsrGs1pA6nm8kf+rN?=
 =?us-ascii?Q?W9eEMaIqFIHwt5mNPSrg0k7Exaca22D4KtPiPKrggjuOgpnhWBIe8i/oSTbN?=
 =?us-ascii?Q?MkIKx4bbrqMi9gXWosnMEOppluDCdc9IaDvx4TKhm2leqJP7NCjpQJG7+3Kd?=
 =?us-ascii?Q?XvgnuDlgL+Pn7fFtQegiSHPbcsPJ40Ue8/3dkvJoAd3m1Z9T+gVfUufbbPGB?=
 =?us-ascii?Q?VV+sstOe9ZCl6Fg1IvLsVftEeyvjkRjgDyFoWJ3bLwx4e/vm1pgtumke9WZJ?=
 =?us-ascii?Q?O2oka3runSvnJiKZh+wIzAi/VEL2N5yaCfllJaaAnRwa0AtPJ79HZqSkDMlM?=
 =?us-ascii?Q?sdujhMC//YFOfXU+RWBHEjY62L3sHqJQB97DkqsxUO00tjcoi6VlIj3x9kj5?=
 =?us-ascii?Q?x0HqF8xa9s4LtnHN0II4MsMnBCxP7D1O1o9v7s/a7JM3apzDPueOawKwcFqQ?=
 =?us-ascii?Q?1YBq1io/TWcNs2QO1mZ+Ip+BWHqTSI4oBfNIVNMENuV5Ou7gle8SikALPNte?=
 =?us-ascii?Q?IvJIBhsA8oBE4T4fqMq7BxI0ouJ2sEWr62EYvlySzCQyAjjtGmcap2hwZWzx?=
 =?us-ascii?Q?hGQCbWQ51eFivD5CWOjE5TWXQfZITYAval0aRyub6yrEhH7Wn8Ux5ebBK4zj?=
 =?us-ascii?Q?tKiLkix7GkMFc9XqlAJtmfLjHHCfw73mp96KqK6KcP6Q7t1y3iteMUsQzgzB?=
 =?us-ascii?Q?IN1PkNdRQgo2jBRALjfmSC1NFYk6DI+eCdLuwxF5cLxvjOWlQhVFFtssjXTb?=
 =?us-ascii?Q?UvSDEovUxE2HY3CQRmG9PKdMcYcXomqH2hmai5XFZhgdAmySHPebFyvak2Ky?=
 =?us-ascii?Q?Y4igs2jMjivtf3rqfIhiCQzXH7ZAcvC4OBnvTP1yYXf7WubOHR8a32WAhO00?=
 =?us-ascii?Q?gL6vbyMUb4pCm7sAy6ZROJYoN6pQgo9KZ+43eYJ91OcDbIXPtzYYKvky56gd?=
 =?us-ascii?Q?mXy1ITA83Hm58ARAM5w2K5j5F3cAxx/yJQ2kR90wQPHDTTQJOFF3gMZlJ5xx?=
 =?us-ascii?Q?eK54lYy7b9RHnj+wTR7qp1NTjs6jTH7lL5GPB0RkAhmYcUba1I81PSQldOxx?=
 =?us-ascii?Q?dEZZ1MTj4+2CGmi3Bxo302TpLGzmPTr7bWwQK0hMW3jDV4fptfwlq7IKz2Iu?=
 =?us-ascii?Q?MdijWJlZSxf8ttVUDSE0uQhI0zf5EtOWvjhDhoz2wSH7gZ1IUrFDvm+7IkpA?=
 =?us-ascii?Q?Szz/Ie8YGNNP5xtYEdyoUHFpl6auuvJzs0cPs/UTjMp7FtwcUiZiuJ3iIBFY?=
 =?us-ascii?Q?M5LgBY7Q/6bI0aIVeAsjWSbYoNE+AMYhRm6TlNaHYzhHjkE5YoaYZBZjxJud?=
 =?us-ascii?Q?+kKtM+VuisiCUlp4bq7EzcO62leARS5XNK2cmpWvbORSAbOVUYQ0Wq6Gc3x4?=
 =?us-ascii?Q?N/FJ0Z/HpCL4KdoaZ4qu8PJvHfSfr8LbVmLQ1w7JlfoyqwfgUu+f2IR0a0rv?=
 =?us-ascii?Q?ix0TEy4JqqD7mFneb8dGRqbLUs552m11a4KOWhMDZcLhxRHFuPNlZNG+fKmj?=
 =?us-ascii?Q?vFCfnxhgkU0d49I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:39:11.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d78018-caca-4e8d-0d24-08dd478d9184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

Esp. in complex system configurations with multiple endpoints and
interleaving setups it is hard to detect region setup failures as its
registration may silently fail. Add messages to show registration
failures.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 728cdd9925a8..606f5652114b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2147,6 +2147,12 @@ static int attach_target(struct cxl_region *cxlr,
 	rc = cxl_region_attach(cxlr, cxled, pos);
 	up_read(&cxl_dpa_rwsem);
 	up_write(&cxl_region_rwsem);
+
+	if (rc)
+		dev_warn(cxled->cxld.dev.parent,
+			"failed to attach %s to %s: %d\n",
+			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
+
 	return rc;
 }
 
-- 
2.39.5

