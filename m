Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D6435507;
	Wed, 12 Aug 2026 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533712; cv=fail; b=KdJZsTKQaa7wAzNwkRQJ6HplQpoSQGCTVeKvvwrRaNHTTW0kSjRyfSQRvqeLfEL3aBxonlwEU3nmBS7fflBug6p3/OTUY00Uq2R+jlU2R9wxMYI8wIhuM+wCvLoCadh/FnHnZTahBLWnjlL/UKWmEhZf5R/nxslLNgHvTXSHIE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533712; c=relaxed/simple;
	bh=zBsmORreD2h3FKYFKes6260lQCIMBwcEsrpBp4p8AVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+q8IzUbbsr3wxonQp1n2nxrXFhzb749JYtcOOLSPyFHybGaMMaM5wytD5kQ4kLhmct8UDmmAmmdUMfFdnSXuTnsdZ6UyiI8yp/o/WgKXVtDnpOA/OoifTRZWeS0HcDzixZJefIieBirvGSkOXARoU9oylz+8B7CpWXtWOWCiEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rDcVvshp; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rDcVvshp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFQ2lD+mA7ET7NjTJfuCn9sCPcjALWHiWwCsuIuLXugjBKHD/HujuBMBDLZrHbqmanyeNlClDrBugCFAbJ2GkTHk7DxLenGt8NoH8XvUpBHVvfOTeF3rYVgowmrzEC+uXGVXVsXWTCPoC3fZXeEn1hoI27119FZaaRp9vVWmI7sO8EbpvYdnz6aqGufUllSKeb7UZxJaMjPvcBIOe8/w95B9gWxJgkBqKRefvuPfhMCoHE2n6ZnTNyKYPQK+7n2PwInixAJIaZTYILTtPtteGLVv+RYWStHpG13z7s/J51AJ42+EDq6FKrQyQ0MvsSkzdWddrn/tPGr1vgYsLz5djA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRbySNrBgmxr00b7zAbOvHMIvwaIdc+gbkt7kitIzUU=;
 b=hLk8U6NbO75skCXcNHRhFb3ftIbl84scL5yk8z5/ckjfScU/TSoMtXFb1l3YN6xYQ5G3IMfdfQhibQR/M2TF0nhc2h7WEKDplZJAcRz+s9Xu+/7Pl+NsXzTQ+tJpeaQx3ku3xsuRcExse+Sxz6kd/3zEDLI3IIVVcXVAwz0mQfAi1idytuUuB6MdUScoLzpFcyMHSJwR2TcfkzXATZFzRyapRcF2qAQgGjINlrHYuR/zA8WNiZXb+bFOvFZ+KwPFvtanj1MShBcAzNXNFhaY7FvzEPQF5MNIiN4xjT0vRFBke9kHy3KNhk3tDTTOCGjXXjQ1ojziqIAYMQA5v+kXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRbySNrBgmxr00b7zAbOvHMIvwaIdc+gbkt7kitIzUU=;
 b=rDcVvshpwPHBbqYCIPJUyV0zXjQOR+7j7sOwTj/aI53e2k7X80wbZd7jvUjOZl8jTkxuqO88yt6mFtfJybXeD9q9n7X2zd7zkLBDTZnEmkH8PLLs4g0DuIjcuF8uIZHpovuDnkk2+Oqy1ZAPSk0oHQhTGG/05uwI0R/4MUTaFAlY8LB3teGtY19jRrFKSxqHciV2nl5quENU/rQHBJvs/2R79us+yt8JCmpwfLu/qUoZH/ZrEllnnNE3FEJEETsHCVRQvWQTHV9rfrXZPY5eZCdEmqoCGZDXcVC2Bir3p7hC/qxeMEEW7IXRVjHOTjI8ftrueEVz5DQU3v1brkgTKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:21:47 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 11:21:46 +0000
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
Subject: [PATCH v4 4/6] cxl/region: Start unmapped poison scan at the committed decoder boundary
Date: Wed, 12 Aug 2026 19:21:05 +0800
Message-ID: <20260812112107.56181-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812112107.56181-1-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:d10:25::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: a6203afa-0f9d-42f7-3942-08def863e54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z/Lb60MjWtz40GSoiBNUNLXQ8E0bS2fQpN6Pvm9/tH+VXtjrTUdqaaCpkIqglv/2+L9jxL02uLO6rS1xr18iSXGbEryE2Y4J4rs3/k6FqZ5z6nCtUmaulmUPw52uuKc335F4dd9JVUHGgEB0EDfOgeRkD6hadRCvFzGbPungVBPzvBs3qZVZU892SqDOJlZVsl2HaovMHZCPKNMzk/9eioaRe2jWpex2vvWT3mJyixBDO/j45eANKkI5YAuFoxWUnwKnFQA0AqGjR9e1c4TYSCmUZD5iXdjgGw7/X8uCejC9H8VJjcyvcChdjr0EmLZNdUZDiMDtwsOa79sOU86+pHGtAwLUdWGqQlFhgHsuIrNevs1Bt3Lu1gq6IqjZthB3WbcWE+EnmD4XuXmtVGeZ7mOGvFunXFR6pFs8BYn2MsCGDNsj2VKPPiDPLxJOG7hsmQjjk+7kj0nA9facMvXlX9txtOjqyM8IjOvvZwv1DozoHUXixw9FjOWtQpw789eooM5tyo+87OKsogm7vp/gaRQDNqpV2p4nrPxwV6b3Dh6gTJBvB9JyIcohdee1tmNesXMnIRGu+998+7B6uqaYzMHSEIOTh78YxXnrncv8+yiZdpd3ZmC1SIAiYRVjWzIMcvVwDDPe63B1Xyto4CKVOwPWBM/LfS7GassTJMP+8Y4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tUW/DHiMijJ9cXT/fcKU9KwAQxcUcJc2rbM9Ml++gcpJhKkUUaA9aWVuloJH?=
 =?us-ascii?Q?EsQdLOw8uTcPBVf1UTiCPZH5+r2UceKfFAYHu3UYceuikLEbGyvYpA4E2krU?=
 =?us-ascii?Q?C7vi3A7nm0JHBBCBbtaScoLGC+6d88+vlHB4xr5dcrwBKHFe2npH4kaOI8cI?=
 =?us-ascii?Q?xS3Y5iKsM2dQYKq8A443zsGaEMnsFxkrnqHgQXT/phrZ8sSsZBcZH/ahp33o?=
 =?us-ascii?Q?82ugRLcMrL9t4k3CEBrcXuglSywfepwLmQedgGhAyeH1PhMz9GRsJesNFxk1?=
 =?us-ascii?Q?hGCEyU7bb53ejphWHGVavqMspH02SR6ameKVRpIftBypEKu2nDCMJsqykPd4?=
 =?us-ascii?Q?NT9bv62ET0LBcHDsRCqJR/+SRLn28bmMUBhLQA4RovUVfeAnqjz2QIdaBo+a?=
 =?us-ascii?Q?FK87NhC5tUA7ZoD8xgWFyVF4la2/U+96qEq2H3Rj8vfJ/mT2LQ6FjX3mQpzk?=
 =?us-ascii?Q?3zweQ6VpRyBtmRVYMqufEpzRqhc6lYMxd0QMnG4lGJeY7paXjQ/OrwrSmKFk?=
 =?us-ascii?Q?kPSp6Tw5dH5wB6/OcXKRV77SqCKkvVH7KiBlFRXi5pc5VIsXdd/kfqo9pQ3o?=
 =?us-ascii?Q?Gl/NpSt/fvQmeqezFCS2lwh2uGXbTGLc9oj7Y0T794gWSfSDIst4qzaGI9kr?=
 =?us-ascii?Q?HJt7XnxialBJ27Jyn3W+stp/2Ulh7t5ykGC3OsJOzQaH2BMrNMq9aFTNoPR/?=
 =?us-ascii?Q?n8OT6pvQEAPt/xv8Lp3DL9+i2rBKTOkjBPMxVkhiNB2ufmDkJzexkv7mfYdt?=
 =?us-ascii?Q?TqqLyQYmISGuRwVb6pAZVrX7qLsVVePDF53zIMFffpfXCTyDjpAIJA4UAkGK?=
 =?us-ascii?Q?MURpByPR1B7a4s0wBY2rMcxWEn2J+hmVAnH4NheIv8cE4BoATRQCVG4EtuOe?=
 =?us-ascii?Q?CTti0hmJ3686bOmMmXrJlGENEW0tw8nUYOCp1fwyp8xRBPh7Z0GUr/UfGkts?=
 =?us-ascii?Q?KJYOj7x0MiuRSPr+dKByhY5wyxTNRV30C79H8ihjDRU98kEUJklgXKMUnCBp?=
 =?us-ascii?Q?ZXfUulyDQs8ZsJJa4Fbp7ht2ReVprc9bUlNAup1itJBrJ5QrC0MjuMQ49ZpW?=
 =?us-ascii?Q?G+u2NYyfT90W/NxgB88DKBwMcPZzRpOxk/gB2lvU1hN52puXC68qv7LPAA2y?=
 =?us-ascii?Q?bbKbq1V55yAbGtdgkJe7yZagidrya02wzbiTRwm5J0PILaMBY0GcRS//5tiq?=
 =?us-ascii?Q?pJ1vMgWx4zuwTVqNKii+h8v6Xydnzu0E7sWQJ5o8URBc8gv+QHWaRtbYjmf1?=
 =?us-ascii?Q?KhOyNXyiV2VVEHOj6kLCveMYFZyQ1EX5Vo90KgYoiiwRHci3N51vkDSgxk6x?=
 =?us-ascii?Q?uO6CgNg1K/PfPvyZrP6PF6R/lRjqbi0rKpPmYA8ZcRNFexRNXRzRj66N758d?=
 =?us-ascii?Q?dmWA4+UJnkEIKjfJ2bPGijYSxmU8mvuQk9VeUQMuahUGDhAqhvKbEtiSyu2m?=
 =?us-ascii?Q?g9lHerPbFOKi6FWQgAI5BPP0/Ee5qpg7K2bBEsW8i8dzNOeQV4U1WTD8y5S0?=
 =?us-ascii?Q?3107vBKGlefuEUENmYbrdS8vNqasQbaLr40VlMYGLcmgmYAcpc5iTtjVYSbG?=
 =?us-ascii?Q?teGQnvZugUMDGLwhZosaKiX5Fcpims29pfNXc1SIIpMWINdW0J/px4CfO35I?=
 =?us-ascii?Q?zxf03jSE4XGvC0FSol2EKLPOYFTUMUIdV39gHCNs8dy8xb4ESneCE4N1WtmW?=
 =?us-ascii?Q?vTgbVrWa4vPR1K/sG3chbH/TNEQLOm5lCU4PCc1v29G0zX8O4gWRxPM27XMX?=
 =?us-ascii?Q?Jg3JgZQ7dA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6203afa-0f9d-42f7-3942-08def863e54d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:21:46.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4vB4+mLXSwv95YE3EgyyKzi2ZuyCDPYfZ00Bl/Ph6QUeXdIWLixD7au4VMQxQTyWn3qLL2rMBHudWK6SF+Jpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocation exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - New added patch ( sashiko's report )
---
 drivers/cxl/core/region.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ddf12075b95c..b7dc5d4988da 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2907,7 +2907,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	const struct resource *res;
-	struct resource *p, *last;
 	u64 offset, length;
 	int rc = 0;
 
@@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	 */
 	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
 		res = &cxlds->part[i].res;
-		for (p = res->child, last = NULL; p; p = p->sibling)
-			last = p;
-		if (last)
-			offset = last->end + 1;
+		if (i == ctx->part)
+			offset = ctx->offset;
 		else
 			offset = res->start;
 		length = res->end - offset + 1;
-- 
2.43.0

