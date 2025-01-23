Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FA1EA80
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605542; cv=fail; b=JztvDI1q3F3h8DkL2b85Xs0aaZRolWHNhoE2KpQRd4LyKDg+GCcngY2TInsZbJ+Ntehe0EpIXxvRdKUQBG+uXq4JubIyw+Q3bQ79IiKzLcvKpOFQjSbvp+nZGLHRZjlM8sszMV8EA5P0DMRjRWovAWUWtwJ5Augp9LIdtTHLNac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605542; c=relaxed/simple;
	bh=IKNkDibzZidsYp6UeLoQszhBYdhHc439aldIKt3VpMI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bEHnZUROdHdNg/M0V6gV1f9CpbXgkITyPoBxohesWS+zt6sXdc03h1t5lqZrHmjmieF8PtKT+LAcFc6vVXFKh0XJdPSkd7ZH2IVFZxRLXlWSsSsPpQaP5I4xX5Car6mn/fAv602b3wCH+y7uuEWX6x433WFSMN5OKa2E1R7KFMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuwUq7Gv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuwUq7Gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737605541; x=1769141541;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IKNkDibzZidsYp6UeLoQszhBYdhHc439aldIKt3VpMI=;
  b=QuwUq7Gviqz+Xs8xMfTxHbOLJUrpF3YNbkwLCv0l9d8w+AlCLZiOQA1P
   ZlG+XWqqqcwqUGzdd1Co8u5yhIC6X33e5DhK4+6VpO3LzyKt34Z5EOBNQ
   pAnfTw4mYEom1r6o0d1yIMTERcio/KSammOxRsCde/GRLqOStvZtKGnfS
   SYSmcQW2Mz/aC1XJKSCnjx2qPpANB2KkBFaGUguUHg+fyYGGTqUqK3Dtv
   qAOvFFGE0xtjDbc/a32dOOtc7qScIpBR9MfOPKBtBOKCMnfYc7nS+O6q5
   FV9lQDisTqae+fu7E0VqCK/CTsT9ENcenZPZ1L1fG/TDQs0gVY2Z8D/RN
   g==;
X-CSE-ConnectionGUID: rcp6dYcVQ2C8qNiK7i65XA==
X-CSE-MsgGUID: BfLBUj6tTQy2O3aeT2G96A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38193921"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38193921"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:12:19 -0800
X-CSE-ConnectionGUID: UUq0dvEKQ/OPkr7HafrHPg==
X-CSE-MsgGUID: aVOX/hhBR+KFsx1zxgGvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="107335984"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 20:12:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 20:12:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 20:12:17 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 20:12:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RomRB1I9P/l7oIdkH2qFmgdJGaHsTDLrJ+/yVrN8ALtnwr3cZtyh199rZ9BUJU8de9D17vMFlwdsb/Alr2raNb3OQZYxY5yfHLZO+FcEHU9j99dJ7xuLmr3PhI+V3PfXAwlOdOqjC+0YSNoFl7pBmXQuPFSBN99CW8e6R8T8GhAmMuhogjOMCwB+1UmgKRem5vtfo9TaW/vOHrGRfH3doEjKXxKtKxiqJJhL6/trXv3tJLbVjMD0xGydKkNiQastOabEWna+c8IH86azienJVAbxCLM6+bdP/ODS6t6uOfqxz1BWBgkm0Amc+vPB98j1eQxEUZom8uYK8dOyuisqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vNjj3uOhWzaCqb5iT79c/KymV68m6qdHOa7eJcqJQ4=;
 b=mcX7OnSEGH4KddmP+vkt3ot1yW60uY6sI8ABhLCqlRPmivuntVIjkrztmf+SJmgI5ZPJCRqLK8VtTNDpQjMM7BC1SCEjzKDNZvV2MTbaz5VoBMfvgRTcdbRn9gFbSAONnoOiUlZvrrxcsB+kldMI+poI593SIf21R15wDMhytVTZQIHB7MCBoTWMKgv4lu0S78hwQ+xETcqI3a6sd/SpooXNZWVWSuBhUMa3u2dmPCq//zEM/xRferTZYiNccii4p11XzcBI03YF5wLOJH/aS12PNGqaqufw8zrxEOy34bzgazi5+uDozgp1GmoQLjxq3Lnz7i1y/45ItX0+OnishA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 04:11:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 04:11:32 +0000
Date: Wed, 22 Jan 2025 20:11:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
Message-ID: <6791c1724f39d_16ffe29434@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
 <67912e07cc2f3_1eafc2948c@iweiny-mobl.notmuch>
 <6791781c4f082_20fa29415@dwillia2-xfh.jf.intel.com.notmuch>
 <6791b9d6ef917_5584029488@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6791b9d6ef917_5584029488@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed12655-22b7-4667-0e34-08dd3b640538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I2KMpLZdLvIr259PLsqS8OxEW3A0vRO8qtF8hCgJViRTqNDz0jbzLscaBv/T?=
 =?us-ascii?Q?1HyQGSOpHIDwh3pfO+aSWqzXAoPmGL80GCdGKDLfU4vNMEljy+wXyj4xaMmZ?=
 =?us-ascii?Q?ceak7RulNrkc1n+p+YOaIe/CkgLvd3COH+hh5pRnlrLYwaIztrurb5OtmuuX?=
 =?us-ascii?Q?1j52JY1o4Qsm/V5DeReLz4kmMws5IF+sms0zzsVhVgnHAyUHgZmqNQVM0F76?=
 =?us-ascii?Q?WtrdZifzqQ054Wboh5fpPhXTrZ/ZhY+XV2eNSt2V7koD573cbrYu/aKchy/Q?=
 =?us-ascii?Q?KByeYjuxEPobzRB/8661coRIevQuYcYGjY32TOYrLmcjMC9dUp6IEhmAjK+F?=
 =?us-ascii?Q?E9pySmcQ3F/Cl4mrfJZtxqzM48DYy9uVFjBJmhAw8Zfmq2u816Ht9haSscKh?=
 =?us-ascii?Q?4QyTUO3Lz+lZB2Fpmrk1yJqkjCAwk5Qnzar8VfmnO4Wsvt330e4ju9Mv/2s7?=
 =?us-ascii?Q?zUH8gcCYPHO1xVCFoif32vcsn/+62uSFRmntA+6e3+OXHc6yomEREO3EEztp?=
 =?us-ascii?Q?kLgKShBcOOHCS/zM0bttofp6VQLM4x6/nAIvwVYFQB+s2TWKXQvpQGyxg7dq?=
 =?us-ascii?Q?BiaRgPV7B3JxbFlHz0lH24LyzzFfKt762wFBEa/fvKpkGpOTdqgF3WRBw5ny?=
 =?us-ascii?Q?ca17HxAGEKy+xdyWFZ9zbI84052XJ2QbsA+Z87R41szejG/SmjvWK924T9sv?=
 =?us-ascii?Q?4UtegKvl6oH4vKLUnuzBGvjbb7F9gq5jaa6m+1caBQfDI/pr21lc35t5oXSI?=
 =?us-ascii?Q?NFGPB8o4BVWtJAcpSr8OJRNED3PiX3z4fvbVicvKgsZfpHEsQSQiuL90V7Mz?=
 =?us-ascii?Q?n4eN9IYjQ2sVy+F4Jmlw01LUxcjQCGvz15wGyr2zaEdfwsCQ7x0UeFeMjOqt?=
 =?us-ascii?Q?IoJHgS5pbwv4/De+ZYZkzmHiu1FE3beW/mDUk85YnndXAXUnkjOg1T9ofWuo?=
 =?us-ascii?Q?l+SHR+eUf34ealGHfLl7NjgovZWII2hZl0Tzkbc8fo/sB50z15bruqD766Y6?=
 =?us-ascii?Q?Mn/PUoaSYFlexSseaZUiT/vb5/ZQfhCsRXV/yW8TqK5Eq7jOS7XBE0WD7wwS?=
 =?us-ascii?Q?4U3t63fHBltHD1emBsGghOQUk6xkD4w7ekscRQkwRpYzpRauMePWWQxcSSnA?=
 =?us-ascii?Q?SkYnzLi/nazwIUHIFeElBpNUBWbXoxaONY72De69d41H4KTQkGO0RyEPfEvs?=
 =?us-ascii?Q?iWy/LJm/QHAhNGjzt7HqZ02raGYEGMUS7uRuC7E0GTaX1VYsn3A2HjnrnQOo?=
 =?us-ascii?Q?EaG5gJaTIXNoOOytIM2ZabJMpYf/GHQrdZqjZy89XxL/hsWvwdO6TkyNP1Sk?=
 =?us-ascii?Q?jUon8TZDGhcVJHRyTPl7HtKs6FhnGNc+U7VSEhe4Kvm0EGs2SraAifjqtTpa?=
 =?us-ascii?Q?x+n+SAx9GneG3QylIKZgIfk+ypya?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUW6xeRcF4Wuh5VYVZ3pYwMDIzoUk9j0pRevPAeBoVg2AaWK6v1qcpa5Zcmg?=
 =?us-ascii?Q?vygcBxrVt5XBAO5oc91dpGGXOo2ufxmlBEyklZ9iYt9iozNsyH+1WqK/3EoC?=
 =?us-ascii?Q?Y4jcjPa/SZOXcXblotTlcJ64h9ma/+o+tHi0jBnY9LITqurhvrHyzzItA76o?=
 =?us-ascii?Q?fKNF1jnK+F0gH/2yzgBgd6JRX/a8C6PvP5qtNbCnHq6HAvB/o6eBFAKDDPNB?=
 =?us-ascii?Q?yB4Z4V2u4R7nYxFqsRd7bPT/Qmk+2hPMJs16QryyS3vsAnAnxnPiwX2RTrY3?=
 =?us-ascii?Q?cPC6VXwuprT80GpftgmNktFYwf91qICJ7DGu1wSYRKRyg7V9Y9yctBBtWahu?=
 =?us-ascii?Q?GAhl7fwO4zp/In7CCGF9Y5G+FM/1B2tXoTNdJza55iH1MNwOw6Gu6b1+qJYT?=
 =?us-ascii?Q?yDGPq+Rejq9YqexE2jsoFJS3TOV09nKvXSicokx06dZXSzj3rFCpDoa32kXb?=
 =?us-ascii?Q?cnOqn8JPuq7U5k4OJBxqMGuziVgzW6t3R7PaXIFSHQumq7DAWVt5ti+hMUY3?=
 =?us-ascii?Q?qDIrx29UmpIPm2AZyaqnlKqAcZyJYzHsoRtOxDu85n7grgALE0UEwV1VX9Rz?=
 =?us-ascii?Q?zkhOy9/mFGxas4wSL6a3Jjuv2FN4D77EXu1ER7WykCMEoQI/dEo+PspZDkrm?=
 =?us-ascii?Q?eaVJRE2hXcLtvjRlCSalbcjx5pnPVxcQ/AIa54h/p3/M0IyRFDjsjmfz2uzT?=
 =?us-ascii?Q?COQYd4No/Mr58l4va6jKEbjkWfe0dtd39EmK0OWiC95mpfHXmCt12qT89H/C?=
 =?us-ascii?Q?0aoAyBykS8QvqHxcUDd/PBy5BwoygTsGfPC1yzUoaziPN1mbrUUhMzBQXm3s?=
 =?us-ascii?Q?XvK7+CTmpDGRxqki8JXQe54jyL/5qcx0JGplzYY+s/5+SACbnF8cOZNF4l1m?=
 =?us-ascii?Q?LsiULlvxujBH7sK6vpWfFA9PwW67nBDOn8fOuXZwDyr20yOdfX56p5OorlZ9?=
 =?us-ascii?Q?mTJJw4L0L4Q/niEcJ8ZTuP0cLsZK/TNX/IKdXkg/ZHVXBoe6Ru4TaP05ds29?=
 =?us-ascii?Q?coBLg58BMmsvoI8myXzCZ3hMvm5KNYC2ohOHzG5vt6KTzeAA2aW0lruAICZs?=
 =?us-ascii?Q?YuPze249B1iIlDup17NAYvSEO+245dLUuGJcv4hLwRBpFDHHZ1oPFZ+BQbet?=
 =?us-ascii?Q?jGneoo3jVoklB14hyGOnuGNJi52NbEaOur2nUlDMyAHH1kiyxFeAlg063o1E?=
 =?us-ascii?Q?XjfWk1q97OMn/Ukqy6zsmQXsy/FTx3WE/bjQimzHBSreXX3SANs2dzoWCMo0?=
 =?us-ascii?Q?SSy5M6b7nk2mr466tGu6VGHegfiAchDlPtjzx6BKnZpfeKtyy2hY746IMRto?=
 =?us-ascii?Q?dkOEAjEWtovPdEN2WvRNN4h2MbXQZfV5BpU55UmKVlGkt/EBLNbx1dvgis6g?=
 =?us-ascii?Q?dUA7CVqDR3bsE22rmIcjRV9CR/RQjFyUa0GQCeo7Yql+43qoCzgbaWMv0i99?=
 =?us-ascii?Q?WxxZYFAxtP8OffTTsNzEUaeWNInwSa1sEreJT2OzhNjg13W6Se6dtqvgtq4I?=
 =?us-ascii?Q?EJorY5Yx0O0/m0KI/bB49hU+McfR06SrOL2R+M9PYJ1ncEMRwm0jnvNgxh3P?=
 =?us-ascii?Q?bg9VA48qaFA5D1e2iiZxmLQ3xMViJ96j8cgaQjftNdApKc3UXnfoIPezMIYC?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed12655-22b7-4667-0e34-08dd3b640538
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 04:11:32.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNCxivDSOUIoBL4+OaA3o1cknUcMKvGqZ4MlHcz7SAMlcmJT+9cgihO9ZNT2g0Puh8aNPFo1wmFfhVfpbiW9KLK/ueogbXJMkORdL2/ks/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> > > Dan Williams wrote:
> > > > Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> > > > tracked in the partition, and no code paths have dependencies on the
> > > > mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> > > > can be cleaned up, specifically this ambiguity on whether the operation
> > > > mode implied anything about the partition order.
> > > > 
> > > > Endpoint decoders simply reference their assigned partition where the
> > > > operational mode can be retrieved as partition mode.
> > > 
> > > You really seem to be defining a region mode not a partition mode.
> > 
> > To me it comes down to the hierarchy of building up a region.
> > 
> > The DPA is in a fixed operational mode regardless of whether a region is
> > mapped to it. "pmem is always pmem", "ram is always ram" (modulo online
> > re-partition which no device has ever built). So calling it a "partition
> > mode" reflects that the partition comes first, then the endpoint decoder
> > is mapped to a partition, then the region is mapped to an endpoint
> > decoder. Region mode is subordinate to partition mode.
> 
> Exactly but 
> 
> @@ -535,7 +517,7 @@ struct cxl_region_params {
>  struct cxl_region {
>         struct device dev;
>         int id;
> -       enum cxl_decoder_mode mode;
> +       enum cxl_partition_mode mode;
>         enum cxl_decoder_type type;
>         struct cxl_nvdimm_bridge *cxl_nvb;
>         struct cxl_pmem_region *cxlr_pmem;
> 
> ... is assigning that partition mode to the region.

Right, to cache it and simplify other code paths. Otherwise, say more, I
am not picking up the argument.

The alternative is an awkward helper along the lines of:

to_cxl_region_mode(struct cxl_region *cxlr)
{
	guard(rwsem_read)(&cxl_region_rwsem);
	return cxlds->part[cxlr->params->targets[0]->part].mode;
}

...and some other gymnastics when assigning that first decoder to the
targets list.

> > > I did a lot of work to resolve this for DCD interleave in the future.
> > > This included the introduction of the DC region mode.  I __think__ that
> > > what you have here will work fine.
> > > 
> > > However, from a user ABI standpoint I'm going to have to play games with
> > > having the DCD partitions in a well defined sub-array such that the user
> > > can specify which DCD partition they want to use.  So the user concept of
> > > decoder mode does not really go away.
> > 
> > This is the question, do we need to rip that "give userspace explicit
> > partition control" ABI band-aid?
> > 
> > As I mentioned over here [1], I admit that someone might build a "ram,
> > dynamic ram, shared ram" device, I remain skeptical that someone will
> > build a, for example, "ram, dynamic ram, dynamic ram, shared ram"
> > device. We can always make the ABI more complicated in the future, but
> > the common case of "userspace need only care about mode and let the
> > kernel find the partition", probably carries the implementation for the
> > foreseeable future.
> 
> I've thought about this all afternoon.  I feel like this is baking in policy in
> the kernel.  Wouldn't it be better to export the attributes of the partitions
> to the user and have them sort it out?

We have gotten by without expanding the user ABI. A large swath of DCD
functionality can be had with the kernel doing the mode-to-partition
lookup. Dare a device to require the kernel to expand its ABI.

History is littered with premature spec enabling.
