Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94821F4290;
	Tue,  7 Jan 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259079; cv=fail; b=ZIj2Gckmme+KOxT/Z6KqSIOPkOhnFLaKWVdz64rGSLV+Gj0XPwh2jaG/vjZiZWA9QhnIZ8FymyGkCPIygKpJLJ/eYsx2pClvVhe19bWt3KR+sL8rVIEVj1ckZ/sLEbeMjYj7YM5KZdWnQitkMLIADpANeBJamY/f2H+JpsWKjzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259079; c=relaxed/simple;
	bh=v5zOdAXmY514DJ2y8vIubrkkPqVRfqsAreOVLPKVHfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbxgeSGnb4OGatvyxZbz1u1ayIKQ+AzVx/4Ul+T+QGER/ThQKJ7SVGjgcdihErhsENfl2oTBJmYn6TXfA6l1gBB/VmHbEMcAwGa3tZvLtwqq6F+xJOWYBr6yaD6l3ciwWIQkbx/Rf9RWEpckyaQw7l4sm2RTysfXz9Uj96Gfd6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pPOKHlDY; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pPOKHlDY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VddEnoJBsN5PrH1KLZIBKqnIdBOAT+p78mXynopaFzJHwQU5toVByxEhss8TjJhRO/rP+QkB0+OPD/UnF4OwJfETxsDanD0IcfMJpP3dYRfL9J2ajV3WFkGa9ZgbSd2coSem+No0DJSFchnGYnaaesyvd99gDpau+GcRVB1aWmHNIAklP+1fBnHZAxOUSSIVuo+v6Q3wYjBVT9IrF8ovilwiUa5JVlJw2LB+kZ/zyhDiTAgNMJ8TDtDJaM59Wf3EreLmD2elQX6zDG0JInh+QIXzBzhYMRdjxiS85tCMgtCVkGp+LY31npdCeGSlWE0WWxEqajeKlIRpzqvlTeEPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgfFAfWnt7uw8c3XpwKFfdt+2xDGEfx+G3Ovz0C8tJ0=;
 b=SfehcLxTd4DE4oaWjVanW3OfGjE2H4oO/ifkGOKhQoyHBrURpF5b1llWjtF+xBWNqIIQ5Y7C+5v0refpP+dKUKzUvqzPnn47aI+4fdyWpV9cdeNC4OOHTxOU9mqHVbe45R1C3153Eme8/+GfjDGKQ2dbtLQTpm0f6cRe9cNr3cmyrkf1eYNENNBZVKNanu9nrn+6HIjKSO/SipDpTtZm1SYghMJV+5SYi2KGLiOa0vP++bOdGyfPEwGGyUZy47J9TM+dxk0NN/43o6LvA/ibvJpvpyIkoba+JW6yo078TRQsnezHyYqtEpkbseULjFHPNP/TXUiKxYaAecXuzrSbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgfFAfWnt7uw8c3XpwKFfdt+2xDGEfx+G3Ovz0C8tJ0=;
 b=pPOKHlDYp+cWrQZyRflMHgDNRmUwWY6aGCZEiFYZOK4qZx64OEF62Dbz3T8s5nAbHBDBA+hia65yV9bJj4qxFAVLIGrDJ+kE83HOfWxSXAwGFIV0E1rplXy39bEbfmolEtJBPNGuktEmQ1bFQfAS3IoW9x6aAO7iBSuM9xK/i8w=
Received: from MW3PR06CA0024.namprd06.prod.outlook.com (2603:10b6:303:2a::29)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:11:07 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::1) by MW3PR06CA0024.outlook.office365.com
 (2603:10b6:303:2a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:03 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 07/29] cxl/region: Factor out code to find a root decoder's region
Date: Tue, 7 Jan 2025 15:09:53 +0100
Message-ID: <20250107141015.3367194-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ec538c-1136-4faf-6185-08dd2f252160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcSFVvYfsePmFN7gUMCOznHXiQ4eckPf+cc6RuKwxI+WRXkJoA1643KLasfA?=
 =?us-ascii?Q?7kZaymDWdYbitamqBteJMUzcWaIRVQMCRqLnC8VB6wbc1hwZh9+waVluWnbt?=
 =?us-ascii?Q?Qcm5jAAr3BMlHU+7nG1hCmhUrVYlecvjUxJNImCo9BE6CtItxQDitPb4UsHl?=
 =?us-ascii?Q?wJoYFGn7oo48IIrpjovIaOox711RvjRnpxledsgvUgz5X6x3NqQvugm+ydXf?=
 =?us-ascii?Q?xtXK7ofdBVOabNxotCTCaQJVcdvup3UD32H84vHeF0OhgxCR9JJuU6Zu1uWD?=
 =?us-ascii?Q?GyUq1lKdlKGBDwJtdb5yU5oCsQYrc+2g1MvMU5zqR/ATDGFuiLbH10bAvkbm?=
 =?us-ascii?Q?wHheEtvaITHlMWKVwBPLg0g5zoqiI6WlorQyJt1c6bMPGJxNPp5X1MsuCY1O?=
 =?us-ascii?Q?7flqtKHOg2WZaOMndWTWd+F8NwwlQBCAaruxcZXDOeqTHh4x4OlDFE88rmxy?=
 =?us-ascii?Q?v+h1eA/t+15j0G5FY6kIbxFzePKkzqVOaowjn5eOErGbnU/K/mLS6WZMNHLW?=
 =?us-ascii?Q?bhNZbi2ipK9NSdJE0fKNDimfBd2DFNi33PxcoTEvF2qqZPqr58bsZbxbShWA?=
 =?us-ascii?Q?Sn03QlZJ4SqzEWTPzjPdfg59X06utGVE/7adIeY6SWkoeVG06H/ibDrFBPio?=
 =?us-ascii?Q?XxXYLCesA7Cop+6a0pzSzqhto7F8pR8vtNIUnWfUlW/amk454h1MQsrSm0g6?=
 =?us-ascii?Q?/dpwBIbW9Gt1Ck7I+i/KROLaq3dcZ/uElNb529RLygC9JaFlA7ardABfh4zd?=
 =?us-ascii?Q?5Oo18w7KlrVfPJu5+TQ2Atb2RWkSBq6vNNij2oJ6qliDbEnhtvOgNTYS4/2n?=
 =?us-ascii?Q?DQdOEfpKUxvaALkd3JjPZ5MQXdSYgT8SeMMEq5gNiMAIrFoaQYgJaEtpFHyQ?=
 =?us-ascii?Q?SjbhJjVI0zvg/132+46pYLKcbaojcDVnY0hAzSrTKruYeRYbKZkKph72mBDe?=
 =?us-ascii?Q?rpSNDkIomiHVaUDpFWZElQJ7EQsqQP/njOHjkqm5G9hXZbTFVb7IWvC5j8JE?=
 =?us-ascii?Q?r7FiFRjRkf5JhlAsgRFIm3PdFViGsIXRaaRq/riKozUiSfHe5P3H0SRBXuav?=
 =?us-ascii?Q?3L2Yzl+nl2gx1rVhDh/N4DH7fls3VgmrqXYo+fgMQ1gLGoVbgb1ofAqY4gG3?=
 =?us-ascii?Q?v88Pse4F1rXipSOmHuPlOkGTCqEn2jbDF5C0I1IUCiCeWF7c/sgoxNsBcBDs?=
 =?us-ascii?Q?NOJUdDUSMQdH17ZSdu3RseLiE0RkCDOx0tuN71Y6YXbVWPuXlw+IIf18eUmZ?=
 =?us-ascii?Q?GqvekcyKtGo6AIzpQPzIdl1aten3o5FRn0ShUJuh1DtClKi0VsmGi+LgwyVj?=
 =?us-ascii?Q?iQaRxPKjRDz3Lw4Ezhda9LpftO9KL+XPNmbg5pgujod045juDLp74Ako4zQn?=
 =?us-ascii?Q?3Tb8tGdJUy4Jnrqy3c9DoxMQo9GBDymrSu1ZJvpmr6W0hWzrsOfNM8v8p67b?=
 =?us-ascii?Q?ehN8Ogu8rAEKAc+azafpFIPE4EXNX723fyzP+WpcHcwp4Rb8Lg+E90E+uCIj?=
 =?us-ascii?Q?7T2xsbjJBz6xxWI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:07.5175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ec538c-1136-4faf-6185-08dd2f252160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344

In function cxl_add_to_region() there is code to determine a root
decoder's region. Factor that code out. This is in preparation to
further rework and simplify function cxl_add_to_region().

No functional changes.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 448408918def..d5dcc94df0a5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3255,6 +3255,19 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
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
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3342,7 +3355,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct device *region_dev;
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
@@ -3358,13 +3370,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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
@@ -3389,7 +3397,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	put_device(region_dev);
+	put_device(&cxlr->dev);			/* cxl_find_region_by_range() */
 
 	return rc;
 }
-- 
2.39.5

