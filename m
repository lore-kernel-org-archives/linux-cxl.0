Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03D3876A4;
	Wed,  2 Sep 2026 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327558; cv=fail; b=Szr/X4ijzhN8oQPUKVQk08qsf9WJSBEmb8pKV5EHdieJEs9oIaT1kyOoWHePVPZhI5AjGFLcVo/UOy2+UKEV5X7AKYXpcv8pGbTb1VUG0k8JgnBtYduCxGVUS7EYYi5lIS26bceupopnld7qoZwcQKHxgpIv5HHwuC4tFq84kqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327558; c=relaxed/simple;
	bh=sD0SPOyJ7a+/6owIGb94284qqSPM4KFvnhqjCxspJrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ckWD4RlHqMfA8/kKZpFVWVsrvlmDg0v0v3ONRsWW46Lu79GhP33H2ELiybjfQzx7xWWmVzjc0z5KJ3nJFCq2tO6yAmKVlMg70ZfxfUWvIdFILai88tUWTXc4eOffsZvq/CBr+ydmvggczlxn90qwSsmmvKwuy9r4vk7qsKD2q0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HAvnwoAU; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAvnwoAU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XixClZzMI+j+wxgTCDmjCSxlf/0lEgPZlHDivZLZkuln7m5c+IlgTnWZA8kGlObBPTdK8IW2wwnSXv5W2JeVJsz6daKCPgv079IPjLcROhdE2w0qtyLCfXg8wdbag2Q5ADcr71to4xH5bhWRRvldZrzlO+P5/qy4v1reVuJxuV8mPU7wdRyiUaGoEtH915E+AAp2nvaYrkUHBtx7WK9IQ040Agak7S+7yUqCaWN3kwUmYcyzFuwvLDopdJk9urCxH+im1XJl8jEl3bTWcpqUt64b8ZFLKBg+wfwlN1h8hF5Ss2BwoGG4T+LeGCo+g6VAgA/w310g5LOfNwMxzLKYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMeYI27txNQJphiE2SVYzPZJU0gJALqwTTkHKj2yH/8=;
 b=P+KbBceFUm6hT6BlxUkQWmBTDWQBAKWXA6iX58swmsIKVuaiyaPkOxfq9dzQIftLCGGRhdtxSoTqKg5ylSIXF7Fhymi7juqldk+YCcmg3iOpnRE0zBxEd4G5QeXAhSM1rLYioqCsulI5B0VLVVEDZKmr2N0+zUolAZRpEnHdsBGB+qM01/3Zg9MD+Ts9zL2IhPyTD2IxOd5kANOEcWnMveBAP+Xo/PR2F/YqkmVUfnQwxhrWRU+xTg+C244ifkYIXlA4czx+B76yzWabxzIn8NXx1U+pvmrhUrQe+p5tWn6c5rXD/YLqBPyl71wMjmnbDdvGwfRBrqqqIZDe1lm4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMeYI27txNQJphiE2SVYzPZJU0gJALqwTTkHKj2yH/8=;
 b=HAvnwoAUttHDwnwYgDLe3/xchy7XP2B3d8HUygQwVK2AnUjYyUIx8KDxxH6cmKKq3GvkSwlqSOhMtMM4dGSmCAOa/uB1I+ht2hCcsg+WjqknrhsnGalUEpD2/1UzxTzB1IUZ1jb2R1pQIL8C1VxG7PlUrE2ffmZN3JTO2XT0jwUu8P72PEeCJ4q+AMhfzdbN+bQ6meABZhC3P50NB2fRWwzVb3SHlJ/dTU06SQ+maRt2gOqdLma9TrWR2rnA0vY0zrKxYFjzEPB1UTVaGM+88JTN5OnK+lVMG2I9goGBfrHWgoCpK/lgDDjTPM/mwxqPKZhUZZCjkEUsbKtPqb3+FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:39:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:39:12 +0000
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
Subject: [PATCH v7 3/7] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Wed,  2 Sep 2026 13:38:35 +0800
Message-ID: <20260902053839.25595-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:295::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d94056f-bf43-4450-1aad-08df08b48469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JbN/O0DB3HyZNG8YvTQJQm2LlokxDaUoy7ujObRLnjhSnVJPBkVuCwa5k8AyQaMAXW9b9/3so8ZGVRNHBbTd/z2KX5mh1yrIBCqRexXY9QXoknthFPrdnJ6dgW6+K4WwskHMRhxBWCzal4G4F3L19A/5BX4Y/+qYIfQTeszVzg3HwsjGJ/Ggx4srVmTJMuTZ3ANpUbt8WBhGWZfO+exigbNb0QuaP4WVX/ZK6t8zFvjZkGySGxAamhGHe267vDyEe2RtuVgigQn6D4L3FOUkxMGwFfgXEgNm48cVPoynC2LLFSM+gWSauGTaVR0YtnlvuCflobNFDVIFMtDMpxuSN/i1AcdPg4hnxMQBXKI2cLUZv9PT50BLSBPAkeKltQb+YCBSeIKRAbbUCI/wSfVjanl3AIH5+UwrT0Tr+HLG+pWvo9uvVg6m7R8L7W+uE98kK/Q8ZWtDVGoEydaz4Kn7DwdyuLMBR8ef/iLYK5aA6fvIwQlUJXkvSUWEfSTNCz2Eh0C+84mI9cTXeyVUgkoYgx5c3A98gIBr9ih+1ZCde1+Az6sbHYWlUBH4gXH99IwNjhKtFLiSRAu9yoW2ZPO1ED8XV9Gm+0J3lPm0IJUbJ/oPehuj+m0Xu/1adaKbPr2WidrR3jJWHf+7VmavrbbUDE8jbkZ8pvOaNm9G8roq0QE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Smr/EI/Ks3go0FjWWuKCJkB1E/mkoj8ycO67N90Bm3EWfTnJt3ru6WKfJo5?=
 =?us-ascii?Q?S1r6iNHYBbteicegpn1P8DoqG58BeXLUsmZi+bQRAwmpt8UIse39nMR5Yneq?=
 =?us-ascii?Q?8XfRY9jl7luFKyWT2yfCf9rSjnR4wascG1ZTDHIDUPn+JlE3ktI81k2YJ1ps?=
 =?us-ascii?Q?K4EyAHZFKkqKee0fUfCac8dpwdYAvdQAmLm8EBrpGfS+CIhRfOjETLYtvT75?=
 =?us-ascii?Q?TKjGDbQJ3bxoAD9Tk19klyo/PeVLQ1o5taJbb5L6kTITRrT2WVMKndILcR/p?=
 =?us-ascii?Q?SZYMcFvKfcxS0SXNsmD771y0PEOa/QCm60I+7cGQLePSF5R72XDuDFVm7eCQ?=
 =?us-ascii?Q?yWDji1KlpLxrKIYQ5VejXxpzmZG1FBvMlfXXyipx5FgHE0nyKjkO9MmFqxct?=
 =?us-ascii?Q?q624G3faDedtYvbem6/xAp0yga6urrYwQuimj8Zq66vQTgMPDwbJqo2h16LV?=
 =?us-ascii?Q?NHWGvJaXdgDYl/Yc428I2lbVTW5OIufPG80cxcDxsk4oIXDBOfuSK0K/2toh?=
 =?us-ascii?Q?jOv5AlEBh1+3fOg5gJNDhfj/fCTQng26rAvf1ZnSZIAMhTWSKUgisVQns2VK?=
 =?us-ascii?Q?Y8PTRYnR83P0b6otGMKnK5HiGLAo3BUMR8YuD+hf30euY3Ixn6AEyqdKgmw0?=
 =?us-ascii?Q?oO9oqf6TXg/geKzQ+Oeyap013//V5xIkqR6FhcXb3E9CjBIVchvhA0F8gX+k?=
 =?us-ascii?Q?SNfOWeZTbcz7Y4TBnZAuj+e50He0v+SPly9cVTjS+IQoOXbz7V3qFYWSC1AB?=
 =?us-ascii?Q?Fd3rKBvpTtytp8BUkcNr0iWZF30nCBtu40LyNU0ePD7KH4R4cVBGOuxqUhLt?=
 =?us-ascii?Q?YvmNVyD9RLklfqo5e8XdC/bvbG+nfSDEXbIXUCpNzHf7E09cKngOnL0q4byI?=
 =?us-ascii?Q?s8S/O8RO87HNmeh6ljvx+nPYEd19jcg7DxHGAeElrhjyJqel1fT/GPCqSB8s?=
 =?us-ascii?Q?RTqBVt8IgWVTzLbfaS0eFHWarQy4Elkg5Qg415j0ddSBrGeoYe1JjEgw9NR6?=
 =?us-ascii?Q?qhFMZsxFNQ/rfsyu1lrPdTupoRAZ/F88Bpb0ByBtZWWFtlQIN47V0lNY3hQT?=
 =?us-ascii?Q?6ejMY4ydcX0XFz/+IMKuAp82pfyzHKpHyVum00gz3Kck7WxiuPgNMvZf2wEx?=
 =?us-ascii?Q?VEOSWJJRHbAfN7gIL0oiN+p46H9MZzN98I/OikkQMNzkgWgoKTnKheNPgjnt?=
 =?us-ascii?Q?0Pf920LUkdt0plaRfdCdQlyNksY+D4N2I5VUm2eXl1CJmamYSXj05KPNSewT?=
 =?us-ascii?Q?UA+zJPGb5LUxkb8nyjvp3jQI70ZBTxW9uAOHERuAXyIV5hdj1blbon6y+sTu?=
 =?us-ascii?Q?YSPig+LDjKkvx3W2/iSSV/OnLz8VCOkwvw07aMH5XS20lzYyZvvHo+velvQ9?=
 =?us-ascii?Q?I/S3B3ARCBKM/AER5ePt2nIhvJFBysYXnHdsD1KkOIwPBMg9vaRemvTdMEOn?=
 =?us-ascii?Q?n6+OfuJx/XeOrmKjngqjSqHoNMia7nFAKyDHBpemG4wyF1t4kqQPYUq9JQe5?=
 =?us-ascii?Q?MFf4P0eHOPflo29d0VQzy5whtlL65mdeSswqbJWlg3hbBCF2e9hy8YwzDENv?=
 =?us-ascii?Q?UMj8sp3VoF+W6kcGMrKxDM8Bga5kUkFNADtNT6XLubv4XP2mDyhcECALSm8N?=
 =?us-ascii?Q?osy8ujqSriphAyZLBuuQMkzxFawdP3Fg3KcmVQKNfro+PFvkraE+fO6u6E+4?=
 =?us-ascii?Q?cUCr/toD/ccQuwtblf79pXyUZVo54E0ulUuwGjdxpX+iqD6FRI44yw+xSc+R?=
 =?us-ascii?Q?vcQqyXo4aA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d94056f-bf43-4450-1aad-08df08b48469
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:39:12.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67TgX4ZPHxFLCdJXCD2EMJC0S7Oc7kY+2l8kEErTEhhcSJ+qtuNjMWwkrW36w9lW7oUO4ZFZH4t9VcH+yS+svQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

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
2.53.0

