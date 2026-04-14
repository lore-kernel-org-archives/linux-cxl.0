Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7126E173;
	Tue, 14 Apr 2026 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186316; cv=fail; b=K73SdjorGNzDRC4KlDSgUkQcv/khwAIIFsnEOZKMbaoG+z5VbRcCmyacK0+5NLwF6S1M0NYtDvbj5bjOzbUPJjCnX5ys7XpBFz9dd9lsd//jQZXgYQr+/NiN1bQbG+Xv2ixw0y33UHIvH3xzELqELH5wN09eARH/hZklgbM/zxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186316; c=relaxed/simple;
	bh=EKFt2ogXBEVQvkMzwwlAdTJX+5mC6r26LGYQl0nbw1U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b5XAptN/zFK85FOajEsaviTH9IanCGD/KmBPTKIXqdHneVGYwnrkExaqeiwwPNZYrx8lXpLf05Kv2VhGGzW65EvVnQ/rJ1lrD5NaHxDVxluGghg9cktp/u7Zoa/oxwXbklMRS6GJqGBSqDQXgFNCiKcHPyYu7Ybb5IfygyjVtzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0gsyLVF; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0gsyLVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776186314; x=1807722314;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EKFt2ogXBEVQvkMzwwlAdTJX+5mC6r26LGYQl0nbw1U=;
  b=I0gsyLVFfU6MLvsXzZxv2pTRjyzJQp4fZPdwpEqnqu5J+APTXCiowYvz
   4XJ6N39A9cTq0D6R+17h8MNClu56/ZLIL0rJ6ahg5QBVY5yvgqCzDvBtW
   OSiaZuAAkSidaVrD0y7AJUbSXkyY13Z++RtH4QTrF4jpw6fAB07080GFb
   TdFDTMgB7MHo3ejFLXbMuJq22AtClq3WAbHKpAENMAduLiDqSlpt4njzQ
   9ysJ+fj6rrhrQLwXULiEuJUtymXWcLb/v3DzdqxUiSphTljw7wuDn+7l7
   sLe+S2CafCByeVew4xMT1VKf/jcAZfXDjRer8QnVliIDyJBlUvwsl2RC5
   w==;
X-CSE-ConnectionGUID: Kj3Zb5yIQLS2VFvKFgroZA==
X-CSE-MsgGUID: 3LlwCIaFSzy8p3pQWKRk5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="102610366"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102610366"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:05:14 -0700
X-CSE-ConnectionGUID: v5baf45/SgWkAAQbxHaLfg==
X-CSE-MsgGUID: YeQG/vlzTnKqvTfw+uZWzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229121089"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:05:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:05:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 10:05:13 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra8SAn50KOM4l0XWsxoJxtqDKZIyX2AjTS2uCC32F3/QVD37Dk6gRiynBwu3+qX+95zEKhDHb96+By6PITgbd026Tr9u4+f6N+f3u8w5sbhYqBV0XAH0cbnJ4DWtgloDeh4hfrHr2VFJuZCLG9SkQMshV0KtFGGDQtgPS2pe4BaEmY9LEVi99YrUWfHfDFrM8tYBjUXlBZveNsTa776GoB7iC20wcJKTRmssqFndxUWW082ctwnI35/nbtA+RipDiGk9qECLmohcWg/TiLnwD+RFc7TeCKRMr7kfK5aej+2J65K3oU8p+jczCcxMarQ2zY7fF17y/ejbaZfg+XSx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xm//OQZUUe+V7km+XNjneZN6LFdgJxAeECxqY4W5jw=;
 b=VwYaagp+O4WPQEo9CgL5UgtUPMJidMcnCgNao8R3QtssQSviMvrNZP5Exbekz/hc0O8zLBCJz/F61b+Upq/8wckF8NnIsU27gPpQsWZq98/WfxhqjTmuM/ZtEZQfUq6UdMuWcq+/uEQVNwEZU1YvlsrcXqOC9PkW+RL01y53GidRtxGeFXYwgAcPQdpFBt49FmN2nrEd/hF4pQg+rqPAXp55lP6jhMZg16hGdhfqH7LX/MRj+pPoaIo14kooZtT5A7XjF/GgGrPMOisevO8a8ooH+Er7Aq558PtT8XkAUmDUJhfPltECd9ofQ42Ej5zXUNbFbqGXqCMzDM8DNUG/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB9475.namprd11.prod.outlook.com (2603:10b6:8:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 17:05:10 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:05:09 +0000
Date: Tue, 14 Apr 2026 10:05:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: KobaK <kobak@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Validate partition index before array
 access
Message-ID: <ad5zwglddhPhE7YX@aschofie-mobl2.lan>
References: <ad3EjUssy1sLzrr9@aschofie-mobl2.lan>
 <20260414151410.3599342-1-kobak@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260414151410.3599342-1-kobak@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: ebda625b-dd72-4f2e-e5a5-08de9a47fc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ++nc9cbz2EqR/GB8p0GbB/SH7YVVot6tAgP/YvXBt3vXNp7kGduioeOGSU2Ms2X/6Y3zODUFW+Jp+Dchkiqpdgr6lC7t186KpZYT1cYnGZAdFqaApJmRmt0kHTigUaJEMhg6cV2f2SmNeUrMc71DtpcWPEaByW/iKvumjlaPLdYRx7MubKymPoPHmVGbVHlYhqSio0WQgxN64iMSVyQtOJXUbAabOvsXfysFJAzScJcZhP604G9ox+DDyuwFLZIvhjMuW3QcbgpcBVOerDKCGyP0ZvnJZ79h+kjSyrDWDeEN5znmCYb87Ow5tML/iMW2aWA4lhqLyKWx1jDcyhC64qgF56dqXqeRIOudQaqxum6dpi+5Kwai2uZSFWVCsJZPlVFqUdxYi4JeihLQYCzsh0f6Ru+kpI6ccGPojWkMyBZM4KY3esrp5iNTZniRvgFo34OHTKmQ3qAH0sMkaOoLouyodtRU/v/fwx92+n7tt+A5NFrI/q1T/63lCw0r3DxnqHbw8gDrDiF9Zaev4Tew/N4Id4HAaaPtz2LL6zonrepV+sIatV3VVZDdb18TZNvuPRz7TN8759Eo0s7upB/mEldn0jR1naK2pshHFpaqMdcISoNttTzdbwjoANmz2vvybL30bLt77A5s5U7a4RSAmVkoUwv3HcuKGunPrwBUsMZqgzILL9yeQ+9IY8T9JIGS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8qxvi2UneoS8UKPcoHmyo6gSzDaTAeqOa1K3WQVMo28i0Ljnl0Vd5DhGJbTm?=
 =?us-ascii?Q?tV2Kq13gi542lw0VtoKnwgAjd2XjCXGQsHjA3ImbicUy29xOBUhEYehdn142?=
 =?us-ascii?Q?b6Me/G5/SOzq5YxvZd9WynDtXZG/skevrKPwZbwK49ZKxEgkgPVmsU0fE+Dj?=
 =?us-ascii?Q?tmTb2M0O17712I5fYEP07tIIUnfFJYSTu4Bxj5Fvw8bccnHb0m4ya9MyuELX?=
 =?us-ascii?Q?SidlIXA9XdP4D1ISg8GwhVHqJOrBEzYrK6qRj54Equ/3PSzypOUF4Kwl8q/I?=
 =?us-ascii?Q?Mfk4fGhCy4iB1SFsA5OKmTbRmwxGHU9cb0iXeGYIOYD7eC6pGv5kLY/nyKmP?=
 =?us-ascii?Q?kyVrC9vef+tT6xg9VWeYKLTuirarU9g1+0nhuwt3G/aQQkjHJmeEaMSPVmmc?=
 =?us-ascii?Q?+RUlfS6sZ10aIalF4VN53XEUJrFvANRrkn9P8Tl6iUUytCNW+9G3wvz0T7+3?=
 =?us-ascii?Q?ovSoZbaB+BO+JLr3faDmB73SSDiqjmNk1FXY27N6LHwd6Qks1nbJywYTorgN?=
 =?us-ascii?Q?5Z8yQRydtMinWqu4NnUBGQWKyCIWI8yfJz0S1/sdWc3t1paS7hNiRvdvJBEc?=
 =?us-ascii?Q?3RCsYRWs55/nCECTkk02nRhMrmzSChIv5WHpWs1VkZGCOg7rYLZJm5WtoPFb?=
 =?us-ascii?Q?M2bem5UytPgSRc1ywvSflSGE37qrqhSeAUzoXRg8Nbjc761bTBA7Hz5RPj2m?=
 =?us-ascii?Q?xWN3/2eqQFiJlyu/G0ZHbaDlIMjueZzVfbn6RuG8Y0Qha7JpIO1SEviHBhkR?=
 =?us-ascii?Q?d/anGhaBOjNEbA7zAVpbS8hMZGk19Mt+orF0cbwpKKYbT13wPmNcpS+rnz3/?=
 =?us-ascii?Q?wHCaCZaRja5SvADmHuXZ4xcZgvTgIOeS32rKn0uxxilXSirk/kl7FewEiggx?=
 =?us-ascii?Q?LUd37KcXcpHYOwanpnnFTbi8hl2aeKb+5hKMRBGWAK9lX8cUgddNY21DO6MO?=
 =?us-ascii?Q?yEmJY6Ya+/G99Bj2QrpOBQrzQCzYjQdA8nbhcprUESVGCbjpVw2Qc0bZuPnG?=
 =?us-ascii?Q?xAzIYqxWInfzH6287OSfvZmhngh8V+QpKZdGlAWUXO6eeQN9IBOz1sJ901Fc?=
 =?us-ascii?Q?JjddBoB+cAqzeKT6uuGrm5kjNLMEE1h6B9enzOpmiAWiNKFjQnBnwdl+Zpvg?=
 =?us-ascii?Q?9nxpnMkTeEOiOyna3hOobd4R+8Xa3Ws+9zVskblIHJamioNwSC+opWAUZCAF?=
 =?us-ascii?Q?ZSQKhUpxZUuW/37JpWH2Ua1RGGv4y2pDzi8wZYugIdPgPrzEgLQQUSiQEjOh?=
 =?us-ascii?Q?mKyzAYdeYcb5JZKIKXAWJImun8mKQFjHIGinVFJf4h7w4tJDjtahXnM3x0yn?=
 =?us-ascii?Q?cKCbzFQj6TAxB0dY8yupB1Bg6goc4l45KBfXf8m4TpYPMy/cfT4ilea2k+j3?=
 =?us-ascii?Q?DJKen7o/1je4HFi97jV9se6z3vtxMR9BmeYZoRNkjdEy3OGJ4M+zeBmhvieA?=
 =?us-ascii?Q?P8ezW3CeT6pBDpLm+NO16tNP/A67E69y+A1Khc0znR8yxxXwLCF6VxirWflo?=
 =?us-ascii?Q?lF4qXCC7u3zaEI2VgzQeiP52hqMMpuD9x0sRcrTp3Z91nrnsztRfRLfkHKEk?=
 =?us-ascii?Q?M+xnUy1wKxzdOQby4N6FxJLNV2T2gWfXQj2NwBTm0+fRp481YiZmxRYNAHqb?=
 =?us-ascii?Q?7LJwBcIR9EO/JUsbNxpZckGqYKwjybkl8vrmnEoz9oneVj/zfKhjm8G2MHdl?=
 =?us-ascii?Q?+H1wG87B0RnpcIh3+hVTNjkKhb49kZoHOzrTAgXn2oRHNrseMsujVyf+rtRH?=
 =?us-ascii?Q?k2zsp7abivUR+OHsNW3Pe/1T0fk8N68=3D?=
X-Exchange-RoutingPolicyChecked: O5t1m3NOd8ELLIUgUR78K3nXgRNcRrnBZbRwRH3bnB/OUhpsbiI1MvZUKlM9+etS8HGJJFUPkLvXFbVblsfPBIaBMGusGLufBjDd7HyicvieSmlLSuuxdayotPcprxHQxs7qK2safCSfCCWqanKRyz9WFBtlrJ3mLJ7Z4I1tVoWknKXZDcccLoe2yg1Kd+RUfGrqSHkqcalzk/Bc2BEZ4v4F4Df/5D/l7NaZV/TDwBIQOBWPxuVNjxE8j4thz9LHJe7/X95UDxueyfnk3QR4NugxbpBAE7NJFFIiOcX8j3+KBMrDEvfgNhF6UdzZhquOS6DyxPQ9nathfXB0P/MKXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ebda625b-dd72-4f2e-e5a5-08de9a47fc14
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 17:05:09.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEKJwUg+S+iWpyYb+yaAlgIs1fYitEqFkZ1fmpLo9LLBQ2SlqaESQLXF/AgzLBYhuZPSXC9Xk/WOPHmHZKt9QAoEvdfyidkuB6zdA5nBoZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9475
X-OriginatorOrg: intel.com

On Tue, Apr 14, 2026 at 11:14:10PM +0800, KobaK wrote:
> On Mon, 13 Apr 2026 21:37:33 -0700, Alison Schofield wrote:
> > > Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> >
> > The above tag added the check for part < 0 in construct_region(),
> > so that's not the fixes tag. Like I wrote in v1, I don't see the
> > obvious tag that deleted that check, else I'd just tell you.
> 
> The check was lost during a merge resolution, not by any single
> non-merge commit. How about dropping the Fixes tag entirely and
> explaining in the body instead?

Appreciate your follow-up Koba but a v3 is needless churn at
this point. DaveJ can fix up or drop the tag upon merging.

Note to DaveJ: see the v1 thread.

> 
> > > Signed-off-by: Koba Ko <kobak@nvidia.com>
> > > ---
> >
> > Need a changelog here.
> > See https://docs.kernel.org/process/submitting-patches.html#commentary
> 
> Sorry, missed it. Will add in v3.

No need to v3. Just a note for next time.

> 
> - Koba
