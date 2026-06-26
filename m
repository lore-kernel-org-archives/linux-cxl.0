Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B63F23A1
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475776; cv=fail; b=sbQ4NAYcGqgFZqN3YkD7WUzAMT0uw/ber46Eq6+zBNKNEeGhQL1fdqFK2P1yaLBMKHuUaSkf3jHD2pZA9dUJGj7qpMg8F0apwzYUPG7H7Mhoy1SiC/lPWvs0bSORGFdwJbtM6SbPRvacGsTwWGB1EjlYigaMM8PsECEvuVY+ris=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475776; c=relaxed/simple;
	bh=caH9OgKPiVz14Qz1W/vwPG13xfa7Af0Us4RIlAR0XJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t/DAwaFwafwyUQKFIhhXKDFt2c+vaud5mOR2quLVMboXJw7M/NEV0RH5mjR3UfLNRmFX8LcSd/miybgeJAM2a/usq3oKqRV6ftPfgeVC3+qxbHVQ4SqGtVHiqAi9sDAoGCBcdgoKZxfvTQtYzg9wJufFoIC+WVN/uQfgNrRdOg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mv3AOkoa; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mv3AOkoa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y89wiR4ulu/lmOoNF9YzKegylWBR0z0N5qlQTJyvAmhqinRd3BBFBrcohOzn1m4cJqMbnxL/47+ySjGzEBKx1n1wa9HiDeCv9TismcP6sP50R/VEyEXhDQLUeBq/a1JmTCQtqqpHQUdcY7PCj3gpT+Yhfz6K+UKH7IaSrM7EoNnge3TjzEGNLxR3A5EBSj2BRC0ERI+s/0VPNGydMrRB3S6gu+zVPdhR5sM1wPaTi01xcVRiV5DPAplJzvDoCiA15Gosro8oMGuHSUDrJDh/TLCYL/ZWep9GmCEE/dpJDLJpK76JarUrm5+pGX8aFIWeXr+EPNiaZiXlLYRFwa7Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm3RKQEgK9cmeo4QhYpYiouLc/X95o2ce6g32aDEQT0=;
 b=k3CG14GcAoimmKo72aglOMH0Zbcx/wegecjl1RneN9XzeacEmbq/VTSOILdWmklLEra4KqqudSzKrrsrdmoyAwa3mLS2761JDa/fhNkLIThNPa74TOBjeehDqJm7t3icu2g9lH+zSYX5C22l1XXeqxA/YPm3Mqvw6xVB8Bz397tshBZMckpRJItCuedvhuzi1TZw1DOoG97kQfdKsbWPQankL3sI8tRy/VwL+mN38nXMaz/3kRJprGBrcrTHg59B3xjCY37tVwJBnsJi7pFvSVobl7S2Ra3ShvGiXIfS979V6nabGAgIJIaMSXdyqDJHd94YNWxwfm8kURux/pFruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm3RKQEgK9cmeo4QhYpYiouLc/X95o2ce6g32aDEQT0=;
 b=Mv3AOkoa+ZTrbXIuUGLK3M3+4uM0bNhDzaODoyE16xyZnwgKDzsJC9ifadPydoYSj2IFE+xQXnDxuZzISAnxiJFtmXAKbrl//A3A4YpFVrHmxmEN284VnK/2CcE5v+2zPaTKu2I+Piu4q5B5ABdMsU9TsfehW6Xdgwd4qKkEH1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Fri, 26 Jun 2026 12:09:27 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 12:09:27 +0000
Date: Fri, 26 Jun 2026 14:09:22 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/6] cxl/region: Derive port granularity from selector
 bits
Message-ID: <aj5r8tTFW0LJrqAi@rric.localdomain>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <8958317c8d2a02f021f34712b69846a709f702f8.1781199122.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8958317c8d2a02f021f34712b69846a709f702f8.1781199122.git.alison.schofield@intel.com>
X-ClientProxiedBy: BE1P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::10) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc8310c-67f3-4fcc-6326-08ded37bc492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	yJuYhCjk0lYHxIzorVgTarYhPgHOHVf2xXX8VkDb1Fv6AgBHCVhK8wgeSg571uLPZUEbocehir+PN2seZfZEgcaDSYphm/piyOG04ckn2LyvTQTAa5mXvN6rlMC8LLBfBXz0ULPAQMj/8JG9fZvuXnKjbKfs2Ruh89Owm4IKMFhH3b2CNSRdxDipN/3rS7Al8DkFUnPTBDcekxnzZHJX4EzRvjQKGiTEVNw67eR5GOy06Rm7cU9ZObXVna9KkKA6yc8OuWegxbecwaTr4T8Hr8ypU4w6UlwCLSgN3eeGgdv4Of1VaX7muPNuEdbXxNnZmNoHnx7tUfk2bTOZOht4Cz2T0WH+fk90zemdnWZ+YkE4fBX2i+NFka2RVNgAXWdKW5icx7s0f18yVJ0w6sRvPwwlGBeqWDn0K6HpeXJgdOUpHav57c6qPT7J1cr3qeYg0QHMsYn37vA3qqI1dBtwtsLmEOBwMH4rqja5ogdVFXLYFGaUb0qZDYYahgLJn7uuVZkqRakEeSgcPmFFXn78/g2m5d2Fm5nAO70yjN6HOONfNy7yImmkYSE6krY2eeOZ2WFWKPdcitqELkoOKSAdgxUyufFgcOTMKPTf/5tUnkKavFpDKv2KobG3d4KKoEOF6EaiQ9ZfQrhxe/P7CN66z7nM6VnYKhupGp4HKu4LSyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7ykke7kZ1qycDXfwC1CyOJdBrAQ9VJkFVLZ7AEj//myZue3bPs2Jw6I3kPU?=
 =?us-ascii?Q?R0m1oYE0egvAGt2WcoYzDkcbtohvZZ/09IhsyeR7QDORHs/ZLeM9JowDsrvV?=
 =?us-ascii?Q?UiVXcw1XEg0N5Gf3YBHtscfqhJEcmpsca4rorx8ElJTdJSRlpua2SbSYAwmw?=
 =?us-ascii?Q?0Q+sXv+kieYPwYtff8a9QL7jhtVmJ6iXGjhG4cJlfSLjklTM5Rr+Lf8I4ukO?=
 =?us-ascii?Q?8ypY2LXSWbpTiWLPvgjcUATMTltDT9Yg0gT99uUggIgOQIrTT5jGKPk0f+5p?=
 =?us-ascii?Q?7KUzrLv7jJ0GxG1RbQsS5xhCr9w+cbOzJPTSFBrnS4dY1Y3I8Se6uOj6x0MZ?=
 =?us-ascii?Q?H6HV5ckCdBY8KfGpsCGFXdv5tQfm0Nt1Kp9OOseT5N4rLniQvelYJ/QI6aXh?=
 =?us-ascii?Q?AoJ+scGvzzJMiaZHMEcnxTX4qCoEgmQTo6T35NN46k7nra059DVman8XL9nM?=
 =?us-ascii?Q?AEMDVIJ5WP2PzJZEdfT4/2H3OAZ7nYPbEJzyETvO+YOAj30QSsQtx9qjCdhG?=
 =?us-ascii?Q?T8BFRxB2c3oZ9Xm1WX6nsz261BN3MvM8+q305dxN/bDMBg5FA31GkCi3YaRj?=
 =?us-ascii?Q?qjFatN8Kmx0ZVhluIIMUlXjweBmpU9v806+ILc1VVNH/JyDhphSiCPROuCmY?=
 =?us-ascii?Q?+L8/jTPtRUV1oB71KqinhPHenu6nS/EPPNhRB7lFmemunejFquq4yzmxrAZ9?=
 =?us-ascii?Q?58/aK+cH4/sDZgXxL8EOb+y2wUj2pzXv0mQGghrb3Q7GmDoauKySQwto2eWB?=
 =?us-ascii?Q?F42uUsWAFE2bvAFUeUBtpvrJb+u4MqzLkqZVHJuhVd7PUZt1cre2gR4MnCIB?=
 =?us-ascii?Q?Aq9ofPuqsjWwrOVRhzpn+dFaiUxZgcYj8cnf60kgOErZRYjpUZ2ouA7yKHY0?=
 =?us-ascii?Q?DsZzaPzEt/pTf0VcYgycLMGf7VE1jaqSu2AaZXhe1HWvFK9VrE62dBv6qqRc?=
 =?us-ascii?Q?awtvdYYO93+DoQEe20jb7Xo67RFJjM5QWdfiikoEZWjrtyYyz4ce5iKrTIT1?=
 =?us-ascii?Q?jw/ps4VUplMBlOqpwNmSi9BJxHqrymCMwjs2cJqIXwPLn840Fu/Wi1s9+388?=
 =?us-ascii?Q?aVRYkOAdtc39yWBD7decz2YZwJqa8gJZZu/8lr+gTDNy2gFOrKwmNwE0b0el?=
 =?us-ascii?Q?NukZhSojFl+1mc1UUmaujT23xs+d1reiFu2dJEWvbwTrzy2GpMPbPKcMXVw6?=
 =?us-ascii?Q?XlMLGSroaCFmxQYEuLYeTkjKjK56ggUVBdd7g/dVuW0QGuNShRyYJiU9mHLx?=
 =?us-ascii?Q?r2fZMwAjDSNEaUsWh3tHefw3rZZtR4+0kALGU2LAiFHvlaSQHn8yPPHz6uwa?=
 =?us-ascii?Q?K1uy8qsKB+qqeLqbvPlgiicTJQ7XjFFOncGh42Vl7FbatlpOOulKI1wDIj+Z?=
 =?us-ascii?Q?BnE493vxw0vSgYbTH9zaWiV8jjGqBDEYq2I3mLmU3v86jwP9japE3iII1Ltd?=
 =?us-ascii?Q?pBObPe2rryFBSGnvWJH180YZU63/anr5HfSeAGLDXkgSxAT7/GAZMAjuK7C+?=
 =?us-ascii?Q?1uYd/nGEYGAtyO8lJKjD5yuzBAQ7vroRiPl1qRxjMBb0WIfN1U+97cH/mJwZ?=
 =?us-ascii?Q?s6P6wljrR4JqJtMZFd6cqS+UuUen7QecyM64n/efCVrZKWGlXoEqR6O2H+mW?=
 =?us-ascii?Q?L25Yd1Dp8LftP8lJ2ziN2iubjVuD4omjpDmcPdzPKyPBlmBUOy2/ItdMNsIf?=
 =?us-ascii?Q?lVLY5YsodmatgR80kZILMXG3mzNKJ9y0GrCt+ZlFJkrP8Fom?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc8310c-67f3-4fcc-6326-08ded37bc492
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 12:09:26.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8GTieejvhk/n62aiq2cJ6xBBu0VraiKj21rvg87MSwiKMxz6+jbkIQ4e00ncTTPsXJ7/Fq8JhkYFJzrAukhUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

On 11.06.26 10:47:26, Alison Schofield wrote:
> Selector-bit validation uses a single same-granularity formula
> for user-created regions. Mixed-granularity layouts need the
> programmed granularity to depend on the type of decoder being
> configured.
> 
> Derive port granularity from the selector state:
> 
>   AUTO:    keep the firmware-programmed value; the walk validated it.
>   iw == 1: passthrough; consume no selector bits and span the parent
>            stride.
>   iw > 1:  claim the lowest selector bit still available to this
>            level.

If we change the implementation to use selector bits, this patch may
change again. Anyway, see below.

> 
> This lets an interleaving switch beneath a mixed-granularity root
> claim an inner selector bit instead of colliding with the outer bit
> already owned by the root.
> 
> Add a final check that the derived selector fits within the
> remaining selector bits.
> 
> Remove the auto-region granularity equality check that duplicated
> the old ordering rule. The selector walk now validates auto region
> granularities.
> 
> Originally-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c859c8661281..d5d19ed62171 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1533,6 +1533,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return -ENXIO;
>  	}
>  
> +	/* Selector bits still available to this port. */
> +	selector = cxlr_sel & ~selector;

This is only used to calculate ig for the non-auto case. Can be moved
there.

> +
>  	if (cxl_rr->nr_targets_set) {
>  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
> @@ -1545,7 +1548,23 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		goto add_target;
>  	}
>  
> -	ig = p->interleave_granularity * parent_distance;
> +	/*
> +	 * Auto regions keep the firmware value, passthrough decoders consume
> +	 * no selector bits, interleaving decoders claim the lowest available
> +	 * selector bit.
> +	 */
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		ig = cxld->interleave_granularity;

Move that to the CXL_REGION_F_AUTO section later below.

> +	} else if (iw == 1) {
> +		ig = p->interleave_granularity * parent_distance;
> +	} else if (selector) {
> +		ig = 1ULL << __ffs64(selector);
> +	} else {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: no selector bits available for iw %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> +		return -ENXIO;
> +	}

That can be moved to non-auto only part.

>  
>  	rc = ways_to_eiw(iw, &eiw);
>  	if (!rc)
> @@ -1557,9 +1576,16 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> +	if (iw > 1 && (~selector & get_selector(iw, ig))) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: derived selector %#llx exceeds remaining %#llx (iw %d ig %d)\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			get_selector(iw, ig), selector, iw, ig);
> +		return -ENXIO;
> +	}
> +

Same with this check, should go to non-auto.

>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
> -		    (iw > 1 && cxld->interleave_granularity != ig) ||
>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
> -- 
> 2.37.3
> 
