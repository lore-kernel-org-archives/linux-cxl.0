Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C490947B436
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969994; cv=fail; b=arpy1swTEGWweG2w0umn2M7iB5KeoMTNWMNupwTl/o0z4yFqq20EY/gshLbvHE3W2vOHiUZ4/IxEcwmiwhhVNkI3NyBeJ3Xh3BCFiRXnQY75TqYu1DXqtxdZ+CXYgLrOTTMXhaA+YLs5fxK7fhApqKFL74rbRLwqpfm9nGCfGzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969994; c=relaxed/simple;
	bh=044RzvGmOO0XPRsrOaPiQ1v+8RL1tQUX8Bmdxet/mjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b/CnL0/Jrup949myr6/piI3y/sENPVVRL6TCYbjwpuUy3+wkrS6sc2yNzbDvNm1cSk8C07l87f4wxqbsSL7oNgrzGJVOGDSEo954JuDhyvTshz8WC9A17dQoeFN2Nx/njpHqV1SAa2ogBKnbftTrcsmWzHYW6ZRbjVxlkyIJYlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCOPdKGj; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCOPdKGj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZdxL+rnrvyj1FO04YVnZA698mii5aydzVFcEUur7JTpkdp96iJGTzTLhR9A169puDk+gGk63ZdI7SM/P5Vdz70V6PiLMMHb4GCKO9TIQgxHEC+nVDq2HlEhoa2Nc8bQGuPlucLvd6C9tT1eXJw/ZNS+nNGOhxnWJxndA76TWCuvNkt3N/FbruOLOfH2mn39Hcc4TFVXGq+oMqpLOKU9z+wVQRh7KOybflj0i8DUqUBwVARZpqAP5cJuE1CiO5t2ruuZJiF9C5mqVH5M+gOi6rWXY8CMMdcWzVkYaZXErbdXwBiS+nGM6YAFi3i5ueNsUtemvXr6WMxv1ZPdFbghow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqfdjSHkkpHATcZtLZOEbax8myDw2sWBULa6hTCmM/s=;
 b=F0AgY7FW4G6qRKD5+xRmBflFKqlBtS4adjTnMGGmKfiiMTgp1f7O9MyS4CVwVqDx1Kj9maj/JUDHmDPYzw4RBy9K48BWuJufNrnkV+OQGC33agMS3qrt2vFoeanJNoPM1Cc8E9jTH86knCM/umkX9TEnPBZzPiLH+5+z6Jo9HWPaZa7Crdoc6crjLZzjRzEUmh5F0/unWvWJDNaaLriEC9SO2KEbQNVsUMIqRlzmcOKQIcJ+XceUeXJfYWvhNPBtsml6VZeYdP1b13pa+vAgsZAFc1pN7JHBJBKD9v85UsE7TH3Kt7Z/uMXZKjy8VS7HBzZksGAk0Ohyg6si3QZYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqfdjSHkkpHATcZtLZOEbax8myDw2sWBULa6hTCmM/s=;
 b=XCOPdKGj+DvLo0TCa2OwKfKpuqXiLLbJY6x4+W9BT+uj1hFoMVyt1xguzG0MiCJfDMBgUvDwlZOgk4IWqk2xsqkOe1FFN6RPIXEqywE7N22Zfw3NG3Xv8TXpUDjZemIB2qWNSMoUZLh+S/c3h7Zxnb2N5CJj/oVdT9X/xlBbhpEXhGPOfS74eCyJi9kgMbo7GeRv9pxRxjc+0jU1zwqeUY8V7t38p/hWZr9tlNGFwzxojBYpGyg1GG0iLqOCaI7ol0mFwO4bOxbImJ04ir4wWtAiLeanIG7WKXnJrBvdBMrgbDk6YtDGNIxY6GDcIe2KidZVa6wn8GSixszxbsH65g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Wed, 14 Oct
 2026 09:26:29 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.020; Wed, 14 Oct 2026
 09:26:29 +0000
Date: Wed, 14 Oct 2026 17:26:21 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 4/7] cxl/region: Factor out
 cxl_port_parent_interleave()
Message-ID: <as9IvZJ8aAU71yxY@MWDK4CY14F>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ac5e6d-5f60-4e04-0210-08df29d539b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|11063799006|22082099003|56012099006|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	AXureHdRH925FvVn/C9XWdJaomTe4/w9dv/wEQI+yyQPdaeL8coZUjWVEio7Vyf7JApZR7EBZZRCc3DHAk6AyOXK99UGLBRkFIF7Ek5RmHInn3scTwjhjRj/AGYyFOuMRntWhOuBZpdUYHkrYIc8q6ZVROGohJdAa/LqpgN9kuixFF9R2FNQ4yeY/E+3EjP9OY+HMxGxgmKqxehzScokU8Bk+FIiO44X78zb6vr5BY92Yfl5CsKuuq8JhaHHqeTZr3gGirhOJSUV73MR7T0Kr36BMMjb40cf1/tDnlISBfzTwQU6VN+JpWYQwWrdzoJTh3i97eiT/OdEHGUiCsYflGWrXSH+syPmmHRdU0mHvvYY1d3RD6xwfX5TljDm+Iqy3nB63qQsAp6O5LBjRn5lYbyTJzRcrsOD1FUGXUdGsFD7SZYvNGE56aL26Lwq60ha8oF6PvZkaglJSEi/F6QrjFd+q/KmtViS+kKtrYE/+zYDxRCmxvvcHHnAcVNc9yYFrKHvway/x3U/xbpE2ORb0nLMLvnN5bPLK2jIKW9t+YujNCDtKZyW/3dLlWQ4az26BsV2zVXahIeziJ3EdjmZhwk/lXYq/Of1iL72Iu9q7HJXLdm8n6KlzW/wRMeVU2spn2KKfFyw7sJ4SV9GYm4l3dlbxVMkwd7P3qnqKsLxlAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jzeDmhzMpOi8KDrQ5DD1SXib/rDY3M9dkG2mavvR911aci/Yj1zH03KWnmhX?=
 =?us-ascii?Q?41R9XhJJCI0NmEcBFXvbtrWRwlblad8vGz8+2UyEjj9FIGsrHAnEe1+YPtSn?=
 =?us-ascii?Q?DGbFiFac/8H9u7Cyrl7QKvCu7Gw47M0zioB8hdYNHYGkB97lPtxGrjgBF7u4?=
 =?us-ascii?Q?U68pPFPdMAdP0s/r9guvR3ozsOgXy0+ty2OXWMJWbX0T4lvXgqF74Sea4vKo?=
 =?us-ascii?Q?de1E6mLSbuEsLnGiNuF1GaCxZs3aTDHuilGirtKN/g1H92CaYlXTm5Si2qVF?=
 =?us-ascii?Q?Q2DD3At5XKJCntz1i0PJTcGdn4E1STJCr/9FrcPIA2jE2KoJO+aKu0MbMsif?=
 =?us-ascii?Q?vk7XrC/idyjVVZjjCQwA2NIJ03rhvDEqx81BGj32ILpkNaQ8uB+oCWF7sAGy?=
 =?us-ascii?Q?LTHRE7elVPha0oMiMzTHVN6NWlVb0656fBcp4h+JtWya77Z7+OKmggJ7Y/Hu?=
 =?us-ascii?Q?d2je37zT9qF9rQN89RA3xsA259BNnvS0enfUfQmB0xcGnvD1tYe0HAt97wrE?=
 =?us-ascii?Q?nwruB5UdnyqVV6yN9oVcNr9tihVpIzeVDNBmBs7wwe5ZHgLndm/rxjSc4/+b?=
 =?us-ascii?Q?TQvcmhteCLss+vOvOoYNTM4+I8ngXmJwbZYjmaR14h+vVFmC7Qqczztot3qL?=
 =?us-ascii?Q?odZibj/1qdyNt/+iyHHrFZtW+U/0jGIIcUv6JxKXYr1rDeGEjVRCl4zPHS6S?=
 =?us-ascii?Q?cWCCnEzfkq18Cq2YWFRJnEI9Zxrn1CexrbhMIqPGudxWobSCmC8CuDBiE0lk?=
 =?us-ascii?Q?12h3c+vkEPUGraYeYccoJ4TRQZ4tJp5tO+7qfLGUX5GyMNlCCUmjGwb1kZ3C?=
 =?us-ascii?Q?Z/Cdql0/IR0L7mT/gzVMxViWDnziCJly9SE9wT4F+Yu+DPBGcf+qxM2a+q5P?=
 =?us-ascii?Q?Fhw6o5+NmTeqmyNkdWwQSe820Xs+7IJxIhNoON4A/8fU5vRqQ0Hm9uglHTym?=
 =?us-ascii?Q?YbvWaO0TcyRXh1ae9if+r3NenrTSNnxZ9IzdovTZJtIvBgAbNbR4umqNFWBy?=
 =?us-ascii?Q?AXKg+Tw2MVHFVZJMFroWJBsvWXIbyEvhfXfEJ1lTecY1Rzk/UzZmi9NE4m1n?=
 =?us-ascii?Q?wmsBrMLKPr9KChf7U9NOaUiW4SACDndTvuI1HyNBQYqyocdsCYAI91KXzuTI?=
 =?us-ascii?Q?LW9cLH/f1iFWjWfWZMBhqgiOrec70kcMBuXkXEE9WBkr9TbGe5vNVdQVmzV3?=
 =?us-ascii?Q?cBLtjR22F2dN+gNBHvZ4rDteGKHS62GMe8RwmxxYcfHGLznPYSvttvTpPS2w?=
 =?us-ascii?Q?IShdn+IvSETvPsieLYOGPcVcMucpMq3XhLDRtlUvbAZPi1mYAbOlVsLS4mfW?=
 =?us-ascii?Q?MCQdZkF7KmpaV+p/z8GGYRYAC15DVfhS0MQ792UbdHtv3SYHM2caf7CvV+KC?=
 =?us-ascii?Q?uSsw85x4b2nsTRD2PhPDLyqbfwPsIjEjum6Ezq90+qKxG02aU8zuwyCQUFKC?=
 =?us-ascii?Q?iQc40Vx4YzfAQdO9CKhokLd5Q5bju3ItjW32owjHcc0maPYoIkL8bVcaG0I/?=
 =?us-ascii?Q?mvWcXZPJ1TDjPfqQpE+zzxM5ldqU/14Oxxj4JApQlNhNOkA0B45/k6ot5R2B?=
 =?us-ascii?Q?p2tsM4Vz8V3m08vPU8/EUh1Nsmcv8KH6GjRUC0xmLnAyTbjzT6v1hnEBZUwt?=
 =?us-ascii?Q?uqbWe/1EngdbTcSZ2y7N+x7LF4IwbvzDuYzp4hWVKPp+cV8hO6Tt9u0lbehT?=
 =?us-ascii?Q?/hZ+xzmKBeLIlzBAPysJg1eDWhWOPJghHXkifm18NZVvi+dxLfFkCx5E5jlV?=
 =?us-ascii?Q?BvKmODe5TA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ac5e6d-5f60-4e04-0210-08df29d539b6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:26:29.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUapeTlP4uHg8KJEBl/HrdbTKg1KCK1WHZwjvMIdvHf0OQYVbhuNsBdpRiLh3s6yHkMV1XHuoIpmsjDh0fjChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9734

On Mon, Oct 12, 2026 at 09:26:00PM +0800, Alison Schofield wrote:
> cxl_switch_port_setup_targets() derives a decoder's interleave from the
> interleave of the decoder above it. That parent interleave comes from
> either the root decoder or a switch decoder, and each case is open coded
> along with the parent validity checks.
> 
> Move the parent interleave lookup and validation to a new helper,
> cxl_port_parent_interleave().
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 88 +++++++++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ea281ce4ec49..c14ac041c4ac 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
>  	return distance;
>  }
>  
> -static int cxl_switch_port_setup_targets(struct cxl_port *port,
> -					 struct cxl_region *cxlr,
> -					 struct cxl_endpoint_decoder *cxled)
> +static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> +				      int *out_iw, int *out_ig)
>  {
> -	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_decoder *cxld = cxl_rr->decoder;
> -	struct cxl_switch_decoder *cxlsd;
> -
> -	/*
> -	 * While root level decoders support x3, x6, x12, switch level
> -	 * decoders only support powers of 2 up to x16.
> -	 */

Hi Alison,

Can we make the comment more explicit ?
For 3/6/12-way roots, the helper returns a normalized out_iw of 1/2/4
rather than the parent's actual IW.

Maybe we should document that return value convention ?
Simply browse through the helper, I would think it just retrieves the parent's
setting.

Not a blocker though.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng.

> -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			cxl_rr->nr_targets);
> -		return -EINVAL;
> -	}
> -
> -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> -	if (cxl_rr->nr_targets_set) {
> -		int distance = cxl_port_peer_distance(port, cxlr);
> -
> -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> -			if (ep->dport == cxlsd->target[i]) {
> -				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> -				if (rc)
> -					return rc;
> -				goto out_target_set;
> -			}
> -		goto add_target;
> -	}
> +	int parent_iw, parent_ig;
>  
>  	if (is_cxl_root(parent_port)) {
>  		/*
> @@ -1539,6 +1507,54 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
>  		return -EINVAL;
>  	}
>  
> +	*out_iw = parent_iw;
> +	*out_ig = parent_ig;
> +
> +	return 0;
> +}
> +
> +static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> +					 struct cxl_endpoint_decoder *cxled)
> +{
> +	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	/*
> +	 * While root level decoders support x3, x6, x12, switch level
> +	 * decoders only support powers of 2 up to x16.
> +	 */
> +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			cxl_rr->nr_targets);
> +		return -EINVAL;
> +	}
> +
> +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (cxl_rr->nr_targets_set) {
> +		int distance = cxl_port_peer_distance(port, cxlr);
> +
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> +			if (ep->dport == cxlsd->target[i]) {
> +				rc = check_last_peer(cxled, ep, cxl_rr,
> +						     distance);
> +				if (rc)
> +					return rc;
> +				goto out_target_set;
> +			}
> +		goto add_target;
> +	}
> +
> +	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	if (rc)
> +		return rc;
> +
>  	iw = cxl_rr->nr_targets;
>  	if (!ways_valid(iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -- 
> 2.37.3
> 
