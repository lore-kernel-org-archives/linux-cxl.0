Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B947CC83;
	Thu,  2 Jul 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983369; cv=fail; b=CaEbHXDXqj4cMSzLqBymowhRV4n5Nnpqaq1/VOO/lJyQ10uw9aAFc1NH6Yq/G4dpAO40XzKzoFLRrNVbK85nZ2Dkot0oTffHuAt/rVSBAOClBy/ya3yw5u6udL1jLyCKgN/+agw4meII57LrKyToVQsr+3Zlu4wdRVxZul44iA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983369; c=relaxed/simple;
	bh=0hL+CpqcIUFsYMc5ylA+K2RlfTaAmqXra6cvpGZEw3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFWK+LzEo5m3Ny+sfTk7ssFUAvPTYvSfvMgRNkrfZ6rVM3LO/uBVtxhHD49jgRsSnAgOEMO6vXbTEKRotlGhFErfrLS6JQsaBTOUSG75NuJfwfIW96bQ4IzBJzKlSSZJT0HJ1glhLG/lLvpxhK2xVoj0q0ug135nMVS4VLKDe/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=De0SYb8O; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="De0SYb8O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDLlWv3RbBuUxTW8sKYBEj6iZDC3Fu8bp7Hmi6VWQ4fJs0k+ogLScJw78DjdfZWeZbKyLt8ji+3MEnWl7ULdFSbup1S65pAAwqHp/2WP+Seh9fOJ80gsGxZge3KMyWnj4sEvhF5dpJoALVfOCgtlIJijrMRLxNWQ+yYfeDEKYkXsMiLyQVQNtlpraq+5OusuqflI+9DDRNLD2NiY8mSu8+ZplYxQzRBpn0t+JuX3frExVdMG12yNwgSsci0knDt3ZnCiqZ4b2HLBi3pI4Qz8GEOyQGQK1YBYEhvP0bnOCS7Zu0CGbhRTHdLcD7eBYHlb+fBE6RFCbzSQ8DuqG/t57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9anS6pqjddQagqO31uPJ0hfzbbeCWDK1bknMeHuWBrc=;
 b=sPkDFpGhWhzUOy2DoYezpaYsdDIunGavoyeYiKn4gQLFZUPOZ9XPhZqTscGH8IB6El5sRuxehQhC/c9zsQ+ELIcstWldsWAI4xLLMNptwYf+0rkdI71P/rDqtGF+KESxdtuKlR3XwllJVmsw0zWnJhMrilojyACrvbdbb2yu+5oSuZ8POzg+JSsYEtFNWOd+nSGVFYfeomK0lfKt2LKlLkxKExOTAHiRaLxrflBwCCwUzEfCVGXH2P1/ilqQGf6AlngiZV0kjp9pGVzvCKW4z97AAtH26pSQKBodCekUM1R23j99poCYaYPQ37RD0QUJh/k81TR/4us9GH1jjxf8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9anS6pqjddQagqO31uPJ0hfzbbeCWDK1bknMeHuWBrc=;
 b=De0SYb8Ol+6LrIBtmtgCudlUqCUkEGXEPmc4/NkmTMdYIXJOuhIVQqaMGk/hgkA3+iKBiYZO5lgQ0BT6SPbDBPo7wBImNLxgTCYhmL8slWnefn+XQ1ED7LfRZGtDO+pR+XgUewQuuoYmtB7msG75BAfag7CxjPcGBVYShQsg53SXNkwYDegDxx9tYxbLqnLy2IC7ElGXPPR4wgJOK1utJa6OLmR2jPh6D7A37uP02O4qB9taZJ+4IKeXRD6yPMLfq7f2a5YZrhIQR32+D1n/q+t1oyUPeopMWlTxl/KbGwYWtay8649+wnTgKgmUhi5UVWZZiZ16QXzphxCo6Oa0fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:09:21 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 09:09:21 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2 3/5] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Thu,  2 Jul 2026 17:08:47 +0800
Message-ID: <20260702090849.47501-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702090849.47501-1-icheng@nvidia.com>
References: <20260702090849.47501-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0008.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe27547-5eff-4c8e-1bea-08ded8199a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xyP2xPzVleifL0QBTrgg6vp0qh6hCqGChRSsNSKqgRqE9w6ScFOMrTPCR/oXRj+nvZuhCd6KVoM+YmUXnTPcRwF19kw+2kweBeSbqkR5hQy5mvV1GnOjURVJjtHPof8vuj5g5HFvhO0/im/HRAB0P+zBHmLYgO+Dy3k64ywB3uaAVdV8rcfNW4QFdk4yni0dEsgKHQNlWF6YMtkNq9YvE4k8PK8uqmUZL6CRZuZ/FYWiEXo6c5f/Y7a1VL13EiGoKtyRRdlCZth2f+lqQIox44TllB718DI7dq1WP1TSO6j14fQ6tPmruN8BamVUZMGEBSzYpBWb5Sakqm+dZ7QHd8pL9/GZ3aICS3mQARdVMscGWmuG/kcILUZvbxffH4faUNdlu4LnqEf9pm0nBXSIXvv38lAjxjyNwaGw1wMkZTtjMlOpmtKIewM2gQx7amnnOjMqvxC+i+sza+C/944clFvaH0ra/XohyxxBAr9jswkSvOF6L+U9r6MDT9KUlmsCOXy0RFXLFYMyP0PfpnVk3TjDApP8fqGvvkrrrR3JkfXOAliZD4xoQF1A3ELCW+TibKG0gYgFq+b03riMx9krbrZI+qJkoV5NwRYdyQcaBJe9XfTWpxAdbunK+civlv1t9CN96D+8ctYCYdGCc2XzmTVhw9l0UmZ8KlhMiujBLCU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jHDDZOfHFWdNOwDiFD04ylHXTy38zRHcm/lilysVlUhJskcIXHNoSuzJxCGY?=
 =?us-ascii?Q?B4gH1+/CeFBd8zK5azs2aXyHjmkZuqfitLVvMNN7kNP9hIrv22617qTHgnTI?=
 =?us-ascii?Q?1FZgs6YOltrkABwiAKb6H15oKQ/awBTkvuWTAjke3QxlyqfV0eu9Adf44J2D?=
 =?us-ascii?Q?YUOvKmag/WbFbbaalYmHl4ETAkyyEt1CoyuvwZH90UK96QcAaF13uACl0fi3?=
 =?us-ascii?Q?c+YaVdi6m3sMTO06l3BzRa0VIbgX27v4ORKbRqzr4qIBTjot6VhvRJUgDyxP?=
 =?us-ascii?Q?Pju1/Oe2VlYN3v8oPwcIbif46REb4rIsA5P9McAb3gCwH0Zozem+6EPiaKKA?=
 =?us-ascii?Q?Sx+GbJQNr/TiqIuk8CYbt74883OMnikqaWAN9wBpcoYgmQ3Vva383XXDgQ0L?=
 =?us-ascii?Q?qLwUV2bIgXjuijQe2KCNmf2fcZm9yvQ1xfTCh5dZhm4aXAEVa8oiKzGJ1Roj?=
 =?us-ascii?Q?cMXWygniBFVV07f3Mo8hVoM89RiduQ6kwK56wEdIFb64i+aYYjNh3XCTLcpp?=
 =?us-ascii?Q?JMzrqkOcMW7khmGi4TzQDURzSa1G4xhMtVsTP30Q0OlVTiNSI07abTPV25AS?=
 =?us-ascii?Q?GP0JPxduepBrt2uhV5f/bVpLgAFYWjoUZ1k/XBwJdmvktUmmmugCgA/RXGWy?=
 =?us-ascii?Q?CXk9/ZT0rVvCqZsSrEcYyjtpEZjQGc9iq2IrTmzxPDCH53t1zxT0plV+hiQC?=
 =?us-ascii?Q?tE8QAWffExs985AzMXapyeSeOj7f1fGcAvJVT4BPEAPIsXkvNeKWoi1s4/JU?=
 =?us-ascii?Q?I2sokaG2XNjEhyIR0sYaCtNFYkU2J0KXPqBU/ddg4II/1tHpydIIMe6RTkWx?=
 =?us-ascii?Q?RHvNIeEbgfL1SPOHG0RhANZ0gCspYEBRgCateR0yk76Zjyr9c1HP2i1fvchi?=
 =?us-ascii?Q?ZaZ0qy10CsMhP3jgHA8AF9JSfAJZ4L5kcv2NII74IbVOmcrHafkRFTFP2rUE?=
 =?us-ascii?Q?yZroAtSBJhPotp3dR/6ytqH1DV9g1GjfoXbSAs7LcKvQ3HiX2s4X1/hhj0/U?=
 =?us-ascii?Q?JnEXBRNqapF1tRVJqgLDY6ZYdiXKBfZ1ZSRjdj4q650tijhv8VDzDWnpm8H5?=
 =?us-ascii?Q?Bl2Mv2Ii1Rv+3Jq9HnjRz3JaRI36odR2GBpjOZFQjNFiSerDA0mBr2HxF23M?=
 =?us-ascii?Q?3fI2n1qVf1IfKb0Q6zBr5SxCZxKiuRsHXbT1siMgV0qg8rb/a/9eHVXBLK70?=
 =?us-ascii?Q?G6t9KVwFwKpd7vDCmwLlNf7WJlUdCAK8Wu6NU19IAayCDoz1aRVSJNN1OMG3?=
 =?us-ascii?Q?kvWjdGqUSnoWhQM1EMgLsbSlLaXIbsCut9cdLbeMd9XNyIbRud4vHTvrgstT?=
 =?us-ascii?Q?Fo1v4Cjnpsp8zZ/NrXnyliycMEUVqhGdQH4UMCqBFN4Up6ExDoNL6Zdj6l+L?=
 =?us-ascii?Q?Nnk8yYM7t9IgU2pIStH/zSasSbz0bFKjGS2pF9kdx5p+k223iTZy7E1tbWlH?=
 =?us-ascii?Q?R8GkWilcXHCw0a2cls08daOij5n4fRfgb/A7hGNbXKSlHbRNbvXSEV1guokt?=
 =?us-ascii?Q?AnrYx6IoPDgXnXFMEK0mEGcnrFyaXYkKus5kVobKozHGe9zwq7qnlk0fpjFm?=
 =?us-ascii?Q?b+l/Bv9cUZcGaT7v6t+gGkU50rPP3S6ghGU1oTF0g1pe/7/dYDPW9jb5JopA?=
 =?us-ascii?Q?0HG4WPUWSi2Xo+fndgrMhzP5tElqYtqs5aEq95oj5kgP+HtxC0cuE12ibGqg?=
 =?us-ascii?Q?OMhnrHVJKvwbLXZaXca55mbf3xIGxMd60Vr3yITTEmDJIZ2K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe27547-5eff-4c8e-1bea-08ded8199a94
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:09:21.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdwwGtKwQQPscelJ0GwR6mKZYAtF04riRtoY2CR+IKNE4mckSsQzVisI3TQrZkPou33c/Z44MuoES/4UP0pEmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

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
index be246fb09c99..52ba8e9e4288 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2933,8 +2933,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
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

