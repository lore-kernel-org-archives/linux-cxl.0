Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F61448E3;
	Thu,  6 Mar 2025 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294563; cv=fail; b=emwA0bSBTQIJE6BN7xeq0cLfz49L1JOEYeey/ggFlSBVfsBI34vrOnMeb5yqEZEjf8pag0ohOv0uSTIO0BGpXLPr22835VhEN9sWp8PLqgW1OxfRFkn3ZzOLjkZRNQib4NCWwuC3+QHkjFo90txVEPi+3JGi57FOUUoDnOmVsdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294563; c=relaxed/simple;
	bh=+l+CsBLa2SuLmtFym8FSGSgtwQpGjZVzsoPUEaqMEHc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=txgd9SVewj2OPXwNUvDzIHRn1BaZbO6Du3D2hWxrlzBWjUV28pSkDr3A2Xfcpg86FCRq2CX+m+YuS+2ofv88iulPP7xlTvnRnyDmfa768ysNJrQMXfUWT7f/MKJ1lRdkXQUioyzT6ofBB8Rvb82MLxZ+yP0QNWPpet7gmlLLqKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npVx4a+Z; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npVx4a+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741294562; x=1772830562;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+l+CsBLa2SuLmtFym8FSGSgtwQpGjZVzsoPUEaqMEHc=;
  b=npVx4a+ZDweu740bwHu2DhhT3PwjzhALqXin9AQXYqAx4KR/mwigCxO8
   FB+WE01ScxqCk3Hu+7ry82B91fkJqEH/Fu3EIRnWl3p43i1Eeh7M0AyUF
   3qUdgjLSGv2tJun95v0iloUwz2+HZ4YrMntbK9uSUjb552HtI+zYdsQ+V
   SK4x+u4wsAlBcsl+i8L4niiqW9rKXJHypw+OA+bIsojNmtkXY9naFqypy
   FTGaHfSreUahOVguImWVKq7xxglYEJW2Fn6ks0HCdEvimW9t3DuANLpKZ
   RANXiW8pTnAnLK1ghDtThunaAkr1mZZYKc0OWIRBAcUiMam3zWgl7ijLo
   w==;
X-CSE-ConnectionGUID: JtMYc6lMSoqXf6rl1TnvEA==
X-CSE-MsgGUID: mEqA9nWoR3+Mqiz8NBFQ+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46101200"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="46101200"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:56:02 -0800
X-CSE-ConnectionGUID: SeLvTIBUQLC3R4v3ArV0xg==
X-CSE-MsgGUID: ArcIoF++QH+/Y+9BKeu3XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="149928122"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:56:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 12:56:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 12:56:00 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 12:56:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP7MB77D23aCP3IrZvUygg8q4WfTjn2s/JSM7FQ+PJ3p8BdEKANsE/YCNg6Nr3ApqxVMzJcsRcSDNwfzDtqJ7uIAHBfq90r55Gt0FSDypCLEJrjEcnSguZePO1Vc8xnUOyXLJSt5zDHzaOZvvH+Dsuf8jbjsRAlMX1bWIlgW9mdZoT6tQUExR0LFCwnkCkBvYHR331l6O7LoIFyBji9FiapoJj28aR4YoMaRmB64hazg5pH1ntgamD6t3os1+LXRSF2ab2sObADqOBu18xIiRNqVkm8McObCY9mpv1KSbcWWxm5zwTqzMdUPX5HRqIDOlO4ONQp4aCH0779/DHEUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrZyHupzrGt5lH06f7nXiHLSbLfPM2EfOIQW5M6z0KA=;
 b=qNcxBbIr6kpwJlyhhg7mqWivSfb4D/6BJL0RV3gv+TSQS9Bsm0rvYK1TwrX2Kln7ldN3q1RHjfbyLRnMtbFCV85FEBYH6iBMnY1QoMpsieAfs4zXAoL40AWp4XWk69iMGGvyuepBsM+gtBLWxW7oiTpEbKlMmXHuQ3Y4ooMnv1U7cmhYyM6vTFMlZ4U7pGU/SM6t2U/8YTkHS9H6T8jNCZXC0JQ0hGiuGGldA60rXP0rHfoUPV7YanQ1WF0aK11uUXoojxsZhkvZ2+cSrBPWRImYT9sLwDMW4F2FfkBKguddTmGQ+3CKgbVySdOzwgXHa2GaYh1/LUS4akE8eovEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:55:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:55:58 +0000
Date: Thu, 6 Mar 2025 12:55:55 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 10/14] cxl/region: Add function to find a port's
 switch decoder by range
Message-ID: <67ca0bdb45cbe_1a77294e2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-11-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-11-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:303:b8::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: f18645dd-5962-44d0-3a9c-08dd5cf14b80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2/vulWBve2mEe9PFBV4VN5M0uT0oLsJ40RyRH20DjbvLpBAg31CPkA66uTvr?=
 =?us-ascii?Q?lH9TSwa7X+OFBCxNj6PTnb2K5/VHa5QA2rbTfVtCMEbL01bnZlJQQfvO6vNg?=
 =?us-ascii?Q?/Mysl6gwLE9GugRUYHvQu9TZnRY+q3oYSIdnnjc1uvp1ye2+1lliIEUntUIG?=
 =?us-ascii?Q?7bj8hhfnz7p+GdWqRrma86giYgI0HnAipsqU8tHnFcH4DhVBzpLe9TYJt3B1?=
 =?us-ascii?Q?cngMSY/a/0C0GFWjpwjDNPDFb5eIwLvhB45IWN/aSyG2RfV4ezAxDoBOYpsI?=
 =?us-ascii?Q?HHrTEyXgdhMGY48rZzqFdMBjDDe6vFMU0TQygQtE3XhOFPZqSy+vrK1fgdyZ?=
 =?us-ascii?Q?8F0tu76Xa+LSvW7r+EP28j4m+ULHJz5Sgyl/GSF7kGHdQdH5pep8mOiUol8v?=
 =?us-ascii?Q?YmuHJbBxgqa/XqpzJFh35qwIGB/KBV8JV2g1kjVGeD4RBU6iqGCFb9FTbxbm?=
 =?us-ascii?Q?UPN5KE87+eZkWQ4GNjKWsNcu4oO24ajG5T/m46oWJB8MZR1O5gQImWdZgX1Y?=
 =?us-ascii?Q?ucdsgZYUmTDziR5kjZoPdfdpkP3U7G9XfqQKt60oPPGGS2V0M/Wts2m393+E?=
 =?us-ascii?Q?EikGwQAFo3XzZlzzhqC4alC6rG6mvrpWFZ3884w7qnBoj47C63THshljIvjP?=
 =?us-ascii?Q?1K+RjtgcfJMQQRU/1/PFCqrtSyfjizhjHKTMuon2Raq+5V1uwbv4HkP8WQ5i?=
 =?us-ascii?Q?/J6hKpL+NLGG7H3i3Fffp4SLsUgKR7qWmdQ2JLFxcHZQSBY5MK5DIF5KyEO/?=
 =?us-ascii?Q?Hqb59J3NVNDP5fOcRsd4CX6RyI/3i1mhwsqWSQH8No4bcexyvKw+ESzE09a1?=
 =?us-ascii?Q?d1bYPvlbOWWyhVm+KJ2dAeGAjxHOlDeKEoBZ115jG4wa87Z6mzvwsXhvENdb?=
 =?us-ascii?Q?2NsJtq4+aal5HdAf5vcYeFEk5KUJ1wLxWr8sjfVbD/zewsAHTAPqfotVO3mQ?=
 =?us-ascii?Q?4lyOPnZmHJ1eLawqY1f8gMHY+Gx90vY9SklBXXYXSFCtUYTP8MY1tKnzr4Go?=
 =?us-ascii?Q?Qq4MBh9SRJN0zEhl4FcE1ngwVlomtE59i673rTooicFSjgu0UNcNsB9HHCo8?=
 =?us-ascii?Q?OW3bgtVwkC++hu7Oo6mO+qBB3CE3o4cgYdOkNhnSpOzDywjJtmGotev/vizE?=
 =?us-ascii?Q?2v+CGVe5PndnRIQArpPh7/UnN/NtDqTLh9piDtIQnedYslZnXd9rR32XGzit?=
 =?us-ascii?Q?leM0ngnW/okpQjq8OU0/2b/6SPkBUDmiGGqbDbI/yxaDVNmAY1ZP9WvhMJB7?=
 =?us-ascii?Q?uBwZA3HIpYCTLc+sm+Vh72gR8lvra+BVSUBuJWaFu8zJ8AMagnEtKokp6SEP?=
 =?us-ascii?Q?ja4qabn3OKIs/pH2pFSpLwvPJpXGvpB/kmpjAiw+Xj2rD/Ye0fX1mJVVWdNQ?=
 =?us-ascii?Q?Rd9mnNqbRRV9qhRIoXJdbM51xO+6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4m4yy8G76Owjld8mKxy7u0CoChoBIMt86qMIpUF9yBCkrkehsZuFgiejp3l?=
 =?us-ascii?Q?HnWOvaUc2nDMAtGPZ4qYbg6vjlg5NXGZpuaZwGGzkZcaVu3LXyMtff3jldtr?=
 =?us-ascii?Q?mQ01Wxn0Dnc0fzrK62Hub1TypAaXxifh6aLBM9PZScQslQ13dVY0BqacZkwX?=
 =?us-ascii?Q?aLkejF+p1ld0CjavWAe/6gO29IIv5bx6VMydp65l5szRd6y3NkZFSyfDMj41?=
 =?us-ascii?Q?/5njQpARwyI0doW0VXnVCgYsVXoWlMILrqcABnHAaA5S/NZGIHWVsi1B73Rf?=
 =?us-ascii?Q?mcWAo9sktoPGEHopFbU9PZ0gZ5bKIvlEzkGfgNybbcT1uALLh3B3+hEQEeW8?=
 =?us-ascii?Q?jEzWyxCUGnTSPAzUcTt1UZoo3gqFCcwv6Ig+oIyv4ij3kpQijzbLueXYtKHt?=
 =?us-ascii?Q?4hxeFMjTevMURtk21bPQLVtcVzbMXOEH/mZc8lq/QOZgtDysHGVyXQ55u67I?=
 =?us-ascii?Q?P3PJoC/uCZLHFJazC9VvU362PzTfdddpVejnbh6OaCRdob92RoRoMsUhjuQo?=
 =?us-ascii?Q?6K9wWQ7ZkxEnj27IyVWHrQAKjS3tNFm4mmND3N13v0xO2MBGwywvYdI1NDJ8?=
 =?us-ascii?Q?xweOW4zbURITPj3o4K4PtNjPHGzEFqe9CRnfbrW4uPa6Y+wr6Zy/k/nLeOLu?=
 =?us-ascii?Q?nYCvHcdUY4Qc1LYtc1aZJDP7/R1f41mMH0mVMcDY+1N7wP3WXjUG8zSeZ2KN?=
 =?us-ascii?Q?R8Gh3gqqwMVHwBB0r6YFU019YPI1d4X2+nL6/qZby21LQfhP7omSzVGXtzmF?=
 =?us-ascii?Q?J4JXX/Djot6ibeGOVSXhiX4zPxiPxOyixYlTZugn9ia4T6LT1d0Sm2e2l+1B?=
 =?us-ascii?Q?NF08hn5sD+MH/96pFypwBEQPhfp1SoKGqSarEkemJvCAZU1oRxioxEbjo6p8?=
 =?us-ascii?Q?u0yvHVDMj9AeeCvOi8mX8irJO5qiCHiWwhkl1XWHT5Tmq1DhxBEiVLCH9cRY?=
 =?us-ascii?Q?mP00NJPaQACZ1Q9xjEtJf1jpHoIR1foArikekBOCRTtO54qwaiFZkxCeiy9O?=
 =?us-ascii?Q?OKqvWjLIA/lFf4273Lnx3zbJZs3AjxOnAaZ5rMpf+TTryjTOkeVCs+jBxMXC?=
 =?us-ascii?Q?hhwb/XFGgikAzy/9CSLqDnvQHgMLroesQHoTz+mNFJnRh/TDJTjE3hgEdu1l?=
 =?us-ascii?Q?8lPcN18i0WxhjEK5SUSNcFZlkEkUq49uEAdqc+5oiRyr88ZE9CZArnAPxuTp?=
 =?us-ascii?Q?TjhBk8awldRehyVCTvlIeCqsg8UjXOsUpYGLi8p3qnreZd4GnI+8gb9tZDDr?=
 =?us-ascii?Q?u/kXLv+UqEHSOXoUXjVS8dD8WTwTA+ZyLcQDYytpnlREXdrZmNvSNZ8w5OPL?=
 =?us-ascii?Q?REuBSm46b7R2Si2sSYPvvPkPiSdRXWPEZzqgHxPFxDa+CE2ymbhH38wZV/1W?=
 =?us-ascii?Q?Naz1RCIUG8+keS2XoUhyH12d7/aeVCfQxjb91xQvOBKe7WS8MKqdIZitz0fL?=
 =?us-ascii?Q?bTaeYoZ4XWSH/bS2SkbebukGmJWzSBY4GkLgG/VQt43lvmZssJTrAgBc9bRY?=
 =?us-ascii?Q?IOw+6h8CJzJDDwEorPzXzFx2EUHzAWlcu4uPuIQVO6A4kc20pQc5ijaG463f?=
 =?us-ascii?Q?VrNsbcPxH/9r1BO2xEWCFfDKnIsFnnSwWbfxmXnP7SfWNAx9rdO+z7/lsa52?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f18645dd-5962-44d0-3a9c-08dd5cf14b80
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:55:58.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPvmvCfLfZq71ygr1DLlDtUNxcPYklDEfO6jCsj55Wyf2dlLscZp+5gvPZcz3ILqXSTaLIKGLkjLvtFah71/0xiYaAvUCPuBRpMBtd97hX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Factor out code to find the switch decoder of a port for a specific
> address range. Reuse the code to search a root decoder, create the
> function cxl_port_find_switch_decoder() and rework
> match_root_decoder_by_range() to be usable for switch decoders too.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 48 +++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 70ff4c94fb7a..cf58ee284696 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3198,33 +3198,48 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_root_decoder_by_range(struct device *dev,
> -				       const void *data)
> +static int match_decoder_by_range(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 = data;
> -	struct cxl_root_decoder *cxlrd;
> +	struct cxl_decoder *cxld;
>  
> -	if (!is_root_decoder(dev))
> +	if (!is_switch_decoder(dev))
>  		return 0;
>  
> -	cxlrd = to_cxl_root_decoder(dev);
> -	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	cxld = to_cxl_decoder(dev);
> +	r1 = &cxld->hpa_range;
>  	return range_contains(r1, r2);
>  }
>  
> +static struct cxl_decoder *
> +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> +{
> +	/*
> +	 * device_find_child() increments the reference count of the
> +	 * the switch decoder's parent port to protect the reference
> +	 * to its child. The port is already a parent of the endpoint
> +	 * decoder's port, at least indirectly in the port hierarchy.
> +	 * Thus, the endpoint already holds a reference for the parent
> +	 * port of the switch decoder. Free the unnecessary reference
> +	 * here.
> +	 */
> +	struct device *cxld_dev __free(put_device) =
> +		device_find_child(&port->dev, hpa, match_decoder_by_range);
> +
> +	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;

After seeing this comment block repeated, I am less enthusiastic about
this approach.

I am worried about cases where something wants to potentially hold the
reference outside of the lifetime of the endpoint. I do not think we
necessarily have those today but there is now a mix of "find" helpers
that assume the caller will maintain an endpoint port reference and
subtle bugs looming if that assumption is violated.

Part of the reason for the "put_device early with a comment" approach
was to not need to deal with some of the awkwardness of dropping the
reference in all exit paths.

However, the scope-based cleanup helpers now automate that awkwardness.
So, I would much rather have a DEFINE_FREE(put_cxl_<object>) to pair
with each "find" operation and drop all these repeated "its ok to
violate typical reference expectations" comment blocks.

So, that's a nak for this approach from me.
