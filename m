Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD2221FBA;
	Fri, 14 Nov 2025 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080028; cv=fail; b=ezbhUsCJjw56qg+AvD+aQSLkzVnBNF14yxN8Jns7+838qbi0+PQfJuvUb/r8ILU8xAmWwNMnlUDCdKS6XJo5UukehwMj6mOA6K32KFbeFy2UGNoi7c0QanQ2fCQyEQpMCdap51CNOeCbEiLi21LZ1j4TUHeynohPL15IAJJkb0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080028; c=relaxed/simple;
	bh=9jkOMIC5tcU/+RJ5phcQSBNg9F9lhE1q4X+PxjWRVSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTs4rms+7lNwDztnAck+XKRwar4DoKnunKLjYA/GXlrNJ0MePVERd5fPe7GCze/ZXSYPsMZHT91NFuQgXKgg1D8NWPgp0OeMns014uKpgW5haB7rl2Q1OpTELLXvnW9p+yXaLgyN3j7oI4K0E5dfaAifUns7DKhJfR6dQY5yf8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kuOLPM29; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kuOLPM29"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXdQM+hMU7YPJgP1GTvUXAmSpuUF0SCefHqWjqHg7ADM1yWVTWHqAeSDr3XE8vreGDa5A9w+y7jnkSGgrU31XMLTHxPJbdonVAvBatjZLzUWgD7JOcTeOrjJXMimaVhvq/DAXm1KBDKOFw+94GNeDPbKPOdcSwTaMk6BRU0PjFjhfy7Tn0mG1COG8k6Bv7n8+C6llD9RKcrByidRL7wSOCbOWRDViKrJaq+gkOTRPlU97xmn7VaJwvj1bXNOEEZHXAdJvXCMhuVOhdiYVa4RVgwmGcjMVoSCdu+WeLIiKDU4Yr63FDzGl9uHzFXxBbMF3q4FmpLrhm4y2FO6zEAY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnT94NWXXv7D3BznwodwKzNz8sS5Wa79yqnXZQpXqGc=;
 b=sdeYOvMeYyvsQnmuW6L8M6hjIXdyO1TV42gd95UkhrRv2DE0O0LhvZlX/vbi+Tc5Pkjq2MB/oc9KyG5oflGEzxB3Tnf/WhsczhpX4pryLu7qxMoAN2DOSfMISalI0qy33m6E30OPl4vFEJWNIzMrvGXroORtsMfZqO9X5EClRxJsy5zr0+EnNPcE7i5lvGOeg88R+8zu7Qq0XTVYnxPgJ2uSHH9EW77+iA38efbEVHqhggjpxleCzUbq8sXf89Pdue+jCUy28XfwM63Lkr7ugUIMN/AdJxdd2JPEAeYGp8BfK3zyV3FUcFV14QfFl9tdIL1rNClXR0NR4f/8v1fOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnT94NWXXv7D3BznwodwKzNz8sS5Wa79yqnXZQpXqGc=;
 b=kuOLPM29i16d+dOjCb1ZaOJ7KUmmwXkEjjhU8QG6JlY86GMOQsPLP9pOjTc9WkDW3G6xzk3c06ESyKQ0oqf7Ml7VMYT8iCtDeqB6pGDqsnMMz3V8/nZEx2NFAatW7ELXFwPoo49yPTrPi63LIeG8BgNQi/xZ3iWZF76wKAR4eNw=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 00:27:00 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::cb) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:27:00 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:26:53 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 1/3] cxl: Simplify cxl_rd_ops allocation and handling
Date: Fri, 14 Nov 2025 01:26:28 +0100
Message-ID: <20251114002632.1309139-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114002632.1309139-1-rrichter@amd.com>
References: <20251114002632.1309139-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9002d60f-22f5-4b9b-3d6c-08de231486d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?opkOOOs3sCJYRHlU/9yV9wNkjuqMlS0gl5F4ie/HQ35ty+TNPnH/uzWBQN+t?=
 =?us-ascii?Q?HkDQqqeDfy+PiMeidc56hNdWEkNFOSDoogqGEgVZCBSPv3IpBAx6SyY7tiSt?=
 =?us-ascii?Q?If322AbzJC1d+2YSVDxzpB6M0pRGmR8ios5bLBbHvgs87NwjjqkDb58EI54R?=
 =?us-ascii?Q?BxMKigkxPTc0xj3e6lP9dZI1oS6aQNFWmPd7Hz368U2uDP24oHPuIQrwLDad?=
 =?us-ascii?Q?KVwMEWoczjurNrd5pHnLsCcmANIxO/PJjILWiWUxVsSue865iOQADaGPpr8m?=
 =?us-ascii?Q?DR26WtsWaXikIx0KsGYY9/ANTwh36xRy4a+IBjl8nV9N1KbEmy08vWkJ6y+0?=
 =?us-ascii?Q?P+9ImCb2C0QRh9gvaunyuSWj3yKAyDRIOmcMe7TuKwSBmii/6/iqkn5mu3OL?=
 =?us-ascii?Q?1BFJIXllTBXrKKg5JVQTf4tcgb+xmI6lhD6JnLpR4g9OrEA4lhkGH++MreLl?=
 =?us-ascii?Q?RyjrNhjX1DMpM6GROrLgyAJoyhjLiO4JrO4Ft078NirOL5nQWMvLfG2byH7w?=
 =?us-ascii?Q?GR1kBNpIAJ8rnYeW7MqyXjlzgfGjY1m0HTAZy/7B5IK3QNvsm2LNE247aWX8?=
 =?us-ascii?Q?1ydnLJZZvWlOkTLMqgIQ6wGgocVwCgSvITnPO7Ln1QuachFU0A3ikM6g31SH?=
 =?us-ascii?Q?xFM3z+nC1g3pw2Ci3rQ80iZIBU0kqogk8V/kKtM7Z0i1eYJN2fhBodj3BPGW?=
 =?us-ascii?Q?GhokOYXOhyP8Nfl9FT8T0QyXlyx6exRJ1cZgFylKjOAkOcTTS5Lg5rAwXwk+?=
 =?us-ascii?Q?3mSGmF3ufZ7kxm8od18ghNVGQ+fA672yXfQnxA8IswA+gsL2WV0NXb/rvwwg?=
 =?us-ascii?Q?eyPdhA9mX67EayMoEAjR7JkfnUUfeaX9ZngKq7HspTcvEoed31IHOLcpPJ2w?=
 =?us-ascii?Q?A+bVYNK3q46lw/7NCBGa/qaLdB9XM19p50mLNTtzAU9LibdJUQdw5fPsiPar?=
 =?us-ascii?Q?VPIOw+Y086X9VCzN2+Trrj5Z3NUN++weogtwOQlo1ArUt4Hp2ZQmmtqH2R+Q?=
 =?us-ascii?Q?DdeBlLg6lFWSG9Yzjtelh7xFnT8zwT+RHiAKjgn8XnBj+q3DSfVyxMZYeEUp?=
 =?us-ascii?Q?QI58EZzDATNihp6kbjII62elOo2lC88uM+0Tj+X1rimKAHLbYjtybY5DOfjN?=
 =?us-ascii?Q?CDl0CybX9kvvHl862jOx4oJm8Z3fCU7fHj5/ze/Cwf3l97iYIQ9T6iawBqOA?=
 =?us-ascii?Q?6vVQOO13OAkXj8mXBY5UdbHW+agQqym58TpKuOL61N1FOGEzxURmLPs7tRzF?=
 =?us-ascii?Q?ZK4CGKxjpqIaxqulEi0WWaiEDROEtQ1g0hfcQuMwEWTyH8uUSj6W0ugLa2Qg?=
 =?us-ascii?Q?0lzGq3DkXt4NXrJuGEBcKWntx0dZNvxwEEJf8u1OMpfrQmZYFQ3lB7ZZvAXf?=
 =?us-ascii?Q?lIl416WmXYplA5toK0dEFqKKLpRZwhVWm5vUQ5ciVC14Ky6i/nKVqxLd/Utk?=
 =?us-ascii?Q?CFAhuMnLnvXWoZZHoIwVuEgxGi/1iIc0udjWNuyAGn/hJJ7m3t1MeZeQHWXx?=
 =?us-ascii?Q?6aKg5MXdSbGyizy6a5xkYJCpyCRGVHkECkcJKIiiSHDmWaHmxKGT9ErNkDaR?=
 =?us-ascii?Q?xRTCJyC9lnRixhMLmgA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:27:00.0807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9002d60f-22f5-4b9b-3d6c-08de231486d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

A root decoder's callback handlers are collected in struct cxl_rd_ops.
The structure is dynamically allocated, though it contains only a few
pointers in it. This also requires to check two pointes to check for
the existance of a callback.

Simplify the allocation, release and handler check by embedding the
ops statically in struct cxl_root_decoder.

Implementation is equivalent to how struct cxl_root_ops handles the
callbacks.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c        |  8 ++------
 drivers/cxl/core/port.c   |  1 -
 drivers/cxl/core/region.c | 20 +++++---------------
 drivers/cxl/cxl.h         |  2 +-
 4 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index bd2e282ca93a..cef3e07244fd 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -475,12 +475,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxlrd->qos_class = cfmws->qtg_id;
 
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
-		cxlrd->ops = kzalloc(sizeof(*cxlrd->ops), GFP_KERNEL);
-		if (!cxlrd->ops)
-			return -ENOMEM;
-
-		cxlrd->ops->hpa_to_spa = cxl_apply_xor_maps;
-		cxlrd->ops->spa_to_hpa = cxl_apply_xor_maps;
+		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
+		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
 	}
 
 	rc = cxl_decoder_add(cxld);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8128fd2b5b31..fef3aa0c6680 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -459,7 +459,6 @@ static void cxl_root_decoder_release(struct device *dev)
 	if (atomic_read(&cxlrd->region_id) >= 0)
 		memregion_free(atomic_read(&cxlrd->region_id));
 	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
-	kfree(cxlrd->ops);
 	kfree(cxlrd);
 }
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..095af0f4760f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2924,16 +2924,6 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 	return false;
 }
 
-static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
-{
-	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
-}
-
-static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
-{
-	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
-}
-
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
@@ -2988,8 +2978,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
-	if (has_hpa_to_spa(cxlrd))
-		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
+	if (cxlrd->ops.hpa_to_spa)
+		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
 
 	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
@@ -2998,7 +2988,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	}
 
 	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;
@@ -3033,8 +3023,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
 	 * CXL HPA is assumed to equal SPA.
 	 */
-	if (has_spa_to_hpa(cxlrd)) {
-		hpa = cxlrd->ops->spa_to_hpa(cxlrd, p->res->start + offset);
+	if (cxlrd->ops.spa_to_hpa) {
+		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
 		hpa_offset = hpa - p->res->start;
 	} else {
 		hpa_offset = offset;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..6524b242e8c4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -451,7 +451,7 @@ struct cxl_root_decoder {
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-	struct cxl_rd_ops *ops;
+	struct cxl_rd_ops ops;
 	struct cxl_switch_decoder cxlsd;
 };
 
-- 
2.47.3

