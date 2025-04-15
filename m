Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93D221FCD;
	Tue, 15 Apr 2025 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752773; cv=fail; b=ahIrfx2DnwyZf8sRZppR33sqxKeNq1pISheHQ3cbuL0m/VCorTCrqvxhTBvogkvLk6nIF6f71dnh+O08ZSXKo8hTHiPjoo2nUUnU+JgEgLCFsNZl/yBUx35Ec6Ko+9osSzeQybG/xYX0p75+oKBChtv/l2Om771mfg1BsxCyrYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752773; c=relaxed/simple;
	bh=msp32DG1hFwvTHOLyTNvOQt/wjk7Hf1XGHjcqhDiljw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mTfzzSPg965tBC87En7FvKNJaoo8NufXgDDQ3Lt+pvsZFKaz4+ESLVzTYlQ2anwd0yrFIheGHrYQvtwwYili8Ji1zZ9akjyRum5daBR+nhzfeE58BzgLUARn46h8rujBK3/ByPU7+zLijW5aMtVq60/0aI+iSiSoBGAcNmeJBww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFRxXJf/; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFRxXJf/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752771; x=1776288771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=msp32DG1hFwvTHOLyTNvOQt/wjk7Hf1XGHjcqhDiljw=;
  b=lFRxXJf/Bm8QBfsxoW6kRL0BBs4T4p+EnTiuBUUrM53efdWfmLjSuXRN
   FrAFJZ08eOw5PvmFZmvXpEoEavM3qlbuGnwCK6I50urXtDXX9UO00PH5x
   ZZK5Vp2gZkPsO25OQXy2tVb1e8GEnRlXFy4lOzt2i79NC1ikappD9IE7X
   teinB+29V2rMrPKrkCSSQGBOrQfqNbGghKRoW70VRRzSJ7gs7yXA6Hisy
   Hlnz7Y/1fN2wY4Kp+bD3O84+ewArmvzngKoEMnBFz5AF1XckVI9vWUbZ7
   GFDL64mwjJ5oZ6TCfu0kjmNbuSiEEFhHTKEgAAjU4VWqNVbZRQlN0a3u+
   w==;
X-CSE-ConnectionGUID: dfJ47wH6RkaSIO3WysTcRg==
X-CSE-MsgGUID: 5SrSCAFWRp62jqlCXUM8bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56945237"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="56945237"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:32:50 -0700
X-CSE-ConnectionGUID: JtcIONeTSyqiitp6uc9AQw==
X-CSE-MsgGUID: 0UzSbS5UTXq0nl3RTWfnkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="134356348"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:32:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:32:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:32:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0HXP1kk8N9Ba2WVNTzNgON9U3Qof3gmXzQlmfqLh+9bS5OOALQx/UTiRQ3zzqyInqrFUEkD3dZ7hHG3ebRTcNArVL8BiG/0lZMobotEmp1wYmsCUGCVJmnpP8vqEQRQexDNHROWAbVIsS1qPafTqlAsZb+bNOd0qt02GALvxzlnpLKb0NgR2cRWk7M2ABJXV5gbNRzJL6Qbllo5zyefBc9p0NP8r/cEQLtnLahSQwR1sEMG2dUeotitu5N2BHhmikfMg+n5K9VtIVUFfRAbL6aq6XbW3qFA21PTZTnH72yTYaqWo30nh0dklaSikD8t50c+cDUPuASNpqtAC2smNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNuiPYHKBndYlUD3zuNbsryLvA4cHr6/p2khLWvrKKU=;
 b=oLYjjhdIIuED6aJN94wV2jC3q8G5REzUb3LI2SEDaUeWUIzoRGc7uOKo+Qzp7XJglfvNbODsbvuekU+tcc1beVd6GVPWm1K8YTsUdpfUHuJCqhZWntdLDiDuijt0ExJiF1gSltR3rKKsuP41VowpmL+xrxdvEW2H4yc2tMOV8/qRyiQmuPTVgiwO8TWH3IOdEWy+wyVYQqr8VxyHKX5tS6Y0tzHM0xbf2Uo/Jdq9j1l7l32jMBDBJgBoCt3c+AEQoUnCZiu3/dbuwgdOwDM/Q9Q9x4det6rmJUg+HrrdfoFb8om7r8IlzGFyoDjvlSXW4wc+z+BVCXhOb3CpLFhB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:32:41 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:32:41 +0000
Date: Tue, 15 Apr 2025 14:32:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 08/14] cxl/region: Factor out code to find the root
 decoder
Message-ID: <Z_7QdJBmUnjDau4p@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-9-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-9-rrichter@amd.com>
X-ClientProxiedBy: MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::8) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cfcf79-786e-4681-2d2c-08dd7c650d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mVSQRpHbPeR6W0pOeSFDEjah5PbiLnxnViy5rN1mA75P6C4QjR3saP/tebOv?=
 =?us-ascii?Q?Up3wve0OquX1PNtcfwy/k/aVETulhcVDaBLwjM/L22iuuJMcxUQe1pTxGVfn?=
 =?us-ascii?Q?spdGjB0jmfd3mKnYQqvl62ly9JvtFYDqnGRMevRht8GP+nC5On4KcY31rOgl?=
 =?us-ascii?Q?bRdImtcn14eWfCeEwK1NDfcYy3+mYLn08M01Lu2ZMhPL6AnGfNOMxW85ZTNQ?=
 =?us-ascii?Q?sfeSzhPTFAuLOA8YikygP1iWqfRdBpCLlmj9dlwoCMQfTo/U+DiXh0DgaiM6?=
 =?us-ascii?Q?UMROhsOTNxR/rkLYp2p/T+q7hwmSSQWywAt8MOIgTVB/wJWQlVYA/NMdNXlK?=
 =?us-ascii?Q?wlWPQx7S536VD44HLf5xlw+CbE+5KHzlhPW0dVTrNyw/ITZhBXiG/OhqXSxV?=
 =?us-ascii?Q?xPYsueHtZdbiMebz+jL7j6uOB+9nW/AXo4/vpbnLIANDN+os5k2QgwY0Bi14?=
 =?us-ascii?Q?we0ezEWHBO2E5QIWe3nLIHDrGHEBgg9b1IpSTl7Ok1iowyAEUmEncz6hPLKy?=
 =?us-ascii?Q?WcjLPPoITFlAUEYH80jd5ehfOaFOkcyonkjm4vJfBtZXZ1LgweEFI1tA6zoL?=
 =?us-ascii?Q?n2Dyvz5xxFbQRSbLEKflCd135WmAxdyemJIzRmLFonqGqdOxCVfLtDegu+Wc?=
 =?us-ascii?Q?uT0v256zIYtkhs4ML4qwlPzDcXpJOoiJAwv4DpJqY+6B+0p7hr7cvm6Cwdel?=
 =?us-ascii?Q?f2g/os280L5xOQo7igerC4kA40nqAxqPR82OFKbXi8NAPj5lOCcqRLNoSXMF?=
 =?us-ascii?Q?ft7eoSiJur5c5rnTPu5euUltbTV6+wF6QJLgpEueu0Jq2/swq4aRKaR2c8EX?=
 =?us-ascii?Q?pQdYn+Y1ovIIc3+8FOGBRkQxc0nuF6tQufUNnMJqJIHbHOA+m2wCW+WsXgds?=
 =?us-ascii?Q?HVISD57HQOI8TOs9dDVMHh8d5FYF5ssjHId8nieZHCSnrlQCVdwFgc9VJl+/?=
 =?us-ascii?Q?OcolflhShgk7znOr8K3U4JYZKXfOsv9svnFzMXtMlKcYgLkIXfNbksSQyWYk?=
 =?us-ascii?Q?nohgsfkBd7OYa6jb0TMMuxU3CSH+aykr9jwlC6QvWFlLKaDM7wdjH/b7BXDT?=
 =?us-ascii?Q?kgUCehw8RhZfb7wFOMgrwxyOMBsP3sH2lhbchQY2A/9GD47wKMWXWvVDsC0H?=
 =?us-ascii?Q?ZCDUSPgb9e9mnuJZwgDPwYfswLPGVipHsSS0eqkPENTd2OBOE7Al0GYZvN+8?=
 =?us-ascii?Q?6UYAqEU7G9AEXpt/y62Qiva/2R9igrpaI7JzBW1N0/f74VF65766RHx0+7d8?=
 =?us-ascii?Q?Bn03M7dtqcI+bk4lKxpwmYy5KkSDcLS6RNKpjBzsct4UjiFO4zsSCHy/PmVa?=
 =?us-ascii?Q?vQoLOJSMNrev1jghjTSuPs6hDNV3lLRzwJ5wm7cDGjO2Gorc9CLzCvKCwrJw?=
 =?us-ascii?Q?a2qaOjPwp9bN9VsaBk3exCSjSF/W41ndevnIWG6WclzH4V3Bq8arrVAFUT0+?=
 =?us-ascii?Q?1WumYY3KWyo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ccy3jBFOV8t99OfQeKd9dpFqTptlYp9EYU81E8Je1KNnE8JYnzw0Tj1G9tJ?=
 =?us-ascii?Q?yEmMDwGFUotxkLDWEEx6LwghzJYj6vJ5JPA7C53gi5q/vNBhNtHufkpzTmCl?=
 =?us-ascii?Q?rFYqBIJQln1y3iqw1/SY6ieeQ8q7Z5krmc7A+OOK2coPD3NUAW1oDfc8Mchw?=
 =?us-ascii?Q?DCdQbJN6Q3Lz9RoHfUv38t0CXHIpGjcz8Lk+sd9FUeErNCi/A8FzPo2pezSk?=
 =?us-ascii?Q?AdJTUuhud2T9dmg4d/s298XDrGgevE1pnK6qD8igPjBto9lJIe/L7GtTN397?=
 =?us-ascii?Q?1+TZYLZJnuqmfl/0XeIoUT06Kxgw+gGUKiKTBhmwmt7ewA0FKMePgaKHZJlG?=
 =?us-ascii?Q?tUbNZOsxuGznBOYKzGSHcRnD/JUADf8NvBeAJ3VrPOMKaUlMvL27+fS15vUh?=
 =?us-ascii?Q?GRIfyhgfDJApptJtgVRlChhal0WLxrvUqVbtKE8jqZLWIkySUJ4pw8hdW8ty?=
 =?us-ascii?Q?xv4b5J3NBBcjbll1C+SeSk0mKGBMcVzFZNxMclIjQ2L3/dUKn9XyI6TNx+bU?=
 =?us-ascii?Q?mbzZ1OWXCOqXrkIutVqBUgNBkvePdHdzfP88eEwpOqe06HjwMRgs6UDFzmd9?=
 =?us-ascii?Q?C+LfuGPKQDzs1PQ63tQeiLsilu4A0R1DsQb65jZnd3dk+IWdVTovrHU4vsFr?=
 =?us-ascii?Q?ESZVOwA0cBdSpLFWXrMJMFb5KDwBk81PatIts7Kb5iFaYtYdc0nXzbaYCEJ3?=
 =?us-ascii?Q?uyyuNGx3MgwskanCLdKEEmxdjrhrNTHifEL162Vkn5gk/1eX7gy5jW9v0n/f?=
 =?us-ascii?Q?HTQ0O2WqHUZJ0nce0Yb+vlvFb1tdaR/vmECfHdY+RpZKpep+G4Zow2NkxNcv?=
 =?us-ascii?Q?KkyEpmF/KBA8xb2KcNL/PH/XYWW7KL+wrltv9DSD+lB7OAg1CmSGe3DFs6VA?=
 =?us-ascii?Q?4FjBhMbCir+j7fApw55UDKr8jzMjMS3hq5qgpd75YmPDPXneb3a0i6WaKVc7?=
 =?us-ascii?Q?HzOoW8BF1oPXHHl/MP2eU9IAa/nX6/NYgKFhkusACHleCHEJqp11OSkVtF+c?=
 =?us-ascii?Q?m/Ga0CF+L3kfVnI2lm3cXtX+qGLr/aiNiK2Lmye1puVsp7zBYAYz8pEoL7bL?=
 =?us-ascii?Q?zu7zXhqLOEsm02S/RAYuK2RgtDrt3AELgcJCoor4GogfF9PafGh11PAiZLwg?=
 =?us-ascii?Q?t3S4h6GUXlgL4pcQSVxo2C2xXuFmijWQko3qYoWpCZuXyfBDDlWBjqrP3QCE?=
 =?us-ascii?Q?Fomj85NEQvqpqxjFo1vMGqdMFVPTNKucLpjOcfydeHQqBaz/KigyDrpP16aO?=
 =?us-ascii?Q?AF8bL9Obji/wHO+QHnOBNm9gQnRKKNNN902ZzAQCDFCsbqATm1jaQcTFK9jS?=
 =?us-ascii?Q?N4oXdmJ8eC7UGSAQYcCDPvybVOAco/AaVrbC7yoWdczcft4gKx1PD9M3j9pN?=
 =?us-ascii?Q?s+2GQ2AJXhK9eRhdwSBzBHIGcvN9BORYhTK1tFI0jD2/RLB2mh2hWtwXoFzz?=
 =?us-ascii?Q?WveBycVNLOdT65kUvPXxOeLXMi55HIdFbgckalVGo13xTyHHa7gCLFXqkMz3?=
 =?us-ascii?Q?B7uqb/st02KxA+aNJB6wILYznlyvlMbE5qZlcUxGTuMIo3lrFzxbbUw8gR/9?=
 =?us-ascii?Q?DV6uHImLuYiz6gkd86XQ3yfOIu+WicojCoDgN6tRkRlTFTO1mStxIJMWTSbZ?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cfcf79-786e-4681-2d2c-08dd7c650d3c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:32:41.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/zpJqp3z8Hf3IeKijGNVvIgpnuX0Z7Lnx8fYLMLZgL9s/h8ndkVG6X7TgR241iWRinTKOnGjCPJ9O/a62T7iScRJYLAHjnMHzZVfGtk5R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:42PM +0100, Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine the root
> decoder associated to an endpoint decoder. Factor out that code for
> later reuse. This has the benefit of reducing cxl_add_to_region()'s
> function complexity.
> 
> The reference of cxlrd_dev can be freed earlier. Since the root
> decoder exists as long as the root port exists and the endpoint
> already holds a reference to the root port, this additional reference
> is not needed. Though it looks obvious to use __free() for the
> reference of cxlrd_dev here too, this is done in a later rework. So
> just move the code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

