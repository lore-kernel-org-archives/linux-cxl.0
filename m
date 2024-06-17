Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519151D953B
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663946; cv=fail; b=bQ9U/NeiFBwBr0rgxMkUOHz14rqpWA/9N/VMIFJ0AWGjzDkCXelo7gQgPRZ0EGdVFzvVzyUaz/fYaitTrgFNgDRDOL/graAt3cUZWb/ilD96bUu/UPMEeoGul/Um7ngvofC1uRp9rFZX9+PduE9ll3JVVPTleIyS0c99YI0eR8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663946; c=relaxed/simple;
	bh=sluedaioRMqaHFJkcbQLtlhW6wo2f3swy16buiJalgg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rze9+oKIM2s9FwwaZ+ho0ug3n1cmm2qWnK4UraMCraJZ4HeZlIhY6XQ7n+D2UjNftfA9OzJnYP7AOgx+asx9YktZ1faRuXIkr+KIV1pvR7Q/hl3MUYWva07NiogfjmZL4uRXBO615VpzSsizwWj/WRm5imiBGAEIL4qJTJdwRcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJ5WCOGq; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJ5WCOGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718663944; x=1750199944;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sluedaioRMqaHFJkcbQLtlhW6wo2f3swy16buiJalgg=;
  b=TJ5WCOGqwJ9FHRUqI/ep5Jcvm/MxTbtHZL1T5L4NTqaLEeEu6mV7GGmR
   Og7qAcB0UnCPJmjbzhaxJBxBvcQs7/j9/YI/CbdFgHlwKuURGFO/3in81
   6OyhCwLpJ+izANI2+7ZWGwQbkuPRDdk1EWHLGGzqgtSs5pZwgWjSiMqu7
   IDL4XUw6zUk7PMu5SKEOjRz3/1HiPKiq18h0XixhjDqMvQOH5YUqHdZBq
   LoOumywbazlRAMr0ucEO48JL6qPxuD3lE2w+iAY2DCkIeJaWg+d1oCkgH
   QtYEhkDDemTEXzShvMS3MHNBzQOEIyWbEQQbYavlwf+jmBkJFQ5FBqKEV
   A==;
X-CSE-ConnectionGUID: 10kkRNzzSvSnfCYlxWrxiw==
X-CSE-MsgGUID: QACeqkl8S+idanuSHeatmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15345122"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15345122"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 15:39:04 -0700
X-CSE-ConnectionGUID: vlPAeTo1TnW703oW8M3AoA==
X-CSE-MsgGUID: /PtenI70SVOlwzfC8I7jRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41267294"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 15:39:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 15:39:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 15:39:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 15:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2VOQB7Swchl8Z9eEQetSu1BZ9P8rgGmOGPk63dj1bvaExsOOHqTQrakuavQwHeh08qGdmQsWCT6A92NvrjC/iUofN5PSzI2ub2acdbxmMLWU7M2iq5mByRu0qJuU45eJydDctkHPIXafawbhlWvjOQnTD5QibCKKb5AVbdr08JqXsjnhZtG97CsxNEOuJ1zdekW4UILUw11txtcoY4jNm3AbUIrVjsiZN7DVmuN0/LaAL/KPVSqUpCXKuQjw2y3j9PfpmAECKYhHfdZ6FW9wEpEon8K7hN1SK0j5lyM4b3DVQyvcA4jbC3f6TOdPDGqibHpHjZbv+l+4EJVfp5z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nryLj0b0aMLUSXZi4rN5PGyaePS8O9ZYffW3USjObYo=;
 b=BqhStjzos2EqmuUrGdyFUimPGdMMdEBS06rIEZZD6nICo/DGv2Mcw1DIKwnYYs/3SXamBc3LXz8jBmFNFg5TVQdImhN5ENY0iumDqE93rk6ytnl4F1XkQXNsrjBZ67/4Zvf74e2L0FGufhbrE0zPwOB4n+hyaPOneAUa/toxve8Vbnznfs5+BQMH5ZqJRjS+rQiDJnep86y895mPeC4jaWIBZrVSTQaFIbUm+wMCfPk8UVKEi8AqJKUnBBxdN4AvkJ3iS1cJhOaIKrUZ9Y/yzTxB/H5E89qR2h2ib0D5gvpUee1PFFDJjMTOk9nxXtCanpcACyb0/NFYzfJoijAZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 22:39:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Mon, 17 Jun 2024
 22:39:01 +0000
Date: Mon, 17 Jun 2024 15:38:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
	<Jonathan.Cameron@huawei.com>, <a.manzanares@samsung.com>
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Message-ID: <6670bb0253a82_310129499@dwillia2-xfh.jf.intel.com.notmuch>
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
 <ZmEroVRLDDLdHIqL@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZmEroVRLDDLdHIqL@aschofie-mobl2>
X-ClientProxiedBy: MW4PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:303:85::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2fa376-87ee-4d80-6944-08dc8f1e4886
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ogb0AlB2BzUrH+RaadP5t4y6Y/i51651TZePyZZQnXLf5KXLKExyvV3x414q?=
 =?us-ascii?Q?yr/JFsMHWMdC+dpgKuDQjP20/yiESPoOq0WcCbiMmHpSe8bRpWMr4nsFmmVj?=
 =?us-ascii?Q?I4gxgIACGTt+rOX35SZoy99WD0+TfXe/Y3vGHGwOq9QY/lK/aralAt9bCHPg?=
 =?us-ascii?Q?YK5PdU0YKJ5iC0sQ+R1gnOc3XkE+265BWCrxXG6ocWKGzr+W6pkzhieBKsIf?=
 =?us-ascii?Q?dlYnNACds7VwShaK9o3UGfzW9fXqxsmrz1g48pOEq6yTSG4zqCk22RTdZ9We?=
 =?us-ascii?Q?wDvQT0slCeNU2/C4tJUQJXlJwk0fJxRElJ4BMROAVyWgMoCruqIsoK4rVfpQ?=
 =?us-ascii?Q?lsL6pg8sM2tsIxLSgX0Ry4TAttSb9lSX1dKbADpo7GzhazggZ3Hay5izHvcM?=
 =?us-ascii?Q?mM0MKtHbWlZ9BRXFHeQwfSimsACLyf9SU7Z4Hohp2xAA0PoJMus4KJ5i/uQk?=
 =?us-ascii?Q?lzs7SfTAprcK45aGkzdK5LT/SuJIDoTnnrZcRiVe5O+aMyrMd5CSzmOLoceZ?=
 =?us-ascii?Q?wLKN7rDTHILl7K/XtDKZqNjVXso7D5HFA+ot94AbYhfiGY3BugV2eyQpg9mH?=
 =?us-ascii?Q?yRBmgg7HPcbu+U0o6CT7+qPIjhNJCSEeU9Nx8cn855asr/bE8h4atgVeurKf?=
 =?us-ascii?Q?vuq0QWjJ+5oB8/2MTm2X1c6Yol/Sc0yd4yov9h9WUQlSvufzlfu61wkK6GJI?=
 =?us-ascii?Q?480KM+0UQv2v4zec+JBckJM1+UFd6+4HCgSr2sgvJunAuImF2WY/EkAJljFg?=
 =?us-ascii?Q?UQnbW/am9EWNACWbTiyulZ19ihWem4xuQagihhTGsMOWUwzvBoKGCcx0Y8ft?=
 =?us-ascii?Q?glINzpdrrnzHFVPgb0Lqt+Iuoh8NPUdPxItaoyIntHR3QdtQY9PnKAnbPsu1?=
 =?us-ascii?Q?RkkFA4IAyqYOkI5EyD7xbjfW6OxtNgEsVRnxmj2XaRxfrkcJTdxsEpXpnbGr?=
 =?us-ascii?Q?iZPTChPXJNWrA4/JyfLu71Rp1BZ6A3N2BHFZrY+i5EPcjMMej3FAPhnPOkIF?=
 =?us-ascii?Q?74aERTpkVN9CUpDH++O+m+1adU29oGAEf5vAjXS1mYLfrietkiy1S2mbhjtE?=
 =?us-ascii?Q?TjsKEN+Mmb8pGcMvWMGuOrEvjng2WpaB/rzPIb6KPtY0G3rVB+ILq+kBvPZZ?=
 =?us-ascii?Q?b07OHyH4NOdG8pj7GSao/vAbCQAg2R4Hemz60Ja4NOx2OnSMyCrfNvNb+SGe?=
 =?us-ascii?Q?T90wIifNp2XT9AyQ67HgdUHxdPw5N075HxCj1A4YhlFFMTjgu65aVi0uKN4m?=
 =?us-ascii?Q?OZSedmqBNuTr7+cVjoDNazbg2Tl15odgjLMTpI8XZzUtmXy+XJcH/khntLe4?=
 =?us-ascii?Q?MXxhTjeWzUJLllqopTpDyRJs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30sEuuQGKufRvQuwOpPsqTXUnNOcUTXTuYamyp9631nGmKSgDB+AiC62vGUt?=
 =?us-ascii?Q?VVPIy3TG4tKWoSHadl4TKgLd5S5mTshFJkRIX0BMxz8MpSAeh7rjuneCvo46?=
 =?us-ascii?Q?DBsWChCtLqDyWLpN/PZJcJyQ/B+lJWDU2D8Y/zmE3ctnRij9O/GV11ZKfqdp?=
 =?us-ascii?Q?8AwA2YIGhtK/TfCkws5mhwHynhVmoX8GD27WQb8YdzzeBodKLfUoPxPwbwiK?=
 =?us-ascii?Q?uiqR8MyrFpEY9IQ2h7TWSNwd48qHeSbG55IPc+++rNbcr684v/6yIrnUH+1l?=
 =?us-ascii?Q?vaw0AmEA5HFN4U5QKDu9RspQzSE0FAwSd6VORVCpqwto5qVeVFlK/0wFyVdv?=
 =?us-ascii?Q?uzOEp8NQCbeZgkKYwPlw7KruiM4rBHgoBWTHJl7K3YdtRfB0p7qmIeUirr8q?=
 =?us-ascii?Q?sbdCnuxbWvwrjGyi2HjvsSKibIpl2ny3khI0qy4sK/LSLFxZAdpUST11gxRX?=
 =?us-ascii?Q?29YEzLyRgbmm4UmZ+SNoRXaDOipafWTG3CJKIrB+fIrpcHp5o7+vnchH69V8?=
 =?us-ascii?Q?uIS0+IpjU6tTsZqoTmvBsITaj/S+k+Vdxp3UfiCVgyrIq6kCF+kkuYBnGwvL?=
 =?us-ascii?Q?9SXnG6nYR2o+tboT6EUEFvy0sqfuq7xEqEm+m8Gzszqo7QWTrpIktUE9wbY6?=
 =?us-ascii?Q?7eeNsIfMSUlLZjYFcUACvILdfrXR8XgStf87hGLWmLvwdsJ3/4LrWY8+88UK?=
 =?us-ascii?Q?qzrrREc+vorP3E6Ssu2LE4OkPUVPPbd7i3hGEOzGiXH8ym7VhriN1a8W5OFq?=
 =?us-ascii?Q?y+JGx35l2CG5Pv1wKK0klNmOpeMASXU54LE6a75MAXJqdqPamRNNPOWmo9Lg?=
 =?us-ascii?Q?B+FLIPEIG4g4SoHyGSjaBcFGKOdxFHFLyqt6IDCV85El0HZhdKQpBBbpR7Cm?=
 =?us-ascii?Q?w7ronDixtLueH1bdJe/v8VRVVrfa4Q6CA4OwGEvJEmJY48EmFBwp972ZPlg4?=
 =?us-ascii?Q?2TmVytbHd865vGuMGCS1MXwDpXOJtIDI6Zyi4AYKKhITVeIIQosaGC85DoMO?=
 =?us-ascii?Q?v5M3g8BlDYcH8DNUYjkeryijRFQ2pAI+bo2C05Dh65+raAdq6bu9j2qfYwnE?=
 =?us-ascii?Q?9m3/5k/Yr70bzecjX+8T6ThBzmf8W2uetktlOxi7RRqSE4/M5j/1D0jo0EUJ?=
 =?us-ascii?Q?UfyZ76WWNyAhU1Kx3qWd1WiOYEWr7Er9Dl2aFDs1F1jdhae4QFmhkMDaThwF?=
 =?us-ascii?Q?NyGz2YKGVwot8eU13zTUZt/ZB9X349UqxdRIlTYEHJaUUfXxkhOHU7rhet1H?=
 =?us-ascii?Q?IVtx2AndAHOGDXedweMf2tHDezPSpCcqst3lgl8aKbi83Whw6QrW55mGOgne?=
 =?us-ascii?Q?4ABrDqaXKGvX6H+Z9+fN+Udorwl3wJmgRlZ1qGzN7vrEsJlC6sIYrSmsDMyM?=
 =?us-ascii?Q?N8DAsURGv8bQZt7Y0/xs2IdVxXft2MuVVJENN3HqagwvxYdQ541gfOZ7k/Ew?=
 =?us-ascii?Q?0OsgbdRkZAUmh4giC2NxzluSN9g+BVnSLPK8RfkdeRgdP8Qw98PSeg/lhNDa?=
 =?us-ascii?Q?ii1pbLZHntMlluphSaURd98nIhaxlPv/cgaIdMNdexnXK9uKe1j7s4LRlfak?=
 =?us-ascii?Q?ctw3FvzTCcT/Rf1qWCa1IEbQVeYaSbAtHLV/kfERvJKnYqF7/dQI0hJJNfwm?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2fa376-87ee-4d80-6944-08dc8f1e4886
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:39:00.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvJs4nJLso/oR2y5IUUX6L4ENzrbhdqlsdjcQSnhf+4na7ET5pLgy1C4IOq3zJmsYfFjYKq5/V97Tiy3NWaw2RMhqR382AhFoHeusIVHKmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Fri, May 24, 2024 at 05:53:49PM -0700, Dan Williams wrote:
> > Provide a survey of the work-in-progress maturity (implementation
> > status) of various aspects of the CXL subsystem.
> > 
> > Clarify that in addition to ongoing upkeep relative to specification
> > updates, there are some long running themes in the driver that respond
> > to the discovery of new corner cases (bugs) and new use cases (feature
> > extensions).
> > 
> > The primary audience is distribution maintainers, but it also serves as
> > a guide for kernel developers to understand what aspects of the CXL
> > subsystem need more help. It is a landing page to document ongoing
> > progress, and a guide to discern exposure to work-in-progress features.
> 
> Hi Dan,
> 
> I'm wondering if Scan Media can be added to the list. I was within 
> striking distance of posting that set when higher priority work called.
> Since it got pushed aside no one has cared :(  I'd welcome the chance
> to contribute it upstream if there is a justification. Can we add it
> here as a [0] here to keep it on the radar.

Added.
