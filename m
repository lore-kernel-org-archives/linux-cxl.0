Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157B189F3B
	for <linux-cxl@vger.kernel.org>; Wed, 29 Oct 2025 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701700; cv=fail; b=bCHtIN+YucYk6Oa0EoNCgtJZbSKjmBiF5wodNVyoa7qRQmEPeCpEjt646KjVRLaDS8VHChdRAoXs3P2mXW9NMRri53oPDdGDbZ4h4htNn+Zh4yvw8TrfJm/FGFq54bsC105z6pgL6+zrYUo+dGbNE6Ud03dLknFe8qrLO9hMYuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701700; c=relaxed/simple;
	bh=jDWYyYiNAOeJMMkFPc7fMqkuGAeugBfhbyeHWTIlDFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VtEuVx0e8Gu8SU9hqKnkUlRj72wENp9JpmpOmjl/HP0+9Nhv4Y61K8Y0/ySmPeWM9kakLRmeTlflG4/Lk3PkwcI4eHJPazmapCOTCnlpvVnl/y2c+6l6ferpjYSUHF111JuQSn3ZW70zTMU9VPfsOjXP4hlpKcyXkBpJzz7MHYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWSUzR2/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWSUzR2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761701700; x=1793237700;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jDWYyYiNAOeJMMkFPc7fMqkuGAeugBfhbyeHWTIlDFM=;
  b=cWSUzR2/kqvB2xij1SljfTYeGDwGDT+hLlY1n3JHLMf4ujLRp3+tCe0v
   c7JtMPu3rAmR4ZHP7KqRSstqaiCn/KIEC06MFSx8RswJh0mpgkQqj7U+z
   RP59FA60Ud4qSEykc4VIO8AJxZBceQ6ij6Ww7ybc/5ZL/C+z8Tl6MXRVv
   VpZpG5RLpYo+jNpvmxxsEeVfZxdeC+ijCbcYSbyGK3nJIJX0hblbVHyqQ
   UtnteW0Izg2zUhp9Yf9oETjg0u57J7ybZdCfMRWHu6ysIPLtyE8I+ElVi
   RKJK6lsn+W7LIsqrc8+x5tqflZdrS2PaE+1VQ+KgQzpeLbFLUPxSDdu1d
   A==;
X-CSE-ConnectionGUID: GlvcF5N7TducMMXhuzUq9Q==
X-CSE-MsgGUID: 5H2+FBzfQUqwvPjKxUIMzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81235574"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="81235574"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 18:34:53 -0700
X-CSE-ConnectionGUID: S6rRu6uZR8izotX3yc92CQ==
X-CSE-MsgGUID: 8NLAZxb5S4+v89nibJjfbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="190696185"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 18:34:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 18:34:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 18:34:51 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 18:34:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKDst+DCZCCIKbvMywkFKEF8/RusUaXbbgew09RcX3OpJbRfNzQl/A2yIHF2bTp1r/TDbYDrmlUiz56Wvmuq8P+ksjYnnIBULHZsysDDyu5k7dDVK+g2Cy1vQPnYiX3fSm1QsOrCiovp67AuGJXrmv/HSW1J4Zk8KaRpmIIt+L1ZdQHqvSDQ31B71Dk0eOuHHNa/dY/WL3Kg9NPl16HibytnLAlBRcKEvVibktXP+LBaZp8O7/cmnwN3S1GUXdE3NmgXi/pIOCMUDrzpU/6aDMU8KYl5w4nuJdoYjhZzHmFc/luYLhdx6jzkaWL9OPDziJ/Rb211xrPK/3+k/r/Blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l+aQBUw0EI31gPJxOlYupS/GoslrVfwOQKB+ixebGw=;
 b=GTLt+y0s3Ovn2yPFLnH8Gb0j3jOJzsTz6b6rhyBSqHlnHu97VjtNJsgOlTZkJzAQRpkYXxJ82w4Mb/9BSKQbY4RkQ8UZOEeECuLFCh1YTPrRN3sBeFzvP+V2BDdBJUo460iA0mXwaVhy72NRGTFHqiHrLR8BAI34vjWTRRDTHI0/4sJe3gdLKlYaWuBqjxd2qT9ftfDPEK5SnReiZwTzJuKSKPEnAdovh4TKTGsS5jNsYAQYhN9FovYHtber3eFEYZPnOYGTxSlqPF6lJomfqtnTAKOLqem6kPBQ7iB/XN3Dr0wgEc7jMyc0IxpPg7oKzSKo2PwyJas58oL2doOV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 01:34:48 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 01:34:48 +0000
Date: Tue, 28 Oct 2025 18:34:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] cxl/region: Add support to indicate region has
 extended linear cache
Message-ID: <aQFvNXZCEYHe5OE4@aschofie-mobl2.lan>
References: <20251022203052.4078527-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251022203052.4078527-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 135e4a80-e4e0-4da1-a655-08de168b5923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zN8KOE+atwVeHiwLBCb2rRX6Nq+wXrlTN7HH42BorXBPFJqvuMf40u9X2jKL?=
 =?us-ascii?Q?/KRx7z2LEwG3CrOpSfiLDoB71W7IgXpvSxoMw2KZE7jBRdMnL117nwQwRMua?=
 =?us-ascii?Q?14H2KyKgosk8pQXWZh9fddb37/Iei/8m7mqY7k78uXbcy/y37VoG6IDsuq/X?=
 =?us-ascii?Q?A1BISIhOvwHOEcTEC5EvJW6/d83jy/xdLPKXcmyYeLNolUEVnTQrfsTlqhsm?=
 =?us-ascii?Q?/27601oyDYwGBwfNxhzNmtsDyMXHH0NBYlqLG+DtWcagV5Tvlk/daRF0grjq?=
 =?us-ascii?Q?p81GfhmSHkT7EG2ByxLiIYbC379IHEwoQlPg0gdOk5iqG36TF5is/hL5jay7?=
 =?us-ascii?Q?oMxQ2u1C9v+0PEp3nX8ncvy+3qQb1KoqHkjUXS1VccDaOslEglj3Ab/pba82?=
 =?us-ascii?Q?kYmrjSaZj30VAt5MGCNkvw8JL0SW3QwBkhpWj6K2JyDObNaik0M2/MfHrJHS?=
 =?us-ascii?Q?iv4Np/CPef2V4oWKYErYyuOkkk2tJgkZeBzyb2VN0yXbgDLDMC4RemTI4hvS?=
 =?us-ascii?Q?cV8FrTrTfe6IFBsloCsHMLL5VyeiECKrnvNTbrdfCxfW25uhSgAtPvYKeDYy?=
 =?us-ascii?Q?01TS5clyXwlVT7LCu2lnFcpJvn+XJGQYtmet8bBJ7RqJuYUCqEnPsGQrtTTk?=
 =?us-ascii?Q?U0Zr9kkMtrwwuXBZ+hliGITukFNHzXB/IoVg7JPO+eHz4EokwH5MNEuiRQ+f?=
 =?us-ascii?Q?V3QE0dwu6ytxRsV4eXNcwJmcNXNAiG23jDoUy76rktXjxy5pirMGNxAewHgq?=
 =?us-ascii?Q?mXOjix3t7CgxhuA0I2ALKOJ1Zc73ZsGxtvofwHM4IQmgYt0IpVdCppVSTvNp?=
 =?us-ascii?Q?CeAFTO9wBe+HUbYCzKM5tKyhqbi86QypJcbq7s4RFXLvDGLqK40BW0ZeOr7f?=
 =?us-ascii?Q?ExxzfkXJmCDv475+nukNil8KSuNyalYAukbcIwafLx2rz3XmDWI5zvHdMop+?=
 =?us-ascii?Q?Xh3JjTj0Vqrl1rghvB2L/mAnbDQUHQYNjA8lwVjCq9v12SEZqSQAETWek+Mm?=
 =?us-ascii?Q?qYp3NK8Mvo6jYHvRJP/qnbWapgoAmGSZAEkVqc+n6Ee4TUgxsjwmnwUwZu3a?=
 =?us-ascii?Q?TGcE3uSGqplAdIPJo/EwdmkT3+DZenwwFzQqEApdyV8A79OPFlmrwKPmVt7x?=
 =?us-ascii?Q?HG8qvKQIvdJ1Py5LblFD4yQoAVhzgQMunF5Gnhn6lYrinYf/32NTCoVpaIPQ?=
 =?us-ascii?Q?3aJCFVn0tRVrYJu6KqLS3kpPLmGavARmASXXdEl+hjmAbcsb/I+68oAoZEtc?=
 =?us-ascii?Q?aoejgDj7QZK0gEaDaAX0KM7VqCnSBAyGorJgy7ZQIczi+yXF3cm5Biisxb+O?=
 =?us-ascii?Q?KO0NkvruScCzZRYWE2WP4cjGgOzyMrsdvNwilVYfpW4mRO/HepqyrwUCJ070?=
 =?us-ascii?Q?pyJvHnDObDmpVt1Wcv8v4glqyqtM/54FZlm6uh2QUt3mIH/nY5EIw0elZItO?=
 =?us-ascii?Q?8Ys/FHAH7hVv+hVR8Uh6BnV/32cWFm/Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ng6uKgvKU6iLBrRYiKrqyNNpLixESb6jhSzKnpU7Il82vYQtxWdK1ZptBL6F?=
 =?us-ascii?Q?kyT2PSrnrzu6lQ7WO5iL17uoTMwYhtH33csVXtMINeIE0OqFn4cRiN+JRydE?=
 =?us-ascii?Q?tVHmatozrBQrGqCGgGCmUvrd3IiiA/e1U8CZTNWZAFKjKQfNgqKkw1aULBhQ?=
 =?us-ascii?Q?FnCeVTMPIzW5f2Qf39yHdAe+6ILVaT7pKKuRvfOIr81EwNpGGLqifjqcZvF+?=
 =?us-ascii?Q?2AjmyzD6rH+/FNONGNM7aIZscTa76+nXPYa6EiPsjzHqLZRelnuY32qjrvH/?=
 =?us-ascii?Q?zm/F0CFePyXrnHFy5fY1DPzWYWJex/K8kbG1VEg/kQAN3nP4psRWlX8MyncH?=
 =?us-ascii?Q?CCkyd3XEqPJHCsvlVcPPa2Amv/lJk+nEuIUfWZASFxs3+HBNgYB3VPt9ADo4?=
 =?us-ascii?Q?+DI/xd+3cyfrVuaTP8JDUdd+wa4GLsy2cWS4+z0jgDkHgNHyzD3tbQ0q67RH?=
 =?us-ascii?Q?coxP8VYyjX43w4UdXybrB8SPjpKD5JIkYRdpQxHRo5cBBh2ZVGj6GPQ+nZnp?=
 =?us-ascii?Q?c24ww/d9uw97hqKUECjMkzzlq089sWqVvgyn8MTsmN4/K2uXPTllIjiJrciN?=
 =?us-ascii?Q?fKIiQJ5X6ppWYoyL6ylJmcXnA4igQ3US175TQqwMzqAo8fFltqAnJozfspuZ?=
 =?us-ascii?Q?I4w5WvkphyX1/2mWeKT4Xp71tgfgPwPH63ZV3t7XYauR/b/yYxi1+jViRdf5?=
 =?us-ascii?Q?BoqbthbFFqYEn0POdqi9BwzlKhWACyuFn/1s9fYpCVNgoDLNZ6GIg66AeGGR?=
 =?us-ascii?Q?bHTtLeatQVuFTzHPLQTbLdBXcuqth7ZuvWY5nADXrSYNf1SNIkrZkBOdFskD?=
 =?us-ascii?Q?bWi0hOqfivYJb3zonXdFnDwrXgffPtzIA82K6808OxXlcAZItMUeVC2HfAxg?=
 =?us-ascii?Q?EbqUV0W5HBBPVEMKVHchWFp4DPUXHUrGeVAsR3qKntCpXhCzI+0EO/eWa+bf?=
 =?us-ascii?Q?mcrPX/A7dSCU9WfqBrVT+w9SQqCZ2yGgbn14+1eD1nZI/KtMuexdUYKSfoxk?=
 =?us-ascii?Q?jP+rbIxrmfMglmPuuwfxXNI0OP4zUjM0N4yr+URyFtV3RhMiU/AAiQSnvfH7?=
 =?us-ascii?Q?9vqehyR2bToUJWnrOgT/bdI1xF5VDvGqPIdfz9a10aicdC6eo8Fg6TEihdW8?=
 =?us-ascii?Q?TLYxzocDy8Sre5SAqljZd7Cx5GrtushMKMreD9bkC09WcARdA2SVBIKZpEDu?=
 =?us-ascii?Q?Lp6YwDx3F2zJchiBX8sUEYbqZggwTSmxVeDrXMyAt21AH/HbTIM4d8UFh6Vv?=
 =?us-ascii?Q?r0w8EstJn8MCbUg9xZ0CUA5I8MUzmIL0cigGZ5dbmsXEjOk/8zxI/DyOtX08?=
 =?us-ascii?Q?niHKWiGnj++eUOiAo25FbSn6k1Xp/JW84od2CyqP1CPPJNukB7LnRYvx6+4k?=
 =?us-ascii?Q?IyNI5STtXAPN4QBaNywJ2mY3sQdAZCtef/iQeDoWI17a2gV6Juqi7gxMnwah?=
 =?us-ascii?Q?tb6agRvkys3yNA+Lu5To/E/gcPaYlwGI/4vZj/QATTUSK5veLGF8LxgYrOjk?=
 =?us-ascii?Q?d/ma1TkpVjUfuEdgfVahdy95n2tYt0u0UyRdso013SmeF4t5tBxyUZSSwQyN?=
 =?us-ascii?Q?67gN3ZMCBD+/Z3fyefN4eTqCddccQvPzEbF8Qe7TN5LmVIMaEqJYaARdWQOm?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 135e4a80-e4e0-4da1-a655-08de168b5923
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 01:34:48.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCc2ObaqxOxdoCztcJe/HbzLZrpUyBO6iLKfCaWuYPf9FIrO27gNzdf9b4J9TY3RMVyItDgy8hUUDGgr9vo3CgRPYmiKbMWsUoG3ROqziK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
X-OriginatorOrg: intel.com

On Wed, Oct 22, 2025 at 01:30:52PM -0700, Dave Jiang wrote:
> Add a region sysfs attribute to show the size of the extended linear
> cache if there is any. The attribute is invisible when the cache
> size is 0, which indicates it does not exist.
> 
> Moved the cxl_region_visible() location in order to pick up the
> new sysfs attribute definition.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
