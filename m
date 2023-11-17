Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aK2QPrrC"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA04B8
	for <linux-cxl@vger.kernel.org>; Thu, 16 Nov 2023 16:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700179753; x=1731715753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EbUYtE0Im5RTiYQmTnhIuaOQM6HwFRHbOOjQn1nC89U=;
  b=aK2QPrrCIOVl4yDCDsZY2qRsjcmDy0rQ/FLHHG5ZnqmKIFdNDzGyIhx0
   Z5YW3XiQvs79uuuujgPA2WgYhE1bVDcR2kHMAOb8O9fy76Z8U8kWHaE/4
   7kGhoAbaZinAnCmzGfou7r+irE6IKRdxNN7wOcDNSUNl2YxlMjmXvujq4
   FY4XOlzeuuvSFxNdE2zdQ285HCT6ojZVbclEN+1Y0a91UFijXS37SNWA4
   eJwqV4gLeqWVxRU31CPIsAqz37DGUd52A8XLzIRD1hlMQ04LK4rU3EUe6
   k9eud/reaDFrzQiT26N7e2I9VaDxXsNvn5LgfSejEBZ6jLnY7fvAcFGZG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="394059802"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="394059802"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:09:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="882939296"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="882939296"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 16:09:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 16:09:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 16:09:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 16:09:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 16:09:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYbOlx90jkRSj26Ntbv1qbiq/Ly0+k0eyUzsshyOuWP6Gas87lQswwZDcvxmGiFOYNLrCBgjALg6Y7pAlhJ8lOP3nHUdtVBulFljfQwe808pC/Bg1kLX2jaXNAg743S/xPUaFgeoYtDv+nEe1AAKEr2cUPFdKYVscmYkFX/hWBUfpfv4qHrR2RZTIOX0oSed+2X4LaF9crcMEUxXvXzk8AZcX1dsirTHocxkXVpWNiOZiiIkJYkNf7u62z+1vKEAc/OK6xVRSj55qLo60mZjqGkxnI6G/zdTVbevOOw3O2+7T+bjHBFNHNTpWkzK+5uurescRdYC7+e2vQCl6sy2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsRppB+TmJWlWK/Lyl3Ww9uTFHVzsR8eD5FAOokC8P0=;
 b=SJLHHqGoSORHgSLNBBndw8xc4XI+HMeqzZqEgT7sC0Ex6NlUou0v3qRHnmnSeWOwi0QTTJduK2zn/GL9P0kTh7uF5YK0Nr1Y5F8x56HzcdqcP9NjCurV0Nq05Hcgo0eUKExjGMSZ4hhFCD/tJtgGbgsRVM6XvB0ixlW23iFGC2gEOWQjloMXfhYL9xJEIs7Y73HkJk9A6CUFQPgzZNJP3CJF5wIgmMXuIakwECJtje1hRVfomsjeoTGgrKeVTdqX0tlVBM4Rw2yIuVqNAlT9xc3E6nn8hWpe9pO0WEBK0/NPfOXmVW02pIT1vECWOvDW92RGtlk9Iwxs8kO6c1vtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 00:09:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%5]) with mapi id 15.20.7002.018; Fri, 17 Nov 2023
 00:09:09 +0000
Date: Thu, 16 Nov 2023 16:09:03 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, Fan Ni <nifan.cxl@gmail.com>
Subject: Re: [PATCH v3 0/9] Enabling DCD emulation support in Qemu
Message-ID: <6556af1fc8791_1a4bd32947e@iweiny-mobl.notmuch>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b4c4af-0efd-4bbc-4f7d-08dbe7016b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErNzVurXFbOahUlsTNxIkL7umucDAhBmNP6QrHSHnHpnZHaKttAlfioi5Ybxyr/gPfCePNOKBXFc9Hts51zANI9qQq0RGrme4cwBy7E0B9BdPgjiemXMgzfffYKQghLbYsdpyGePsNCdg3j1B//bOuGf30AO66AQL5Q+N3ln6qA9RITfOcP0erQyGEK2m59p3SC0p+QyjUe4984c9gOk58PklHZjyEIW6VFGHkPnJjG9TmK4u8Rlvg/UXLZLT+c/2Rid8KTWkdKrTOKNMLp3mFv14lslTr1TMSol+X10rn+JXDajKiC56qPqmI2q7rN1UGH/jkOCgUj+k4P3ofFDVDvfkFfL64LTi4UTfd9oRwtbf1ipJFQeEp0zjlFfrmPaOaHNIBWDtQigzlK37nQAwZ3WFdM8Kl1nPRJXSpCtX30gRBmNnAADWyT/VvAjSTRPV1bpnAC0uQFCeycEF9mv3ckDavcPwN/yanZmGtpmN4vuzDpuGKD91hH7a1JTVCmwLy4QrALhV1ADJl2YkjlKufhrQcXXDQYBshj4wNAgKGj6XsiOODCPYLQRs5eHxlseDpQVeos0hxV/anQa8mKX6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6512007)(6506007)(26005)(6666004)(41300700001)(82960400001)(9686003)(83380400001)(8676002)(8936002)(6486002)(44832011)(4326008)(316002)(2906002)(4001150100001)(5660300002)(966005)(478600001)(66556008)(66946007)(66476007)(86362001)(38100700002)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IoXYdlCDUZMwTshSkkoUcsqCWJHXFJRyE7YxbtYHTfmXHC8VOtF6HfBSAKrg?=
 =?us-ascii?Q?xsv6T9GvUqHLnIikKUlV++93DG25ut7//sG/u0Ai1XVEZOGfM0LMLVqwP9LP?=
 =?us-ascii?Q?VuVfb/2vOPaz1YGSpdugnJll/4yLPBmWIVAdMdfTV5hoqGvB+jvBh/QI5V3d?=
 =?us-ascii?Q?LFswz2fPOMNadcPjsW4QaACo07PLHqmKnpHmIKpiBexd4ZK/xLUdQjdkqVhc?=
 =?us-ascii?Q?3D/+nbRH0AjKpVegM8EAcyQQgXk4m1dUn7aR3ejnik+7290zS6p1Z2QWu+04?=
 =?us-ascii?Q?aB89w0ZZ/Fj8E6ZncIs/PPO8CO17QQPiHzHZCy3KrPmOZ8YWUZ5QF2s1hdbQ?=
 =?us-ascii?Q?TZ1kynVmxYKyHP6cy7AzEwkKJnb5JTMivBfuwHb5zpcAE4Z/ShMXkgYFtxrG?=
 =?us-ascii?Q?OxKvba0QVMBBXr2FiRUXA344CEQ0gt5F5Ie7eZQ8MXZVQa9Y3ypr2WllD7yp?=
 =?us-ascii?Q?gEpacK4cidnhLNsGwqrFY354YpVsaztY/jQOPXyD/DKJawUuuOn5BfBsnFpV?=
 =?us-ascii?Q?pyk34qsRJSgKvU6YeSSYfFZZ8RPAq8JMpcF4LwrnXnJDkQ+ZO96/XM1uXxUA?=
 =?us-ascii?Q?2h5Ou0G7Sv4ByJSq4fdMgss4HAohEgiaFzwvr1tNdmRplsW/hmJNbEC99ins?=
 =?us-ascii?Q?92QTDx2FCmuaUavJ2/ZLQrt2DAOrXftnsVV33foFfa7myBuyhZxd9dbOZ5CG?=
 =?us-ascii?Q?4pTznaYVI90i1PaA/eAk5mxgd/k6pWUsxIcVDxhTawVgMSomwtVj/VYb8qMX?=
 =?us-ascii?Q?JHSY1YymA4qAU3iuE7W2QaXrlk3yI5b61riXfSpiwxbvQUGe34jGeyTTHrGb?=
 =?us-ascii?Q?MiAiu5vV0OYNuZFLn8eVppGiadDw2l6psMruSQ2ifDohEpGIJSJ63gN7AtbY?=
 =?us-ascii?Q?SLLElvZbHTLT/kWxrM3rHwfTLQJpURuAKnib2Mw2JENLujDCxplfjeI40wBw?=
 =?us-ascii?Q?rxkAktYpy9xKNBXoYe2GEwa5YpIfei23CL6woV5JWWdmQSvyRnE/vXy2LK3u?=
 =?us-ascii?Q?V6AD7WDU45GcIZkL+5zkYDiAbKV5Hh04AnlHuWoEujA/wxp0eclRpao8H8kf?=
 =?us-ascii?Q?01Rjqo0kaBmd4sguvDFYg/cuMX8BV/0gWsoTaaEI6P70H8e7BkHEyGDX9qJc?=
 =?us-ascii?Q?MWKj5x6E6dJ8dhxx9RsBxTFdGutCpYkFqgizKQJZncRfa14VBWZY6MoPPGJY?=
 =?us-ascii?Q?nCIjPtS2hSL9iC/aZISD8iohX5i4A6sP6SOiIDx/1vrpPCISORBr/8J5QXP3?=
 =?us-ascii?Q?o0nX1aTsr7gTPdvnpAl07BiHJCdpt8/ICDPjqTBVbfDwl0sVV0QhWWJeo15d?=
 =?us-ascii?Q?/WUzaa8446YE9q0RvskIFnl6kHBV/hc7gJtG+9sIzcJ1wLI8ZFR2foQmeh/a?=
 =?us-ascii?Q?upQ94y/mMptGxjfLxbpaK7jfllfCGlHmOPDj4GN5BvCp2Cg+Ns0QxfqOPN0J?=
 =?us-ascii?Q?stiT24X0JxurK0bbu0u7oht2cTaOSgknTJIJVCPQSrO9R2JITDW6AMZfc7zW?=
 =?us-ascii?Q?mmvBu+OUb2ci6TlGTGfcgj8rRU/7y6z/1gAyU1Y0cGvglQXS34Y90QKu59Rz?=
 =?us-ascii?Q?8KIhZp6sxpa6HysiZKtdg6i+cwAgb7pJuRr4HZgd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b4c4af-0efd-4bbc-4f7d-08dbe7016b5e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 00:09:08.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHrRfylM/DpcL8FhZbVZvhpMOj6WwDS+zAyRSlMiJhbUYexQkXjIsMYMJVJlIKAK3bllq8xGJ5eHC36H4VDNQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com

nifan.cxl@ wrote:
> From: Fan Ni <nifan.cxl@gmail.com>
> 
> 
> The patch series are based on Jonathan's branch cxl-2023-09-26.

Finally getting around to trying this new series and the patch series does not
seem to apply on top of this branch?

Just to verify is this the top commit this work was based on?

   d4edf131bbac [jonathan/cxl-2023-09-26] cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

I seem to have found some issue with CDAT checksumming[1] which I'm not quite
sure about.

I went ahead and pulled your latest work from:

    https://github.com/moking/qemu-jic-clone.git dcd-dev

    abe893944bb3  hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions

It still has this same problem.

Before I dig into this, is this the latest dcd branch?

Has anything changed in how you specify DCD devices on the qemu command line
with this latest work?  Here is what I have:

...
-device cxl-type3,bus=hb0rp0,memdev=cxl-mem0,num-dc-regions=2,nonvolatile-dc-memdev=cxl-dc-mem0,id=cxl-dev0,lsa=cxl-lsa0,sn=0
-device cxl-type3,bus=hb0rp1,memdev=cxl-mem1,num-dc-regions=2,nonvolatile-dc-memdev=cxl-dc-mem1,id=cxl-dev1,lsa=cxl-lsa1,sn=1
-device cxl-type3,bus=hb1rp0,memdev=cxl-mem2,num-dc-regions=2,nonvolatile-dc-memdev=cxl-dc-mem2,id=cxl-dev2,lsa=cxl-lsa2,sn=2
-device cxl-type3,bus=hb1rp1,memdev=cxl-mem3,num-dc-regions=2,nonvolatile-dc-memdev=cxl-dc-mem3,id=cxl-dev3,lsa=cxl-lsa3,sn=3
...


Ira

[1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/

 
> The main changes include,
> 1. Update cxl_find_dc_region to detect the case the range of the extent cross
>     multiple DC regions.
> 2. Add comments to explain the checks performed in function
>     cxl_detect_malformed_extent_list. (Jonathan)
> 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> 4. Update total_extent_count in add/release dynamic capacity response function.
>     (Ira and Jorgen Hansen).
> 5. Fix the logic issue in test_bits and renamed it to
>     test_any_bits_set to clear its function.
> 6. Add pending extent list for dc extent add event.
> 7. When add extent response is received, use the pending-to-add list to
>     verify the extents are valid.
> 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
>     cxl_device.h so it can be used in different files.
> 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event
>     log type.
> 10. Extract the functionality to delete extent from extent list to a helper
>     function.
> 11. Move the update of the bitmap which reflects which blocks are backed with
> dc extents from the moment when a dc extent is offered to the moment when it
> is accepted from the host.
> 12. Free dc_name after calling address_space_init to avoid memory leak when
>     returning early. (Nathan)
> 13. Add code to detect and reject QMP requests without any extents. (Jonathan)
> 14. Add code to detect and reject QMP requests where the extent len is 0.
> 15. Change the QMP interface and move the region-id out of extents and now
>     each command only takes care of extent add/release request in a single
>     region. (Jonathan)
> 16. Change the region bitmap length from decode_len to len.
> 17. Rename "dpa" to "offset" in the add/release dc extent qmp interface.
>     (Jonathan)
> 18. Block any dc extent release command if the exact extent is not already in
>     the extent list of the device.
> 
> The code is tested together with Ira's kernel DCD support:
> https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
> 
> Cover letter from v2 is here:
> https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com/T/#m63039621087023691c9749a0af1212deb5549ddf
> 
> Last version (v2) is here:
> https://lore.kernel.org/linux-cxl/20230725183939.2741025-1-fan.ni@samsung.com/
> 
> More DCD related discussions are here:
> https://lore.kernel.org/linux-cxl/650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch/
> 
> 
> 
> Fan Ni (9):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> 
>  hw/cxl/cxl-mailbox-utils.c  | 469 +++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 548 +++++++++++++++++++++++++++++++++---
>  hw/mem/cxl_type3_stubs.c    |  14 +
>  include/hw/cxl/cxl_device.h |  64 ++++-
>  include/hw/cxl/cxl_events.h |  15 +
>  qapi/cxl.json               |  60 +++-
>  6 files changed, 1123 insertions(+), 47 deletions(-)
> 
> -- 
> 2.42.0
> 


