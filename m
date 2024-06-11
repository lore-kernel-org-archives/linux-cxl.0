Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502D2F2C
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142662; cv=fail; b=s7tsf0rrLOrYYiuzEYvqkkW/qG5FvVi6VYusboBmL5nu2a5h4/imnXMo7gaSK7RuB1/0IcSAA2l82ieoTwMBhgO6Ynmv/50JDYgP0GjNTwErFtzhdtUQyc6ePFaSSfIFsPUT97JhnYoBQFBNA4sAiWRbeA7ObSojVW6xy82I5i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142662; c=relaxed/simple;
	bh=2pRLZfN6dvihx3T/GLW29acF0yrLacwm2Bon84oCzwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iqjP3KdUpgsan5JSnwyg/dnCd3oVltKEpk9HRpI3AxruTrSFm5Utlbt8NuIihConxVAGUVKJUAUclON5/nuvFIqNctz/ovrkHxxRZnoq9w3L0L8CwLnXQUvoozFW36oKaZ/UeEDMI+BP4KmLPQsBcRYXFvVHohU4FHcQRz0nSSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtYyHZdH; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtYyHZdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718142660; x=1749678660;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2pRLZfN6dvihx3T/GLW29acF0yrLacwm2Bon84oCzwk=;
  b=NtYyHZdHVAvnXsIGU9SMvTNJKcxuIfeiAHXtV0tr3Q5nuhKDzUlnVNP5
   ttjkePkIOQuNSwPOmOvBGtRNNpInhJcTTpfRv2C+T7p8JpnANEIqQFvg6
   8qRc2DN7DRtanq9xZ4+kK8AO7qYuOoU6BKJYbpPeg17RJlyRu9JZdgjyW
   pB5rRJontxrspcCfWyWGr9YdccmVeLPy7RBdIF6PLj5c+JWekmhCFovMn
   HVyVQM5XtOH+dmwYZ4Wslsf81LCEHTFffiCD1pDDz+BHbEvm+GON/++yE
   PN057cvgeRl9JOKMrvzXfT9PQGzdpbpu+b06Ny6r0L37bfK+Rj4E1gqfS
   A==;
X-CSE-ConnectionGUID: WnkS4gxsTJyBcxbNA6OINQ==
X-CSE-MsgGUID: D52/4T0jQcKkvn+kPP1llA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26288523"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="26288523"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 14:50:53 -0700
X-CSE-ConnectionGUID: zKy1pnlYSMOgujHDXoOk1w==
X-CSE-MsgGUID: u2HhljEOS1qozgSqDRuW1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="43977109"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 14:50:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 14:50:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 14:50:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 14:50:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 14:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngKbp9OD0FIV672vqSKt0Jw8hWJI5FolAXwkxpcCoZWTjgNE0P8bi8EjITsVD+qxJs2rMh5Q+ka6X0IYoW+0i3oZHBMMH7f6nonFXtW1z8OEXtmrg7KyqoBvjKZH7FSkSAr0fO765bbCzKpHfOR77ijTVDRIYFTLOBVHI0sU1qqh3FwvvGMAmzfJG4sdWhNo48x8d/9NFYUCG6lH1787abh6f0WpRQ9+Li7C1xXa/h9n3YHR4VoEzY3uf3mM3syYja+O3tuGkrH6WtMX2NO8Anz7NjEqY6mdUjN+J9KPs7iCLNQ6EjULg5wr6o83IR00yy0cQwCv0pqay0hWVB+22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8RJP92Cki9tuKkrNw1EjRM9nKAbHEAmVbQzCQGGJb0=;
 b=dYf/OTwS3PCeC3aV0dAFW2LXmTm77Vzcrjz+8zOPWAFoMWhokvX2XvBaGab8zEwnMGCItvIzPQDdmLa2SKKGtQ0Ty6EyWSBr/aIe6VNQYdwl4W/FbHhZPxs+gSKulFMqHKbHelyWLFPyAgpL8pgqQmt6SUa2X2EWyCEVsF5ctqKqBR9AVFB19W5l911sKbJkT9YciuoIQSzUSyppvqfyaryZKTAAsa9pTKDfpL63hYLprcg5PIok//7xZFh2VqrjvizTtcn3huEkAziP43GrxE9rza16KDX5vMMjYcjchg69qz9MEajr55aXDIJH7uJyY8bw+buTUzJoAj5sMpJdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 21:50:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Tue, 11 Jun 2024
 21:50:42 +0000
Date: Tue, 11 Jun 2024 14:50:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cxl/region: Verify target positions using the
 ordered target list
Message-ID: <6668c6b03abce_3101294be@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1715192606.git.alison.schofield@intel.com>
 <562c5e2097f32567bf7aa505d7952d9c068d830b.1715192606.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <562c5e2097f32567bf7aa505d7952d9c068d830b.1715192606.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: df8c3364-a4e6-4c55-17bd-08dc8a608a5c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MC1xovNpmTWsDD3y7qz+0yA+lFwWYVPMVPayl8fYNoA196/335RgC+/gMeTF?=
 =?us-ascii?Q?2HFhGNDWzs+jax+gOD913MIL2LRa6aFVyzwI5II/mAvs/cYtK2TCEZPYTOxV?=
 =?us-ascii?Q?qt9X54gvnO+tlWQGms/nPBHm7iqjt4S3e2IsE7VJ1Uu1ffr8dvesZteSE8d8?=
 =?us-ascii?Q?02+opYqFG7N5lWIrURi44hS+SfP/3gVxssLzknsYLvS3S5ecW9oOWUBLOnho?=
 =?us-ascii?Q?Lzjp11WvaFgxe8YtFUCWB1mmfTSO7Ki9MC5l8c/pQGlclGEsAuWfb38C+4i9?=
 =?us-ascii?Q?BAt65KZXVDpcPu3aGGnsASUYPRoAmcDtYBQZdpkEdYol165nlP7AR2Vzz4mP?=
 =?us-ascii?Q?XEIw0+YaU+hfo07pgslljWt1SD6CZ0zmOBcrJ7QTuuzi76Pyk16l5JvQ7M3u?=
 =?us-ascii?Q?Cj1cW9p++7eKa0/Hw5eLcooH2vsJJ2vOG5I0dWgxbZe6jzFThe1j+VMBHmnD?=
 =?us-ascii?Q?bDVgjQ4DbkaCR73lZZ6AbH+MKovDv8gq/gEr27M+6yluu4WEtbH/DWet/fSF?=
 =?us-ascii?Q?YruKoX3mWB2nkvD3FcU0b+8Qk4T6XbZRuBhxBGwXUeepji8ALfB5PFq1MBzo?=
 =?us-ascii?Q?sPwyj6l62E7J7+421E2h8rVVmBVxzCO63b1iBTZfiooX+YCWPX0JGK+R4qx1?=
 =?us-ascii?Q?lNN4Hp4kyScGc+YGuYiNzowNVOVnPEx0bLpqqUjKAG2CFsn9qRkB+LGbmi4D?=
 =?us-ascii?Q?NZ0IqfozOwGMZEpzY+ju25EE+Ey8fZeQ6JBBDnUI1ey2rduS1cfVUAfmj693?=
 =?us-ascii?Q?0ie4bJfJllB8RLtN7CdBwpHYxDq4U1S2Slq0EPqLOUJO5nSq8YL2wzYzLto+?=
 =?us-ascii?Q?rsOpkAR3fLakU54suH+aIsR3Fcko9cmlmLrEZNWlqUt9PDEtn81JpDZQywoB?=
 =?us-ascii?Q?INIMvVcvD44ZkEEGRSZST9dfn2reuwsLELZkhawfBM4aTScRlXzgeu7pAQ+/?=
 =?us-ascii?Q?9BYnE0ZL+aXxGUk/qylqbiaO3Z66pVum0FwhLIMZfMmTUE7zol3GGKMm1x/B?=
 =?us-ascii?Q?VSdgNr6FyEXpGfkAf6Xc+6cYUeQXXRnkvWYdUXL1R8IBR5wmFSdSb5hjSOxt?=
 =?us-ascii?Q?XZRblFl6DuUiMLay2VDm6g5zgn9Z92p6nDcEXPXprxh8QFwKygpZ8s7863fn?=
 =?us-ascii?Q?l+fGlJG99cIMx84RuXk82byhVmyHcrjP2OiS1gVoY4lHD5CQvRMAb+pxLjaD?=
 =?us-ascii?Q?N6PBsf8kvbhGhz6id4GVUqhWrxHZxyhwj5ggkCEF+WDWKtj5Wg8ijBQUoZfy?=
 =?us-ascii?Q?clNx8dzisTcbilZrTW5iQKNrMqetc4P6vXwN/dB1miGyDVuICpMxyBZJkAhU?=
 =?us-ascii?Q?cbxITMJyGy+UnuiEqDgmjqfT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APTRgUz+5f2lFrGMOqrjWlo74dZvgYwl2PL96XhU5is8xxPzU6dj36gdIV7t?=
 =?us-ascii?Q?y3xNxn7ZzbH6d90z56FgCfkK4yWlySkuhM7GcQSjAiUpOzdh4keHdKGtW43/?=
 =?us-ascii?Q?V51j5gNTi8rxlGj3iGGPC3zKhkg+QZ/kMlyOHvROJap44kZVGfpG7/9Y4rIC?=
 =?us-ascii?Q?3UhZoNF2M74qXSs47WcG8qkB88mXIRnkdmcacLxQwBi8ZjKHJ3UQpK/K69P3?=
 =?us-ascii?Q?jiSlq7nqzWc92PWkrTn1i0MeDcGemnObqi7Xps+5zYZuJA+TZFafF5NZ74ST?=
 =?us-ascii?Q?DACcP4/m/H0rREnAAjFH4UZMnK1Y+OPnonFpeRX31iK/zyQUGO4y9m2uVsCM?=
 =?us-ascii?Q?5xa7Aa5RMOJlCHz0gOiFtzJ08yVvddQ5Oa+m2M7ymocKuxEkmX86Zee9OjTW?=
 =?us-ascii?Q?n7Nlx2CNDPp9zUKcCyvyJG/1hYd1ZcB76FpPvpYQkzss3YZouZPnTRCxHJdE?=
 =?us-ascii?Q?Ef/Kbpen/mSyIeT+5aVjV5iIadD+z4rslepB0FiLozXgBdS6qKaq8262L8iX?=
 =?us-ascii?Q?fq3tNixYh03jtrxgt8irgwY1mwbkXIuJSWjajSiDKePuQUvzt2a3rYcBidpt?=
 =?us-ascii?Q?XFZj5H8976c9rbaCOtTr2siG9iKrKky3esa4P37nxSuZNfEZXqTe9bDcTKTu?=
 =?us-ascii?Q?/ygT1kO4deop5J1Iolei66YmKW1U6qcgJUZxsjZIsyC1QMD3wHVh0HVRbLFt?=
 =?us-ascii?Q?ezMUIoLKz9DOTxVGjm0B2/QZVmXAw2KLovfyLuEx+So5Z98z/d7g8h+f8nAf?=
 =?us-ascii?Q?kqJN2BjEjBoNASfJwl0FIz7lOENcyvJjVpkrYb/NRBezkBEmkt9zXxX3M8or?=
 =?us-ascii?Q?jKaWxRDNeKhZKN+WpRHiEio8RIVNyE6SQXsgi3iA4h4oJ/2xIdUk4BZVaYyv?=
 =?us-ascii?Q?vFjHIulnaEIN1NyfIcfOb1oZNZtfQr+zQk0UvZwKiv0Wr6ypi9+CMoteQfab?=
 =?us-ascii?Q?5WSP3ak1zwjtLClgCywtfawAVgUdGzR+Q3FVEVrQNaLN7as1lxsjUUZKAU3L?=
 =?us-ascii?Q?WMHav9+pwO8DLUtbaTCvLet1EpKCBV02l5o1KCBlh3MkIsAKZiftCHLRm/Uv?=
 =?us-ascii?Q?IE4pZfHCEbhWmz35rOy452c4k9s6uv09ResFyJK7xp/KbF90MRMKeDdUCrat?=
 =?us-ascii?Q?AFHq6ZtpW6tkQBnetoxq0oZBC37sejdQiTk0va8+xEsJegO7s03Us16Z/wLz?=
 =?us-ascii?Q?QkD1wvumW1Y1NrGf13TuyReYfY5FwRToIxS2yF5R6GOdHFU8VqkIniNFwnUE?=
 =?us-ascii?Q?s6JuHoV3XWwKHToXSV20UFrbwy1Z02cU3fOhV/eM2Q9Lt0FlJh3U9cAoo2g/?=
 =?us-ascii?Q?CHfAUsjq7wwJDccYym1LDK4Eprq6ytXNh9baF8BQPQ3yVatH/b12uTKnpoDv?=
 =?us-ascii?Q?60/R3sMNlRI2zHAGyf6aQLPHj1e5aWb5h4GhuZAzJzjA44obUtJKkYEtbhXa?=
 =?us-ascii?Q?YKnbr9ZuQSbz2jjXuB7JYNk5X3b85aHRwaMwrCCOmwD6U04vG5SzmgQ2Gu6F?=
 =?us-ascii?Q?t7UAFVd2OBiKxZr2518BkNCGmPQn4t4BpOyLVubiPVloIEeYwdA4nzFfq07G?=
 =?us-ascii?Q?ljUgU4mowh57mfWzFKjgN8PSFOWz3U3oKvARPtpB6SI6xXs8ef7czH8LeeOm?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df8c3364-a4e6-4c55-17bd-08dc8a608a5c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 21:50:42.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQyt86QlXe0sAlbla/DKHYrz5W+mMGXcJHR9HubKR+LNR5pFOAjzttJnEKc/PcY3vFY8B6O2Yome5M82qHgjSj6b3mnOMYCkoZ7B6+4S89g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a root decoder is configured the interleave target list is read
> from the BIOS populated CFMWS structure. Per the CXL spec 3.1 Table
> 9-22 the target list is in interleave order. The CXL driver populates
> its decoder target list in the same order and stores it in 'struct
> cxl_switch_decoder' field "@target: active ordered target list in
> current decoder configuration"
> 
> Given the promise of an ordered list, the driver can stop duplicating
> the work of BIOS and simply check target positions against the ordered
> list during region configuration.
> 
> The simplified check against the ordered list is presented here.
> A follow-on patch will remove the unused code.
> 
> For Modulo arithmetic this is not a fix, only a simplification.
> For XOR arithmetic this is a fix for HB IW of 3,6,12.
> 
> Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
