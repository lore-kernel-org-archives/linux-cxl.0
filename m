Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD239AD2A
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967407; cv=fail; b=Zc0oY2f9+hCFuMRU9VXwcNSzNzlu68BvqYkViiECTFmONIsP1ivjz72Mx0KBi6dW6UnwrCkPIBKwPUSYg84wPknnHWdh+PKOVQ+4R0DvyCGIM4tmYVQ0+FWdikTLx5goq/a5w69+HM2pghu4S1OdRAvE5tuFTli/Ik7ipg2LM54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967407; c=relaxed/simple;
	bh=xUzG8HEraRWLkDYzZ89i6fc0TZYIK8WW4kMywDiIBlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZ3egL2cj7hBRy6t2dfZtqb5dDqWQMYA+8Vk0oP6iJGfpRHUJs9X73ypzZFVu4tgoPfwd+6bg0DCAwn7xydOwkex87g19D47cT+Wh14qvV+e1izR7D8W6cgBtladMzp24oHSWbD5Z4OR7Sy2mSCgtLYqO+jui5llM7bg7VTEITQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MjUsDmn1; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MjUsDmn1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/yiBsjaoQ19tpqxikrMgrFgJzYxpF99FPPRtA2EoLb1X1XWGQQ1gIsnu4h+EpRhpzR1X1D47ETH91jijfo19f7uFcAVwX9xhcBxtzWvrSwm0sQ0WAAP2l4rPw8W/rwcnqa5rhgYtWaauB9dOU1i0sGHVZ4pzgKyJY7dCKVOPDEWzNOP/aY3asLm9aCYvnpl0x7M4YmTR2NAt2pubrbdjWiBzzqLd9NMukP0nmWCulcAy4tgkaPF+13Ibd0UuRU7oXu8/qCTVGdnb/M/MqhzjrdOq1DhaJSr9CA41AUwj3NK/T4W6IL0ixiTLb4RStpy62O3v+pAOU0lIkTP0JtWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dCPIle7h4TwaCKKWUD7Xpjzx8lBxRNGA3w9oPqcq+k=;
 b=bUBAt6awFKcnrS8s0IdZfQf79cMwtmgz2mTDITgJyr5Ue4x0vFMuWbT4wnJLI3A4eMmjeMHMzl2mHaXYReetoINPviZ0SqqvTeJtaqGwiuBdEbhAi+XOWPCfXet7qNelFwkKnNbWEXzMFH2zX5xycekxTFPt0yNc5ZgjMDgZXIh9YvQWmuzpUqtCfb87FMapT52p3IV2doajkFudr6lba4bRZhnTqRma1bj/zH0XeG64ct4zOLLElahQ9nB/rjRAf3M50QhORIu3K//k+ezldz79OTomydwLpWgFwtm5Tlrd/4ej/4k1Ny7LhUeBA/ZZKEfRV1YipWNFAnbFz/bPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dCPIle7h4TwaCKKWUD7Xpjzx8lBxRNGA3w9oPqcq+k=;
 b=MjUsDmn1sZh5Uz1udpc6J9iC88L2ZbWh71YZPLOu1UN3GNqNDhRsTIkSwqHFlDH6hJZClKeIW17NBYFAe+6KazlqK64DMh3adIYa1dtnd+j0c5kKLdMM9pkjUtI/O/uBsLHTOzdXBYJ3PFn147ofWPOOnAO81sOAKNu1wjkIAmS6zYeGRmWRKnRESd10aj6XW+JaEL7cGM3sLf58nRdmLU28jXeycJmxzML3cygUb8UxnbVvK0mco7hYkFvt0uga1EoQwM6Kl3IBy//VugXPhcRVhbAVsuVoqI+o9EfzFhwvdzv1DjLl1vCu+rGgoqTqYdAHQTbqklFKEu5wOEFRrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 14 Oct
 2026 08:43:17 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.020; Wed, 14 Oct 2026
 08:43:17 +0000
Date: Wed, 14 Oct 2026 16:43:09 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/7] cxl: Add interleave encoding validity helpers
Message-ID: <as9ANXkFmGMyE6o2@MWDK4CY14F>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <17c9c350c9e579cbc059b02e0e22ed513c54d468.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c9c350c9e579cbc059b02e0e22ed513c54d468.1791860305.git.alison.schofield@intel.com>
X-ClientProxiedBy: JH0PR01CA0065.apcprd01.prod.exchangelabs.com
 (2603:1096:990:57::7) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b61fba-953a-4723-4d8f-08df29cf311a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|261009223027099003|10067099003|56012099006|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	YnrUvY9nMcMq3gwL63eS+ukFjt0yVQyQbhNtugDGKzwG2Vauw6Y+eh2RzhFsXdl3fJc9V2WNwpnlK6f/EhAezkJotmW4nVuvK61RAQ68PgbKJy52BDfvQoWCmTU9lzaFGXgoEKbhtxXTDKu6CtTrqBnQuNIQe8F+oGFDBeVhuo4mFQbwryOwW8ilgbiIOodnASBMbslhwCSBsdIZ3v1Rvi61C4G/dky4MhHok+Qic2uJAKkqQIUdhDqi/MNADuCsLoFF+2EKtpSGxkdmYOt8X9lX4lNrQOIx4dbkmdRNXcZ+Rx3+dqb/WbrOsNyN+7UQgi7Jpi52MN0lI+9lmsR4uG/eDtHbyzoSDshuQ4NR4/Jv5oN2vhky/OVg7JJLlEWu/N80Q6wXtgTBaMMUIaHjpUrPuRrtmo/PqlRhB1AWasnD9FAD/n8loUOFvgL/G8R3YlxYqNxRwJImZ51D66BHXvvS5YntdwYajllF0dLVdNbeCvlSljEv8/pqitSsf7ia5YnAihN4NS4bObcdWsc2B/27cZxopW2elCvZhXIT8haFF9P6ADavYivieJjDa+5XYJa18w+mkZPtt5HO83VV8xId/cH12tKYKuhEpPy+X7jCCxHolD1FUyJJEqTAgI63N7oc6XT0TfMRyqZXu09+RTMsddQ3D+S+K6RDEA4QtMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(261009223027099003)(10067099003)(56012099006)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naG+Q8BTP5F1AjvTudRE9wHXhIXm3HH1nCFS/GMJR+tw4ZFQJhc2vwfYbyzY?=
 =?us-ascii?Q?b8RP2iE1RgGrU2sNsiU0l0CyGslJ/OsTkxWgroQPgndtQjhNMWp8Ga7sFng8?=
 =?us-ascii?Q?rTtqkecwfrUYKl65D1t+3yfO3uvuBEK1+x9xRkyjXCxAUau5vX/m0C9GZMVk?=
 =?us-ascii?Q?Bt7sD+nACotJclfwIV785J3vB6zfox6Xm+HDsiJIpkg2mU18rBVeXrN4AMHV?=
 =?us-ascii?Q?9/kUrZxnyc9V3udIiSXeH4Zm0xSMaVxsZlY4dJf8PYvDXLXmXlZm4khvxvLk?=
 =?us-ascii?Q?C+3Pd/gzGVum31LDvBHlqclxfkTWNVZ+sZ4krNimq3/d2HHVZeF24vKvS/EG?=
 =?us-ascii?Q?O0Ij5ITRP0HDglW4qumaBtWcNVqQ7Ym1pZOJFihdaWzMqvIrnpErPePFOC3p?=
 =?us-ascii?Q?WVnWBf817QOC5cF2nFjXciwzVd3MeW09BwezOxB6EStrlFQ8/RVXXQgu9cX7?=
 =?us-ascii?Q?3vmTg3cUX0kksUKno20rpwuI4Hk7Hpc/1SeKM0xBKY7M1/BBz/TWB21po796?=
 =?us-ascii?Q?HNaT7lWjBOR92sJgidMAa2PHQS3S08txRlWr+qapKj5n7QKuPnHtSGCsHKR5?=
 =?us-ascii?Q?RfLQa/8V5hjpMzZeq3NzgTV+eA+tQOxOJhUtqy1/JUXltMTJuPIdgFqpeQXt?=
 =?us-ascii?Q?bKK2u9aZDcbrFg+leEJ2vVn0ZsV4L1r3pM8Er85fsvDDlpJPYdQRp3DB8E2P?=
 =?us-ascii?Q?3J3MTZzweOJZlrBe+Cg/cVQMRSGfgcdPhnq1GRldI9L18+UBj+x+LkOtUJsS?=
 =?us-ascii?Q?HmSGMF+XAuOW983s2QIwNKPP+kVsiIES5BG6o98kPn6lTYD0AEZvpkeIG6IE?=
 =?us-ascii?Q?4xPTXRg5R4XrVoc4YjpfnBVD059URMi9Dh56CJT8iAgipX/+qSllmK9itHio?=
 =?us-ascii?Q?Nm3+/GIA0oU+ODN5Ma8CToPxXkKKF7Q7S3qK4C3QVUGB4jwSnaHnAtsf9TPe?=
 =?us-ascii?Q?+QO4DF/ZRFaDFukNaoSOV6sEJX+7I49Egh8JQYq/TpO0RF35HYGjJDfJdW7m?=
 =?us-ascii?Q?J2M1qJVf+wPwE+YSRD6GS5OblOlAPS9MFrmmGkOG9K2rbR0qhPQ9rQ16ZS+C?=
 =?us-ascii?Q?WR0qB/hGmybAe/WsD+HdXm+wI63O622+XZDTouCTvWRB3iS7QM7n56i+0IvN?=
 =?us-ascii?Q?zP5Wro/3NaNeKMng13IxoFHLPdLi+Vj1iwHuHoTHWo5rv6krJdtANMbGwEJm?=
 =?us-ascii?Q?asuZpJa0xtZjAKNet97YrE5/bohQTOwbEMDbBd7U6w1glLGlJ98EXJwRBKwI?=
 =?us-ascii?Q?1Uv7W9495WH6KiRVOsdm6Da5QQrj5uSqr44sXx+23utDP+LklvI6GNWxO6ZE?=
 =?us-ascii?Q?yjpXbIwUPwW7YEpTZNLegP7hf0kp3RIoJonke0YsMJ7nA54Ub4jjoH13gMBA?=
 =?us-ascii?Q?PEQSWZBbA2CvjagicjvTLj3LTS/5GfnI9xv4sypZwq9iwzruo6abzePl+TP0?=
 =?us-ascii?Q?nP6/qh8bwY3EU6IUgjMvl7M2SSUiifHpTSy9z6dEEU3if+cpdwIj03xtLDjl?=
 =?us-ascii?Q?Wd7OKKKbO/LugAA7uHNgM1n622a6jhQd4p6I1D4RQ5yrKXN3RTql7BuN38He?=
 =?us-ascii?Q?wAr0P587rE2xKPX78PtccrRa9ux7czSlp5HKGXAaMdQVP5FNkqPhQk9vbG0h?=
 =?us-ascii?Q?m+pAZGNutiW+fzwkO7mniRWEIr5RTnbQkX5xWks7qFdmaZixN1hqBtoc9wN3?=
 =?us-ascii?Q?Gj8gcmimLy7O7JDwoKF/TJXAOZxcVWEcVHoKgZKqSX9vgxFBuKm2IhRsxJ7A?=
 =?us-ascii?Q?q2QKHkEbVQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b61fba-953a-4723-4d8f-08df29cf311a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:43:17.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oji55GAy5VEyvvOE4m4spay7NyuiUgifz8cOaGXCk5QokeY79reAt8fQ+MlHw5h451EaGrGPn9PjOxNenAyHYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

On Mon, Oct 12, 2026 at 09:25:57PM +0800, Alison Schofield wrote:
> Some callers of ways_to_eiw(), granularity_to_eig(), and
> eig_to_granularity() only need to determine whether an input is valid,
> but must provide storage for a converted value that is then discarded.
> This obscures the purpose of the call and requires unnecessary temporary
> variables.
> 
> Define and use new helpers that provide a validation-only interface for
> those callers.
> 
> cxl_port_setup_targets() also encodes and then decodes its calculated
> granularity solely to validate it. Calculate the granularity directly
> and validate it instead, making the calculation explicit and removing
> the encode/decode round trip.
> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

This is a good refactor, with patch 1 only, using GCC 13.3, region.o
code size shrink about 40 bytes.
Measured with scripts/bloat-o-meter .

Best regards,
Richard Cheng.


> ---
>  drivers/cxl/core/region.c | 49 +++++++++++++--------------------------
>  drivers/cxl/cxl.h         | 21 +++++++++++++++++
>  2 files changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..bc087ca63946 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -493,11 +493,9 @@ static int set_interleave_ways(struct cxl_region *cxlr, int val)
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int save, rc;
> -	u8 iw;
>  
> -	rc = ways_to_eiw(val, &iw);
> -	if (rc)
> -		return rc;
> +	if (!ways_valid(val))
> +		return -EINVAL;
>  
>  	/*
>  	 * Even for x3, x6, and x12 interleaves the region interleave must be a
> @@ -566,12 +564,9 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc;
> -	u16 ig;
>  
> -	rc = granularity_to_eig(val, &ig);
> -	if (rc)
> -		return rc;
> +	if (!granularity_valid(val))
> +		return -EINVAL;
>  
>  	/*
>  	 * When the host-bridge is interleaved, disallow region granularity !=
> @@ -1451,8 +1446,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *iter = port;
> -	u16 eig, peig;
> -	u8 eiw, peiw;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1524,48 +1517,38 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		parent_iw = parent_cxld->interleave_ways;
>  	}
>  
> -	rc = granularity_to_eig(parent_ig, &peig);
> -	if (rc) {
> +	if (!granularity_valid(parent_ig)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
>  			dev_name(parent_port->uport_dev),
>  			dev_name(&parent_port->dev), parent_ig);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
> -	rc = ways_to_eiw(parent_iw, &peiw);
> -	if (rc) {
> +	if (!ways_valid(parent_iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
>  			dev_name(parent_port->uport_dev),
>  			dev_name(&parent_port->dev), parent_iw);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
>  	iw = cxl_rr->nr_targets;
> -	rc = ways_to_eiw(iw, &eiw);
> -	if (rc) {
> +	if (!ways_valid(iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
>  			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
>  	/*
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> +	ig = parent_ig * parent_iw;
> +
> +	if (!granularity_valid(ig)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s: invalid granularity calculation (%d * %d)\n",
>  			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
> -
> -	rc = eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
>  	if (iw > 8 || iw > cxlsd->nr_targets) {
> @@ -3131,13 +3114,13 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
>   */
>  int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
>  {
> -	int ways, gran;
> +	int ways;
>  
>  	if (eiw_to_ways(eiw, &ways)) {
>  		pr_debug("%s: invalid eiw=%u\n", __func__, eiw);
>  		return -EINVAL;
>  	}
> -	if (eig_to_granularity(eig, &gran)) {
> +	if (!eig_valid(eig)) {
>  		pr_debug("%s: invalid eig=%u\n", __func__, eig);
>  		return -EINVAL;
>  	}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d96210b8f147..8f0a79e7b8ab 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -146,6 +146,27 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  	return 0;
>  }
>  
> +static inline bool eig_valid(u16 eig)
> +{
> +	int granularity;
> +
> +	return eig_to_granularity(eig, &granularity) == 0;
> +}
> +
> +static inline bool granularity_valid(int granularity)
> +{
> +	u16 eig;
> +
> +	return granularity_to_eig(granularity, &eig) == 0;
> +}
> +
> +static inline bool ways_valid(unsigned int ways)
> +{
> +	u8 eiw;
> +
> +	return ways_to_eiw(ways, &eiw) == 0;
> +}
> +
>  /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
>  #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
>  #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> -- 
> 2.37.3
> 
