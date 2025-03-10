Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F41C5F1B;
	Mon, 10 Mar 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631274; cv=fail; b=AaGKOoi226RcxvTJzw02EkYLwQhXBmyEZcwnAH78Q6slgrieThXUPtB2g67xYFVaHWXlNR1xXepVSbEGnp8g8J62Ex9vfNhGcFEOf+paqT7Tdk+ODuZx2vK8OZWVds9Ikse1Y4aaoSv+TV2ygs/9cKaqOsb3Zx10ZAVpSf6ameg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631274; c=relaxed/simple;
	bh=0dVRfI6r9bOBo9WN1Dg8rIh9OH607gnuLgWgwL2d4dg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u/m+II1JCc4n5aUdJiWeAqr3OTNFMr0lzpYqOa4ghTwqhW+W9rv8E3CxQ+mHjIkaTWqPsMh7yfgAIiJe9x1HJdkwGXoThcqPJGpBC29KG8Xh3cvvBkP6m4m9HPCCoraWmiP19cjyYWuHXAdVogKVsNCLcyCbnwReXlabaODFadY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXhawafU; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXhawafU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741631273; x=1773167273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0dVRfI6r9bOBo9WN1Dg8rIh9OH607gnuLgWgwL2d4dg=;
  b=jXhawafUfBs9wQUrRD1KeDqJuYwZr21sk0jaS2S25T/RC2sietBw9x0N
   4L1dz3VpR9aVMwoexCniptHURQIuvXxoRjlho803vNquva3BpBtFlCRYf
   qk6WNnTNboPjL6ISvwTUkTvoVuo1MR0EM8S4YPOoTCdo1e8DHs0x/keY7
   0oTbiVqjrVt6FErumlF70FJRbVkabviy7M/sK4FBOyLEXO+kMna0k6rZ8
   LSAC7LYuHvJy/3eTDmDLntHWE8DNYdkQBX3gpyybhgCAoeIFg9bkTpUZH
   Hn5uLhpUKp+A3VWxmUb8uPbSSC2zy6UlFGn/ayK+W792ZNyFDU0KZu3Wy
   g==;
X-CSE-ConnectionGUID: r4ZdMZLWRA+sTmoEiTwX9A==
X-CSE-MsgGUID: yxfGpjvpTt6khk4mv1a/sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41809606"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41809606"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:27:51 -0700
X-CSE-ConnectionGUID: PVw0BD7xR0yfpoJgp7K4qA==
X-CSE-MsgGUID: wrs2schxS+qqmEIs8Zxouw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120964212"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:27:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 11:27:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 11:27:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 11:27:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUj04HLkZQcmpZZ1pXitk/Za02po/0+3ItCCzYMXQyFKmAle99aoE1j2c2547X9ejwefPeMDkF64+YQqyNR9ShRvfuRsVXATIVOX1mEriErHhzq6SGDpYxuzPinsVjanfxauJYBZwpFA4nhzc+RMFkAqtZXmzJai+itWISvJope+6PuVFAhqrS0gqbdOoGAXJkOpZEDv8Q/j/MJkFMi47RHrCkYBoZZZUTfMOMT3JzFK3ge4dy7ZMaD2jSRWNaEGNDqQtlUPbekxiO4tCjeKOwjqyk9lVI667IUosqzgp12YXnEoBOhWP/NNhukZ3n7nzwCi6e3ZH8epzeTiD/j6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRaprUOQo5K+7BN6OUkeJZhFx5iKyaBRneQiaMz3ytk=;
 b=j85E9sX2rAL9gyfBxuoJZjezml63bCntg5/4QvOjB3bKnjzWFVlNCbfW8QFjDC8EkAogUHM9kFU1QTL8jgIDtJwSgzSzxO72cEc2D6TAG706osVw/efUjhMXb5daBpBrhpQrk4yxpt67e+y4e4bMIoCFsSOyy/mfqRxY63h9H3/FFclHu/r/YQR19C/nE28+nJnMut+CCFyqs4AzGfZ7yr+3kRgV8kCSvrJNPY1FKkWckU98QiD8o7pN7TLD6qycSdvgt3A9eeDbH3zAG6M2BAUUfVPQ7hNiLeyQHz6cyGZEjrdSnE5OIW90UPWyuC9QW2Mr4GgS9AHD3IU0ozF+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7916.namprd11.prod.outlook.com (2603:10b6:610:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 18:27:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 18:27:17 +0000
Date: Mon, 10 Mar 2025 11:27:13 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
	"Jason Gunthorpe" <jgg@ziepe.ca>
CC: Arnd Bergmann <arnd@arndb.de>, Robert Richter <rrichter@amd.com>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>, Masahiro Yamada
	<masahiroy@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: fix FWCTL dependency
Message-ID: <67cf2f01dac80_11511294e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250310135119.4168933-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250310135119.4168933-1-arnd@kernel.org>
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f464aad-ff4d-43ba-c51d-08dd60012ff5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HEp/eipB7K7sayJGwneapVMUVwJ7At6JPTMG1OmfwtLQo2iYZtCa0yYG3X4o?=
 =?us-ascii?Q?Oq7PfLeqHcBU0YVIoqQJDIWLWtnYgijT0y8IYbxj6AcM1+xlqA0JPkfS7+Mi?=
 =?us-ascii?Q?EiFZVDFi/6D3M7W8dR56XYpwMxHuW2gLarGuNPP1mweQAZgc0kEpGwe00we5?=
 =?us-ascii?Q?e8ly3JevZwEmpsVu5Bi/BZqKSJbbQ6UD4oy8nNEY29QgEqiZk5gbn11adXt+?=
 =?us-ascii?Q?6F7ZTRGOtU8te4szCSpGsqDIYAzU+gHyJNIwFMdSmT+uUyhvcLrjWjwxh0hD?=
 =?us-ascii?Q?6EITzVeqv3d66bX4ruLytVeBzK10+ZW5Fh1nrkotBaj2FnN7mv0TRGRR6FcL?=
 =?us-ascii?Q?goDmgw2GPXhO0QWLdKC+LNuXVzd8B4b+Ug+YiGfmUQB+qA0qFgVoj+tWz2YN?=
 =?us-ascii?Q?NzfPWFRbnH4kqZGTOMaBXfz68xuVhPWz1K1b0VAmwX7lIqzu7UL11EthEou4?=
 =?us-ascii?Q?IPbPw1WZ8Kek/IR+0uMoZ8e4suQKuJM6lRCEvGV731zwwVBCTWvDzxCzpYNH?=
 =?us-ascii?Q?7nqu7uqxXHPvYvnHDjgL6vQPUg9IJeyVqpUIRdU6zfxWuVTKP5/Ea6NspCCq?=
 =?us-ascii?Q?wu22WN3gOPXCj2fEggJcGlYaR3HfAnvSpamSfbZJmmLGmRC5vn3ur1EWyvzF?=
 =?us-ascii?Q?Q3FtE6MzSB6qIX/89uiz6aVkwcIR8nTsNAWTlj/zfceuSSpemSKCjiS4Izy8?=
 =?us-ascii?Q?p3spI6bRppPBQ1M+EclEBau+BMWF16CHdwGokVbiaqJNTTPNxfJXMDmwmbRo?=
 =?us-ascii?Q?LbV3Oy+yvXei2IGlGgaIwdfzHplK5zLpoxKpe2306DdykpvH03fMv7xLcRHC?=
 =?us-ascii?Q?zKrQsSIGSVd3Kxj+e4kl30hbh057MtnI3vdPdSVu6TshSbLsq6fxawENre+Y?=
 =?us-ascii?Q?yegzRSZcdE0EW3SSiZipWjyJsgvIC0YaLwmYGda9LZcvZLrFTCnsHsGR0eiT?=
 =?us-ascii?Q?byAGciti0xHOModvqSqcXPbPXatQ1ys6ni4C7m0uh+JeYQvBTktwrCvTzVcH?=
 =?us-ascii?Q?qN0DuBI5LMDcgBQdkCfx+cA5xutOyO+wY7ZlniOeWey/2XLgfSmanWyHsL2t?=
 =?us-ascii?Q?sL/HnCwyYPQSD4XC2i4AR+3cNI6cEMYmnDBXuCZMDJom7VE36hvqr4r/729l?=
 =?us-ascii?Q?Exm3GIFZ8RuTb5lpD9LDs35Lc5Gm35tIdjOc4HDaPWpRG6Z4tk82kIpLoMLO?=
 =?us-ascii?Q?TYg+4tTLNclUBOy+/2ldceDIi+aHGcqRHwNDa9hboP9V6a5DeYkvZHiJCbMO?=
 =?us-ascii?Q?R+oc+LG7R2l0GhSOkyIBlgJMaZ5jKHTtIG/fXxexa7yjgv8VvISulrWTV9pZ?=
 =?us-ascii?Q?XxLzHa80Kr3T1zZG1VSOeL5KrOcspzvzoffSqXLOYkSThubAp9it1tvigejk?=
 =?us-ascii?Q?k92xW1PAbU+5W0Hkp/AAWYYhwIxruL5Is+4hov7n+sRr6MCknptGb+b4Te0q?=
 =?us-ascii?Q?w51anXsxZC8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+STAn2n5Rl0Ye3KQRd0OtFFfeK7BUKViiFZMgXqZ+ZoRJ0fgfj8UCZAxERW?=
 =?us-ascii?Q?j1cOquxYvakGgiwRUvOjfkfNODYjdqLjfygQFNdRMgiMIEaI/F/uDTtUJons?=
 =?us-ascii?Q?YxAOp6jNmEaHbozNTn9r25pHxOquAPniJfp8tqVH6j9gvsmlVVvM8HyYEc8X?=
 =?us-ascii?Q?3KxDcAYetnswM7kUUKA3fZ21thl77hS8mRvXc6cwetPrBVAS7JEsBZevmsPJ?=
 =?us-ascii?Q?lmhnW4Amw0mFRzHW8t4NKqBh0AnQ6CL24I4kwXb8amkk2NNVq7qnvyhd5Lui?=
 =?us-ascii?Q?VsW+UVN9E/MOGppdNYQvASVCtbeUL5wUtkdEtQy3Re3j3nKGcJxaCgoC//CB?=
 =?us-ascii?Q?WSLZMQtjgXvENtJI2GbBAL3o5jB0sWDkBFHdGGg3fSWVlPFQRcyk9uc/ACGV?=
 =?us-ascii?Q?/J0AmIfl3s3D1IsK/5WVmDak32v+0kUJptApYlioisMSqRP9y3XnS8F9SRmL?=
 =?us-ascii?Q?imlhcE/VpAe3HJ0pUPwnXyE53Ftx7fqZsSQcDfiNHzWYk+mWXwN3wCiIQzIU?=
 =?us-ascii?Q?EwQbTuMSHkrcyuzvIC2fxMFPSX0IwY6v+wy/sX4qJt7doaTbuV7xX8WIN4Pm?=
 =?us-ascii?Q?BLhnKzxANiO/dZRqkjkzJ36jtxLqhNxDmEhcLKuX+vsopjgMqqjtlGcfa9Cb?=
 =?us-ascii?Q?fObVT8/OcVsZmyVmhhyDBu1dKe16U3gPJnrdajFZKZzLP4spbD03dcNKwrBG?=
 =?us-ascii?Q?mJMM58J3Vv0TOHEn9Vhjhsyznv+IDPcu7iNbbIF1CVR3vJ5bm2nkDukUz3Oj?=
 =?us-ascii?Q?4+TPIznw50KKPo8h+dL2tB7J72BuphgB7gDl9ob/uG4tH1wKuazG/5GuKKtU?=
 =?us-ascii?Q?gIwojwRiu1ATVO/PpoZ+kbejA/R9JJn2pUhYK2Kkn3r8iFc57uJsDqptQ2ZX?=
 =?us-ascii?Q?1CIy4JZgY+azbAu6mtlCYOj2+Jfhi0MfRdMAmJc1BVoGcKUBwr1hsj+LS2iT?=
 =?us-ascii?Q?9qGUcOkRT8gskCCHwS2c/EN8CHJYlQIZtr/75l5hk258uw5ftUyiJIgrCSyl?=
 =?us-ascii?Q?Gfi31VXxXsV5J7d9bDhAeJ4XwcJUjrdX0fvEdlJoQlFBzjml+7G7o/83pnVH?=
 =?us-ascii?Q?3KzXz92Yx7NG/71rp8mWGfdQ+soQonQ6FhBICWwAUVmMFQ+j+995TU0M6SXZ?=
 =?us-ascii?Q?wcXo+xC6RD5uI6NICP4rGHdxJRS/LYN+p7fQxk3tMfk4ZqnMpwHoHJ5dKS3c?=
 =?us-ascii?Q?B2XkDM6rJloPtwxXutjZa+TW/MR58d5bgD5XsSJ+7eeN6C0NkBOG7xxegUTv?=
 =?us-ascii?Q?mc1ey6rAMyM+9NLx8ymwyCSPpfy5ddreRKxonMEq6Hgj4/iS+YiH20XGXN1H?=
 =?us-ascii?Q?cGCCl9uVB6ZH7LAghSHkFkQ+uaVPTCMqxPacEL8DT2/8tRJ5QQy+h+BvMOwd?=
 =?us-ascii?Q?SEPXbB98YSia4PL2yfVF0BwbTtUSSWXfzDCpOCDhCv1A0xWkXsl88rQkQ6QU?=
 =?us-ascii?Q?OyWMkFq5PLh6u5t7Rybvr6nSRAAGtOK4w8hdK79AxW3I3T6+y1NCOeI1Ub46?=
 =?us-ascii?Q?t9e6iiCM67Q5eDYROTH6MyIy3iPLmTOCO97y6JrR/VFzJyJ04n7FN3PIGIg+?=
 =?us-ascii?Q?8zSi+Pa75Grxxah3SSJzCIVUueQdJN/E9KrEab8sd0EovnC8oQov2eTiMiec?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f464aad-ff4d-43ba-c51d-08dd60012ff5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:27:17.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emJN1rzQIUoxj93CCbqUa0uJgqmrRBgB9Nkkfr+ZHzH41lJwzDmortRDrngs8tkol1D1jMHsYosNZB3x9KRJLowlkAhIkFn3sz00gRB9Caw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7916
X-OriginatorOrg: intel.com

Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'FWCTL' subsystem is selected by CXL_FEATURES, which is a 'bool' symbol
> with a dependency on CXL_PCI, but referenced by the cxl_core.ko.
> When cxl_core is built-in, but the cxl_pci.ko driver is a loadable mdoule,
> this results in a link failure:
> 
> ld.lld-21: error: undefined symbol: _fwctl_alloc_device
> >>> referenced by features.c:695 (/home/arnd/arm-soc/drivers/cxl/core/features.c:695)
> ld.lld-21: error: undefined symbol: fwctl_register
> >>> referenced by features.c:699 (/home/arnd/arm-soc/drivers/cxl/core/features.c:699)
> ld.lld-21: error: undefined symbol: fwctl_unregister
> >>> referenced by features.c:676 (/home/arnd/arm-soc/drivers/cxl/core/features.c:676)
> 
> Move the 'select' into the symbol that controls the core module instead.
> 
> Fixes: a53a6004e7a5 ("cxl: Add FWCTL support to CXL")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cxl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index ed49e7e7e5bc..cf1ba673b8c2 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -7,6 +7,7 @@ menuconfig CXL_BUS
>  	select PCI_DOE
>  	select FIRMWARE_TABLE
>  	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
> +	select FWCTL if CXL_FEATURES

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...I tried to find a way to keep it local to the CXL_FEATURES symbol,
but it really is an optional core feature that needs to have the select
from the core module like you have it.

>  	help
>  	  CXL is a bus that is electrically compatible with PCI Express, but
>  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> @@ -105,7 +106,6 @@ config CXL_MEM
>  config CXL_FEATURES
>  	bool "CXL: Features"
>  	depends on CXL_PCI

Drive-by observation for an additional cleanup that this CXL_PCI
dependency is bogus. If it were real then there would be a circular
dependency between cxl_pci.ko and cxl_core.ko. As is this is just noise
in the Kconfig file since the dependency solver would already be
screaming if this was a true dependency.
