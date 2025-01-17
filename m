Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59186324
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136461; cv=fail; b=tcu5J5sE/p69s6Q/4TFm+N/n4hYryLu7VdWppL2Eum/KdVsDSxIFExa53+5MXD/D0XlYMZVDW5FXr0Sr1JjASoK0+C48yMVaawtGMGvmcoQQ+7UX/RPI8YkcJJCYbtgAdExWfwoa89FcerO/m/CUaYwNqz8ocCPXq6WleFDGGfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136461; c=relaxed/simple;
	bh=0eK1lqNbao/BXB8sZWcz9tAZOv44ypxa5ywQinzJroY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kWWGgop49vS7bXgqnmMr+fyjhE7Lhkzios7PxCBxaxsOEG7CG9k7eli+RFyeT7olQp/u9tUc+st6cY9f40O30F9a8PYXUW+auUz/yXEiY02oD63ZXEj+T2R/jmqDAtZQl3JilPHKx27/k704IR7DKRomTeZwW6OMNKlNJ8gh2N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWzFdmYB; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWzFdmYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737136461; x=1768672461;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0eK1lqNbao/BXB8sZWcz9tAZOv44ypxa5ywQinzJroY=;
  b=kWzFdmYBEmEZdje+nb0rOGh8QLRwrKG4J57lGk6Ag85J1nLnLmfj+9uu
   oFWYxZQX6yMxvVZN4ssvvHbJYdvPFQewai5dUmiF50yqJiQ0buMS/o5av
   b30tRBcd585vpPgQt/ng1qIyWd00wJ06N1pSgFcx+7GG7BPVlkILD7ppg
   EHIY/8AKOFPxh3EaWDbpknO4nRmdC5HiyqDVgQnJhqkmHx2O+J0jQCgUt
   XcbFlm0xVJMfd+kGzBYptQGkiEMm3ZfJXnCdguByTywxVUyWL9WQx2HhJ
   BnOFA1XQLW3FjvNWes0PVRmdVieijTf2o277QAj1rVmQyZ/Llhm/iVMKa
   A==;
X-CSE-ConnectionGUID: 52LlAIT9Tken1HKv6mT2zQ==
X-CSE-MsgGUID: HY4xC8p2SomMPogNoxjXhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48573541"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="48573541"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 09:54:20 -0800
X-CSE-ConnectionGUID: OTu0iq/NT+O/BLlKMZGezQ==
X-CSE-MsgGUID: 6p78P2QET8mCrpbX5BLwIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109920928"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 09:54:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 09:54:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 09:54:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 09:54:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqpYalyKQLelD2MAodY53xstUY+bpY+MoAzJSwGjI+jIfgDiu3xJuY6RuGVAIRhfaltHLmWkTmitTmUWzu6g4Li5zT8mVVi/zCzL9aqYaD+ZbjizBZIS1B+QI5PQt8uLinoQo6CsXkQP2w8SVatsm3qvVua8N60+HVQZVDyDcZQ+R8+90E75XdaGFAKc6VRJcgVIroL2DUlrA3KsK7aF3yntfZHjty/zez7M74pc0sO0ysDtimUfWVxKU0giX8D8ye6S2uS2D8RAUl2vwBpAp1S2J2ZFRoFXnwxUDJOsQunyWwa6GaHnhHjbx9pamyZHkaqiuvcctJ8r0zrLvK2ZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X8GCMyTfDD6is23X9yJ06o6PDJDR/G3ZhvaTyyYLpE=;
 b=wvYvrn82vNO6GinW4tXOoQ3jynI/n6NzK36mnADpekM5nXNUFaMf6CeV5sNoWw6C8pQP5Rk7+U2l+gIlKyoYNg6SAKhAsMSr2Bf/fvru8Jg8sjZLFheQu1+kYkrK3Jh0PrgfRpjh0nZlM9iv7kv1YXIlaq2gIZ42hJO+hjI8gAKebASHfSq1WfyOg1cXSHyNiRuH53fm8bco7t7v65rWo9mBvjxgX3F+SY7eLvSFOajE5Lma17cgHl0EhD+QIVIpOEx5djdmIdpDspmsdhuug4CGZDTi+wVvSDfLOwg9x10f7gKni/ZoWn7O+Rg++JWmJB8GZLGGpf6S4IB/WpS/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 17:54:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 17:54:15 +0000
Date: Fri, 17 Jan 2025 09:54:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave.jiang@intel.com>
Subject: Re: [PATCH 1/4] cxl: Remove the CXL_DECODER_MIXED mistake
Message-ID: <678a994543330_20fa294d4@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
 <8705f4e6-58fe-38c2-1980-081ef331e845@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8705f4e6-58fe-38c2-1980-081ef331e845@amd.com>
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 3003ca44-32b3-4e05-daad-08dd371ff50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2b5ASeP68RcX3hNG/s94zBzimOBQoVG5fIGZ2ynojOfw/er4r3mjPRYyGT?=
 =?iso-8859-1?Q?ENhygu7ckKEp4oH/vpphAZvf3ANx6IvtmfIS+aABqN6vYdhWCspEQ9PyxL?=
 =?iso-8859-1?Q?1fqGt9KWOMsTinf//MX92EkTO65BGEI/4Wj/DswH10I9WHjTKmia8COrUl?=
 =?iso-8859-1?Q?ZW2WOkyxOX2ABSNeZ53YtcKQAm1//mAIZ4Z5+jxsUjPmIviSvQU4POuzQw?=
 =?iso-8859-1?Q?gKA9eSppcocdkr0gs684Tdc0WqPfbe4RWV/m5qxahEgZJMwgyyF57wz8WQ?=
 =?iso-8859-1?Q?qOcH2SQXsK6NZOnauD1jjwAewPXRC6tK4p6yNVmcjn0/nNjOdowdRQ0pAq?=
 =?iso-8859-1?Q?TSUu19S2Nqju3CX/A4fwXONeFGz88UUf/jKx8RctYwJCtek43J87mYwesw?=
 =?iso-8859-1?Q?KOErdrPjyThWAQwVkKyPIobdLGkQx+K2q0opUS//UfjypSbLi+l+tbzkeg?=
 =?iso-8859-1?Q?cK1u1lEx9Va78hSv1p49fs0UJsuLqZV5mDouHzexTPZ1HfSWvqt+JgGPhr?=
 =?iso-8859-1?Q?jEvLCl9s9I7mxbZsONp/14rgkcDC1OzScc0Dmdwtp2mcjX+g/3pJZuCkwd?=
 =?iso-8859-1?Q?fvtTWq74wHSj3EHNor+rSJ/mFNk0jfVpjOmcLANBag12DF5Z7N/KlCR9eG?=
 =?iso-8859-1?Q?JdOEz8MhKhMpat4hhMzGRQ+rzL7qVYV5kenE2ORR6BOh8YzGEpARbWQzXX?=
 =?iso-8859-1?Q?iqIVpaJlbVadt9+ugwfgA0RdL7U/5xkc860W510c/O2v85YaGERo2UYzzS?=
 =?iso-8859-1?Q?i+neDx65NCJkaQGdCG9Xd7rIWqg46c2mguzAQ0EyAaPf581Nk5y0U0n5Gm?=
 =?iso-8859-1?Q?HudbSKF/0Sjs4AuBs7ZrG+2Ks3bEtfW5MZM6iFHyP4gfC1KXfL4eUL+x+7?=
 =?iso-8859-1?Q?tBSIO36KmHHhGzKJNIURzeM2Gd96EeEVVbp85robkdXVtP7KZ7gHWtUcfa?=
 =?iso-8859-1?Q?U0Kzuy0Kgc+xeCP/CkWTt2QdMY0Ki2mbaV07t7nW1Oj2gq7//IwkfuoyDr?=
 =?iso-8859-1?Q?GbDXuYYUKZ0bFb045QSIZLpeZ1RLfdnOCKR+PnyufYe/V5EfLgFP8Jpmrh?=
 =?iso-8859-1?Q?P1E1LRF673cFVKY1VAMXJAJZgebGromUvaRQMz42zFHugCQKMkaTtYAd4v?=
 =?iso-8859-1?Q?HVZirw63GqqcDzpd7EKPhq9gmgSAM8AUde1Mu7fA+kAMXVHhPx5rCnJ0Cy?=
 =?iso-8859-1?Q?c6UtQTYBh1XDiQEUyE46r7kqfh6rFz0/gJ1btQXbAsC/aq31BeZHrR4A/5?=
 =?iso-8859-1?Q?LN1RKFGKSmBb2PHQSMQ7MT0lna/Ckm7qMomLNTEi3aXk+FojBaz5mFyWIL?=
 =?iso-8859-1?Q?e/tlcSV6OBTif4cGSfenx1EqHKXrE+XIFps5jJUivJSXeOV1xlh+oY+Gsu?=
 =?iso-8859-1?Q?qGzO6mPo4/AGhCotgGRLmmxiZVkAWc3gMrn/Wzo2B7Duzb9aUGfO0wDKrj?=
 =?iso-8859-1?Q?QljxHVZJnUFSIdrK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Lu7zaMD45wpeNtwIbJ5Nb3l5ht9fqHYEb/uKmRVqA+e8dJiJNeyOOYpwVa?=
 =?iso-8859-1?Q?0n1sZeYkUCtMe2TVv3s5m9OGtKKJfwRJmgT4qUi7LJc+6yFbmdd7bT2l4f?=
 =?iso-8859-1?Q?7XfI6PsVDNU0wW15XQaeaOgGU3Rm9hTlhvxMaVCIUYXOZKg6ZnNcz77+jU?=
 =?iso-8859-1?Q?Nyvc9dZApJ1B4+82N3tfsskzFJ3ecEAgpgHNR0PztIK3nEpg5YFyQqIzWT?=
 =?iso-8859-1?Q?UeBRdehbfzgACmfL5oipz1h2bBrw/KkGjsHRyKNSqydBD2KSTt9QOwVxbe?=
 =?iso-8859-1?Q?cKBZQps7Xj5cf2tMkQXHCJXET87tBHpadfdaoTySI6sEGenkN4Lez2Povw?=
 =?iso-8859-1?Q?iwLHNKdD9+XvNVangQj2gQ27e/wusnlWdTknlkN7/UlX1ETuQVSioblsNr?=
 =?iso-8859-1?Q?gVHVeAHq+EEN5qv6tuUZYGTji8pttiZEPNQfeVTAewzxTmvyiB2EBDC1EU?=
 =?iso-8859-1?Q?KrmR7uijpqA+M+sdxCGWS9RuR+H9phdSgp2FxPxZJVqmOb9UKVIKTGkgqN?=
 =?iso-8859-1?Q?Yw+kiPbyhlc6noi7FPPM/KzjzC2yiMY0LbBz5OcU7MJBFArhBZVZlDW0sb?=
 =?iso-8859-1?Q?8fUpnpSQZjsFl4xqRabivwNqjVz1HhZ3P1MhwTSl3wrR8pRbTVgvZZOC6R?=
 =?iso-8859-1?Q?oDAOhF3O1HZ1hxLQ6CsUYpiyS2CWysciUHevEX1Ozd+F/q54N9B/qh+kbY?=
 =?iso-8859-1?Q?QDzV8R1Qw3jZw/g9KuIidSt5fZp0/F7mnGTLzfu3I79hFBD8hYze7K148X?=
 =?iso-8859-1?Q?COvD6Fu/HtQElOSaPF/zsgXeBo8bua5oOs3369zlQPrxYYk+ArgqhLDOAM?=
 =?iso-8859-1?Q?WsDoKOHwLjwgpVxeALBBBmPqC1WjsrprdzeSKz0RJXU+6Pxdo3mLjPUEVj?=
 =?iso-8859-1?Q?yU6J/hWiYrUj+0zwNmcmG81ohjXpdx+HC96ftiiv7JXMU5QUw8g6y2646j?=
 =?iso-8859-1?Q?XCTlBVTFfRCRbxL1O2FRFSaSDpAprpjSb80edKzDiUr0eXT89ByAknfVjf?=
 =?iso-8859-1?Q?yc8io3fRrzWkXZrgZz8zklkUWe593vLI6r1O+2At6NfamoE1Lgnfs2vsKy?=
 =?iso-8859-1?Q?oTxx1p4ZUvLtOwWr1zVv5ZVr/nqaYvKiSFegOD3q01dJhVJniycxbzO9YY?=
 =?iso-8859-1?Q?bWBPeOSLrvQi2jSIiB0+oQ1mwjS4rKhkiEsARlvyJKd9GFgU/uPPBzMcOv?=
 =?iso-8859-1?Q?GNg8hzY/AgUi/UHMGL4Ufd82QbM9IiZ4FeADlibhS43LC0xTy8q1OUVqvH?=
 =?iso-8859-1?Q?WM0dKxYtPdBYLC/8dWVVjJ3rHa0SJRWOhODnGfY4onZiTwY74vegcyb2dn?=
 =?iso-8859-1?Q?+9hlivIto2G/Ba3bvH+drfOBiKiEqtifdK35PGfT/LgLEpmsc4aZsO9LLQ?=
 =?iso-8859-1?Q?R++GBOTHniymnFnJhQsMro+Oqj5PGi6gmoBxP4FObHBmoug+/9cZz+u1kW?=
 =?iso-8859-1?Q?45V+2/3OWFdj/j6HMU6jbrBbrCw1hJSctbVJv23hE2/xhfuq8X/L1ljzVC?=
 =?iso-8859-1?Q?LbxnHeUOz9kbygUr/yktK5U5QfQ0aRnzdA6gvnFkHfjlly75xPQjXBfGxG?=
 =?iso-8859-1?Q?i7y2lPy9LIVF4APqEB5Axlcn25AQ9/k133ckcAVXxdTtpXIRi3R5ykkSam?=
 =?iso-8859-1?Q?CVGp87V0lSst1X80n3+H9ErumZreXaEbt4BH+zl2HOsAmGq8QJm2RMlQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3003ca44-32b3-4e05-daad-08dd371ff50b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 17:54:15.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDMkqXWpLNq/XIAmk/BdaDdfsaVbH6VYXzPVKyaOBrA76O9/tj7YBW1nPLqKG3mkW984qONVc8yfSMF52FodgNvk9sWqkbsA+d/Nisz0z6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/17/25 06:10, Dan Williams wrote:
> > CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> > platform firmware has programmed an endpoint decoder that straddles a
> > DPA partition boundary. While the kernel is careful to only allocate DPA
> > capacity within a single partition there is no guarantee that platform
> > firmware, or anything that touched the device before the current kernel,
> > gets that right.
> >
> > However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> > designation because of the way it tracks partition boundaries. A
> > request_resource() that spans ->ram_res and ->pmem_res fails with the
> > following signature:
> >
> >      __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
> >
> > CXL_DECODER_MIXED is dead defensive programming after the driver has
> > already given up on the device. It has never offered any protection in
> > practice, just delete it.
> 
> 
> I wonder if the reason for adding this CXL_DECODER_MIXED  does still 
> worth it for fixing __cxl_dpa_reserve instead of just not supporting 
> this case.

See where that "failed to reserve allocation" message is printed. That
leads to the driver giving up on the device before the bad decoder
setting can confuse other code paths.
