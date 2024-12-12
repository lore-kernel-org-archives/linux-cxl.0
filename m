Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F7418732A
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033747; cv=fail; b=elxjQhauSrX0if8gneSgpBKRK/xR6Ki4Vlvt5FTxtoBZv39QNcVQzVmjsgnOZYGuzNiludZx0ThoFnjismi0UQci9TMPAJikkVpG/Ll9AbxHua4XmyjPC1mWRNyENPYFiqN1OJJOT/Pc1BaA+KnfbAhqFB5k7hZ4BLPSbnu9MbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033747; c=relaxed/simple;
	bh=PLCQyCqyOYTNRJb13l09aBAxUM2BMcLSwZeP3YZqKeQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyDfYnkQ2aYvhHCqvRRb59yCLx2VcbDUU/FB53YAryeFr7Ye70YNWFLuTIzJdD1OETCwFugqlDXItJglmrcz/vmCKmQfELBGz+qauLvdOtca6Tn7tfPuyFWYVddEdckY5tz4ogGXJ3MaQOc5ikqTVNz7XjEnWwExgpY0rGmI7ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4hPsJtr; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4hPsJtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734033745; x=1765569745;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PLCQyCqyOYTNRJb13l09aBAxUM2BMcLSwZeP3YZqKeQ=;
  b=O4hPsJtr2G3TV2sH+A1dIPWHHLgkiHcy1UldmSC82mtdw91xmVevb/+x
   yeVmeVzvLEAxOrwCiALdn9BN/EVCn8TKxlnu02WIbWbLKVf9wei/4x64g
   hrUOn29iyZ27vo1aq4glr9C+x0wx1Eln0ucj+eK0sx8E0nLcb2XzFmh04
   FToGnYS/m84J8Z8Vit/o0smfgMO85m0KyhZNf2VIfFEoFvBK0lQyoTLcn
   6Z9vTRupTN5+mAEOxd5i3oYUw9VI4Q9xXKv1oxHYxqXJbQEDgNxVeLUHS
   ObX00QDioK/b6sPJRx7AuTBiUyCVrMGSy1WpgpkUkvoFK86PTbmU48GBc
   A==;
X-CSE-ConnectionGUID: Au/b5URhRE+HozUeeWanGg==
X-CSE-MsgGUID: vWdkWItnTbirGx25AztDMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="52001239"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="52001239"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 12:02:25 -0800
X-CSE-ConnectionGUID: BxJxNMelQdCV+qCy7MRJfA==
X-CSE-MsgGUID: VD/5NTSFS3O86V2afBuW/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96222858"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 12:02:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 12:02:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 12:02:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 12:02:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idnymzFz+95dR7885r1vvxm+GnpBqZxYa12O+A55Qk3AyqE/+2A4nKi81PdqwnxHQpUUKVdPqw3GqdQJ+Tn5rIVK0+hbq0j0xLhEwJ7V9u7sEUlKhaVtWtkWzFJ0voIYf43eZKAEU5eEBdK8AzVTjn78z+qZUtirctycWJPaT46QrFFUWGGMd+/gsqrODtiMRoY6GQlB9O5Cz9cCQ39D9elpciGLHZq1lIvrC+xTBIFoM2n2nbLyAoMsfMVKrghVr5z5wdLW60m18IdFXslA2YcBNUA0F+ZHjc7hOW7k7dNbJaCbVToaXjaQ7ss8G0pqCJZcOSnTCm/ZFrpKgpQhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JMcbhATgUG/4i7twHWnQLFfiYpPnGfAqcK57JoJD30=;
 b=hBjk/T93fsdHB65j0D54WP5xn8rOHL4/hpoaI3ArMDhwSGxl8J/MvudqTGzRWvV7osJ8cS2gk+QdjtGDGPvh7/6Wp4YZrYTeUKwBlBxjKEwpKTHv4XP4uh+S/h21ghtjW6fMR5mi+y3I6YMrcgPzjCv9Elssthn5EucPWxlYMlBmUsf0kbAlgwAr+S/aerTR9S46GO+jpPtPTtq6H+uIPJ9CH6XW14WcwMPyP1YWoOc1s2w6AeCk62HBjSL2yMEzGClU6SOhZgLH3xh4eK9nsic3cra3MD7zdeq0ZJ+CHE3qh7FN74m5p8dkP82OHe7bdlvFYgJxK6qjNs+DBmbdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 20:02:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 20:02:16 +0000
Date: Thu, 12 Dec 2024 12:02:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Zhi Wang <zhiw@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Andy Currid
	<ACurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, Surath Mitra
	<smitra@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
	<aniketa@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, "zhiwang@kernel.org" <zhiwang@kernel.org>
Subject: Re: [PATCH] cxl: read MEMDEV_STATUS register iff the device has it
Message-ID: <675b414537cfa_3e0f629495@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241212123959.68514-1-zhiw@nvidia.com>
 <675b39f177675_3e0fe29471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <4f2e1930-bdef-410d-a9b1-3fcf6c46424a@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4f2e1930-bdef-410d-a9b1-3fcf6c46424a@nvidia.com>
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f04045c-0e14-4f5d-212a-08dd1ae7e061
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JlFwMVl9w4i/l6ZuvLnURi0e31s0zPtFqu/q/v3VgB1NbkNkWwK/ySu9pO3p?=
 =?us-ascii?Q?1MuOtsDIuODUJaqNA1BQdWUj2UvghFMiplBX+VgWNQ2HFSKfGgV+ZEyK6KyD?=
 =?us-ascii?Q?cmLQvXUy1Z8FIPk/huRkbyxHjPDdgsKgBiSpGzSqXojeYg2frn3ELK++ZSNp?=
 =?us-ascii?Q?lcgX3l7adwcrMSG4dfka1LWm0Lp2HzSu1LnY1gZHcJIZ7FDW4rmHTwJTKIuR?=
 =?us-ascii?Q?zl4e5Q9yYTJeTlo968K+QaENjG6le3w99PEx/nj54qJF8BAHLYKfDPhjDkAb?=
 =?us-ascii?Q?SEQVCB9nimriveaysezsBvsBs84GLf3g2K1sM3AMi4g8gdH6aPucWYf990zv?=
 =?us-ascii?Q?YQ3jP505DL1rlSmiaIf9pKDNTVkrADRTdqqFY1X6t0fUHKgGY5TeQAM2VP/T?=
 =?us-ascii?Q?mitI0Ij1L5oDhf+R96FH8ibetkuez8z0oAsMk/edscutw1HCTRgPYdsKcOQ4?=
 =?us-ascii?Q?V+AAdBiLromVCAQWLvzUPC4xUq5XNn9ig/cUQNKnoID3eEZSOxs/c1MBs81j?=
 =?us-ascii?Q?5lppweoeo81+AEQBFcjMuQIAhze+m9EcNo3IHjKh3OqW89EXt9Olgj8FBq5b?=
 =?us-ascii?Q?VhMz2N/yxtgBr70HkKKx7y6BmoEVzYp6XWeM+Roc9GVjwo3AolcL6EWBWSKg?=
 =?us-ascii?Q?zQ4BF0pEQ214vMTAob28gpwARUqRnMNbqhPeYvEeUOz8a/9MHhGivEATMsKj?=
 =?us-ascii?Q?OvU31CbzYMxa0enRtJfV7ktJ8UPtiT8B1DGIuB8J9bM36lzp63gS0IGt6Z7Z?=
 =?us-ascii?Q?mpyFvlNlfGBkezgcvo0HILiRh+aNOCeUGG1XSmdT5O6oGWFZrKQnwdkCTKoP?=
 =?us-ascii?Q?QlpnfcsB5x8dDLJUheYJn7l6WJdZpEzYhSftt9B2dPgp0c7Tl6hM+2uIwQit?=
 =?us-ascii?Q?xzzsL6wwP8UEtCbyq972yQara3O0fu4lLbP9GbLE4vvglTvSYwDZ6ENMCn1X?=
 =?us-ascii?Q?A2pZeht1g0ThIZpGHHRWP4V4Tw1BrvTn4RIwVexICqSBdS6cKdr7KrOkERn1?=
 =?us-ascii?Q?3Vmg82cSZ6wcFYGuy0HSNOKOOMijgDHBKKR6jTQIlBw+g/HJ35Ph1GgYwI6D?=
 =?us-ascii?Q?DrYdjch42EzCpcbTqJkKOewP1k0x3dE7fkKOb4G2kbt/UC6vWRtyrPEEia8n?=
 =?us-ascii?Q?mgRKh2kbI9PwDVdm9XYFgYnKq3uzaGgAAB6kEhmX1sDtrQSyTd5Ha5m/kvjz?=
 =?us-ascii?Q?rRcWJ70QRXfX7jyPketWxfT/P9J2Lfz9VRGmC0l6FEOudRMnEcERL4ztrtYA?=
 =?us-ascii?Q?D1dy6HkndWqeTP8J6dVbanqth9zyT56tG0nTjtXL2s0MkfN1SZXtfKMYpm4k?=
 =?us-ascii?Q?z8lAjct9RwZhvYU4Wk+bVXAEWhvsxRqdm83MFDHpdd1dLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hsi5pDOG26T9V0AHW/N59GZCgYqKGp6PmertPVpH4/CjjWlgoWaytXijCtBI?=
 =?us-ascii?Q?EX2QZAUA9n5pc8r8i8Tj1Be3MOV/Xw1TCIKpYG4jluJC3d+JBB/zm/EArJQ2?=
 =?us-ascii?Q?J806jmAv2Dd4ME1bT9nM++pziO0g1jEeK+vq+blvcCt7Np3Fv0n3bd0MBRsw?=
 =?us-ascii?Q?g5Z4uhUMxxScgSTThzeywuE+iDtWLgHgIF1thSPv1WuE7bOINrOQs4NFagt3?=
 =?us-ascii?Q?nOVKcFOsz7BM8ePP3f2uCE3ucPZnt0HDsCLpdMwNqi9PAKcpYkYAF34NUCqt?=
 =?us-ascii?Q?CjOkAPhpdGJVDmden4Bbr3mR4boHS6kh8+7fVI0XwBIk5SZPdTKQE2iPP+oi?=
 =?us-ascii?Q?w7zMkxymoaZKH6nnUzxBABOCUcqzAexxZT5eFyo1nKAQbQFzkTOX5LKleGCX?=
 =?us-ascii?Q?JdDoxyUYzmQaHkHCvudyrBzSvqFYeJdmE64I8h8/QLUVd0roVXgEYghUnYIF?=
 =?us-ascii?Q?AQSSl+Jcj0MGmHnHgSmipBQYz7A2DuZ+EU1U3xFjFjFNqNQ2/o6GxIRJTX/N?=
 =?us-ascii?Q?YbJeA5/igniq8KZT1KDYUdg2/iLJH8xGUGUcVmgNAOXwTscyaMqvIc+Hges9?=
 =?us-ascii?Q?iW+dLA9+T0AdDQukvKA9c9fb4cT80fhEsOAmPGAo+bLhPamua8L8NZmxEVU8?=
 =?us-ascii?Q?D3HqRyhUTrWAdV+QisAF5XJaRF43x7/4MZ7cxcCT9KnVVC8QqPH3L0WWSBkr?=
 =?us-ascii?Q?Pkl+wEvsb6dIGm0TK2iV/4dVM6nvf7mmxruhAtDZCG9gEif+YHXKTLti33RU?=
 =?us-ascii?Q?1T7fYjW3AV2VN+SR2DmkclEGUebQAuf2/+X6IaR3M+2ojGZ00o1nYdEKmfsL?=
 =?us-ascii?Q?mNElJTfdDr9BpaGHJtm7y6cJphIFs2R+7KAhqdf10R4l+D3fwLdVNfWH2rnF?=
 =?us-ascii?Q?Vt0t10oGeKG+Htg3reWsYhuVE9su8K2iww3N0ix/P3KzxKxtnb49f3jCZIS4?=
 =?us-ascii?Q?fs8B3oRTIc75L73dNHmj6nb3ILO1mF+84Ay6AXMac98kXjjotL/dp7u96a3H?=
 =?us-ascii?Q?pO10MKr/m4gzVOeKSPCqGNEDutQGXx+FFPxyKvyMB+qA36z6at93NK8wW0IL?=
 =?us-ascii?Q?U+oS5AQxfXu9Zb9LNRe5UbWHJusS9zSJS1huAtp4cOobsLf8jNnDDQdoKUmL?=
 =?us-ascii?Q?aVtf6RUP1ARpbDyuMSjMrbhWPkzWO2mAODHixuWzqlHzbKkzI3iHN3d9cIlL?=
 =?us-ascii?Q?EQRI/hoSt2f80Tr+96+A+ee5xh8FcntVAbV+DqegQat5T5CMBgHaQ6ykYiGn?=
 =?us-ascii?Q?X2n29IIpiDeaExnyaHaIoJNd7wj3k26apP6s/4P4/Vvj1dsgzhdWtRpjdsfz?=
 =?us-ascii?Q?EOnCzUTQGkWWUxSIJKV7yWQt2t3U+i1xvFP6c9HISKlpA2SPHBN6Og77ZJJ6?=
 =?us-ascii?Q?upVEo1xc0fJqzsipBFYLFvcAMe3h0cogbZL+ax5QNII9ftw4GOiHbEWItuAu?=
 =?us-ascii?Q?FU2yl5M1PqYdBgch1zlHF432d2R+EQcN2PeSk8d6qhEo6b6fHkTxjkLdx7hq?=
 =?us-ascii?Q?ixQ+tTDE0IYdLxjnjUWho9gOM1IKXklpctE6v8SA6P0YrwOuKGJFPEc2hT8F?=
 =?us-ascii?Q?LzWZy7IOFGy/wV1jw+q0uDG4C2Z5vcGllzKw8oP7JCfuJ22Yloyb4feLLTSV?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f04045c-0e14-4f5d-212a-08dd1ae7e061
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:02:16.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnJzHiBjW1ZZqmYmJvMt2APq4MKx/veOWqkiJzSN2E19YfZeJZl3eLzuwacK0SVLPN6pUnK2Ycj6GQ+fs2AEw8b4ubX6Dz3kH5AG9ABM2C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
X-OriginatorOrg: intel.com

Zhi Wang wrote:
> On 12/12/2024 21.30, Dan Williams wrote:
> > Zhi Wang wrote:
> >> Before accessing the CXL device memory after reset/power-on, the driver
> >> needs to ensure the device memory media is ready.
> >>
> >> However, not every CXL device implements the CXL memory device register
> >> groups. E.g. a CXL type-2 device. Thus calling cxl_await_media_ready()
> >> on these devcie will lead to a kernel panic. This problem was found when
> >> testing the emulated CXL type-2 device without a CXL memory device
> >> register.
> > 
> > Why is a type-2 driver, that should know the device's capabilities like
> > missing typical type-3 registers calling cxl_await_media_ready() that
> > has type-3 assumptions?
> > 
> > These feels like a band-aid for a higher level issue, no?
> 
> I think the reason that we would like to tweak cxl_await_media_ready() 
> to be usable for type-2 is: even a type-2 might not have CXL memory 
> device register group for the MEMDEV_STATUS register to justify "media 
> ready", the rest parts in cxl_await_media_ready() are still valid for a 
> type-2. E.g. MEM_{VALID, ACTIVE} bits in DVSEC_RANGE* registers. A 
> type-2 with HDM decoder support shows the "media ready" via those registers.

So I think that just means the core helper is doing too much, break it
down into, for example:

    cxl_await_range_active()
    cxl_media_ready()

...helpers, and have cxl_pci call both and type-2 drivers just call
cxl_await_range_active().
