Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2F4399CC;
	Wed, 12 Aug 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533704; cv=fail; b=lWk8Asgw0tM2bCDFVUdmEaFsOwme6daZofUnI84CyLfbqHC51ehVWFi8Lv8h488r4wGeK4SykrssCSgQ53zVFTpWSEWtxVM3rBcOk4lyWkZoFOdBZ/AYjXhBWif5ZiKvfffwu2ssNC2t6tAyso+hom9iXf9a35X5VCJ35cQGUJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533704; c=relaxed/simple;
	bh=N8sO820OP/w/ocMdUW+tso8YAFf/1yY+6ASfXgI4MtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UI7O/zHuykJyFHVS5EqXOA+p4h7GR6TUiKQQ5TFYM8dgc+gFy+Hyf+SPK37tOIuv6vS79+8sG2M6Qw7o6n90+pa3rNJzp9uzuDQFKWNyhkP4lnFw1QnfHjtzmBhEGlopk9E0aXAks9NPgRklMzF5KgEjkkQC48ReEiRx0eM5fBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Axswf55F; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Axswf55F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddEP1cyfdAGXxXu+65OnqPNIYm+1q1ezO1L05i27i/LKrgN2OCKQKAYtvql/RSGxhxU/2FE8/HLzDEIIwWSCBaOfT5Y1bcaWpyaIykciTlGE3xZI4XUzqxiFmywCTdm7a9VsU1I2hRCvgniSeSY57LMd4dezVU2Kb0PV84Nk85zFzwizs4oYTtSMyvZ6DS4robT/oYdseRsO4vIhX83ScPjuJ8NUjj4Aapcj5CDBuL1r/nTboHn8aFnn68RKgS5gbQKzy3gkMYbhrf8aNHPA5KBaCLvRVGXPp0xtj1QScsDkqCJ8fKN60yt4McncN83ipIUjjLW7VuKqxOj8vuCFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra+QSLoXzJ1Yf2fHmyX+ygANlqx0NusVyFPI0RGSLso=;
 b=RFVJ21JR/zEmFr9Djtla5YAFqAMqp6jNZYfwhKBdLqDJauSynrsOGfS+d0i0sDtB0S8ABp8/RcdHRcErdFxbBPWP/WNbh2gw7KiujMNtOd/Q9MsnRhEMCdEmMb+IAVX7iBQCOP7WbwCCH2ztN021J4Ozn7wmrsEWifzf4sx2Vmmbz7NE4nA2m429PToDLeiyEVgke6XJyRutxxPrtXNIg2+vZ5v3rRhP6XjoBO4mwO/GyrQF5bfRYHNcSte4sCJ2b4nQDKLTP0ZiRivY1De0jDfVqftkHJzJsbBNNKBlHtrtlNQICHly7dvA7IbIbAPnVAQqG137s8o+zPNs9hMxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra+QSLoXzJ1Yf2fHmyX+ygANlqx0NusVyFPI0RGSLso=;
 b=Axswf55FLLHRSPqAsqzRxcsA4rFu6SgKobCbs7TpefYjy3kYXiJy8ghKwexzvqeHueO/uAhENcgU4RPgizZzzGmU8Vj0OS6bp9fb7FAUYiW5W3vDFJOSn9z9jeh22ob+Gl0MqmgfdtW0pXGajkRL79taKY9Ve+JNmTo4i/mNyPaQNZgWf5cd5TYFXsz2ucOvhSarI4BBDcDEz4k611DfSSGzP4QysMm78IeusotmI4AaohLMLFJd+HC/8LBRBmiTNbIF31bLHzOCAlNMQfbqp/eAfqozqN15vW5kC0mm2x3UDQOSheVfwhiFriLqn7s0jSigHOgMKaNWTMo7J3eVLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:21:39 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 11:21:39 +0000
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
Subject: [PATCH v4 3/6] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Wed, 12 Aug 2026 19:21:04 +0800
Message-ID: <20260812112107.56181-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812112107.56181-1-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de866f4-a831-4985-e137-08def863e0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MI1M73d60fuSGvw+wQJSONxEIvATkJF6XIRgOBxVKh+ysRA0t3A4k+kr4C57dPSa+hOfRhXPlC7ZH73jaBqhtfwK0+UOtO9U0zv05XMnUvl9URdN7lCpKngemXIWPcT4DNqT2TE84iMlUWFR84SPRy2ncPvYb5bnRWUTWIpO5FIeLtexM2PlADInHUGh8odRbs/ugeFcntztkOWZw49g4WTWJZTYkXK7sPSVj0fWZPt2isw8KCCZZYT+nU+Oh/SGxn2mv/K7CSkvHiGRbhmWlnU0CzRkLgNkbpZp3PHLYIcQ/RnEyY1mjcdndY2ri2AER/hfNhABPuYGTIVC+2rGrwQAjJ+pX3lsfU99NyKxbRhSKCZZlGAfScJGuP2nA3NTKeIIoV9VH/CsHcaCi3fAHuz1FY+v9hekGQWlFgZxsmsxbg5XF+aPFcBZtguUa2OVsCZzg/ybTbtBQ79fmt8D7XfY440Agv/T8G5thRJdX2YUT15PEYIBmALk2h+U+ffyE2Mc2NsFYaxEbuaNLGlRC09y5tTNn9Hb+qXce9uZ/1AS50Ny/sdHbsxu7LUpRc/YeyR9E3JTOHemhmXoQ7HxJrbl/lrF6kW78gG7kMQx6PuWwcvTiTHiMyGaSHLBMgzmXZfBwUmKpo+oLPgA9GttnaZc7YlhdJ0pC0j8oNwV5/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zHHNnbrr4iGBHhPCESD3J+QRbfkMnMENgngnameHaxrpHpv9PmLoBwAKrHgw?=
 =?us-ascii?Q?xTIz+GocDbA9mCnwOK3HFSUPI7MbXuCkJHodRghdkDQNZJWSvxErkS0u8xL7?=
 =?us-ascii?Q?2iS3sz92vsCyaIjg5CTE1b5hS4T9nJY6QBiRd1bLKgVxzSj2Bspr/WsjyxKO?=
 =?us-ascii?Q?Ziu4//Ux46UAZVmrxx9X+qzOu9x8AWN0kP6LCSUSh6KYItwpOzP3wV5KfgJT?=
 =?us-ascii?Q?8ywhuvd8KB8Gs3VQJzGQtRxVBTskRDD3LKS+95xtgmVVlWngyHrOci5rn5Ng?=
 =?us-ascii?Q?QpbeQkxFfFSjJ8fPjg8zWgxob6YDYPAdhG2Pu+a7xuuDCnH+9GGU3XV/h6uy?=
 =?us-ascii?Q?kvpJr09+ascnlptvaLC4InvPEHS5/q1Bq+FRQJC/b1TZ341ZNKgSBmBg4hXH?=
 =?us-ascii?Q?pl1QxA0KqoUTMEO1fy+gEcH+jMbXmdZY5mPQH1znyfTyh5A78vyJ+tYuqu6c?=
 =?us-ascii?Q?O0beUfYTlR+tpVEkWDqrJRpI3Lx6S8bMuBljEnn3Wrq0ybsAyG/lIaZoaDC/?=
 =?us-ascii?Q?CYj7C3hUcxt0sfCI15Mov9VCjwSWzwzt7S9yOS0Ek0YEk4vGQmCXGVJaGF3d?=
 =?us-ascii?Q?P8VCJtaZcRu8SnW2IIjMW5hdpPeZ/M7guFNHA0mjv9/p6ioIBoa7FeyqhtQw?=
 =?us-ascii?Q?TBVquBINlD3Ku4hMNOz0wLiuQgXUmeweKMoPQ2Ov05NOyUGy23d7XaRlFhrg?=
 =?us-ascii?Q?RkGHga1p/8lPzjQrKPK/Jop+8nVhzURtlpVjK2jNqT0exRO/CbZG1j4z97KE?=
 =?us-ascii?Q?rcwMPmsS0SZA6OEPPuVJe750GTeXTLqfkWKS3TiBoSyR9yCwbW3aiaCQcd77?=
 =?us-ascii?Q?C8ZKz/ERqHLB5+3hHPNMUlsuOrQaY/cHUmJZHfzy3q5GiRu5xpz5czoj9TIa?=
 =?us-ascii?Q?UkAyMNrP0R7Ehar5E0GV1XBg6FwHiNRUHwMp4jEbKJdY2ALVUuk58qxFqmoW?=
 =?us-ascii?Q?PspCeFgLFoTkP5g7YoLTvJ6V0jyJX9Q/G5h3O9mjGPUcia3Yq5rmfcFFluYh?=
 =?us-ascii?Q?oBfL5yweOuKpiBcvqaCjaDXI4CeLe9Gyump6XlcnIlkOzmlUKxnPBKbBNkgc?=
 =?us-ascii?Q?EZdnsPbYI2Hfmb6raze10J/Xe8h6j9CUQj4yN7CCFHrRSeXsEHY9Noljuvzo?=
 =?us-ascii?Q?hPamnzw3RZnRYfPSO1luLxKS6QzPGxAFKa8+vKQ8tzJcwPRjzBwY1Ddxhm0x?=
 =?us-ascii?Q?Lxjc7II1Mz//u4/41lfX24VesZadaugQ79NQtHwUawWZmEU1J/uqDz0Gs24U?=
 =?us-ascii?Q?bKmsqJgajmpxhcuOR6t2D/3qrzLp3aoCzla00uVrrbEPUowvekL1on184NbP?=
 =?us-ascii?Q?5ae3qCSewdMhwzXTeydgyPYIW4bk/pKekFidTsxTvolnxO9n602IOa/e9BqV?=
 =?us-ascii?Q?hZzlCy/yGltbBemEVAi3GEWO2AVkndtgAlWjLB0++OVZ41AMKYfxhAiqjRsY?=
 =?us-ascii?Q?EKCkF1qoRJ9eArzYYLgABDD2thw+Q2x19cifMmCV9OQ6RNBF95xwz6ucj2fH?=
 =?us-ascii?Q?DWGpkybqUISNW4JgFT/ls5UVW6COGn53SSz7ljpx3qsQZBuSst+5VdaKvtd3?=
 =?us-ascii?Q?oiDxXzpNqh5n+EsWPpJ3MC4t+Tp5Z/bbJb8Qu46k+Av7TciDVjLZVdWzLT9X?=
 =?us-ascii?Q?Y6PzRmK+ZL1sTxmSO/hopSGuOOubRDj5sNbPkUkmIQQ9lwdbHGWJnrUc4UZN?=
 =?us-ascii?Q?IvTAI7vTCPS7jLJxKWreydd+D5larF0CNpmqArnPK889FV6Th5Dtp2t25SMC?=
 =?us-ascii?Q?89t3Jhl3xw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de866f4-a831-4985-e137-08def863e0ae
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:21:39.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzNWJJ0N6l28vV1gYbw1OFtnDWrf6oYZpmvbDpDTIwcCmT2EzeyBFzWQgGGkC/y4pfX9s1iEZXMGeTVj2tWNgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. If the tolerated RAM fault was the last poison query before the
loop ended, the function returned a spurious -EFAULT and the poison-list
read failed even though enumeration succeeded. Reset rc to 0 when
tolerating the fault, matching poison_by_decoder().

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b03f30c04d35..ddf12075b95c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2930,8 +2930,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
+		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM) {
+			rc = 0;
 			continue;
+		}
 		if (rc)
 			break;
 	}
-- 
2.43.0

