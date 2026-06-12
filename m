Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3134846A
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227150; cv=fail; b=j2l6lk+UH4Q5EtEXdOK+SloomRbkB/hXQa+kwhJgdZh2Ie4XFARxPEcxwFjwiPlU9Z9LidFKGDhEOkdM/c7EL+AuksWRoXdPR49ppOT51rUkwhT9IVnlPV+3S0pNtoCchN4tNv9zamllNZvd06XjqYYYZz/ZmqWqm8AnXHrt2QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227150; c=relaxed/simple;
	bh=Pr86e3jo9aeqDExmTrIDwXe/Ecb8TAOKBhIN5U0sZL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B5m+Kdxbuy0Bz197ZhRT3Gb/obpXqyIoGNTEzYZFgxIbGD37uRV4vQuQoOnYURgB1KYgcDhnoBv2E3kZ30jO2TudAYpVobq0XVvq7N8YFMzlPGDF64pX8KWcgei14v0PeOm0t3TqNT1UlS9WBixqTeit41czwayYYJm4CZw52hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gV1CMmF9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gV1CMmF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781227147; x=1812763147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pr86e3jo9aeqDExmTrIDwXe/Ecb8TAOKBhIN5U0sZL4=;
  b=gV1CMmF9HnFHPXElemJzmCkSPKDo8DWsjtJr7cg3Zre3+reS2gwT3uX6
   uKOErb9sOE779b4V6qDxgHMEjj1X4xG7kocmx8FlUcEQalxmpfJRGpwyx
   4BC6t2OY85on6g/h3SEV+9btDgPctWvcE58UeCLUuLRs7L6rG7dXjJqL9
   KXgttrcPk+QDitCSUKL5m2Y4u3qiAfD7r8B3dfab3A8miW3ArYYl2uMsJ
   iCEkHr1Oqd4b7wgNVJimoHqn4HSZufNWxtEmVrTK89RyJXnFZ+dTKT18i
   ZVywXYRUOsF2/SvT67nDabqFWUjp/OkZEy3Tij6wWdtChjSkOj5vPgia6
   w==;
X-CSE-ConnectionGUID: IF5Eh5VpQNCgCdvPCxbJ+g==
X-CSE-MsgGUID: vmvOj2h6R7mMadj8dLDtVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99475922"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99475922"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:19:06 -0700
X-CSE-ConnectionGUID: cxRgoW3YQT6Zfs5wnzBaYA==
X-CSE-MsgGUID: O+hb6/R0QBek/bTVEzZT5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="242544657"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:19:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 18:19:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 18:19:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 18:19:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ5zxbeT6T2Gvpukpxt9lm0c0kK0sFsHQnt1DLdA19qI1Lt4p7Yf0HAknDZBMgmwIFk5k6tqPl02cQJWHiNUZY2QN3j4k5Ckqd0s/2diVdvmVBeusEcTxu18WB5sy+//4oxpPgMxRti3SiXGASoZ4CcQnVpNXbAWtc8mxfqJuGtbNgHMlt8PSKxDF+/IW8W43O5y2SgM2Gja+389fQ0AabERmRrD6+wVuZvqBuJqFVvGXEh01BhWj/76pc68HJl6Y2tHCZdzmfJrTP/sB7ux/Zh1hHdIFO1/vBk7O8axmc/hYrHZ0JykITdQP68ncDJiZtFKclKa/OWUFqnTCgxwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCTbRBoCSCvCUY+Ogwtsm/IM85JbeYDcmUBUT5ikNdU=;
 b=tQsvXC8FWRBqlzZQYygRNK4pdfropwJQaPxEWLOAg9E/GWT1IJcSZchW+a33GCNrXlOAkwBF6Dc3AwzDpI0m0I9/bSOKjWu9rFF4AT7aj1n8676KY6KFQheRc8Pg9SXNavgKXAlyqGWwGu49FkZO1vZUUviS0u7MOuCB4ZwsYkYHkzqfCBRAF32/boliqvw2rq5kLAvdHX2WVzaNTN5j0sY98NiYCH7X6zANAwQIjGAaHndyjB6GfTTpyC7KZhoVeF2thiCmbFC/h03Vk1EDYrNEE9GQ1KibmbaUqKGITQHfkrDphR8Kj4ToSQ68loj03pHvxd08dNgYQmH4cVo1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 01:19:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 01:19:03 +0000
Date: Thu, 11 Jun 2026 18:19:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <sashiko-reviews@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fill first free targets[] slot during
 auto-discovery
Message-ID: <aitehJe5yth4yaEB@aschofie-mobl2.lan>
References: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-2-5d94ca06c4e4@zohomail.com>
 <20260606081149.1B0F11F00893@smtp.kernel.org>
 <0df43a4c-cdb1-443e-a424-33ecc63d6c1d@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0df43a4c-cdb1-443e-a424-33ecc63d6c1d@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: e0eded82-2286-4543-9562-08dec8209700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oNL1uEiMf6eQI4KgdwTt9pOuYtAtTrzU0GrkfAmShJWXf1e5/umRN1DdKVPdyPg/4LHC4o3Xo0PwxtOSN63fSOkSdudqDMGSIrv6xxCsj6M5IYOlPZk8bf0eDfUJEmMOdE2qdCeWVhIqBTuI4rLU/Zs6DfaQYo6Bm5IEklZK50ESdcwz5Grcze1IWpbmp2hS+7s/ms0Q806THOO7gu9plmpp5Y3bfqPp7thq0iui+3pqIsIBR2eCv61FnQtRos9FUusqjXqf9cwtxXwCmZBRC9mfG5iuhTQl4o2zDDdKuIHt6FMNJqvBxzP29JF+oq/Mv6LKgz8cVoYSb3pMTTNznQf8C9yGrA3yV6zMmca4VrRuw8aTTP0wycsvqmW0C+hHr1TweFGNKg9a6R5t1LVmDJh+teSN0spOKwJb5HTUMLLQclBDRn0c4pjYVi5a4WHPOAtfeL0KvQ8d5LTqZg2G8/uRRP8ucQZFzlQ+HHE/90mkm5uRcF2CZPunfSZNfParnqxbhyFTW/eLkSBrnwpcD0wNe+x4B4WHGiXN1nncp2CYoTWmTUfD9jgPgs9TlJxZMwc5sKlQW4WfTL51YVqAcXX96q9jJbEloCmcb1Ts/iVG3pY8lVXlgepokXBx6ss8/hemKkWVJ4q5V9f07AidFDPYR0K2JewNl+5y5yBNzqQ09tNHybydaZRMq9DhO4+N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i5W75vMJVz/aE9f9xzn6jfInxtSWUMU49uPLSo70h6UVK5hWeEmYvuAE2o1O?=
 =?us-ascii?Q?DAFCTBbK0Mbx5RZ2mAFqwps8vgjLwh5oSBFcSP0q024CA2nAXIL3+E7EN+OE?=
 =?us-ascii?Q?p4/7x7x0mKS+xX+CFKM8ZJldzKYQbziDgn9vLC3lochlKfTy5Byl+nu51ogq?=
 =?us-ascii?Q?sA922+ddJBN5+W1k0/qkqfT0hxBWl48b/Yq19NRXDToQ60EJXjRnMnHGQZyp?=
 =?us-ascii?Q?1/WBRhjM1ZCOAeWo8TLQPoa9wa+8KizIVEZ5+913+ChjJecoyOiQGYDfPnMO?=
 =?us-ascii?Q?gYoNtIlsgqM9EUGJ8YW2PuK/9Zpg37h2ZDw1AlBUOh5UMMEyBYouEyDS//M4?=
 =?us-ascii?Q?k7F2JLzG4fHemfHyZPW4rNB8CUlGQwr8g4teGdIc47eUTamc73JSHrg7y5fy?=
 =?us-ascii?Q?Tdz0MjTfHHhJkXzHDgzL8UDm1OlSGOqU3+C+g2dCJrx8accP/Uxcwwf8t4F8?=
 =?us-ascii?Q?D7CBDvOfR/+ugHFXh7ZOpCyxK/f8AYYYugDD1GylhbpvKS5VrZLbVCweaXiz?=
 =?us-ascii?Q?36yU+FfTzI0ceB6cW6pqkzANpCfHrHgyYcwWfax8sgovVp6+kmsEtcxYGber?=
 =?us-ascii?Q?FfEWavMtgiw+MHn6bnvmOrzEhev0tlAHo/7AN53xyRwQsXaZNwJOy9OPXqH7?=
 =?us-ascii?Q?4unT5oq4qnCkz5rUz1J8t77OSoTrhiS4XC2ZAVGhNoGlliZLEml/XsUN+SG9?=
 =?us-ascii?Q?9x2tTh44sF/vlW9lL/EXK5M460GQ5Bjz2gg5sj1NvslphfynfThkhDFTMIkF?=
 =?us-ascii?Q?VLog+AcUAwKPijqrd2C08tc1FSXMgJTBcdcBJ7Sv3TiF57+L6q0EOEC4a6mG?=
 =?us-ascii?Q?ILcZTxuiIuwLETkxb6DRvaMmey33BNdbVsFVXdsyEjv4CINSXFiTqBZEAvQc?=
 =?us-ascii?Q?61/MeO+SCERL+hj3UVh5G8nF/2AXHudRtcqotju93MuCsU/XZFTOzeJqc6kO?=
 =?us-ascii?Q?+nwbjTWxdoUz1qYPKCHxVaCCHODifP5qGzugAWy9EO2La1jUY4l7idxJGmh+?=
 =?us-ascii?Q?99HnfyCCFcXFD+326USMgdJCWQeZa6RYMzQGd4C5djz5tj2TjtKmNxBP602f?=
 =?us-ascii?Q?Z+gKXn1zm5AW7wmVRoHlh1UFsPizq11ffGpcauuRuQ9ZEpeXCh69/SFIH8NX?=
 =?us-ascii?Q?f9JK+carQizLW/7b+KNwcM6bto9qgJX5gmUtln7Bn/cpKpA/96qBMHwvSd/m?=
 =?us-ascii?Q?7stTnWIzSTiUNItOfG0Ezyn/GYtXRVTvQO9xdm2kPATUkHWG0Zv/1jr68bLk?=
 =?us-ascii?Q?PlQ2HnMlKFUwL683Yz+r+dDurrNvPitc0l9GIOUiiFF5zfVuiCnpPUK2O+IK?=
 =?us-ascii?Q?p+IHLgtLi3FG8RGGsAD/VNffpzOkR/KrhXiviypDBqrkqpgtwmIr0B/HQLgz?=
 =?us-ascii?Q?yrXsSEq4QKdZLtnZaCMe/tWTowQ4KPAM09fC/NFN3uhktqCsSUqyhL4vgGlD?=
 =?us-ascii?Q?dMy2FsRTevLJBv3Nt2vT4T7IglN9CW0bbjbVRi7y/lEh2leA8t2WvkTFUKzs?=
 =?us-ascii?Q?H44QGDh7AytpS0q90y+P9b0c/ssE3YztgXYdK3mXpq/wb5vwlZuQNsh5tzpX?=
 =?us-ascii?Q?2xCTrVD49xQR2qmAIdzktYNtiCy00R2CRmak8pHF9zttS6X0d38g8ufYJxbC?=
 =?us-ascii?Q?HtiVV89MH2Rf1GCAOZsfXYCJ538S5cNey1WuCPL+LjC+68oDdyl6G07bPh0w?=
 =?us-ascii?Q?0afU2QyefPoV6G7wG6oZKIcBONXc5U+JClwDSAYZ46aTGXv9bRTOpX3xbrUZ?=
 =?us-ascii?Q?zyvhHmQ3CK6/Fx/Hj4AFfudAwRXr6Pw=3D?=
X-Exchange-RoutingPolicyChecked: IlZUCsh5IbDVbQEu2qOwtqMgozvOlpHWKrx9/ixTmtRS1gffquQfxheRsk99s0dCvY8I8CJ3TWMNlNCxFOhZfVLasJuBAFjbl1SkoFDmxemUmvH9vF3nSH8aN0Fnpu5dvwNJyRrC6z6gF5AbWm3w6qDGf5iWtwnEzsGil1/Dp3wSYJQF774oPWethkl1VCUKsyNZCtVrqZN+V9Uiy1n9N77o5DUjcEPUsywwAhrFsl/3+0uXoGYnC1oqgfBEw+icAHjR7L1lpeTLZt9wjBknAb54E06cfbRODhW/I5kILB09BockW8U1CM0rnuEY+UvRZG/6JEJVNpXI8BfzHerJ+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0eded82-2286-4543-9562-08dec8209700
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:19:03.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3OYLIq9sNEF01LGBXV3Pvo1l+ObajBfbCsvpIx4ZHomR+C4AHa9q7dA6vtO1gtZrqLoj9FBvKOUjTqK/m44FueL3GKPIQgtdBMCN8rWqMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com

On Mon, Jun 08, 2026 at 12:38:42PM +0800, Li Ming wrote:
> On 6/6/2026 4:11 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> >
> > Pre-existing issues:
> > - [High] Loops iterating over the `p->targets` array up to `p->nr_targets` unconditionally dereference elements, leading to NULL pointer dereferences because the array can be sparse.
> > --
> >
> > commit bf78125f1b0b7a811b9b200d37ed57cc96619a00
> > Author: Li Ming <ming.li@zohomail.com>
> >
> > cxl/region: Fill first free targets[] slot during auto-discovery
> >
> > This commit adjusts the cxl_region_attach_auto logic to find the first free
> > target slot for endpoint decoder attachment, rather than appending to the tail.
> > This ensures NULL holes in the target array are filled to avoid accessing an
> > endpoint decoder via a NULL pointer and miscounting valid endpoint decoders.
> >
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index c4335ebf19f7f..532dac77bd003 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -1848,8 +1848,21 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
> >>  	 * this means that userspace can view devices in the wrong position
> >>  	 * before the region activates, and must be careful to understand when
> >>  	 * it might be racing region autodiscovery.
> >> +	 *
> >> +	 * The endpoint decoder will be recorded into the first free slot of
> >> +	 * the target array.
> >>  	 */
> >> -	pos = p->nr_targets;
> >> +	for (pos = 0; pos < p->interleave_ways; pos++) {
> >> +		if (!p->targets[pos])
> >> +			break;
> >> +	}
> >> +
> >> +	if (pos == p->interleave_ways) {
> >> +		dev_err(&cxlr->dev, "%s: unable to find a free target slot\n",
> >> +			dev_name(&cxled->cxld.dev));
> >> +		return -ENXIO;
> >> +	}
> >> +
> >>  	p->targets[pos] = cxled;
> > [Severity: High]
> > This is a pre-existing issue, but since __cxl_decoder_detach() can leave
> > sparse holes in p->targets without compacting the array, are the loops
> > that iterate up to p->nr_targets still susceptible to NULL pointer
> > dereferences?
> >
> > For instance, in drivers/cxl/core/region.c:cxl_dpa_to_hpa():
> >
> >     for (int i = 0; i < p->nr_targets; i++) {
> >         if (cxlmd == cxled_to_memdev(p->targets[i])) {
> >
> > If there is a hole at an index less than p->nr_targets, wouldn't
> > cxled_to_memdev() dereference a NULL pointer?
> >
> > Similar unprotected iterations seem to exist in
> > cxl_scrub_get_attrbs_region(), unaligned_region_offset_to_dpa_result(),
> > and region_offset_to_dpa_result().
> >
> > Does the array need to be compacted upon detach, or should these loops be
> > updated to check for NULL pointers before dereferencing p->targets[i]?
> 
> It is not a bug here.
> 
> cxl driver always calls cxl_dpa_to_region() for a cxl region checking before involving cxl_dpa_to_hpa(), but if a cxl region is not bound to cxl region driver, driver will not involve cxl_dpa_to_hpa().
> 
> But maybe adding cxlr->driver checking in cxl_dpa_to_hpa() is a choice.
> 

Hi Ming, 
I'm in agreemnet that there is not a reachable NULL deref path here.
With this patch, the hole is gone by the time those loops run.

A hole only exists transiently between a detach and the next stage,
while the region is not comitted. The windows suggested aren't real.

I'm kind of against adding an explicit check in cxl_dpa_to_hpa(), as
'hardening' because that undercuts this whole point here.

-- Alison



> >
> >>  	cxled->pos = pos;
> >>  	cxled->state = CXL_DECODER_STATE_AUTO_STAGED;
> 
> 
> 
