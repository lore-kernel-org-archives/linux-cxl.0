Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9601367
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737772240; cv=fail; b=DRKaZHJSACLl8D8tgoNfIC0ohiiEscL9sJh2yHkummDWvHJJT/YGDOH5G/Pc/saXemfD8WgPwgabV4LVB3rqzTGHHs/XzPqFBSTY5sn4OXoZBALV+Y+Yd5TilL6aI5VSs4cU1Y90DkwgHZMRRj1FzNdW9DNH9ExrrjUuiALMhco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737772240; c=relaxed/simple;
	bh=eTrBB94GqBL72yaisaVowKuf7IM7n/T7P5b2V20hcr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YsJxYB/ryIgFLZJuRvtvpt3KlXxHnKTVUincewNfClUCLDyC0RqNQM6iA2spjZMIyntXlLmp/cOxwCxjK8F74hATqkbamcdNt0A7cVNtyk8kOFwGF2qD+PKiC+GxWlDKesZpfPkuiOG98QeSkrxNGNudP5KHlJPTOgz60CPujBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCYwScCU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCYwScCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737772240; x=1769308240;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eTrBB94GqBL72yaisaVowKuf7IM7n/T7P5b2V20hcr8=;
  b=TCYwScCURK5BJNLFn8Y7XdY40WGStbu0U2bZ6iXJ9aA4Ee1JPeGacIVT
   SXJDR4qety4K4vKBbgO3ksrb6xaALpwvRQo8OettwSLcsEtx9XHslxDgh
   kyEFC7JzCMfJ+/O6LBhTlz5Zn7geRahyKxEo3mtYemXak7Yz7kUxk2G7F
   4zWghftAyMdcjMT8aVZMsBlLA/Qa8mRHZ+uqMdZ34iClxtDatgRZA/pNO
   e1LrE+WY6NX9g1KeB8jtNxMGSCKEm3iwB5p2clYBUHA1fiPnpMUpaGfkH
   W2I8Z2WveW6jeahKnSJBxI+wMCdYoL25JtLQAwbvoskDpImPmRXRjuELZ
   A==;
X-CSE-ConnectionGUID: C4ajpy1qTR6Pain657E61Q==
X-CSE-MsgGUID: ZDZ3QhDfSGyyvQ7Eb/kR6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="55733887"
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="55733887"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:30:39 -0800
X-CSE-ConnectionGUID: Feg2uzsSReGoaWRo4WclNw==
X-CSE-MsgGUID: YZ7UzYE2T0iyeHw2ONbPvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="112927179"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 18:30:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 18:30:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 18:30:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 18:30:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKkxgG3cMwHchrn/EJaUOpnHWwkhNixFsJ1C0FVihFyU3ovQoTsxo5S13AefIkj+Wqg5WC5lHsChBTk9snCu4MGTvEtD02nXk8wpzOrvjSCDkfXKUlSUQ+40/IwxT0OuIwa89kT3rOdA/VkKtoW+Fu9ATGKMD/MkEMI512Q1svwJI8cveFWDF0X40sy+9GnJLEnCznus0F5Endct9OnJtiwNfcvterIne9AxRNavYKOEtZoHHi7R4ISBadYlye2+SI3vKSovCT4c8PTjV34oep7unuc5SrOplloTqbvn/QXvjcX7Ll+pj/2m1jjDAWIMUh9zxpZ3B84WB5/9XpSIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acMkm+pVhffQYLZVM2qrZqxx+G7FQiFrKFwg7ZRU/y0=;
 b=JeUx62RqoOilf6vhDV8EPyq9UyIlJIeCAGEHZCbOIgludyPXqHS+CYIwpeRmsIDVa9UHNQ6PDWwyVDOGqrh9o5vTQHk+lqK7Go7Y3iqDWwMtXZGOG2G69zN57AO7H5tpPVnEKS14U/899KwiySlwv7V5yI/wo8NvlPAlt+sKWTZAEdiy0PK3ZpYD3C96e6ZHhy7EoYt4zgkusQYB8kc7+PDAJdtFa/6SiZM95u8GPJQ5t+cULm7l8ivIX1iElRwwLAYB/w58zzgCioXFQdScCvT9LDdGgk7neK+33mYazgINKShYCOmfOa97PwM+59gGbQFZOqzInLiSbKzCQDXZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sat, 25 Jan
 2025 02:29:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 02:29:53 +0000
Date: Fri, 24 Jan 2025 18:29:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 16/19] cxl: Add support to handle user feature
 commands for set feature
Message-ID: <67944c9f293b0_20fa294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-17-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-17-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:302:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f0d8c0-94ab-475e-471c-08dd3ce826bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YkDJR29HKezK2iohmlUwZoX+Pl3IEhi9RQ3UZLnhjsMd1ypCAjIaejFKgsv0?=
 =?us-ascii?Q?jxps2QfN+oD6kv5DunLG83cIIgwbq9bMOJfWYPUmXcFO+H0HK53pnss7sWJm?=
 =?us-ascii?Q?wI92w1zPIYvoTw9aU4kgZdjRmeyYykX4rLMlvBXYth3ZkJHuQTYh3W2KpBl5?=
 =?us-ascii?Q?+w9d2m+2XZqMHu4QdpxK6y8qfGnQAlDyjnMmKb9Dsd7VObxJlQso0Emps/xI?=
 =?us-ascii?Q?bLb322BJx/zyGTlNfDK8Be2dbwm2lNrr7DbdKQm7D6oCQ2YBmzpcMWCvO8Ma?=
 =?us-ascii?Q?tHqnF8l+9GsWRqPB5jlHlySXNGnQF4YteW0dgAj+X+aXiiiSOKl+OQ80rW0k?=
 =?us-ascii?Q?YBr3cB/3HIMSfeLZIISH1L0bw0ruCrlRXopxqTfiTCs+rKLc19i+NlxrIHdQ?=
 =?us-ascii?Q?NePT06ot6mFChX2Alg268L5J4C9kt/k4ZI63SLr3R3zbRIknhRdIuDrK8SzP?=
 =?us-ascii?Q?4LWpHeiWbDTN4JEPdZUtQjbaAZr+kEA1ZusMmYS4dIo++duMscehEGfXOnDY?=
 =?us-ascii?Q?gfuKiVM+NYRaMOFqpB1hehBUobn0PsCRAgKIlZ734V7vcIFX/ryGKjKWV2dS?=
 =?us-ascii?Q?BsnQwsxY/Cr7CfXieTqmlT2qnP+qOqdhxbih43hhhC4KfhlaSblTI+S1OkAt?=
 =?us-ascii?Q?umVOAt/SMNXHJcU/FHATmUc0W7EExEB/Hzt9KPh1R5htakQTp1Ml+CaG1Imi?=
 =?us-ascii?Q?O+UJc2Awv8w2tr/3kIt98Blhv53y9dfi4zeENCj+NtZZ44l7SrcI/MZXRCiN?=
 =?us-ascii?Q?ZY15jiO52utA7oJ6NxSnfblHn6vCDNdEVWbZAo2EK77kpn7KfwrGBkPnOFYK?=
 =?us-ascii?Q?zMZdT1p+Yyh026esUv9KHqRu+p6CK975lmHlHvPIwQqqkL/dpc6IuOyfQFH0?=
 =?us-ascii?Q?PnuSVQjAeo4gxhGGiGQP29Nh0W3AfnZMUZsUcvcLMcbJo3x1vszchsJJ5E26?=
 =?us-ascii?Q?oC4CPQgdjB6bz3BPv8w7QsCJ+O72dCxReqL93lFwt2Cj5UFrhpjhDYmDYo1O?=
 =?us-ascii?Q?LVrlSQrLlEmcw84rBHmunMVJIZRk7oAwOVKccYIqI1ZA+/CCpuOklKRT2U7u?=
 =?us-ascii?Q?Bv114UgjBsos8a5EBI01ul5f3+TsuEJhPLlqWgyDXOkvfAvpzkvgefaCVaZf?=
 =?us-ascii?Q?+5D70wF6RzAiipYTE4mhU+BPcW9bjuq+xb1/wndyvExx9NjgXsXIbZc0XocO?=
 =?us-ascii?Q?yntSWBrR7HLcKgh+AG/IeW+Y4qFzMFwvcn5eXYO0FBjfr7lvZjiCtXlDevZA?=
 =?us-ascii?Q?dmpPAplNB66/lO4xqTDrhAlNYwHORUmfDiV7QgCyi43Y5ek8rYeBsGwlCmLe?=
 =?us-ascii?Q?97rukPGVi61tKHe/IkMlQ13lYFjryWf/rEXDLysODbCk4XS4AFsPfbUwc9Ls?=
 =?us-ascii?Q?ewytXXsrQ19mJaE4tNEGxSYFnRf+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KNR33Ul6WJaE2Vzi4XMKUff07g1xXpmEquFgswevQwxKBhm9Y/Hf425pbIib?=
 =?us-ascii?Q?GK4KaIdID93BEnnvpxLDrPzG+FOLkWNe1Lx+UgZhW4wXy9VQMQxiTDZYU1Aq?=
 =?us-ascii?Q?Zeun2ep94PKBEcAn2DbDI+q4zZae+iyLuNxWx6z83QdtBLyTxfSz4RFFPLtW?=
 =?us-ascii?Q?AprD3TWoSvSl8J4kQmfsvzVwjHzKETPQGNGoi1Si2oQ6DwQGhReuVBjT0nHe?=
 =?us-ascii?Q?vtNddLf+T+x+8CZFfzuTDWUx3wm88p4S7ze0sbM55kELOlaioWvw4ZSXkCMG?=
 =?us-ascii?Q?0ncsHsKhWhuwW8ZwRKkuw16fWmvA3PtyGg9sLyjBP5mV3nDS/lEa/hfPIYoU?=
 =?us-ascii?Q?AHzZ4LyIWlzIg+A3gGeU7UUUkfm1D8iyVCaQyMNyLojNDQEYYi1fgm9YHse6?=
 =?us-ascii?Q?TISTmY27YQJpen2FhZa3sT5nXvP8OFQZ7aq2BGtogXk6kuLIJl+gBr13rUQe?=
 =?us-ascii?Q?sPcwLM0e2+8fzkz8WFE/P/gbeABVFyCZqQvbdmiONbqzYTKFRxDd+kK56opN?=
 =?us-ascii?Q?lrE1XS8/RnicYi0T00K4cWjrP5Fu14ZifuWxvP/4M+xc2k87z8Io0Z7bKsmH?=
 =?us-ascii?Q?iWKThCiaISYhVC3H7S/7JoXc+mJjI2kAwDnTGkLX2X7IUWWX28Ql3D925iI/?=
 =?us-ascii?Q?F1UVSl09VW/HSV/PKhw9dv4cFaK0FQQa9uJh90NebMJiU41Gpvuc/gt4L6tD?=
 =?us-ascii?Q?cBCS4I7bKUuhLw+Hj2BWtp+LgLVHV9UlKj5FCGxJ4pqSa+NhhBZJQwLe2+/X?=
 =?us-ascii?Q?lFVr+VLxonV02GpqKmX/ybcA4Byys9Vv1lCbIIlbuWxjs+zFj/QXBou9p8Wv?=
 =?us-ascii?Q?/cZRMjzIvKFgw1/kJQzE2ITB0JvxC2uHTEokEaUpIaYaV0F2qqykvngAw+LK?=
 =?us-ascii?Q?Jy/inWi/HsHBDTzHQM1tJUAsahTHJvTurwvL0vwKWlYGHJ33OTVfkNwdnVTP?=
 =?us-ascii?Q?xp7NR9wDb/81tHk2fpMUfDA9LyCdq9AfQ4jehC9o8AL57Ct5h7+CK53IC/bU?=
 =?us-ascii?Q?H3TqVBW7N4kBkhtkhpqIN1jIt+ynMXs4qHXoHgA0lSDjO/Yi1eMniTZoIqmv?=
 =?us-ascii?Q?q5/ux+KLlmQba4H452P1xH3ipRpNsv5MdEvX27ITi4u5J2DFa8ZIzyvB51HE?=
 =?us-ascii?Q?WGyyLnUdZqQzKByi9QytWHOHkMqXgKsqv0s6x+Pbus79RIHbvd7bJnntN86V?=
 =?us-ascii?Q?ufkF2FQ0KwY48Jdb7vOlbLIteA22vj7IhIprbw39qEj89kWHIq7itb5wICkz?=
 =?us-ascii?Q?4FWH0IFqiBzbCumWDLoY7V1/JLkXqX+H8SIauL2QszbPQtrzTJzmWa6slmIb?=
 =?us-ascii?Q?jt9CcpSGgkgPYjyWOxwy0YM3wnDv6TESyX6au26sHMF5ldehpBQYLp7i5UaR?=
 =?us-ascii?Q?HAsiZbCThcoiMCmSCfa6J8jxCl5T68XDdw9NvB99xKME35C0ErK9XQdCG4/h?=
 =?us-ascii?Q?KLXIo4cYiryHjt9nNdaUfLJDnBi59ol8bJJKMpUxRGooTRQGkoWZkajf3fxD?=
 =?us-ascii?Q?bZAjoFM6YQLIm7h5RdlVNjvSYdQpp+L9eXzMz0eK2OPeiPrXPBqeVr3ASH3f?=
 =?us-ascii?Q?boLTtSYP6tmuDjFDT4IgxoZZaDLqw+7G2gnwZQLB1RiTlPkbKfjPda79wcie?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f0d8c0-94ab-475e-471c-08dd3ce826bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 02:29:53.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzFloYiZGGidj3KeJZdoA+laf3MZeBtouNrj4u2Q1laYd3jCDWxMY4e9XnkHwDykqHtdIw6RdWhTf7wyK6qN0803iCGCfb8d6tESysvEP0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add helper function to parse the user data from fwctl RPC ioctl and
> send the parsed input parameters to cxl_set_feature() call.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
