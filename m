Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFB38B7A5;
	Thu,  2 Jul 2026 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976859; cv=fail; b=IJVZohtuqdKtJrxcraIrFcQKP6bJXhPUT7lJ1C3TRNKi5+aEid/Y3+x/xq+nCh6Nqmxh7Zs6bz5n81xgqQJUYjp/Va7BcA/uKYhuAqtSH/mHPdfqjEvt3LsgT3cVw+v+BlV6zijntQA/A8X7IE3WgCua1IIxexFGpSOJLn8xuIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976859; c=relaxed/simple;
	bh=uzU1BdNEhYevklcB+aT/cJwjDCJUL9WQZ3EapB+R4Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WDp2prrGeOyfMfZOkq/pxTj7XVLjkX0SxrWpvUtdZfIXXF+TDgiaDFk9jNzDrrsfbAFbvaVnkyso7gj6hmfxGBZRtBVF1KYhMKYMX07EqX5NBYeuQYaMbBbYMILdIWzNPM9RG5UTe2UC2ZfJUjWvvYaV17jZDfh6NAZ3c3hyKl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qP59f4Vr; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qP59f4Vr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awOBQ/EuvpHEK3JYTP6fJlvih6/TkBNFiwEHlEFzzmLyw9u3fLA5J12RwWA1fFYAIuZlXHvz9KSh6pX54RbeWt2isAo7q5TwyO1VATD1aqdj9j+yg9kbOvrPszMDOsJE4gd4GgLZ+euBk2arKwcG0TpLD2WTzMQotkWwSGcXQJwxCHa+bWrBM2WGkYfOEuxNc2dDpZE99VSuVc5UuV4pP4NAt07vU7sTshe/6iuTN/qLu82GEaAdZFA7egjOMmK28nJKOMHMRjdR6dPDFDLqkAhIwg6hdaNpGtSUjWp2oBf0GWJFyvPCZTGhOi5TORPEGe+op18NCMZH8JhFOx7WhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4Oej1ZO+LfsSqa+8Aa4NLe9vmQHcqB05ZPd4Bp3RXY=;
 b=Di35dk0O7aWNO7UlxaZiJgPuU47M2URvcaf1XE2k8TR4bkHo0fa77kWk0ndr5PrC/f5mgiRmJuGMXkva0DMig+JUp9uJeqX7Y5wJ99kVfmnBsaGbTQOsmT2xBEwkv3kU0jm1oiOniueqX156KaywKfS9lg4ceZIDMM09OBUK6Wl+WD/pOaDfY0/c4/1XVpg6HBWUaQhiG/idhcrCpNGyWdH4SAnzHU82rNE4xMfulQkV00A1fAYwnQr4VMoUJAc79Y4wa8z02cj0JUQ6OreEllHj6TLqa5H61acK8qzitGl2BOMR4jDutaFQq79H6csp0lK+KLmhHVfaYGgoVlhs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4Oej1ZO+LfsSqa+8Aa4NLe9vmQHcqB05ZPd4Bp3RXY=;
 b=qP59f4Vrmqlh8vtlnQlJkPKCau1YIuOZ5TBhUH1gtKU+Rj6m3/vtW2K5igs68ZdXTQd04MpJEaYqy9tr6GI8TRXFYacUkTBpgePxd/Km1A11bR/f4BRSv9BUc9s4uVAxXENyZIhi4YqIZUQlE+rtuOttXU3v7u2LJOVtNZ+iC/xBW+uG/9CEgTaTvp5io7UcR/75YfKPAS6x0iRZjMhb907LfSsbclOg8npIbKCllCUhtHH7VdTCO07eALxN8gnzBxEupPeTLvikeelfy9nDWNZteltyfTHDHRhvl+wqHxZFfwrcnRTKSvyVmow5PcUd4l9jPTo3Nks+3bC/cr6O/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:20:53 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:20:53 +0000
Date: Thu, 2 Jul 2026 15:20:47 +0800
From: Richard Cheng <icheng@nvidia.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	rafael@kernel.org, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC PATCH v1 1/1] acpi/hmat: preserve hmat_adist_nb notifier
 block
Message-ID: <akYPrcsz2tWl7ga4@MWDK4CY14F>
References: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
 <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: TPYP295CA0004.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e605b0-a545-4883-0fe0-08ded80a72cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HnUDp5+nE5zjYPEiVt5AKF0Ltxs5KVNYYGmLOTADEiK6BF9Can4x/r0uR5WclNODO0n8ExAF+J7wpVBlOJ3ShrsIpoK3HwN6yL9xY9hJkc1TD2h1envfHfhIFxmbBZDKu6i/GxrZb2TxXeld+cDqJCtIHloe/cv1J4CRnLngY37y15o8NncwW3sXzJODZ8Q8eN+/zYHjVdnzVo019IqAwWBBizdljnTcRfUfpf/hm/TMGjWigqDAe37HQGicg2n5+W4z4RGLVVGB/SNKun/ZHGMf7OQEco2PWDwYa7GMCu6wwAHhZqrn6kae1JOUzjm375mMSBu4ZGwV1Tqbrioqzvi2hKzH83TkPFYQnZc9pPcH7jgZoTqifFAQPVNNTI/1fM2i1UtnWEevX3atqFPW2s7EC0vS3tbuBNbAOzki5vQsMD3yDvqr9xL1H+UhsJ8ONFwHq5QtJKbSGEc2WIevUeCdPHxwKFC7BZC0ylSDZbVTxiOiFGDQZtSnyYjYdeMkh6SWaCbXfmGyZYokO3P+brbqHUQ1modq4Z8PHv8mR/1U0hmTAITyXH6L/EZn2snrDk96Ka1USyH42SpQtqM1s8Wlyyohp025xlJ1gDMgQBZxmtVhAO5Pwq/iRaNahWXpjapQTUKVDicS/ruVYA80kZhwHT/30HcuRp5YMN7dEgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/t+VX8fE6RNFg61buuhpPtrphokM1f5v5o/PgRLs1GVyPkhQ4w7R6NE8cX0?=
 =?us-ascii?Q?vrsEEEl8+jmoa+emDfvmyyYsbZXD5+9rfXFCMhk8T76sastftW6kbNBPyK8V?=
 =?us-ascii?Q?HU5pW64pV/Bd6FPEhK8fXAzNtmA8pke0eAKa3jM/LrFsq7LwpZj55u/DNm1Q?=
 =?us-ascii?Q?4MtvMyG0IrL48/ozVBFFSBFOflg5PxPjKn+a3z8zWoqr7BPf3jTCXnW+MiOT?=
 =?us-ascii?Q?EQAJeZWu3I8XCHSSM/TtO9I+aEvlRVSA+rvZabLJ3eJfrF2Boec65+QriAU+?=
 =?us-ascii?Q?15/2KQsWH8DN2bDs4hz/NxsUC9+EUHtlor8XZW8vQVkMLq+pgjO/kbvYLzX4?=
 =?us-ascii?Q?R5B4CLb56ZPqW2HhLhk4A2FM5MuvEOTlyHpwOLIgLFxGXwfMzDY19id5Bmge?=
 =?us-ascii?Q?6FdT6ogsm9HEDKgeGF8Ot6vvEZHvGcbWEU/8X83slGVwTOtbAM1DL7Sd4eG3?=
 =?us-ascii?Q?2EtCJfk8un8cD/PMSi18MVfzjy17bACL96/qtJ6n9LkX6a/KocJbtPE5eMny?=
 =?us-ascii?Q?U0hxy8jM7J142pgfcJ4TjRS1kYf0cQL5Z+n/ogHVkwNKcbq9v6jLiolxB41j?=
 =?us-ascii?Q?O54+CTLH+prqiK4HJPvBRj6L3X+dvXUvNEZu9INeZm4Ic4GHfit3vSsmxcn6?=
 =?us-ascii?Q?AiwDzdFYOAUVCWAjjbCPghaoPhfNM64JmqkC0TRzH4tip8MAe6zbUDJlI7hY?=
 =?us-ascii?Q?7MYt4YdcMwzxwNhcc+n5k5fEPsaBmxAybICha3WW2OFNNpPq4TTIxYESxYTL?=
 =?us-ascii?Q?qd6qNRDn60qirAD4NtsAtrRx5W6AYMCgrsiMEwkN3b4Q+xkgFFalOxvhVd3d?=
 =?us-ascii?Q?A+RFh7Bz5nyQSLGP4inQd67YoWqr/QlrzYAim/xl2dFh40nEkh4LJQNctaUt?=
 =?us-ascii?Q?WX48w7TVixJpjhb63XgF5dGc9hgdUp0utcGryvGxi2aRNPt+BGh0dhlTGAkG?=
 =?us-ascii?Q?KNhG1m+yoDD8FozGqo/iPvcFfMstcF0PNcN60DNxI3mFHelF3YAH0WFqmp+q?=
 =?us-ascii?Q?uE8jyk3WXw8xpM42zOTWRMXtKDVuBJqalpmR59YMoo7oRqpT/XOxMIgbl0fH?=
 =?us-ascii?Q?V+H4UNVaoBbZXile7yS2ATGn2/ZManiZiovCvGnx2zJxPIS1MmzLF74ihgpA?=
 =?us-ascii?Q?38i2usaX8/JDFEwS4hB3kd+/cinUwXpNIdBK/Rj8OPK5Doz4Dt+JmYdnEyEG?=
 =?us-ascii?Q?uPEXXYWxpLylyrqPG7BX9AExlqox3h1EF8q56PJ8XAd1UpY+IpSp1ZVJmrP0?=
 =?us-ascii?Q?7fs3Rhb/U4WITqHciRPgpZz/KO4ZGlAbtXplW4JDiTwZSzpZONC5yigkz1pK?=
 =?us-ascii?Q?7HTD3aQS1SZUGBWr8EwUu0vjQ4Ap7V8LEYUArqnfLadW4yWEFuvDWNYdCPg3?=
 =?us-ascii?Q?JLK9UVTz6Uy6X2PlSXjpV78pVXK8IU6LYVt9InObSe46GLIMMHp8P8xCfmkT?=
 =?us-ascii?Q?AcOyAaMRhpD4v4lFaE6A0d/UeYhGOh5F5KaGL7THjGD1reJDgs2sDmaiaOgf?=
 =?us-ascii?Q?+sUXjjdIp37DsOb0Lb7lVSP4S8BdYv3WwNWEWhBNeL8+2DYM8NXkJYdEelFd?=
 =?us-ascii?Q?4/xfI6xu6tWy6EZbRnHZpvInHa/52c+T9e7V2USzeoQXNYYG2M6TAZAvQonm?=
 =?us-ascii?Q?hdRRZMjIsMOCxFPopR/Wo2qUX2OMEbU7ymO/EtlSveQyClLRotoBODlQyGCx?=
 =?us-ascii?Q?+eJ8/sHWjKMJU0y8gH7DKFigyApXAzvrzq0/LGpeXX5jZ1vo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e605b0-a545-4883-0fe0-08ded80a72cd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:20:53.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otiVQYtEt0jJqrMTuhmXyMskSRYp1RABkyXTGeaQH+BXaVdMhfc2c08FQypcljSLw6P6+8Y30cFg7z3LrZl9QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

On Tue, Jun 30, 2026 at 03:35:07PM +0800, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Remove __meminitdata from hmat_adist_nb declaration preserving it even
> when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
> registrations using register_mt_adistance_algorithm() will find a
> notifier chain likely corrupted. This is the case when a CXL Type2
> driver will load after kernel initialization and a CXL region created from
> its committed HDM decoders registers an mt_adistance_algorithm notifier.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/acpi/numa/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 9792dc394756..3006789ae31f 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
>  	return NOTIFY_STOP;
>  }
>  
> -static struct notifier_block hmat_adist_nb __meminitdata = {
> +static struct notifier_block hmat_adist_nb = {
>  	.notifier_call = hmat_calculate_adistance,
>  	.priority = 100,
>  };
> -- 
> 2.34.1
> 
>

I think this is not limited to CXL type 2 device.
cxl_region_probe() already calls register_mt_adistance_algorithm(), and CXL_REGION
depends only on SPARSEMEM, not MEMORY_HOTPLUG, so with NUMA=y, MEMORY_HOTPLUG=n, CXL_ACPI=y and CXL_REGION=y,
any runtime CXL region probe walks the chain. I would suggest some tweak for commit message.
Also adding Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")

And maybe keep unconditional removal rather than a consumer-keyed attribute.
register_mt_adistance_algorithm() is callable by any runtime module,
not just CXL, so a CONFIG_CXL_MEM-keyed condition would  still leave the hole
for other callers.

What do you think ?

Best regards,
Richard Cheng.
