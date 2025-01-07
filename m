Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F511F76B7;
	Tue,  7 Jan 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259101; cv=fail; b=dnfllQ0vskVBBanoStdDKw5eUmAUUqHntgsEIHXOtvdaDkBYrvi+PdiZe1k4Yhx15CGI3Yu6vIk/FceV93LmhYE7nxCucyqNzK8ASrtS5OHXrUFFPF+qI2lqCIYEKs0JF68d5B5QxSjiSqu2SHd9HzgNcD0FjLqrgyNzRL+UvBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259101; c=relaxed/simple;
	bh=64JuMkWp21qv0GM867D7HHuNu+CTe7sbi441kHj96SU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcrJuH+EkHNyhWP/70UwVYgoeM5pvMFNMjUxBcEpLaogWGEVMoJFOXS3nKovDbrF34AIPKiOfAT8xOySoz+4pyjOfcrDAKSKyaSaLnzC6M2/8SfGjo3MMSZ0pw2P9160ebf2VuqDDlyM1LLwZmUyRRC3Q++cz7yB6hcew3sJXWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TMG4a0nk; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TMG4a0nk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhPVjLbeFyBkZUKn06IiW2RaEGjj11sOxmDZ0QHp4cMznmtiuEYNwZi0DDzgzoKu8RYrgcDrE4ONsOw9O50y+wl0hkm/EoyR8+U74tt3163mOFw0gnstGP98bQzZzm5zYq99HS0bcJ1GCinoDFyZEE/6heykseWdaKDfwpV+w82hvl11rTNPfP+3mvMKzlLXFVx13ex/+bzSgmZYP4Zb+YKxVBaxw3io9ZGDNxHECofWQqtXIXYim5i4m96om4YCK83lUVng6UAL7kbdJ1hjdYEvTdUS/sugUfr97lE1DJlNOkobey0O6K82D6fRzhSLrDnqf6dTzR4pr5SYK8KAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqZiwzyq3Cf0DQuWSz3drRrmfbHZYz6RHWV8ZxR2p28=;
 b=f0p3UZ3Jopsna5huaxkzCpLg4FkyUkNSZ5xdf9DgMemUm+6cJf4BXorNTFx1CCuvxEfhDSUmKIUUdg7J6lafg2vLxondB5HWMqYOA+FKOtzwLBrIb6mND3+aitGHsV6DV+TL3vEyyPPfOB6kLMc56gqzXoKZnv/Pe3zehzBV7jiNLLsNP1zvBhbgElR1zZXEFUWS0zFLTwQanT4Nww8jxRuNIzn+n1WLQ80n+ih0jGB9vGUTqyyW53H2sl3OVHv0aydyvhuA8uOIPsrHyiGkREByGpbALdfnn6LNMqlhuUdD7ffht/akA1faLuBAF2D2mkLWg5maH5YuylnrJ3P/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqZiwzyq3Cf0DQuWSz3drRrmfbHZYz6RHWV8ZxR2p28=;
 b=TMG4a0nkLf8BEkgOpzIeTiDoFfyx607kVihjSlVH/MOyq+oXKA0fu4SOE+hWat3bEVP6r+u3AxTOxsvJMshB9YFEeoXW+Vk+jtqI/jgU2O53hHFm8GwnGg8LmHXNHpcLGNtty3wap3EXlsIxTmoEqSJTeYJStSdA9wGvHBdgU9A=
Received: from MW3PR06CA0012.namprd06.prod.outlook.com (2603:10b6:303:2a::17)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 14:11:28 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::79) by MW3PR06CA0012.outlook.office365.com
 (2603:10b6:303:2a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 14:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:22 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 12/29] cxl: Modify address translation callback for generic use
Date: Tue, 7 Jan 2025 15:09:58 +0100
Message-ID: <20250107141015.3367194-13-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 55488605-f73c-40f7-d5eb-08dd2f252d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CyTFYb9hJwR1aT9UPWdzJjKCsxQB/UH5aI0Uu02uchpv8PLxBfuKofsnUyy/?=
 =?us-ascii?Q?PyCS2tbT5h/PzcIFQ6ObpcXLiHCAewWA1GcQZRrQg0FPbGwMxCDdTxHNhU9A?=
 =?us-ascii?Q?URr4M5wqZ1fneT7MHCKB0W2jWRK0gmo9dNBjelarDsko8a5KZYBa8TE4fPuE?=
 =?us-ascii?Q?nEaXKlajVDnk/V92lQHVqSTSrSt6EXP5CeQLujYUOiJhg67Y57HwVLUADN/n?=
 =?us-ascii?Q?RB/7e/J+QcLmDKZ5kySXLzts4NQLn/r8a6ClnMCCsKqq21z24EnVxkO/jMhI?=
 =?us-ascii?Q?gE8ihzdyb2W0iByf+dYkUKng9VzAxIiLbCF3kagyw6Z+maCPMYCu17AUyfXU?=
 =?us-ascii?Q?XDIeVPz2SZ1BoEmOpq8PmWGNK1u6B1ZOUs4OPJtHNF4AZ59oyZi0uXRE80bl?=
 =?us-ascii?Q?Ze0+TWBfitywJHcYe4av/ZxVzuG0UTYl9q32zq6BA3ienAqXVObxSxjQyMWh?=
 =?us-ascii?Q?Se/bgCZp/9M9yeCP83yBWirYv6YxW/1P8gCZClEfT3Azil4drgLiqtIua3G4?=
 =?us-ascii?Q?QR0UlUOwyaJPlcSadrjf2FUfRxcWTG6zwmIF3/9LaHv7JRBH3cz+mZTSk3Fr?=
 =?us-ascii?Q?Uzua+DP7EiDMFhhQxltNm22wrZt8Pn+lRHSkQY3DrX2MXJzuEzf05bCoowna?=
 =?us-ascii?Q?9DO39qejy7eYzO8tkFHSOz3viLedlgDt4YWrLwi2Bm/zdeQu60v+jD03EqUr?=
 =?us-ascii?Q?mfDVXGhfbIozvgnohm7+sMukjZVPzOB0i7QjsFacuAylvMR6yg126lASW4vD?=
 =?us-ascii?Q?FDQ5ZWCor0bYF8gRM3S2M+3sN8g7er9ZG7JzLSzRjMnRX+OjrYuMrzS2EjU2?=
 =?us-ascii?Q?dR8YdB74mhQ24bW+d1VAKVYuisrTI1udqM53jti0sjAxm9TahjzzfGdMcmNL?=
 =?us-ascii?Q?fLW0+BbJOdtpcKrLGnlBojqhQjXuZzkFjDHTznzr1pMOaDtSdGGCvCOmfFfM?=
 =?us-ascii?Q?Pn+YCv7/vGY4tsioC1VqQWEjnxae/X47Z82f5CFI0F/tIWAQHeRv1glZ1wvJ?=
 =?us-ascii?Q?3PeoWYKJ1bq6eAH3XLEe+qWq3zns7QAI93q+SSOZTkgKMNHrHvXGs3wzEdGF?=
 =?us-ascii?Q?FG+RkzviS25+cAg1XJWgnq/ED8f3EMXNZWwTOtmL/uW+3T4DKTJlRltlRp6q?=
 =?us-ascii?Q?UIOC0oZzDVDS9uE4af5o0aUQ4bDwIoUfO45o3oj6bp1M2+OahUDj0eUZTFE+?=
 =?us-ascii?Q?rnAKd6ET+E8wLilwtcS9gq8GVWKZp/ortLts8TC1he8Zho2YdKSm++sFE7V/?=
 =?us-ascii?Q?XVnb9WJoIs70yZu2Rx/4Ef2jjT6eTmASQe1bTtoIN8zQuMHiigBamOh56+mg?=
 =?us-ascii?Q?QGk48T0jDfJx2JS1gkbi48pBM4nTCE1MhlX59HHV4jS+i+RitcaE9lXcbHMi?=
 =?us-ascii?Q?n+xckHlxYynm9O0vhZ/fgrqo5oYVgtfgK7yJbsDHl7PyMhdCwQNDDZ0UqGas?=
 =?us-ascii?Q?lkdds/9JbMlEiHTRYoP63SYJ2+8kOM7ZWL1RJ6plJrTOo7Fq3Go16Ytz65ZU?=
 =?us-ascii?Q?ytT3GwJch8o0Ph4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:27.6270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55488605-f73c-40f7-d5eb-08dd2f252d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762

The root decoder address translation callback could be reused for
other decoders too. For generic use of the callback, change the
function interface to use a decoder argument instead of the root
decoder.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c        | 4 ++--
 drivers/cxl/core/region.c | 2 +-
 drivers/cxl/cxl.h         | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..b42cffd6751f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -22,9 +22,9 @@ static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-
-static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+static u64 cxl_xor_hpa_to_spa(struct cxl_decoder *cxld, u64 hpa)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(&cxld->dev);
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
 	int hbiw = cxlrd->cxlsd.nr_targets;
 	u64 val;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6fcf56806606..9443507ed4e1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2925,7 +2925,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 
 	/* Root decoder translation overrides typical modulo decode */
 	if (cxlrd->hpa_to_spa)
-		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
+		hpa = cxlrd->hpa_to_spa(&cxlrd->cxlsd.cxld, hpa);
 
 	if (hpa < p->res->start || hpa > p->res->end) {
 		dev_dbg(&cxlr->dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b3989dc58ed1..be7685fe8a23 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -443,8 +443,7 @@ struct cxl_switch_decoder {
 	struct cxl_dport *target[];
 };
 
-struct cxl_root_decoder;
-typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
+typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
@@ -459,7 +458,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
-	cxl_hpa_to_spa_fn hpa_to_spa;
+	cxl_to_hpa_fn hpa_to_spa;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-- 
2.39.5

