Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF0420471
	for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041246; cv=fail; b=Oksy0M1iu/H7q39JVZowdxjHK195p3ailtxj3kbKX6yGbb0TjYPl/mcUXiLn9VtqXe3G59cuSVt2ja2p1BvfumvjQIb6f+VWmXd3k6RAR2ck6BWJGXsLUwpc2YqZ2f9bRrLXXqKIfrLoivP61aA1L3L6V+lE8AL1zxyTLI2sKWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041246; c=relaxed/simple;
	bh=ZvSirqkbtB6Bb+QpW8xwkOwE07MymHotg0m+tc3bRbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NITl6uvqQ3zxVKZSSbaUPX7qHrD1Jak5cEUnmRS5Y/71omhZjZLoNflfn+p6Hpr+ENqbugV+Z0G9vR5aHMR5SI6SDcI5uyF/nDO9ELWMRenIOIU2XXxZRD8aSXn2I8FAzdSvHJx6j3Uql9lZzkoK3jmKIsB17M8YWlX+rB71cqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=25KtwaeT; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="25KtwaeT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gbspix7QmHlmnt4Y4/n6jE4j2E5V/cqVAjHi+GNMKPAIhqg8ptBTv2MH2kAakexNechoV12UA+VwafNCkaap/OPn90ZhUm9HKwbp/4PxlXEfkwaZpxOzpcZQwcaE/fPPocCuveAdrabv44vk/5nqJrcD2+JfrpEi1iuNQVxIUsneq4C8oqrAMlo20jdapZE5Xo30L1EqJj+kwWuzU+PSRZSjqln6Il9sQC5sxBtEap4CrY7GbfvskbFp56bv6784NLVo/Mai2g1ssChsvpmeCEq6oSwqQ9B5fbXzphRqWb5UJapJ30IuMl6ad45LptXsQL6RnwmxnoOJvpq5Lksj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZZfq2apkzne/lxTOfiQN3gwPNJMoU7hwZwJjEkTI1U=;
 b=TM9tkDojJMAc9flTRAqlJus3wSjZ4oRJYd18xzcF06JyeweLZSS5GtOPcUEODRN0F78yQPCvMOA6z8y8D3/7BUTd13CYTSIk6wlFT74ulPuTnTmwUep62YiwH8lAeL+hc+EV0i0brp0+dlyPb8MjV3wH+g4K7e4UbLPSgqq/ZG7uBEyGECG7EkFyNtvAht/ykhEjNvHG+a+CPXQclO8ClchIyO/yIpT/b/Q0NDB3LNLinqcGfWSMHNN4NZKfnEu5qgawO917SelCTHRpm5PQc3VTf96y1uB6lvaRR6DGZkheE1ydkahi5XWdXcjvHI9fgxFQbKB9MTlO3QsYntj40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZZfq2apkzne/lxTOfiQN3gwPNJMoU7hwZwJjEkTI1U=;
 b=25KtwaeTk/mdLs9Yj++9TMJrgJdxwjyvnHLhmtT1PNGKhCgYh+EaSRqoH6Hno0SqaFd96VHrR7lI/FIzKXxcvOwRQyjXXXQEfBm2cJovzmxpAvIl5EUsAgKI2TlUw7O8S1eq7yDpOA1B2vuAKZo3nV6DhcZBA/3cgLsNSlKdXl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 08:20:40 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 08:20:40 +0000
Date: Tue, 18 Aug 2026 10:20:34 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 1/9] cxl/region: Factor port target calculations
Message-ID: <aoQV0mEURRUwZJmh@rric.localdomain>
References: <cover.1785444498.git.alison.schofield@intel.com>
 <3fe2719ce4e5ab79d842107c575d326c5658b9a6.1785444498.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe2719ce4e5ab79d842107c575d326c5658b9a6.1785444498.git.alison.schofield@intel.com>
X-ClientProxiedBy: CPCP307CA0006.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::8)
 To DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6928f9af-5799-4c1d-7a71-08defd0196b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|6133799003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HexEOfGvDitTqTUYpHYRZbxDsW0cnHgweyMaB1bTGl5vTVzc404dJb1soH8a74FTf9KvQpvWIf6DYxJNoN1HWDvu3IJYmiCbJE2DJGnuhVUttWQoIDPFsG0xAFiUE6PzCu6U1k7O1ciVqRlhs2s1pm3ZV2WaAIUAYfoW8bP3LXp63Q7I74kkO74WFbO15lTDQI6mYwq6vmfSOwWI3MOiYG6uEICfI9wVzw1BR25kSbxGv3dpdtMMawAdSEi7SReIvrauyFJxc/slQtWvlCeRGMgsge6GzU9Dz4a9w6rTtHaeV1ZmhUGwxnZcEy2cExwKzj/xxLEwSgbOETEM0A3sGlJrgHrh132X686aD3MA7jUKiBhM/t3Yo+83LtVZrU1Cdy459CyuK0tg9OK6zBDFd33Ms3Ubk+f3nj0UijyZrW/N/oxsTvtOrqANNKSnaalKwJXlnR4RfBu3gh5DIjb+6QvhlbNTOvIyNgmA2lXLJzJ9QtjIXLuLNg91GR+yqlKUaiS6K0I5k+oGWORnFJECV/okzo1WTa5sFUs+LX6IPA1R1nCQ5y0Q6t47jTWaHCw3bVHwdZWz4G35XVYJJ6iyAAfGKOCAnLH5oDA3O+sBVGx8wVbI5yDBHR/jw/l2GGCPhbpVNE/MLIAd/77ngLzClxYtFO+l+QYqps7qutcW31M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qZ/FMQbgSHp9mjg1de5WxWAJg6TUtnaajA+ZzKtKYD1Y8BveHJ6nS0zJFsi?=
 =?us-ascii?Q?mH1PMu9qEdenGowDzLZR+ulKqNttzYe3yGVX5LrF8TIb/DKxopSwjFekbcDx?=
 =?us-ascii?Q?t5oKEfm2O5dRH0ovHLmHFQu+jOfRsVXS8quMkR3jNaLDmtT/PkelGsjrYUQX?=
 =?us-ascii?Q?iAE24rMrx2z/5hsU8pm1hCoA7DVBOrvZA9sdwVelelbVhCQ4JHuQR7F/n90W?=
 =?us-ascii?Q?mjekyJiBVrYWXvhSiMSen/DUZwNrCzd8vmEPa7NJRqq8oaYRuQLGWfnx1eDR?=
 =?us-ascii?Q?T6V3/x3B07LnDro1hf7J5w6q18epEj8PSRkcF3LCyoZWmGPdUqxpQR/yC5k9?=
 =?us-ascii?Q?dfGRtJVkaldppBTxMmlWsyARdqYzEmqi9r4Tc0caFVYEJXzR64fPSbKS6Brz?=
 =?us-ascii?Q?iz5bSWj1lnD02aADez4WIV62nkpMz5mIDIOlgju8DFzNUqa43djeOejEHbfX?=
 =?us-ascii?Q?QRqcx04tOU3r3bHLN3F51vnjirclDeGGK8MqHzmu7TIuk1fBcXEp3HSyLYoY?=
 =?us-ascii?Q?pf7dzJvTqznixg8NrW82q+xR+PSWH8YEQXz0xQM+q45Ekk9o0v+LbHDOJbyW?=
 =?us-ascii?Q?A3s0+6Y0pKg01g3GHyqw8S1P5Tkrr8IPG5cq9OJ0dH/nJnZkoVT+MN23cHFe?=
 =?us-ascii?Q?K7I80Zoyeo3SAzciFs6tV1WfCdJHPsGNjNIbHXxXEKjAdih6y26gZZTQDPFj?=
 =?us-ascii?Q?IZux8Wk7ODcYpJwKjfD1TX7BTXQUNEprT7eRGz9dOijV17UhQpd24LaKEqkF?=
 =?us-ascii?Q?rOEfXOoQEcTLKtChoM4SGgK1o/ca4T6jEppiC/WPasZLc43+a2Lc9Sil3D30?=
 =?us-ascii?Q?ejT33ew044V56I5gLTk3Hn1zv4kiOplptZLjLXia+mhoVhgHqBefFFMUvsJh?=
 =?us-ascii?Q?4OO1xP/iGWzqGEEdByEqrNOijb2nNjuuW6ALoz2qFns3iV0xrcFqXUsUcygy?=
 =?us-ascii?Q?XOMz87wDHjn6w+55MQs+m6aHpz9jaLISlM9wAon6iIvTNgl+fflNoVYJUJo3?=
 =?us-ascii?Q?nq24aAr+yoFH8NvXzggNyKsSkLZcGpYgHoqeSgAfDCXCfbrmI4YzRa/HG3qt?=
 =?us-ascii?Q?mWM+sMLFjzvoAYHc131Pm2jV4YrALI5LXqC7I7reuRQS76mTHLCikUlPgJEF?=
 =?us-ascii?Q?891HgvsiGghKGj8VllAucb2f5DVhkaHyjjL1Cden0JqpsIjwiA2LbSyP0tCH?=
 =?us-ascii?Q?wsGj1t7ku9g4naCJ0nmRJaegdvLjYBZno2ndKr5+2edcd+Ih4RYt84QVT200?=
 =?us-ascii?Q?K0CpswrjqQZD9ZWUJNMgoLIY3lJVLxS+EtjACg5KyxQ7Xyn1ptN5GvvA34OF?=
 =?us-ascii?Q?UBENC+NM1kCWdy61boa4bt9mKMUS1uW/9LLmHoPhod5lBzNidy82mmB55DPk?=
 =?us-ascii?Q?wNQ0I53lUUpml6+IZc3NIbILwABxNS0ToyL71CxcnCAehF10pkHkxnSGngU/?=
 =?us-ascii?Q?RbkRuIqPfVEzScsaneUn5UzlPkgXp5Yy703uyAE/kIxUpP3erXJqo7G7X8wa?=
 =?us-ascii?Q?hPJmg/Ki6GJMzeh5k3vvqAZtOJGXV7QVEWLHnFlccZc4FZvv60JXSNt2tG7y?=
 =?us-ascii?Q?+PtSDThdTjqf43lxT3C6x7TMn3MyIfYjIye9wv0uXXMq+yv6kKqZAMUyql73?=
 =?us-ascii?Q?YItH5/yTYvkRykvHOLExSo985fJTspr13TCpSE33vqP5pooFXmPtzzdCKzVI?=
 =?us-ascii?Q?hITIAg1HWAcHc4quBToZz3smEmG9XjRXsY2UCkbmtnjTrrmhnywZ2QWQsUJ0?=
 =?us-ascii?Q?51Knk+XNmA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6928f9af-5799-4c1d-7a71-08defd0196b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 08:20:39.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py5YfEa81sL1lM2q+lRVPqFq3w6th8HvPU/LqKhks8NsulvIfcoLdc5wpHeILMIrLIKJtw3i+wqZuBHsqkzp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

On 30.07.26 15:20:21, Alison Schofield wrote:
> cxl_port_setup_targets() calculates the interleave fan-out above a
> port, the port decoder granularity, and the distance between
> endpoints routed through the same downstream port.
> 
> Factor those calculations into helpers so the target setup path can
> be extended. Validation of parent decoder values is dropped since
> those values are validated where they are set, before this port's
> setup runs. A configuration that is invalid in more than one way may
> report a different error first.
> 
> Suggested-by: Originally-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 197 +++++++++++++++++++-------------------

Please split patch and move out changes in error handling, see also
below.

>  1 file changed, 96 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..1082db7b2cca 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1350,6 +1350,19 @@ static void cxl_port_detach_region(struct cxl_port *port,
>  		free_region_ref(cxl_rr);
>  }
>  
> +/**
> + * check_last_peer() - Verify the previous endpoint routed to this dport
> + * @cxled: endpoint decoder being placed
> + * @ep: this endpoint's entry for the port
> + * @cxl_rr: region reference for the port
> + * @distance: distance to the previous endpoint routed to this dport
> + *
> + * Endpoints routed through the same dport recur at @distance intervals in
> + * region-position order. Verify that the endpoint at ``pos - distance`` used
> + * the same dport.
> + *
> + * Return: 0 on success, -ENXIO on a routing mismatch.
> + */
>  static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  			   struct cxl_ep *ep, struct cxl_region_ref *cxl_rr,
>  			   int distance)
> @@ -1434,60 +1447,106 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +/**
> + * get_parent_fanout() - Calculate the switch fan-out above a port
> + * @parent_port: first ancestor port
> + * @cxlr: region under construction
> + * @fanout: filled with the product of the ancestor switch ways
> + *
> + * Walk from @parent_port to the root and multiply the interleave ways of
> + * each switch decoder. Root decoder ways are not included.
> + *
> + * Return: 0 on success.
> + */

I don't think that static functions should be documented. They do not
describe an interface, are short and also called only once. Instead,
the function's purpose should be understandable from reading the code
with small comments only where really helpful.

> +static int get_parent_fanout(struct cxl_port *parent_port,
> +			     struct cxl_region *cxlr, int *fanout)
> +{
> +	int distance = 1;
> +	struct cxl_port *iter;
> +
> +	for (iter = parent_port; !is_cxl_root(iter);
> +	     iter = to_cxl_port(iter->dev.parent)) {
> +		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +
> +		distance *= cxl_rr_iter->nr_targets;
> +	}
> +
> +	*fanout = distance;
> +	return 0;
> +}
> +
> +/**
> + * derive_port_granularity() - Calculate the granularity for a port decoder
> + * @cxlr: region under construction
> + * @fanout: product of the ancestor switch ways
> + * @ig: filled with the port decoder granularity
> + *
> + * Preserve the existing parent-granularity times parent-ways recurrence in
> + * terms of the region granularity and the fan-out above this port.
> + *
> + * Return: 0 on success.
> + */
> +static int derive_port_granularity(struct cxl_region *cxlr, int fanout,
> +				   int *ig)
> +{
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
> +	struct cxl_region_params *p = &cxlr->params;
> +	int sel_distance;
> +
> +	sel_distance = is_power_of_2(root_iw) ? root_iw : root_iw / 3;
> +	sel_distance *= fanout;
> +	*ig = p->interleave_granularity * sel_distance;
> +
> +	return 0;

Always succeeds. Should directly return ig.

> +}

I will review both functions again after reading the rest of the
series.

> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> +	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
> -	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_port *iter = port;
> -	u16 eig, peig;
> -	u8 eiw, peiw;
> +	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	int ig, iw = cxl_rr->nr_targets;

The changes around here should be a separate patch only containing
error handling changes and other related reworks.

> +	int fanout, rc;
> +	int pos = cxled->pos;
> +	u16 eig;
> +	u8 eiw;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
>  	 * decoders only support powers of 2 up to x16.
>  	 */
> -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> +	if (!is_power_of_2(iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			cxl_rr->nr_targets);
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
>  		return -EINVAL;
>  	}
>  
> -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (iw > 8 || iw > cxlsd->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +		return -ENXIO;
> +	}

Split patch: Moving of this check and other changes above should be in
a separate patch.

> +
> +	rc = get_parent_fanout(parent_port, cxlr, &fanout);

I am not a "fan" of that term. :-) IMO, target_count or target_total
would fit better here.

> +	if (rc)
> +		return rc;
> +
>  	if (cxl_rr->nr_targets_set) {

The check can be dropped now as it is done with the for loop already.

> -		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> -
> -		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch == distance.
> -		 */
> -		do {
> -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> -			distance *= cxl_rr_iter->nr_targets;
> -			iter = to_cxl_port(iter->dev.parent);
> -		} while (!is_cxl_root(iter));
> -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> -
> -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
>  				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> +						     root_iw * fanout * iw);
>  				if (rc)
>  					return rc;
>  				goto out_target_set;
> @@ -1495,84 +1554,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		goto add_target;
>  	}
>  
> -	if (is_cxl_root(parent_port)) {
> -		/*
> -		 * Root decoder IG is always set to value in CFMWS which
> -		 * may be different than this region's IG.  We can use the
> -		 * region's IG here since interleave_granularity_store()
> -		 * does not allow interleaved host-bridges with
> -		 * root IG != region IG.
> -		 */
> -		parent_ig = p->interleave_granularity;
> -		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
> -		/*
> -		 * For purposes of address bit routing, use power-of-2 math for
> -		 * switch ports.
> -		 */
> -		if (!is_power_of_2(parent_iw))
> -			parent_iw /= 3;
> -	} else {
> -		struct cxl_region_ref *parent_rr;
> -		struct cxl_decoder *parent_cxld;
> -
> -		parent_rr = cxl_rr_load(parent_port, cxlr);
> -		parent_cxld = parent_rr->decoder;
> -		parent_ig = parent_cxld->interleave_granularity;
> -		parent_iw = parent_cxld->interleave_ways;
> -	}
> -
> -	rc = granularity_to_eig(parent_ig, &peig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> -			dev_name(parent_port->uport_dev),
> -			dev_name(&parent_port->dev), parent_ig);
> -		return rc;
> -	}
> -
> -	rc = ways_to_eiw(parent_iw, &peiw);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> -			dev_name(parent_port->uport_dev),
> -			dev_name(&parent_port->dev), parent_iw);
> +	rc = derive_port_granularity(cxlr, fanout, &ig);

I still think, the granularity should be determined just by
calculating the bit position of the ways bit within the HPA. But let's
see next patches.

> +	if (rc)
>  		return rc;
> -	}
>  
> -	iw = cxl_rr->nr_targets;
>  	rc = ways_to_eiw(iw, &eiw);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> -		return rc;
> -	}
> -
> -	/*
> -	 * Interleave granularity is a multiple of @parent_port granularity.
> -	 * Multiplier is the parent port interleave ways.
> -	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> +	if (!rc)
> +		rc = granularity_to_eig(ig, &eig);

Same here, separate the combination of those two checks in a separate
patch.

With a patch split the actual change will be much better readable.

Thanks,

-Robert

>  	if (rc) {
>  		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> +			"%s:%s: derived ig %d not a valid granularity (iw %d)\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), ig, iw);
>  		return rc;
>  	}
>  
> -	rc = eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> -	}
> -
> -	if (iw > 8 || iw > cxlsd->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> -		return -ENXIO;
> -	}
> -
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    (iw > 1 && cxld->interleave_granularity != ig) ||
> -- 
> 2.37.3
> 
