Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E6157472
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712700220; cv=fail; b=lKAnqk7aWMeufYoBvlUtDaCkqu04XdKK/ptgFGhE7WspC3+Uf41dQr2w6Isp9rlij9OOJOqcf9HhFhQVT1c4EEMo5DiSdjlZ4Jt1EWftPycfBKVo5kcqBCJD/YiyNqofB2uyi3+hYvV32rnqmeN4x1QlVP9kt5zHoXrFHfBBrAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712700220; c=relaxed/simple;
	bh=FlaNBlXYesIYCODPIbzRbpYYben8cTISYBkUzxI5kPU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RNYwL/NOwFHJiYZgDEul/+PNwwKslNstJyeOGCOSiX/x7BOGoT/S4po+0fPC5OWONbB2tQQa2h6+5cIxbKOyrlskietkvr/fR+xFBOieL6+nHcniO65lMihe7VLgb9eI1A+kFVefQfscAe+7fW+ezpQ3JL9RUX7SKTvq3w7cP8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mH8r/Xfp; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mH8r/Xfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712700218; x=1744236218;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FlaNBlXYesIYCODPIbzRbpYYben8cTISYBkUzxI5kPU=;
  b=mH8r/Xfp97kDAzrNORYBfJLlKjF8GD2zuQzFQgl1OLrUZHLujp8iIw9M
   l4zTzB15e6cY+DA9WEr0wdL4XcxwKmXxvqcoHB5oluk/DCYHi6JGWvedS
   PnZys1irgmEl1/PYxUGaYPxtrYA41plJjR2gKJMPFoY454sWC0B15ha8X
   kYs1qr6Or9vVIKL2MXjxZlCjGL6kN8hfy2BModynHH1AlWVJpv6uIIRPq
   lB4N8H5aIeGEBl9kxWiePLeIyAC4/BXrTwyNtm0xxJyXw7bcEFYl1GU6l
   KUosd5h6Lj/6+2WbhRdy/oRm2LSxTsojCll1p4OtsioFqXSKteNbgil19
   g==;
X-CSE-ConnectionGUID: h2ZieZQtS0muxorgUsc8QA==
X-CSE-MsgGUID: 8SmKK9p+SceJDMZLlql5sA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19424627"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19424627"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 15:03:30 -0700
X-CSE-ConnectionGUID: 7R2P7m2JToaH4CIKaYl+Zw==
X-CSE-MsgGUID: R58uKTNkQy2VrF9Zcl0q8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57800933"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 15:03:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:03:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 15:03:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 15:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbyv2rZ8eHJU8kFzFmsI3BiWhmIg6nvp7jwZ8KaDsa8U6oKXk4hXseViuHfItAEdubhXl6ppnQo7Zy9Sy3WDiWl0O5E/3ImmkYzN0OGGMjb9AZ0WmN4DBtqRXKL4iST1aX8nZHpKGG3MzvvdjLdXhjixbcLnnGlps2uuPqA0/dIXG9DTjDBhYmYk6Z7lY9hfNJofGHq9gFmRdWOU20yX6YL/PsL9h7RjZgY3DntZ6KronjX8nioKI1kFemeNEoGVG4dp1JqGL+uLoJG7KVNcpkrUO9vgh/5s0RAcFNDekRaCQKY3WPDAmhTHbCK8fgabNnGKwxmiucIo1yr+0fHPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okQa/JwOPJJPaRo5E2DTbZKrFJQQqbXgpSd8QgkKbdo=;
 b=QKWKgr3XpVp91y7vPpvu0acirFiG6yD65mXDBwQGRKwkvPkjRVq7nf/DODqOPJLs+ztBE0KWBu2N2pPhdAaI4juX4VebKOFURmDx+JaacZiRBn1JlIfU7hQ9+AgSs/q5I6hIkkuIAqErX1uCXI4gX4PboOqL5RDQ2fm3Dt/kO3DDv+2ZM5PuALMTuDY9PsOX+whfgztEQkbvIs2gzIK03pbMkrlFZaNtCLVubWdiEvVAf1N+pPgOV03DrCKpO4VmD8yheEsuJpPU7A9scSRjiXa+pfWrrt/77x0hoDLoJHs1XsbaBI/0i8khpiH7FynEBzouZ0tHEg96+9heNmjjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 9 Apr
 2024 22:03:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 22:03:21 +0000
Date: Tue, 9 Apr 2024 15:03:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH] cxl: Calculate region bandwidth of targets with shared
 upstream link
Message-ID: <6615bb26a0cfb_2583ad2943a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240409185023.151885-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409185023.151885-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6559:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2Vbrlcr8NPFIwcsxGSibTfduv4SfntpxVtADxuzcdtsPsokl7pXPLhoMR9BbAi+0ystyP3If+cZzcmGsGtD+Zw8gePRTdkfMKGD+shHWREJ1qXaKD+9s3CXsiXj7qlXtgAJZfaHw7YjCqM2T4QYTN6VlVBLNoQ+ITvLtu/NZEQhL9Nd7uu408ik3b2uC2RjosJGvWmltoJCbUWiF5XXptgOuL6jEDvGQHunIzYxVGlzyax5X1KCFX9o4DXRXaDsllfhlYEida5YX83Hn2x+qpeUqiJolJ4JABRZehy15up1KNdsNOAFqG8JR2q2XLXy2Xl6gfjFN8AeDFW9gN+99dsmDA6+dwsC0ntK6wiFygdfQPmZrmstI7Bn4/HVRtuKkCW9NFIO0Cx3QmmrQjqxef8an30s7m6oYFKtAm3KVp/D1q8TlCS3pXw0Cexbq0gwikqHZvfq1lKXdHgWLSI5q9Zk/hfAwXH4Lo6TzTRvTCw+uBY8qmGGnnDUzOVnDJw41ue4d9MuZbTRK75OTnHNwE31sS5anaA7XCefAV66tZuj6DFJNtWHzmRcfbPSo/kGjqG5me7h/U22WCTvQMBNVVlyevkjjWAFnu7Zra5N/WQTy5BcrNhhoNUNYB2Krgq/JRqY2upjDhscz6QhnovMcNLKLLmx7yhJYWZi2usvDR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvUxhS14t0s1bUn1g5nW9EjV5jKYutwBf7635npcS7Y6LZd4eQT7RNgeLexJ?=
 =?us-ascii?Q?GP7PI/kyoMaYecd/4qrKurNXggAnf8ZPsvX+RimKZ2x7pY3358SssIVzahCO?=
 =?us-ascii?Q?7EJKz1x0WtxTcT2PSoh6UjHJbITU5xbgr57Ld3pt4SCT8dWjlowyWs515uj5?=
 =?us-ascii?Q?IRxmG6dVh7DU+ZUEeoH2Wt9PoPt3UeY4VJMyTSvYYWmksAIsfxwR3cixqncp?=
 =?us-ascii?Q?oWTUXDmgPqol3/K7YFftjcHeChEwBCP5K1ULaeN0ttgIme7jBftyiUKYXd0N?=
 =?us-ascii?Q?0ZGRNhOq0ACNT4zEsIsV7x1iktH87Y/9QL8I8wbeF7i9xNhmDYuaRR83glGZ?=
 =?us-ascii?Q?086fot40RSaYB7vhWwgR/EaLV7xmmWLhBdFB5HbQ6rdDoaaJX3XsuCbE+OaM?=
 =?us-ascii?Q?cp5lC5ezdt5nOXXAcNatmCX4euzkfehG4qD12yr/LTg3zJzRm2v7n55d90CJ?=
 =?us-ascii?Q?wZ5kpgyBKUUjlZevBg9p1EYBRZ/ZDj7y4i/nQA3V4ACK/yjHejow25qby6yK?=
 =?us-ascii?Q?25LXDS6cDqrbhw1W1lPu172b4C6bhTj3KYBPl6MI4s2v6QK2DU4DEJaPBodx?=
 =?us-ascii?Q?RDIGiO4WjsKbqYtWT7DTyXSoMj23AhB0CBLocFCHKs6OdOQL+auCxJrpbDC3?=
 =?us-ascii?Q?djCZK/rkS50Eqb3194DouZxVRKKHERVStRR2KNc7N3oK00txbIY/GmB3sM8C?=
 =?us-ascii?Q?0L6nr45EX9Y2h/gE6E1elc/42aRBIV09qy/6VyN5XxKLfvjOSLPHwTWUHst6?=
 =?us-ascii?Q?jcNb2McPLYIpp8gUJ3+HMWEdfLC+2aM3oOwt60RF/7W1udj2oB9Ha44Qiq9w?=
 =?us-ascii?Q?MGEKis6yWdbLXezgIaP8CNI/nLq9ohhTQ5f022M922J0iFnK9DpJm8LMDqIE?=
 =?us-ascii?Q?VfJNvNmp+lvcC2StEOwS8/v75zygtoLademSpBpHknp23p8D58Z7LoNGnZjg?=
 =?us-ascii?Q?wLpwGI69a3WW0nwzfctGlcGopwXXp0wb03dWgwWpDqCLEZDRGaKUm9ICEeCj?=
 =?us-ascii?Q?tl/vp9QoUpUSsIbKR6nXRnsmz2lBdQyY5e2/QcrFwdG/go17lrQGzCX4MMYh?=
 =?us-ascii?Q?8JTbz0C0dWCiAn6eJg4NbsHQ1ZmIjITwBSp4yNflCNT9xaMFZA1YBjzhMvDW?=
 =?us-ascii?Q?GdgYKj9ihuHaKB50hCIGq2nliok05yrHU8CR60H4ou+efcmGPHVOf/NYxxbi?=
 =?us-ascii?Q?FMvqljpLG+AyTl8gf9btIHiy3QiwSARdmu/YrADI3B5ceI04a7gAMaipBLxa?=
 =?us-ascii?Q?WSU+PRNnsiJvkBB2cQF7umM36lnDPB3NoxlqlZsi2mgi00ltVT8l8XYZ3Faf?=
 =?us-ascii?Q?UpxzgF/jJvGf1hsDPNyW+uI62dbJD2OLhUJPDn3ACI5WoMwYMP1f8X9RQcbf?=
 =?us-ascii?Q?NbFys2q22xbBLQfk6Ut8i3CaH7/EDESyi0hENimWrLgdRS8jhxji82Zuvevx?=
 =?us-ascii?Q?szNwd2+sGF6BQKbRlB8NNkJV/Fvng5uQPHQvMgSj06lfPWXBaJM3xv/SnVmR?=
 =?us-ascii?Q?APrIdTZpcOfRo3zE0BjAccKM+DFO0qetbDdsITuLZ3Sy/2vLT7gbyGem69Ex?=
 =?us-ascii?Q?0CqRHJ02X7yxVOUO8rJYnzU9h4YuQJdKmO2relE1eOkqb0aBkY5PT9HUVc3R?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b3133e-8f7d-4b48-0c8b-08dc58e0deaf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 22:03:21.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSK+d7lMAytsQNgCypsqXCwcpHVOsQIRupZR2mrhFwKG3pKTKS8dyUNu/JFV5Qv2oTDMZc3Jq5lWdiXTSbOmIK7TvcqsU4LEYPa38JCSpes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> For a topology where multiple targets sharing the same upstream link, the
> bandwidth must be divided amongst all the sharing targets.
> cxl_rr->num_targets keeps track of the numbers of targets sharing the same
> upstream port. The bandwidth should be divided amongst all those targets.
> Take the min of that bandwidth and the whole path bandwidth as the actual
> bandwidth for each of the target.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20240405143242.0000363a@Huawei.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c   | 24 ++++++++++++++++++++++--
>  drivers/cxl/core/core.h   |  3 +++
>  drivers/cxl/core/pci.c    | 17 +++++++++++++++++
>  drivers/cxl/core/region.c | 10 ++++++++++
>  4 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 4b717d2f5a9d..af5c02ab49e3 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -551,7 +551,10 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  			.start = cxled->dpa_res->start,
>  			.end = cxled->dpa_res->end,
>  	};
> +	struct cxl_port *port = cxlmd->endpoint;
> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
>  	struct cxl_dpa_perf *perf;
> +	int usp_bw, targets;
>  
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_RAM:
> @@ -569,6 +572,19 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  	if (!range_contains(&perf->dpa_range, &dpa))
>  		return;
>  
> +	usp_bw = cxl_pci_get_bandwidth(pdev);
> +	if (usp_bw < 0)
> +		return;
> +
> +	/*
> +	 * Get the number of targets that share the upstream link. If there are more
> +	 * than 1 shared targets, the upstream port bandwidth is divided equally
> +	 * amongst all the targets.
> +	 */
> +	targets = cxl_region_targets(port, cxlr);

cxl_region_targets() is too generic of a name, or otherwise feels
misnamed for a function that is answering a port relative question with
region data, not a region-relative question with port data.

Also, how does this handle all the shared links in the topology? For
example cxl_test has 2 endpoints per switch and 2 switches per
host-bridge. As far as I can see @port is the endpoint port that is
never a shared port. So I would have expected this calcuation where the
topology is walked.

> +	if (!targets)
> +		return;

This can only return the shared targets per port *after* all the
endpoints have been added. Looks like cxl_region_perf_data_calculate()
is called during region attach before all endpoints are known.

Maybe step back and do a different algorithm?

Note that when an endpoint is added you can see if it shares links with
a previously added and skip adding its bandwidth to the region, unless
the shared links have leftover bandwidth.

In other words, rather than try to divide the shared bandwidth just to
add it all back up again, skip adding it for shared / saturated links.
Not sure if that is acutally easier in the end, but might save you from
needing to wait until the end of region assembly to figure out the
number of shared targets per port.
