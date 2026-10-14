Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AF4DE706
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970939; cv=fail; b=LLALGjGpT1w7pFPjSt34/NSlAc6hzaVXfBrMH+1N8myqMqHOZqNPpiyFTp7J10AzTw+EoSgBe9uGeyNNokJBk3k+o9fPtdLl8ix1wrtbkyl2J51SF95Umut256OQL7uU0Gvo7vIwius4C5ksL55noe4PGbFhqA84l5D/8yzWCiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970939; c=relaxed/simple;
	bh=Zg2NXtMjar4x94up+ny01fTDqsgLZDEQ3fOpea5gpck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MVST/NzKQGS0iXq7cLPMaXKs6D1avmWV3E2gU0wli8tzR4mQf2Uq0/cukG3Qjf5o+pnVUokdYtFT5H/F0a+nP0JK5Wl8CFFmvz3mQiAmt1D5P4QC0V+KydJE2kVBcN5hbx5Yc/VI2tYtzksedugaIojMxcEC4araBARiOqqcLIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dcOyhYXw; arc=fail smtp.client-ip=52.101.85.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dcOyhYXw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IX7S6hcdKZ1hS/ALbDVPGNNQepbCQpFGZyAIDHxma4dYfvCaCE1//9MNuNQzr7Vi8/dgZUkfSq45xAG+I2tYkFWHF0kizpNPzNdqvJGegaLyrRbeVMuZ8o7FNTyINLCoxnIKJEhFGm+qtlF3fmAqeN6DVnZGP0gUi/lZURYOMED1/86SlMOcDHsHymGmAKiQEExcIXShywJb6DUAX5eKPBcES2nZr9mp0cjSNyhzJPclmAui5z8YfHhnNt0aXYfUDLBW2FVO+3hEES4p8PRYQhiEz/YJNOX2kG8H0y/WcZcEkxKgMoYV1R39coYNWg/S8Z4N3TbGUCB0tD3aIFeGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyHTqgC3ZBNoTzDhrMmMu9yPemCAkua21v4tte//avE=;
 b=c4tb1+EbdofbWoMTDbalEdrdqkHJozs0YpdtOHTZ7uJYocJCTBJI2luU632O3r3zps6RkOvZeqRkArtXT7Ga8WJhrmVV4/Z/19jvSnGK5Bj/7yEHCVhtG9oB/82wscOASMBY0388Vc10QemlfkMBs01bBpEFvpIP5FcifOcZx+eaUNJ4Hvlg5K3kjVREivygNqgVBWASTMZF7CgncxUty4vap6mWKA6TwYIo+6+DuQNITvrLg+dh6Mn0/+p3L9pbDqAwQeJXLanTF4roobFE1XbcbwMHeqdXfAAhBCk/JnFIjjgTuXDNdrQfJJ3takUlaQx/eUtQ9Jjm/YhVMaVpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyHTqgC3ZBNoTzDhrMmMu9yPemCAkua21v4tte//avE=;
 b=dcOyhYXwpYUQ3dn5YuWRRz7CVfdONHVGfADzoY9PY//hBs7HQ/jgosdvqd1fDQtWAbmCgP4MvdLWSXsOeFHRwQMJEElyoxcr8gpWfrCyKiJ+HJ6WKDzKm+PKgO5oh7Qah9NtnOuBM/ZC6JMzZp1qdCIQ/FMW/fZvhSxRAoLIkYbGhHfCfwt8JeRfEuyTB+6flxSFKiCh4Ie7eauPMPcHpt9aPB2vXKXSGk+q8XXxWJ0Eg7ErnMd4TJ/eyoLZnuWF0YEZy3RvhT2bEl+BGo44VVQT+NKIxZbfQ7aKRPf/G7mWu57ynxVFyF94cb0L3duK68eUKXC5S9DT8WtM0iwkzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:42:15 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.020; Wed, 14 Oct 2026
 09:42:08 +0000
Date: Wed, 14 Oct 2026 17:42:02 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 7/7] cxl/region: Factor out
 cxl_switch_port_add_target()
Message-ID: <as9OWYj1kr1-tWpb@MWDK4CY14F>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 162b252e-dc42-4e61-6def-08df29d76a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bu961PAVhZFAvCrJOIIkUXQmwbV21fet5FBRM1Rqv2Np67G+2bZMX5Ruo0NyTzNHW+m2Dp1FKa5ozqjaYJ2kfcMs75xws+6may9FwVfOLE+x0Ju6DcpmTeUrihHKbzDMzv5tkKcmEGXqSWlvQj7k4ZkR+NidECxYiRQTiOggCgh6DGJNLcF1T3by683gbhugHCmgKYcmuZBfkwIZXgPYusGWBIOejd7W5bxwd/QH7Hosjt59z6fLkljz0KajMvS4S1pGwEPAsBkywVpa0Z+tP/MMyiTTld/H+/h8iqOdSdZQy/opnsFr2s8X7fQJRkLA5ydIVqKTzhKLU9BMfDJIuY7ZCRhUPPM3b8Z4MRvib15vXuLsebOgajy3bA7Wh/AW+2zcFGe5i7L9Bk2ktEHqm+ImXZ59xgunelLBeIPXuiowoEKz9Iz2dDZzw38OKJot4wjxln6wDLNyHQYRkbLJJaoFtDc+Gpf0VEwYFSys+Z1DtPsOoO7D3fkYDC5sjXKj6hUhBcvFakDkaxwsTegznX0pZZaGZqqHIBIvxxXGspv1LFRqp7UgxqZWLNzVdb8tHNuTkJTMQkaiVBVPZYWKKeLGCpZTTr9i7cqx7eeKA6xI1nk3aoB6ygoBp3QfNYcsUZVmbtyVLAH37vLnbV/cbskVz0+qoOD7pb0GCUUyOSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jA3DX1Y9vM9YVikuYX3YLpoYfss+uzDDQruldM3k6JBPogQV7EZIhep6wZZI?=
 =?us-ascii?Q?ct7o7VqajHMMlbF07q7XeJy5a6hoVxenbvoQIJM+8RJJP36DdQxiNTsANoeI?=
 =?us-ascii?Q?vjK/pMr9+5nN6MbaTpnF9L8gXATA4eoQmO2BzpI10CCmXzZr8ysQJJBSxHJ4?=
 =?us-ascii?Q?YQsa2kunklQ1ungmC/9t6BHtL6TM7EjPqno3MQODk22H3xVS4pgCLyiE08qx?=
 =?us-ascii?Q?uCo5DVpIUg830BiRPjUAnJjcQ1Q1mu+TnQAU/4+bnH9OWhigX1AdcV/a4E6i?=
 =?us-ascii?Q?dtsQ4xK7Fg1Bv5vANHa7CrI2MhneWq2Rs6xgN4CNgD/AJRncdSCW9ZYQrY09?=
 =?us-ascii?Q?WpXT0Cu7qMLfJi8irFzCe4DqB8KWy4Z87akY8r9wwq1bQMQSNu+6tRl4nXil?=
 =?us-ascii?Q?cPLA594ea9h5VymqRenGTcv+FWfPRSgS2HpOW7J17j6DnLkezpDS/87FEZPX?=
 =?us-ascii?Q?YZ6h+1kpzOa+RAf8tfWPqBA+6/1+NbtmJTS+BJ3jsB5gUKi8dbMZNUaB+w/N?=
 =?us-ascii?Q?xzEvt32WADwSobfiz0Zy56JEMLVAMmjptER6J6tqSxCrxzELk/PxBlMqBOMg?=
 =?us-ascii?Q?+n9xAgwjXaL39SUAnY7O0OfHQCvHRaAu9NeASUngJiO5eVcQpUrediBKqwrL?=
 =?us-ascii?Q?h5YTUXY8frui8QCZcN2OV6U5NDZeXi7xUllqpY38mf2qsRirYduzFjyXpGc2?=
 =?us-ascii?Q?WJh1hshDKZIdVb9jssIxOkmL6GFO5z9zE2PZYpmTbRwoQAMeFoHAqhnPORgu?=
 =?us-ascii?Q?Lfaq0lG+9AXBxgO3YaV4bAxPQMJvoMNxTrEG1SpHfUUeSayUmU0wua6Ug0gX?=
 =?us-ascii?Q?sz+3E9SdQ20FQkHGGkLaKY+6dCMDQ7y+Nf54z4pFRQpLo1ChHWMUVbWZrv0I?=
 =?us-ascii?Q?u118YGP6ST17btno1CGBfBrQ1js7457c9D2zzXMH5sIgn77VMseRg0qUZAo/?=
 =?us-ascii?Q?ltdwl8wOSqEej7p0WVWwyWKLMssEzcSbVy0KeyoUY3+jrKq7eLRkBY8ITuDu?=
 =?us-ascii?Q?u1fCFScBc3vcPcBfAN0uL5rJoAynYZF/74BX7QuBXTqpIYiCcSTCifP5aGsv?=
 =?us-ascii?Q?LyDllTQbOSuQUsI5Mx6meIxVJnl76bBf21I4cQ6CI8bIU0aibmFg4iEMzNzp?=
 =?us-ascii?Q?Hk3E+4yew4uKXpFaiow1WLAC/ze6HCOWTnVLeWIZmsJmwoSElxIl1kAgDIBv?=
 =?us-ascii?Q?ZR2+hMW8XvgNQXY4N3REUH+0KJXens3rDRtEIEGpooXSdTYHRKG3HN60csQ4?=
 =?us-ascii?Q?ls3hu81rgQ+oZqETZwS9OPD/H0DQFL6YlJur3k/WXOncaix3YbCMBRZtAG4Z?=
 =?us-ascii?Q?sfdW6iJN2vDhNGBZDEnX9AuQUwcJQWbk3xcBuxnCl0fcyQ9iQxpPqEKi3TWl?=
 =?us-ascii?Q?YnJSTJXJJ1mlrjyNZ0rWS7WRbkQCNwPDq9wOVXLX9Hpf85TVQJEF2H44daoj?=
 =?us-ascii?Q?OuocfKzphizRyJF5qrl0UGrs+TvqWWRleRDqtP7kMg4ATySobU3gkhFjGae9?=
 =?us-ascii?Q?D22ZNxwFLcuShyhgsM/PLCtMrgk2PRdoKiZraOhmmOA7bGUXNbnNNSr5p7Y0?=
 =?us-ascii?Q?akkrAyOlsZACJM7SPrnGwO/eP1NFMAY+JxLGjmIS3MhLgKb4hgm7DWVrFiRL?=
 =?us-ascii?Q?ksSw65cNJm+7j+k76r/j61aPdH2+sdz6NzyQ/WgxaAj6MlqEyB0KiDqwfjsc?=
 =?us-ascii?Q?Wz82yIEppntLSvomiTFdiKV9OawitRHwX7mdYS83TBQO4bjO883uA+plOlUN?=
 =?us-ascii?Q?DU1uivO17Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162b252e-dc42-4e61-6def-08df29d76a00
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:42:08.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAGi+SacYPB9j5XxfpZWZa8xuIWJBmA1+BVh5sh44KX671HvQSy3PW4Z8Vq4aH5t5umvswOjYdpuJ6E/HTsjWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926

On Mon, Oct 12, 2026 at 09:26:03PM +0800, Alison Schofield wrote:
> cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
> port's decoder target list. For an auto region it checks that the decoder
> already targets that downstream port at the next position. For a user
> created region it programs the downstream port at that position. That step
> is open coded behind an add_target label that the target search jumps to.
> 
> Move that step to a new helper, cxl_switch_port_add_target(). The helper
> takes the switch decoder whose target list it updates, rather than the
> port, which makes its scope explicit. With the decoder setup and the
> target add now in helpers, the path for the first endpoint to reach a port
> becomes an else branch of the target search, so the add_target label is
> no longer needed.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/cxl/core/region.c | 80 ++++++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 229372123271..50f4830c225d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1608,15 +1608,50 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
>  	return 0;
>  }
>  
> +static int cxl_switch_port_add_target(struct cxl_switch_decoder *cxlsd,
> +				      struct cxl_region *cxlr,
> +				      struct cxl_region_ref *cxl_rr,
> +				      struct cxl_endpoint_decoder *cxled,
> +				      struct cxl_ep *ep)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxl_rr->port;
> +	int pos = cxled->pos;
> +
> +	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: targets full trying to add %s:%s at %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> +		return -ENXIO;
> +	}
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> +			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				dev_name(&cxlsd->cxld.dev),
> +				dev_name(ep->dport->dport_dev),
> +				cxl_rr->nr_targets_set);
> +			return -ENXIO;
> +		}
> +	} else {
> +		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> +		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> +	}
> +	cxl_rr->nr_targets_set++;
> +
> +	return 0;
> +}
> +
>  static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
>  					 struct cxl_endpoint_decoder *cxled)
>  {
> -	int iw, ig, rc, pos = cxled->pos;
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> +	int rc, pos = cxled->pos;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1641,38 +1676,21 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>  					return rc;
>  				goto out_target_set;
>  			}
> -		goto add_target;
> -	}
> -
> -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> -	if (rc)
> -		return rc;
> -add_target:
> -	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s: targets full trying to add %s:%s at %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> -		return -ENXIO;
> -	}
> -	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> -			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> -				dev_name(port->uport_dev), dev_name(&port->dev),
> -				dev_name(&cxlsd->cxld.dev),
> -				dev_name(ep->dport->dport_dev),
> -				cxl_rr->nr_targets_set);
> -			return -ENXIO;
> -		}
>  	} else {
> -		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> -		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> +		int iw, ig;
> +
> +		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> +		if (rc)
> +			return rc;
>  	}
> -	cxl_rr->nr_targets_set++;
> +
> +	rc = cxl_switch_port_add_target(cxlsd, cxlr, cxl_rr, cxled, ep);
> +	if (rc)
> +		return rc;
>  out_target_set:
>  	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
>  		dev_name(port->uport_dev), dev_name(&port->dev),
> -- 
> 2.37.3
> 
