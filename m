Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EEA63CF
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307038; cv=fail; b=VGRB8/OuiVjEzWqATVE9lLX6GPlMV4NGlH3SEgA3LVzz9pv6GJXEWWmMEZ7O0Ea2B3ncMrN2530IlDyzhptCS5bhtAewectp44KDLBzVLCbTRgZ8oa0NE65iF2dHe1Gbm0RDGBQGD5PdS/yVi/7CrI1iz0LFoBh9i0NRIuRERQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307038; c=relaxed/simple;
	bh=fckOkt2uGDJW7/lIIZQzDXruFXkqWQWCnsF/MrBCbb0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LxG9YrcqospWltwsqTKNRcOqG+FSEoYeJxvPOL0SR/5Xqh9osmsOMjA1Ej16c/Bul8IZMhHHsK8BF+a3OjVd70GvsSiPx3+lRsCcCHEdZyf2P2GXfB0JN67Vj0g8Nwe7iGsfVDf4x5xgWPqUHnlwfu0xc+zP9q0VrP88UTQTWcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUn4KoPG; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUn4KoPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741307036; x=1772843036;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fckOkt2uGDJW7/lIIZQzDXruFXkqWQWCnsF/MrBCbb0=;
  b=VUn4KoPGDybvuGauwr3RhO4j/8eMdXJIM8skzglaTUqOKYArjlFJxZ76
   4PWVBHX+sZsPLAWLfTsfY5ZRAppnnd1I7TtFNLLZnJ+6+5PKrzK2Js43b
   sYn9KsrwjtCDO1ZunY7DDLf9n5/cLxQVdf1O4y+Tgg3Nia4RdWqg5UPoI
   oQ+HVRyLnxMFdMvhlHUulMk1eCFEImbKeFmPcbcq7lOvsZBnPLWqZ0RYf
   M9yA1BTp0Zwoq7+BuHkFVZzA+aYeLs9IijmDO63oi8JZ5Aqb+F1txRGAf
   zpynl5/F3WRTUhHO8JLjY6x6sy98IyLPb9GDAZTnWxKRBlDiNlvy5Deo7
   w==;
X-CSE-ConnectionGUID: iNW5LdWiTkqI2llloL3JJA==
X-CSE-MsgGUID: gtL8wHHNRZOUA3v88MGVwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42484499"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42484499"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 16:23:55 -0800
X-CSE-ConnectionGUID: OEpTDTh6RkmwLCcJikj0oA==
X-CSE-MsgGUID: EH1D7Y+yTq25mfDyixfbwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150109175"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 16:23:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 16:23:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 16:23:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 16:23:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXZWnNJdaMejsMwQnD8Z5ticJjd1Yun9upjsy2DC6q/W5jEYEZuXQ9Yt7hxdAkZ141WbSm2EiTrHiVfBl5QkJ7xpFezWTp7lUCv5zj6sxgVQgheM2A8SP/KJUFpY4d1J7d7AQisSSwBptbJHw3474JsSZfYgQ703tIYouxaWRQ3pndj7E70x6GehzUjlz9Sswg4bNJBggTPO5AdIKE7JHqrUSUTxSAm2atlHEAPmQMXddVsga7fA5iqnwSlSdSO3tlO3vp5sYsKm7pNnV5r51YfomLxE9AUsmE1fiEp3loYTxgsEGs0ZcwzXqYJyi6veghDUVrI4PNvfTZlvXxhe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5VNJxrZw7t7eGrrfBiFtB5RFfasDaoRYpMbeaOjKYQ=;
 b=nzjLuHrtQAefHGdEl9a8HYqaAi2l7qGT7ZZdR8tUq/JMhQ7uvvteQGU51JZMDehPncWPMO+cymFEju4O+5pVRY6JlyO4k8JvGJ5KsFnOZ3OXv3hCP0M8Uu9ktboAPajUtikK8Ie30wcCivFyYxr/6S4ZNw9M7XV3wbAWcRtjROth2Hzga/e5N2JPSmmC/EeQatyqX43eNzJ5LacGgNens9q26mbhIht0lu08RgwIKLth9ybndZgiNtBmdxKKjLbet2QwxbdWJgmPLX1EYAbGTffGFFDGn9TGLS1NDSw0PrZwQiZIn9Xh3k/h5h/YYMDo7+UAxTTOJQ3cvlimgo8lHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6465.namprd11.prod.outlook.com (2603:10b6:208:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 00:23:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 00:23:37 +0000
Date: Thu, 6 Mar 2025 16:23:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
Message-ID: <67ca3c87a1dbe_1a7f29493@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306232239.2609017-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306232239.2609017-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:303:b5::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 3574fa09-9008-45b5-e7f6-08dd5d0e4dee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oi20U9BJ7DAf96buCR8nrs9C7x4XCCPK8fJamfXzr2L4ic7i9GcW0MBRLx9Y?=
 =?us-ascii?Q?5fz4UIvth+rcETl6gYJn9bu2PBIiKDX0szyqoQAXmEozte7H6O2WyYngr5ND?=
 =?us-ascii?Q?ZaLPwMou12b42X+e5Vkylbrc+coqPj603GDtbjxVmBQTKdtlzWMsrFahzS85?=
 =?us-ascii?Q?LrGQjsI1LBaahREgbDXGwk49eA+asYu7nEfVoOzTY805CjcoTzZrIG1BLQKn?=
 =?us-ascii?Q?0SU34VMPkSjk2QyYLE5ITGdKtX/Ss6KUyy6CiuDDZcTUvQ5I0kyjwBU43Ial?=
 =?us-ascii?Q?iHLpZa6NpUkXaLa4N1FIZTI/lr68TVGl7ULa7dyivGexoFlyS7jnlsPbxLgL?=
 =?us-ascii?Q?ce2TRAiYepZaKkyuiEDTNLbcxISWqTh3K3bvs5cMYWdZp6K8ZTOc/F+YNeX0?=
 =?us-ascii?Q?qYvX5YZ4/HixdiUjlTZZpZPY3siNiylUDkqaZ6DAqTp3V29CRclzk7L+D+Pj?=
 =?us-ascii?Q?EZleMtsKrR6WPO/vYuB/rSLYTcATtLZupb6JOb87oqPxVmHNpUxOJ//kQF5D?=
 =?us-ascii?Q?eMeJ6Xdbp49VlSHIiZSCDDKcCo4ud5peI2NPOG5oi/OtmhE8ZAkOMISCPyr9?=
 =?us-ascii?Q?abywXj+GEpZKEyPBBXLgGuNOILj/4vmGXSCRnh/BcgK9XsN+8AhEGhr34tGN?=
 =?us-ascii?Q?3aaTmkm2mFM0zHk+eFSf/51PjJ4aJFSZphBvtYAXEWpsXPpWGXpr/yvJdMck?=
 =?us-ascii?Q?e095UTGQGYEKZ4wioRIRkv2m/ftkH5h/GhZ6TBI0g27IMiOwZJbISxtKK/80?=
 =?us-ascii?Q?dzzsb7hWP6K4omOD2Ilrkh/7fvIt0NjU4VY2diFthjY0Te60AI58CK3exJVG?=
 =?us-ascii?Q?GLgZZSFbJFBff2N/9XcmVHqgl3Ybyq5g55Fty8e6hlfcrJgm5Aq07qgxJBF9?=
 =?us-ascii?Q?uiW7w194zeY1NDylnuvR9hxJzFYCG6r91qAij8CWyfAYflplSsFdzhzKY2qP?=
 =?us-ascii?Q?FEqlhfSlOgjiJ254yqKB/YGCAs5QzLv5p0mxole12NXcO8LDN7vjiHoNjpQ+?=
 =?us-ascii?Q?GNG3Jnyh2AI5ZBJckIRX7241yEUJqDLOld37Lxe1DjspwhM0x51C2MOJNhzc?=
 =?us-ascii?Q?9WFIrxG9scpTKuLYkv/Wz2dO7oxOaw7tKXUsxqKOUw/8TbXEoWM0w35rfsp6?=
 =?us-ascii?Q?ONo9oZ6uh2L7qbA7RiKCyvBP6Vzfwd28GO/0CIKHHXU/zTXpTInEIvLTAd+O?=
 =?us-ascii?Q?kpgL0VeAjvspsV2KgJNmifyYiEPEfmiNTIOAXxh9PtM+F/gtN3Fcl/Cw4O4f?=
 =?us-ascii?Q?tVAP8TDB8SrmZRBEeSiflUR8UG1BC9yQP1RXKKFtHQ4kCDeHxP08hr3KmF7l?=
 =?us-ascii?Q?VYh1vDGov4zhs5RKbvJNKXATjEPLZqGxkJz2COtj4XIC/a8wQ4PfOPP6o7+5?=
 =?us-ascii?Q?6/OTZi2z59KU9is8DW/WcKIoflgq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hN7wbN7NOSlB/vVw6g/r1bTqilpFoA4AcRxSatnhTUQrOLSEfclFFWfpIX5J?=
 =?us-ascii?Q?KhSrn6IC4xP8CFVDMOj5XsDPqh6Px/B8+T6ZoD30tjY23ObprsBzN/jA5Ayb?=
 =?us-ascii?Q?P+gO1KeswQ/CuqvpaahFcwmSMlqCgFQVu/z/uZPjBrKVIdDakySgyX2hXAaC?=
 =?us-ascii?Q?veRMcq2Q1poC7EQdJuVxYuV7Lbe5NllAUjj7nSQP8iaYkstT+q1IMbgDf9xN?=
 =?us-ascii?Q?wAqcOwVY2oVrZzIjwlrt8Jc6nIVNcUhhWm+QUw+6xHTx1oOJBRGywmbE0+6p?=
 =?us-ascii?Q?gZckgJozI4qdRyhrldaV30NvsVEwCTXzIe1EeSF5UjQ9B/4B+BTB5XYKnzlf?=
 =?us-ascii?Q?BSnBpi49Sf9VXRL5jkBoKuA1OT+cVo10wotemQXgdj0m1km/cyJmwd+9zOF5?=
 =?us-ascii?Q?E/E1TC+eSM5mBXg0s1eEdgKipmbhfI17SqdgBWPrC9MUI0SkjYxsqovwn+S2?=
 =?us-ascii?Q?k7lW3li65k6nq4IY6dM45ZHUs6muMzH25ntYIwaK9mwTJjTKqM9e/dshC+7G?=
 =?us-ascii?Q?D9ssSzix2gRlq7iAXpxqksnclEjZaun3auEpm1ORGXFqELb4UjObWNHi4ieL?=
 =?us-ascii?Q?yIHw3rXsSULteJ3oHwnFq5WIr67C4KvChhGJYFArwMUUhwpH05/FgSthqGO3?=
 =?us-ascii?Q?jUjLOykzro6Sn/XV7tIORsI5U5uCt2GbXpy0xu7d75pEdLEgVOUDfvtPh85O?=
 =?us-ascii?Q?+LerrrAFrVzC0kBdnOxTtbk3ulhRKyoWVETUuGod+F6BYurgQMMkGbIZvPbq?=
 =?us-ascii?Q?8JnjYsAKWCq6z5o80lH/LIEnV+oM4ot5fFU9tePjolFRaCIGweJsUPi+9TWp?=
 =?us-ascii?Q?NftdTPVQ37orfhxlRFIUmY391w2pQgahcpEr52HNLMrI0/OG6GB5qV48FLrF?=
 =?us-ascii?Q?BDLwKc765981EleFTh8FBd7n0eupcSoyF6ATv2b/Q7zHsOdM69vSslBSuGvS?=
 =?us-ascii?Q?oC/6htYdn7iht8NogayDiY/5hNhaAGHofNTIoXwPuSZ/18zv5UECYe+vigYW?=
 =?us-ascii?Q?1QHjwbxWU45KC9he+AtynuEcBqxO4Qx2tfv3H2FJXG/gtReEsjMnqUxwW/pb?=
 =?us-ascii?Q?RvJCMTCXinJoRt6tMwIDUudCMCCP/z6tIfv3//2AD5z8ashnNUZqUR00fkJZ?=
 =?us-ascii?Q?R5STcvO03JdJ5lMZYoT5D7s6iL0XGyTbvBH1JmnDjjrWbxb2EzhwOEvNCjzR?=
 =?us-ascii?Q?aYDHH5If8bqq8FCllTyZ36qjmUCr1TZsZP4xkLS9p+r8IpQafDWOpq1ODsDN?=
 =?us-ascii?Q?dzEk1Y52y1ucGgtQfhu9wRQOwQ/RHsfGaN8BZwHSecynlpshtW19VokcldWE?=
 =?us-ascii?Q?25BN01HmELr0xscczbE2ygE0ZrlRVTVVaMS31OImr03G0z3a+hplFhnr6OxX?=
 =?us-ascii?Q?GicEbHrOQBIuB2wOzp8aqwTFfCy3XbhCdkKyoRj5BphLPX06KpNtZ4GWQgqJ?=
 =?us-ascii?Q?LNAZISgIPz8TESJHOI5x7/Jhf5u1Xfg+FWTQITbkOWzE/uueDQDMw4sF7tmr?=
 =?us-ascii?Q?ClACtdauVN0+KGuXFY+btyO/po5PIUnqf/aG0Y1hsaqWxYQbR7pEMMlpQumN?=
 =?us-ascii?Q?TvmNL5l3IX6OYIz74QxlYyzdzY0x5FO+3gPsbfsOMNk2KU9rVp5F93eLfZyG?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3574fa09-9008-45b5-e7f6-08dd5d0e4dee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 00:23:37.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTdgzL7epki148kt5cjhBJeM8d6K2UFVV/yNeBfREy5T1komlrY206O9u4PAayJSgJTciBzzOoVsF3et9wiwyS4cfrOyq5AazMjkbOxUzLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6465
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL driver requires the granularity of a region and its root
> decoder to be the same. This is particularly restrictive for 3-way
> host bridge interleaves where the only spec defined interleave
> configurations for creating 6-way and 12-way regions on a 3-way HB
> interleave require mixed granularities.
> 
> CXL 3.2 Specification 9.13.1.1:
> Legal Interleaving Configurations: 12-way, 6-way, and 3-way
> 
> Adding support for these new interleaves touches these areas:
> 
> 1) User created regions employing "cxl create-region" fail when the
> CXL CLI tool gets a mixed granularity request. That is addressed in
> a patch to the ndctl tool.
> 
> 2) User created regions employing sysfs directly fail at the sysfs
> store of the non-matching region granularity. That restriction is
> lifted here. Note that the driver immediately allows any reasonable
> 3-way HB granularity, but the region config may still fail later
> if the ways/gran between region and root decoder are incompatible.
> 
> 3) Auto created regions, in which the drivers role is to reflect
> the BIOS created region and provide RAS support, basically sneak on
> by. The driver ignores the root decoders granularity and assumes it
> is the same as the regions. The impact being that endpoint devices
> appear out of order and DPA to HPA address translations that depend
> on that order are invalid.

I.e. that is a bug. The question is do we backport a "fix" to make that
config start failing per old expectations, or do we backport this patch
to fix those known configs?

I would lean to backporting this patch so this needs a Fixes tag.

> Here the driver stops making that same
> granularity assumption and checks for an allowable granularity.
> 
> A new helper, interleave_granularity_allow(), is used in both the
> user and auto creation path to allow the newly supported configs.

Minor but the function is not performing an "allow" operation it is
evaluating an "allowed" condition, so I would have expected this to be
named:

    is_interleave_granularity_allowed()

> Another new helper, gran_multiple(), is used in sorting, target
> list searching, and distance calculations, supporting the new
> root granularity to region granularity multiples.
> 
> And, as noted in 2), there's an added check to see if the
> selected sysfs ways/gran make sense when considered together.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes in v2:
> - Allow exactly 2*ig or 4*ig in interleave_granularity_allow()(DaveJ)
> - Remove needless !root_decoder_gran check in gran_multiple()(Ming)
> - Update spec references to 3.2 (DaveJ)
> - Commit log grammar cleanup (DaveJ)
> - Describe param 'multiple' in cxl_calc_interleave_pos() (lkp)
> 
> 
>  drivers/cxl/core/region.c | 104 +++++++++++++++++++++++++++++++-------
>  1 file changed, 85 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8537b6a9ca18..cc2687407a3e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -532,6 +532,31 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  	return rc;
>  }
>  
> +static bool interleave_granularity_allow(struct cxl_decoder *cxld, u16 ig)

I don't like that this function takes a plain 'struct cxl_decoder *',
this function is only relevant for root decoders so make that clear by
requring that it is passed a 'struct cxl_root_decoder *'. Yes, it means
redoing the "cxld = &cxlrd->cxlsd.cxld" conversion.

> +{
> +	/*
> +	 * When the host-bridge is interleaved, disallow region granularity
> +	 * != root granularity with the exception of 3-way HB interleaves.
> +	 * Allow the CXL Spec defined 3-way HB interleaves that can only be
> +	 * configured when host-bridge interleave is greater that the
> +	 * region interleave. (CXL 3.2 Specification 9.13.1.1)
> +	 * Allow 2+2+2 interleave where HB gran is 2 * region granularity
> +	 *	 4+4+4 interleave where HB gran is 4 * region granularity

Only an Intel person might understand X+X+X notation topology notation.
Just describe these configs in plain english.

    Allow 6 endpoints across 3 host-bridges when the root-decoder
    granularity is 2x region granularity.

    Allow 12 endpoints across 3 host-bridges when the root-decoder 
    granularity is 4x region granularity.

The problem is that this comment assumes direct-attached endpoints. If
you had switches between a host-bridge and endpoints then the region
granularity is not valid to compare to the root decoder granularity.

> +	 *
> +	 * Regions with a granularity greater than the root interleave result
> +	 * in invalid DPA translations (invalid to support).
> +	 */
> +	if (cxld->interleave_ways > 1 && ig != cxld->interleave_granularity) {
> +		if (cxld->interleave_ways != 3)
> +			return false;
> +
> +		if (cxld->interleave_granularity != 2 * ig &&
> +		    cxld->interleave_granularity != 4 * ig)
> +			return false;
> +	}
> +	return true;
> +}
> +
>  static ssize_t interleave_granularity_store(struct device *dev,
>  					    struct device_attribute *attr,
>  					    const char *buf, size_t len)
> @@ -551,15 +576,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * When the host-bridge is interleaved, disallow region granularity !=
> -	 * root granularity. Regions with a granularity less than the root
> -	 * interleave result in needing multiple endpoints to support a single
> -	 * slot in the interleave (possible to support in the future). Regions
> -	 * with a granularity greater than the root interleave result in invalid
> -	 * DPA translations (invalid to support).
> -	 */
> -	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
> +	if (!interleave_granularity_allow(cxld, val))
>  		return -EINVAL;
>  
>  	rc = down_write_killable(&cxl_region_rwsem);
> @@ -1305,6 +1322,23 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +static int gran_multiple(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	int root_decoder_gran = cxlrd->cxlsd.cxld.interleave_granularity;
> +	int region_gran = cxlr->params.interleave_granularity;
> +
> +	/*
> +	 * In regions built upon 3-way HB interleaves, the root decoder
> +	 * granularity can be a multiple of the region granularity. The
> +	 * multiple value is used in sorting and distance calculations.
> +	 */
> +	if (cxlrd->cxlsd.cxld.interleave_ways != 3)
> +		return 1;
> +
> +	return root_decoder_gran / region_gran;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1336,6 +1370,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	if (cxl_rr->nr_targets_set) {
>  		int i, distance = 1;
> +		int multiple = gran_multiple(cxlr);
>  		struct cxl_region_ref *cxl_rr_iter;
>  
>  		/*
> @@ -1347,12 +1382,17 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		 * always 1 as every index targets a different host-bridge. At
>  		 * each subsequent switch level those ports map every Nth region
>  		 * position where N is the width of the switch == distance.
> +		 *
> +		 * With the introduction of mixed granularities in 3-way HB
> +		 * interleaves, divide N by a multiple that represents the root
> +		 * decoder to region granularity.

I go into more detail later, but region granularity is not relevant when
switches are present.

>  		 */
>  		do {
>  			cxl_rr_iter = cxl_rr_load(iter, cxlr);
>  			distance *= cxl_rr_iter->nr_targets;
>  			iter = to_cxl_port(iter->dev.parent);
>  		} while (!is_cxl_root(iter));
> +		distance /= multiple;
>  		distance *= cxlrd->cxlsd.cxld.interleave_ways;
>  
>  		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> @@ -1369,12 +1409,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (is_cxl_root(parent_port)) {
>  		/*
>  		 * Root decoder IG is always set to value in CFMWS which
> -		 * may be different than this region's IG.  We can use the
> -		 * region's IG here since interleave_granularity_store()
> -		 * does not allow interleaved host-bridges with
> -		 * root IG != region IG.
> +		 * may be different than this region's IG.
>  		 */
> -		parent_ig = p->interleave_granularity;
> +		parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
>  		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
>  		/*
>  		 * For purposes of address bit routing, use power-of-2 math for
> @@ -1446,7 +1483,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
> -		    cxld->interleave_granularity != ig ||
> +		    !interleave_granularity_allow(cxld, ig) ||
>  		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
> @@ -1675,11 +1712,12 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int multiple = gran_multiple(cxlr);
>  	int iw = cxld->interleave_ways;
>  	struct cxl_port *iter;
>  	int rc;
>  
> -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> +	if (dport != cxlrd->cxlsd.target[pos / multiple % iw]) {
>  		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			dev_name(&cxlrd->cxlsd.cxld.dev));
> @@ -1811,6 +1849,9 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  /**
>   * cxl_calc_interleave_pos() - calculate an endpoint position in a region
>   * @cxled: endpoint decoder member of given region
> + * @multiple: the root decoder gran as a multiple of region gran
> + *	      Typically enforced as 1 except in 3-way HB interleaves
> + *	      See gran_multiple()
>   *
>   * The endpoint position is calculated by traversing the topology from
>   * the endpoint to the root decoder and iteratively applying this
> @@ -1823,7 +1864,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
> -static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> +				   int multiple)
>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1869,6 +1911,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		if (rc)
>  			return rc;
>  
> +		if (multiple > 1 && is_cxl_root(next_port(iter))) {
> +			pos = pos + multiple * parent_pos;
> +			break;
> +		}
> +
>  		pos = pos * parent_ways + parent_pos;
>  	}
>  
> @@ -1883,12 +1930,13 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> +	int multiple = gran_multiple(cxlr);
>  	int i, rc = 0;
>  
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled);
> +		cxled->pos = cxl_calc_interleave_pos(cxled, multiple);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably
> @@ -1916,6 +1964,23 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> +	/*
> +	 * Protect against improper gran mixes on 3-way HB interleave
> +	 * Expect decoder gran*ways == region gran*ways
> +	 */
> +	if (cxlrd->cxlsd.cxld.interleave_ways == 3) {
> +		if ((cxlrd->cxlsd.cxld.interleave_granularity * 3) !=
> +		    (p->interleave_ways * p->interleave_granularity)) {

When switches are present p->interleave_ways and
p->interleave_granularity are not relevant for 3-way validation. For
example imagine an x3 HB, with x6 switches, and x12 endpoints. The mixed
granularity is resolved at the switch level, not the region level.
