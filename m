Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E22D7386
	for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774124; cv=fail; b=GmXI90PyvjuQ0+UBENE+VKjOBuxNhS7qLsQm1HQvoBcjlEDaCG6OILey38e42OXcFp85O5NsESaoxT/ZIGrOIiA+fju9fj0GfiWTwtL5OY8kEAYO04S0d8gEQFOgbg1Veh+bUavYQRt64Yn8lClGU5YWEDaTNiHlco0KD0RjefI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774124; c=relaxed/simple;
	bh=aa7OdvAtJl71lvfqMs4qwDHkt7f4Q2PfDsGy+uDdA/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UdiOVON6tweAG+IE8eADMHGbrVIgri3J2Ky7ZdCsAu9wHzK5VZXX56y+gVXZwkQhXvAFaVofDVmArhUrNlIhn1qEWQJaGlU5Oh/UAtaB2LiYxQm59fi3po+AgyxQNlrb0PsiDH9J1MbQj83JUkyjVu6xR2blSxq/OQYfoBAWJPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdrwtaWV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdrwtaWV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791774124; x=1823310124;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aa7OdvAtJl71lvfqMs4qwDHkt7f4Q2PfDsGy+uDdA/A=;
  b=HdrwtaWVfpiOCBpcskk6C5rzWOTicC5JeUAHUeNngtQVfWCD7gda3bpI
   Tabuy4osql/U0G4kmjUpLcQah4KlxLvF7fGUmx/31LsQ9loQ4nqWrMOEl
   DlJ3VaLPVbS4ixSTNwdQim5MZxSxHvPXyzB5KcfJzLzwobHCx0wHQmanB
   xp6p7xG6W0Whdt5zF40yd531aoZ9XlR9uKztQL33oPK0fTNNnCExtLwi2
   NWSgDTW+5Z8ktgyyf8rcpTmzZa/CHvkLxk3PfqHQTML/AvZBtKHjK/3Re
   Vzu8f2KatMx76BMTXGcKZMyjIoW+Oew9jqmn/z3Rr4kd+h2q12Goi7K94
   A==;
X-CSE-ConnectionGUID: aCaeIZl5SgqyMrGaIgkiOw==
X-CSE-MsgGUID: HNpY7yWaTZ6Zr7/6qaGg5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="467605"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="467605"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 20:02:02 -0700
X-CSE-ConnectionGUID: 6Ch9+F/1T1yJdztfcJxkOg==
X-CSE-MsgGUID: tRnKBDXqS3GPiT3wZOM0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="743446"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 20:02:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 20:02:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 20:02:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 20:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNZTAPpt52tRRmFNDJdCyqu4YvDhiZBzht2VmMZ+r+0VpUR7U3oZs6ktumaAI8RL/IwFnHE9bAz9SjghYHlfAjdma8ynQbE6XNHGOLyFydmutuqn69dN0BLywoxUkv/hYnk7pjt79MOmYqqcgmX96YXI/3VtUTJgLs5Xa60NFn32GZoU12tjO5I4gHZI6a+RTR9QFQZIkDEElw8Jnn2l2ozXyv7GbftouLRn1maQ3w2MnBMLfeuDXVh6XzQCxMWKfVFokNEij+c4vgXJR8oe0Q5Lewi7GT/6SkPj/dwZTVApLyu7HuVcUeSGCKP64TqL9u44f53vnaWp719k/2Ewug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh8bDiq0sNYQJPMG3MftsYfpgnoLJ+i+72HVAHvdMjY=;
 b=dPuHwkwmeh2ZcXdfMIYkhP4cK3A2ALcR/UCB0q4HOUfnghexEqHtsGXo3nLBtMP9HwL/ksH4vZZyNju2NK4jsvTI3xzJz01vWuOfpE/cNH1hUqwBihOBqOWZojwDx7xoAVhNw9vKLWyNfSRrBkFgX9zics4PuOPbdj9fc3gZoHKcBrDk2QyoezScjXba0JzBmCizNmGaP7e1mSHSnK3Uj3SXQDsh3YX/2uk0Hw3qvjVOESrYkHP9ig73Wkg4DzAJAqhNnYQ6FmIwRDKaj1lYUNsRYTRR2tFl384h6KrepNwBMMXi4kGTTG70l+/TxbieOaYdB6afMLb3syFgmYGvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DSM1PF1AEA105E1.namprd11.prod.outlook.com (2603:10b6:f:fc02::144) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 03:01:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 03:01:59 +0000
Date: Sun, 11 Oct 2026 20:01:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/8] cxl/region: Name the interleave locals in
 cxl_port_setup_targets()
Message-ID: <asxNo7QceNuOm9fM@aschofie-mobl2.lan>
References: <cover.1791676454.git.alison.schofield@intel.com>
 <712f6428213822ff3f4eaaf0e324b80f5b478a5b.1791676454.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <712f6428213822ff3f4eaaf0e324b80f5b478a5b.1791676454.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DSM1PF1AEA105E1:EE_
X-MS-Office365-Filtering-Correlation-Id: b50a96a6-4f68-470e-019b-08df280d2e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7npK3bY/bRM5jT1KAUgwMekoW6lrWTlv2R5Ml4A6tqsfWKtdiuZFZ+rtuHZ0nNrIlmuXNGEP6jM3e3z75TOvhKCOPbeODr+2RlhtbdFGohA40cs1Kv86DgrUWeg+5utx+FxCBh6uB9y8MvszZlQWf3t9Zg99usTH6mjxiU1jOKh9ftxZWZLhYbZoTKQ7GWBVFpvPqPrFpl7Kt9/RbpoGxfwjCsYpME/PeAuG/UPsrS07N7XMawaGtYXnTp+MDlU/oFpwXkiTi1iNe0RQ2c7pc4Aa1tj5J9NNVO23NgwZ3eMOfEyzl1mb+JTmutJ0zmCGuaDPQoS2nm8qJ5bUsFLQJ+BoajE3L39T8ZrTLPYGn0GSFgeqRtjiYsDOKqdOwG/5eAH9CJjiMIOCTufjswWjduLLVdkooT5wW7V5CKxV6EBm5aK3NiWxjMIoKVAjumjOOo2Ntouiel/gH72gZYH/XD63JN2Kh+DRXpyqJS48bc3XcjLy8JMid/02h1hwwam7ZMMiDgogdaN1rnenA7dEjsKpoWUZwUfoXbBUgNIFoDqKGgIApAuMdDoZfmygiixduQ7SZQsW3YL0AyfJHqFbh8X0zgAXAQTXRmnA8veLxgLKByIPfnEnBWGKK2pWKBr7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UO5NjymQCLgVP8eJtggYizCqtX0IlAM0uGkrXuTu6vN3qMrrjvOi9uDfi3dm?=
 =?us-ascii?Q?U1TOruy6itrZTZmBIpnnp3ucbhBmHnpxdfnZrxTmubdaWwbHXV/lz6WquQ2h?=
 =?us-ascii?Q?mqhPVhoqWyBFw8dUbRcfj2OkHJsv/SMO1sH0T7QPm3QTQ5fsrXexFuqJghix?=
 =?us-ascii?Q?YxOaQvu/9hwZ40HizgjrKbhhOkreDPIAGKcwr4BPqapkgy9vPHaVc4enew9t?=
 =?us-ascii?Q?CcnC7aMCazOuOa672itA/an0fPEt9aZsZFhTcXIb+jjn0DOVQD6RiK1caS+V?=
 =?us-ascii?Q?1DD7E819oQqsucqJ81HU6jIG4JhX0TzRbkAwBd7nXZ4/uKUJ/Ttrc/jKAaS0?=
 =?us-ascii?Q?QTp5VNa9869pRRlLoOaO/E/1z0xkydnFJSBHmFi4wAy3Yti52217N7/xwcgG?=
 =?us-ascii?Q?3ntKOE/UVxapUvBccJtKQxHcUhzVnS/Mnu9XBJ/1zG4fwgJoBnZRwMIB8P5z?=
 =?us-ascii?Q?VXsGrSDmDp3lcE8MAd0oJcy5pcco36cYM4Rgnd2u3UAnVZtY4UxtVzUdFBY4?=
 =?us-ascii?Q?Bji0nhkLyVhvFN+zPBe0xDpUOwkXwoMq1nrxP0RIxNWUwCMFm34G6hEBJBdH?=
 =?us-ascii?Q?TDwzXeIKCnYtzVAj/jZLeIi6poN7nYWpjZdsUtXdkmfgOuG3Gl03d+LsZXL5?=
 =?us-ascii?Q?J1MMqItRxa14KJTBeoJ+78EaNGddpnht52kiinKsv2OOQB4LVO2IfykmDKmC?=
 =?us-ascii?Q?3wgt5gR/8dk9GQbzlEtTHpFkz6blZWKgkcdBypkDJjQSSKijEnFLAMhggor4?=
 =?us-ascii?Q?z16cFqVQXYtoSyKan+RSF7XbkBsSsc3OZ9ZuIShXS+7j08XXTmFTZCMU9veh?=
 =?us-ascii?Q?zxpBX0awpNcQAdZ+T9sdZxXJj87UzYZI53bJ/XheuyCrLC/xA+UU82kl7S0X?=
 =?us-ascii?Q?gg+Ah+Zh3YzX3+kxgqPGDqd33zETlAcsZ3AiLbyKnCWZ+CY9IbxaV8tiTvi5?=
 =?us-ascii?Q?O7bcYM+LylJ76vFbsqeZ6Bunv9pj86CadikXmHCLfGYLT0u6HEtkxdAQPqwA?=
 =?us-ascii?Q?OfM1qrB4LD75xJeQO9WNDEH4gIc5/ZDFav6p5ICqPxvjBoxCgKJr8sSOjkYJ?=
 =?us-ascii?Q?w8xGv7xewUPgXgd89NJXtJhKoRwAINLi1XBKh46awTVQzt1s5OGke082EVcv?=
 =?us-ascii?Q?9VzO/Pm5GGajAR5lZ5V+DggwHWqaFL4gI3JR1/HuUijYOT1bMjVXmZkW6A2L?=
 =?us-ascii?Q?xoKFveC7U4Ghoz7YuZWYlsewrPCjPS9CfXTThxIIOVBeRISeCZlaRzpVeL1x?=
 =?us-ascii?Q?i3WoQPb20+D0vidCXUmKMToKsClHCufvDik2VYy0YMbNtueC3eLymfLy5L1t?=
 =?us-ascii?Q?ChA6t0clvFvjtJdsdFhqZnmNp1E5ige9CawDkUyQiQXuAgTEJh9QVd9+hIFp?=
 =?us-ascii?Q?dMojuHLi+0jCSvM58QEc1Qzhj1RL3H2mhTIV7mU2nZlwZh7Ta6ZMd7L3z819?=
 =?us-ascii?Q?zUZV2dwPjcjqs1fBjVi0ZVoFpngBDqXd7P08/E/ZfMpg4Rqnzl8q+qORGFTQ?=
 =?us-ascii?Q?xyTn9WjyIs0QwDFZc/Mu4wMYQaVHKJIbxETQwjn1OXIgF8ciREo11WUIkqs+?=
 =?us-ascii?Q?LStqYDvDa4SIR9NwAUf0FYmi5qcLq0AzcUh8Srqr1KquGkg/rjxrduubKPuR?=
 =?us-ascii?Q?GbM4kTfLGdQiRydKVl47o1/1a25AYeWciNLDO4shhpvTp2EYxqD1Zpt0bTOq?=
 =?us-ascii?Q?rEbWV+ZM4J8V/1YZg9K/PKCzIqZdmBx0FvElkiPYCzCCZwGZ9MWN9IhyTR0G?=
 =?us-ascii?Q?n4OgnylTdAPhXf2t4vYBsCY42m+ke+4=3D?=
X-Exchange-RoutingPolicyChecked: Kw9BXArJndCB0UIhStVDmqqhEJOGuH1Hq64Wi5nhBExP8P7bVGZ93IbJL/xhoSXJdq24MuX9mhH4mVltW7mlriQ8cE0w1MYF0mVrQ3CAo7/sDfI+6sjHBVO4z5QUzxb+oSts4djx5EZsXsbeEXnZPLXgD+idNf39gvy6BQeCS6aG8NYRYUvkpDTNjzyyvwcq6/hCldP+C5lLXCf/E+D+YRX/H9PDcJQFrCMvDtaP+3dTEinEuKnUGfztKZ24t8uS4uC7W8/xDRaHhQII+tNVK30XiucJC/paZX862mB8/VnLTvkcfzD2CnPYstpCXDmgrv0kQ7E/yC0WxG5rh3C5Pw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b50a96a6-4f68-470e-019b-08df280d2e62
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 03:01:58.9918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVV/o0+l24m03k0qFravoa8f0BqD1HzlX4exJu6/E7K4IX1MYLtZtCEg6Y+Nskme0Q1umKV7/xGa5quD9XyfJKttVVF+FWNnQjmV1IMr6gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF1AEA105E1
X-OriginatorOrg: intel.com

On Sat, Oct 10, 2026 at 05:20:17PM -0700, Alison Schofield wrote:
> cxl_port_setup_targets() derives the interleave granularity of one decoder
> from the granularity and ways of the decoder above it, and takes that
> decoder's own ways from the topology below it. The values from the level
> above are named parent_iw and parent_ig, but the values being derived are
> the bare iw and ig, so the reader has to work out which level each one
> describes.
> 
> Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
> for the level above.
> 
> No functional change.


Oopsy daisy, I was suppose to drop this patch based on our discussion in
v5 of the mixed gran set[1], rather than carry it forward here.
Sorry RobertR!

[1] https://lore.kernel.org/linux-cxl/aq3dkCq3WVYnFVDD@aschofie-mobl2.lan/#r


It'll be gone in a v3 of this set.


> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bc087ca63946..1a42753fda48 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1437,7 +1437,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> +	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1531,10 +1531,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return -EINVAL;
>  	}
>  
> -	iw = cxl_rr->nr_targets;
> -	if (!ways_valid(iw)) {
> +	child_iw = cxl_rr->nr_targets;
> +	if (!ways_valid(child_iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> +			dev_name(port->uport_dev), dev_name(&port->dev), child_iw);
>  		return -EINVAL;
>  	}
>  
> @@ -1542,32 +1542,32 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	ig = parent_ig * parent_iw;
> +	child_ig = parent_ig * parent_iw;
>  
> -	if (!granularity_valid(ig)) {
> +	if (!granularity_valid(child_ig)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s: invalid granularity calculation (%d * %d)\n",
>  			dev_name(&parent_port->dev), parent_ig, parent_iw);
>  		return -EINVAL;
>  	}
>  
> -	if (iw > 8 || iw > cxlsd->nr_targets) {
> +	if (child_iw > 8 || child_iw > cxlsd->nr_targets) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s:%s: ways: %d overflows targets: %d\n",
>  			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +			dev_name(&cxld->dev), child_iw, cxlsd->nr_targets);
>  		return -ENXIO;
>  	}
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -		if (cxld->interleave_ways != iw ||
> -		    (iw > 1 && cxld->interleave_granularity != ig) ||
> +		if (cxld->interleave_ways != child_iw ||
> +		    (child_iw > 1 && cxld->interleave_granularity != child_ig) ||
>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
> -				__func__, iw, ig, p->res);
> +				__func__, child_iw, child_ig, p->res);
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
> @@ -1578,24 +1578,24 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  			return -ENXIO;
>  		}
>  	} else {
> -		rc = check_interleave_cap(cxld, iw, ig);
> +		rc = check_interleave_cap(cxld, child_iw, child_ig);
>  		if (rc) {
>  			dev_dbg(&cxlr->dev,
>  				"%s:%s iw: %d ig: %d is not supported\n",
>  				dev_name(port->uport_dev),
> -				dev_name(&port->dev), iw, ig);
> +				dev_name(&port->dev), child_iw, child_ig);
>  			return rc;
>  		}
>  
> -		cxld->interleave_ways = iw;
> -		cxld->interleave_granularity = ig;
> +		cxld->interleave_ways = child_iw;
> +		cxld->interleave_granularity = child_ig;
>  		cxld->hpa_range = (struct range) {
>  			.start = p->res->start,
>  			.end = p->res->end,
>  		};
>  	}
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
> -		dev_name(&port->dev), iw, ig);
> +		dev_name(&port->dev), child_iw, child_ig);
>  add_target:
>  	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
>  		dev_dbg(&cxlr->dev,
> -- 
> 2.37.3
> 
