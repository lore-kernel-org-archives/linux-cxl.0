Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBB12D758;
	Fri, 30 May 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629714; cv=fail; b=Mw/nmJuBztUMMUwJE4pI4QEUVML+/xiTWfEmrLyI/gA6o2VOkuG2xtRfj2I7NdjzSWE38x0Q3LaH3hCB9nPZs/JgcmwmL11kW6aJqntfFuqeeUgTjukHmz12V8RB4Xkzr+k+ZxMz44B7z7q08Dn6ylnGBXLEaadEI5uiO0+9WIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629714; c=relaxed/simple;
	bh=9nq1YCf9YZxyXJmHrtNEx6DLYrsFrHRLoSNFYmh46rY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nj6YkLQPhyxE4rz7kNB/V8rA5Ylv1w6f7NJawIoOIfdebdZKOmJXpXJQtNwgRee+zu+pAtRZCXMB6EJS784V5zAy73cRZks7oAPtodswqH3IiX2cwBw9Ay0nYZLBy2qvy09brK1EradDLey87zX1tq5btp59yuwubys7+GTrVqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jj5llKux; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jj5llKux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748629712; x=1780165712;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9nq1YCf9YZxyXJmHrtNEx6DLYrsFrHRLoSNFYmh46rY=;
  b=Jj5llKuxoqU9+uMLnuJ8ZXWchrYUikbz4G3mCEUX0/UAa0/RMCp8K/1C
   zoLVTPcxIyOjinP1ZmG1qy6wHHrqHVRV28RFGcESKzjE7NQyV1LTO9fDE
   iWa0CUwonR/SrthWRrWRCo4e6ExlUb1xnWdHPX8yUXNip6qC2Si4yBCFi
   dfcUvRSGsMTYaJ/8N4HaxwnMbfrGwrdQIMyNTotPu3lDohGyLpKyoqwzs
   ZXLB2GPaQy3RH+onUpRWwKk1DQegta40ji7lEmpE2Oy6V2YFUxGSsKJD8
   pz705iDOCgkmys7N29r22rQ3JCUtYBEWs8LX4REHaATKNxUs1mN29kXvb
   w==;
X-CSE-ConnectionGUID: AySCC/pITF6pMkobJyr8ZQ==
X-CSE-MsgGUID: 4BVi/KtRQfaTl/76kg8eww==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="54395545"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="54395545"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 11:28:32 -0700
X-CSE-ConnectionGUID: 3xCv7OqpTjOKKzLFz/zKRA==
X-CSE-MsgGUID: xzP9NndmTNKJN/l2lGrODQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="143861508"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 11:28:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 11:28:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 11:28:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 11:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNJzOpGTRjtMTFUQckeSvLnK4k6qiKwOIJ3hTp+ra+s0pYMTNeUXhgw1PKvrkdz4s8OgRccH82eS5lr3AunAenwQ1WwKYWZD1mWBQgnIb0yDVP/ECPw9D4eUZBpy0h8kpZ4GSbF/CKrw/PZu9Eaf4njFDLoI1IhB2z0VGjQjxtwrLJjUig2W60GljDzcLqHppHqzyeETiJ0jrLCludPq6rsA+B88H9aU0sdLupG0Pl4yHWRex89qOHtgOziW3NKauzrehr891i9Fz9ylkuMqIZOpNt6mcx5hltSaHGKe+yjlSc2tZdutAYRQXATG33JjDmz9PDo7yv44sVE+ILYh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Haehg1A3nbI5ZWkGH/boquO0FzGqo/dMzlHikK9BM50=;
 b=GSDh2BPuv1e4bbicGFo4o9o7SqnF3OmOPr+8QItyhW0wrVMz6BVYZgFqpZ+h1G0gBsVHQaXs1EGjF7Z2IKQTiqZRwbHKe3pfngBstnPCr34jGE52V4izrM5O6Hlgcje7aXdCNuWLestysuOlMsDcoEZ4/I92vaZQDM2E31kRTQ8TxWDnHqI6Lu9b06xhMH+EYI6AKZ1v+i2tnqzT+qwppW05cluHIECxAAJCEUap9lu+Bs4+VjMDcJ+VbZSXcaoogmkifyggMFh2S0Cwu/ffXDQII2IRPsrNifkqZsmYskop+FVYizNnya9j7Ord5Yz9GkLoiNbpEcAmJ8aX95BdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8786.namprd11.prod.outlook.com (2603:10b6:208:59b::19)
 by PH7PR11MB8551.namprd11.prod.outlook.com (2603:10b6:510:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 18:27:56 +0000
Received: from IA1PR11MB8786.namprd11.prod.outlook.com
 ([fe80::d1f9:e89a:ae05:ad0d]) by IA1PR11MB8786.namprd11.prod.outlook.com
 ([fe80::d1f9:e89a:ae05:ad0d%5]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 18:27:55 +0000
Date: Fri, 30 May 2025 11:27:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Message-ID: <aDn4o8Fw91vQ9D-D@aschofie-mobl2.lan>
References: <20250530122852.10139-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530122852.10139-1-ming.li@zohomail.com>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To IA1PR11MB8786.namprd11.prod.outlook.com
 (2603:10b6:208:59b::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8786:EE_|PH7PR11MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: b85a95fc-87ad-4ee4-4e0b-08dd9fa7b250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ImJRtr/ICRyPgMzzlmxcEhTb06hTG8CzknPRNOTy+37l9CAQXMb3xCVCIMNC?=
 =?us-ascii?Q?pCu+dBJLnd9d8RdiRdJiODfU8mvaEVPHUH2JOfKMvJDhRR3113fdEPDulssC?=
 =?us-ascii?Q?kqQBlnCULu1tiDOGrDBluF/fpb0MDGLIa09OE7A1ggwVz3X/UEZ8MNzK+Jyg?=
 =?us-ascii?Q?/6hm/Lr50OdE8RbRutPBPf9r1jr5fGs215gqVOXOukIvQuFnFuQZgKT4R33r?=
 =?us-ascii?Q?LHLQPTsAX6CEzTXN4XVNanqabB/CjZArjpv++iJFJ/ZxA6GMfU06s1VF1Ux/?=
 =?us-ascii?Q?SIQyMR4ZjXmGPHCjQ/WCaFbdybQ8GKGHNUMLV5J69u6L/bB+YTYqJM/l49ld?=
 =?us-ascii?Q?6qlUUHGx8aHZ2MEXwqDVurqkBaffn5rX297VYW2h7Wl/LePpA7/VgLeEssQt?=
 =?us-ascii?Q?NEQj8MoybonRBYtW+ROnaSwFDqdUVV9RU6ypez+dc9Q6kpEIkmElfgSH7F5+?=
 =?us-ascii?Q?HIX6N71dzluz7VziVx3cNuVhpa/D5LcZxFwGy5MfrP7GlrxaDDbxPxkkIT/h?=
 =?us-ascii?Q?lUix1WgAtRDgyAZhOdO0Bm7KHZIKXHj9iQ4CCqC9cDDfCvi8ULTjTISJXWny?=
 =?us-ascii?Q?FROCgLR+iL5484qhPjyN14aYhCQAIxR/qsK3L++jPWQA2viNAbAdsW770fnn?=
 =?us-ascii?Q?iRkISlBXbCOIrYpqX0/+HaoYBpe0mZ13VqwVvl3/+l5f4+vyHfeyxmXfCAW2?=
 =?us-ascii?Q?naPU0Vum4LVFAyG0OV+r30NP6jOxVU5I7fwnRoAL+4aJjjdUUfZ5uj2vDm9w?=
 =?us-ascii?Q?bvf4axv44oJiaD0K9TFV8Xby/UM2uPNe9taRczodTW5hefvkWXtdxzOeEqBP?=
 =?us-ascii?Q?T+wrVpfbMeReymWBW9sPS57xHfh+qGjNI9bSOI5/3LJ/nvPKOOYvKjI/5V+F?=
 =?us-ascii?Q?yHfQn6BBf66iMDFGp0P/q8dgptdi8LuFho+qKRXpuwR1KiCKU/QXkgAHDaAa?=
 =?us-ascii?Q?U6HlBZokpO9bFwSj7qVG7Onx6Lde7lJibAJEYbGaS009vn5A3swyq6LOWYJp?=
 =?us-ascii?Q?ZR0xCrvIAyc0rc88KmNtXIexxN75ebLMlSRRsrvQDlnInE86q6MV/myxJwL7?=
 =?us-ascii?Q?FH4kn/r4eAu8BEL+bf4DPfV3/eVpcZd6Guc3PdZcP5IIdGiBR37ysNzZzABe?=
 =?us-ascii?Q?U9HVMQGDpuAiPvUXzWw5w24wYHpuj/ntVJkHz7L7cpVrOz1fPx/h9w4W9gMK?=
 =?us-ascii?Q?2KSNvhZkXo+8kp1d1BOOGzJ5nWOaQzTHPK4lL+l4iaZ4JohNOqQo4eV67pkv?=
 =?us-ascii?Q?n58mxCyMPDpZcPPtXrD2BmzXWRqP3NkK7gp/YHP7RIc5tZN/qRiUr5w2q46D?=
 =?us-ascii?Q?ht/roy1IFGESAd62f9KuzMYhAQ1aUtkHM+iCziGM2by94GWyLHCvqJI2TmW5?=
 =?us-ascii?Q?rDW6uWYLyvB27wdhZ04FAbSbVSwwmPHLsJy57M6PxG3jiw+J6HVtlDscSoz4?=
 =?us-ascii?Q?yS9O5T3mDU4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8786.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t++HwV4WqSukCsve8TmOBHsRNxwFmoK2DuVIUVPuIb8puFO20yNYvzUtRmup?=
 =?us-ascii?Q?/KwCFRnOSLrDG7bo6hsgqt+yZhBusavXlhQpiCKuE6DCq7OPFTIxMrW8a60z?=
 =?us-ascii?Q?xYqnDSs3bS1GtLiToLBtMkLz+0JvwUrZMKLQDjs4DIIe3sn6bvsgybM+oNKn?=
 =?us-ascii?Q?3/LqItqUCvHo6iTBQ9PnGZYGt/mg+T4E0Uau8eg6vPf3pWf8TFY2pCF3yh3a?=
 =?us-ascii?Q?p19b68XqFXUXYFXddJCJKBATp+sdx66xW1cDyZUNUtLkbnUoTqHPJ38L2XSG?=
 =?us-ascii?Q?ayfxmx9ULKGF5S2Qs3EIsMsDK7tYbjXZlnpOeZ+A/JaRena16IMEJPRYYBPx?=
 =?us-ascii?Q?qEcljtuRQaMGw7UdkfoqVuGH94IaiXK5OOGKzHkW6raNqVsq3fTkQYqG7rjm?=
 =?us-ascii?Q?d88DxI6sGXS9eVVTzi0JATo+HxxsU6MQt0PYoeNfi4M13GAzfboOex4xIbPa?=
 =?us-ascii?Q?0SVTFgxoJamY4/GzCVV48FvPzCWEC7SHZmwWPq2s6tIl3tOpUmG5bP72vWh1?=
 =?us-ascii?Q?6Ym5QBNzd7nnAE2dA0ahqKdkBxFdle1s41H5kFDLJKzKa0wgr7nwuNns9S++?=
 =?us-ascii?Q?viByxUStdEi/EUt5NAvCOsGac7kHb48/8nI0xMMgqL5DzWlr9xNNZw6vTUkC?=
 =?us-ascii?Q?EubRizSRcpO0J4gFTP/pBn1hRF2AxBCKKoi3I0Ytx+nD+0R9bQMMn5gBhof5?=
 =?us-ascii?Q?M6EEL3kUr4dPSiWM+uh4UZqctzFqP7r1ifegUmKR94EfY7T288pceSPPVoSR?=
 =?us-ascii?Q?+Je8sGePvJKUV1A7sgSouDyNpA7lWQzdOKrhVLTBQZzRyRFA+uSfG97/p1tf?=
 =?us-ascii?Q?6q34TeEyebZ475c1OByyljtxTmPRNH5G1OgIdudHqls0gO3oe6NvCEGuo2ch?=
 =?us-ascii?Q?E5/Se11vradjXloU25UoOSKlkx7SFHQqjBYtMHmuK+TCYmuPTR+aWgi5QAPA?=
 =?us-ascii?Q?scdjBwqWEXOjPtPhULmHrCHHtCYOm4bChBzbrpW8hfh+69UmFFjaW93MAf2m?=
 =?us-ascii?Q?qPOkaQv/AQtxrBMJPgsvPoK5iA3mjGgEvmopwr7lE4LJen6BRE9+IoOkx1/g?=
 =?us-ascii?Q?YcyvFMXD5J9Sws24gwRbj8UWhooErJEp9t503GnMzQ6uv+5Cp3GoQ/bVDELU?=
 =?us-ascii?Q?noyHs2S7s3t0n92QVn4DES2Afsa+Sa3qUjjsppWTlHrbVe1DKqxV//yZukRU?=
 =?us-ascii?Q?5te9QUOTEhPLk9B2YZGDPtZDZ3TL6kNbonWmrjB4i/HqBBYml+h0vv+I+7sX?=
 =?us-ascii?Q?LM0NJw2sY6i14AGZWGRzlGLsWb76rMocgwy8SJC014PFTcgYjm0EoB0NVsys?=
 =?us-ascii?Q?ua2ij0BweCqtmPujvmhAIrcqrwV0CltABupV4q83466HLTzzz2RjOfgBnV9c?=
 =?us-ascii?Q?KEkbKskGzhIF84G0Xk4gBjlvGS5ZF71bs5J1620PaT1mNfhyluWwEQ8eZTw+?=
 =?us-ascii?Q?DPUDDWU0jRC9QtMCuqvyof2k8v4Ezi21+dB9PuKX3/f9Z9183+/uZTqzRVh7?=
 =?us-ascii?Q?7ckLAnd9OkJD+rt4O+aGMLCC+R8spuPHEHvzem/aGFT0xuNXvSShF3a48aOv?=
 =?us-ascii?Q?d56GCamkfQBx8yvPVf1Q9lNK6+5EOTJtW3RqEyaK0PaFz7TckOdB4TonWixx?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b85a95fc-87ad-4ee4-4e0b-08dd9fa7b250
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8786.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 18:27:55.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWfVRLS2A/grbZPkTijbGQZRy53dTMQMuw37FVs904f467FrvMPM/xj9+CpZ5GuoARvY+b/InN4Ut6qbbF+bj+7vE9ZwbRQ11hB7wTXRxSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8551
X-OriginatorOrg: intel.com

On Fri, May 30, 2025 at 08:28:52PM +0800, Li Ming wrote:
> When trying to update the scrub_cycle value of a cxl region, which means
> updating the scrub_cycle value of each memdev under a cxl region. cxl
> driver needs to guarantee the new scrub_cycle value is greater than the
> min_scrub_cycle value of a memdev, otherwise the updating operation will
> fail(Per Table 8-223 in CXL r3.2 section 8.2.10.9.11.1).
> 
> Current implementation logic of getting the min_scrub_cycle value of a
> cxl region is that getting the min_scrub_cycle value of each memdevs
> under the cxl region, then using the minimum min_scrub_cycle value as
> the region's min_scrub_cycle. Checking if the new scrub_cycle value is
> greater than this value. If yes, updating the new scrub_cycle value to
> each memdevs. The issue is that the new scrub_cycle value is possibly
> greater than the minimum min_scrub_cycle value of all memdevs but less
> than the maximum min_scrub_cycle value of all memdevs if memdevs have
> a different min_scrub_cycle value. The updating operation will always
> fail on these memdevs which have a greater min_scrub_cycle than the new
> scrub_cycle.
> 
> The correct implementation logic is to get the maximum value of these
> memdevs' min_scrub_cycle, check if the new scrub_cycle value is greater
> than the value. If yes, the new scrub_cycle value is fit for the region.
> 
> The change also impacts the result of
> cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
> minimum min_scrub_cycle value among all memdevs under the region before
> the change. The interface will return the maximum min_scrub_cycle value
> among all memdevs under the region with the change.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> I made this change based on my understanding on the SPEC and current CXL
> EDAC code, but I am not sure if it is a bug or it is designed this way.

The attribute is defined to show (per Documentation/ABI/testing/sysfs-edac-scrub)
   "Supported minimum scrub cycle duration in seconds by the memory scrubber."

Your fix, making the min the max of the mins, looks needed.

I took a look at the max attribute. If the min is the max on the mins, then
the max should be the max of the maxes. But, not true. We do this:

instead: *max = U8_MAX * 3600; /* Max set by register size */

The comment isn't helping me, esp since the sysfs description doesn't
explain that we are using a constant max.


> 
> base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
> ---
>  drivers/cxl/core/edac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 2cbc664e5d62..ad243cfe00e7 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
>  				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
>  {
>  	struct cxl_mailbox *cxl_mbox;
> -	u8 min_scrub_cycle = U8_MAX;
>  	struct cxl_region_params *p;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_region *cxlr;
> +	u8 min_scrub_cycle = 0;
>  	int i, ret;
>  
>  	if (!cxl_ps_ctx->cxlr) {
> @@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
>  		if (ret)
>  			return ret;
>  
> +		/*
> +		 * The min_scrub_cycle of a region is the maximum value among
> +		 * the min_scrub_cycle of all the memdevs under the region.
> +		 */
>  		if (min_cycle)
> -			min_scrub_cycle = min(*min_cycle, min_scrub_cycle);
> +			min_scrub_cycle = max(*min_cycle, min_scrub_cycle);
>  	}
>  
>  	if (min_cycle)
> -- 
> 2.34.1
> 
