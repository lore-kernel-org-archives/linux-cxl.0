Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E338643B;
	Wed,  2 Sep 2026 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327550; cv=fail; b=J7m24ULhbdzWXtb4Y/Ateew9hFPu1MLA/gRYfz30Uf+cNHc4xR+CS9Bcsz9r89eSWKK6ygAdf+dhdDKvRe90a8lDSi+rLV2/UisEPJ/m1sFQCmtz0rhqLo9iWqsDv89MZt1qkD3AUlNpMXfhZaAxrdlu2R04okhniPMzY/IvO4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327550; c=relaxed/simple;
	bh=v6V+N0fmGA3zOXnutNojTTuEBsBbCOjFOATkAi8l+lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9axi1L3zipEEeOnNMlgsXRVwQ2NLlcV655gjBTqEWnKttUpaqq2ClI5tUDRbqYkrcvM6v6irwgkT8o8Yj2NQjHnnoZNFk3HmTRgUKeyAsEhqLuMKoG4L17ayQK3RSH+rZ9pNzHjGgfLK0tCLoBCxvWLp9JPRawm4DedbReUexg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PwSgw1we; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PwSgw1we"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0cO23hYrwZkjPg4VDC9hbBXUtr8VEJuqfPE0gR4gAlBytx+U3POQBJ8wKWqPr0yDIrJ9AR4oqIY+qIm6Dj7uQbDbIfO8p0jCT7RGQsaRcpTZ92BzPZfZjYC3HPVAheL0TaN58d7hrXnN/4J+8w5NgxL9I+Pc5FBHsf6y7xygX1EJ7cEyu5ZZMOY+fqMVHzuYxXOMEYo2X6ItjwEacFbYfWi44durEBaF95SpjJ+6CGzj6bV0YlIvnAMOQ5UNFqnMI/QjOkFnAbXLchu5ya8D1/G6pCM0YkeWgafNTkOo0UxJbwry1pfbI/7WhWc17zaYSSQh84Thi+c2oWfeVpp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYupqiA38ZwvDU+FaF3g29r6VTkwRS/ktrIVV8LWocg=;
 b=UAVXym/b4RR+HYFDGtHFDMacCDGs0w+4XzqP9dcY+nriq15jAxlfdIDKBggNVLNpq0i07IrS9RFFyDDECljnhKvnLvKyylJKs9MeKcwnM1y0nGpw9SwAJG+dBG2QXkki3zD452tf1LMaas/8b/nOhivO2lLE5tsXiIAXrSfOK1TK3IbEyjo/7OJgp0M2fT2DqvPn/7vVzaRDntMBe3yXAjjg7bKNSCfS82beMH7+txcmkiQz1LDUP2Wc1CD7E4Hto7twtqlWa3Wk2leJGO5TrnBnmK8xwRUBzSyLXBe42yqMJGlk8pPmJ3jVRS4eJxwZc6ECfwv5w6fq98QE/4VawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYupqiA38ZwvDU+FaF3g29r6VTkwRS/ktrIVV8LWocg=;
 b=PwSgw1wet0cHhi1BdPV3a2Ns1wbgjoas1mb0H3y2IAppTlJsXezWMLW23LLnrMeASzg89BG2u5stfhOqJhVD5Zgf+fPOUdOfQD0KfyGNYKnU4pqtZ7NqXPfklC043E0lLDW5Dr7s9zCwX2HlsvUB80X9JDK183GE0uwD2KSDu+p0pBX86JaYz6wJRnkrj+jslHXW/0sq6Sk13sBLWAdD2di79UW+i1uVC+iCqvtqJGA4AOl4NE295IE0N3+/zc5lycGaCRVoDEQC0QYlbBcsNm8HTcEs54GTS65AIcf5FKVmAzzeFInmcY1MyI7ogfYZZU5A1IAIibkiNowgQ/c/ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:39:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:39:05 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v7 2/7] cxl/region: Scan all partitions for unmapped poison
Date: Wed,  2 Sep 2026 13:38:34 +0800
Message-ID: <20260902053839.25595-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ee9e27-df9e-4a58-80fb-08df08b4806f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rod20cNdzOE8jmK9514OCXDjndVmKe6plT2GRW7jl817u46oV7nP/dp06fy5OvZEAiUYs5ZzUjm0K/R2r5HWyNkUulIfBGLokVk3WjF2VHV5cySAH7TxlDea/x7wvgJZHuNdGGjqFMVmY9F5tYIcTQ02KB4YXRKNhU05B0j27oOw3jWx8MOTaU7m+AhGtsO6QE9kVC9jhHGg+pU4qwQSW+GI9FqTu1/M/xbcAqW1N8DpuVPdHmzr34Sv5EibMOcTXOloOq7n6bnygFtKMGpaZEEA1I067thXG9nu7KoJVnPHEMlhlDsXyBOaMF8ahcMcVSJ7KhbQ65m0knNIKZ2mGri19onAjiHwT03HlNNefhLBqDTFTjYxH2qMunvHneHhYGe8VOQQV/OKt+aeP5Uj/p9tqk9McnWzdcXjvF1iRTPnXXcoexY9zCNiFtgM9oKrLbYrC9tRXBNZVpPppxF6dr5Bplh/wKENHHZSBy6No+RskNvH1IvnzKBTMdYZRhs3h3m03f5GwmHc6ToMyJGTCmXC3t+RqUOGGtf/iObg3D130v+jCvMKwHk2/DclE5YFGhVmuo5Io0QBL1pX/B/e+DF79TYPykrVpWf+SGtDbJ8kuzn7PpNwCZNx1r0uL7XoO5ODy4SXPi6HUWMnVwOfQEmsQ4FMtNDSHsfhyMYWufc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmZbBBgRpIywyG8Ao9tDRScBnvruOmpAHfAMUzo2ekiTTV3ZfaWxcQOkFqXO?=
 =?us-ascii?Q?sYvs/caeRd32prf0lHAQDk5li7qTHf0WyjfjP6i+ouUo+/12dcrTp66eIKHQ?=
 =?us-ascii?Q?SPO6H92nVQIJpJvvZ914oFTaoBi+ONQrw5NVPNZGzaKsDuG/JVrH4zvkWfzq?=
 =?us-ascii?Q?LNKFFZwyCXUn9JirqVGCtVvXubOn1xW79bPl8fTzqk7j88JKm3X5lOR2NRqi?=
 =?us-ascii?Q?NCFO+HVD5oRH0r/QSkIcds8UOhr/YcxRB1x+1wwC0xDtCkb23RhS/KqGxWSH?=
 =?us-ascii?Q?dA5NAUAB7EhjRcNmLIEG8jN9L02zFbzBiyBVEOaJNPcG7AD3LZtNHbF5baib?=
 =?us-ascii?Q?25j4giY850q/Fegw5hnqu6er+zT2rOkjzk5U8UCgf4P6eb4baGUMnKzOjEGh?=
 =?us-ascii?Q?hOAaq+m2simnb4DcviP8hNkdaRlJIHHAbc+dw0h1S9llgVqhWuKCINfqH7EV?=
 =?us-ascii?Q?7KvVVIOiq6eQOpQFB3YQ0AB7T/lmyey1fT/eLTtZOb+h2uv3KdOMydtjeBRi?=
 =?us-ascii?Q?WSEk4vf4zwS1NJkDGZlPoVFo8dkCFWSlNvH6XTEv1dtpYRSEh1VIHVHrNnr4?=
 =?us-ascii?Q?tngTHdB3iBjMev/erpXqF/b2OiXG5C8PRXCeJgYqD8pnH2r7lt56DFuL8T+P?=
 =?us-ascii?Q?2Ke9akG2GBTdEystfMDwSi9vKf8ll5ocpO7t4+8Qgyb41rijuS4mUzV6fnz/?=
 =?us-ascii?Q?Pv001NeyEJQrcwMUzFCpDHC8CqvUM7vUVi85N+lLxq+hr4oiXf9NRM23Dpsj?=
 =?us-ascii?Q?n+FlWHpCnqnz61oalhbS8coE3wF9VvFOhTGiRowbNqu8gow0OwAln8rRs4ad?=
 =?us-ascii?Q?/BcXdGl4b2sRaOxaxH4B0qjvK6T2Ng4sb94B1s9Er3FP4npk5o4ap1RuXyBg?=
 =?us-ascii?Q?hNkszoYM1vAi2uDLsfmH3ov79xbCGO3WDDKDgbfTRWWb/6IymHwNdE2zRDvq?=
 =?us-ascii?Q?trFWi2p0qe3jklgLMbMUMswj0aciJDznb/lDXGlYm6YaPucw/bcbx6/mnj5a?=
 =?us-ascii?Q?T33Ibiw0DsYFn+2EtJOrAOjxev/ph8gorVj6xlFtH+i62efPGdAJJ28Ayw5L?=
 =?us-ascii?Q?p7LaVzQ0lSJgbvIHS83qUu1miG+Oz5XNb+jYRItJKCSDFMCGh8rF7wEW/+14?=
 =?us-ascii?Q?b8wfo0ebQMoa26WQQe4whDzAW0su1i6urcmV3GQ3+pI48aEvPzCEU18pTNfc?=
 =?us-ascii?Q?fEeoTAQ9mKBI3ok69i0LukQ3iPIIIKbJKKKz1h+LZ8GWhH9hAoz7qZD29dp2?=
 =?us-ascii?Q?Gf5W5NpwjYft5LLDrgeDHB5mKHM5TCamBBDaZCqHVZrVWcfO5PcUOXYAdYj6?=
 =?us-ascii?Q?WTjHhNUXV3XGsRsiHCImu38A1Kewr2jdOCoORkHJZUvJh/fpnCAhtwvB+B/d?=
 =?us-ascii?Q?DsTRQj7AKwsSf2GVPsXFOxlBaokM22obxk5RfKVC46BzmUIPDqVQt88GM0Fi?=
 =?us-ascii?Q?vbCwon8kMTpS/GL9hCHn9OSo9uzCOT9tm3zuNgKlv9pc7fXJBrf3MqrsiIur?=
 =?us-ascii?Q?e2Wn750cBtuH5ssHVJCNwtDDEdfd7vgwLW52f81pFsPXp/MUPawCD0j0TYkB?=
 =?us-ascii?Q?gk9u+QxvPb05wA3tDwc6Ab5bvANipOL23vNs3l8vvDAJO2weJHQqhJAS0sFy?=
 =?us-ascii?Q?dZLjUT74AMq8qJ5HwhpYCyXipFPQ0y8peHxrDne9ll5BJjvHrboweLGBIFD7?=
 =?us-ascii?Q?KasjL5DSLAV2PB1/RWr1kO108lcqNE8Mg0in97aqLArmYge1Z3VTU6FLxumv?=
 =?us-ascii?Q?d4pqR//pVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ee9e27-df9e-4a58-80fb-08df08b4806f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:39:05.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HBqtyNlxYgG+ZDsZxybKx8+V64JBv4GbsegwJvA2/0DpHglNgwtwg+3T7gCIH7KFFGGlIe9LaykQsDfquv6qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
from ctx->part onward. A fully-mapped partition has no unmapped tail,
it's a normal per-partition state, but the loop treated it with break,
aborting the whole sweep and silently skipping unmapped poison in all
later partition. Use continue so a fully-mapped partition is skipped and
later partitions are still scanned.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..b03f30c04d35 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2928,7 +2928,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 			offset = res->start;
 		length = res->end - offset + 1;
 		if (!length)
-			break;
+			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			continue;
-- 
2.53.0

