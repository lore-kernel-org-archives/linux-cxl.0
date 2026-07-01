Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889D50276;
	Wed,  1 Jul 2026 04:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782881324; cv=fail; b=lgJ1pVQqBNWFCE9LTZemBvDoAGNhzWJnNH+TAsic+q/5w7R3MtpcPYWQ1e7YdGa+D8ZIi6vNtGDiKUB5nkHLwWFK9f/e1V7oAhJ3TSTcasBOROXz2ivGEpWgD2XNQIkVm9eXD//At3nGuJOZhlRcBvBKT8fcN39ZzAB3ewjCdFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782881324; c=relaxed/simple;
	bh=2iX44QRkkc006vH5hlkCYybMitw6jim3011XGgdR8l8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uT4iIbszeLiiFRalxVnE14mA3b62gdSErmP6rpH8Agf40Mbe3UuM9QtpJGPVCNPiIc+5F+AFUMi5TQD+31ynYOek6hZOn0qa3XYYBPSN1vR3/W7wfm8avJpw5QMKKpLlRvnF5u7mqZNpWBNMtBcHR+CbD91hnGHzoFfY3uzcL/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlMA6zvA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlMA6zvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782881323; x=1814417323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2iX44QRkkc006vH5hlkCYybMitw6jim3011XGgdR8l8=;
  b=hlMA6zvAhoDs8Kg6pSamsBa1ypdC7d2SmkJzO0PrcEDYvqzibjmzG59U
   KgP6zUrxLfzoGVNc3q2to8fkIj0Oow/BWm1dAwHu6TNfPknoypVfUmqS2
   ccxXJvXUG98PuFx1v5v/arowc4MHYzCwe/llGjcMpUj2cypwNemlXgfWQ
   74LWJcp1hlJWE4enSWzlGosTg8JBsUWXfuXk6b6l2IOPrGObSXyEllMBj
   6IRu1aB0AbEHKyDpo9djZiHsok6JadQm5ZTnjGJZAtmkc6YWZP3JvlYHW
   +yBKcWS5wr2R7+o/qJKsAQhMZJ6Rhz1r0k87lz2b5H6df74qowmXJBzxJ
   g==;
X-CSE-ConnectionGUID: XiPdTBuiQyugPvPBxXXycA==
X-CSE-MsgGUID: KTQx6sWqRLeAQeGFIZv6yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101029592"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="101029592"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 21:48:42 -0700
X-CSE-ConnectionGUID: VGR6KLB8T7uqk8k6r260hQ==
X-CSE-MsgGUID: qEG3sQKfTlqcnJVVzUYUxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="290582252"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 21:48:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 21:48:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 21:48:41 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 21:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVCWhDHURSyPfFZh/irE9QfClyFJeqR/W6tzWwJ9Q9Kr8YwfFXZer3tM0hKq/8T86OUU1xmWczdHTwHVr3rNu/qZw1M8T2q0HJiXBwlQ+a5zE4sgTgU/HPIQee9EG5DE342RY/3p5HK4d1ZBbKZMrYXyA75Rft9bFQ6UCHJ5zHoLDTDYk8ZSlCFvIZoQlBJT2SXVVSbxXV7CQuWHAgX8FGshAcHSZNOVxhm4SQ3ktnvEvz3awci32Z1w20y79qLNKCU30K8Klaa4riM9wwwuxpjCG21+EfQqwBMpB5BHCUtFqi6UQAqpAgGWdFmKQUWxOPBMXolmF3WgeWNQZTvbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnQPufQK+GkrhJNXQo78yZdeivFWDuHe/gL0po8ypZc=;
 b=Y5fwff72foZXE8W7Vm1rD0FGqTInPeLxWz2RNyZJaQUORVWocIPwi9n9W/e2uJ6FJNiVQAeJUjda/qX2/1Se6HM9R7cXYyDyLkPV3r3VlFBH+XV1THq2S26TDQK0/r1YbH+yKvAx2YsDCK29xDOAL1X+ngKoDm3RiomrgTDkrZ6xN/pRwnKO544EXr3tdklS3/FEt/Cqy2jb7samf+C/GVHie07aK2/Wv0S76D/xwggIJC8Rxt7gqc5+YnZl0RNnQM7g1PtGQxZrab84gqFIODgkkojKQX+ddiJak/ZDcItmEIXVXRFBQu6mXOw6LNiC3al46/u8NP1qe/9IcCpsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 04:48:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 04:48:34 +0000
Date: Tue, 30 Jun 2026 21:48:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <gourry@gourry.net>,
	<rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <mochs@nvidia.com>, <kaihengf@nvidia.com>,
	<kobak@nvidia.com>
Subject: Re: [PATCH 2/3] cxl/region: Scan all partitions for unmapped poison
Message-ID: <akScHQoZiEcFwKeN@aschofie-mobl2.lan>
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-3-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630074657.43077-3-icheng@nvidia.com>
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM6PR11MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9e78d2-e07c-40c3-38f2-08ded72c01a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 87RB5oylTZPX35QwNwGjEUl4gesSw5P4zWO7Yk83DoVY+zHQ0eQt8emvwcAjTy6kVgdVaLPZrHEMFUUSCCyGAIZ2Jjno2EsfZFGnc1N7AqUCREyTuvQZ7n74gbuxXqjuHGML3ZRxmhrwtk3qbiC9vfYfrDA98gmrEkk4eVUPyVG5H0J3QVEWQXA47RF5aBnVL7/DOiv0KDu5LJxSjwoQAJopUMH2MVz8iuph509BZGFMZqUgdW7WXlYLXIq0rNLrwhFnNcPKeTV2Q0YtkoHVoTgXYj++wgPHRqPOaHYHZj2vOmhzjyRr3EqDRFhf8u7+OjUbznHPTOH0d02Y52zc9FgNFCztkD3ierknooAaAIJD0e+Gtvak/hEIii1oo8X3GkmRfoTIj+yIG8Xz1Xs1KYsqV1K4iM2pR6cKI59BuVOvtTbVEXk2jvV0xex7AeeUDjvvu8cEpG2MyrkALuTsXFVrz5Qr/RkywSognmEHGdB5i3crDlv/brBeeowes3be75DSjBt3Aj185nF3iNEmXQe/IUqLdoyZe2KZXsZsC2sAFx3WZU62IB4b8MNAyQqYcQu6ZAg0HgRkZGJPNKqXUYdisvTJmDJe7bJ//hAhRT2TL7hnwkags9m0YG5AzGOHNKJOaT56j9gQDYOiPFZ67ZiBkShljZsmHxw/lUqhh+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mu6ZsBlOgwncCaCqkVnnD8Xio12bYzLRODR19D7bV3zBDGW+aKYSirzDruWN?=
 =?us-ascii?Q?Ph7IIjhSFlDQijuV/Z2PwB7boH2sR5E5/yb1tOZoUBYle+5sFZ5kRTgIG0+u?=
 =?us-ascii?Q?LUNI7oiCrxDyUgeTNmMjXk652WImGLvXEG2rBT4FlhDZIPlYZ32HbwnjtMaS?=
 =?us-ascii?Q?bZspQcC4x3GPxCDo7/xwQDow4kwBSmBOE0HqVNX63WRqZBAsr/9UNh2SgTJr?=
 =?us-ascii?Q?GxYyBqW+ksgTk/JTXyNEe0+jLJYpLGM1YB8T1ZgW1+SB0iM+rRk3T1d/valU?=
 =?us-ascii?Q?L3Nfqp7Xg2SOFZSe/LVnvmVdODG3kya2kDJN7klEsvZ/QNhm0/I4f0QQVRC+?=
 =?us-ascii?Q?9eVQw29PFPWm1P357+qtnU7CWLAsg0dMzWmIOuIBPg/oKU1Nq9LlkedJAsnG?=
 =?us-ascii?Q?lRwoXryWBtLpk0U7UioETdjMZRhYbfGboqwh0IAiJklXMV6NXDBuHOKheSsA?=
 =?us-ascii?Q?frp6JyAZX+R5cvfrcx2PNMWqVVauCAilarZ7Tpb3tBgjwq3Y8aO6hkR8Cahk?=
 =?us-ascii?Q?GivDIKBKLDYcTvpFT4dJ5k58adNf7vXko37Hx5sAnbQJvA7CZLhPr4njFog+?=
 =?us-ascii?Q?OJMU1cM6hVwLFqI/mq6wPWb2jFi9sGfxs/m4CMoeGzfnfRkGSq9NdF1tI99B?=
 =?us-ascii?Q?J+J8mcamvyzb7VrnXvnz0wprMEWlIHVBQgTQhXY4IjHcn+F6HjwS9A/W8GeK?=
 =?us-ascii?Q?dUH6HWMV/AEJAu/4GERquwJjE+LeVTohvoUlYf9JHZC67qVVOFjvtuTYYE//?=
 =?us-ascii?Q?Csg+CE2VWL+4QzaVHDXXsRd1iHf94WWY/M+4w40nYq6y1lBuqVYwyxK4NIci?=
 =?us-ascii?Q?pkdGnlcPoMFisK2UgMqCwIH3qt5lJ51JwOneol6FRC9fzPX6x0xWuVcPRaUU?=
 =?us-ascii?Q?k8KPBzIAsyfc1m0CLG9aSek8QRyJtmTy5xiNjHFR2x8hOsD7pniUx3S4nMxz?=
 =?us-ascii?Q?2yUeLANbiaXOW7Oy5hRwumHkRzClhfqyCegPgcHDZNaa/wKZPVcnmK3DJL2E?=
 =?us-ascii?Q?bfw/dwYweqCqyHWmVmRptcXRhis+xsP2QNDQ34MLJ5tUML3BgWjY+EwCIx3Y?=
 =?us-ascii?Q?yiOQJPQLzB67BqVEL26rr0I7qiSHaChXtOofq3acj/Nb2IZn1bD6ZRCx1VRs?=
 =?us-ascii?Q?QkEbORlInqnzt8+ysUG3FQ1pLgM+sCzaci1x2uLR3yJZtzXDalOVk4UStHmg?=
 =?us-ascii?Q?HMHAmZVB62VFaZCxBWFVPooiNGjTDzdsL5DY2Aaq54h+LStfIwpziDgBuA81?=
 =?us-ascii?Q?uJ8kZh3TT+u3mVi0UOywnLYEf03M3p3pXEB1crjhR/9fn5T3ccJ4+iTktpiP?=
 =?us-ascii?Q?l6ZQ4S//2DgvM0c/XHgNp8UsWY97/ruf3SAya4rgYblL7oNVyJgqwpju3Esd?=
 =?us-ascii?Q?AeMRYdyuOetJH4tSpaRtb0j7wQalYecje152XdNTcWWGctkvEw47ktNTqwLz?=
 =?us-ascii?Q?085OIwIipe+yO2hj5dUJL+HL1F6X82kLbFxWFWVlzyniJNwjCahAIQmFpZ4y?=
 =?us-ascii?Q?Dpg1/0+qlWvbzL7dhXYccXSf1t89KKbxIjEukmAg0/gnhz1P44pPQrknjS3y?=
 =?us-ascii?Q?5Kb5v/0AuxyKMOdTfLZ/Rv7e3CxIKkb/7EKZ9B3wv+TOXWZ4oTmfISUF9rK9?=
 =?us-ascii?Q?fsjCuNuFzdtQf9vBN71H/f+OEgE7wrdmjZIvs2vR6jXpuM4FHjawpYIczEBx?=
 =?us-ascii?Q?vZyUCYNdMuVeLkrUPGNtcu8pb3nrY5DOOHRdxgWkvEas1wkMnHhKRzqHnx4f?=
 =?us-ascii?Q?VbAOttnp72qegUAagAI7O6bH26WVEQc=3D?=
X-Exchange-RoutingPolicyChecked: JlNtO9vFbCHj248rMf4g6/k329eQLTX/4aZMXt4jClcH4YkHep4UCkamokfD5U0433bMvNovTJy0jJX6qCSwnR01sqW5D35Oq+/XoQb4LktWoCfT5xvmzVnAy1or7S9oYM98o/rUmESkTPuYDQmGBcU+F+jgbD1673tHJJLys6fO/4gVN5iynAfnwaw0AKhF5dm/3XTqXTh8w9YCkYbWwvs5InPq5hCzuJtbDEUBSxHuzZ96wfnB+lAvdVCr7CWM15QhmeHVx8g6GAKtvRecIaymNkA4wO0HL0m5IxUKHSP5FSyI8eOfIIRgZZMmIC31loIGNgAX5Cd6qxrPAYpOOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9e78d2-e07c-40c3-38f2-08ded72c01a0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 04:48:34.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pnf70gSSSdepml2Jtr+CCOM1oXuVskD3VBgVuYbe1LMiYh3AxcsOEjk2TumS/GSsUuqaIDyr5BXYLLMUfG0CmjlDA467p4lbqjvIotJf6Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com

On Tue, Jun 30, 2026 at 03:46:56PM +0800, Richard Cheng wrote:
> cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
> from ctx->part onward. A fully-mapped partition has no unmapped tail
> , it's a normal per-partition state, but the loop treated it with break,
> aborting the whole sweep and silently skipping unmapped poison in all
> later partition. Use continue so a fully-mapped partition is skipped and
> later partitions are still scanned.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>

Posted a test case for review:
https://lore.kernel.org/all/20260701044205.1589967-1-alison.schofield@intel.com/



> 
> Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..be246fb09c99 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2931,7 +2931,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  			offset = res->start;
>  		length = res->end - offset + 1;
>  		if (!length)
> -			break;
> +			continue;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
>  			continue;
> -- 
> 2.43.0
> 
> 
