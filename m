Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8461F667F
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015811; cv=fail; b=CDF7q8UhgSYTNebjTLSQ1OHlckCMC+LudpbjwJJoYzMTcf2xWMtysFJ9sqJ74nCiQ1NnSxR8BsZgeqOr3b5pE4AG7PaE4O4WSHkhgbS7yOQi6Egv6261bjp5x6mY2o4S/LehyBDNinuALYsptg3bLb0+WVbDvEPsx5W9zEld2Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015811; c=relaxed/simple;
	bh=6KM4GyEu21VZoGaCPjPe7Hih0b1dub/itIxELcIqK4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ho47xRgDFwaTkCYpFuOEzfOwLGOyyc+mGG3PXjKg7uUxAKNNRu/oXtbEfiXqCrPn/C3svB7GeNtKE5Xwo43Nih9hCJ/cUjOCshJC7xRvHWkINPoI6pYjjBBd1gUZH+ZMs4YSeYpHZCgXvluO500gQ2ROchMYJumac9WNR+Lkz+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIevLvYI; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIevLvYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729015810; x=1760551810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6KM4GyEu21VZoGaCPjPe7Hih0b1dub/itIxELcIqK4s=;
  b=gIevLvYIpIX2HqZZtUQrbVQ2oexSrZDTs2uGwNLMYcNL8NV32nmq0zYL
   hIf1W7X0HrzMzZfR34QdeNXjoPop1dCe65y8h79p/c+SHIWf+szeZRcPj
   jTUCk8/4Okda9ZH9usGbvdMG5bG4BHHY5cv4pLuTfwrfGDC2dXzMYeL8I
   jioL/uEyErT+YD9Dc/7qNufZeQEK+vh8SxMR6WaYNZ+u57n8iqstJ8LDj
   3U7q72E2wklgPF5TRTRBgWUTm4ulIF1GmOdhk1+ogrf+9LB9UlADEZ1KC
   jdME4q23H6CJGgT1jdRiQU/s9TnN2ID9+MIw2+ggxQfG1gwdwhqYTN3Bl
   w==;
X-CSE-ConnectionGUID: RJK3LkFhQyWK8qxA6kXSOQ==
X-CSE-MsgGUID: jXa6N2dBRE6LsENSKIY4Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45904404"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45904404"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 11:06:59 -0700
X-CSE-ConnectionGUID: QUZKh+ccQZqee7PFeOhi9Q==
X-CSE-MsgGUID: 7m3M9sLnTyWEqGYSzTkiIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="81953154"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 11:06:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 11:06:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 11:06:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 11:06:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 11:06:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0dXhkioFZ8VquMj+kZlXGFUsrT/Z3aQguVHwTJBt7FRK8CFd4LHGSHrh3NKKXFuDaaqpDra3CW4S6WyIzjrYPMW/oAqn3UI0hXkUKLhDzGU07MIpt07s4S5Aqzhcu54vd6hCLEhd+aOSt3/a4S9UaXUp050TU3xYzWnrXmt1uT9PcA8So5TkjanMRoDkkcQdINv3HnPojR/wmAHaQbODzU/Hh/F6UC3Wfu8xydbavl9fLmhhmJfhpBML49HNzImmM0iNH4xG/X8iCbBJQfIcZQHBlQmsOm93yEO9YkYAQZhAewAM0xyyASQvELYe/zLQyqp1LpcIL3wkloKnxX8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PI7v0sjxWUJkNvbJvKDl7V5bHwIbiNczVQx6ddidSQ=;
 b=PGS3I4W3W7/l+CUQjgf3UuHWqK556fry2d7bx6pHuBttcPQcSw0DZ/0MHATLFOioq761jmywsejS+BgYwXARQDC+97peB7FHX0g+aWyqB/TSJVDFTbQHo8MnVF/HsKArcoZgbDbqgJeBijd9GTeByJDZfXnaxesbj61Z2iXLYRpoj8VLDmiYc3YhrUnMKEtHw/V5hM5DjxaWBbfvLAD5PubCLlXNUVVay0MPNFjMlUPLc3wAxk8BNWQiMQ4j8ZR/HGXfrEjyBh9MdX3ZTmzuPWLJZDHfBuORx0I2O7Hy11S0lBTFWVIbxVaRrE/qQXMefmsBIcg9uwbTUkEMiAVAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 18:06:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:06:54 +0000
Date: Tue, 15 Oct 2024 11:06:52 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, "Huang, Ying"
	<ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: KASAN error when insmod cxl_test
Message-ID: <670eaf3c9f1d8_3ee22944@dwillia2-xfh.jf.intel.com.notmuch>
References: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <04fb47fd-0114-48c7-ab8d-e779924f489b@fujitsu.com>
 <3f7e276b-bd2d-4986-8953-cc80a851304a@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f7e276b-bd2d-4986-8953-cc80a851304a@fujitsu.com>
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2cca58-5b87-4aa1-08e3-08dced4426d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rOQhvTkt9opSwqPMMUszpuQ1eCul9xTLk4QIvrhn5vaLRc4EHMO/l57+mnVr?=
 =?us-ascii?Q?Yliiq7uYNMwCFMKWv8CNe2GOGdc0D5uInlMQ99g3gM8CBKRjqikCYBeziM8h?=
 =?us-ascii?Q?nJJ2j64fYfhBYdPNd3tH1/4yEK18uGNuqP/ZWNUlaDuRqGFg9ZAmrya4t7nk?=
 =?us-ascii?Q?bUPwGD3ac3EOAQjCooKgR0R+IF+KbnWl3+y0ZJwl2anPWq8VAUjSLSnkz5BH?=
 =?us-ascii?Q?+d9oTAKi9O600ym1Iqv94w80NDdwwht9K/Uptpej62ELgfypjGtuN73kDsdQ?=
 =?us-ascii?Q?5bOWff2pn5HMtDgc1VDS9Bqp3i69vxxB3ZRD5ZDuKjsx7BmDni61as65lusv?=
 =?us-ascii?Q?vE+fxi4zwFFRgRy6pQpELfkT5vy8z96y5j3P0uR13NBOTvvnPln38nDgjM7L?=
 =?us-ascii?Q?RAjWhPvG9MwXIVIGHaihTXd/8iE53xMvhTMxcba3yjb7jPZWq+4SjaaJwwqV?=
 =?us-ascii?Q?CDckMDdnC3OLhhaM+1wIrLGovdL+NxIaKEYaRvZmH07AP4WdPz6aaPZHTemQ?=
 =?us-ascii?Q?pM5pTw+8w/irDeZR2dWgJw0rZ43C7RH6EOhPz6O4aHvoIVsfVBtBKP3l0Iln?=
 =?us-ascii?Q?2wXPYq/xaFAZKV4OMKvLUSxREQwTJH4UjCS0YLxskoiwkQZ1r1y2BPej48Pk?=
 =?us-ascii?Q?GrHQZEZUoVNiM9gpaRrX1qywedYQIkvUQDASY7RkSc4aP38cgJDsOOb/pDAQ?=
 =?us-ascii?Q?KZq+mXbyAaoaZ2fr4CfPIiJ9Eeh6c2UJrnJ4w8FfA6ul01qXAytCtmrxsPkC?=
 =?us-ascii?Q?740N9/kkzQh73EqY0TMt2DhQS7Jur8suOH02aa8xuDFnujBEu41BBTCC0LXJ?=
 =?us-ascii?Q?xpK+5omvxIfnu9rzzwAEoWdcz0OiiUnP+gNk3YghZ2ITknzWwwjdqMzTMX0R?=
 =?us-ascii?Q?4BTVpVjlFs4kUeG5m9+TlqtX+ABiYAEgeaknTZkDwGoyC5G8xUA0aa+tpDJw?=
 =?us-ascii?Q?CAxKYymJcNmimu03KqP3fiSeUuHFzlx02uLkhFwyCCCgP09OlhX/xgGyN4ut?=
 =?us-ascii?Q?Ny8DcvM2n7jWiAODZpeuN3x9WLvuoCINYmhSwzCSiduyeQrJCNg4eUu0WuYB?=
 =?us-ascii?Q?0ErUByoEbcIPgKs1Uv0o3Uhu38mBh2uzr4e6+fYMud9XMrDcRTw1swN/7BYH?=
 =?us-ascii?Q?IhVkiIdzf6HaTWyT98YuiaBvxc2Y58E2pVy6HCegqahY+n1WHF6iLmEdBRwY?=
 =?us-ascii?Q?wOoPoOk4WTQW48SMWhJ1FqfsWddHP/yZHMr1L+0DjUEsJhasgwqer/zY+PUP?=
 =?us-ascii?Q?t7CR+cnRMn7hYy733miGFhlbXBVoyI2HWOO0E+QOuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYpa1MkM4c8smbgw74KXUBanmdV4p9iYUmkp8nDET0XKla6shzaRn2tp6tjt?=
 =?us-ascii?Q?58BC3afGHuRCh0L6MkiBcr+1KP2Sxl3EbD0OCgJyIcFL5c1Q+y1Yugwb09kk?=
 =?us-ascii?Q?PmghLJgjpwDspZi/tAsVjgqFGccdIbGdShTh9GjmAmNCi0/0jcyG6Wni4dxs?=
 =?us-ascii?Q?2DRLprRBv2LAN00zWUmtVJ+rQIJr7c3eL+Q+4WGURMGcXCWg4Wv1kjscJSnQ?=
 =?us-ascii?Q?g+plJri1nP68r9OE8C3qlg2Ss+LpPU2VGiOcO8aXEX/ItDnxdgccm/D9J3gH?=
 =?us-ascii?Q?l/D8pSixna7emeUka4M4YqejwRhD07QUZHr6QJMydWdVZZZnLPby2PVipQ0L?=
 =?us-ascii?Q?GlztCE3xzGfqRwukrimzsq1d9i9QawORwfUsrPFfzlIviMFcPF0WPNLUV+LV?=
 =?us-ascii?Q?bSHsbLfofZVDWz5ObgSpC9m6UKIH+qwgAlHbTyHB+UflxacdCuKdQnaLPM/Z?=
 =?us-ascii?Q?OD/vlFSErg56uY2qTEal7PrOsvFy6hYWWDrRuxm3A00tGLzCXiFY7SFzWpCa?=
 =?us-ascii?Q?R1mP211u1u4sJaccGotNPK/F3B+Y4ohbHm58f/gd/LE5dXcGsZLEVkk6cr+s?=
 =?us-ascii?Q?0XA6S4XjTMDgI1nB1BP1vQW0O/OOxelBTKLGRSw6cHlQ14HUq7DSAy+wYyMD?=
 =?us-ascii?Q?aD7+jGTuuCjBoMlZ0mQ8nOwAx5sjgW50vAS6vnPNqH+fpWsejuah1erUP33x?=
 =?us-ascii?Q?/UktXe3WdMhnWkAfC2OIwFhAu3sUTp6vjwwPcPAElebiOpeHWyDDMK0pfqMo?=
 =?us-ascii?Q?62+UJiJJAh/VZoiwiFxMSeAxiYdLAr3WII4wr93DWHFgfl+VWxebYotaLSX3?=
 =?us-ascii?Q?8FHbqceP/Pzrdm0t2t8UCl1W0gGnslOa1JkOi9sqjk9oYJXbA+ulcqXLDFsX?=
 =?us-ascii?Q?eyLhZUGLrZERE4HbM14fjdTAcP0xtVM8zNvABuLTc94nAgneh/VuxdYzbtba?=
 =?us-ascii?Q?FjALvDukOTUfnWXXw59W6s22/pQChmeFhpcf6kNbK95ez/QYXTomD2jQgOV1?=
 =?us-ascii?Q?cvW5m/UYt9tvEi0JWzSzNwsiM9+iLnJ49ZS+Wv0+KMDYjop++JmLe+bFQ53X?=
 =?us-ascii?Q?3bVG2EsF5dfBKrds8FpvKg3+7YDRpR8SMwmVr31uYnqfN49TtoE9xuf9WDT9?=
 =?us-ascii?Q?rsO7jA4yvmYw99BD22Op8JP1RNgGjzc7LJEIpG3DQxDMLI5yjdpJAXo+0sMY?=
 =?us-ascii?Q?7PCbQpNvDzrIlzO0h7MZ2jI0poxLOa/a6WRZID9fRywJh2Vm+8UR6SlZyNwp?=
 =?us-ascii?Q?mdFMRtGG0pNSCa8kDyEdfhaUizO/BpVclT186ruZenyrFRfkMXTIQlWGEwsw?=
 =?us-ascii?Q?EYdFd289ahCQ1ETaVWnKFEduJpsiJMeAuh+aY/kSL9Ifz++O53FsLsmTY9ac?=
 =?us-ascii?Q?dh85kNljOFGiy8Vmz5tg6Emh2WgQXoMixqtCsmvunUbbA5Qs+1uBvBHY9GGE?=
 =?us-ascii?Q?A/9Cs0JpGakEf1/znRzK3sP0HWwrTWx+2DaxsvLooZWriF/Dtta1AZy718rr?=
 =?us-ascii?Q?4cxVwZkIVtqier7WY+fCVgkkUAOB88pkZc4kDFeSWtqVksx7CZcv9DVHSpNU?=
 =?us-ascii?Q?kCmmom/Eyt48AvXkO5Xet5b6dPEU0vHMPcwYVopQWcpINSGIUa8o2arrqoyp?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2cca58-5b87-4aa1-08e3-08dced4426d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:06:54.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKtgrQdkJZCweaYK/U3+gEvTyZigCjq4KzaIMXARUwnZct3n1mngX6P8zhxnhyO7dRC5v1HkyQJX76SAaOVrIN9USNdT3bcT8UftYHN9dOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> 
> 
> On 15/10/2024 16:39, Zhijian Li (Fujitsu) wrote:
> > 
> > All,
> > 
> > I encountered a panic with similar calltrace
> > 
> > I guessed I have root cause this, it was introduced since commit
> > 
> > commit a5ab0de0ebaa65e0a75ec0761a2745c66a9d17dc
> > Author: Dave Jiang <dave.jiang@intel.com>
> > Date:   Tue Sep 3 17:11:51 2024 -0700
> > 
> >       cxl: Calculate region bandwidth of targets with shared upstream link
> > 
> > 
> > Which calls cxl_region_shared_upstream_bandwidth_update(cxlr).
> > However, the cxl_region_shared_upstream_bandwidth_update(cxlr) works on PCI/PCIE device only
> > while the cxl_test was implemented by platform device.
> > 
> > I'm cooking and testing below patch
> 
> 
> An alternative patch with a mock,
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index b1256fee3567..ed9f50dee3f5 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
>   ldflags-y += --wrap=cxl_rcd_component_reg_phys
>   ldflags-y += --wrap=cxl_endpoint_parse_cdat
>   ldflags-y += --wrap=cxl_dport_init_ras_reporting
> +ldflags-y += --wrap=cxl_region_shared_upstream_bandwidth_update

I prefer this mock approach, thanks for tracking that down! Feel free to

>   
>   DRIVERS := ../../../drivers
>   CXL_SRC := $(DRIVERS)/cxl
> @@ -61,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
>   cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>   cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>   cxl_core-y += $(CXL_CORE_SRC)/cdat.o
> +cxl_core-y += mock_cdat.o

My expectation is that all CXL core mocks land in
tools/testing/cxl/test/mock.c, other than that this looks good to me.
