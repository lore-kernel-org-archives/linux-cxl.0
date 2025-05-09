Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E0238171;
	Fri,  9 May 2025 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803303; cv=fail; b=bD7ZUjaxtCCzbY1LKqPW571VIg5cLzaoJ8Xxg+t9+w6PUJ5X780wFLdt+f88IW9EGOc74x6dxwkompQpMc8aS2R2XK88heIkXQn+KJ5LcY1AdNRKXLDw3CfoilxCoq6Bw3kySA/LhUVSL93OMtbKmzTLc+UJD5qgumsa3Kb4L+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803303; c=relaxed/simple;
	bh=8U6H7lnSEVPNbfFllcjL91wC7PobCR3JntkRpazSikI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvMEVwVjYalKxOMJ2WvbzK23GzlIriuapVEP6l15GiGWin7AiC88IQsjW9JqVyk4qm87T3zStIm11VykY1R/+K0v3diu7ofKEadsOKtk52N1ULQbamLms+kRipV5Yyo1oFRW1D3FxuFmub0CSFasPMG2ui+HAqJ+WtR2g/7a2hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3thS45oO; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3thS45oO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgfYPs3ZjOdkW/247SqNZfYd0XQGWP8OiOwF27hjCnmSpV5vHbupGvyzVeCwhUST/Qh8/m+Yr1hquWk1ofxTJPFtCpqOrP/xVJgP+sWglkRR42pZrlfutSipwokGGTc5CSiLsdNbmHSiGwsk2Q4uqqs7S+XxGkVkQfHzewUfGa5f2RYqJe1jY8i8oXj4QAE6dIVd8stTq0dMaHDesREXDa3gRQME0hOhLZSne7/RuWb527+iYteIUnA3WjO/dyhAbS+tdeaYyjWBfnvgWak4hdr0zp1gPGTEFCTo4WwmHrXHGgX4knTXiFsRej85wV5Pw0TcKeqTxyX1H8c0BwVr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSf2G4JwtivsU8WcnNT0Tj/VPRfv3310Dev63tbzTME=;
 b=JMVQB9KodxpUfaEDQr9TP8nmk2cBvqNS0rZBooJCryAUaKftnAuhSmHt3YfIRjqKbaW4xnIF/v1Mz7MUAh9vJBl4+hBN3M3PnNeiLfL4Y0/b6o1SKgZNeaBIBiHJEGF4uU3tkzD1sNQDqg52AK8pwUoEmPAQ5wZCZ2MiIbbDVlgqkMYRPf9xYoiPUITb/uxjaGPCc9Om8JSLnTWpEbmng+MRwix4VvyBnHCv3zLQnsGQr/lyMcnlGnKjq1yQPOp143cj14kssQ06RK1dDYIcZMn4CXMpyi3/g4xKcWI1ch3EZHh/+lmdIlemTEhx70oD+nlUFVXuqmpn4c+X0OV8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSf2G4JwtivsU8WcnNT0Tj/VPRfv3310Dev63tbzTME=;
 b=3thS45oOPFcNFxNHDTtq1SON6qkeLjI7dZ9y1Ce21+7tOcJLwy6d6EUOpaMTgRV9rFQHe9Mm7DtIA8tYS+WWQkQnfh7Oe8g6N41Sbm/bFqbeYp+/vlJQBQ1+LBrg34/56u9ZmFbOWoSNINbwwrgMIdYd2i5NRoLkDZHv0InMxOE=
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.37; Fri, 9 May
 2025 15:08:16 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::2d) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Fri,
 9 May 2025 15:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:08:15 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:08:12 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 10/14] cxl/region: Factor out code to find a root decoder's region
Date: Fri, 9 May 2025 17:06:55 +0200
Message-ID: <20250509150700.2817697-11-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
References: <20250509150700.2817697-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 86604793-0a4a-4564-9f84-08dd8f0b5300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GCWZcFsIMiRHo5R8GuyOHF5DtIsQ9BmAiTPfTqJRt4zbXmNTq6QXTeqSfA0L?=
 =?us-ascii?Q?Y0jmNKRoVPd3HwoP4dYIhO/N5/IL3hCzWOLvsas3yfYzhxgIodzZNacg4vQP?=
 =?us-ascii?Q?FQwTtlJucwVALymP6goG7VGZmuUrFQYM8p764USJUC+9GgyM3lspSOluGjck?=
 =?us-ascii?Q?cAYx4SykshTRkteUxdV9kGbcQiAJqnZfKgeRR5W6DcWF8SxawvyUHrT4fsL9?=
 =?us-ascii?Q?N1NRPDgufvZhwSv8UVl+SPTuLcaQvlhmf6yBL8Y7R4Fv4/yfr6v9Ns9X96pf?=
 =?us-ascii?Q?C2rkWGyAYjHFjb7kN2YImc1kGaZVoA2DYGh24aVcXcsBM5ENMT/eaFiv4HZm?=
 =?us-ascii?Q?05NtCcPraDv1IQ7r7x87ZdfrPeND2/RnaluhC7AftHTgY9ePVFM6Af1JFc8Y?=
 =?us-ascii?Q?MyJWsziKB4vYlibxfF28Q36dPTrQYzd/jy/ppyukp5gdwPpVoBmzUQ0RVew7?=
 =?us-ascii?Q?E5MS2bZtDa6TRfstZr9bJEiVlK/V0QNJ8zgJmLaeMJrGtOXWtW91aoEkUL4a?=
 =?us-ascii?Q?aizWDpcoLAKI/zP05qVkJcufSOzTMvjcQ0gxinBO/hmymY/dmalym4p76yo0?=
 =?us-ascii?Q?47azrqrhjxU+uJ4Iye66ZqfgWc3ZVgvuSSY175tHu5zcc5umiBqqGmlSyRmG?=
 =?us-ascii?Q?VZvC288PSRdqVaVMmdSeh92/MyaQY2VpOFNlTcu2/da/TauFzBSQ8PuV870o?=
 =?us-ascii?Q?AuJjgZpxLTTkhl/v3s1T8NTe5QNjccH45Prxvaa8wlYQf0NW4onbed0rhSfk?=
 =?us-ascii?Q?51F1soUoRkWRBUkTEMcJcbrp4GZjEVu68zIIu6UCwkKj+ywFjZ61f0hlz5os?=
 =?us-ascii?Q?jEw1SMZVB64PsZUxA8di4hHnvPrjDOntohTKn1Wfkz1voao0x/H9ul6DPUG3?=
 =?us-ascii?Q?+03ubf6kGiNc4JzIx43dCjoHFIG7rRuhFpzXVdkoi5uUYseOOSlnVW5kmVaD?=
 =?us-ascii?Q?0iWSUvqeTh4GgLH7ZXZrgd4IUDubSuSxFB/jboDHewEQH8SbaCQ9HZ3EeBOF?=
 =?us-ascii?Q?H3i1ZvKLibfHkXIWpj+0RDx8sk0WKb5XGXAaMtYkL+QWuvVr8Pj3A82OJDwS?=
 =?us-ascii?Q?G28t1wGhnAN47DYY0yZjJYQ22YPjbOu/af+7Hw0KflIQ3pHlrizS1Q1VRmTz?=
 =?us-ascii?Q?CazZRJcK/J7X5kmw8FPJM+nAdz8TpoGYfSU+Aeiyjh+rnv6TJON+08I5aXZs?=
 =?us-ascii?Q?zly4U/xgIWt6j+hGgXxEAt/LBKgqvzVOvEVkIuguuCY4LqX6/PGfgvfSWMea?=
 =?us-ascii?Q?UfpPB4eodIRa0s80Y1xlsIqow4lc2FPJNpTjPRFoi4Kli89s58Ihy3Nr/R/1?=
 =?us-ascii?Q?W6f/W1SWlQbuirgOgtnqf5mP7ndECzV+ecb8YjjfwmmRqmwmcqxTmUug681K?=
 =?us-ascii?Q?7P8LXY13U/C2zk+PHP+Vvm6CglJ9kGreM1cX7SJcsc07+nvmMYRUmentJ50D?=
 =?us-ascii?Q?y4bmWfjavATSOPWquG7dBpX6UE+aPLxb0ig9DYYmod4Or5OG+kAcslffRfez?=
 =?us-ascii?Q?vv2ZtSFe2ZOyLhqNXHD8Vd8UVu48kz3XTgvf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:08:15.6010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86604793-0a4a-4564-9f84-08dd8f0b5300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

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
index 45f5d2c7dfdf..8fdf03058b2f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3405,13 +3405,25 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
 
@@ -3424,13 +3436,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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
@@ -3455,8 +3463,6 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	put_device(region_dev);
-
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 371f9dcfb61a..ba08b77b65da 100644
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

