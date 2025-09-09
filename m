Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B332D5C74
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439121; cv=fail; b=XF8tuR0dcVTaNqQgp4UNRgtdJPoyrBc0Utg8uuQgPocWEdLI03wF8dZ7JB4gOLZvxMWyl32Xqlqz4/k1SVMzfEgaSSbcIc1KUs1aWqA8ze3YD+o5svDePVsmxyfxPwPXzm/EMSOf69N64akeTbLWNTbtxWb6MZ0fyFewYuIcT38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439121; c=relaxed/simple;
	bh=iW8f7whXMjOXqlky+PhuyGYpZAKo0//jtNUuoWJi+7k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L7kNj28jbB8IGY1UscW6S5BI+ThgzHPC2ZuFoGzG6jHqDOWV6peW5QRHZaf7fEIg+FiaaB8ZWIMD+pz0D6jG7w+ZOb9g7IuuJiYrYyIgY6pVSmxlgnN4UBqecSSUCZl6nA8SAhSUKUWqaBpQ6hj9mAX92W4Drhqclg77maaMuXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8RFFNQ8; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8RFFNQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757439119; x=1788975119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iW8f7whXMjOXqlky+PhuyGYpZAKo0//jtNUuoWJi+7k=;
  b=n8RFFNQ8NAWpkwQ5FYUjZOPdITK1SiHjInOJrYUhgq+QI6lXPc2fZxUN
   qlWNd4PjJXO12weCD7URrdui7ryDBqklAQQ5kwnv7hO6x07n+vsaBosTb
   oFKToXsuSV7HwAHgjn8QYFcvalK/+jCGAu7fEuzpolirG1Ou8eEmW8lvr
   vPL5xTYBYggDuUzgDvI7PoLDCLL289UPNBNAtw34kCEsV4016OnyJGXYB
   pdQ3G9vX+/Ar34q8r+JGiqtfAZEyiSm60/ETvFM9nnOWIKWEITx5gQysi
   u5LNgOxZCH6xfs6we+/CCB1aGfHoFTIhlN40WSau9a7GBgHclXN23yP4x
   Q==;
X-CSE-ConnectionGUID: UHLjFRV+QPux3E1hps+LtA==
X-CSE-MsgGUID: 2fnpI6qdRdi0u3ni+cG8LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="58774027"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="58774027"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 10:31:59 -0700
X-CSE-ConnectionGUID: Ju+L1obeRN6eQhdnEPYPIg==
X-CSE-MsgGUID: v1XilpZpTiav9Wafd3N/fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="196827376"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 10:31:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 10:31:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 10:31:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 10:31:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj7RWA4LiZWo851TsoHl5ry2DTUcH/glNk2hKApR7iwadrVDSK3yHNdz2NJIAFmWFKVjB+L1VuNmlFYQZ9a8RdKOW0jmrKOtFUhBynSJn27clGD+MkNy2J+aqg1vzkqdqawu9h+F9Z6bp7QY+W4tN6RdJjtHsTaUIp9i9ocwRNMQAdoC3rsgOqEa9BojuojdtVzoasUNQr66xtyEerEokvfE5bgUA4hDvalnUHsYfuMLTk2/EbcL7/43R3m45hHFUV1ieTWtebnmyBncb3cLOV8hyw47b/2+QKF4FfQSyzd6mRJfv2Rsi+Pka/n7NxUNhfyjJjzZ4L15mHdszFF8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsDc30WAUQsRUO+LeTAPsHpoaWUm8Piyn+sIc0CkD7U=;
 b=MzIbkrWAOaLohczfgk8vMR1u9OIqMpT+VHfxhCJ/RNWyWuaETqk37ZRckGtt19pl5cKtOSe86aikn28e1BnDwa3w0nFMaYMST3HUsL7mvkq0C19PhvhncSkcuvvHN2eBruhbFy4cbJCRLlYnvPbhgcybt1HK8dzDyTKOgTGh7CtIGu0a3TgUKUIR8MwcdgnosM5+UJsgEx3QOFOw/RYqcqUHEjgb3GABxhJ02zp0GAKPowUiTkVSHxuR3LZ8jvi/fFaBTGxDBUoFjtryKVA535RmUIaPBd5DKrQ/oq+qqhfmHCfUZRDnRxb+a+bdGtAiI3+ONXkcK5k6eVBYsVN0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 17:31:56 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 17:31:55 +0000
Date: Tue, 9 Sep 2025 10:31:51 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/region: Refactor address translation funcs
 for testing
Message-ID: <aMBkhxzQTZSEkSlM@aschofie-mobl2.lan>
References: <cover.1756446925.git.alison.schofield@intel.com>
 <f0c6fa733cea8585f2bfda0851489bd7ca2e2b2c.1756446925.git.alison.schofield@intel.com>
 <6deca3ef-2284-433f-ae91-ce1ff9f7a8b7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6deca3ef-2284-433f-ae91-ce1ff9f7a8b7@intel.com>
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6345d4-9ca0-4f7d-9eaa-08ddefc6c5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gy/t8cUVs6H6/Ps1FFbxNK5WKl0m8i+8E6FxkRkH6MmdpxOWjeJhwhvAvAKt?=
 =?us-ascii?Q?0W21GwOjCSVCsa5Lmexa7Y+82QGxKKNVf897Zv6l9MX2jdkjpPe6yPLsVygq?=
 =?us-ascii?Q?LFuZeY4xT9Di5YegQ2P+U27Ul/XG+2eXdmnJGHgUGynovLd6bqm64qpDw4py?=
 =?us-ascii?Q?nStkmxnIGc1iaBYTEQjj+dinLPvK5IzZ1UHJIAnCwqntKvQ8iMAiMVMa7uxC?=
 =?us-ascii?Q?FZTcX/peBkH9J+zoRue7nCuSZuBcHiP/sJfurn1/GcM06PhNPCLlVsobtx2e?=
 =?us-ascii?Q?e32seoMD7RitMXAvBzLjDWqaqYcoG/ZgVvZoqMN3Z09/uI4lquftCLN8SIt6?=
 =?us-ascii?Q?sAXWIBQaQ/2JEVei+wxMf1jKDG38xsXy/28ByfEOpJbDYLONeUbOgTIO7uIh?=
 =?us-ascii?Q?MRxJjvH+Gj2etLL197ikzvE22dblvBOSpOptY2cc91fBzyUOnz1P1PHvOFjX?=
 =?us-ascii?Q?xvNUjU/YTHK6KScazEqTLXwUNhEdSzKZfqGn1tH+uKREHm1XfBHlIAgu2aR+?=
 =?us-ascii?Q?VFThTGBNNmmLYBzgE7aLAPuWFHttX8++1+x9DbTl4sq6y7nraXWWrGV8ba2u?=
 =?us-ascii?Q?k4eCoHFUwBCACaVb4SCfTwf5cOtnQRIvYyOEejqcFMjbJm00fa723CZ0qvBB?=
 =?us-ascii?Q?53aNVDpEuLQm0CC8HBUi4GPDDGAQzLy7cmky07+BdL4J6ZhVEi2c3+9Rp3gq?=
 =?us-ascii?Q?oH5LNYTj6l8UBGr/76Lr98czb7EQlbi4cS46yw6dcTTi4EPSsEyAHQuKR3PS?=
 =?us-ascii?Q?piOlQsxUBdJvCHTOWWuuNnj+cjFSam8o0Bd49Rmbu78Ly48p6GjwPKlPOAkM?=
 =?us-ascii?Q?M7iAs/Ul0ioc+136vi1pNuN5lcqEka2Jj+ZgM+kUyKyYCaQpK4YhSHhUkHNl?=
 =?us-ascii?Q?rl4adhUcok/LI9qTSdPutOFiYmvdxaax4GiAJr++AP8TeZ+XN8jzoULq6s36?=
 =?us-ascii?Q?L7aUC8QBvE2+U+FzuypUTCMVXKq5UfbCzwQcghslxNNPWacE6n9kB180aDP6?=
 =?us-ascii?Q?JbYGULDY/Qx1x7ep//xrpJ7lGAjKE4gy+yZpcNkQXLPLfykP6KyuNP5rmxdW?=
 =?us-ascii?Q?QfyLEwsLNHhHaUf7jiZ9cYbcZhbTM3HyGNeEigYgHf0/VHM41WfuHqGopeVZ?=
 =?us-ascii?Q?0VLQn/Y+AD+XWcSNSqQbOF9kfq4Gor3M4FmcENS7QetiSDsjRNMPHNFPmkjw?=
 =?us-ascii?Q?sLOxFEfL/8JjkFkOf2gmWYb2HDMlHU86mxul/O+lD/HZA/mdp1E2L93mG2ED?=
 =?us-ascii?Q?4zqfjK89fYPmF+6yTcNCU/st6tOhw56ZSXbBzX2wU3Ej2vcol0F3a/P8Gjmq?=
 =?us-ascii?Q?2cT9ZP0Dg05Uv/Jism7+hXI/Sy9X/PS7BGSIN8uqclkip+LlnisgA485lGwy?=
 =?us-ascii?Q?G7F25FaqJOJsDFeBLHKHelZPqQTRfFJwGlT2Ebe0K9cNlsm8VfMSnOJOIJ2+?=
 =?us-ascii?Q?X7677KC3lM0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p3TndWACft9tMlH7K647fXI4hCM+tWDcL5yvno1MNmuBfUjC8og6MZVGO87h?=
 =?us-ascii?Q?+07ZwCHip4PzDoyyS1QwmlLO0RtvK5o4O32jO8isRKHo3h3Omg31mU5IJbsY?=
 =?us-ascii?Q?XYPeC0K8zBLWT/1kUt6mHZy9eBw4nGzYRWVbZJhbqnFxXr0fjyWgylrCPVyp?=
 =?us-ascii?Q?3roSk8g5gc3Gw6AqIFR398JrGlsCYw40a564FZ2ekSqgiu3eGxWS8upVW06R?=
 =?us-ascii?Q?+1X7KA57geNOZiMzi/LeEAv5lZbjBXUVH9bUbqj5a5/6UhJYn5DP07L9cWj9?=
 =?us-ascii?Q?BhJsPkh0BRPhamOWhF/5rQ7UNT6kypVP/dMN2gL+z0IX+pp8NCGwxTFZEOSj?=
 =?us-ascii?Q?C8cjSLrYl9MdZX4J0ermjhv+DhF2cNqL33NOVq4lKQcFBeDi0e9jKF0lHIUv?=
 =?us-ascii?Q?YFnvzm29rpgKzjoW2sUT/CRWFC4pZl6cs9BPNuFDTm+VNVzYgAUFvV3lvYND?=
 =?us-ascii?Q?+Oz7MCrAhgXF/6QOkNrpi8T3Ifgb/Urjgky501QkkyFXryrsNMmTlk27AWCy?=
 =?us-ascii?Q?VVO4C1zFMPLpxQ77Xd/RRArFfGcw5caBhevcNyaQgALTe2fqKqgJs1y8q3Q+?=
 =?us-ascii?Q?VRFm/4iCVlDQfpu/nTvQv87qHKBwXY2AqF2TpMng3dC84h9QUCe/Q3UyPiRZ?=
 =?us-ascii?Q?/2kHY0oZahYJhcmKSUWWIpDLYmESd9mQtIiD98f36RosdbBzTnOpo4K3gcVH?=
 =?us-ascii?Q?ReJKHikIyk4e4zAnAhvmWvMP9EX4hwQC1REIKVX9ETc6Z6wlR6FCzbd94GUj?=
 =?us-ascii?Q?CcEJlK5urcNGqtVI3VHTa7xp17KYvRLeDy4m57WUhuUhTz3EN1WcaBCilS5u?=
 =?us-ascii?Q?XP61se9mDMzoEazanhDwOQW39ONJUEPcYmVOtIw3p0+YblY8kfV15xDxU658?=
 =?us-ascii?Q?U/lo4FZLsIuBTjKJ1hMhGoiZCku7QtVabFDEuDOa9ZmGQdJdREzxV1am7mfR?=
 =?us-ascii?Q?CASBFubj7SS4GZ31gCCGbxyH2Z+72zPqhqaU9KTtxpa+CZBZ7guVC127gMOz?=
 =?us-ascii?Q?JEkJcjfHsoJ7MuArFF9NsRCc4BzPNdkGL1t2YCMLDKV8NBsLbxmmMVyJKAH0?=
 =?us-ascii?Q?+IBlqLkJfuxKmT1Kznz8flawS1mLoLf67NFhBddQGasRVVgf6YyEDN/Xtt65?=
 =?us-ascii?Q?f28k3rCa2UkDv4G4aOwCXisghPKPKaLaCpDgHXARUskKGew2/GYkLeQEqtZb?=
 =?us-ascii?Q?AxYZwJFmg0ugjosMleKq1/NUD9RUULMG1pYdFuZMuiX4/47c/E1K2JhKs+MJ?=
 =?us-ascii?Q?glc/HiRLTFoq2YmlQJ3n6TD6t7ypgCUu04XHhLMF+chY8VC1bNF37MoAMcgR?=
 =?us-ascii?Q?pIZdV9oIOFmqDWeaHNiZ4nzHctmqRO6/JjKAHOQFLmefynJ/VpFy3sAQhGIE?=
 =?us-ascii?Q?1dKHzJNrjeLdrAJqn2jwqyySxlU9/JS/voO0S82XTsOYRvztybO+uF2L621E?=
 =?us-ascii?Q?OPMld+6gSKkpXQE2t7K/Epi3vVwc5lU44UafHI7rdyCuTQcAzdkLRnRtPWlB?=
 =?us-ascii?Q?VqYHT8xy6A6D/Hu1EChtD6OTy32DJWMjHoCMcyhsqpD4niMk/6YuauK7imw5?=
 =?us-ascii?Q?BJ53cQBuMS7D6Q1bRjs9G/MzEcWShULlWl2XVMulA/76SfSzTvTOceqihgf+?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6345d4-9ca0-4f7d-9eaa-08ddefc6c5a4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 17:31:55.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNXvqrEG967e7h01nHS9YOT45MiUIT/fU5Eq7aipbpK0qqIlzk9lTwWG4VsUY/JlS5+T2IXz5USIFCqrh0Tezpugt82J6xK22s7J9QQl3Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com

On Thu, Sep 04, 2025 at 03:05:00PM -0700, Dave Jiang wrote:
> 

snip

> > +	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
> > +	if (eiw < 8) {
> > +		temp = hpa_offset &= ~((u64)GENMASK(eig + eiw + 8 - 1, 0));
> 
> Should this use GENMASK_ULL() instead of casting to u64?

Yes. Will do in next rev.

> > +
snip

> > +	for (int i = 0; i < p->nr_targets; i++) {
> > +		cxled = p->targets[i];
> > +		if (cxlmd == cxled_to_memdev(cxled))
> > +			break;
> > +	}
> > +	if (!cxled || cxlmd != cxled_to_memdev(cxled))
> > +		return ULLONG_MAX;
> 
> Maybe:
> 
> 	for (int i = 0; i < p->nr_targets; i++) {
> 		if (cxlmd == cxled_to_memdev(p->targets[i])) {
> 			cxled = p->targets[i];
> 			break;
> 		}
> 	}
> 
> 	if (!cxled)
> 		return ULLONG_MAX;

Nice - avoids avoids the redundant check by only assigning cxled when a match
is found.  Will use in next rev.

Thanks for the review!

> 
> DJ
