Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917952A1BB;
	Wed,  3 Dec 2025 04:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764735355; cv=fail; b=UeV9V+JcZcN2efIS+3U5Xm51kDTqSoZcx9LKTyA0cYjz1kz0wYslnrdXcabqcVE0aZIkQGesaacOxEJSuccMOgqTAQr18rVg4pvPCkqubgkpr8J94y5u7p03Id5YnQwcyL15g6NbQLefdCIYvH7N0P8+hm3QdFFOJ4O8jp1xrjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764735355; c=relaxed/simple;
	bh=TUQiEHLshPpKJE71EdfKNe0xZFjJTgyMEsn4Y1HSJio=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Am8hX1+hFCDOWFA9YuPjv+C1kfTeDfpBA2UUfB4GnBsKe8AhuxTXm30uwgHB20hP68nrOvzCNYF6L65Jgk73YpDLigyX0CxeluzgPH0uahpGaYCRTMrxRJcuyEACky0N9momX+aT84kbr9BtLuMERTrR7eMFI6T2674YoBodgv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0l6bNxn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0l6bNxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764735353; x=1796271353;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TUQiEHLshPpKJE71EdfKNe0xZFjJTgyMEsn4Y1HSJio=;
  b=J0l6bNxn1mzV52bxaEwy+AmqAWuJIyn2jAHUci2CBCaTKErKgiESRYLb
   br3nhHY/oHGTcrAU6/3WEwH1X8yRu+Ci7Xd4RWnHX7mUFw3Td0ZF33hnk
   YRy3v9IXOM+xke5sd87vzT5W9w/FP6QFVUoNSRI/25aGbudXh0jMDnfjK
   0SBvXFYZTvuD0it3zyUElQalUvQHNmHWaioqExv1izsZ0p+qxz9XyI4xH
   VtuGdZ6TAWz4O8rYL02rrydgpL6LNS87d5b9cvgBgbSZt5PdmgM/YyLrc
   xVRF6W3CauDefs+Y8+0o8TlIud2AnAT45Fdqoik5KBpRWeW3HZ2PVm4Os
   Q==;
X-CSE-ConnectionGUID: LQrMEkjsQK6wklQXkh3NnA==
X-CSE-MsgGUID: ntMrN6NxS3CW51/WDmq7qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66795333"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="66795333"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:15:52 -0800
X-CSE-ConnectionGUID: 2Z3PU/5kSMq1LNuwS9mSnQ==
X-CSE-MsgGUID: h130Qw5bRk6v/UL5YTbp8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="194385480"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:15:49 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 20:15:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 20:15:45 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 20:15:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8H/NplPTZYTLzrGuOLRSz7aLkj5IIefMQmpXcRcGwXY0RSzkL7ibrvM9mP2CtCMhCvccA5hYlvunZ2gjxRbXoftwCK6BxkuMwsKbXcA43NdW4imx8jdT53ouizpOLhCf58BGXR0GgAS8iKLkJdvwE5GqZhWf3Pksba619y+jvTSh7VMwfII3AwUSkxNnBJfA/PI2sn7LN4zyRBmozgDU1XGL//gMg/ldly55tGQf6SLBZBRU5jz5OtIyZGFnzr2J/stlxCmkDICO82JEWr9OzatjgkZnEgWXZgd+DIwKKRt+IimzYjreusrYRGdidnH82WllXT61AZBK9FHSMCh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jb00oWgTh4219r1seRAiFPSrKFpUJu8bW+ODWTBmVM=;
 b=PPdcT8NeN0gSHLBxY1dYAGJquoz9uJAhGwe7YCbC6rpfiNE3KE3w+utBUoGptye052zzgXwIW6/FAuxJ4upeYaVbTPR7jkKfXOLdKtlxwa8RsbdaDvWJPPesWT0CKJ1I11JQvOEXYFUp8NpofLrCxy6YlXWIIWzlmwb1s45dN3iWuD9d977B20jH0PJWsi2XKuS/j73pI+5PoPvoeTKTMJeaCxcZhfd9bHuojiej/H3gAy+KUNYHWuAj0D04vxCHopqR7VBn6sn5Iu5spC982GMCpja6H+nknoJo2b33smJi4f9XtoT+1S7Xj18UTZTFeS0kr2qcUElDVFVAkmlndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Wed, 3 Dec 2025 04:15:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 04:15:42 +0000
Date: Tue, 2 Dec 2025 20:15:34 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
CC: <dan.j.williams@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v1 2/2] cxl/cli: enforce HPA-descending teardown
 order for destroy-region
Message-ID: <aS-5Zjhz-5Mkdqpy@aschofie-mobl2.lan>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
 <20251125143826.282312-3-pawel.mielimonka@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251125143826.282312-3-pawel.mielimonka@fujitsu.com>
X-ClientProxiedBy: SJ0PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:332::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfefcaf-a908-4874-50a8-08de32229fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3AvUT6kg2/qAXaxT08SGDfGnqDQmKBjBhLjlscKceUb6b5pY7U8tv578aE11?=
 =?us-ascii?Q?z7Z+HfnDYidCN4mT7tGptruoLoPygJhLBg2An2VfkDZzV3vStUfuBQfym4KW?=
 =?us-ascii?Q?185xk4UcwzqG/QKSQq8k/Gu3/UJRyVTZURUOqKFc6YhvtrHIUbv90OcQSVY7?=
 =?us-ascii?Q?w9Z7PafAi3anDvjUpFBgpEVLULsZNYxzbtJmOHBiO52zOcfK/8wCDURSGKOw?=
 =?us-ascii?Q?BY5ct4yc78pQu9GPHGNxh6P8TV2x4eEuTlinNJXWIHlQ9Jj/4of6eLsuuyAP?=
 =?us-ascii?Q?sEYFqAGxlzoge5gT0BIF5Do14qsWr3FKWkR8dElWOWavXaqSfdoj9qIBNWC6?=
 =?us-ascii?Q?ms/UU/Tq89hPNv/0Us5Yrom54AbQKaevSwZO9X6Cj89U37iV/m5zdz9YEfKw?=
 =?us-ascii?Q?OgNOt5uMdrNK7KpWfIozzw0uPGdlHAcgB9MlnGqDfxHgwocdpUEuXe6z9LOe?=
 =?us-ascii?Q?ndVP35WUYu7l5fphjlvruXaDUlM5/TfsFlkWDM8z6EsV2unytN/nIxHDRzVJ?=
 =?us-ascii?Q?7ZwkTAmaGWXHhl+3iZ4QpJS8rDvThcdzF2OW76UVigLmPATbRqK2phaqqT9k?=
 =?us-ascii?Q?bBPZoJrj56UGM5lT4EZL8cqduIr7gmRsLI7UabshvyXx0OZSF3mqmBqRb6EX?=
 =?us-ascii?Q?y6ErHqL3zwpnRm6QwaiiDH20tQKHEXMNWTMnlY987KJfDy51HJyVDQ6Uhooz?=
 =?us-ascii?Q?GnqiXS6WhD26mClo+qDoOWz+aRKWUpYyOrhZ3N5FLXl1xXQW9qvMYFDBFxYj?=
 =?us-ascii?Q?CMyI8i21ruFojiNH3JsCsuoyOBojnIdLcBEV2VXZwg4DD+WQ5xDwdUrZ/0wL?=
 =?us-ascii?Q?OAGveLeqtP4nwnmgoRAIJRZfqApW4ljgKdpymyC7+sf+CCP7pPyHYYkzIgXF?=
 =?us-ascii?Q?0pPkzIOiyDHxjpRYf3nlautc6MKnncnU0UX/JeymZ04pfFJD7vqQo6p0yMKZ?=
 =?us-ascii?Q?l7RfZXtsYc6GfIn5S9kGIuc2zjqWO6MD62lQc3HxOHDTUk1EIKiR3lSTVdd0?=
 =?us-ascii?Q?BHK6kzCsqknRiDt0XnjplDiiss80lVCEn8kl9tL6/w9IDrk4NL3vfYWCv0SB?=
 =?us-ascii?Q?Y1l4PUzDBSrwia6tXI9azoqFvTSmu96v5Ct5G4yf6i12biL4ThtfzqznsWLh?=
 =?us-ascii?Q?9GUO9ZVxcJ4KUZQVbzBXAuwQbNUyW8n8pkeljRywn+VV5iYQFIrEykyklR4p?=
 =?us-ascii?Q?6WWKjMdoUHnl2qtQpy76NYbRj3TyHaUJXqx4fNTITraz2pDtajjvaX7T863n?=
 =?us-ascii?Q?56aBcyIJ18EvWROeGrwCUTwcK22qt4ly+rKM9KGQSeWOlvLDK7RxSTvtvmyt?=
 =?us-ascii?Q?qhh67UnTDOIWAUYH+GoefQRekJ2sbx5eTD8N06cdwuGufuIFsSYAnvca1r1s?=
 =?us-ascii?Q?I2HllFbDS1stL9aKbMuVcrJF8GovEZ0GOaAXkdzcmeZ+hnak1IieE87XDxH1?=
 =?us-ascii?Q?L8LGs+2RgGbh25saEf5xD3sYjAy7S7UY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XU4DKKGsrytZ6fxjyQgJo4obprwNuKwpl4XzN1sKrVA5HbYAAdEUAQcAiUXr?=
 =?us-ascii?Q?1k4FZv/xsSF9yGwQhwpAfxVlewU7m3kxWHUMkdM38QOWw26IEUH4Oh0IN+dp?=
 =?us-ascii?Q?VzRK37pB5Pt4fB9g2o26hwIqhI8SaBgXNruNK37nJ4FTqFy3yEd/aIcA7fcC?=
 =?us-ascii?Q?VxJpiAnX2BnilwDrtA763idsNBJ+dSSODBNKua7oQANdOIYsLrJ2KHe+wblf?=
 =?us-ascii?Q?M80KWd7QozIIaQ9Ffx5qm3V7QM82HBakrCOvG0iAEsPULz/DTTvWhySMe/ai?=
 =?us-ascii?Q?h2lyRM/TQY2N2U6CRgjUBcn74efnqZd0DuNFvodPrNqQuH1DerlEJuun5oUx?=
 =?us-ascii?Q?On73u76YYOASUb/ACtz+q19X6NRRIkAi5qMFCopNBQpD/BRSH9srfGjCSvI5?=
 =?us-ascii?Q?7+yynLUsN3aI/GZFIomzH1Z3kaSwL2yr6AX0z7eR0Z//J8PuMBBDwhb1dXko?=
 =?us-ascii?Q?5fSmokD6iGu+f6H8WASJzx4I2uanjGfpIcCnqXfviOkKswI4oV1m2IsSNF7U?=
 =?us-ascii?Q?uX8xCAZjChNiFallpAEESX7iajhXhKf3hDqrv8EQScmv2HgLLZWY0TTX+CE5?=
 =?us-ascii?Q?z6NfIpmw05BAtUvlrDBKXXcks+JIh3qIz6tS/9UTEJkJcQdNTc9Fe5NokE2y?=
 =?us-ascii?Q?RWnEaVt0FLskcII0N9LhZYU7uyohUP2OX82pJJ6UqPB6VqEwKZt0yHxK2Its?=
 =?us-ascii?Q?c60j/j6uDzmApNS6tZilRSBhEUdcBlhJfIuTQuQZRIKfVWRCfOKLaNj4QBqo?=
 =?us-ascii?Q?7t+nBrZyWshf9atzL3bWNh+AOWYt/PMs2IfFts7REiHRxj3IKo42RCatL+zV?=
 =?us-ascii?Q?aCMTYNVuzIcBtouESTGknmTgpDPqyOuoUh/+yqAphZB7gp8P+pHajk82fxp+?=
 =?us-ascii?Q?jD/ZzhulGTGJDswKzoGtlLDBu61Aafuz4rmseO9a9C3WZnhpK3HAuaFwwn3M?=
 =?us-ascii?Q?JeMX4ERxSBYp66+Km1wiL9LHvEnw3lADpAo6jLnqiWy2H0OcbjVNI4UEEsaM?=
 =?us-ascii?Q?WGPYLyIyZOOt1RRpRDXBzawXwUhzME+ZbGj6p26XF9iK5RIWwWPbrcVyyuHY?=
 =?us-ascii?Q?mqMuysbmJHEVlLA06stdHTBFAHLjj2aTb7FC1+gahkNKtCnCjGY8BAeHSVfP?=
 =?us-ascii?Q?WRPMySEbqQ2zihJiGJ7Ud++eOsC8O9kym1N4rOyGBHb8YlcYSVTzIPTB1BXQ?=
 =?us-ascii?Q?X3DQ0x5d5BGPEmZmkgQwa2dHDp7qRE9Wrkfo8pVgbYaJxBMvawB6kFlI2JR9?=
 =?us-ascii?Q?AcdVcNqj2qDfHXYSdNYhCmSUNSHObhR+4D5gLZEeLQlk09cwdQuZkscyxe0/?=
 =?us-ascii?Q?bFv8TrjYR+CzZJ79Enpx4rC3kMcDbmHpiurmUlD1igXUugwOz38Yl5TyPu1x?=
 =?us-ascii?Q?WladedOMaXxaNX5WwFbCwE7dI0GjtTb/Sf8FpjegPTL6ms1KlZVrw9o834ah?=
 =?us-ascii?Q?Kmjnt9p8XdbCdbPy4LNLrgn+SUzPI5V9xSXI+nP5Yn8f5pG/B5XRKjcie/OM?=
 =?us-ascii?Q?bnvgHrHmyKt3XlJQgQvaaXdsBBUik43F/F+R1f6wEnQ5xti0AOwETsFP1XAz?=
 =?us-ascii?Q?qAEBjPVyCg5/aMbg73C6ZNyLx9frA2uvn9rJVwJlmKEM7yHElJ8C3kKAy6Gz?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfefcaf-a908-4874-50a8-08de32229fc8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 04:15:42.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcVzkq77ITRFuIzZaINst23kSxBA/qshasxvrMyIuro057l3Adl6EET4h+k3TGDFkylkvrDoMv76rHHczhJl9V+989lRNsZx6uLCcFd+4X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
X-OriginatorOrg: intel.com

On Tue, Nov 25, 2025 at 11:38:24PM +0900, Pawel Mielimonka wrote:
> Implement destroy_multiple_regions() and bypass the generic
> do_region_xable() path for ACTION_DESTROY. Regions are collected and
> sorted by HPA, then destroyed from highest to lowest, stopping at the
> first "matching after skipped" to provide user with better error log.
> This prevents attempts on non-last regions and aligns destroy-region
> with required decoder programming order.

It would be useful to add a sample bad spew or what happens now
on attempt to destroy out of order.  Folks sometimes search on
those strings.


> 
> Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
> ---
>  cxl/region.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 58765b3d..1bf1901a 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -950,6 +950,57 @@ static int destroy_region(struct cxl_region *region)
>  	return cxl_region_delete(region);
>  }
>  
> +static int destroy_multiple_regions(struct parsed_params *p,
> +				 struct cxl_decoder *decoder,
> +				 int *count)
> +{
> +	struct cxl_region **list;
> +	int nr, rc, i;
> +	bool skipped = false;
> +
> +	rc = collect_regions_sorted(decoder, NULL, &list, &nr);
> +	if (rc) {
> +		log_err(&rl, "failed to allocate region list: %s\n", strerror(-rc));
> +		return rc;
> +	}
> +
> +	for (i = nr - 1; i >= 0; --i) {
> +		struct cxl_region *region = NULL;
> +

Here is where there is a difference btw 'all' and a decoder. 'All' gets
passed as an argument and the filter function recognizes it. But for the
by decoder option: "cxl destroy-region -f -d decoder0.2" argc=0 needs
special handling

Inserting this here worked for me:
+               /* If no region arguments provided, match all regions */
+               if (p->argc == 0)
+                       region = list[i];
+

Then with argc == 0 this next loop is a no-op but that is OK because
region is now assigned.


> +		for (int j = 0; j < p->argc; j++) {
> +			region = util_cxl_region_filter(list[i], p->argv[j]);
> +			if (region)
> +				break;
> +		}
> +
> +		if (!region) {
> +			skipped = true;
> +			continue;
> +		}
> +
> +		/* if current region matches filter, but previous didn't, destroying would
> +		 * result in breaking HPA continuity
> +		 */

Use kernel comment style. See other samples in this file.


> +		if (skipped) {
> +			log_err(&rl, "failed to destroy %s: not a valid HPA suffix under %s\n",

I'm not familiar w the usage of 'suffix' in this context.
How about replace "not a valid HPA suffix under"
with "out of order decoder reset"


> +				cxl_region_get_devname(region),
> +				cxl_decoder_get_devname(decoder));
> +			rc = -EINVAL;
> +			break;
> +		}
> +
> +		rc = destroy_region(region);
> +		if (rc) {
> +			log_err(&rl, "%s: failed: %s\n",
> +				cxl_region_get_devname(region), strerror(-rc));
> +			break;
> +		}
> +		++(*count);
> +	}
> +	free(list);
> +	return rc;
> +}
> +
>  static int do_region_xable(struct cxl_region *region, enum region_actions action)
>  {
>  	switch (action) {
> @@ -957,8 +1008,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
>  		return cxl_region_enable(region);
>  	case ACTION_DISABLE:
>  		return disable_region(region);
> -	case ACTION_DESTROY:
> -		return destroy_region(region);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1026,7 +1075,12 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
>  			if (!util_cxl_decoder_filter(decoder,
>  						     param.root_decoder))
>  				continue;
> -			rc = decoder_region_action(p, decoder, action, count);
> +
> +			if (action == ACTION_DESTROY)
> +				rc = destroy_multiple_regions(p, decoder, count);
> +			else
> +				rc = decoder_region_action(p, decoder, action, count);
> +
>  			if (rc)
>  				err_rc = rc;
>  		}
> -- 
> 2.45.1.windows.1
> 
