Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99F1311AC;
	Thu,  6 Mar 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292053; cv=fail; b=HvCc411eNlym03JId2w0HWJfNmr6RedztPr+CQBDlDdUedbMwuman3xqrAkNX0dr7ktNv7PVuZPu74GWgGUUnTiCSR+YDboVnsFRYpuKlw1FKyn+wRhhaFQ08pxuvE0JuNRl8yPJGRWEKo4bhyDQOUpwi5G86WQC0KUKjs5SoJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292053; c=relaxed/simple;
	bh=OxB4VV4mdV4PVYEH3dVRCDW4g5jmVHtyJhl6ERLDpTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=upHaUJljmX8H4kLOhF7UQkCeLjtyGsNjlp+tZHxN4n4aK+ZODGq8lqMi5FMCVo4FJMpETt+MmOXyuuglbagPGnwG8NHLzI1L/utfEd2Nq04VA00o1fUaHR1mQmp92azgeekF/PAWiBag1f+yJeIJVXrSBAyIrI8p/glUQkbXNhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOi0AB94; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOi0AB94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741292052; x=1772828052;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OxB4VV4mdV4PVYEH3dVRCDW4g5jmVHtyJhl6ERLDpTU=;
  b=kOi0AB94KmKmJ9UymvorSXlNTivOOOjL4anF0HpVaa3u8yJk1FNV48rv
   P4tXRwjf5kggbLseqM39NaVkPZ6j2CG2R20X1+UvIF8SPzTrdrQLs6Lul
   4Dn3ukmp3/6jTzRhyV4TdfxYKWmp2iSuGBlhxU2BayiBSfxpQvHE0L40s
   lWKBlstkf6v0gRvkz7eRX0cKr2pFet0L2JuZiYRwDxUei2UO1bqrPxSk4
   es9bGTFcz6CfiNZ15jOxjMRExxNRiJcRWjvLIM3gweSjX16+F1KQWa3nB
   JtIAKO5LloZx82IUZoK2xPYcBf3lPvWyjk3QDLO++F06GU5iAhBnZPWrH
   w==;
X-CSE-ConnectionGUID: VcjELJoGQH+qdwo6lBZVhg==
X-CSE-MsgGUID: sOVBFjeyScKSAJTYWpkaXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52533666"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="52533666"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:14:10 -0800
X-CSE-ConnectionGUID: hIh4xxEuRzebTiQkr77Ajw==
X-CSE-MsgGUID: geASumgkSuedwR/lTw5W6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="118958603"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:14:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 12:14:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 12:14:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 12:14:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUuIP0uM9Y7QkHJ2TpmjezAUqBTEad8W73YBRNK9ztTe6CLqKOcsVrUaXFKUUluB2StRDXmRo/KEBuxTYN8lbbQf4jh8HHhKLPQbMyjVnHlMdN4ssnn5aLluxDzcazBcjh50W6q2xEcSeCI53Sew36NSVjv5udn5BTwVgXvpf4JmEBkuMCkVWVdAZwB7R8cGbtITZrdo9OVMAVsGbnrlawrzY7Dz13+VhXlBGWJ/CmzjZ0/l81Ax9/6bbwmTmJn/gmdN2C81f6+q2XyhZZf02r+ISiG8VMpoz2trEYl7Wkve0emrpaDgoUrdD3c2b8QBHTx80FycUFJM0CJ54utZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKcniMA1Ew+W2+DRPqXviCuNW91YH+M1mO6lY9+1Ij4=;
 b=c1Qh46knETvI1h7fjDrgvF9MR/DQybNK9m7B9Oc5mO+oAsOgRf8mwocVZqdhT+A8Cb1o4BLPoIG2riZadZVlFynBkeR+ssmnpYRe3qC+1fCYT4TFZmRu7Tg3+bTOKxashtP2cktl7NrOJuOpu8GIi628jXaKJhou7u5OsKmfsq8pHEi8Et+jIOlrnPMQZWbGyt0+pBpvnXAddnRd1fM8H6w0U2hWpDJBpnogIxkT+HJot7mhyaCCfi2148hY7FBTHS5JM1gdyZoLvxREoYDWeI7PPryjZl4c4BeCTf//OMQ5BTVOjZSYBE1Mo4t6ylbz2HtXcTq0TRHCCQ2ThpLibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5794.namprd11.prod.outlook.com (2603:10b6:510:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 20:14:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:14:05 +0000
Date: Thu, 6 Mar 2025 12:14:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 07/14] cxl/region: Move find_cxl_root() to
 cxl_add_to_region()
Message-ID: <67ca020aef023_1a77294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-8-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-8-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:303:b5::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f285974-3517-4fde-4ae6-08dd5ceb7207
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F1HCW16fSYnHP3f1lCBZqRyjExF8o0CHSvOCr3iRweZU6h1K297UCgilDFja?=
 =?us-ascii?Q?LP8qIkMT8tktHzQPJxq/VxUipp/PaQVEQqdXeiHhV4hdx29qsWOQni/N9OpX?=
 =?us-ascii?Q?o0ZwSykbMuVc92RCYL+GEfs4Z7llqFouAULJKb1SigHLg+ZTorq9iNWdsYe8?=
 =?us-ascii?Q?gybbbIWWfgawYF9HUkK4V5PBcfo79Z/rkIodR5KB8xhjvzNmuBpzeH7Fv/jE?=
 =?us-ascii?Q?k/zZ6xSN1xYZg0ofXfMCzpP5C6r0JQh193B2LEeXFt7eM5GbHt0+2o4Nq0eM?=
 =?us-ascii?Q?9O8nhCcl6sHAXaSgmQnD0LxmiFq+pe/NG5TdOvUr7uLsClM0Q+8RZKYTl4Z5?=
 =?us-ascii?Q?YDmJfifN24xnjG9FaPjHnIb4sbNbSYhsldhdCgco5KcEkFoT4YO53mcvjUTL?=
 =?us-ascii?Q?lotRboL1m8TPdYeccp1mQTBLL7pTRlwtr4FpCSUFT/Zl9+a/wXW1gwSD01n9?=
 =?us-ascii?Q?pzKshR6el0AYrwpS+sFHcrWxrI/qTqfat1rJd3L/LF/UGPgw/C/Gmegpo4uD?=
 =?us-ascii?Q?FnWDvlrdZXzgiITmPlfmYJMcK7bI6jPdiqYX0w/NxnQ7THxvLnjCOZdBaGOl?=
 =?us-ascii?Q?4ir3StJCVQgYbCGjjKyMOZu6uv5iL2azku/Jh3hbXqqpNpYLeUerdt4sBVh/?=
 =?us-ascii?Q?9WnGln+JBo91Y05+1UWBHW/R4FL1xQWFrRstasLfqCG5L2lmN2qzfJYzKcLk?=
 =?us-ascii?Q?xhFQTBvh9W6/ZHPRPv2F1jeDA761IcajLp7lHpTY1ZLgli3hOlZB0A+tUtva?=
 =?us-ascii?Q?vFfYzSsL/D7ji89Hz5z7FqhjR/CeDvyCp3XmbgyZYMmG/hcAoqeNtZprGny7?=
 =?us-ascii?Q?KQpf6k4xboU1EJ5FmM7WDVjd6NPhDHdwZ5xsqjjShrYfGOMDx0zMXCX46Ez+?=
 =?us-ascii?Q?Z2sjSeVEDDiQHyNsjeTKOFglugUZKo/shKla+oeweBcV35QsLpvi7ZNlL7Jl?=
 =?us-ascii?Q?k1RbdHGb9fuC1wJ8ch36FVixGxToadiU3SBdGaqQpx5ujgdOul6YN8XMYg0x?=
 =?us-ascii?Q?cJe+IqG37asxBedDXzF7E3G0I8CSCHdyZYUlIUSPtdB9Xo4TpbUz8DV6bicH?=
 =?us-ascii?Q?AN5HYKNxqZX4XbbKlohskcoXKhF7NbHXmyjBiGLe+NwGjPbjawF9epRaDlI6?=
 =?us-ascii?Q?+eCKZPXW9q2DEsxPVFVb0djz28vQSRGLbfIJ338cnS2F+44SMCpvGZGgpTxG?=
 =?us-ascii?Q?4AvfyyX+bHLIelMnL32x0DjdWu6bZjehqRjF9ub5AwWCTUrVyX3PdNmfBzDc?=
 =?us-ascii?Q?pMAiJYRgyr9tI6LEkRQVciFfQ8GIEYn9zddlaFf9Kvx1pe9JLhwCNicoHJmp?=
 =?us-ascii?Q?/Matdfuco57T8Os8OeXEL8jP+YstCRzHo1OyiARE/kXs0eCynr0CEOwCi+s9?=
 =?us-ascii?Q?K9vm/RAriaq8tmbT2PRV9TxDwR72?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dC7uVg09q0Epc3tDZsMF6WmOTlluozHgRUWDu7FCVvaN1/MXt+k6egkhiPhH?=
 =?us-ascii?Q?m5EeZ5twfa7GhWEJlSrcsB7UnvIV9trRvtAMb5kEkCYpGz1PXuz+rO6fZUgZ?=
 =?us-ascii?Q?0ElRPmn4YiVCPEeqrRdWZj5nXHBuaShaA/E+86y5nFB8oBKzR0OkGXXdU+h8?=
 =?us-ascii?Q?bvRErKYGtJF4foLQh8BSOh+IeaqsyfG6ONFPmIrmjvzmhXqTM0EjIqVM9vnW?=
 =?us-ascii?Q?QBfACG51bjpPOxtKH2NJuTsGNl6Xqdg2/CiAk9qJ6fdlqZTj5qf8d8cm1mpQ?=
 =?us-ascii?Q?z483AVIBeGD8Hvm4SQE9J1BsMhPAiXq3hKucIdbKQSW9kInYerKNQqmWZ4Gq?=
 =?us-ascii?Q?OQyPtGMXxN3q56CJJuXSXOlWQXUOnAyXeDKdGILybdA1sfh2wOxls35oyolf?=
 =?us-ascii?Q?6YX+qaMpPJTLU8AudS0OYWnTG1GWPeRbRP39M4ZkrKSEpZ2jDbIamWDZD1Dj?=
 =?us-ascii?Q?lfSqvEhLpJkUXyTycg2bbcKoPZlNqeVT6qfRhnerpeJ2hCzbb2+aq1us05ga?=
 =?us-ascii?Q?YcrbI5Fmk9AiFycyUYzYqaKIdlixCBKcQk8r4yKdYfN9cnlzPhx0Idx4erKX?=
 =?us-ascii?Q?3ZvcxS2k0/G5z8DQSQC5pMpVw8+wkqivImtDAv/ervzCtSZC807sHWwiPAke?=
 =?us-ascii?Q?m0cSjVCIneBmlOVCOr43mClAQCqid5GFJBaDBqpIsMnsELgFeVVxcZ078G/O?=
 =?us-ascii?Q?7g1DALpS1zdHPCFz8Mb4fEAe2dMQvzSF9nxAwZrFQQLbL2tgQmVSrDpVYS9l?=
 =?us-ascii?Q?vzTtrpmQfHUk3+8rTHW2TVxNLeCXY6SUJcc3+efdTMKJLocGoDABNmG7RoAV?=
 =?us-ascii?Q?WEywwEvK/2Kds6KGlEC6MLukzRyOKrd4TK05brfJ4+jDjKottGMh2DKrmbk3?=
 =?us-ascii?Q?6dXAMevEdeyW/byRW2MvRgy2cW8mvBVREInZzx1E6yM2d4gLKSrLCJ+ZVjY5?=
 =?us-ascii?Q?IR6z7pb24xM9YYRT8T2Ko5XBaoeW3vFX8/d8tvLCfE6UMOWgww0DV9tIkNA6?=
 =?us-ascii?Q?2VrdhCuybwNEblyGR278hHe4xHrBoNu9UIbeHBjNZCU4gXwIEZ3TBw3AdLC8?=
 =?us-ascii?Q?KlwwTO281hmH03yw4ggWLQ8hA63B7NSHiOdv6GInckM1wfzhqbTMtdTfOTYG?=
 =?us-ascii?Q?S8rmRFeBD+zN2BsKFl8svTVHzm2Qyo4M35/phtC5d6UUQxEzJ9ZixzNaK9pS?=
 =?us-ascii?Q?mBT7wedeQ4wcmZiyq18/ymg/L7u6KR/kCJxsSFU/RcCVuJE16lmc2/5iT9pW?=
 =?us-ascii?Q?4XB9vCoyG8MJKkCob+ZqlGCIvlDEVnDuMECCpTPQmPWMKivEjZv38ihMspJu?=
 =?us-ascii?Q?ksMXeOghbfyYk7wxyf9JobrUQUimbQ9fk/uDgzwFpb46snJNr1ev5knoCHxA?=
 =?us-ascii?Q?tORksVwZDFuXu8ItSo464r7m5uJMxjfwqZ1HbTHWNOOczyzrwLI7ziRpNPzn?=
 =?us-ascii?Q?a7cpXm2xD18ykthozqPqp0hrEswKkBOtfDx2sGA0WXOtttsVNhicAhei+FX2?=
 =?us-ascii?Q?BzvK+UnpCF6PUOXzTjgXF/zgDVgzDFi2Dbf0dGEx0zWAmC0ZVAbZXXfT6MG1?=
 =?us-ascii?Q?enW62CkWzh8Pe7tult7FrFxQfg39CJSBzQxooXdTvGEJr6ljeLlxCEeDygcm?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f285974-3517-4fde-4ae6-08dd5ceb7207
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:14:05.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynvBvwgGgisjlUBVGVXZEdssMdOh5SB+qWgNajY3isbwUeUwRUuVDtvS/zrgH5x3HU6OENGV3vI93yYScX6tYvLLjas1XqD3694AxPUmrng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5794
X-OriginatorOrg: intel.com

Robert Richter wrote:
> When adding an endpoint to a region, the root port is determined
> first. Move this directly into cxl_add_to_region(). This is in
> preparation of the initialization of endpoints that iterates the port
> hierarchy from the endpoint up to the root port.
> 
> As a side-effect the root argument is removed from the argument lists
> of cxl_add_to_region() and related functions. Now, the endpoint is the
> only parameter to add a region. This simplifies the function
> interface.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
