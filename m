Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490018BF8
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666292; cv=fail; b=UXLxF/9l4GkSHMTMVmo6/tdIct5AiCjUmr6bNJjxm6PFadgDSzlk3tK+CbuOauBPdsx1h7wR5+HZ3BcRhCTUYNsC8rlCMH6xl84A7O5tvj4iJ1jwTJOiAK1RGh1YxUMcaAno3aKLmNI1qtcXK8lgxTp5bJogCkjsa03ygyozs68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666292; c=relaxed/simple;
	bh=Dhm3sR9L6rb1vdXFsgrBen8w5m4ycFGECwiCEaxkDVU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L7IC3B3UcFjjQ2WX8zP2Q5DwObmAtzdEfh1GNukbi5tSydgaY99daasrBCkuWQ4GC9T8tvhQiOl4i9G6QSUUpureKBMWK+jdgq3f+9cTBceqmdyAS5r5MJvnSDkDBcnK59gvG/wDm3YNqB7vunGCDwHUAlgdj9fSj2XWzr+NZ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GibcLn4u; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GibcLn4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737666290; x=1769202290;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Dhm3sR9L6rb1vdXFsgrBen8w5m4ycFGECwiCEaxkDVU=;
  b=GibcLn4ulGosU5kPF8CGbmxtogmmuOUTid6eIKgKn8QwtHP7JuIpaXwY
   Wk5IzQCCHm9k2bnrXx47cSATSQiJXeB2jaU0z+Yw588apQF9GIywmZNZB
   IPcvjT1L99R4fJJJTaj4mLC1jnPUnR91i48dv4DZZxoR+XX3U9zmiwnn3
   fOYJi4F9g/32Q9UvtB9Ewpage8p7HNwizxMvOOVZhQaRFzztJMcx1wvcW
   rF32oYYI9ZAAuzmDcvkLA+dA+sQOYU0CVk3Pz1O6ZSHbeuYFj6b4vH8oP
   HE8bX2zRqbsVyDP0PcypCh7Luqp8j4I0zLfJLnzwSA+p8pl34XYodQRqI
   w==;
X-CSE-ConnectionGUID: stZwAHiAS7ylK8a+8v6u7w==
X-CSE-MsgGUID: CqbVLclfQcWOHgDLq3T0dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38445361"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38445361"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:04:50 -0800
X-CSE-ConnectionGUID: 24oZQ2vsRHKyno1AxXs+/Q==
X-CSE-MsgGUID: kzf5S1PIRtSfq21DoRLfug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130872844"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 13:04:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 13:04:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 13:04:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 13:04:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjWnJ0e5yBiSuU2rJA8j0T9lr0kTC8yZMOZ5E20nmx40nBE9cL5QgqjfcKkwZahuB/RFFjFZXtujYyLaMI84JByYNWvNFRZIgsc/cC/XTn7i0UK+PEM7TJH3QJk0GwEhDwyvIvqi9cPhWlD8Z7cRwjfReYli/+DxR8mUjW7WOIq+BjmoVnc7/R3xNHx5UBb8LgN0mibzwwJP/4g0yUR89vfeeQaCOp76YwWCG3U+Mztrlz+D1AovKa8OsfxgeWK2n8gFqfz5VxE+Om68PjSqpWcdn9u7FhQUwOwZl5BMjCQsTWQK8GRqVTASDs7/Y5dafe1LyMAMTJ5OldZQ5gr+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mgl+O+iFE8P2TBFtkKGx+1aB4BEooZG9yr4vdMaA/s=;
 b=jsyA2ZE2R0YQGaDricYVMg1AMKs7TQbk2uHjk+GzuIeyjydBe5rCBDxzH7ZU2hjafqEOKP4v4SqZAZt3B1sNJQ1FX/g+5wOGKuZ8JP6dAf+jV2j2cD+Fi8KB1YLk0icOiscaYJ8JEWrOdwvsfkIj7c5bXl9B7fV3u9JeUUhd7c9vxlmNb/rh0D4Tk704hPHaXKdVVEGVqnYarPxAF39hCF4qRnwB4MgETHrH6UaaD5dNvEoggyJ9Z8JzQN9zwYXQ+bBhnToAqsul47G7miGB34CJeDfHCJ74kZiKpzoUu806olamhpHtUkhuKlqvAWhijlBIq/S4xCyA5eBCTjHRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 21:04:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 21:04:33 +0000
Date: Thu, 23 Jan 2025 13:04:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/5] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <6792aedf7fb0_20fa294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
 <0ebda6db-8431-3ef3-9c24-d19cbec7f338@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ebda6db-8431-3ef3-9c24-d19cbec7f338@amd.com>
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 535f1ff8-fb41-4fd1-74f9-08dd3bf1891f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?GhEJh1Amp6lCt8wL2strBSMEMgsJBrN3PTRAV8t4wHPCbsRAtRL3l95JaA?=
 =?iso-8859-1?Q?IeycYk5j9/7EU9nfNkhKk/UAZHNhvEr7HSAXjuzBDisZ88j3qBgdRt284y?=
 =?iso-8859-1?Q?9ggIHE+DFZigZHKyohmVRYrUma1hRPY/jk3RZah8sUOhsWB63mAxN9o2oa?=
 =?iso-8859-1?Q?Yo+0Golfov0lXr5Yo+vfcE7yNqGIwh19CSY0eliJd/ynz2dd2RZ1fREbDL?=
 =?iso-8859-1?Q?VXf9Yg2a0D0SefkqcjILWWcej/ou17b1s1H/Rn6FD+WhBLSnRDn4qO2hTR?=
 =?iso-8859-1?Q?0dSRqHgbMcpmPYOhpjWYcgn1xZiAPKawpzDtF0w3dIqtKxRgzVmm5/krbQ?=
 =?iso-8859-1?Q?6Z5qvhU8zXLsVYELyZryXFY4ZZGMwtnAKSfATCXK8P2nDIXe+ZmbzL26/n?=
 =?iso-8859-1?Q?jxY1RiXafS+jQtQW+Wawj7spwkmObTJskqgTLlwuUrRW6A8SM5lSbsXaNt?=
 =?iso-8859-1?Q?dM1HF0FpsM63izJMG10xTrl4VuWjWjod3W3eQiRi1x9o5EAy3q2ZSDpqf5?=
 =?iso-8859-1?Q?acdRGmEV+ZoqK9Xh8xBf8RZaSqQD79JaogI7OzlhYRp+0/tkc5XdyIAfl8?=
 =?iso-8859-1?Q?cEiM2g4MrQsB3oOjBbwf3YTcFyr/P+nix+YkOsIDSy7M3aNywgb3RdYUGK?=
 =?iso-8859-1?Q?PWBvnkgog7ZDylwrgv9DYYKi94l+pmN4C9tD/rv+hSQKUwZx8d47ns6AIv?=
 =?iso-8859-1?Q?5E4JB9NFgtZNOYe2jjHPh9zYaQ+Ip8sBDqIqYLvGjzF8JcEXPuVPwJjRWY?=
 =?iso-8859-1?Q?cC4UfEinyApxyQ7CALglpwJKM4yEQEtqgZEuGj8/pvpRfFeacX8vKQNUBo?=
 =?iso-8859-1?Q?1zWT/oaKdRGURBk1keCUA+tZSeuA1uyUBt3ipdG4nfel3ijn2bzVE3wIhd?=
 =?iso-8859-1?Q?P0nfr86Ju00B6s9NRJ6LKWl30TPyrcGyv2wthoH/r8RmMWgMO0m1KMJB5e?=
 =?iso-8859-1?Q?L+HVf7qFmDOm722pA6odYzWd8qls1xXNAQaXFqd6ojnZNyTIP7CnoEUOmi?=
 =?iso-8859-1?Q?MWCuhCHQpsUVVT3kIJhNJWeqzFyaETkmQNRuKf8L6pC2Kh41a/p9w3H9+f?=
 =?iso-8859-1?Q?5Z5oy1eE9ok4aC3In8vAbAzCWRG2eHfE/3nUIfOjbNWOCcrGocP5H5sXdc?=
 =?iso-8859-1?Q?Q1BUb8oWi2ziJHSZ0mQjTsQVL5VbrjsbvHil/IJ6CNJ4ogIdwGh7SEcwtb?=
 =?iso-8859-1?Q?jxUxvS+5zZp1uiWbIwKG9aghVfA9igvmxyf9IvHPJNIWIUdxx2nyetOYHX?=
 =?iso-8859-1?Q?p+2nLVjjMW2cG3obHYEgayiuaLSbvNcz/ex/Lq+EflGYrIl1iokch751Rd?=
 =?iso-8859-1?Q?Gq51LInaxcFl0wCqQjFTpjpzWTMn0s8mhL6Y3F5g4f/lDF/485krZBsF8P?=
 =?iso-8859-1?Q?IP4zdqysu3reBS06a5sDqnu4KvZkM90Fx14+L1SAsa+HQbjcG+boQvxeJu?=
 =?iso-8859-1?Q?46cbEtLaQt62RPs8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CHdIjdZvd5wR+mU27eNAKpmEay9sb5UQRmyHNJwcInU39di8Ml2VFjhwsN?=
 =?iso-8859-1?Q?wdUxJdgQ6uJSlBJLBbcXwHrOl5VLvCCHh83HcOa5I0jvPDaXQo0gGKpW/Y?=
 =?iso-8859-1?Q?HhQREiZeleD1I5gbj4M3vJnC+acUe1vx5agT86ALVeIBu0ddG+/1BUvoOf?=
 =?iso-8859-1?Q?C1p90w7F6xoCvGv9Gg2Pye9O89lTVGjtf5fTr3t9+aee+m6MPDIddS2YXa?=
 =?iso-8859-1?Q?qa4Pv3CYel5bQGnwN11DksFQyUB9e614344+92B2fN0D4VXaGPlbtCDfhA?=
 =?iso-8859-1?Q?CF3m3RbL7OmGZFYu4UNRtAMAk6O1KYYe1H+4QDGpzfLa20FWaX3rkJ89kK?=
 =?iso-8859-1?Q?ycm4nt8R60sJWXYXcRI/iWvLXGdmlPnV5YPlUFLHlJ+YZFlIOhpG2q2i81?=
 =?iso-8859-1?Q?oDWsXszxpgC4XmEHuWw3eMTHUihY0JmGuY6KvERiO8YKyGajmDaWtFyTZY?=
 =?iso-8859-1?Q?yxDIEq9pycgysteirX5nHxauKgYn0+m7EBBe5aJdBzjnqB/H2/dcW6gFEv?=
 =?iso-8859-1?Q?3+6m7+lh2CNvLX5oqHfLoysZkgy7OFmp7nm44OrhalouTrtJbeDSANJ7uU?=
 =?iso-8859-1?Q?WNZOzECbRnbh3B1FBH1cDPq9VJ/RhcHTK5JjJMSiFn8DPGzIb7rdGe4pUD?=
 =?iso-8859-1?Q?iYqXwZf9cz5/GJvx7BmleUpK9ZF71FXPvXtHzZAnSCWxhQUNVeCzllJm/E?=
 =?iso-8859-1?Q?/i/LZqKHr83cArKKMYgtzFRmajuIgk9MXud+jjbKi2KNyPou7Kajq9tRt9?=
 =?iso-8859-1?Q?OhWZO/1xLk2ejDh+/j4+WqETMJTPC6bmdkXLeJqz125s+CtORBr5LaRrDD?=
 =?iso-8859-1?Q?vTCFb/NJe+gbZROEfsI6ztuVgMuP7WzhS/BnWMpGvpXSea9vrTyUMd6Prh?=
 =?iso-8859-1?Q?JCP1E7kc7n8ay8zW4L5UcLU7k4OsQeYLtLxbdWWuUhMFDbMcMqq6yHmle5?=
 =?iso-8859-1?Q?T54KT0FgbWiyLF0weRwNbgVbqy03dl6iH7jRoeabwrN5FwI6k5Y6DyEr66?=
 =?iso-8859-1?Q?V4mV5okDy3nQOH7hzlAgzuj7tpb1Rfv/mGiS2vEnQzt9HObLMgCvBPULxT?=
 =?iso-8859-1?Q?4Q22gy+R1RsMrYRdC8CYNeGzFgyAZmE3GY8BeaFexRsHzYwWd1Dc3hCwUU?=
 =?iso-8859-1?Q?fVtsTdlLVwVwCLL0Nru7Iz4ViJKv9iz57op9LEVRcLZ6SLlt3QUS0Nr2jM?=
 =?iso-8859-1?Q?7/tEdL4E/nhH14t6P6r5eYZW7/LZ8x1pyQakD18z3uod7tyZP9hl9djXQd?=
 =?iso-8859-1?Q?FlCtWuz9KlUeQHj0gG5gSyLErevdGNMuFWB7PPcUsOW7dN6wIPS4IV/wlq?=
 =?iso-8859-1?Q?1Cbo8B9PW1SXTeAcJHKkvnc6qVzYukjU6dfcdmUUrndYzyq9qefaAsh7Gc?=
 =?iso-8859-1?Q?+qBirKVb1oJ6wf3LMMB9lvz0vxSUiHAo33tEkti5ddfWV/YZRls0h5VAzt?=
 =?iso-8859-1?Q?kTJN2GQjO6mtNrJz9Yi3uUBLCGinpQEHOS8/UKX3owhyVfiZB6j7r/pywr?=
 =?iso-8859-1?Q?SQ13WwtdzeHS1QucKwmT2tujnlERESFmdzA+UC3Ta5lR/4D189g11EBLMQ?=
 =?iso-8859-1?Q?QJet6wCiJsnnLO1yXoC4OCWma/xmHIrL5lumQ3Kjvt8eiI4YlZQykHLB/V?=
 =?iso-8859-1?Q?CzVd6/h6wDf8RKJ0FTt/Q5BajVbnjLBCN4CZzBZAK1X1LNO/ZKLdS2sg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 535f1ff8-fb41-4fd1-74f9-08dd3bf1891f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 21:04:33.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CylAY+WAolMy8nPr3x6xaYFF3+aRZA5jMuXz3UDhWgrbzKpjPFh0+ouT/CtqJ1lsABj1dMeZSML9PIZmLusb4XkQ60HLy4ahxLQzPYbhR7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/22/25 08:59, Dan Williams wrote:
> > In preparation for consolidating all DPA partition information into an
> > array of DPA metadata, introduce helpers that hide the layout of the
> > current data. I.e. make the eventual replacement of ->ram_res,
> > ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a
> > no-op for code paths that consume that information, and reduce the noise
> > of follow-on patches.
> >
> > The end goal is to consolidate all DPA information in 'struct
> > cxl_dev_state', but for now the helpers just make it appear that all DPA
> > metadata is relative to @cxlds.
> >
> > Note that a follow-on patch also cleans up the temporary placeholders of
> > @ram_res, and @pmem_res in the qos_class manipulation code,
> > cxl_dpa_alloc(), and cxl_mem_create_range_info().
> >
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   drivers/cxl/core/cdat.c      |   70 +++++++++++++++++++++++++-----------------
> >   drivers/cxl/core/hdm.c       |   26 ++++++++--------
> >   drivers/cxl/core/mbox.c      |   18 ++++++-----
> >   drivers/cxl/core/memdev.c    |   42 +++++++++++++------------
> >   drivers/cxl/core/region.c    |   10 ++++--
> >   drivers/cxl/cxlmem.h         |   58 ++++++++++++++++++++++++++++++-----
> >   drivers/cxl/mem.c            |    2 +
> >   tools/testing/cxl/test/cxl.c |   25 ++++++++-------
> >   8 files changed, 159 insertions(+), 92 deletions(-)
> >
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 8153f8d83a16..b177a488e29b 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -258,29 +258,33 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
> >   static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> >   				     struct xarray *dsmas_xa)
[..]
> >   	xa_for_each(dsmas_xa, index, dent) {
> > -		if (resource_size(&cxlds->ram_res) &&
> > -		    range_contains(&ram_range, &dent->dpa_range))
> > -			update_perf_entry(dev, dent, &mds->ram_perf);
> > -		else if (resource_size(&cxlds->pmem_res) &&
> > -			 range_contains(&pmem_range, &dent->dpa_range))
> > -			update_perf_entry(dev, dent, &mds->pmem_perf);
> > -		else
> > -			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> > -				&dent->dpa_range);
> > +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> > +			const struct resource *res = partition[i];
> > +			struct range range = {
> > +				.start = res->start,
> > +				.end = res->end,
> > +			};
> > +
> > +			if (range_contains(&range, &dent->dpa_range))
> > +				update_perf_entry(dev, dent, perf[i]);
> 
> This is checking if range contains dent->dpa_range.
> 
> I think it is just the opposite.

This looks like an equivalent conversion to me, what am I missing?

> > @@ -567,6 +578,9 @@ static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
> >   		.end = dpa_res->end,
> >   	};
> >   
> > +	if (!perf)
> > +		return false;
> > +
> 
> This change seems to be an improvement or hardening. Not against doing 
> it, but seizing the change, the function can be simplified using the 
> parameter without any local variable.

No, it's not pure hardening, it is actively avoiding NULL pointer
de-references introduced by the new scheme to not track empty
partitions.

I.e the new to_{ram,pmem}_perf() helpers return NULL when the partition
is zero-sized. Previously this code path would do range checks on empty
partitions. 

> >   	return range_contains(&perf->dpa_range, &dpa);
> >   }
> >   
[..]
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 548564c770c0..3502f1633ad2 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1270,24 +1270,26 @@ static int add_dpa_res(struct device *dev, struct resource *parent,
> >   int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >   {
> >   	struct cxl_dev_state *cxlds = &mds->cxlds;
> > +	struct resource *ram_res = to_ram_res(cxlds);
> > +	struct resource *pmem_res = to_pmem_res(cxlds);
> >   	struct device *dev = cxlds->dev;
> >   	int rc;
> >   
> >   	if (!cxlds->media_ready) {
> >   		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > -		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> > -		cxlds->pmem_res = DEFINE_RES_MEM(0, 0);
> > +		*ram_res = DEFINE_RES_MEM(0, 0);
> > +		*pmem_res = DEFINE_RES_MEM(0, 0);
> 
> 
> This is a good example for the discussion about the  patch hardening 
> resource_contains. The initialization seems fine but IORESOURCE_UNSET 
> not used.

To the contrary, I think these changes are an example of "updating
resource_contains() to check for zero is a band-aid that does not fix
the root problem".

> it could be argued the resource is set, but it is a zero-size resource 
> leading to problems in current CXL code.

I challenge you to find problems in current CXL code after these
partition reworks.

Passing empty ranges to resource_contains() (and don't forget
range_contains()) is either a sign of a confused caller, or a caller
that expressly wants "contains" to return true on empty matches. With
these DPA metadata changes a primary source if not all 0-sized resources
in drivers/cxl/ calls to resource_contains() are eliminated. The new
cxl_dpa_setup() arranges for any walk of cxlds->nr_partitions to never
find a zero-sized resource.
