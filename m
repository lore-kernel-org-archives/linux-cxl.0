Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB21DF73C
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041269; cv=fail; b=ZXtV9uGwJxATxajZxMX7RpG6j0eopjwhAN5Cu/a68FuS5DPf2MGfl8sB9o7OnZ5SlGIXHo2+bo9YzNBHMVSyGWKRZAIxSDAUy6UJ7kTRk3qA6BpUJH97/NoMwnctIzYX7/6qDJhEz2qop6RuEihlPTpG86VtkxtYk5x1z8Gjzvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041269; c=relaxed/simple;
	bh=SQjJ4nh4QYk7T0ybD7zpuA24m38TTRIO5zwo1jb+RKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fgLh45FGR9mOMZ8kroataRkz4byDAnwyU8Hhb4dIjtUpzm70e3tilsCkvKQ9MalCPiYc8z+TWEjx0Rj/xhB0gsEfwf4kLzm79wpNiEObgQ9XLP79KxiREyhv7khQzXPXlSrsDadlcW1TMf1ASWdDjx31p9c8nA2yN26vJAL4B2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuaKJ9fA; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuaKJ9fA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778041268; x=1809577268;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SQjJ4nh4QYk7T0ybD7zpuA24m38TTRIO5zwo1jb+RKI=;
  b=NuaKJ9fAixQhrGiH2opymsD/hJMCrBIh7/3ySkdFee4jVRI2787sMrm/
   ob6S+BEkiNAu5NLm3Twx84kr66T/Je4YrNEUJ457Nu8ZctC25RHeT2uAN
   Ixx68sqEM2eSiUL78rfljiDVkX5XDQbVip179MmJFIxXWd7C5BVMRbbVf
   cGq99cvp7d2fRIYwHEjDpgcC4SuBVOyd+eFDe4omFQOeI+iA5KSWmi7l2
   pCRy48rLRjWh2G+N65EQqkM8HPmLXzgY7VW4FklZHqStgfmfPGvg1tThh
   z4DSZBiXjy2BkVmyE1/S5zBUgtwv5mmW+SM3284tWAmkO9Z/aXzBaJ12o
   g==;
X-CSE-ConnectionGUID: AxynXzpmSrOjZC15A1UuPQ==
X-CSE-MsgGUID: sm/DxrsUTKKukjhhPZzj2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="96492986"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="96492986"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:21:07 -0700
X-CSE-ConnectionGUID: 2mSLJ+JeQGicszaDz0MA2w==
X-CSE-MsgGUID: KXlYJ5LPQBSRrbX/MZ717w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="236256018"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:21:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 21:21:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 21:21:06 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 21:21:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClFgW2xQph1GtbtTLL8zXRHHQLglBya6o5xGFVT0KyOfNalQ9YnwrO5Dh/dthahxAIy47xFCilEG3vA/eoCJjtKKBWvBZac+GAVYY7oDIlQpVvqDF5W2i0dHB5rAOyMJjMMAhshefoRSWPGdB4FFJKQ05KrpmkQxxt2GGP31xt66pOXauJcR849eK0oFaxV99v0lAA4/C3JNZeH20so/fFBaI4NonX0Akt80albs0tgu2YQCMdBbZwaaJmndkgFrAKd0uEFORUT5FO4LYdJvENWfc0es75gymEjqFdywrprOX2x/w3GnTG6TBsmyd00pKWVWlyyIkcoPULiN4KU49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRlfm0fx6qxgFrXwu+Vph4xYCPH0HqX52cz/ZkScYJs=;
 b=ipMLqZyn27kCD9BwTFffMPbS9YGaW44u5IQ+SKAuGUkQtuH77Am2ZwGSbLu78zPhaYXtOlL/YYOb8oqofftgYvv7ZX9BeGbQdFsgjfNQZBGW14+BvrIyer7QuzSrzRea48IuP5rXSk7Dut8RypTu+KiHgph0DlLHZBUzTthDoHjb4kdZyfeyFqX4G78UurYtXtj7kft9Lmi41JU8Zbe2b4gXeZ7zF0yG/Y7cm+3hXSAWv0s/HusBTEmactLMBMydsAtyAE9YZKuGB13K5AjlKRSf3NE3Q8PLgo2MlUnI4xqlr+8Sz/jg/RN+Wkm+zt+LNqY9Vl8f/J+bfQ16/ctlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 04:21:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 04:21:03 +0000
Date: Tue, 5 May 2026 21:20:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>
Subject: Re: [PATCH 0/7] cxl: Add CXL type2 accelerator support for cxl_test
Message-ID: <afrBq3AIDrAkTTWR@aschofie-mobl2.lan>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422230237.2599333-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV8PR11MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ce9723-fae7-42cd-6a54-08deab26e2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1vJddh6fzpT0Njk8aJkEUXYXH3Xwms632DLb34zqkwTOJx7L7NRzXChpjBQjPLWwSlRGxX9G7KnStMsvfcQO229/vamW4MZHFy3rFvNRjV8gRIBTc2iw/fQStVDyUCkEpbaXnh1P6CzQ9odDJ2Lbrc3FLtRVvl8fczrAzeEsLRxrJlhTYWRpQTSUSmo5C38qmE1R8TmmB/Gaq1AWVGXi/Kb3+ZohQrFwMozbVYazRLZ7Ca+tKjf7dMnEamwurRQ8abSU6VdheduA/nNpLDBEQWKa3JQbI5Cny1G4M0/+Q3xNoy7D2JZNWx4Oc8rBkaHh5K+Kg0AtBE+ksITeMb/o++4ao1b6mT6ej9Te6zNM8SKHX1XgNAtx3h8oPslWQTcivCtuiIJOcaJpxVXRSps3X/W4KdW8KYWY0W/JCEJGzLZs+ZXzU4R6A7NCr/Lqj/46oaRaQJFm1iCI7gvizkDHLaR7BK1k7qX+kV4aezRWHd0Q6z+8aJnAKmCjpYZoj1Z49XA7vx3NNMeIYM3nOjdkoKd6oFudh/4hI//K+DZsTTucgaWjogdlcOIR/uKuwKeXQImwZZnH2BM2iLLj0Sft6GDthETPCShqzWTLv7KMYTBe+qZZXuKSZrikUQGnsjZ6e25yJGcCEbETtwOFDNlTsvSdIH+GHhBDLtSDvr3UmNO1g6CXMD0iacyzs4hF8ZeR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UPLiM15C7mabP+fz5FhwPM0hWci5WgwqVYNbVgZFkolElYj+5wUVCNc6e6wl?=
 =?us-ascii?Q?jS1Tpy8UDYD+foDuc6p2yxHlE+Ym+VkRSmYgaz+KXoIwOAbz1nntHEIzMupU?=
 =?us-ascii?Q?1dlnuWwQXua0aofMGqj7+XMxJZ0YOpdgNZIdeAPY1gP2bnidzLYj/c97wzsj?=
 =?us-ascii?Q?4zheH8ZeiBiicE5yONVaVBMJdXUO6uME0P85eRMEL/wf0Fs+z5lnn4N6pYkN?=
 =?us-ascii?Q?TJOV1S45ox//XIkC0/WG6xuvu1bLyH62xDVhC1/2O1Wao0tlTLK6uf3bTlFg?=
 =?us-ascii?Q?lobUpAGpE0e1drOQFSuuEiHHjRbJvksAPR25Vj3dlU9OE+EzwAxfSIhRUtr+?=
 =?us-ascii?Q?NRTDktD40wpddghWMsVfEI49Zbgly7vxeGZCxnICdDrQcjUhUsCXK+NIumQX?=
 =?us-ascii?Q?6pHGjmZa/Rk3WrZuSvQknbQ2D1Lk38W2p5WxKWYJB46sacYfSlPCzvd9QZ56?=
 =?us-ascii?Q?svGTeDqMODjASLQBKGdSaFp4eNXrG0EwVcSHS9/0T8xq5DFiar0Mu8S+x8Pr?=
 =?us-ascii?Q?r8zyY95NgI4b+fbrNU0yyebmPYzhkyGvydQdZs5qDfNCSo7fYI6oguRrG4bm?=
 =?us-ascii?Q?+rrYDTqGEwDJGzlqOp0srodhJxGaewjabU81T4lnmx89HyWuzx0BQyHhkZ5G?=
 =?us-ascii?Q?a8gILmxPLogviitd0svNDynYKH9IMvJUBZgY4+MX6L1V2X+/OOfYNn/4T0Tv?=
 =?us-ascii?Q?9UG6XJdpOxg3a+HebEr5zVzU7TuILn06wB3KP8S44SCsHtLxrUPpt7+A7diq?=
 =?us-ascii?Q?CAfv2/RftpwcXFXzKaAztHFCPhTO6lTm1LIBLvY/cwvwU2LEpwuNum6LqD5r?=
 =?us-ascii?Q?qyB1Vci7oe0i8yZ0Kii+7eBgq8KfmAcOWjG5p5GDcNYVj3CZIlY86E+5v6im?=
 =?us-ascii?Q?zRjg5fTlP/pw3BxzWjEUFKLdw89IRu20zhVk8DmdsDVdf3kUgeqrPTKO5PiT?=
 =?us-ascii?Q?csSXp8x1Q4MEUFHAGYnZskg0erRuGgTsojThC7QGXTVRGj0lup46mjLthoHI?=
 =?us-ascii?Q?xS8SIG8/QfngQcUUSl7X0LviklV4TrS25h+qfu8iG8lAlCJhN/zUD/4JZbjo?=
 =?us-ascii?Q?YcHYJAzyvn3qodQf666c31+zLiiyjmTyCtgok930WIdjEkIkTCy22Oour9Br?=
 =?us-ascii?Q?ofaf9IAVXf1yFQLv2f1Pvif9/WFiEKKeu+K5EsWKbeE/sR9AoI2mDw3576a9?=
 =?us-ascii?Q?ejZ7qLL/q67ZQxiHTM5KoOEUonOTTufN8dbyqA9oyXmZmW5lGg99KdADHNfz?=
 =?us-ascii?Q?0wsz0MiRgrSeZsd4Db/6JfSey9clU+tWAVCRAiv6kx+lmZYTXO4l37iWDaUw?=
 =?us-ascii?Q?I5aEwbVooDzPn30dVccf0JFuD/pEMfy2WlN+sMP2xKc2zJkKpdawBuZh0yvK?=
 =?us-ascii?Q?IyalPIeaxRW5yU8SIFAzmqBlzIJDGHSNLwGp1ltowGwAlLSbwGgdfcf0tkoZ?=
 =?us-ascii?Q?3separDmQ9vOME/U8VguhFlqhTKfsQ9VdfQqgbBBTXquwooFUVYOV7cDzTBt?=
 =?us-ascii?Q?CJ9CDBmalDngrkMYc87bferpKMOFQ9ezZyFNIXN4EwExZVIykOb4BBUhH7o8?=
 =?us-ascii?Q?N8aeVxRBXxln+Ef0yuXGXfkbO+oesgWzHbDAoCXTYbPPN7AJIVBtUfYxMIeg?=
 =?us-ascii?Q?5sqVR4zpsnscnhm34pOoq4S+q9HEsFh/RyR3VDFvh4DG11EH/k4L3ZtwV7YP?=
 =?us-ascii?Q?Rlu0VWo5cpfaT5/Q7OupMNKlkj0W+aT5D4AQaJh1nPe8slELYgKxR3wPTfqS?=
 =?us-ascii?Q?/2OplFr2OR03Q05jNdtn5+i3IJnbRAc=3D?=
X-Exchange-RoutingPolicyChecked: JQ4LNLGu6z9JiN4h3S9FHDvmUNEUUqZ1C4N6UgmDp38cbDiwdChyvo4sv3zrtBc1D/Vkl63976aSJ3LLoqUmpDp6Mz3iIKYMxljVr3hinj7FAO5IH6hdYcsnmNOrLTctbiF7JSqDJ8ezS5ZdaGXt34An69vDu8zJkMF/frW8QkAUwe7LsQ5vpEWEG/suIVyLGNI6FalyMLgV5berWAkDegtM6TDTVL5wbgthMT4582jAeUnvZXwbjIQPgU63ODG1Btt3ZFLJLCXyM/SsOAxBR9Y3pZj3+HbiTMEB1grh2tiNRQAF+4LPxllQp34BzFHvkiVuRAJ1gra5DnHXvam/LA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ce9723-fae7-42cd-6a54-08deab26e2ac
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:21:03.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqIDz62tG1sQYIANIv1aMTEa/pJyroDTGeTpPAp0Hd5FtDsiTnwfR5cgxxSjwREzNbLr23H0NESxeJRx/NUD6r7kfGkKdYm5hU7Js+fQhpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-OriginatorOrg: intel.com

On Wed, Apr 22, 2026 at 04:02:30PM -0700, Dave Jiang wrote:
> The series is based on v7.0-rc7 with Alejandro's type2 series [1] and
> with Dan's follow on series [2].
> 
> Series adds a 'type2_test' module parameter where it setup a mock type2
> hierarchy with a mock type2 accelerator device directly under a root
> port that has an auto region setup.
> 
> It also includes a CXL fix that was encountered when running tests with
> the new code.
> 
> [
>   {
>     "memdevs":[
>       {
>         "memdev":"mem0",
>         "ram_size":536870912,
>         "ram_qos_class":42,
>         "host":"cxl_type2_accel.0",
>         "poison_injectable":false
>       }
>     ]
>   },
>   {
>     "regions":[
>       {
>         "region":"region0",
>         "resource":70300293136384,
>         "size":536870912,
>         "type":"ram",
>         "interleave_ways":1,
>         "interleave_granularity":4096,
>         "decode_state":"commit"
>       }
>     ]
>   }
> ]
> 
>     "root decoders":[
>       {
>         "decoder":"decoder0.0",
>         "resource":70300293136384,
>         "size":1073741824,
>         "interleave_ways":1,
>         "accelmem_capable":true,

FWIW - above was a pleasant surprise. We've had accelmem_capable plumbed in
cxl list since 2022 !

That's a segway to a sanity check: is there anything else we want to
display or do in the cxl-cli tooling that is special for Type 2 ?



>         "qos_class":42,
>         "nr_targets":1
>       },
> 
> [1]: https://lore.kernel.org/linux-cxl/20260330143827.1278677-1-alejandro.lucero-palau@amd.com/T/#t
> [2]: https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#t
> 
> 
> Dave Jiang (7):
>   cxl/test: Refactor mock_init_hdm_decoder() to prep for type2 decoder
>   cxl/test: Add type2 support for mock CFMWS0
>   cxl/test: Refactor platform device enumerations
>   cxl/test: Add hierarchy enumeration support for type2 device
>   cxl/test: Fixup hdm init for auto region to support type2
>   cxl/test: Add cxl_test accelerator driver
>   cxl: Fix double unregistration of CXL regions for type2 devices
> 
>  drivers/cxl/core/region.c      |   3 +-
>  tools/testing/cxl/test/Kbuild  |   2 +
>  tools/testing/cxl/test/accel.c |  71 ++++
>  tools/testing/cxl/test/cxl.c   | 717 ++++++++++++++++++++++++---------
>  4 files changed, 605 insertions(+), 188 deletions(-)
>  create mode 100644 tools/testing/cxl/test/accel.c
> 
> 
> base-commit: 6fa897f2d9a917c4bd7b911b230fcfad05a952c2
> -- 
> 2.53.0
> 
