Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520742E337F
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144412; cv=fail; b=iJGtE9IcGY+9IdNmQ4cZrBFVymVrL1mxtkL/vhP1Ef+uDt062g7BZGwS0lpkmf6pn8PLlNX/O/KZhOdsR+XtWqoGSp50a8dzQSQtEYe2yulYywAJCPjI5DNYCuAS2W15M8eTIgS/5ppUTUarUCw9W4DzYkFL65TeiNHH/2JqQ/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144412; c=relaxed/simple;
	bh=Ts8WgzCEA8CoAUXjV2pdwokGg/IzJ+vtv1BDKSuHeIk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cvx2AySQE9abNld8BxUGY/rC23ymXwgfWN8XWnyTCdJXuWVJN+AIRajV2HN92CtgF3GanUIyfruibLcn93TO0sRgd3TwFjip9jo3CMGhc9J2izT2JP9qIPhvIm8ixKL8ErJDGNIuPWmJ9GBEmFxjdXYmKhbyxq2QHshlMzgh9ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cK+nC8RI; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cK+nC8RI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741144410; x=1772680410;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ts8WgzCEA8CoAUXjV2pdwokGg/IzJ+vtv1BDKSuHeIk=;
  b=cK+nC8RIJPPchsMNy1J4GPpMtIJ2saCzjb30nTOXOFURpbTYmH9W1IUk
   jBRpFMm7bFILpNEjT/CvaVcvVZbdb8soeg0VXAyaC7+b971cz3i4NiChS
   Q0hYXrHPdcwILI28EG8h9iOzFOGv74w7HCw3QOp4TgCTBgvok9yGW4OL1
   JK6sV2ygBTboDZ8gmRFjpYyU7bmUzKSKC0gMZC377inFMlmaDv0YvnqQY
   nRkh0rADEbnmzn1O8bTXXC1XCV8JxP/kgkg8VfRm4PEaZKbPCIjrw53o1
   wnel4n71mVs2I3HMlOmIYixeiOeKDIIex6CnSvEAUq7G+Yw73kxIbzqP1
   w==;
X-CSE-ConnectionGUID: mrW15FD2SrmKcojLrJOyyA==
X-CSE-MsgGUID: E5XpLRbRQMCuNb1+8aP6Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42224549"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="42224549"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:13:27 -0800
X-CSE-ConnectionGUID: ItBWbS+nSQyCgplAAf6fxw==
X-CSE-MsgGUID: 1yMgAEcVQzGqHOv47gVrng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="119240152"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 19:06:32 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 19:06:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:06:31 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 19:06:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke2vp80UWy5jhYoFHejqe+qX17+NguucTzyt+uXFr+TSv7BHc0INQ9Y9nA17BV0iS9C9NdfNZeWLyVeaocHIA2GfIgAoTV08d+5V3k8bhdXoyC4yW5oBp9yKs53YKt07zfBxdL6LWyg2b+TRx8HMv57hukrPoS4mBetPc0CvujHDMiNYOPoY7myiQhAHOHx+U5SeY7P4YuEfYt9Rupx11SJgFWoraricu7HHGnAbQjuHRxjbFLfNHyMhxu8m2CvAxa3cmPDuMI2zP3HN/VV8/MN/3lgNFqAt8QStMcbwjDNl4GZxYgLaQfDh/zWC98+jsb5uXDZnrQiY83RKPADEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlcTHhABWBbVk0Sn5IVtpgOqB9XPGRcfyHHZiTM2e0c=;
 b=qEEx3KOaU2QzsolxpZ605GuV74wqMTGescIRR7fp+Vqr1q8QIS9MUfqVd5WPhNe+nUpxGufIfRtvrYkXIXMbm8S6wt/HuMppTztoTt6OdBQA1cPsIGxsnO6LJAPE40n/TNZ9gm3aoHdoPaCoBbWe0Zy8yMftQTpBsPfCnoWXaLBgbumUNFXEQ+5itUQ+aVD510pJmVlVdHkADCq1a7cZGkPWNhX5B1L+rgFP3SdPwrKhBNQiSEZHscIBQpDS5OhzqxiSnYadWVML+9nkcvELfltLKwTF115hMxBXKhOvskfXU+MJwAIw2uoa7582OmQE8BoeVKIb4Jo7IiBKtNp8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 03:06:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 03:06:29 +0000
Date: Tue, 4 Mar 2025 19:06:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "huang.ying.caritas@gmail.com"
	<huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-ID: <67c7bfb286ebd_1a772946c@dwillia2-xfh.jf.intel.com.notmuch>
References: <174114125011.1367354.2670882864492961789.stgit@dwillia2-xfh.jf.intel.com>
 <688c24e5-b175-4245-8f60-7cbbe1c7006c@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <688c24e5-b175-4245-8f60-7cbbe1c7006c@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cc6543-825b-4452-7eed-08dd5b92b965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d5oL6lVJOZsXBJnD0eHeQPOSmIWjlLhduT8/QeZws+mzjGWU8oRMVZvfwRaV?=
 =?us-ascii?Q?ldfRzNWfJO183yNXas/42uk13KyR6qwrWtPh4njUyu+6b6xU0qYUlX2l9+S3?=
 =?us-ascii?Q?6Gb7zK7ulZBAD6z8qAItFq1oRazu+9eDftvejZl8MS9At9v0AtrZX+iwTSpb?=
 =?us-ascii?Q?TrqG8vxiuO1veudhHXUFQpJ7d5vnaMt+kkNu0S9Uypv4oti9G+yFvQasOzwJ?=
 =?us-ascii?Q?7LxJRfVX1oOvYgLLhWOtSHjNBO7A2cyeLXkbRRF/go7O/3cQXMhy+KMTkj46?=
 =?us-ascii?Q?bx/RQwin41ru2E7L6QBK6JY3V4Qxf7iQRDP7eAYnQJqPVOKSpehYDpB48q5T?=
 =?us-ascii?Q?+SLBMfU89REB9CAtXxR+NZCFmjRJ+fp5Ucb6gtrC+4llS7SFeOJVn3GEwCut?=
 =?us-ascii?Q?HkyJxsQV4mJFUCPz1QyISPYF6VjK1CxctIImi8nyETa0ZzdEmzAa1I8XdoLp?=
 =?us-ascii?Q?FhfDMQWSjNHA2MCnEPIjf7YOE5DbiQLlXHkfMIhchGu7D6/Zpv+TUcsZgQii?=
 =?us-ascii?Q?FVXOgix43s5gES/J2rD2+9Oc/e5bDOfiCMGaLeLceXN4Y74pqfIJzzzZyszm?=
 =?us-ascii?Q?JSHL43eoTZZsXiF8Dwln5UlA9AyqtJehLc7gsoZFUT2m23fksCpH6SPkghub?=
 =?us-ascii?Q?M6hfOUaUpe4KrAs/uN57bRxADDcnHbZdTQNHrnHlyJV20E+5tr4fyHUYerSL?=
 =?us-ascii?Q?I9PRsOFKWs9xWmSpd691FbhvCaxrqc7nWyRVuAd9Zo0U+OS8G3esw8gEO+2K?=
 =?us-ascii?Q?X/ENj5C2cAN070eZDDn+RjcHwBo9HiJudn3m6W9kLT1JBcAaP+asZXHOUW+u?=
 =?us-ascii?Q?oVY99dODf/SmMZ4+/iD3b+v5MrCMC/M28d7aoG9gqtW+QpI66ISXzuFjE0ca?=
 =?us-ascii?Q?iJYRFeIIvaNW791DCPW3DczBUJnJKWff4IiQ1hNauG1i/VMPRP1KCYjygUPj?=
 =?us-ascii?Q?WFDpaxoskqoKPZZYo1DyOkOjWX8WPomk7bcdk6qX0t1nlmtDls/lWd7IzBVU?=
 =?us-ascii?Q?/8cJ/tx/yhPn3hBg4Lf0NjGRwzW/M486N4QPrHQDtsyFkOsmc0D+xnouVhCt?=
 =?us-ascii?Q?ijxAQXgD7QAkxL9zEy8w5SJ2vmNRVGYpYQ5EDwnUpyeAooJA/vSFSSp5K9bg?=
 =?us-ascii?Q?lGgNPbnE5XCvEdRAiaX1e7lx8ca2zt3E+IkPpPxNqHETfak+ZmqFWsSUBde6?=
 =?us-ascii?Q?64p/cVSObi/KkUtRmWnfTSTdnIiykUA5/2ODfivmo602ce7DFqK/sxMCfYuC?=
 =?us-ascii?Q?Q6NAy06xVn407bgLVdfUfjSlRCXYArMQbLkOVNNz1fCGuaftmuABdKMoRBla?=
 =?us-ascii?Q?qHYtEetTnerlD2hSE1ZuweBfgcbgGz8iFkNwe278oIOzlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VZT00b0qFCMNb1KCH1JiKohqjXhMiwCq9himoxAMxFfaYEjmHTXdWBxv6nl?=
 =?us-ascii?Q?2yqvPStdClBuRh0kRGoGqVjlFw3EPIft48rUYqaz18V3g6qrVE/8LWtidlE0?=
 =?us-ascii?Q?DlzXgA0810fBqOU0xqe+IOf+EWWFpeSsfdk0Dtowvd39tHE6mST2ckVRc0YF?=
 =?us-ascii?Q?2VZzCnZbS+Pr511WQHm24gKGg+ScT0MG6d848q4dJ0Uyc/oj0JSRCBOArOAk?=
 =?us-ascii?Q?8tuKC/9R0d52hnJB7sdsy7kV771gnqE0F9lTXZRT5VxueanE7MW2SOdowQoL?=
 =?us-ascii?Q?sIZY0tRZFmFg65vIxJSzEZaIA0wu3kpYCl/54WAhxjSPYQ0almlfHmi2GAcF?=
 =?us-ascii?Q?3f52x3CFptuQqzsGc7MXBnzEOW5kEjVhWBjfMM98NAcbhJs7Ulp8s0Brp07w?=
 =?us-ascii?Q?45zyirvcFLz4pt7GvC42j4vye7yFfGW8LVa3nCZfz9fiCReo/MVQTie0/Mib?=
 =?us-ascii?Q?zWYjTqa9FvY4BAmVPxDMMZVB5Ye8VBwVwd2q3roP247uLi6e9gqAlPkbQG8O?=
 =?us-ascii?Q?I+xBLhuJXcv0JlbRzMS3SVTvaC2pCPfwyzg41BqD4gu1pJQQgGjkFXbnoF4P?=
 =?us-ascii?Q?TWJ43eva3xQzlf6qBWp6nIfZxld7ZPMeL/TS+IMocYJy/WM0csysfywwTdq3?=
 =?us-ascii?Q?V4ieVwKD50vI9CPXmSlvDzoD8lNBE5fajY5UeRvPUXn94riqxZFcnnlaU/cD?=
 =?us-ascii?Q?MSPYHVgZ30TAfBHnfZ5P+3k5Lpr3bWztIAV6PrWaRVzqFwjNu5K+qrkRC6s9?=
 =?us-ascii?Q?b9QKkkzYCteYkqEYd02syl+c8O6PhbSnT/irWohv+K2x3hEZgIlhVlMQdamj?=
 =?us-ascii?Q?6OOWcigJcVgCGYIWBjr6TH99ThfKy1Q2OL7s4TgMJobQEmWK1+zZqhtvJOio?=
 =?us-ascii?Q?976//eYUhLXkx2UC6eQPJXl7j93oV3FsyQjnAhud4TSiUisssq3uy2dgF4KA?=
 =?us-ascii?Q?TUHlpk42ORvUSbs3aIlRXCbW/C+zciID3+jgLiErgn4ZcXNuC8bclEjCqAAs?=
 =?us-ascii?Q?80ufJYJdQCUr2VEAZsgAFf6XmoTWFlJ0B6CLbKWPbwtp98sZ9B2FBOeZfdok?=
 =?us-ascii?Q?RRti++gEzfRgwlY2gVjcXyiJeYmm4iWObGhaJE+hQyOsZkGiKoO210H/jPJT?=
 =?us-ascii?Q?zbzDL6j7C5aQrZOA46kfUxmlREseeCWBiLl3Rd2OujrTkailxil2YHvyEteW?=
 =?us-ascii?Q?SOIlgQJ4Shg3Nkga9fn+D0dDFIQL02wFM4H4Jcl0wIrBkHeTrw9YB9YOMmyW?=
 =?us-ascii?Q?0OQcI8o68PQxxY03p9WtduOy7Yfv+o2b0yDaaz46ImofBznI5tHEHMkULKZ2?=
 =?us-ascii?Q?RHuP/Dsb8LvKqpoPo1bcA6Raho/fcPX/XLpC3Pr9matZLc8XIgCj57L+nCXz?=
 =?us-ascii?Q?0262ZEe2Nn4CCDfSL5kdBZU2SbNCIs3lKmAKvK9dXfar5b+rDwbewZ6cF0xr?=
 =?us-ascii?Q?2dDjy233CmXef4WGIP6mKgunRnhPgyzYPGH36N1GWr9H+FwVX86EDX5mWuHj?=
 =?us-ascii?Q?QsTa0184hSR43pHydulHT+BxE/9zyWYPMm2H6u1CGfjaHzXYqEpwZer4o93e?=
 =?us-ascii?Q?Hg60D0exArgogVYXE6hNvzcTtzcz/0ilTRmn7EhQgEz02wI/YNFIFpZAocDP?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cc6543-825b-4452-7eed-08dd5b92b965
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:06:29.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8MEYdn2uEsZvLnDxRp0L+7NB0+RuURQGZqydpQYbMPl9MF6rV9s2omleIoMj+YtVz/czxxqEcOPzMImdCn+Fo9aKUDcgpBmhd5WMkBeEdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> 
> 
> On 05/03/2025 10:22, Dan Williams wrote:
> > Li reports a kmemleak detection in get_free_mem_region() error unwind
> > path:
> > 
> >    cxl region2: HPA allocation error (-34) for size:0x0000000100000000 in CXL Window 0 [mem 0xa90000000-0x1a8fffffff flags 0x200]
> >    kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> > 
> >       __kmalloc_cache_noprof+0x28c/0x350
> >       get_free_mem_region+0x45/0x380
> >       alloc_free_mem_region+0x1d/0x30
> >       size_store+0x180/0x290 [cxl_core]
> >       kernfs_fop_write_iter+0x13f/0x1e0
> >       vfs_write+0x37c/0x540
> >       ksys_write+0x68/0xe0
> >       do_syscall_64+0x6e/0x190
> >       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > It turns out it not only leaks memory, also fails to unwind changes to
> > the resource tree (@base, usually iomem_resource).
> 
> Make sense!
> 
> 
> > 
> > Fix this by consolidating the devres and devm paths into just devres,
> > and move those details to a wrapper function. So now
> > __get_free_mem_region() only needs to worry about alloc_resource()
> > unwinding, and the devres failure path is resolved before touching the
> > resource tree.
> > 
> > Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
> > Reported-by: Li Zhijian <lizhijian@fujitsu.com>
> > Closes: http://lore.kernel.org/20250304043415.610286-1-lizhijian@fujitsu.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> 
> Thanks for your quickly fix!
> 
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> Comment inline below:
> 
> 
> > ---
> > 
> > Andrew, here is a replacement patch for
> > resource-fix-resource-leak-in-get_free_mem_region.patch in your tree. It
> > addresses missing calls to remove_resource() in addition to
> > free_resource() in the error path.
> > 
> >   kernel/resource.c |  105 ++++++++++++++++++++++++++++++-----------------------
> >   1 file changed, 60 insertions(+), 45 deletions(-)
> > 
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 12004452d999..80d10714cb38 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -172,6 +172,8 @@ static void free_resource(struct resource *res)
> >   		kfree(res);
> >   }
> >   
> > +DEFINE_FREE(free_resource, struct resource *, if (_T) free_resource(_T))
> > +
> >   static struct resource *alloc_resource(gfp_t flags)
> >   {
> >   	return kzalloc(sizeof(struct resource), flags);
> > @@ -1631,17 +1633,29 @@ void devm_release_resource(struct device *dev, struct resource *new)
> >   }
> >   EXPORT_SYMBOL(devm_release_resource);
> >   
> > +/*
> > + * The GFR_REQUEST_REGION case performs a request_region() to be paired
> > + * with release_region(). The alloc_free_mem_region() path performs
> > + * insert_resource() to be paired with {remove,free}_resource(). The
> > + * @res member differentiates the 2 cases.
> > + */
> >   struct region_devres {
> >   	struct resource *parent;
> >   	resource_size_t start;
> >   	resource_size_t n;
> > +	struct resource *res;
> >   };
> >   
> >   static void devm_region_release(struct device *dev, void *res)
> >   {
> >   	struct region_devres *this = res;
> >   
> > -	__release_region(this->parent, this->start, this->n);
> > +	if (!this->res) {
> > +		__release_region(this->parent, this->start, this->n);
> 
> 
> IIUC 'this->parent' now points to base instead of the previous '&iomem_resource',
> which might change earlier logical assumptions elsewhere if other code tries to
> reference it
> 
> Is it interned?

Good question, it is intentional. I had the same concern that someone
might have been dependent on it pointing to &iomem_resource even though
@base is some other resource.

However, if you take a look, all of the request_free_mem_region()
callers set @base to &iomem_resource.

Now, alloc_free_mem_region() *does* arrange for @base to be "cxlrd->res"
(not &iomem_resource), but prior to this change no 'struct
region_devres' was allocated for the alloc_free_mem_region() path. So
there is no risk that something could have depended on "dr->parent ==
&iomem_resource" when @base is "cxlrd->res".

> Other looks good to me.

Thanks for the review, and the report!
