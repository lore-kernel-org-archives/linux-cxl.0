Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9F2FFFA4
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jun 2026 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665835; cv=fail; b=UVPbvMhsFHd0TrSZIOHvfHEhovainSt0/B2huhdCmcCDHm2lNEHlnyFaw1GwjRrvVu4Qidvu1e11O1HYjbo5EEQVYhK8WQ4av/3VdfRPaa6Dcad2VvzBlyNZ1ec5TQNrX5Tt3xMpo2GmpETkalPv0N32I3O0FM7/+iSPa63AozI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665835; c=relaxed/simple;
	bh=EBf059SdRJMd6CT0ZQbYN8/fWryBt4yz+hLJ+Hv9GRs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YcRtR8Tsu651DVH9+NvPR1IUvqBoQVtZylL7MAVNsm9roGljbVBFqVfHc7Ebzjqf91WIZ3f2p1cCHwO5QYbRgVrFyddgb+/0bmj3ZKdG9ERMb0kWKskzuGtveNgwrl34J1kjlEj3Vjf5ViZK4XqxMAw+RlxsuqMO4szHlEjv7XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvgNT2qB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvgNT2qB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781665833; x=1813201833;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EBf059SdRJMd6CT0ZQbYN8/fWryBt4yz+hLJ+Hv9GRs=;
  b=EvgNT2qBJ9Nyk7ozDV6upAdyv9gsxF+/ChW/8h3K1VVH4xMMOsITzCEB
   TQZxqG9Qn2KHQ+CcKCiG37ZtRPyLaU40pc1VLHH34exbcnZ1jTDu9Qy1v
   NuNmEBucxT8PL6lwkgen9Ajy3VYPzPMI/VX3u+vMooKZ0rnQAyKW0eSyW
   u3nxIPL419prmDdceYzjxUIY0oiy7eNEjKnyR1kEQ4YhxGhJo24bWRKb4
   W5zohCnx3jNaLe/S5ygpKOIIZUD6ZwfCeB/kHjqEYt9ywANlSfeo5jfR4
   nodUdS2gtOswwRLO08xe/yV/33VZ8Nig6wMj+CnvfAYd/Clw1r/D9p2sh
   A==;
X-CSE-ConnectionGUID: coYkXHleQX+Y643mqj4/6A==
X-CSE-MsgGUID: dtkW4+soShK/El9b1otxlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82227694"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82227694"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:10:33 -0700
X-CSE-ConnectionGUID: J9B8bVrOQf6VESQAVi6EGA==
X-CSE-MsgGUID: NdzbPKabTiekFnnU/+5G0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252905976"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:10:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 20:10:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 20:10:32 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 20:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgDCABTcxuv/No/P4jEqmFzNatkiEAko3kqxWcvDVr8ZZYMAbEswhlP/OMVXvF610uFa23uGqQZAGA+kY05Qr3b/3u4rbTtYtDa9ocMtkO99FPzzhPyrYkfPUHZJE6IEA8Z9QcU4oIConHOYCRbzql7uyMYuCkgH2Hy2CSFyFPzvbZ/HDpa0o415x1S/SwvzW9fM6sh9cVCGtk/s/gJNQ7AI1O5wLiQv3X+B5fsBY/Tt1iIrPAEl1upks4l15YmOWZruoG0qhUMYNqIigDisCkPno9VP/dHH/EQ7ltVokoAE1vA2b6Mi4nstK+bIpWlO6KmVS6+C6T91p4rwrU59RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkcfdN5HfO5ChX5fiPJN/EcJozvKRbb3sM27rnc1XDk=;
 b=uJwTbHsfqwgShCP9BcPo4AERHMSonSCC26vAqkhdsTEs4diNoMol2NpcxfLjAsZTNhEEVAKLAOCV1mJqwThIMC4mLKLTAHL7nPggUAw9qkmTdKMFOp5EMK+/GBdq6iCfLr1rahD1f6xEa+DVFEcmdwHPcLwuMo2rFga4Cq6HIGEgqlmGxM4IwO3aCBKxvuDcbYvz2Nhk3pjsyIXsXzoVdrnF5SqbrihYnIEC5DAeAwTf0qNdGxpSlwhaQEgCLiV9zBJKtfZfedAwrpyaG2b6yZGaPKgvgCKYi6XOxco1UUCR5YU8o7GEgE1MzglNbjYtDGjgxmPugAOOFxoa2xD9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SA1PR11MB6712.namprd11.prod.outlook.com
 (2603:10b6:806:25c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 03:10:29 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::d35b:e3ac:6d53:bb3c]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::d35b:e3ac:6d53:bb3c%8]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 03:10:29 +0000
Date: Tue, 16 Jun 2026 20:10:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] cxl/region: Account for mixed-granularity in
 position calculations
Message-ID: <ajIQH0cA6A95TEQ2@aschofie-mobl2.lan>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
 <aiuhReNj4Q_-HMzF@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiuhReNj4Q_-HMzF@MWDK4CY14F>
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SA1PR11MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: d1422288-7546-4e09-57e9-08decc1dfc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: K9JmlW7FTcCVYw2bIUa7UUbbH8+f8ND5lGhzWXCTX/e071oV0rqVo3dsNUiMhNepgc4v4fIdFsma5mQZV4D03ub9ClKSEcs3EzioHZv4F7SaaBbLlEQdzT/CjWgQXNOzR1YXA0skV8X9XfkxIQo/7t/DEwu08tFgR5/JYpulnGxrQ/U+otYa8tAWP8I41CCV5bGfY86v0BmQR7chOEKMla5sKPkViz72VhTx+b1lREbSJbEETGOYtLCjQIg9OZDAW55fj9l4E2ZjTVHSlxuSsZdtYSVmayGbSIrEyJs5YELWlhE+2UamfkHeBrdoXuNcyOFCyt3XyDUu/mGwW8M/l6h0s6Z7jfYo81ItEAIWALjjrRnfVsTPgwySqEKbZVYe7ztSnqzdEgAprJmbh+TvOFefRm5Zcvmbi7UYzZgvaDlhb9HRQP7EbF0RJJhzCavT8XlCXfs76y4nXrkHmVbAqgoFMlW4B14Es99I1LkaRxUc0Doa3ADhhP5ZnXahOpvwq4u3xCs4oIYO/QV9lx4Cf9/AVQdZ4nB01PDAwumVBXWKMj7ynov77pqwLkfxJCZFvn3j+oM4bTdIT2pf+yP4s07W77w7JFgYNx+EnS4sNoTqVCSK72sKG6SGdjMrApT6ibL1AbAG5wF45CMVUJnB4aWxLWbF0acj4eUzBmNqE19YOfOMf52UgqTRaq3ewleY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oBlGmxMteIRISZWtUp4/zaOFxHRx+ETaXmh9+mMl7CLZjaPtpWLMKnMLrWpZ?=
 =?us-ascii?Q?EG1VbdOotQaDgWketsXwGIZtmhno80i0w8NMHnAjK547Bwe37Txal9PAf9py?=
 =?us-ascii?Q?IZIa0jFG/WkAYmmWwAm+35a1kiszkz8I1pSAQH6qNvDWYFY8uGsx8cRT9tiw?=
 =?us-ascii?Q?v5+S0FnT4tPe2ul2f1Lu30aHNV8ZHktVaO7EW+cxyQxjbGWEjQtfuCweLu8r?=
 =?us-ascii?Q?kVhcK4i/BKO6xbJFVm9wD+6zLQnN949NlisaAng9gz0QqCBCPq7nPk5xqtnT?=
 =?us-ascii?Q?g7MYvfsr5YjDNhRR8qqq7TrW0ZAnVFxJ8RhgSpuqegJuUlAyztdIxuI/n7mw?=
 =?us-ascii?Q?qFzCybv5w8EyBKq4sOniW2CIAVr7L+Dkj18Qe8UEeR7b+jQlBB32qJxn/u9/?=
 =?us-ascii?Q?RXjLgEe6lM+W8BuNtnZ/ADiCuZ5WDExKoe2wOIqgqsb/5u2xonogBo/Jk7kj?=
 =?us-ascii?Q?Ns8aoXmMfAiAtrvPLbyMLixUucbpK/3D9chzlyfpGqTNKI08H5jFU5cG3EFH?=
 =?us-ascii?Q?XIKJPbK+uaECnLMRNJuVdFDvKjRssa0bkBI/mMVJ1FeZCYOu8JdwNXw8imyU?=
 =?us-ascii?Q?ScgHBPoEwUFd5b7x2MQtdduvVwUec9/aEmvlnqe2y8FayWX59ZqjeDJVVCow?=
 =?us-ascii?Q?lyUlWkxC6BmDfS3w/MrG5p1iwBLXWTysrbpu2NDkvlFV6RfUiJa3yhzUw6iM?=
 =?us-ascii?Q?ndM1N3y9FZ+X2EWrZfM1qJwt8ymDvhdaNa+ckc7AUqtYB8C/gE9NNvC419KO?=
 =?us-ascii?Q?bJKQ+9R+9DXfuPrQpvv1hbwPUZGpoNFytA0x3NZJ34NTHfvcAz1kVfKdiylT?=
 =?us-ascii?Q?lCH3rNbHxxe4BEm348ka9aaMLU/jgbleIlnUg8BIEiocMStI/Hgw6tBy54LT?=
 =?us-ascii?Q?0Qma5HAmNEcseY9wbBuzuOtiS87qgoE3/8VgyJ7K33OEcI25y6pDwu8W+Cs6?=
 =?us-ascii?Q?DGtbvq67jNevCs7Q71toQW3YQ9FzphXYNvu5WIzfF8tHrY/dAkxCbv4GVwkC?=
 =?us-ascii?Q?DqqUMhXkARaushXAwDw7yr2jAF5NQ5utOHOJb1c+oc9idNXK0vXm1r4JBLn9?=
 =?us-ascii?Q?AelJI6QiZQvzggoG0Tdr3ZpL6lg9I7mg/VYv8nxkf5HuIiZFk4QQ4yXv0V8y?=
 =?us-ascii?Q?4swclagQJoXisxZJxyyiekMTNlSoaRCZZ/qpqAsVfflKH30lZ3i0fRxDw8pk?=
 =?us-ascii?Q?zXZoHqyhT70BM7b4zs9d2qu0f5MwUCbJezmO52kXc0KQfvPH8axbtld7yGha?=
 =?us-ascii?Q?fq/Zpg1rVyUc8Yyf8zzH/BkQLyTIboC04sPdSwjdvPMiFFLha0BCaLN8nI5a?=
 =?us-ascii?Q?gN4nbulwWmc8Yn3MeeAGpPEVtZzVCBCOdXN0Q5v/FYFKppmFgHw5oHxGKbs8?=
 =?us-ascii?Q?OOsc6gt2aPYJVPbCLtNXoFim0cZuvOc8lIuDu2J1BlaKc5TWtROXTdwZS71S?=
 =?us-ascii?Q?ARtLvlxEJqp4zIU38Hnh/6Mif6Uhxw+cNmyLNXQqUsNAescLsB415x0mFHFe?=
 =?us-ascii?Q?eTmEPXauhysAxHSzbaOSsRV2FUzu7rG0qrOuE3tsjPIcrKVI1nSw/oyZf+pr?=
 =?us-ascii?Q?y/CMFAUdrLF5yN9sadnraarvR11XJeH+NrtNfkVHwXNPSPYnhEwXzZeCF+1s?=
 =?us-ascii?Q?xDXb5SmgPd49K64QoQ5Sf68/79j2jMbN9ae2+eiO5XNaUenFsYDvo9cswFs2?=
 =?us-ascii?Q?MFoiP7mDF7ka4cvqqIpA3bgry1FUf2j7G/uFW7UjE+uXkhoiAuAL1qy8hc+8?=
 =?us-ascii?Q?wytvVZK0IRIyQXem8t6tCSaxqtNbz5k=3D?=
X-Exchange-RoutingPolicyChecked: kiaqDVSJ91YX6wRD5RqvJIgucRwwFxBrqEka7O9FcPu+Tgayk+pcxF7XsoQebj75Hod9X9alH4l6CT1GWTJS8vUOXH1jvRds9naemqZPW0Phh4WQw9O45SzAaEFlHpDBbXvsABPH+xtuXpgjblkDDLJRattLoDsiQxyOoy0KyWwwh1Vc3FtaNAM5hkRy38+Ilmd5D2tVxBLHdq0ofD4n9wyLtHodG/4l0jtR00dpD+ZGC9dDdylf2Lm1xYP6pS3E6zaZHYiiREwI+8xZtbDmDyg+Aq8Z5UpJsFfEUuH0DLxc0xcs6yOhXzSKCH5IACGwuXs+OT0KUsO7JLfy/2Sqfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1422288-7546-4e09-57e9-08decc1dfc0d
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 03:10:29.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzF4e74L/B6yJBiZd0nfS0wbdUIYIRn8szVCZOtaO/6W08Bqfe7EtBnmFMIU/2Jzp+c/B5/K2mUmSJZ1009lHmw8Aue1n+9QNw6pIdlcBeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6712
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 02:21:07PM +0800, Richard Cheng wrote:
> On Thu, Jun 11, 2026 at 10:47:27AM +0800, Alison Schofield wrote:
> > Mixed-granularity regions place the root decoder at outer HPA bits.
> > A root target then owns root_gran / region_gran inner positions
> > before the root advances to the next target. That ratio becomes the
> > root target stride in region positions.
> > 
> > Account for that stride in endpoint placement, position calculation,
> > and peer-distance checks.
> > 
> > Remove the temporary mixed-granularity attach reject now that position
> > arithmetic matches the selector layout.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 79 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 58 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index d5d19ed62171..9fff538a9ce1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1444,12 +1444,34 @@ static inline u64 get_selector(int ways, int gran)
> >  	return (u64)(ways - 1) * gran;
> >  }
> >  
> > +/**
> > + * root_pos_stride() - Return root target stride in region positions
> > + * @cxlr: region
> > + *
> > + * Return: root_gran / region_gran when the root granularity is larger
> > + * than the region granularity, or 1 otherwise.
> > + */
> > +static inline int root_pos_stride(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > +	int root_gran = cxlrd->cxlsd.cxld.interleave_granularity;
> > +	int region_gran = cxlr->params.interleave_granularity;
> > +
> > +	if (cxlrd->cxlsd.cxld.interleave_ways <= 1)
> > +		return 1;
> > +
> > +	if (region_gran == 0 || root_gran <= region_gran)
> > +		return 1;
> > +
> > +	return root_gran / region_gran;
> > +}
> > +
> 
> Hi Alison,
> 
> This helper computes stride from gran ratio, but nothing from downstream
> checks that the stride equals the number of endpoints actually fanned out
> under one root target.
> The patch assumes each root target each own stride consecutive region position,
> when that does not hold, the additive recurrence below and peer-distance seed
> both mis-account, and we walk off into a foreign endpoint.
>

addressed below...


snip

> > @@ -2010,6 +2042,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> >  		if (rc)
> >  			return rc;
> >  
> > +		if (stride > 1 && is_cxl_root(parent_port_of(iter))) {
> > +			pos = pos + stride * parent_pos;
> > +			break;
> > +		}
> > +
> >  		pos = pos * parent_ways + parent_pos;
> >  	}
> > 
> 
> I have a question here, on AUTO path, the check are bitwise and order-independent,
> so they accept it, then pos comes out d*2+u+4*hb where HPA decodes reads d+2*u+4*hb,
> so 6 of 12 endpoints get the wrong pos and the region is rejected or mis-mapped.
> 
> If my inference is true, it contradicts the cover-letter's "every arrangement" claim.
> 
> --Richard

Hi Richard,

(Oh, this got long! Spoiler, I'm proposing we limit to configs where
root->endpoint gran is only coarser->finer, ie. monotonically
decreasing. No coarser->finer->coarser(again))

Thanks for digging into the position arithmetic!  You are right, and your
two points land on the same root cause that Sashiko raised from the
peer-distance side. The position calculator assumes every level slices
inside the chunk of the level above it, root carving the biggest pieces
and each switch below it slicing finer. When that is true, the math is
correct. So courser->finer granularity as we go from root to endpoints
all is good!

However, when a switch slices at a coarser granularity than the level
above it, the bits are out of order, the calculator places those
endpoints wrong, and the region is either rejected or mapped wrong. The
selector checks don't catch it because they only look at which bits are
used, not their order, exactly as you described.

First I revisited the CXL spec. The spec does not explicitly forbid
courser->finer->courser? It doesn't. Section 9.13.1 only requires that
the levels use different, consecutive HPA bits. It doesn't actually mandate
an ordering, so the out-of-order layouts are legal.

I looked at the CXL Spec and the Driver Writers Guide examples. Every
example is coarse->fine:
CXL Spec Figures 9-16, 9-17, 9-18, and SW Guide 2.7.2, 2.7.3, 2.7.4

The CXL spec enumeration tables go further. Table 9-16 (a 12 way) lists an
out of order ordering, but that has an equivalent coarse->fine config that
produces the same results.

The gist of all that spec talk, is that I cannot say we won't add the
suppport based on what the spec says.

Next, I considered teaching the calculator to handle arbitrary bit
ordering, but I don't think it's the right thing for this series. It
would mean reworking the core position calculation to gain a case that
nothing, no spec figure, no table, no firmware I'm aware of, actually
produces, and that users can already reach another way.

So what I'd like to do instead is define the scope explicitly as support
for coarse-to-fine mixed-granularity. That is everything this series set
out to enable, and a clear superset of today's behavior, where any
region granularity different from the root's was rejected outright.
Gracefully fail anything out-of-order with a clear error rather than
letting it mis-map or oops.

I also believe it meets Robert Richters (AMD) needs because that original
patch did not add that support in the selector bit accounting.
Find link to Roberts original patch in cover letter.

Does a clean rejection of the out-of-order case work for you?

Other folks?


-- Alison


