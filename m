Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2D70AD6
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232320; cv=fail; b=Zwko5ScEaFT4FAPm273R2YbuW7O6i3ydORHsLsaoKAr1KWSXb0gBcQJycoUsF4EH1gKUG27MgJvaae5eTq5TZMraAAcNQU49qjjV+AqFkiCClObLRceBSjXccyNw5+jnj56fgr6Ehnzso9Qo+Xyaep1eQ5o1y7CeOccN292n8N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232320; c=relaxed/simple;
	bh=diQUFqIPocMV/rWC1FS92XxAaqC7c4uuU9zSx2Mkx08=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pbG0D52uj7BbdzwNPzRWsufdVnYsl2lg8tcVOv0yJqknSNxNr7nmy6uGqbBAh7rPgrmvEeYaYQNbH4UaWR+JBCet6Jlx3LC5wWZ5/cnOYt8AFjOC6MqoqjkVfUTZFCnMmGW62Nr2pFJe2Zs3z40tVaoZ38oiw/H9B+ST5AKEFEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTLRAcNh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTLRAcNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709232319; x=1740768319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=diQUFqIPocMV/rWC1FS92XxAaqC7c4uuU9zSx2Mkx08=;
  b=hTLRAcNhsfIQwHqhA0a6N1TQMAaSQzXTR5OoQsx/HmnaoZmOIOjHYPOJ
   W4SWQT4Jx8SbrCs9rXcCtfhLbX4BJI4+BPO6jZqQ2z3Pb3i8mxLFztvoN
   AX+9laezcN5hmegkRXZMmDOBBLieYLjJElR9/qITnD2B39K0w85vCvbtT
   5KLHCBtoAC7xzbt+H4BRHi5kBk7uIrUeKvJ1U/ZPLCjsGxKgUyfsjnqPX
   adMRxxLAjq7rDfhCVMVCM8rxbaG+hDuSAMZ9h/rMuLC2jwd6uUJj1aTOX
   JhqVWgIw8BBD13Srs6/chOqi46ZPgg6qqATqabrmYyz3LOTVHYAqlYp/+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="21273564"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21273564"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12604159"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 10:45:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 10:45:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 10:45:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 10:45:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMzxVMDOlnjuXBkEUUpiDOzqISO39mm1/YItC9Bb/GoSrUe5RHaLXERZ94CRsaCcG6ZJjE154KEXEPvyxgFcVSYyGK5ELdu/Gi5Nu/UOR0noewNN1+oWVXFiskt2Tdpa1vggOpXGBaQpuOWrFd/6CU5FxZn+bCZma6KnXXxMyhSv5YKEBLWuCHO8ndZp9Cp7vJ8qXBE5QOUnWDaZTYckfrAIZygNG+23E8/0bkN1QF1p2Z4nZOHRKvf7RGYO7jSSjXQ2UeTbzy6DbHC41hViT1iAPB2QUiwLY2av/tUrq0ixAm0CgZ9M3b49ufR6g2RYJDXkbMHO/ZzKjOEIWQo7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xryu27U4tLm0QW8bmqnVXijw+Okbsm1jZoE/qJIsv0=;
 b=lugGTfd+8q/ZIcyXm/2fXAhV0YuJ2eT3bbbv7Wab3HjsjTipCvxdBF+4+8as7hXV6+sljoSWXPq922hYRMTPECBkaquWO+v2gtfqqbnrOyvgXn/r7x48VbSGSG0MWk0s56IRse/eJxiAuoTJzE681dukkAnBB0/MfYcXOEfsmMeP/guNDi/HWlj40+hsYB14INrEkDHzBChWc63BCTAr+ZpkyvP2a/xZ29KqP89p9ug3nP6dsb0epUPS1ZLrnFBDVAxC+5g+nMgshfxVfpEZ/6ieo1/DZVxAGYKnIdnjyHEA0WELtKcgL7z/uNk1riMuJBhlmj1BG10gKgMPn6kTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 18:45:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 18:45:14 +0000
Date: Thu, 29 Feb 2024 10:45:11 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 1/2] cxl/acpi: Fix XOR 3-6-12 way host bridge look-up
 calculation
Message-ID: <65e0d0b7bd91f_1138c72943c@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1707891715.git.alison.schofield@intel.com>
 <0eebc96f0e36ebc74b0dc0f4112b70cced6907a7.1707891715.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0eebc96f0e36ebc74b0dc0f4112b70cced6907a7.1707891715.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ddff2c-0e80-47e2-3936-08dc395690cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWYqtJv0ysLQuzVV2D9jGQGxW8blI06qX07wc1lNG9fwuNWiZXNHIt9Lj2XVxDvOQfikpPleX1RggXmQTAjvL1NnbJjWk2Bihm4+Bc7AkY6qYdE9qZIHjlfO8acUGLDSPX32VCw154u7niGPxU0DYVygFKp8kSO+RdNpN8f9qTrrgj2SPDNUoSZkRAclCQCucK0ZKuzfNha8v3d/OxDcV1HJK1BaAI+fk4Xt73Kl9wKxUw78AqVGYzF54/pnzhb95ldn5dFDSy14UM/iOs7qW+r9eST4rj1+VemSSwEJHLJrWdidXQJd8swFLxxQQx1IEywkPzmeHcmWvZ757sR70SKnu/K7xjAAOas724q1vRKTfhZmofT/6Lnkwv25bipotiMPDrmuPU+S9r+jDIXggHzjMnP3xI6IG1bZBbBuqnLe3TSHLiBk/mAKkel3F7YZ1L6JYeZO41VZZnZUBY9fYDhVm3BIZaaOFNWDVbJDcgfBfmEEIhBbIk6nSD9kcnXysVcD1vH8R5sSXyxRV6ZtKzKiCnXBQkAuUljLlN1qIrzshe+K4SMdt7DbN9WtyHvHU3JO2/hV90oSniG//3ssHh9wUP+hdnA3gIMa6xuXN+OYuZpeP/AdxzTD4hbdoE0eFhrW/ETZEPZRr2emvBmuPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B2kQS+NggB93U6JVkIq7APg+Ngzo84Rft28u1npnQXH28XTcbsgniYNPkQgQ?=
 =?us-ascii?Q?U2zeLWGhJbMTNj0JMDidLiitH/UfCBy6N7TCcB+IMAyagtSpHDHutRE1BlXe?=
 =?us-ascii?Q?E1URGWCNfpeJxIAdmiEQuQAfevKjk/HIZUhd76LZoiMx14P2D6eg9+WUc43T?=
 =?us-ascii?Q?2QjWsOWZqAueewFWY5BwNJDIeo9kZoakqOaUGVLnPvysy0RDYiy6xZJqU0UX?=
 =?us-ascii?Q?5IfLRoT4CNiqN/w3C7DIKWDRqmNAEDs9zyvb86DlHOrpIoGSnkO5fcvq7VDo?=
 =?us-ascii?Q?wPllsfgORXjkvoz9VP6eHvC26YDvFZdrN3SPiD19zCc74UQcNRWTJZYbsneN?=
 =?us-ascii?Q?Mzj2A1kb0+9Rn2ICzSFIhUNbqus6TLM/fJe9nQH3cq5troec/qo/I+G4Af3K?=
 =?us-ascii?Q?fbuNbwBPAQsVUOF/CAyKYMktWEgjL/Yhh6hUsSvsjFf4dI4+LLA7ahPn9ApC?=
 =?us-ascii?Q?9u/whaNrQcBkhvUMxqdEPdd/Jb7F7Oqx+erj5QqCeMShTG+X0a5o9C3RIcKG?=
 =?us-ascii?Q?mCASTseKmHRPhbmwtop100XkPDarPL+kwykfoRGEcsYnWiKrLMv0UPtPDm5C?=
 =?us-ascii?Q?kT9EGq5qym2ZoqY11WSLIEWgkW+7Q7w1VzRbgOym45YelW97fwyLdreTHWwZ?=
 =?us-ascii?Q?8xO7x4x3gcaNk7Xx4Qf2xpEkf7uEt9fm584Q9PudzFLY50H/TvNEr8wuz35n?=
 =?us-ascii?Q?xKCjRABGQh3mRfF+QYsQGQzUsxuNb1iUbkzFOXOEQfkcYNttEFUG4DDSo4QD?=
 =?us-ascii?Q?9rOnlB6rg0C8oaXfaXrNcJcDYelSccLCTrpjB3R5soroR4nn/zLtzFDj+Wbn?=
 =?us-ascii?Q?G3KbIMJCbLOHuL++WsuVIYC3fO/D4U26UF2f69ixomju9YfH+JqatWyuH2Qc?=
 =?us-ascii?Q?dLyzJqT1lKvOTQyh2xr6MIgeor6Kdfoc/vfcEclzvL63MaY8yD+5oH8iyAbb?=
 =?us-ascii?Q?DYCugS/K6jMeP1Y4bfwnA9j6y0T/o6pRvlr/C7e/bzyfmX9/LpE0eacak+Ma?=
 =?us-ascii?Q?KUk4BbO3uaDxAI4kQ/Si2U9KY+cXBFsCUDsBxyIwfwJ3zjUb1c+UONcjNe4x?=
 =?us-ascii?Q?XXK3cP30U7U9oPPMDhNhhuYufItLzCzTl0pbgeZ4oG9lK2LluEv6pWYLTeaI?=
 =?us-ascii?Q?z730hdHLhJSbFVr3okgbS+Di4EXox1C0zI3uTXoFRUR0xHG3e0NX9DprZtRB?=
 =?us-ascii?Q?h9KYvzceVEIkq2Jqq5r1m/+WQpoBAm9Q7a3dI5fxexluhCQMvAPWyzK9vSPy?=
 =?us-ascii?Q?F64wehD1wxxNarKBk55Oe6Dxh2H/0Qo6DCgBSaah0wn2IbZ/MDCidquwi/gM?=
 =?us-ascii?Q?u/kCq6KYPLg+pTUQBpZLMQegi0aC/TWRidQp3JQxa+baqj1qvU5bJaMz6EMW?=
 =?us-ascii?Q?n3oAEB+Sbc+vT95Q62LadFH3UpZsIXouM6bob3UUjhfxxTI2p8eP8rPYN5T8?=
 =?us-ascii?Q?UnXHF6yfq0KymBncgGJI5tmW4E6Vvwlc4YGd7PRDCK+pMuTdM5PHeEmPrRPl?=
 =?us-ascii?Q?xqW/qI8E8VUS0OZJDZRmy4Xm3MaaISULpodNgaL6pZ1S7DGMNN8S3dTgs8bx?=
 =?us-ascii?Q?C9sssr8CP1xcF+v7EygkeCU9+T/VK6dhJvzD0kr7QHs4OoCbpDKiqs8mvEXh?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ddff2c-0e80-47e2-3936-08dc395690cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:45:14.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qAbuFa2aidUO8hcNjmC6rAI52eczgNKr/Wg3xVkVC8eRWE99MY29PuRBz9je4xK8W5VeR4bLSR98H9AyRlEDPdfWNblxIZ9IJGzqdd1Jtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The XOR host bridge look-up function is broken in its application
> of the modulo calculation for interleaves that are multiples of 3.
> 
> The failure appears like this:
> [] cxl_core:cxl_region_attach_position:1433: cxl region4: mem0:decoder8.1 invalid target position for decoder3.2
> 
> Replace the broken modulo calc with the same modulo calc as used
> for Modulo Math. This is per CXL spec definition but was overlooked
> in the original over-complicated implementation.
> 
> With the simple modulo calculation, the jump to a helper function
> becomes needless and the work is now presented in a straight line.
> 
> Display the interleave_arithmetic in the dev_dbg() of successfully
> setup root decoders to make debug lookup easier.
> 
> Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/acpi.c | 51 ++++++++++++++++++++--------------------------
>  1 file changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index dcf2b39e1048..86c735f733ea 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -22,31 +22,6 @@ static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>  
> -/*
> - * Find a targets entry (n) in the host bridge interleave list.
> - * CXL Specification 3.0 Table 9-22
> - */
> -static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
> -			  int ig)
> -{
> -	int i = 0, n = 0;
> -	u8 eiw;
> -
> -	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
> -	if (iw != 3) {
> -		for (i = 0; i < cximsd->nr_maps; i++)
> -			n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> -	}
> -	/* IW: 3,6,12 add a modulo calculation to 'n' */
> -	if (!is_power_of_2(iw)) {
> -		if (ways_to_eiw(iw, &eiw))
> -			return -1;
> -		hpa &= GENMASK_ULL(51, eiw + ig);
> -		n |= do_div(hpa, 3) << i;
> -	}
> -	return n;
> -}
> -
>  static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
>  {
>  	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> @@ -62,11 +37,28 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
>  			  "misconfigured root decoder\n"))
>  		return NULL;
>  
> +	/*
> +	 * Find a targets entry in the host bridge interleave
> +	 * list as defined in CXL Specification 3.0 Table 9-22
> +	 *
> +	 * iw: 1 is no interleave, so entry is 0
> +	 * iw: 3 uses a modulo calc only
> +	 * iw: 2,4,6,8,12,16 use xormaps
> +	 * iw: 6,12 apply a modulo calc after xormaps
> +	 */
> +
> +	if (iw == 1)
> +		return cxlrd->cxlsd.target[0];
> +
> +	if (iw == 3)
> +		return cxlrd->cxlsd.target[pos % iw];
> +
>  	hpa = cxlrd->res->start + pos * ig;
> +	for (int i = 0; i < cximsd->nr_maps; i++)
> +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;

I am with you up to this point...

>  
> -	/* Entry (n) is 0 for no interleave (iw == 1) */
> -	if (iw != 1)
> -		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
> +	if (iw == 6 || iw == 12)
> +		n |= pos % iw;

Can you help me map this back to Table-9-22?

Shouldn't this be:

	n |= (pos % iw) << (iw / 3);

?
