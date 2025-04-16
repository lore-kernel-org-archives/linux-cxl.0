Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F8233713;
	Wed, 16 Apr 2025 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744844928; cv=fail; b=YNlz6aYA+gbP0TM1WHN160Encg92H2iqlElDqUN2jW0XwrIFhrV3pwNFSf3RPQHcXLNgwnOWBNc317NpEG73/m6Lv/kDCl/ZjQ0X+iofteAi4Wcr3T9WaLb/5W9WZrpsWNpvg2vEsB48J653MfwdvaUVdCxL05yot2dXJHwASSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744844928; c=relaxed/simple;
	bh=r7PXaN/6EQfIbpK6Uou4/CF1pLxskxE0Hg/Wd0Bi+8o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqLOrpcN5CAC5vJAYFl+TmRS+7NJNb5lM/KniU3SUgsIz+unCydeKULHHtAdJkbwxs9/H8TqeuA7bXb8TKFcMRtUo1ckQMOb66AL4o+nJMxSNGljrTZUSl81TAT9PQWkVE4hJaV8eOJIH9/BR2ylGCj6GONhbsjMlomDc8Caz/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7F0iW3N; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7F0iW3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744844926; x=1776380926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r7PXaN/6EQfIbpK6Uou4/CF1pLxskxE0Hg/Wd0Bi+8o=;
  b=l7F0iW3N8xGt/Lj6t8YNvF1FVdrxJI5NXENxh+6IM2D8mpWigt44D5XT
   LpAE4aQDthvdlRQb8cVRHCugLrOaetkt+VLp48Z8FONgGJQvMMgRuzZDY
   Jec85sp/BV0iyYUOEXuIJT+/ylSgn9e1q+FVXmx46niFJMgNb7/QdWQQg
   5w46f0khV4kl57UgzRhrHrKwqBJU3xA49IwK4jAK61yODK26pVG2/vHzr
   IYipFAHfRJySDsE3lOJKIEQnWWX1tWgD6GbVFag1xfU0aZMpLC3wx+4sd
   vWq207YxXNJLz+1PJfHTohGX9llMGuuEV8uQHLGodLsPHzRfUTsYP3t07
   g==;
X-CSE-ConnectionGUID: j4poJS+FThmlp9x8KgT9+w==
X-CSE-MsgGUID: 2Wq7anFpQDiz8kTocuEocA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46546107"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46546107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 16:08:46 -0700
X-CSE-ConnectionGUID: jHQvisCfQNOTjq+BhlX/Gg==
X-CSE-MsgGUID: i9p5iSziSpa7jl4idoZxEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130485372"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 16:08:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 16:08:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 16:08:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 16:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPsBkffW3ar0YRLOuYtbUtTQ7sbXm2QF1GbXI+abjW3vcoU01Lnef4hL11YVrzdM388TtIqKWoWjOPHedLQhrPXxQzw514E7bLDtzZK8A/EhJklR12yZ3nRaKkfek5bQ3AMZblpvdUelOaUQWcp0Zrq5YleA1xAC12mmviBHo7H9dNZ26yQd7qYBk8XPokrRXvKm1BNEOrEDrX6RBFC0588rWGhLgsIlp9npySUZlw3dVhLHlO4qhFug8jwWoXpK89g7guaJ3EraqhtdmBTCWaH/btvck5SeMPChM+2paHXl4vTlKQoTtl6SSYzC3UZyXPdTfWkL8RgRET8sZzBMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4N1/tfzr2zH+HDDUkGttfrxVOtcbjh9Np6qXIKHc2U=;
 b=ua6GecmApvxAQODy1L5lb/O/7ES1M8wh9mpWCIY6SSCZ3oFu9Z+gFMs4KUo1qneGfa+u0TKqGyV9/TvzlBYW7uiRktuHksP3PrMBiofQPzWmsi7iMm814ACKt+BJCuZ7EHt929EjfKzCYLfIOmlBfq1Wce20q8hTLM+uBdCbNcFvTSliUpNCwpF44IP9351fpvvoSUWvZNXZqeML5gwdzboKuWeC0h9sp6EpFtGuP1FcALF6O6A/qdov0VaPjzKz6quz509eRogBTx3HYt3zSvwCff2EtMq4nI7586gRBXkHsyHnRdKflNYXGWoJ8xtwjnXS3/NtIAgYUN2HJkqTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 23:08:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 23:08:12 +0000
Date: Wed, 16 Apr 2025 16:08:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, <akpm@linux-foundation.org>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<david@redhat.com>, <Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	<rakie.kim@sk.com>
Subject: Re: [PATCH v8 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <680038591bb93_1302d29427@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250416113123.629-1-rakie.kim@sk.com>
 <20250416113123.629-4-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416113123.629-4-rakie.kim@sk.com>
X-ClientProxiedBy: MW4PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:303:b9::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: a71d6d8b-b47a-432e-e1fa-08dd7d3b8f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ErIZ0cULWBs9yinZsDR0FLKK2+4SZGFO3vcHpRXs8lMj8OWRphUfgLanNQa2?=
 =?us-ascii?Q?U8kiAbZctU0coz4tck6xmgCgptQEVOHfVMsQHoZ3bhQ71Eg9i9ODqg1LUaMz?=
 =?us-ascii?Q?8F8q6tKn9vzcjohoh9RR7P6ytSn3jyn5Cpf2WFH1tYqoA/5v/dsxXzZLaHF+?=
 =?us-ascii?Q?j6Sna5Ypd/fcEnhCuy/jsJsuG7gian4x0LedVbLE7AxKz5tl9WkkHAmS3Sh7?=
 =?us-ascii?Q?yet2/mbzXmjLgICJ20xe2PM58Lt9L0VLLrHmGXufxPzwycrekM8De8AL1MHh?=
 =?us-ascii?Q?XpXk8QYlUc2shzIgz77CgG02A33UZMY6RjeaAxQfuJYULFMPP402IYK7h9m8?=
 =?us-ascii?Q?2aqffjSlwasuhStg+27myr1kLdXxVCw1BrsnzRRw5x1J/8PG7mGpG5dEUCLk?=
 =?us-ascii?Q?8cjYIBs3JfBl7DRoqnWBfd7csh5gBBdQGG7W0L03Avb9vE5Ep5Tl3rbekRAJ?=
 =?us-ascii?Q?O1m5Ag4bZx86OXiaBJNlPSFueNk05yqFnjgNI5cXk4o9y5x16aOm4AH5EDCU?=
 =?us-ascii?Q?oVGCqbFmi6Yqy0y4JmKuOweIyIrHne9y6uU4GM2nofdtaSXhvalH0Ce/pBNt?=
 =?us-ascii?Q?x57c8Stjc9RkbBuaMEhjEWs4oBYp5k2ouI/K6V8oDVGZJk9rAEpsC+VZb6cS?=
 =?us-ascii?Q?k4MejnS7XBCAQFvdyBxeLjysx2F/L3Tar+RI3ipHm96MTVtTWyDu4XYdsy7D?=
 =?us-ascii?Q?C/+Pj750Kjv/Gs871jW3Q7/dtjkjSoH0QxohpHPKI7uuqbCA0ME/C85FDiF3?=
 =?us-ascii?Q?X2lAUP9JWGBAzYgTRLgD8XS8gOlzxaXq4zKlfoZ0IeZPE0stCH2HNZv/9oYg?=
 =?us-ascii?Q?IaMparFMOq+uehHmhMfghCSdD/pg9CJC2XTebZAxvM+nBttD/3Pv9PMNynT1?=
 =?us-ascii?Q?PbU+iYbesuzDUFXKNo4dfsxpauPMmaaUf+SwpfKlkY2WZdnHWPr9ZQMNzK/X?=
 =?us-ascii?Q?TUxKBKe1nVB1f1Ft0BAQNV4Bf+Qujr5aIMbdmpig+rTLT8PJWxd6OKeC+DjK?=
 =?us-ascii?Q?VoUOhOkZoYSR4U5rTKrnbmPrxrr9/7ngtXINYpgvi8ckSlm69nbuU5aJxcZ1?=
 =?us-ascii?Q?T0eIWmKcimXmbKKdb4GoOsYqsTnyI5ieNIrnnXU6gTOtNqyCEvddOxBvQAnv?=
 =?us-ascii?Q?7TuR2KCdLxh8fpwKLChMlL6cnU7a2DGVBmXfyDLTqIBcs+r0pd1HSlrAHTo4?=
 =?us-ascii?Q?3VkdEowMzh8tZz14IuEHvllQvSJP42a5cVYECv7yknFHiXHeg0OHybvQ2I+y?=
 =?us-ascii?Q?2zhFOGhuh6f5c9EP5+rVIUVAJ9p9nmhYBH51cvpJF4rnXmjAw+7ZakTMyjhq?=
 =?us-ascii?Q?W0yUgKMwkGjSxCgp1zQPS74ZGRiuHOeK5Z3nrIHh8K0Vzv+E/CXdWyjyP6eV?=
 =?us-ascii?Q?wmhFVwGoW4lG0zUX7o1FWTS3dabIJ4Zdu12ES39GQGnrwhIqg61bt+vWRuRH?=
 =?us-ascii?Q?HV05hrDLa5U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tH9w7vMOODKgiIvDUpdMnzqhQo0qhm59VUlSlTLGElXBSMvrSOPaONV4ipv2?=
 =?us-ascii?Q?iwPPhUbb3Er96kldSMjpZofHKxTytlUBdRjgJQIrOr8WwoXXdsq4n1uyvQHc?=
 =?us-ascii?Q?5gyNQcZQyQ2x9NibS9f71td7GSXzSthScuypp23iWIyR8hEAXPk10Ptyi0C5?=
 =?us-ascii?Q?U3bT9WC4eAO3Wv4lq3Y+iATNk7glq7xtxNvBGFNHYB/mj2iTL60Yj1p8Ki9g?=
 =?us-ascii?Q?DEJfB1LUd4r2m9RHv94yq4jpTPdUiiITPQlP3mdae5a1o+yA7BjvOPW+atVz?=
 =?us-ascii?Q?whNo5teBcwfVAWjvEk9+IIC6AcQXXxEUYaW86nXaYkeyBngWF6mJ+9AUddAv?=
 =?us-ascii?Q?iuCPqqb4p6aSzLKNEfCvNA2eJEynH/vzq0/oVMneEQNmGojBHzQC8+5tcJf4?=
 =?us-ascii?Q?RL7C4lHr9TCrk9d1eRrtV3fEFKcqWSjAF1Y/X2Km5Ys1SuFDYI6txbRx8PfX?=
 =?us-ascii?Q?33g8P5Zuoq8ybw2OHaO6FYjnqnFUIGMVWnoxJO0Cx24cOQHdamciLmTS4uJu?=
 =?us-ascii?Q?UdtzLdWr01bwrsqk/Bx4cq2uQVGMJ5NGVwOKRpNsG6+e+XzaZxoroER6e9Td?=
 =?us-ascii?Q?Ed5RkwS80stLDeRXeXMb2V0r/ROxP51aD0Zq5NwcDJS6rgYwvLU+rM5gmqRl?=
 =?us-ascii?Q?rMiE2+9YTKeBqKOF9LAMR1hu+nx2i+emq2wuo16NoKD8JWx4aZ1kY+TxpC9u?=
 =?us-ascii?Q?mq7l8tG9lxVvnk660Car2NJQH1u1nXrDkyA1kOFZ9FdtIaGUcNYhRZ1tCiOj?=
 =?us-ascii?Q?uWXZnE3UU65+Bv9KS1wPHjhnkpGfNCI5z72NrE9j2X9jJHFdhGTLUBFuY2y6?=
 =?us-ascii?Q?Povqzwz+TUEvvt5WAKti7aEevaRBy4KDF9gEGjySazOAkyB4AxxZkvrUlow5?=
 =?us-ascii?Q?CchBbDt6epBN4CO4300Ym1clTWJWylbusRuFEShEZYXRjWdRTLuJpzelMnIf?=
 =?us-ascii?Q?EVLHy1JJS0qyjYAAjkcAZv11UUg7eGOifiRaHTXw9vFU8Gu5TRQaX2fJ1t2Q?=
 =?us-ascii?Q?gkuNx3xSwB/c3oS8PX318FBTPKrIQdsGWAt5S8gQRKJFEb7DbRcISadaj7XK?=
 =?us-ascii?Q?6XMugetFD6vVPWkwV5Zqljj+12oUM8HsFc//Uqspf4WBMTLHcAAx5Nd4nPbX?=
 =?us-ascii?Q?kWOe6fNN8kCb55AgXNsiBqAtac7VOZ05pfrVEAjESnNC6FIG6mS8z5yF0lAH?=
 =?us-ascii?Q?t0q9HWJhWw0zIW+ixpJyy7STVeXYOTSi9WJcS+ss6jsOK86ZXjFgHSO/Clow?=
 =?us-ascii?Q?ZqcvbvJrlbmJIubh4In3ahPBwBaQIlV0zCoMtBew/lRBKqbgbG34xyCQyg1a?=
 =?us-ascii?Q?WrjrzSx8pKW/Q8Sbtx9cECvA+0L18SVM1UI2IMxg74baaKWC/FoM7qyHrYof?=
 =?us-ascii?Q?mjdSg97OSjZ798H7YjM9Q9yAehWG5gvKaqGeHam5OUG1aARm+D0ugPIyTsP3?=
 =?us-ascii?Q?BZklX40jhYovtevZoQJw39Vj/WtkvgZ9zxnIYLkAlkZ7KNZjx8ZsZ5bEScVI?=
 =?us-ascii?Q?GiLbtWFpHIUQF8Lhol62xz/XGj2BLulNdXD98LAwOdUmuAoRvygNUadwQe4k?=
 =?us-ascii?Q?4tWJ7XZBVJbH9AEnvAC65e78/Lf0TWMHPFlH4dn6T5W8+OWYTU1tFUy8y5in?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a71d6d8b-b47a-432e-e1fa-08dd7d3b8f65
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 23:08:12.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbTvQTQRxmk/DYy75/1VDhpbRufMlHoWXg4/0F2b5NUkrShhjasY4jVXeI6Fs12D1f5UbN8R9tHxBpJNKKIAbRKZWdUKFF2j9cCSPC4TAEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> The weighted interleave policy distributes page allocations across multiple
> NUMA nodes based on their performance weight, thereby improving memory
> bandwidth utilization. The weight values for each node are configured
> through sysfs.
> 
> Previously, sysfs entries for configuring weighted interleave were created
> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> might not have memory. However, not all nodes in N_POSSIBLE are usable at
> runtime, as some may remain memoryless or offline.
> This led to sysfs entries being created for unusable nodes, causing
> potential misconfiguration issues.
> 
> To address this issue, this patch modifies the sysfs creation logic to:
> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
>    the creation of sysfs entries for nodes that cannot be used.
> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>    based on whether a node transitions into or out of the N_MEMORY state.
> 
> Additionally, the patch ensures that sysfs attributes are properly managed
> when nodes go offline, preventing stale or redundant entries from persisting
> in the system.
> 
> By making these changes, the weighted interleave policy now manages its
> sysfs entries more efficiently, ensuring that only relevant nodes are
> considered for interleaving, and dynamically adapting to memory hotplug
> events.
> 
> Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Co-developed-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Acked-by: David Hildenbrand <david@redhat.com>

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
