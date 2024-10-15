Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738121E3D8
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035613; cv=fail; b=ZH688WuVdv5wZK9w+QSzH4p13YpLvQPnlvEeZ4qND1T2M+c+XyzFm/3ZoCBC9zhlZv0+3NxwWhIyatueg8DYfESCtbVF66EZfKXo2wj1EWcvJUOwck/WFfVXeGWajzdfO7qY5GGdfwABbpk0MMmX9MuK72tcs7qtSxGSwqlI9D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035613; c=relaxed/simple;
	bh=qwXP0qvyx7bPeq498vYC5lNrW+rsrveI526cB8kKfTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OuRIsueO/VqXXyeBQwjiMlafEkurFyNwIHCr3yk/GzSxUMRbi6vzg2dWSaXXAyRx8chRjGkRL4zeAGNgFkQzHcPckstyS4LohgeLppUPdntF6Z0FWVue+WK0leUjuFNBiPBJLUCermlBqIUDOHXK+/OUA2+RjCa5YIypC0SZ3js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkQjKTBG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkQjKTBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729035611; x=1760571611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qwXP0qvyx7bPeq498vYC5lNrW+rsrveI526cB8kKfTM=;
  b=HkQjKTBGkOcpNiM4pkLyE8udWfmoRpoJMwjBc3kc6/+jdQmbQyQkaObW
   H9zOA1e7KwBbkqq2omTa3mzBrUhUbAJTHru8S62dWe5u7mxVF8ipL3mZX
   We6vK4z5uoVULGHLtHpP3CTrkG5QxAjOc/j5+vP5WHnQMpl/b6bxVocK4
   fYFVgXJ3ACOtzVwixa2TWKIeziO14Nen1dhPLd8GuLD7R744AL+6u7y0I
   JlA4JjNIWnLErqgRUHVXk4wKljkJJ6Wg68ybBAcBgXbZQHNW/6zxEAaxb
   86neUZIf7caNIrf6j45V0aYA0j0SYYLHV0A45g1rQNVykmS1d8HoaVWEN
   A==;
X-CSE-ConnectionGUID: ERMrg7zARzaqFztfmLLsTA==
X-CSE-MsgGUID: l3Xl1ts7Tq2WpbzirkHP4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50999230"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="50999230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 16:40:11 -0700
X-CSE-ConnectionGUID: pKaTFzXgRx6bVTSkwRoqcg==
X-CSE-MsgGUID: 9KSKZRtcQeu7oroquZftHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="101365212"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 16:40:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 16:40:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 16:40:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 16:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHJPhndellzgg4oM6U9uu7epKTr67pJIMPe7yDisQKlPP3HbsyKyVxl8qeHDz9HNUDV8Jqwmu0SH5WSGGwdaw/eeFlzlO56hjyaUmg1DqDoi7Vke350uMnyf/Aoy27tU+o8DZgqcoVbbKN7f6uvxK1NKeaN0RO/3DTxybfUGjv4nn3zjic6nc9BOZD/Aq2EMHSuQKWtThV/SX4FTWQBhsbQ/2umY2x4wzr65GUT53PWk5Ipkbm8/QWRRVn3bhMFrD2IDfNaxc40qSD8lMgwRrn8wlz5/pcihvVqRCkB4as++2fn2GdaIvT7SH1+VHZCUrmxNb9QXrYJde525cKwbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhS4ZATwG553lnQRyk7zZSP9f8ashQbHVIXzvEp4RbE=;
 b=gcpQL5E5fV9rtSmyp92DyozSNgCfZEdfr1KZ5P4a8OU47c27oTmawvKak6/DMLZOEMlO4kecxTPaoE31IPhUvmF+3ypG0ZHgSzkoIp/c8zwtZRm33XCgmiZGKx35+Vb5oa1CsnQ7IAPuiww/atGIlUAq2IH2Mn80LQxcQgSsgBO4afQE8gDRzbuMkNXKEpT3Bz0/3FcP30EW9IfnLgHVj8o+6NuHlvNK3BTAnVPuzzIvbW4hsesXT/iyx0C6lzw27OvbrzJKt7pK1RhCrCwvKSP18JHlje4hb3pVWMn8vMFkSm3K/rP3XWikeod1mhCLxb8xQlPa+As80iTEBTyG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 23:40:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 23:40:05 +0000
Date: Tue, 15 Oct 2024 16:40:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <mj@ucw.cz>, "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v18 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Message-ID: <670efd5389f6a_3ee22949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cccdb8-502f-476e-8faf-08dced72b26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6KP4EwN4ymCuU29i2c/0MI6WgVwY8E3zLbl7yTrFuv92nyy5bwCcgL2Hx9g6?=
 =?us-ascii?Q?DrBfw2wEAQERQIEcyIP56mcg5I5qNtKw3sQluEennFJbT49zUgih7drRPzQD?=
 =?us-ascii?Q?7FPI7cHLIZ7kx3QOjSb/xkd1QJLb7lnjIu05wWFW1fmNe45B66Zon03FDS6G?=
 =?us-ascii?Q?GtDGmB3LBpl/XUcvwms2S0ndBXBnpNJlC3iF+40DZnbdaeVdbJ4wMfww/jHr?=
 =?us-ascii?Q?qG3vfQggQSDElcHM2LcG1YkR0mkVnU+2UpjeP8QTbgBsQJVv+6wrPh5OitoA?=
 =?us-ascii?Q?KA1Oe3OEoOUhqneBxW97ZlLiZHMwo7YovT7rFHn+8Ka2gg1SxD9zVZ2GUlTp?=
 =?us-ascii?Q?2HdDSLWKfEAeTtgZdHz7B5G6H32qYHM8XgvOrH3ZwFVnsiB49QqAgN9DOLz1?=
 =?us-ascii?Q?5gGO0sRGR25wotr2uVyJW4/H/XFgm1etoqqoqU0cNNFtlX6OqNMZEXlLbhjI?=
 =?us-ascii?Q?CCIFIqWx1qxowFuB95apqvgxzTQU6HGTadpo0QuCJGntdi5RMbzDJL1lcwbp?=
 =?us-ascii?Q?kt1SiExe4NtN4ztBVO4Cr5bqO5TZvAliSC2hBC++F/NommdW3O6TvQhtMVZl?=
 =?us-ascii?Q?24l3XmMiMe405LA5Cb+TxVfO/qm8xqPKFbqXUgGa2KHFqzO9E6XKUzn7zfZB?=
 =?us-ascii?Q?SIBZo0LDCEUyGR0d+7E+rJM8puRMJt8ErOJsmDANI1luBrCUmimiL0NI/LIx?=
 =?us-ascii?Q?zzlO6utlbFIxzvcI2dNk1/KxCynjlj5e4NPTsqFCs2QcwOkrwgvEnwa9yvjR?=
 =?us-ascii?Q?8kFriunXVsFWA1cSlU2lFgFsrXYJxwmiaHUqZKQp3eWjfcyaTMD+r5xJ7cey?=
 =?us-ascii?Q?0ff8qxs+PQ6xLwIllUycid7VVW2r/PkzRao1rQZC1cnMQYPgcmTtt4UsxTJj?=
 =?us-ascii?Q?80bLz2dNqRDJk2nEb9LXJ0QkY31P7Gj4wf01yNxKKddYiTmHGNFC6scYg2QE?=
 =?us-ascii?Q?DmcFQOco5zS+njqMA44qeUeVxzY4/TXBUH0bADPh7FKiObfDh41lYRfvAOyF?=
 =?us-ascii?Q?+WYaroTNL4KUVpHiP0V4IUSSE/JsaNShq6mVEIduv8dGFaGU3a7SG2ExaQNW?=
 =?us-ascii?Q?51EMSdmu3re0Gl146rWjpOGVUegx2KZby1NPIFQ82iWzGtI2gN4PQGBYEw8Z?=
 =?us-ascii?Q?++XJbsjcomVxTQt0bJBGDCDtyTjcfmZDqy2oAfiodyv3wQR93CeHj2y+gFqs?=
 =?us-ascii?Q?RXT26LVTZk9aFwsc8RP5XkX3vtH0u1bkGSQ9jx4RqAE/cEhU4h/oWzoKSiN6?=
 =?us-ascii?Q?48Al7C0HnVovyreKEjWyKHuM6feQOSb1lWDvIMOC5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B9qRius3aWg9mRemucpGfRAE9uarYO51XRMzQT4WWltVwR44K7rLJoJaK0E4?=
 =?us-ascii?Q?LixzS3o3bZJKFmHzhsqD/iWUCjM67eZ4tktPjiRmpSMWNQ88MC/toeOC27//?=
 =?us-ascii?Q?yhT9xXAJH4oo4sQiga6npq5+1JgNy3iSDsN+ZcWQQWjpcaTJDLHmgAZcU2uu?=
 =?us-ascii?Q?nbArnXnlDvTZTrIooLr2rIT82EAxI6eaqLuoYZqGwZqRa7zSNYfJ7uK6AOgP?=
 =?us-ascii?Q?/2gROYrwKXiu9TmSg7E/b9SgmvLh+R1z1OM7RVoh8pLKJ0qvGxnbWAng3pCt?=
 =?us-ascii?Q?/PAoB146fR1yIHYiMn9CO5cwFTGphOKwOxvwv0DgW/pYNGhpi3nQc2MsHmF7?=
 =?us-ascii?Q?MIVTPkKptTbakrQqgZQ2y9BTdjtLPKH+SCTHDMFa/vZF4eD6zTOQgJsU8UqE?=
 =?us-ascii?Q?GAIvg7qsJlSVIfFni56MI/SAuJFPF6ubZOZs1VMevXy8c3dpOEdTaHptbAvw?=
 =?us-ascii?Q?p4NAbuq7fZcwH8iyFDTTuFK4hVCZebBJpVDb4pXYppYA9mWrc3TtZChzyeQ/?=
 =?us-ascii?Q?/tGxQN9SLTAUScgLFCHm+DoHBMCS1hOLdA0dd4SvCiau2akZBkRzjoky5Pxe?=
 =?us-ascii?Q?P+rdAhoeDgf+M/KpZ/WQokyRMsHbTGswFKhHZz8nWXvnDfB1BIwcZpKKftNi?=
 =?us-ascii?Q?di03TW73KtsIKU9GKYgs9VgMTgynpFCjJsl3qehOQi+Y9c5tyU80Zy3FORyB?=
 =?us-ascii?Q?X1TnVqAXJ8Soko7kA5qIiCCKhepV8KglpumnOgJabhWcZYeZKl7ncX9YDsAv?=
 =?us-ascii?Q?UxyR1hv2Vegb3NXbEQGWp3t2p0Riw2aD3m7QpleYtvl5yLLwlNi0Pqul64hK?=
 =?us-ascii?Q?SLjmCM87J5FQzacnlGhaovK22gbtoFqCMEh3cqcebihGj2nsp4GqPGF8pOJs?=
 =?us-ascii?Q?JHu6jHFvxfnldhQisyS1/mfMtc/Apj2msV7HWRhEgQ6jE04O/7wiEtLAnuAI?=
 =?us-ascii?Q?JpAquHujW/ul7cWtNQY0bCaN6JDqAh5S+6H3sA8rUaFEJyylemlSXUjpUd+U?=
 =?us-ascii?Q?6XsDD3NRLX/Uw5whjm4TXlsojoLP1OW6Z0v44w/Z7aZkO0z7kWJHW5y/cVn/?=
 =?us-ascii?Q?Rfeuesh7emWyAZnkT8BieVROi4meWAYDT6gSMCtwhtFNxmESCwxnS/2r4x7P?=
 =?us-ascii?Q?QJS/i2+Z6NmIY5OPdgjaD69Gjcf9ypYYzb3/HzSdojjWxNyH4uzCnjpekbRq?=
 =?us-ascii?Q?/tBYPCpPJJXkiiRDG1+ZBAuN458jwRsurHqTmZJK8DO/IimP8ZzyltTqTrTp?=
 =?us-ascii?Q?ue9XnkoY7BABy/rWZd8b1EocYsBKxwHwTVqucoD13ju9i6UhIeXF6phHeqN+?=
 =?us-ascii?Q?uxjXXfbJEheeiEmssFbEOsr+iugO6yidQK94yoyg7dck2fdUhmOPVr5/vgPN?=
 =?us-ascii?Q?Ymhy8uLhmvFV/W83yMV8xCq0uMjBkUupR56TSA/EkXOQQXNa0q+cMb2sgOTq?=
 =?us-ascii?Q?56R3QUutSi0KNzLq8tCbV4QsnuMka+Le4dlRKkbbpPBj3Gy06+ucJCZVMbKv?=
 =?us-ascii?Q?dwt68KjOEK5xtxhtXnnLbgCU2FkRQ5ytjPM5IErlXZGnKiv0uhZUjIkknSSd?=
 =?us-ascii?Q?RoUHBS9fYcX8BZ33SJ8644CsvIZsPHKD0TkzKKhttXGV24nfg6r6IkhVPctq?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cccdb8-502f-476e-8faf-08dced72b26a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 23:40:05.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwXMWy0orkH7F9LWWuNsRMGSscAY26mwoJv786lO5SvJpi4y9BqSm97b95p6uk1n6bX0maY3QdwRfgocqBDMIjOy8rbRbFllkhCQrht5AE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
X-OriginatorOrg: intel.com

[ add Ira who is covering for Dave ]

Kobayashi,Daisuke wrote:
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> the link status can be output in the same way as traditional PCIe.
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> different method to obtain the link status from traditional PCIe.
> This is because the link status of the CXL1.1 device is not mapped
> in the configuration space (as per cxl3.0 specification 8.1).
> Instead, the configuration space containing the link status is mapped
> to the memory mapped register region (as per cxl3.0 specification 8.2,
> Table 8-18). Therefore, the current lspci has a problem where it does
> not display the link status of the CXL1.1 device. 
> Solve these issues with sysfs attributes to export the status
> registers hidden in the RCRB.
> 
> The procedure is as follows:
> First, obtain the RCRB address within the cxl driver, then access 
> the configuration space. Next, output the link status information from
> the configuration space to sysfs. Ultimately, the expectation is that
> this sysfs file will be consumed by PCI user tools to utilize link status
> information.

Thanks for all the work on this. While there a couple things that could
be cleaned up it's not enough to require a respin. So, for the series
you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
