Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77C1D5CF9;
	Thu, 17 Oct 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204394; cv=fail; b=W4RIr45LigIk4W6ajv7Qqmnrkhp6G8lxL9iiWU3PjIn4I5TGxbskD2b6+ck8O1FtSTpmWljHOG63dbfHwDjtbUXgZiLU2ZuN3c668d544onL7QJX5/63Z/yNUVegJr2lYN6u7HtHP0H83/siiZg552QN9oaBK4bsEi+6wZqRqCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204394; c=relaxed/simple;
	bh=xBT0WdcUzhZXbKjf0JuFYj+Q+g3P7CrUICFah8G9Dks=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hEoqbV8TzaPk1u8yL450oaGowIPY1VvoZD2pwxpJNBCBw8rbpJ6eCZkqTke4H0KjFw5EIEo4Ll1aZrtRw+XKQhmKb73lWKWkyWL6+yJ3mblrp2KAorZ3yHOy9zRFEIS9mhC2bc9StCC48gQPCYaH9pgjOnAFje+Hi4u+c57s3A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwEXFi22; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwEXFi22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729204389; x=1760740389;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xBT0WdcUzhZXbKjf0JuFYj+Q+g3P7CrUICFah8G9Dks=;
  b=FwEXFi22On6n5/xJuBhox/NqTas+7Wxn8MqqNFk4POLsgMF0Yvr31GtI
   F1+GbWzyziyUxaVUdpypPhblvLCniUaowPPzEXNpE5743tqqKrE+RWHMt
   46TW5+qRuK7kCQZdp6kcHLlOPPtolqfAJyQOF0KVoyxl0zJdvbZiqS76e
   G5TLjCc5T4Dt8lqmF/L/ssyZwUm2dMdhpFreo7sc+gpDH44kE8dlF71P6
   2r1Wie+haZgXny7npawyiEUg7nDDKYoVLcqD3PZJ6VJSHcmSeKMGvy9S+
   ImAH8L7rf4M5YAEG49qUJ+dEPrG7CWxcdsFzP1H7VMj1K+IvpQ6o/A2SJ
   A==;
X-CSE-ConnectionGUID: YVga0x1uSwOvs9Kj/S97cw==
X-CSE-MsgGUID: ukbraIqdTfWT/8G8DTu52Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28681711"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28681711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 15:33:08 -0700
X-CSE-ConnectionGUID: Iy1Mpt1MRpexXv6SlAh61w==
X-CSE-MsgGUID: NTC5a19oT+OeZkoDLGl1YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="82647199"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 15:33:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 15:33:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 15:33:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 15:33:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 15:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJrPIravDaBQr//6GQ9ZS3jsvx6Ej6I7i+zeeCugBIwBnQS1J7dnWPNUR9rAKHFDuRri+oheCPT8+oM8aoD2EFZlXKTJtfFJgEkkApXq8ZMOAr/tWDxQlxwvHnSGQAMZSJX0dypPCCwjBl8hsMAakK11PZDA7INGs3MeaAtxa6XUxzLc4ipfYILnGKjYYQidbefilOVfOhu7q8umOLqBF0bDsp0c6eQO9NXfOr7WNxFk1tE2QDgYvPmF2eGP9s3PoAslLDv0LGS5P5r0J4neCkwxaAxIwXheiAL4o8QzR0PtwlDoFPGGjkS/uzgN7hoHtZqU4VUXBZvwMjb8GmqFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7gqcB6LMApQ5BAm4FAVkTRadvoJuOWArDnSDMezhNM=;
 b=I356M7mLzdiWctmn3dDDUI9NfUU2l05TfuxoZnZaG6ucxplQ0V7Xu3iohMmBtwJ83Usbc4UXK47XEB7WaldguDlkksuP02XNnHGfjWG2enhlvN+wp18IX45LE+EINLKYKT+o0PPIN4kMerLuLUkpLhOykCnzMsNy3DfNr3Dc67JazbtHKBWm38buXxtJHj6I58Y/6RLBJ7mID9OqKU6YXqmxKRnVFo147wktbGVv5Aovp+fLJl+tYcRHVg3Pn8pUdVsOTpddAM0d/aKDamOeGNy8EHx11gfNc2jvpp7hLhmeCjsFBUcbXOlX++WEl5HkHX+ehksrgtV6IHoozjZF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 22:33:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 22:33:04 +0000
Date: Thu, 17 Oct 2024 15:33:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Huang Ying <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@intel.com>, Gregory Price <gourry@gourry.net>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/5] cxl: Set type of region to that of the first endpoint
Message-ID: <6711909cd5d83_3f14294e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-5-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015065713.308671-5-ying.huang@intel.com>
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: a212207e-3d44-40b8-5b5d-08dceefbaa35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lEgB8VHDsHcxVWsWdvhlmJ63PJDbFAT2R003tyYN4ddCNsjGiJzQ9itGN/u9?=
 =?us-ascii?Q?0ioEZdLtJM2DsbIXnL12pb+qPrVLTNEfNd00pAe9QrnN43CJvSMy/h3+7Yxn?=
 =?us-ascii?Q?dmpMqj/o8H8tgeAubj9YydHeJOBOrUKF10VOd1h9Maj3LHAIDCyGIbbtdN09?=
 =?us-ascii?Q?znXGaCd9nmCF5YIdVwtyMkqlwnS8midlZmJbkhT1sd6+ebx3gmH8ZG7uW7FV?=
 =?us-ascii?Q?KEd5KtT0s3eIP39gOCh5fdsx30JNKSqoQ8uDxwyDlCFPGWADKahXH6+/Nusc?=
 =?us-ascii?Q?LsHYlvF8Bx8oVgNbBD5IdhDQJUW3ZFsC+uGHTkZr6JiFlLNSLN0aLZtWy3nz?=
 =?us-ascii?Q?IFKya2ghc8961cAq0G/3Z3aoBBWCnVrgaRn1D/YALCSGAc41oR8Ir/OBUWMv?=
 =?us-ascii?Q?Pf6DZsSla97XsqMLA9wdG62pFJ8V3/ybNAeNWV+T+Vq5G6M35IM2ZDGvensQ?=
 =?us-ascii?Q?ctwovK9weh6F5blsfS186ODQ9jlgA3fg588vy+sNj7nhBIfS6U9U8znjmyPN?=
 =?us-ascii?Q?jeKzmfA4t8iUJ3R+3eGWPIz2kkaNhz4gQz42Yns3NCBOYck2/IYu3e7bP+C6?=
 =?us-ascii?Q?7NgCLO05Jg969dNBqYq9aH53peR34psi+4eivxJaAGBxvFZWZxkKa1v3/zJ2?=
 =?us-ascii?Q?vrRwwdHnRaWLI8iisF0XWWpuQy9dxNhaz5C2sjCU1iteSxG02DsXiVKtOfMh?=
 =?us-ascii?Q?mCIw9pi2vFf9L8x+KHsBYnqxz0VFaif+5y4ZfgVlLIgp8HwPFCC59e8Af22S?=
 =?us-ascii?Q?llK1N+9AMdMT9RTf/yvZW21X7TA9cvjSfP/sxqHfncBS4dOHm+GBHdJ8TRUG?=
 =?us-ascii?Q?YawVdWeQjoAaojWZFbWccH8yqV3rm9ZgJ0BvEzugJIkfvGBGAKVp9Sq95nF+?=
 =?us-ascii?Q?1mLaJw8OCjE9W22dQEtCzAT3uHRVOp9l+fM8f33/8rivDAlL6jo7az4DN7LE?=
 =?us-ascii?Q?7hIVIbDC06WpSp/dSHg8Tmgguqc32fqs5pXbMlDS4Q0l6Ql87sLQNg/JQj8J?=
 =?us-ascii?Q?7sPjk5CX+j/6z2iepLw4FpdczPUbaItkpzMfAYMaXEVgUwdM894ZE1MRhz4n?=
 =?us-ascii?Q?CrH4FMVPyOQjQaJqwgg3Pf9ZPnXJnQxibWPhUl/UX7fFcIYJl1fnZXvESSbc?=
 =?us-ascii?Q?2goeYGI5bqMtLP+OkTNgZ+R3tyiqZlKSG8BlgCmH+xBJNkBhDCk7dYNCYZ+C?=
 =?us-ascii?Q?L94A5ITSS6VHYRgNHitpCP8tNNfhJiIVbOatzZECYsv19ygJhBWzCQWtqeAG?=
 =?us-ascii?Q?2BBxUWZ8aNHk7hI8dxqKJxFE9Xy1WuBa8l6hbQbYFRszCaj8R6G+GtMjD81w?=
 =?us-ascii?Q?s8taUi/Thl+IlFoQGtng7Qej?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mX290SmKuYaTC588HN3qbS7S23HpHMwm5lamWSeSKRnkfiNr00ncEw3uK1vh?=
 =?us-ascii?Q?2w2WxUnlJvYStI7fwgdeqZqA6tECRvaMNJzlBYgIbW9KWOsm618Rj5Mjjv7A?=
 =?us-ascii?Q?FmND/ZwFt9JFSk2Lwtb4tkwjwtKFin94sRF8NfU0MjzF3dB4MuwgYxuBkzGB?=
 =?us-ascii?Q?Ldifl3N1RvWDf55mQ9+cKdodAFE4I+BQjL/NH94qyTxVsuLB/vK0WAXpIkUj?=
 =?us-ascii?Q?moG0jzStJaOAdXXMVGsI6dlI6YsbewLWXUV9w+Lm+Zoknivun7cmcZfS/Rey?=
 =?us-ascii?Q?ks13vkPf4YHE81F80K6YoVBFEF+cSN6iECgZ3OK+Wb7KZbGSwpmFjawjLbrA?=
 =?us-ascii?Q?CgkLICFFbiB/HicEoO+SrcqAlI1E+N1Z9pMPnebzmRcx3jaXwgjTqgRjeALc?=
 =?us-ascii?Q?alxLlEB3+bSQSquCY6gtiDBck7z4knM5P7KmYrnl7cZgpP311Ufqzey0NiPU?=
 =?us-ascii?Q?njFUxOT1m+VBXdmi7P2WqPg9S/TbOSLVVaSYffE35tli+hp1E5fWeINJPh1+?=
 =?us-ascii?Q?T0phwxLIBMipX04pJDwfEDQ35I+J2R2IE9HcCCUIkWMsAH9u+lD5AS1dLrPB?=
 =?us-ascii?Q?t0yUIsKHMsht3uG19j+xux/SWj+fP6vWbewY/HNRPALtx/LGuq2kOgiTnrlX?=
 =?us-ascii?Q?VTp1YbvcOFk1Zv3GOLB4a+apazhLco/6ihybJG+AvPt85bYd6PJV8xTX9j+B?=
 =?us-ascii?Q?L5HQwJxNszpCJm/6cYLNG7EOWLwZS83eE4aKQtmB16v7+0yMqImPgou7zsOq?=
 =?us-ascii?Q?p9SMhh1t650LpIHx8xYsC5J2+2Cjya06tiHxojqsvVWGanBlPvSlOOnVzkB3?=
 =?us-ascii?Q?PyXAgzrBPbSR8NOlQcktRMBd7+jUbUjaRD9RvX9ji0gc4WY1gvX8sWmHi4oD?=
 =?us-ascii?Q?TuCsCVPvRN9DuB54TVgW9PSKwIGKBJRRxXVYk3mUzfcsRsRFNcRBAd8UaEhl?=
 =?us-ascii?Q?nFOF8dllQsslysjtGhfn/2bqtyclgs3BbJfcN4b79L9STC+3tvHfKqo9FnP8?=
 =?us-ascii?Q?n1rk3bssuNxAQNFNQAO5q2Mbm2zXSJyzVL1ZWycUn0levhGsUvov6jdqWT64?=
 =?us-ascii?Q?dVPfzM7x1BlkNBGymOm8Y318UzSZI/QTKNf+7a7AyvOQdKvriUBETLOOwY0p?=
 =?us-ascii?Q?CgXrCf4gz7KVQXwgqA+Vdxfb+L/c19Am70UuE8h2W/AVrdjxWtTjw8xpdMAF?=
 =?us-ascii?Q?eE3JlbUr71d6HFGAleNaqo2OlUKcCHSi/YkLkvxrAHUtHnk/MFjTAqd7lNL0?=
 =?us-ascii?Q?qmG+IYbFxgPCrdtjMnlZWCLm2hri/GUlZJ3bPobiozFptUDasBuN6IM9i0Dh?=
 =?us-ascii?Q?s5hkToWuvohydD+3ns9XW8btaW8KsbL2vCavQ1XsDMK4in+Tc62917AcWZ/M?=
 =?us-ascii?Q?o+B06kMcVlaao2N2+E1jWT91kflfRz9BeI67pWoprdPMDzGSbLPnmAXQFTqc?=
 =?us-ascii?Q?1AbtG8kRHeaLJl3PNHNl2uvZZ8/+M80XddX/JL3qdcJZ0857FsOA2VQ5d4d6?=
 =?us-ascii?Q?VFuYRe6UC3NsaVHzAEml/uO+oVRuJBJTvNHZeED0jwksLaZjqghROq9bHxfU?=
 =?us-ascii?Q?aCL1C3WOGi+6GkOgAcwxc2+ZY9SvHyjd8l3jNK6Mmhw+N/YM+z2b55EdrXGP?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a212207e-3d44-40b8-5b5d-08dceefbaa35
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 22:33:04.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcjkzY2PfdmX5q6vBt6OCI4XY3Ic34IZakW52N95bZjdWfDjHiiSJEs8KW8xhTs5o1Xjg1eW4J00I7S5dTTUh9e4KyRz3Tqdv2kJ8gX0jyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-OriginatorOrg: intel.com

Huang Ying wrote:
> Current kernel hard-codes the type of region to type 3 expander now,
> because this is the only supported device type.  As a preparation to
> support type 2 accelerators, the patch sets the type of region to that
> of the first endpoint.  Then, the patch checks whether the type of
> region is same as the type of other endpoints of the region.  Because
> what we really need is to make sure the type of all endpoints of a
> region is same.  And, the patch lets expander/accelerator device
> drivers specify the target type of endpoint devices via struct
> cxl_dev_state.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/acpi.c        |  1 -
>  drivers/cxl/core/hdm.c    | 28 +++++++++++++---------------
>  drivers/cxl/core/port.c   |  2 ++
>  drivers/cxl/core/region.c | 13 +++++++------
>  drivers/cxl/cxl.h         |  1 +
>  5 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 21486e471305..29c2a44b122c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -382,7 +382,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = CXL_DECODER_EXPANDER;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 478fb6691759..c9accf8be71f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -841,18 +841,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		.end = base + size - 1,
>  	};
>  
> +	if (cxled) {
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +		if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> +			cxld->target_type = CXL_DECODER_EXPANDER;
> +		else
> +			cxld->target_type = CXL_DECODER_ACCEL;

This looks broken there is no way to know the target type of the decoder
from the cxl_dev_state. An "accelerator" can have HDM and an "expander"
can have HDM-DB.

> +	}
> +
>  	/* decoders are enabled if committed */
>  	if (committed) {
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
>  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>  			cxld->flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl)) {
> -			cxld->target_type = CXL_DECODER_EXPANDER;
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>  			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
> -		} else {
> -			cxld->target_type = CXL_DECODER_ACCEL;
> +		else
>  			cxld->coherence = CXL_DECODER_DEVCOH;
> -		}
>  
>  		guard(rwsem_write)(&cxl_region_rwsem);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
> @@ -874,21 +881,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  			struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -			/*
> -			 * Default by devtype until a device arrives that needs
> -			 * more precision.
> -			 */
> -			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> -				cxld->target_type = CXL_DECODER_EXPANDER;
> -			else
> -				cxld->target_type = CXL_DECODER_ACCEL;
>  			if (cxlds->coherence == CXL_DEVCOH_HOSTONLY)
>  				cxld->coherence = CXL_DECODER_HOSTONLYCOH;
>  			else
>  				cxld->coherence = CXL_DECODER_DEVCOH;
>  		} else {
> -			/* To be overridden by region type/coherence at commit time */
> -			cxld->target_type = CXL_DECODER_EXPANDER;
> +			/* To be overridden by region coherence at commit time */
>  			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
>  		}
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9ebbffcea26a..d1bc6aed6509 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -139,6 +139,8 @@ static ssize_t target_type_show(struct device *dev,
>  		return sysfs_emit(buf, "accelerator\n");
>  	case CXL_DECODER_EXPANDER:
>  		return sysfs_emit(buf, "expander\n");
> +	default:
> +		break;
>  	}
>  	return -ENXIO;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21b877d8582f..d709738ada61 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1926,7 +1926,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (cxled->cxld.target_type != cxlr->type) {
> +	/* Set the type of region to that of the first endpoint */
> +	if (cxlr->type == CXL_DECODER_INVALID) {
> +		cxlr->type = cxled->cxld.target_type;
> +	} else if (cxled->cxld.target_type != cxlr->type) {

No, the type of the region is determined by the caller and should be
gated by the region capability. For type-2 region creation I doubt
userspace is going to be creating those vs the accelerator so this all
seems backwards to me.
