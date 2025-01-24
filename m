Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905F320F
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737679359; cv=fail; b=G4DfR2Sb30ctGXUwNRUM95r1Lre8/zZ7ZNdU+DpxrVFQiMUqPsBD708Ciq76d1wNbHaF3P8NcJs/U8LnBQDV+xfzrnwkx3ndiRrobxkor4D3XdWVZ+7YKe1VU2E03CHmrU9o13jrswqIhujcpwsRQpizXLQMzHSXPk3+DdasJCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737679359; c=relaxed/simple;
	bh=Wrn8w3jgjxFmkYNHieoZJZL186vpn39+XLgS8OGDCto=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ETBfhZIT1SBb40IdphgWR4Ecojxq0B8p1MrXAdCnzM9JRPNznNJPzxhhL1lyahT/NpVHE0nlF54VWgGsyy35NSsB+3PzYTiLP31xh364I085MseBM68m2sKYneeS444dgYzwLF+JWF8UWMJVcZd3MiU/Hnc/v9qDD53dww6wtC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFyiHc/S; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFyiHc/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737679358; x=1769215358;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wrn8w3jgjxFmkYNHieoZJZL186vpn39+XLgS8OGDCto=;
  b=FFyiHc/SyUUkgoWCOK2VnJ7NOHJg5W1JJfev4r1iLqsVZOMEZxYwqqIS
   BxlZVlzUe2GgxZOtFGpTvE3wkfVkTWkReFR0+RHu+J4bSlkVNKGWL9kXr
   SitOALduzY2eywYLDOWBdNef6hsWH91K88bXwYEq0hrRMqIpywlS21Skw
   93uwHvEIhwxaDgg6MK2af3NGLU/8HGlQZqIzp5diXGA207rvWzXAyRqM6
   UtXvkwrnBU9cfAFCeXucyPMO1CNgvaI+nyuSlMvEuOALDTdgdbrbLd0hx
   mLZDmTuPiuqJ6s5KTRIj+Ph5WN08l/Y9Yh/346H1TXlVzU6uMjgc186LM
   g==;
X-CSE-ConnectionGUID: awItKWRCRIi6TmF4GDYx8A==
X-CSE-MsgGUID: 8IFvJBfyRjeCwmvXnDTuew==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48795485"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="48795485"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 16:42:37 -0800
X-CSE-ConnectionGUID: TMSLrn7tSMmI/YY2XmgrTA==
X-CSE-MsgGUID: ncUNPv6zTxyZGocB6gpzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144863163"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 16:42:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 16:42:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 16:42:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 16:42:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzbXTi6e67bLTUKzr3ElBflkATvPvgXdJoS/RdIATyYqG73fU/hE86oddSFuexV9rw7BbQrAH4kT4w0cvOf5MkN3uh7R1WVnmUGz/Cvo7wrcfL/r5wG83JtG7DKaRVx4CCx4ixRcqxte7650CKtlYcoSoBEcsAuVE4UoUkIXlSaLn4MIKarnsiosaNIGeRHZgUSiWvPM4S73oyJOeA112g9LmPx5v4xgOgTXMQ1lpJnZh8peGd5oJgy1/80RYdaiFoAzkwLckfb2eSF/i4klpydbr1pcHkNBAt/R5dg6+4jeJuohQGUsnssLk9PkM/brvof749UpNZX+apORLZ6Swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s6cQlCrI/lnDukhtiyw1yBOsao2tkDt7CMacCvelPs=;
 b=IhHpVoJqCQvI2BXQoT+NGHRdfKFeb/tevY9I5gCUVvFixAjilU31isWMw18RGw36cfptLXqgU3yxlUO4edTIc/S5XQL7qqDyjw7v6xQrWhm+FZi92zV6PhBBSexwXBVdWv9xS1WAn4uDnIf6dN9dq+YeobnjXGRlYX2r3JeLZBf1YL4nMoPOQtkRBrOCV2HacPCy96jsWWQFInqKxu25dHm9EveQNXAOrrhvFQfFIt/Mdlh3+vOEkL5tsattGWn0N/xyiZSygPb2wUOV5P3aqg5dtOxmCSgevCxguaeKRgp0JojdafoaxNZmA0B7EuMD9DTspk7EuCmhk/Znm8mSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 00:42:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 00:42:28 +0000
Date: Thu, 23 Jan 2025 16:42:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 06/19] cxl/test: Add Get Supported Features mailbox
 command support
Message-ID: <6792e1f2286_20fa294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-7-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-7-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7e5c69-82af-4ad9-c7dd-08dd3c0ffac1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EVm0UPu8uoAc1jmgJq+SQIAJaI2GZmyZ5glXgQlv+HQLgpf9xkv5CKTiIQup?=
 =?us-ascii?Q?vQRNy5/DVRk7r52N4gm6B9IyY9DNK+jSzJtMkRMkV2Y+6WMnLroIf8P8tG/9?=
 =?us-ascii?Q?PyDhI8UAGDRqVvUaaIz9wpLP8qBBLlca0ZH0KzWaWBzjgszZe9wHxxHS8WfN?=
 =?us-ascii?Q?2xtBk3/qnAfWKD06UAkYfpGBGqLPNi23rh6BS2NLoqy72z/rthTgfVcNqjx2?=
 =?us-ascii?Q?Rv/f9+EwscsgIwfiw4V0xGfCrZRdLU+fHqFquE17Elxl4Y+s55sySnxql7zu?=
 =?us-ascii?Q?L5dIi7g9BxnbT06e7zGqRFOChvQWb0s6XaeeXBDSbmh2w51xEOMRc8hnwFG1?=
 =?us-ascii?Q?bt4Mlcu37QmJQit7SQ3OfHxDDhxXZO2lcCe+CR1Bnzh/T7BD0gR4h9P2Crv+?=
 =?us-ascii?Q?ykVud/SJF7IhIKFY+I2OKscXBX2g3pMsOVqrpnwgDbSdRd4yinTPRRuQ1TJK?=
 =?us-ascii?Q?AXI+pFUth1BQnV3lgZ2I4sfNcFX9kJmmf+pGo9aQjjooUTiD/O65QzPZCt76?=
 =?us-ascii?Q?1M3F0qDHA62aP8ozxw9TL3/E7+oPlQPZKb023WYYZR1GJGDaFQKWfPGd7bDO?=
 =?us-ascii?Q?xwt6gfZAuHF4ncL9TGeLsEe59G8gEcRIBDiZbdlb3rFS3Uy2ru795rdaLlrp?=
 =?us-ascii?Q?7XujIbXfd2f/84Y7Pfktjy2XQwSOJAXXL63NKloHcTFnTeOTo4g/4PIeWiHY?=
 =?us-ascii?Q?O3NSMb2SinZaUtcxcOV3b+3WuHYUWfQXTCvoS9g2WEq00/BDu3g62ZzYhMiv?=
 =?us-ascii?Q?IcbImXWWr/svGV3HTY7BOTR35yFKU1P9otI537v4CycyMKlNCE7NFkUqnZJq?=
 =?us-ascii?Q?9Ha20lYceeaOmFmHA1q+u2w/16n5zRt/7tcuZzATn/YvLXUKW4gqAPE3Xxa5?=
 =?us-ascii?Q?v6ESnjcETI1srCRhSBRzHQLUd6KifGi0gcJbLJb9VG1B4FlmKGcxzoQvm4t1?=
 =?us-ascii?Q?UZ01nlddV2EyQ24ck/sCjdUxpElMjn8ZJzyt1tWFWyZbBwt3fM7fIlazFHNi?=
 =?us-ascii?Q?3JyiP8CNDK5pRu80Bpay23ZhM1YMTdthDTo/53wxxvslW56kae1cD8ghOkkm?=
 =?us-ascii?Q?6XgKx1sJnlP9fGkDeNjOBl/5NFThLekDKcCxJH+rnZXlpb32yrp11itPf+0z?=
 =?us-ascii?Q?p4vwUyoWSo2oE9CCJRgr1Xz2ufO6XOrXXnS++cSBc6vBQPukM6xrg1XI8wrO?=
 =?us-ascii?Q?DGL2pIRfjRpEMQiIJLDqlGtYor3WskBO5ev9/8sI6YAZTsZZCE5/7NjVd82E?=
 =?us-ascii?Q?7F3hpXIOxo+2n6pDeOATY6RGcDZklpEJIzPghQdRJxJD423wuH5NKT/gFRvA?=
 =?us-ascii?Q?92j3qdviW85kMkoPFwT5ABQ/xOmY610VsACIDcT/z1+2xBiWtNFVnK1ugxcw?=
 =?us-ascii?Q?N86lqkRTwd8C+/8fKasO7s1WAzBl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0jp175/coTmq9pi+A+8i3JD8EPwGVVdYvgOff2quk9IMj5RW5GDfcyG6KY7?=
 =?us-ascii?Q?BdpyD8gzQsuxrKesV6VG7hWe8hhc2qGnYbfJfQNlDF1I/OUXsU3HBwe51wMd?=
 =?us-ascii?Q?ncxi+4BtptpwSgTOPt2rEAnHs3BQ66oH1jmQjom9xdEwAinIfSB0YRqk8W+2?=
 =?us-ascii?Q?XIBHa0E+75RLOvI7Ir4ld5C5Z0XIjuLeNqDknxFNMo9DkkTUEikFH/fbkarr?=
 =?us-ascii?Q?F/px3osR44Reh9oo71CijHSbz4oI4LGHM138pkrXF5Ro91IXY35ddJzbTcgO?=
 =?us-ascii?Q?wu9DhlbWSUroewYcSQc5j+BZ8e9VKkqWxDiSXGoNnRHkwDANsH3bnoCzvfGf?=
 =?us-ascii?Q?nCqNvR4L9K710RCpCJAqPDS+82l1dOh4bgXZ9eYmrJkvwVVvzg/cnG4FMiC8?=
 =?us-ascii?Q?Gq02uFmdzsiUONuHHTVzM8WIJi5rHm8jB5CgkgbWeWyIS2NB2SW0MaWprXGb?=
 =?us-ascii?Q?xQ61MRF4XEB6LQ8/2smG7QpcxJE/yhVjimeQOVXnBPy1EX/TEfpF/HBVE9gH?=
 =?us-ascii?Q?suD3eaiCpahoo3QiqMKdqPJtxDYvPxBHURh3+vpbsdbAw8ljYoWh4QSM/R7h?=
 =?us-ascii?Q?jP6PgvxrSfqLNJ5RpHS3bjbBj0eiB8kRYGf2M2gbhrLO+JFizN82aWsNO4nT?=
 =?us-ascii?Q?mRZZlGV+QT4h3+debB+QMG4lYoPyddh5Vvt83YzENFG5N1UXXIMDG+EtMqyR?=
 =?us-ascii?Q?uT3oYMLipXONWrYEOv5MhtBv+/6FV2OEqL1Tl3G7PoO/lGdYVGRZfoWRNJKc?=
 =?us-ascii?Q?1wwbPRP9g5QUYcmoJL85jO+3pTcJXxXe8nX9SWQClDdx5UNt39acd3hbSThT?=
 =?us-ascii?Q?9vv1tpN342jIYOxQLSHGuERUs5Bo9StJ0CQFMvPBh0oGBmO1BMWam8BP9A6e?=
 =?us-ascii?Q?GEg7iZ+82BCfFO6/CHHBK0fWN/5AG4Ew7O4rrPAR72PpRVhbrtRLalkRd+L4?=
 =?us-ascii?Q?BmeuzweSG3KxI7vtSlZyOcT1K/WVRCTVzlcU/5Fr4X4TdolhMnCWkj6GaFcd?=
 =?us-ascii?Q?Lh+cDsIp2CBai0gjiU7IjKPojzjQg0SoccERgTdK8vvK3hqvDJQqgXRbOZPq?=
 =?us-ascii?Q?0hrbHfenpjaBtPqKlA0tTGcHpMWnbtw+JnpQAJDDJEQepMFM2J5/lviMOwZv?=
 =?us-ascii?Q?tmYXlVdTvNdoy+XBZ0DE5PKejVLh1V8HSibCnPVApVIrcl2OM/mKbXSoQLmX?=
 =?us-ascii?Q?cLXEGazA+ncVfgklZyC+Nn6evoSdmV3oZ3vMLRi+qDcRbVar2f3H+Eeril2U?=
 =?us-ascii?Q?McPg+cWZQ1/cHBa5HFyZ57M1cRtAQ1IekKcggDdwEiJA5T7/UZOWt5bvv334?=
 =?us-ascii?Q?UB3XxUnAhq0/X9VCNoPtL0C7wFZ4itjU3zrlfm24FFqwyQ8CbZbe1siNSP1/?=
 =?us-ascii?Q?qEYS1l2dUwHkzOAjYV8kmVp/YewhimEJPdwvMKL/YXUIqH117AzFklqZD1fx?=
 =?us-ascii?Q?UmIDVL4IYO9qEB2IBoHPHYxfx8/pKw509/nDr/LKMFOZl90qQIDmosJJKIS+?=
 =?us-ascii?Q?67a+5qbIlV/gXTA+h3ZzqQ/Zd2s3GrjcehR3Fsont2l30aJVFtJSD9P6wpBA?=
 =?us-ascii?Q?xsyxxuX7yMejf8GDQcz567Ua04+w3kDuC+mGI3yMrH/84Pw1q9/TkH1pWzdz?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7e5c69-82af-4ad9-c7dd-08dd3c0ffac1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 00:42:28.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oh3He4Kg/RMU7iz8mygSrLQStvZbm+yundAnT39vmJZXCDXinGGr9RvlZw2XeO/r40LWq03RZxPuuH6dQWloZhL3BcIThmKELWttf+k9Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add cxl-test emulation of Get Supported Features mailbox command.
> Currently only adding a test feature with feature identifier of
> all f's for testing.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

I see the ndctl pieces now, so lets upgrade this to:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...modulo trivial comment below:

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1:
> - Fix setting of num_entries endieness issue. (Jonathan)
> ---
>  include/cxl/features.h       | 23 ++++++++++
>  tools/testing/cxl/test/mem.c | 87 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index 429b9782667c..8ff7d90932d6 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -28,6 +28,29 @@ struct cxl_mbox_get_sup_feats_in {
>  	u8 reserved[2];
>  } __packed;
>  
> +/* CXL spec r3.2 Table 8-87 command effects */
> +#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
> +#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
> +#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
> +#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
> +#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
> +#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
> +#define CXL_CMD_BACKGROUND			BIT(6)
> +#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
> +#define CXL_CMD_EFFECTS_EXTEND			BIT(9)
> +#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
> +#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)

cxl-test already has CXL_CMD_EFFECT_ definitions. Move those to a shared
location to avoid duplicated definitions with divergent naming.
