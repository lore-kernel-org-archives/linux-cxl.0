Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FC101E6
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168736; cv=fail; b=c21USnw9YvEBLmL/o6wYUTUlhCVY4HsYEByHW02YgQNZderLZV0SkDKtU4KQa79lhq9X/JGRY1lrqxK4xleVFVB3j7KqLbtYwvJ8K3/UNBC9Ghk9tZ3WRtvw4Y/BfKMFs1TbL2zCYR837xSnxaZcmJH2mOxlyhMpvM5BU7O0+3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168736; c=relaxed/simple;
	bh=WycSkakfbaG+MKSLv1ujGo8YtC1tVCN+2m3pcbp3Kg8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oBuuSOYA/IphF/CRIe3b2u/hqP9Z3gRc14/w9S73mO+PA7AH/A/NK0WdzRNEJh013rpSmw1yrY9AGQFRc8x+79/oPbCequ/6SfTMWD+IApjrykw5RzdWiJuVR4BraqqLxlHbgr3KJFQjVOp6kq/2GT9Y7XNBD/0Jf07rA3i1tWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQpfr6ji; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQpfr6ji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723168735; x=1754704735;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WycSkakfbaG+MKSLv1ujGo8YtC1tVCN+2m3pcbp3Kg8=;
  b=UQpfr6jiwU31uQpe2QLQ7a2+uZ2OvQnd+tsj0fuj2WDJtoN0aqY35e3Y
   4aao8vHnbdGJrFln6a8QCHr+MmnrRL/tttwfAJ5ZPZ4TE1cD4vFYYNrTA
   DoNsCAsilw+a5+DypTzXdlMhzmvWPtct3BDGy9OgB7jdAZLIew8DzhiP9
   AJxgumHSG7vm0uGCwIlt/Dylmk2ehgUCCsPWyJktgEICIQrR+80TGWUn1
   cIl0Hj6AntI05WNBVPIjqSPMP8IQNVSyvLHCzyEgeryKzuo4PY3bSKPfH
   UjGTKWNLgpET7Ng5/YELVpggw/kt+HQpBHXgrKXn3aJgk7S7uexxB4/MH
   g==;
X-CSE-ConnectionGUID: dFIkad0OTPO/7BfYe21ADg==
X-CSE-MsgGUID: 2ZMGJWXUSfyftvCKWSPuBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25093790"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25093790"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:58:54 -0700
X-CSE-ConnectionGUID: ioyRIwfrR92Til313cwCHw==
X-CSE-MsgGUID: 6O8P0fJcQauljMJFvgQTTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57640622"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 18:58:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 18:58:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 18:58:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 18:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErEGKj/Va+nvoOlW21BF35flJw3/q4mudrhVJK4gkkGqyq5Qjg1uzkAjgRSCM6ShNdBIeUdoo86h4wWzUl53oFQsfxuA92iH/Y0MnX+xnnjwp6H1tZVaTuVrQlPujYsHsnwu9o+kvcACgxUxNjoU+lD5K4VJOkauA4IwKyxQoY67BV38oVXW+fVsJCkN2Ppjb18I+CtsiDpiCq4drSIDk9te3uhZfZ7JpejYKJDKYJVW4zoWdqjVWtfet6BKS5Rt+LLyouz4vo6bArP9Yo7JxSxW3jR8oFXlX46svq+Dtp6lGV8NBJfrkFUp0FEl/gWapOz06mhTEo3a8Q8G1iMvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd6nujIJpuyUpfK5ZQ1HhdhHwaMYxwPv20X1wjwylak=;
 b=W1hLTekcT+csBchd0tvdxvApkQFPqZVTcepyCNGLhItlxlejWriUgdzgYmSRFdQffAdOlhVcgbRzhClmcb7y7uPZAYn4djLGjvF01c1wLB3P3r9uRGhxZ0AZr1Tayhtq9cu4QG5Yh1SyIJxJMPPB9n7XtCspcJJQZWOxOEv2TowLFyuqTVK2qpnQhQ7C9BY2JB/adCQQ2OOoPiu3GW6S5pqP/TWaJa3G12voreYwsa+I5ExjKEbZCiBLH0p6Jt4lfL6w3kqvumEbn2hjSprvULYdfKNl8pc8sgCt2CugJWtxXU9PEm6KZTtjE1Cn61yyjnkh7cAIYxSd3OWB4X24Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 01:58:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 01:58:50 +0000
Date: Thu, 8 Aug 2024 18:58:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Lukas Wunner <lukas.wunner@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@vger.kernel.org>
Subject: Re: Odd lockdep splat involving mt_adistance_algorithm
Message-ID: <66b577d735b3d_c1448294ba@dwillia2-xfh.jf.intel.com.notmuch>
References: <66b44389e7b5f_71e8129499@iweiny-mobl.notmuch>
 <87wmkrzgsu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66b4fb7961376_c1448294dd@dwillia2-xfh.jf.intel.com.notmuch>
 <878qx6zdgx.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <878qx6zdgx.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7f0985-3386-44fd-c28c-08dcb816d016
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J/F/6qW0nw2lbkaNud8lZjmKiJVzU/r5aTNwRk3abXXmA4BTB7GcRDeEVacX?=
 =?us-ascii?Q?610JEHSyy53iCV0emr/Q9AAI1Sllcdanh+5MMPAsC8Klk+QjD6ZXgnCACXrI?=
 =?us-ascii?Q?DxJHmPkiIkrx3njkuNRE7nDBtUtwRQbD8Fb1wLBUnomXLyf05UQUjDAO8N/c?=
 =?us-ascii?Q?XidpJ9ET0PPbmqdRqlNBGR4dDvFrxOn1ALLlPqMU78ZhHHn4Ppnc+8LNpPCx?=
 =?us-ascii?Q?tzPiOwKOkNwMYOVWIQAS8blAiAq4TETwWdItKhGHrH+I7A1B6fmHHDfaUR0a?=
 =?us-ascii?Q?TxxUXsfSH8IFF757QA/KSXcJct7F2WAhWczA+XWMlnS0ItyoFg9eA1k5Jia7?=
 =?us-ascii?Q?Sxl50v8R4CaNPImUUBMcw9SQP/vKR2r36HwEz+r3mkRO7aGa/Pi9/AsA0VKq?=
 =?us-ascii?Q?pKJwl5sMX1cdZjBfbjKGSsqs1PKBmFWqv/9hf0CK+hoBM+WFhaAo81gYlbtd?=
 =?us-ascii?Q?lquQTmyX+mn5TEPuaBysLaquAKLMUUmZfRKcAf0cE289g0f1q35uhda0ipkZ?=
 =?us-ascii?Q?8oIBxTK0D9iMySO77l5rudAnNltrdvijaYHrhkLQws/mMah8mpo5c48pSMB/?=
 =?us-ascii?Q?Txra/ftLFfFHAyeEIWPgnoAC+OC5QdoSiFzGJqvmeomKRkzXURRKIHEpuVF1?=
 =?us-ascii?Q?P9ThQbgyc54lF9J5Oyr5OEbdCUKfz15M0lnA/spTlHqKeOrIUYr65U01DrWA?=
 =?us-ascii?Q?42PrXgCO8kygb6rOinCIjGT+TB2wd3F+kOTKwoofFyajVpeKey21zpGWlqVC?=
 =?us-ascii?Q?thljEJ6AH4eGMAK7I2MsR6DkDU/MCzNJMhgCjZLXOPbSg8dd3KWdaBYpyTsf?=
 =?us-ascii?Q?TEhYiT0Baq6nGIMkOaFWUvCEdsA2h7okCVrg0LXy4c9Qk9OxW6j4cRdgCdDV?=
 =?us-ascii?Q?1Wzd8WmhKlKE2sjZ7yiEHfvH/tsrXoU7IPwFXvZPJVL7SihH0hnJ8yQB7P6b?=
 =?us-ascii?Q?SFy7vMEceNqYNYFLO/2RkRE4MLLbg55WKOaWrRUInBla0ws3k4l9M0GZYI0O?=
 =?us-ascii?Q?SuUsMWRC7EhuH0srsWx8UEp3mgDwxcEk+4myiETL3o9nfkZLNvLJmMSFjNim?=
 =?us-ascii?Q?ytD+mzSWck6dQztbH+rrcZUT8BfMyMEm5U+OemoWFAPJ6/+K5phTY1u9F2uq?=
 =?us-ascii?Q?/Ie0S/KRenwoN9tltCYM1Si4CcuJn0ek7RrplfC4527epxKrD22IIT/gFQ3W?=
 =?us-ascii?Q?ZxqXAjpEGWleLLJFXlYFutWlEkBVha05BQt2NHyiSixmOynFQYJSL0SDGa8u?=
 =?us-ascii?Q?eZqDQ3CvolLiCnzpUywRDCbXdbUceFBb8678w4JQMtvr/R+orLo1MpP3ykrW?=
 =?us-ascii?Q?nXXBss3tFXISFtUpylWOzEY3sIvfwjq8eN9Nc5FiNC5GoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h0a6RUxj1pAcC3oXJi/Ca2lfGpC7IsbLTeftW+XG6KJvFJgQWidRNcS+z1xA?=
 =?us-ascii?Q?5wy1SAgu6XG6vz/GheztVO+yMCoUoHYkGFngQkC7ou1/fIrTn2kE2LgmAxYw?=
 =?us-ascii?Q?O/aiEzOBZAc6+fl2dBR1E8+IBhNp8am3/uK6tKdFcVNo2xncB61HqznEc+BZ?=
 =?us-ascii?Q?f1KUhGTOoY1YUrg0X334VcyQu7LfoCcUAt3FXdhnE0x4vjFXjWNQWkIz4zXV?=
 =?us-ascii?Q?hkMhR5JGz2DNGTTQcEekldyFVXZRtNlJbIM3pg0pU253vqxrBWL6Z0u5QPy7?=
 =?us-ascii?Q?RlCQqDooF8A005PSsgO0Kqi9fd7FmDhM1g9G/rhopd3adMJGwbn53/shMdAj?=
 =?us-ascii?Q?jtKw5J7abxdE355JDAcHBA6tKgbbxOyphgCkJoPoIRkA6kBKrzgK8WCHI7Yk?=
 =?us-ascii?Q?ktqWAqTmK5y8ZHUaAtXAvD8lXvJEFC3BC2DWMf/r6+d/0Hbl92DaWfrpbqAo?=
 =?us-ascii?Q?qytmfm1mcDbK5k2Jcw//sqD32BxgM5oKXkZgq4Rpht6YVCVM6pHe4XKVbneg?=
 =?us-ascii?Q?iWp3jfV6jSaKO5WKzC0T4AmNpQxU2sZZPk/3eIlZPztmMQF8IszZhUY/ZeNp?=
 =?us-ascii?Q?zFFGpbbK4QnFRSHk5Iu+6O2o1r35GRLXyHGJ9DuFZW528tkDXmmAHeW0qqA8?=
 =?us-ascii?Q?vbrYyaBiPjgVPahM6Jhen4OFRQBvSrVw8o/6iNq+2MY2r/vj4QJMbMuBS+pt?=
 =?us-ascii?Q?nxQujFu0o5frRTWqMpGVE3dBYQBhJrmnIWbBkB8Zd5Kn8ffLKEEifOO3pDTZ?=
 =?us-ascii?Q?Y2TM42Y256C1rfdTbxrYHYe+/X022A8Vgb8RFDHM0EnXL0SQx0WZMr41/+j5?=
 =?us-ascii?Q?LmbRJu4P00ajYLqFgGrh8QtMfmtUZhCYv0W6flsv9lkiOcEogd5OF4XdM0X0?=
 =?us-ascii?Q?EGYjhZ+helDMPHLdnB6j1MKZE5MSqczA84Uza9TAvF0M2GTyabFW0DzhYP+A?=
 =?us-ascii?Q?y0Iv1SAOmb5ZDEapJfX1K/UdjvSUqR59tNvwo1j7G3yy63+OhoEc5rrmtE5r?=
 =?us-ascii?Q?p+Maha4Vh1bxsOqCcFbvu2c+k7xKVigNomljI7F5D7ZrFC0EFQrX/a1cJZ9a?=
 =?us-ascii?Q?ljN3bq23vusXyvn6YzdKwbrd2qdDsU8v7woCYFZCpEo7+EmD3Hzdy7sLQRvp?=
 =?us-ascii?Q?IdWykAy9DfBrIcXDJt4HDiXVQxSWvQCNia/8SnMCfJmrrOt/tD9E64yU75cu?=
 =?us-ascii?Q?N2q/2m+fF0UFk5yIZSp5jq0nz+9jnYImzT3laCYEBzkJfgNey8tIWIWLbsST?=
 =?us-ascii?Q?HujdeAye5r+P0JnVZPjYkBpScc28hM6PXzudyiTISXIYb+59PmCev7jFqBKT?=
 =?us-ascii?Q?GdnxWz5TzpWAwfK1mp+xqprGJSspgghCG52Hvcxih/dRC33hhZyqsSn1jsI9?=
 =?us-ascii?Q?Muz3VJbgwpAGVuEseHL7T2qoliw5soy4Z8DGetkrqI82pEvsUT61hezIFJif?=
 =?us-ascii?Q?fbbP80FM/q7pKpGgtOnNu9bNTphgPwufb2jV8sdjK2b6cLhmI/zCz+nZy9Il?=
 =?us-ascii?Q?Cr9zZqvlRwkgUmdf3GjZQcQ9JEd+ohyljn1BzOKag7j2Y9aLK4XH7D5yaIHv?=
 =?us-ascii?Q?2FyD/X/m3lvuVsjsxzaiErz+NC9EDPTHh9mz25q5V5cAnmMTbmVTGjTimK/f?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7f0985-3386-44fd-c28c-08dcb816d016
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 01:58:50.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmJRwK2ruZJMgjsnjE0iDvhXQxyLyA30Hg8qzNGCAlqbVTJOkTpk4L7dwOv5Qi3WEMV0/7JkkaS+voYim9VztCcfAJT30+vwYTKREmh3ooY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com

Huang, Ying wrote:
[..]
> > Ying, I think it is dangerous to be acquiring locks in notifier
> > callbacks. I am not understanding why this needs to be a notifier use
> > case at all. Shouldn't the adistance be passed in via dev_dax data
> > somehow?
> >
> > Something like:
> >
> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index 9b29e732b39a..3ac20f4b1c63 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -18,7 +18,8 @@ static int cxl_dax_region_probe(struct device *dev)
> >                 nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
> >  
> >         dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> > -                                     PMD_SIZE, IORESOURCE_DAX_KMEM);
> > +                                     cxlr_dax->adist, PMD_SIZE,
> > +                                     IORESOURCE_DAX_KMEM);
> >         if (!dax_region)
> >                 return -ENOMEM;
> >  
> > ...notice how the dax already knows the node id which makes it extra
> > unfortunate to need to take locks to recalculate the node-id all over
> > again.
> >
> > Can this be reworked to make all the paths that care pass-in rather than
> > ask for a awkward callback in unknown locking context?
> 
> Hi, Dan,
> 
> Still want to keep mt_calc_adistance() the unified interface to
> calculate abstract distance for a NUMA node.
> 
> To avoid acquire cxl_region_rwsem in adistance notifier callbacks, can
> we store NUMA node in struct cxl_region?  If so, we can avoid to acquire
> cxl_region_rwsem in memory hotplug notifier too.

The problem is that the notifier can fire at any point in the region's lifetime
which forces the notifier to hold locks while accessing any dynamic data in the
object.

I made a mistake allowing:

067353a46d8c cxl/region: Add memory hotplug notifier for cxl region

...to make the notifier registration lifetime collide with dynamic
updates to the region. The notifier callback should be able to trust
that it is safe to access static data. Something like the below at the
minimum and then there is no concern about needing to take locks to
snapshot the region parameters.

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..bc9dc14b88a8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2313,8 +2313,6 @@ static void unregister_region(void *_cxlr)
        struct cxl_region_params *p = &cxlr->params;
        int i;
 
-       unregister_memory_notifier(&cxlr->memory_notifier);
-       unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
        device_del(&cxlr->dev);
 
        /*
@@ -2484,14 +2482,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
        if (rc)
                goto err;
 
-       cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
-       cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
-       register_memory_notifier(&cxlr->memory_notifier);
-
-       cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
-       cxlr->adist_notifier.priority = 100;
-       register_mt_adistance_algorithm(&cxlr->adist_notifier);
-
        rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
        if (rc)
                return ERR_PTR(rc);
@@ -3386,6 +3376,14 @@ static int is_system_ram(struct resource *res, void *arg)
        return 1;
 }
 
+static void shutdown_notifiers(void *data)
+{
+       struct cxl_region *cxlr = data;
+
+       unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
+       unregister_memory_notifier(&cxlr->memory_notifier);
+}
+
 static int cxl_region_probe(struct device *dev)
 {
        struct cxl_region *cxlr = to_cxl_region(dev);
@@ -3418,6 +3416,18 @@ static int cxl_region_probe(struct device *dev)
 out:
        up_read(&cxl_region_rwsem);
 
+       if (rc)
+               return rc;
+
+       cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
+       cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
+       register_memory_notifier(&cxlr->memory_notifier);
+
+       cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
+       cxlr->adist_notifier.priority = 100;
+       register_mt_adistance_algorithm(&cxlr->adist_notifier);
+
+       rc = devm_add_action_or_reset(shutdown_notifiers, cxlr);
        if (rc)
                return rc;
