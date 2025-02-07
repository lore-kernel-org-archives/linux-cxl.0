Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B72475FD;
	Fri,  7 Feb 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942762; cv=fail; b=lFwnRLKnG9EIn0T4cpdV7Ov/LX8rQR2gR9ISYYA9r8PE/uEqRSMf56Er97kAaoqhwNjz8lbsbUz3wEWP7w+7xlpon1IG6Is6t1oeLM1YtXV9QnM1EV/FuJVGTN2wPaEiEEefECuijcTPeGfK/UHm5J3RQR3rzv5BI2/EoKxFqmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942762; c=relaxed/simple;
	bh=AnTnim4Zoy4U2xUw1Clh2Ip/oRDfHV2PasApRtxHNDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2Q+XuAdn43C4gy9QFeM+FK/Yuxv6hQ+V7PRbjD7mvi3EjEaprY9KkQeOwRFSjt3TBpsV/zDv/55ORQTpuBb2dxli2dbOHOpGIrtlRnAdFQTiNrNaqz0Bc05e9osI8RU9X6PL4V57u775CTx2P7vgmkUgDqmmWG5y5mLCJVH3To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydgHmFH5; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydgHmFH5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzTOfIo+SZmVRlrJ9XjZe8gXofcIuBEE/JKxxofq3Yj9ntfSZ5t2PxE/0uEDm24Y3R41f+5qwsDMNLnvDOgwm4cI11l2J2GObxc98TaoWHU5jQlj0SFrxeRKgZhk7jMnRqPKKEQqG0zWMApwGeW6lQRIgyBhOHApyaQ0fH806LR2rMa/4un/WjbXXLAqJZkIcWCAGl2OEpy4wqLPnJt0b6pT0U2MVfL5crTzWmNfCrJ1XmFbWpGtOOlDqkLLXnL8oi1ekUco4P1ycBBNFcP3HgHtjcNFRZeJtWzEtU/ITjcDnG4LfBYGdArxnslil41N+ponPC4cSGoGRe8OhNnVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhz5UT3CgPbxHXp3ulBryjPUdfG1m2gku0mo6Xtg4Yg=;
 b=vlaxkAtEGJfGFDZycsi+bIYNXMeAGidsnQ5a+bWk3c/JwjTLlmFyMzXjGoCF3Brxd37Zndl9G/INsvz6baz/f6gvndFLaKqmorp1yVGWnlmhwn7L1AnIEgzwWABKVjtah+agSDytUiAiGxXxjIiZJlSj87scBEA7M6CJUfLYVsdYNy5PgIbzGFus8Ra7RJ24rKIIBDo7q958VOzTuOuu8PG8F0mBJYSYcDd1MplbtQj0EinEHfZqJ65PNB3JpEtSGfm35bb6j5uifK4SgkPXUxJi+kmQ1LpfCBGKscszPMHXyAK1XMLdEJk29/q+7RHbKQ+88AKvpQOeCKr6tMYUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhz5UT3CgPbxHXp3ulBryjPUdfG1m2gku0mo6Xtg4Yg=;
 b=ydgHmFH5a9ar8LR/KCdy7y7AFZ2BYr9YoV7ljp/k95GV6r0UODlFdlHqlj/Gy2SVAujlVI1SOJBaY6Jo+566HPLpoPhfsEsmNArrTB3PrW4FXW8R43ujg09JEUf9PT5aAkQCebjybRMxDo/g1MTgud7aQK5iGAJJ9tO1qLc0hZU=
Received: from MW2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:907:1::26)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:39:15 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::d) by MW2PR16CA0049.outlook.office365.com
 (2603:10b6:907:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Fri,
 7 Feb 2025 15:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:39:14 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:39:11 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 16/18] cxl/region: Show message on broken target list
Date: Fri, 7 Feb 2025 16:37:51 +0100
Message-ID: <20250207153753.418849-17-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfdbd3d-fd21-49fa-6f54-08dd478d93a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ywPGnOSQVlgYezMlc7ZjYOuydtIyOjvxWnFxLnULZ7/PzPgPTF0FHOUOAIDs?=
 =?us-ascii?Q?jPVF+XkNvwIXKnE4B4tACq+XO8vbSNVno2LDuPjD9va09N2C8Yb/qHTWTi4M?=
 =?us-ascii?Q?HZ1G0QWWx6woT6aCU/HJlCUklfbEcmqu/Cvf+lWusAf7gGfsKge0b1ub7V4s?=
 =?us-ascii?Q?Gw1f8kwjPHisBtOJGP8X/ktqVfTCHnEzkhFxiYTp+pBZweupXuP2k1BmmN9N?=
 =?us-ascii?Q?FyKZFXlz00OJx+0jhKZz1jo1OOTjkbAcQlVkj5oWuGkFM7lYCIcJicxHot9F?=
 =?us-ascii?Q?Mn0b5lOdGIBuUX5kXBrl/PK47ZZi9al9pOyku6oeI74gqNdeqgcqq2rQiPTW?=
 =?us-ascii?Q?9/+R+eHl2Lp5eyoEBlEBg1a/uIfDZohqtuJ4R46tdLsWPpcBgwyHFTUJ5T+Y?=
 =?us-ascii?Q?pgECuB/i+ZUk/Xj3nLZsuxuNUuoVDcrbDvR1cfwNEVg/6PcPfJePW1x39oxI?=
 =?us-ascii?Q?d8W/p63hCbtNrrh2lsEzfqKCiOV/sqBBk9H6JKP4pMuC3r/25VuCzzeek+u3?=
 =?us-ascii?Q?dpFjbSEod5MewsMFMAj45XG8s5DVxPm5kjzXiA/1OrMbIIjNwAHN/x26r908?=
 =?us-ascii?Q?x5O8YSD9lH3/W1U77N+wm35NxMT9yHhPXFgfyEYpEqEeH+nQaDCrmFlPrQMT?=
 =?us-ascii?Q?+Kk5BWQ4BfPw6ul+fiaXg/kzAvGXVZ8OJquK6XOoAsDnlCMgxgKY6Zl3dDnI?=
 =?us-ascii?Q?jjZIpa1SB3x3qjx4jcPYc4Cih6me/sckKjAUdUSc2WYphomo+ZnPRXTqBpzk?=
 =?us-ascii?Q?Zzv9poz51DwfkO5MdqDXW3SO92JCKdmysNhBIqdm4xO1zpMc1ZhjWJrUg7yh?=
 =?us-ascii?Q?/K1MUJPcnb9yXNZGMHTfEeYbCeRqXfYV8J6euUrICBrIa/Sy8xHv9xXn8rtZ?=
 =?us-ascii?Q?GtlELh4nTRtLod7AxenFeXdg+TkrrYr37gKYpk5Ol/eQWbZ0gLeUVV40UnE2?=
 =?us-ascii?Q?F6jKHbHibxXcHQII8W27oBvITT0k6Mgn64bg2Kti5o5dMTSxgOgGKD1ecg4f?=
 =?us-ascii?Q?eok3Y629CcD5V+14hgdkJGXze2MtTT0P61tjdmb5i33zutmlkFGvXSQ2ODNN?=
 =?us-ascii?Q?5jpmJ7ZNVV+3H66WeQTz9GMVNFOf+2sMBzsc54dPDLWSszN5NsdDzmpv7TsJ?=
 =?us-ascii?Q?HaQbLJZOWT+GFFOZucA36G1Y3ExEg98iMTiVfrB49FY8umLEsb8T4MLc3s8r?=
 =?us-ascii?Q?Q1QDjp49Pr+FG91AlAifvHDlONLZo4H0OXD7VOoj65QLTBZMSAmctWO9c4ba?=
 =?us-ascii?Q?iTi5ip9R/DjYheijlx/XsiBVtqFMSroWVlw9gjmcUtewZZQC938t+yGVz2Zh?=
 =?us-ascii?Q?sU8Gs6oF+8OHZhj6bCnMCZH3RMVo7PVP/AHjjJl7u69QdwJiPQ7dGu46QLNr?=
 =?us-ascii?Q?HVAzdUAvlM8XyGWJL5tmoNB1KzHIJiJkH8PbcmzSrj+87B65loaQe8jXoWO6?=
 =?us-ascii?Q?QP+pFNZihr+Ua5q8JOSmWY9LKFIEkEJTZ0giIkymWw6zIhi8XSB/O0dfKMh+?=
 =?us-ascii?Q?kPcDGKWiwur0DrM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:39:14.7747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfdbd3d-fd21-49fa-6f54-08dd478d93a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

Broken target lists are hard to discover as the driver fails at a
later initialization stage. Add an error message for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 606f5652114b..3b578ca167e5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1790,6 +1790,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	}
 	put_device(dev);
 
+	if (rc)
+		dev_err(port->uport_dev,
+			"failed to find %s:%s in target list of %s\n",
+			dev_name(&port->dev),
+			dev_name(port->parent_dport->dport_dev),
+			dev_name(&cxlsd->cxld.dev));
+
 	return rc;
 }
 
-- 
2.39.5

