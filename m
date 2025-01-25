Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5D1EEA43
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768557; cv=fail; b=pBWscqorg0yk7b9ofvg46JLukQcYgpCMxJE6jatRNdEMM0hvF9FyDDvaWiL5Z7jBMK9RhD36Ai+9b/hBGIdUAMntIBm4vosbdenfIQ3V58YZ0lBzSVzXFd3eQ4LfBKtXlvDXjZpgMGkGIGeWfQBJG+q6jNhVTW/4gZGbiUkEfEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768557; c=relaxed/simple;
	bh=7WV6fEzTgHyxcSCTJAtULnJRWSiwNpX2M+LmG5tEWy8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HuC7NXpCPEOeRi/QFX+vz1N466zZw2jaGajykhfWDZcucCU+xCDovCYWGDWQmtNVGQskT4wWBKaFwSI1IoXqkJmqvH7ZUSoV5azghDtw5xTSiIp5TsU4NpZNeRbh3eVAKKhnU9IAU+luVNjRBII88p7Z+eYTssJ8hRh5gqCDGos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGBnhWJ9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGBnhWJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737768556; x=1769304556;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7WV6fEzTgHyxcSCTJAtULnJRWSiwNpX2M+LmG5tEWy8=;
  b=HGBnhWJ9rcFD4XYI+xooTN1NP2+RLWMVL+U0GHH4XYgatvCZWdiXsFDU
   mnGktldlclPOpi5WsAicw6nDDX/oik6ODrZwK+QcaVjSOYutdfNEjtbqz
   W1p9frY8vaipsIdy9rXoSZmSvskE5Jxns7I58lB2aJg7bHCsiaNjsLj0i
   iVy7/54zAgEZsVS/zGMmkUhtsmh9VpEEhUogcNLFLV8RhDF3Aa92M8z2s
   1GyTnlBKjIPvhnty66iL79uvBSXQUy9vZGSdCCf34zzqhaWUKaaPFZIKk
   p5S5rD+50Lz8zdCXycoLkQ0SydHHZ0fqOQYSwXSgD+bBIqPv2hpXABofi
   Q==;
X-CSE-ConnectionGUID: IcTsrYRvRrOo5+fBFCQdTw==
X-CSE-MsgGUID: cjMB6gS3QVC5JfMcNmgkug==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="63668774"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="63668774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 17:29:15 -0800
X-CSE-ConnectionGUID: 4SYzTfYuQGSRncCkAgAO2Q==
X-CSE-MsgGUID: yrURS9QjTdGfWucBe/YSvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108355191"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 17:29:15 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 17:29:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 17:29:14 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 17:29:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+rvHoy+HhWNiwcJcNIM7Odfd3/KELvL/FmobdYpqFSWyRLCIMSjObKhE3YwuiLZKIqq0hGJCyCl+6NXIZWHu+Csr+VOWaehJJ8wYrO4pMybaFQ6C/gijE0Z2uHqAnloYxo6DyShZliqjU9E7ud0MmeMUeKmTgOcAXYxVcf816XCHikm3j7yxFRwup5wRR3IRVLmCsMRnmK1hu792nugUiAylPON7Wt9+t2VqrR4HB4O8IdSVAJAzim511R+6K6+kWEISwTcxnSdOGH77VMPSA22r7D3OHfwsfk5jcL4gg8cTJcEVCDHUSShaUyoJOaV6c/WVEw2ZvLV5YG7o6rpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3KIaI8neEnHWoLe0WysXgPYfJo/iixwekNupYZuJ7c=;
 b=ZzqrqVAdT4cPrxpAq17WvqqxvLGeW3tDXJNuyTLAKuv51VnGBb5EOJm55SbboPFD2iVDCdlhMZvrktfJt8jhFMeRoYcTs8rJJH7Kz/PIQs9YsH4cfFJSOUM63jgMYYHJ3frOa2xuMb/dIPzGMuprtIbUcSlGkTJSn7aA+GmUsmIMQbksmIR3lGJzBQ8ux/QxnvRrOXOgX7dscm2PGpV0g+IwkZZy4EG43eBOuBru6SaUm4h8f4cWTUEL+/rOJWjwMxwvraJXnSxTlSfWC3v7zHYFsQRn8oTNqOMLFZj7Bem5GY7Xng5w1z46Mx/QfCFC3s54nOg69NzLcn4eUHfKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 01:29:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 01:29:12 +0000
Date: Fri, 24 Jan 2025 17:29:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 12/19] cxl: Move cxl_mem.h under uapi to cxl exclusive
 directory
Message-ID: <67943e6592133_20f329432@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-13-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-13-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:303:84::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: b33f8f3e-15c4-43f0-22f4-08dd3cdfac38
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IagDHJKoRKX3oUPO42k63aYFd+5jTprIha+Z6A7kYQAHq/Nt/0KZVhEZspiF?=
 =?us-ascii?Q?62obyp4xKuud15UnU2LxrpplxBzNiUCGIlZh8hnroT4hU8LpcDTfUQlJfR/b?=
 =?us-ascii?Q?SoS6RhepywNrU/exE1V8wGRdfSTZ3bpAsegeH+R5k/w18fsauoyEmkVNRagX?=
 =?us-ascii?Q?Z9gI/P95coU/B/aF0Scxg4c6gkyb00cowpubSD8Q9AiKSnPRaLcpV2p3Q+FC?=
 =?us-ascii?Q?OUgwZ6raztEDwhDYmOziVVOSoTAyc5CmHzcG7YVBru0oDrQkBdcZpjZU8b4B?=
 =?us-ascii?Q?4hu4g3r0fMgdRLsYZeuh1sbww5CdJK7ocxFrm3KO3UmoobjJE8K8bsrN9MPP?=
 =?us-ascii?Q?XPKPe1+zJ6qDnJ5ryED9cBfmCVndeKK8lcKknTrwTKOeGaXL9Xt2JybCRncH?=
 =?us-ascii?Q?efrkBu5l3u+UegI7y9lkAVhXPyNyR3Bq6CcvMSeJqdY7yxPjfi9n/j6iq8yn?=
 =?us-ascii?Q?o1fxatWaHYBghmuyKl0WTRRhuiwgd9o2/VizFPDtKuDCF92vdyITZ9HRBSHW?=
 =?us-ascii?Q?WR8hqAwHqe/QCxgN2ftc9iSl8X53QR+Mdj7wBcn21dYPZPh/2Nf+Vp0OuMTt?=
 =?us-ascii?Q?UAH2+ggjNBXg26jhFh7tRFdfcnEQJ+6gU5cmU8uX6EFiVeA6zEmfKrfTvIW7?=
 =?us-ascii?Q?EJafJZ3R75wkgjSwDA2ydhiSvf3PJKq45iEjdoENeo7wHnB2x54JixQsl9Pe?=
 =?us-ascii?Q?PGJLNjgw1SFxCGYi0ZC8jOqo+5IE0gpKYDHYf8/HUPVpl5r9ZKxDpBYjrr+m?=
 =?us-ascii?Q?fpfPFkE926tDgrzevfrDphNDwBdvQTDeFhzhP+hSmkxdGFw05a8nUxlVjW2f?=
 =?us-ascii?Q?L+6IGCQXIvtSA5MbBMSnIhcm22VYKGhM6n9/JdvbDQnS2y3nYFUV9hYMPLwa?=
 =?us-ascii?Q?nwP3beto5uXf+l97/b3aC0Koq5zIABkD1DLNMBrzpipg48xzx5//rLTQF83Y?=
 =?us-ascii?Q?AdMSYTgpUrPNxwPHDk6uo6eeZ46jbq0bsRIvnU4IhFz0M+hEdmIGjdE/Q30B?=
 =?us-ascii?Q?Pxpz/caqa77rF0B7eJyhblqWEHVUvGR5tIjAwtf57SOPZoubwHORMjSdeQTB?=
 =?us-ascii?Q?HHtQjYUiobg8QcIGBv53LfiS+DtDpbwlSqUDiAFq70r3RNgachnEE+xfniaL?=
 =?us-ascii?Q?RH02jesp9nmO+iFA5tnIywXNAA/Oa985ccNSM0uGwYzeuMwH4VktKtSj1XYi?=
 =?us-ascii?Q?+WfJW+2snT6Uk18Az8R+JfbuHmTgW6xzvZud5aQmb8qaJRP8l/cpe+eRlfrd?=
 =?us-ascii?Q?BvuIq58alKo02bQ+t8A1D5W/xuB7TGHbpsvYRAQuFcscB9Nqf2fNq7AyZwU3?=
 =?us-ascii?Q?cnXHfhh5t48cZHSOMMMg9FmQ4zqtl4FrB2Dw1H2NlpFS80kX+37me48mvS7h?=
 =?us-ascii?Q?4y2hHrExfWt8QF7YwoF7zafIkAS7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n7kVeHA774FY3wbxFM4tUNx4jjJl4ofkftx3yAx7a4stl7nU/M5hlBwB9lgA?=
 =?us-ascii?Q?026o9s8l+bI3guLBYgCova9Yt3/o3LOGxwsDMD9rIqx+v5+lA96eOU9STnr0?=
 =?us-ascii?Q?m3g3TzB3m1YMfG0KRBYd525gBStY2cCyshBy9j275tHaMNzyIjKVBMANCPSS?=
 =?us-ascii?Q?2DfCFRQepaywV9afxtlokri+Cfeth/LHQU5bgWMhwJbRmv9WBV9L0H+l8OBI?=
 =?us-ascii?Q?W5fW18CazpKqOkaImKgZm1ou8IcfVCoWhYALhidDTCht72wZHj+qU5GLBAev?=
 =?us-ascii?Q?ZNKMylMv2OXmwZWD9s5xFjgFdmY791Js8rK5JgEmlsDe8R0zQj8UrdD+HkMk?=
 =?us-ascii?Q?xflIB+qPKw3J437m/hJqx+vjN6+5K/Gy+c249NH+aE9mCZdnkBGtXTAq1ari?=
 =?us-ascii?Q?zfOJtqLmO5p5N7aZFQ2WpWCGq1JpIkjBtWHAafq8vgSA6S6wbgwsZ4vWl97I?=
 =?us-ascii?Q?sVTJIuT0Nn/UCLDqK1OKu6mttPbhHZkgJ66gPZ9Oz/+sxV9D3Nm4L5RjbfC8?=
 =?us-ascii?Q?eXAd9SqdLyeZzvnQsICRnpk5dq0qCs8WGOY/LNrOX5YLhWM4dgdcFmbIckGS?=
 =?us-ascii?Q?/eYX7qIRDBebNgz1d4r2ky5uof/NoR68hBjROqv+VumUXGosGZ2wDevNxiK6?=
 =?us-ascii?Q?nPZPeyyumVtpPZyXHQWCdG3NeYJd+qN3OBpY1ZPMjl7FRFeHNwj7x8jMJTgN?=
 =?us-ascii?Q?a/iJrMV+eEECIpW9AUMOFppNAA5pLnYkK87Bi5C729v7/mPSWxcIHspCDNZ9?=
 =?us-ascii?Q?sZC/b4dA1HJ2vMxyBlA1GwvVtii1I0ACmPprRlk0oyR6SrzI1QwsixVmx3T7?=
 =?us-ascii?Q?/2tD2iLzmncB8IlxWL8r1w66XRMaJr5jyWkEeSwXGDIJu0WdKBM5GRRb9Yn2?=
 =?us-ascii?Q?O1KGrqUjad/knwJkZTuz3glP8at7+ftJVARwNTEWM2L4zFd5Blvb1azngB5O?=
 =?us-ascii?Q?HyTJFN2QN1qBYYJedHym/igHObgNN7mMP4306mDWNOCv62Lsj2yvUQqQNhaO?=
 =?us-ascii?Q?hWj9UqS2yl6ri8RFnXTRpa7I7WjVtcTdR+bJC09yATk4l1lcohGGYDGM9stp?=
 =?us-ascii?Q?pci3eA+C0+g078WbCqAfQRgevs+uZMYAUVVpT6AkJl6gyNn4K8DwaWr6uwP9?=
 =?us-ascii?Q?hcwLK5V16ulkMbTYnAr/sErg/UjibPjQ3UaoJNRM9AXf3X3hDFwkZKWvXMDn?=
 =?us-ascii?Q?rsxpHd5O6Kn5PiHGm90S2fcnWtFaMCYbqZLYaBIu5LCvi9mYTLk4Cn/dCTEQ?=
 =?us-ascii?Q?RLAGZxE+eNk/Z4QYjm7714NVVTDFSM6kom+rB6OowBPSUG+SPwtugzmLgwmm?=
 =?us-ascii?Q?MxvWKgc7iiSRFQKauJEoOugCzamXavMNJf+d5Hhk83W5QhkK4DhHitKbYB3R?=
 =?us-ascii?Q?/dV1k735H6BYOd7GvnjWf0PdVqgwobXGyhF19s5e6vcUZXbebvADggSFXAqM?=
 =?us-ascii?Q?GhTPoEKsIk0VSTA+0kSJeoQaOHCd0KfXR4ZU8hVz3pQzdS7GUaXU+ZwtNzKq?=
 =?us-ascii?Q?YJIIWro55oCocW/xuwDaUFe7jJGmGIMYyNvhnju2nhPJDZXQcYcoQ1tDMLRR?=
 =?us-ascii?Q?t1f5uA0iEJEdPFG4RYpnkb8pNSScWWIaywWj7RZpantrZBdvF5KEi/xSYHyg?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b33f8f3e-15c4-43f0-22f4-08dd3cdfac38
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 01:29:12.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o6WYbJ0fhEeeSIMuFqhaHhSiFyI0mean9Q1TFjN5WHv6Z/jl+8kga5WBPQfNEZXat9w94VzgGwZZJOCLrZ5bANGYISJxksXhpzXguXkXls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> In preparation of more cxl headers, create a cxl directory under
> uapi.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This theoretically build breaks userspace that was looking at the old
directory path. What's wrong with adding to cxl_mem.h?
