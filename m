Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219634B8296;
	Thu, 15 Oct 2026 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052242; cv=fail; b=fKU1hyyGPybpwDK8AH9+TrvTXzJ17zvFdEBajlO6bTFlns/9Nx0kdDUIT3kY3v1nK3WfM4TKep8Gc+bpWuyJz/GbQ5PtHW1Flufsg0fBS+kNtCWyJg1c52/uNWPwK1rCyLqLhA2y8LPayoUVYMGveDlZFjsawQ0ghHPHCsyw+mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052242; c=relaxed/simple;
	bh=GAUINSy+9ULF+fbE88WO6b8G+4vTGd4blqi6TbmJe24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pd3k1oQSOm3fxHYbiX7eyGns8X9k8ubFANYazZhds1Y1Pyosc7Yf3u+g629TxGoverpHpoiVDuXwyTeL5FX9z7SGOPpON9/IkmYwTSSlanBzYFzqZ2d9btUve26H76fLyXe1D4NIBjz5hk0dXukOz0+4Ae/qDF//h1pYGwAY8ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WIjt2Y26; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WIjt2Y26"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LptJMAoGI1NerTx1dT5pYNNeasvKxnjHuRV4SlR8WcohIFl0yY/s6F2gOp6OHg7ghhw0HY+TeQeaA9iNHogRYzps6pOJCA4EoSTWlXLse2AGb9QZushJ10sqPkuEeF683ehHgTLfw98Plq9lvxwJCDHmdxThO+vSFxbPws+UrJBPA1tNVCrlTjfKpb8Md4ogSAlnfiwdgUtMDUQEMI+pcp16Ru4vOhC//96smlSD5ojVYCUC2Yd3OkFkfBllJ/we7ok6EL3yavMw/bDvVli1W0Bor/ys8v7j9BH/G7XUX5CKaE79xW3NhrtmeAdC9yLM/DKa/0WEhjmNKy0DNvzocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjsdVu8fY/buRr+9wLm5C5j2+0iFTOYZcmvqrE4dSCg=;
 b=uqUfE64q6e0ACTYBtYsRYRp7BLRnlxQn9a1dqLlhDFlcQh5H4rBzy9nCfwA4G4OVOiF+U5ZaLt1V3iypa4kA/7lzy3sOK96KxhETWE7YUPNqW4+pZnON2zOr6fZAVcxzgnCL8k1DmFdgO2/UKzSsC7vRzUdaNe+ANPFODO6X45hnJhQDu6sbaXLhONMP7V4TuxelFi1MacjyRj8QYWOMyUzY/xZMOiJhPW4LTdTaJOvgaCUZmeiH18KoPlndZRCeNLWfpYcBvX8RSQUfeygAWJsf1HiFC7XPYsfbVq9NlNxAQD6uYUlWiwEQhCEuMAIp23VBQKmUz+6jHl1wWPRIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjsdVu8fY/buRr+9wLm5C5j2+0iFTOYZcmvqrE4dSCg=;
 b=WIjt2Y26WVdtf/goRAditZ9ZZBGTTsdRt0wHvrZwqQ9HYgP+1eybYoTJSbioGzhMh4osTgNP7QVNbBSfod5EjZ8tWhXagNsHUNDY/+Yf7ZWuuFZCuXxz1ZRuIpOT8w8f7yJR3W8N6v708oQ9ZtcGMk/pdkBCmRWLui3R1FjqfMutJ9CCZ1P3+2+1JCnw4txyE/1PBG1L0ZSk79uwB2xQSnsBEFgRDBZhonX8sp6q4sgeS7HP+BsdK97Eq335Eqv0BhwVMGGlUvalDk4ZHXpYKqgT9mTugJMh6/zrKQK+HnLgdcIFq9u+UvjfHGEhp8zjVn94oJ2DMjGBagY1x39FBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 08:17:04 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.020; Thu, 15 Oct 2026
 08:17:02 +0000
Date: Thu, 15 Oct 2026 16:16:56 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Gaobin Huang <huanggaobin23@semi.ac.cn>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Add the CXL 4.0 command return codes 001Fh and
 0020h
Message-ID: <atCLjvE5xJp9jo6L@MWDK4CY14F>
References: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
X-ClientProxiedBy: JH0PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:990:54::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 50771e60-5aa0-4090-df1f-08df2a94b0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|10067099003|18002099003|3023799007|261009223027099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fXhA79Mn4Phkyab5gzJlB9rQnLKb9u4RdlO9acmeWqro3RYhmMviGK+I5y/N3ICsC/qdCKHpc1NO/mT27yg2mAH4Hka84tHzsvGcdH1oMaEF8gm0UNpwdfHLWb6lcJglYQ+dorBziBBIE6/OwcsF+usv6dlg13UtlveQ4sbqDuOjP8x8twqohAkBodKy0L03wQ6GphtkgbFfNIrzpgXo3qp0d9P/eAGKPSofyl12p77yBpuwC+iyMY6HY/ucLjr+QVhoPTp03G77/XYf5h2fQ7P5disPSXFv3/SWe65QUMhvkhi+AvQPPM+tPM2FviM+Vuv/YlFaWsmzbPnDijNqzWSu8KmTQH/tsgw13f3KrQjItbVnHlIjyVanVrNuXG79d8CpAU12j3RC4dsHf9yzqm3wRLGY+rP0LOueSqCy7DhlsO/iWVB5fkn+C7nE4nrTs7OhvpORjedNz/rWa8XZgtwaRy6H1UNF5DH3MiX0lxDyJpyb8OkvDeOdL2CEP7KUj4F2DpcgrVLI98s7UetHLfGr5mKm/PexLjxYnKRA5Cd99dplC/cFUrxVCMDYbmdTQWUBbtaEyIaoyt2MXaF2tEKKhYaPtGF/FrersN74i8dF6I68vrTNh5p3gbSC15ilT6AQYSyl+O5rrLNX+M7x6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(10067099003)(18002099003)(3023799007)(261009223027099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zw7kSAUOk3m8J6LBMtK6adqxaG3TomTyW4bhXHbvGrQ6AxFtH+/Q4G2EAryt?=
 =?us-ascii?Q?qcy/rdzl5ZtDTuLSWUpJwLLuXlsD744TVe/S3j77EmoC2QKD4g1jt+rPEnb1?=
 =?us-ascii?Q?Ev7hF6GH/wNBa1C7TlZRZVwye+AuVfcOGokuct2DGTrWpXrxauNydVgcDyM6?=
 =?us-ascii?Q?ZcBXherjXaFf8UVPcXikREHKBi7600kLUk1bOlTnuAiWzzruSZG9K5otQs9c?=
 =?us-ascii?Q?rHtai+XPaB+yUAKFqLEfPVpF/fj+motykRCHdJM31VCHciaNh395MoqsLV8q?=
 =?us-ascii?Q?8ODxKeSPJN4k7Fd04fJA4GWfMswmUn8DWlCphp1lOy/2eJpzIR1dkGCnuJ0n?=
 =?us-ascii?Q?bMw16I9H9SknrNy60vcS7RCe0OfFw5bHhxW04RpGoJYuqIdguWWU8PzyBadk?=
 =?us-ascii?Q?NiN6Wa/cOhp4ji3oSZNdwntPk44enB8CfgBbvILCTYc0mcFsGoZXtnNueOD+?=
 =?us-ascii?Q?+eXsOkoWooErHp1qzFeaQakaRrSOUCrS1WhmDz9/+q6gQ3OhP0bMwdHOt3z7?=
 =?us-ascii?Q?sJsS2y6uOvSCOTrI4QLAz+NaRkT1lS1e1Jsao/oq9ARmsiORxFVt1Wzl80cA?=
 =?us-ascii?Q?DdyXIHgN3zoUIzG0EGxh8kZw/N4GENsnosiJvzDdmVILpfYIZOqR7J3HmOUp?=
 =?us-ascii?Q?Sv/pKaA125OvengMAJtrSxPxAWq7XyCVRUSNUX7Gnl7I9tyAKMl1Tzm91e/h?=
 =?us-ascii?Q?nSktkW6lx0s5I80u9FrnJDSWhkGmUzOqo2NfS1gG1hJwYGJ6Q0MG5KX+FRvf?=
 =?us-ascii?Q?SgVF5+LOrhNY0q7YMX3W3tLH8pwr5BR2m71uvyeWTKIQQDtacYiS5B2DSL2N?=
 =?us-ascii?Q?/yJEObYGi+HmDVRmBxsx6ER9Ptv/HoPnlXoFPRtBMHP9nQJ/RMSudo+Ph+dq?=
 =?us-ascii?Q?PFII3YMfrOtFcgdXb9mhofxbTVrJCDAUXIFckj9/u8thBgutXLLH1eYfKcR5?=
 =?us-ascii?Q?OtMh3h8/Ia0DpuuiWAz0pt1uUj/tZMItswDG9PeByQKck5eOqB5rw+PLxQaQ?=
 =?us-ascii?Q?ZCz39ocvxKHVwKJpcrfRnWE5zKaW2UpIznCMFVh7Jg+AUYUSURbgvg6L73r6?=
 =?us-ascii?Q?0hXo49d/pbyQDxZRRNfceJjDX+JF/ditgf6PhRnoU8RvFhxhryjECwR0X2oQ?=
 =?us-ascii?Q?YIBnJilJoGiVaqgBAeeyHO3MKwzAddU2DTW3qohms2WVnTSVLI7jJpww2G/x?=
 =?us-ascii?Q?AdGDGrhhpcg29pMG2Isu28mWhepNxnIdV2cz8x02n19TC4QBKi+yuka6+diA?=
 =?us-ascii?Q?8PYIwGk89J4kMg0W/5Gtr41G/LaiyxsQzQIJaQaQHhcbcx5VXg+xu49uNCm7?=
 =?us-ascii?Q?RAPsbKCosFHntPBM2jlXxd9P2JJo6e3jWjysWCuwXfIyE3ZmHlmnmGHroESG?=
 =?us-ascii?Q?y2C+MZ6WYUGhwioFzZ37ypx/xydLHSm+tzHs2wQ0PcBKxe6Hbwx0TD+x2k8W?=
 =?us-ascii?Q?zS4vp7WpaGs6ZQ6ZJeI+3F8qSKRms22PrVhNARPxpyDAZgd6RzJN3wR1AWAP?=
 =?us-ascii?Q?4EH08tcrPFrzD9u48p4Hdnc1floLFZZta6COqNWPgyDNrbjzQgd52F8m3fY4?=
 =?us-ascii?Q?E7VXp4wKS/Vz3ttL3V8on3QB8lkHW/ZFDtQtRMoYleq67Eg97DAxUPnEPJ+M?=
 =?us-ascii?Q?oETxc4i7N+blaJiktHVi7+NCQkE6Ola4n/QFIJ6R3e5iHHgy7sjGMcmMlisA?=
 =?us-ascii?Q?jEMJZ7Rcz7mhzvv1apeDnDdPKe0hGB/W6JrLQ02d5grkUYZr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50771e60-5aa0-4090-df1f-08df2a94b0fd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:17:02.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGatTjQQ0AjXK/ue7pGz9TDWf7bxHEyyxD2f/l25vLfCsWvklzs4UUKhqHKmLUpBnaQUsTIU/5FYdfLL9sF1vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C

On Thu, Oct 15, 2026 at 01:50:48PM +0800, Gaobin Huang wrote:
> CMD_CMD_RC_TABLE ends at 001Eh (Invalid Extent List), but the command
> return code table in CXL r4.0 Table 8-208 also defines:
> 
>   001Fh  Transfer Out of Order: The input parameters data transfer was
>          aborted because it occurred out of order.
>   0020h  Request Abort Not Supported by Background Operation: The ongoing
>          background operation does not support the Request Abort command.
> 
> A device that reports either code is described as an unknown return code.
> Add both entries, mapped to -ENXIO.
> 
> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
> ---
>  drivers/cxl/cxlmem.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1a..43f29564c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -190,6 +190,8 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  	C(FEATURETRANSFEROOO, -ENXIO, "feature transfer out of order"),		\
>  	C(RESOURCEEXHAUSTED, -ENXIO, "resources are exhausted"),		\
>  	C(EXTLIST, -ENXIO, "invalid Extent List"),				\
> +	C(TRANSFEROOO, -ENXIO, "transfer out of order"),			\
> +	C(REQABORTNOTSUP, -ENXIO, "request abort not supported"),		\

Hi Gaobin,

Do we have users for them ? or potential users ?

Best regards,
Richard Cheng.

>  
>  #undef C
>  #define C(a, b, c) CXL_MBOX_CMD_RC_##a
> 
> base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
> -- 
> 2.34.1
> 
