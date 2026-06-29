Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C440D574;
	Mon, 29 Jun 2026 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699337; cv=fail; b=TVm0c4OOWlJuRXU1ryla3huml3iAE3DzossSw0TkFno+SFDLHD/RiMt78q1qFLVlILR5GRLVPoeqnd43LaifS7Ocg8X0QI1FPuXbK9MIH5npZAySd4eMdHkmmPWnZj1f2vRv7Cgizz9xg449RaQ6FUC1hZLeXwlNgw2LvWVjJkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699337; c=relaxed/simple;
	bh=Uc5KgCnuX6zmRwFD68FfxGLu8m84XA3RoqA2c0yWZIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcYQUqA4C+WZaZJAY6hIkJr13iOS0sfLm/llpq0LvC6zMeSCu16eSRePoM35HM/O8wybCxjej442U7KzZX20/tVsaoQuoABX5Xw+AbGLKx03CvNJybe1YdtlonFW0qTCpz1YxQ10SI9tYno/bfOFWKzyWYHHGUNfKcECE7yRPEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dfNge31c; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dfNge31c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y771wMxJ0gX9Vxwx97VMQ0Ncu2zmsnxSxkP0bmzgcxHNrY3ZvFaU0le14hJTjx9G3NLC3w1Pyyox7ZLqYTbB8mQIg0ytX8KyRB2xZWp+2y/BMTpIWc+7u4xnZ2yMTJWZPzAR5mdl2qpuWxSY4m7bpvov4mM9A/g2HBwHAozCmaz1DFe2owOU2K8LMSysAgP6oTOnpoX4lTsRE7PQD8JNoa6AdFkj2kkvW8VspaXfqsJqNdGzPxIeqdk8s/0Fv8lLylfdlnuf2H1I8k5SafCnHeeQZvBvx31QKHb1OPbYijVaxlkjnjnBTeJxC70IQelAkLWb6kpAzwo09UFzR/R3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8P0ZTjzK0Hbr+4W6p5o8jiS90wxj8J3gPyIYsG7Wvo=;
 b=w7xzsehCAjyBY5mtGxt3cOHqr3HtbSUaRQI835rVP2BFzo5Di/ZaKhhWry8pa0ZhEMCyrnyb8I+LE+pLJVwxRjDbfHcpoil1pB9+4rwGzZOdeDY3lb0+mP0zivsMRHi+3blPOWBGD3z2g7M5Xx7bouNRAnF6LSrLiDCZavuYjwres+6whOu+RXiFPJXDEDWsicZP2E2EvFDQCARimBPBdkXvuL0c5s5T4QQ5Vw2F4xh/qM/7Qn6t3xDNKzsJEj9PpDo43sV3MwL29kpPuKFnmYIF+seK1VwP0+zkm1A0YDmSvsMUNti27K+9rqBtt121dANmVwzj1VxTTLEC3fshVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8P0ZTjzK0Hbr+4W6p5o8jiS90wxj8J3gPyIYsG7Wvo=;
 b=dfNge31cLbV2S4DnKGteqXMyCZDc/+nwzLB1UrQn6TFHMI88PP43mu+Xa/by+EQpocxZ21F9RYvpbRKySUd1WOoOH5xpimXY4rQRE3bVp1PBhHGQFaHeZ/JIUDhF4aXTKIYI8Frl2+z0q/l8VahyK/CVahFUTYQzADeRufwDm7H2LvCzsL0ccf/hYc+Nd3v1oFgjZntXmgyKw5rc1v+Hs/DP9Pki8lcS0jR5jfDix8OML5RzDBfYwW3ag+9747vTvWGQw2NWQGnzE89sotjvh7yoGbaGjRtWz9XpDaxb2S8SPjoV7jhZZEFBkC+bbxuswgNBBCtqgTmeK/aZJScW2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 02:15:32 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 02:15:32 +0000
Date: Mon, 29 Jun 2026 10:15:24 +0800
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, 
	danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com, 
	kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, 
	mochs@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Clamp mailbox output allocation to the
 payload size
Message-ID: <akHU7RCvt9V8zkdC@MWDK4CY14F>
References: <20260624144147.53997-1-icheng@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624144147.53997-1-icheng@nvidia.com>
X-ClientProxiedBy: KUZPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:d10:32::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed9971b-6722-4afa-42a0-08ded5844bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mzjpv6Tta6/2Q13QElJYRhrA+c1cJoCwwyCaR1CU1oaoUWq6p9IU5VR9q0TxiqX5HfKRSmZ0pXeuklEu2jXkNo2QxNU7SltSVNik2Cl7BOG202E24+jqKo48KcbSqJ+01WhkuEACJG/iD910vCbkzmvD+ACJe+Tzn/uyLAKyvPCqPHHJRKCZIavlBYCys1JVLuBpwzpcfAMtOI/eesmavOpAY7IsCGHAYenYkYW088EFd6HYjqWJ1+nVu1LXFvjH2AJJBV/DGbA4byRoHkCL7QHrcGPl2f2BDQH2m8rFu+wBjsanJIbn3j2UoHqq+eYOcvFdvmtYW5yW+7rv3qcDz9mdXbK0/S9zzlwFI6p8wEbRWkYrEx6g+MVC7rKcAdBF4z8mzdh88PzrOQlMATOKM3yrySs7Z6LJokLSjGw2fSfGQHAQU3nRwlPG5sohN7wWTmmnMPf5ftTIK5tgd1I1AIMOfyTzxSC2y/bQypWOck6WR6zyzcLZICTeI5JA7c+1Hoeoj57p2dCKSXPp6+q7ysoDBELy3j5+1I5j9hFIJhBw7TS5Um0Ei47J8iLfuT5As5nDrTdPcwl3TF1ELebyTX26K0nQptfuED+pULfDUfyPjdvXtVVE4Uu1nTm9tnUaGkrh0eZzocNCKSQagxUjejJqv80xbYqFVNe2Ay+xnU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKmQVkDVkLxEt/m3G5Q3coy+qU0QdoFAxIDXpqA+IgCwIw14od7quQ9vWQVU?=
 =?us-ascii?Q?TuVTAeVEh1sYsZkLRPimRiZ6YmUsD/1U9JRh75AADcuVZTUP0he38wtjbpQO?=
 =?us-ascii?Q?6za2USvt4GD+/y9b0eEnHbLU59G+iG5c+l8gIqHm98DZzSjzsH3YnXqJww6L?=
 =?us-ascii?Q?kUFVGe0SAbqEQ4rU5NIBzSPb6tq6lA5/gKa01TGU/d+c7TK3skvnJE0P0i55?=
 =?us-ascii?Q?ELMQQKcpKn+9SyRCmJN+A67uU8sHdc4UXnasrjgDARW0ehhdFGIdYT3MOyvs?=
 =?us-ascii?Q?uhgpIVr6cDoALC/ooJXy1bq6orNLxvoJ0xCA0FMX+c2gj9tWrDdsmW3DSN9h?=
 =?us-ascii?Q?uqrJOB/+Q6bwmkB3ZmXAV2W6vEmMOosiYASvlUTArzgCobN/+ADjtotmtoMq?=
 =?us-ascii?Q?DJaGet42L++TJqo0qbpK3HUTlTyUaPsRd5uCOyYyNJrzHlORYM01l6uhARwo?=
 =?us-ascii?Q?3c1EXOOeWFEa4olivLpYKyd/jlZVVywpEGGlRFbx8DdeU7/XCXrKRkJNTkYa?=
 =?us-ascii?Q?5hoIfZni4K29aKBe/FBEVDL472O29qhxdxtlamSEf1Hlcw1yGsedFvJa530+?=
 =?us-ascii?Q?1/bSpGeElEZyEI7/3bw3+e5S4tLJyWsy9dxK9otmF8ymJxOj/wo62TJ42K0a?=
 =?us-ascii?Q?pkd+cabqXeWJgdCm8ou7KabUjiTGRJ4fA4sKEQQNLZQFlR01KS5YFDjeuA35?=
 =?us-ascii?Q?3UB8R4Kabj9MERIZUuPfIhg+hm2GrMWbze3Dx2S2Pwc07K111MlWl9pKEwy1?=
 =?us-ascii?Q?FGv3nlcq8AM8SMioGsmQVRof0QdSmMe6bQ3ULY0vfj9/yLE/XoO2L1vFnUj3?=
 =?us-ascii?Q?ey5AhYa1Tni0MQx6IqEuwNOAzUzDnwH3qTPykVeuXhEwvwNG67WirmW3N2Wp?=
 =?us-ascii?Q?mnkdLD1+/E4SLh9G6JscV1oO4iTeB0i84CYtFZzxzoZXB4ZyI4Cx1B+Z9ySc?=
 =?us-ascii?Q?cGH//KvCMbEi8A/lCpdb8CXst9UwkjdBH2T5lFNMK6VB6vn3Y4AxWTNvHlmA?=
 =?us-ascii?Q?grpafP14NQNfS3TxsfmE8rLguFLxOhRuqwndHYRgQEj6dv4CInTfnqj2Iaa9?=
 =?us-ascii?Q?ssqsztn/fbpm7dlAij+P9UxbIaz4XOAtapt9Gcx8mpHMVe7o++Wrvi/1Ggri?=
 =?us-ascii?Q?vu8ITbJTFYmK2TUYv1mDhZqXoXUrwRootiCXml5g4ciRmP6AmcHupKcs+JoT?=
 =?us-ascii?Q?1V+KQMfZRKdkGBYWPIHbHdCUEFx01UA+BF1Ih4WCOkhaYa4KkVpCI5dc+pzf?=
 =?us-ascii?Q?AVLIMxsMcMnLwjWtlWZ2ejzhhOMAiwGlC37EZPEDPtX9nLP3MF4ZVSz39BJ3?=
 =?us-ascii?Q?ZZD6Z84qoXTYKjTa3PJeBnNAqbSxHfH/De0qUaIbCPurqnbrYihZHb3vlKaF?=
 =?us-ascii?Q?rUaqALaUuyfHHHa4yLYVpq+BqpwbH5y8VRiqYyzJFDl8xoNbG3FLYYQfHEgu?=
 =?us-ascii?Q?iTBH9PxPCz3wFntisongem7ZBywcLHwg2WABCgy5hJzOYpuspaCcgKRCQ+EE?=
 =?us-ascii?Q?8CN4Wa4zzu4z/IRoW64Xt6ptHUxFG5OYvl8qlQc6ZnLaSzz0Aao2jK4Wa1GG?=
 =?us-ascii?Q?zcHQAiE8/GiXdUGf0uYgeK5lq+O/2DNxgC48w20IRz1f5CH+Q/m/v4gFTP+s?=
 =?us-ascii?Q?4eLmOF7PCJyV8hC/spKU+wTSQWSWvAxE47epTPmAl9wROmzu6YGGbW8j0yXi?=
 =?us-ascii?Q?81ZAlGd9xBsvZHNoNpXLJDxyzNNzWjefnE9BxrXUMEl6oW4Dm4qvGyHIBbLJ?=
 =?us-ascii?Q?M4FtvEPuiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed9971b-6722-4afa-42a0-08ded5844bf0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 02:15:32.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u89NbhhnPlsQV3ETezLeG8//oUxNEX+VHVDmvaiEkBoUI7eZO+hFQcaZqG1XNzTAA4QSG0PhEgOhqNK9ES0kNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479

On Wed, Jun 24, 2026 at 10:41:47PM +0800, Richard Cheng wrote:
> CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
> size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
> kvzalloc(out.size). A large out.size drives a huge allocation, above
> INT_MAX it WARNs and taints, and with panic_on_warn=1 it panics.
> 
> The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
> to min(out.size, payload_size, device len), so the output buffer is
> never written beyond payload_size. Clamp the allocation to payload_size
> too, matching the RAW path.
> 
> Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
> Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Reviewed-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v1 -> v2:
>     - Correct the Fixes tag to 583fa5e71cae ("cxl/mem: Add basic IOCTL
>       interface")
>     - Drop the reproducer and sent it as a regression test in ndctl
> 
> Best regards,
> Richard Cheng.
> ---
>  drivers/cxl/core/mbox.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..d9cb02c9f72c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -380,11 +380,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
>  		}
>  	}
>  
> -	/* Prepare to handle a full payload for variable sized output */
> -	if (out_size == CXL_VARIABLE_PAYLOAD)
> -		mbox_cmd->size_out = cxl_mbox->payload_size;
> -	else
> -		mbox_cmd->size_out = out_size;
> +	mbox_cmd->size_out = min_t(size_t, out_size, cxl_mbox->payload_size);
>  
>  	if (mbox_cmd->size_out) {
>  		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);
> 
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104
> -- 
> 2.43.0
>

Hi folks,

Just a gentle ping on this one, I've tweak the commit message
and send ndctl patch for it.

Please take a look while you're available, thanks.

Best regards,
Richard Cheng 
