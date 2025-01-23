Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8B8BF8
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662476; cv=fail; b=L/jVYkuoSrduVwInovkAIl9nCX+K21BxyN9svg+3lMVCxgyOCoIOvHGfPERu/3Ue7voHQcXSoTgrysHdeyNvYksCOKz0zeB7dXP3DtqTDAduZV/2wg7eNeBojSuTQbVzaQbxXW9OJsfPm/XFgrE8Tqxp2Z01VB86uCFFpnn6hss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662476; c=relaxed/simple;
	bh=SlR4XdYgrHVnSHtjf8lVzbWwTgDWzyWpuJtsRgLAx4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3YJ0w+rRIyHURU0PtBpxl2BzcF+R/u8Ikaf1HGE+TGnvPLFItjHyIv6/Rzn91vZE20AGzsJfVP2KW6u+EmRRy+Dcgra3M7pMqVP/TsuYWNBb69XoLXpvyv1m+krm8LA+xOn0YwXrnComWuPKoJEYC3n1ddWeStxQeMPtoxlL+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpRvBMtI; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpRvBMtI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737662475; x=1769198475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SlR4XdYgrHVnSHtjf8lVzbWwTgDWzyWpuJtsRgLAx4k=;
  b=MpRvBMtIGcERFvp3gi1FNR/qRR4TaV+wqKTv6x7cN1RbVOv58cWGPSSZ
   lnOyLvBLNCURnj5IAo1vsbhdTJpDbqZv8eHgzpm8F+dGbG9sdsfTrM6UW
   moRQHjg9F8VLArhiK0+MKGmAZSWwFD8NHZJROt9AqfUn+boeO6I14l+f2
   c6dnc80Zg5BiyEojK6hk8O7V6/t0G65qLIcIvWqKBlr7rjjw10KPnSK/Y
   cUTumYpl999ZWCRL4bRWWMbZJpGowXta/yR8mHZHyda8e89N7sSdx7x+E
   L3a05937NQ61lkLINulz5jnl5OcvSf5c+Dr6P8V6tElnSNGPLHLH32Fwp
   Q==;
X-CSE-ConnectionGUID: v7gfIgnATE+e9vN0fQh3SQ==
X-CSE-MsgGUID: wgIQYVTeRoeAa/fbOqBY9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38440138"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38440138"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 12:01:13 -0800
X-CSE-ConnectionGUID: KAC9Iza5TLSYKgrw+wnN/Q==
X-CSE-MsgGUID: XAfk42SRQ/GAc40Zn32ekg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="107370682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 12:01:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 12:01:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 12:01:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 12:01:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEmsTqLh8NVhOwI3Xl1XWoXMZxINaxoFdx6zWkPcaGzsrP3tFHqvaRaTLkTb/2uN/lzoMhscJLfGocSQKyqzKWXbCNTvohwiyGOxF7Y1z6LihZNL0Kq2nTDW8z1JM7W+pWwzVNvbVNrKCorER4GgCyba81J1lKjF4L91ZkIlWK5EoSppJ4q8Y/wtvWu5T3EFLqqnQdcAhqId/bMvssvleJB1orBS2WZypxV5DA5U2N0KKFq5UEC+McuylJJuoS50fjTIMeFocL06u+IKotiyQhOXHTk/Wabzra1kYTWU11u5AkmXYbindEQAv3uMnh+IofpqMM/v9u7eKVkel6402Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCv13joeCoQP9aOqjpy7eqKUmAmTKsEG0wc9Vm7tFIw=;
 b=btTyfyJzcr9gDAc84jQ7MsrpsNKdpg0OrC9E+/nIV6Tfh89Bq3t8h9Ssoqk35ZPMLVuE2IdGU4lwMQ8fDnugyQ7cEOWgkgOLTnd1bgovIc7QofTd0B2vs0cNXZU3fzbriqDyj6PM1xO4/APbEDWYmf5HduwwTbONu++bjnd3dVgOVdMOYQpXo0pmM8Tu7OKz9TLwPEW5942spb/M1w8xHNqsAVCL37zhEQ9GZKhMAeBdMRJyaTyWXli0BRu4+4a8Z9x47GmykLgnRagl5/0NcA0L0Eg4G+LBGvjxInyTNcH+wbvh0EDckQj3rrLo8Z9OTeUwIOkDO2+aegC9TssEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 20:01:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 20:01:09 +0000
Date: Thu, 23 Jan 2025 12:01:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/5] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <67929ffe1ea64_20fa29452@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
 <20250123155734.00002ff7@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123155734.00002ff7@huawei.com>
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: ee39354f-2782-4e21-bf74-08dd3be8adb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?75vUD2JVo0OEaCDaOiT7qi/BPEsqEKWx8CakwMi1nkS2MqbJQi5sagSBkRIW?=
 =?us-ascii?Q?qf2xn4gik+Gxe2GwzLw+JgeXrmX/UxPGM8bZzLxVs+Q2ub7oSirz+OFqTt4O?=
 =?us-ascii?Q?8Hl5TwZ76/RQGAWmwS/18/uc5IAOpkLn7yQIwNxkWffBdSoR9QlUscIEoKZz?=
 =?us-ascii?Q?phMgMwbun9QNC4KVHYnH1PuZh08Gps19yAsg4oKHWk8vbYkL+llQPkRTnfj8?=
 =?us-ascii?Q?oZ4f/I5WJSxX4yvw4beHuxwjj28OHjQSNOhmxUxO04TmxoI0yTzwweul8en/?=
 =?us-ascii?Q?WckRQQEyEhLtVTzOFTaDFMv5lZ+Qk44BuS5Ts4XfgFTL49QPMm/V7MIp/izC?=
 =?us-ascii?Q?W6ii5VT38qs2oAompOwCSTmUKYrqhNwACYfGtdN4UywxhEXUseXW2h5tnqSy?=
 =?us-ascii?Q?WTXeKnr9SF5HflX3/LKKwo+TGfTgUHVeizXYiSo7V7yeBmI8lqzGLqkH/sb4?=
 =?us-ascii?Q?RaU/sB6i0jqtwUzIFxBoXnViGhA9EWqRDqe388Mbb7w0gGOA0ZZ86AQwJYxa?=
 =?us-ascii?Q?5EvEzBA85Y8S3hiIbpLLb77dnaFJuTrjti/HDbuU6Jb8jCE+w8QKL4NG/jiV?=
 =?us-ascii?Q?jHM92lyEzvT2gIgoivG4ZmrGrf3p0lH3ghrBDIGrdMLkWmU91qidQcVwF39W?=
 =?us-ascii?Q?T4CQYvTf2KRuKgWFQPaG1udH9fgJnHkINndI3wLn5bNmu//bL3qh8VEo2+1n?=
 =?us-ascii?Q?KbXvC1mhdEaPp33ofLtt0Yh177RSmDa4Pw7I9uy1WNsK9qaF2rpW5QJv1iZG?=
 =?us-ascii?Q?UKu4hSRXVPmryaLCFsQLSzSI6ffZDzsupTxOkB9ng6yMZdFw8AksdIIFmAuc?=
 =?us-ascii?Q?NIg5w4hP+UWscUteZSiqvAJic8R5mKQBUbjIzSz52/Vy0AuVLb39CDuXgrmJ?=
 =?us-ascii?Q?opbpQkb6XnLbQBroyDFd2A5PRqnG8GWUjgsRoIG4S9ba/ZU41C1bWACRWFie?=
 =?us-ascii?Q?N7v0xLaEjJUMi2CutU1m2CTOJqCHEo+5BlVVVW3M+nx76WAFD1d3YcJCPLth?=
 =?us-ascii?Q?zTC7y03RIzqkmnEZK2X7kBOCwgq97gWgBwMShYHXtSf3ifrS6VQndYbpPnmY?=
 =?us-ascii?Q?/cLkkclo9bCE8xqo6JgvbbuSc6+RZK5RICEDzHxp/ceO584thPlJ/2Zn5AAl?=
 =?us-ascii?Q?EZsoElF/OzHAfUMwPbUtYM+l4DMi85Fja2JDMDZL9nuy8myJHKxPPNWfBnkz?=
 =?us-ascii?Q?RCiH8RrzOVvgv8q19ZQEqWKWfzUA15OdQR9MTibq1TxtwiKSiM5E7mUlJz4B?=
 =?us-ascii?Q?gyYwmElM+m8pyDVzlRNuR60XHd0pla3WvuqJ2dKT8JdoYpptgMBo0pKee9Bq?=
 =?us-ascii?Q?fkiP3FXnWrT4hK7Wrvpi2eTPQifLsUTuZGEty8/S7SdknpAdHj5dnf/ORKWD?=
 =?us-ascii?Q?WF04z+fCUPqIcRpx70yCbMQqhaMN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+GGhvJ/Mu2LZTXNzwT5dbDrFpUD6ZcmnDzy246jMEFkBgtwO1nBAhozXhacC?=
 =?us-ascii?Q?lnJMRZqx1zBqRrXaEjz7YwaqZJbanCDvCvrUVieQyLUdhGk7OzzrfPP1dQEI?=
 =?us-ascii?Q?nveuCfnGNY0Wc7K1//8U67GoAU/7hn8dyyzhyfTBBYnqmZgIO1GPdcKcgUP/?=
 =?us-ascii?Q?o5P6vOYlNMn1LyONVUuhZxx375aIJsBaLGNIwpFR9VNJqis+RdQos4YOHSYT?=
 =?us-ascii?Q?AFM8cZMKAKnRCV+3PwN2HhpaQBOfoonPzZsBtbasFWwQwYmfjORBlD22rmIE?=
 =?us-ascii?Q?4HstdkJDV4jt8bk6hsIX7A4dhIKPB15JFIfxHClz2b1ya56GuGfznijChUmF?=
 =?us-ascii?Q?nhW0L0PeHxfqYaFLFSBMx6QxRb3c/wbL8mUqyQWqIH3FWyFATtpLEBCzEkII?=
 =?us-ascii?Q?cg8USjcz3GI5/T5+KCunF6inaAKtXQ65wFsO9vqWyQb3FFsMgEnWRwwGcaZI?=
 =?us-ascii?Q?CnJO2emo/6kljhE+I9uL5a9qXfuaB6JYp3OwMEJiQ1uFszuNOO29ks3UgjKK?=
 =?us-ascii?Q?BusCCDwWQPJbXBLYck2e/D6HHQfnXhjSMh+8bTywLdEPksjIwqygMkHP25G1?=
 =?us-ascii?Q?9HI30gTRicKs6LnTbzeWCmFypFo46W+dm+Z8uKPD/qV1Sjx7VmN9ABqJHMGH?=
 =?us-ascii?Q?Z5+Lnn//XbPeeGRJvbkYZN4wC44nP0LnTu8M7eauzltQ0eNdtlUIJ9zOuI2a?=
 =?us-ascii?Q?5S8WudfHxQcb0rF4Jn+1SW5Xi89z03rU08ZTQTm1FnMjuLrRqVPSSmxVmk7O?=
 =?us-ascii?Q?bO9PDF2R6uKubBw2/0xM/VQh9OFjAXcTcejh2FTWKihrH5QcWVUrol6ES+dq?=
 =?us-ascii?Q?lyRRwDk+q4Adzz5Pa8HBrJhZ6wLM7Tdxmf9dCxZIF3GV6mVNaV7LpOWRoqz4?=
 =?us-ascii?Q?XTjwDszC1uhM9r53ubDloVHOcRI2uibLenX1CJDSDsTyu5u9fv8eXKeZkJDt?=
 =?us-ascii?Q?zwHnAuodc+rxeHwQoI3aB4jFnFU6Clk/n2CfVh52ye+0ISdKRFP4YvBT8g6C?=
 =?us-ascii?Q?tl8/E2bBTkg2bme9rrPV2oxwe0/bhKGcIyBlCrAoC8YI3zNYPskSCtgGhqHm?=
 =?us-ascii?Q?NtWeNYmUd5sZtu1PpVDOveEZoQObzjrT8mm1O2c46X1vnnE3CS/HG0uNCz8m?=
 =?us-ascii?Q?tc137Tx2ECapcjTl5yQpynvXPClYuGThhZ8NqzcPCAbD46jJpJ08VZDi4+5d?=
 =?us-ascii?Q?XllkD1ZzEVEgMmyLB3gP4iHOzH0jEkKqXxeDpqOevw6/nHdhz+t8x6QGJFUO?=
 =?us-ascii?Q?XKio1i7i6iQWb9KTsWjJPyGgJvJCn+qybVp8EueTqQbolzspe7g36+eSInDc?=
 =?us-ascii?Q?1Ygz31KNd8RYBbyCJYItPkZvYxT9Ikf8tuesv9nURSwCxDvcP1+gexY5uCUs?=
 =?us-ascii?Q?GTkUg5fLlHDpw4wVz5HYr50rOWcMsnBkUrTCRtW87I1IBANfCLLLM++k8Wz0?=
 =?us-ascii?Q?r4xqag3v2OwIwzJ7ZGcdu27SrXNXt0qKvL4gYa+sCt+5GsewQXJ78REjq4Gk?=
 =?us-ascii?Q?o/u+Hu5I6129AvXwGz328GnTwTOlbiqkWSk5kOUha/3+GV9b0vRm9Su2mYU6?=
 =?us-ascii?Q?V5soYjjUSck+Ih7BNydzBQooT0FErgupiREXYfxEV54sT0+72hFx2uGqU8Pf?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee39354f-2782-4e21-bf74-08dd3be8adb1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 20:01:09.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khYhp7OzKmIt+AC5W2TGwNA7IuuDDTQDcn7ki+AKwAoKRQl7RQcP69Hgouj7Mv51rK5pQ023DmzSGGyNyq9F3piOkfsQVHpoS6FiUp1RzYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 22 Jan 2025 00:59:21 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
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
[..]
> >  	xa_for_each(dsmas_xa, index, dent) {
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
> > +			else
> > +				dev_dbg(dev,
> > +					"no partition for dsmas dpa: %pra\n",
> > +					&dent->dpa_range);
> 
> This else branch looks less than helpful if I read the code right.
> It will fire at least once for every dsmas entry implying no partition when
> in reality it is it probably matched on next partition.
> Probably want to break out on match and check if i == ARRAY_SIZE(partition)
> after the for loop and only then print the message.

Ah, true, good catch.
