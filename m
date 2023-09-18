Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99308CD37B0
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Sep 2023 18:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjIRSVg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Sep 2023 14:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRSVf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 18 Sep 2023 14:21:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D4FD
        for <linux-cxl@vger.kernel.org>; Mon, 18 Sep 2023 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695061289; x=1726597289;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g3CbybJwwTPXHfUj2xqV+e2ADI9r5m6Zc+vHxE62feo=;
  b=YUDQx1KPh6rawsVsEcA0JP1ht4sVUqQR5lAHLE76ixKnvaCAP1xzve8X
   ZK2MU8k7t+m8SaRyP1Qj8FRK16rqwUdVNXrLhdfNLc2K9cOb1MMi1SZC1
   5HaclkMXUEmhh+lltAezem+xjuSC28GC7xR1bI/t0ufCSJAwHa5zOCuoJ
   Lw1ulWFJ/eQPuGTib92yq7jZHyzPM8glNlBWincU7KTdN3cG6lahcsi7j
   Dx86tV+6ut3QhyxjTkCov2RqcH54NdxKg9e9NO3oGCldZCLQ6PYKjfQo/
   zxj2q9kKl4y10xtvtVVcMiclpcElC35NTSXvZdZjj8ZHYXILVAFpuTDXr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359988978"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359988978"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 11:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775230867"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="775230867"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 11:21:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 11:21:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 11:21:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 11:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjfmvfCPyP8V80/+Z40Bi+59p6E8vWHfGL5TEimhl2qRJ+5hzxv1o8w7GTqOuUbuAQp7H4loftdBllJnE8/1rzHMrqoN4CvNvGrBLAKta8CgOxeefXid5zhwWZZhN1tFJxDPqa1u87PyYBW3YqtjciJSDhPgYp8riu++KA2YF4g8aQ0FTTdE/KuhsRUiZ36vSD9B1rU9dqArAbc7rd/m9+fs7kWG16o06Ys7GKukf9lssJsjUbGGOsDAuvWEOTlcMG6/y81f3Rje6oMYnIZM1H3dVdSgxVe7umamjFzf6yUWvhmPsBj42NzS41hcM+cryYc7Ug78h0b75578/82WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/4lKiz3KPlRjVEl+0MSz92LwPQhHNDuIl6NCXZVxzI=;
 b=imE1ptiHti5JYo4mJOhd06jBDNiHfBdydPzLhX+NaegvQBZ4Z4nd5lv2Vxcn8EHFgGOhaT6aI+Bg0xrVUBWBGNz+XS0e3CxyFo18BinBbdSaGfzFOo6XIftmdyLFGhlT0Akx/6b+XJOg/pV0DLHcPQ4B+Gt2TTlnl6eZIt0Zna39MBdDs1NwsM8jqx+nd9P4b3KqrVM9kep7QmGzWrWrUqHQ1gZq69oizeJ+KRtrfug+RInn+8W7tOkuBsgvNvsMhVKp2IyPY3r5iXI8r/rtFkvwhn41iJwUqRMbsNAOFysyPt9NYE6fuVahYz8km5J/WH9dktO41SNyBO/zd/jo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 18:21:25 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 18:21:25 +0000
Message-ID: <b72946f0-31dd-b22a-f2e8-a12eb2f522ae@intel.com>
Date:   Mon, 18 Sep 2023 11:21:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 1/2] cxl: Move command enumeration from dev_dbg() to
 traceevent
To:     Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dan.j.williams@intel.com>
References: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
 <6504d69a10453_37d9bb294a1@iweiny-mobl.notmuch>
 <1b66b8ae-143d-b227-27de-988ee9f0ce04@intel.com>
 <65088da8ea533_3921be29438@iweiny-mobl.notmuch>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65088da8ea533_3921be29438@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0066.prod.exchangelabs.com (2603:10b6:a03:94::43)
 To PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7852cf29-7c6f-4cdf-465a-08dbb874113d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glfksfTdL/sT8xF4K0Qwey1TUSS/wKefo5vAxxYTJEDa2/ZbOiDSFQPcTEgRq99C04flBrUSz7Ipi5/+oz//rDZSCUSaTHlg3+VC8ZEaes+xoGIXDkLlT8P4s8CAiEysFlcJqJVRidjS2kOJuCr/jpMJsDlBXQH3FUhrSXALhwsVWXbOG2FcMIeA1/JVs+gtvELCHp0j/LjZTDNwq5ZRfijTuhBrt9PmCt5wGHOdD+Ft1XuKc9kXxawZP95xI6+xp1ltYsW8784m2VIcGt/hIuQlZBsanvXrrr3jjp5S2+jhQCAXj63KwRqDMWq6dgHSFCC0nLzYOFONgl3uHxahFZpGF1jT4e723aHTArgV7gL6lx7SHX/gCVNxS9JZvoJyXoi5NeZWBWOIuCyHHSMiFCwE3SQrkU1yMsx5/B4zE9eNuiOxLz8MuGXt9PYNp34o0Mp7ABDg52j9ZQXoLgACJS/Wi9/tO3mpmQZ/Bw9qdyzwm3yWnZrPzxKgpmwIelB7WKoJfyJVK8EDCDe1wAihjThq6exs0BmS3wjby+WSiyZ1bhMBHHDX9kOfU7O7/atnC/F9QP6INw2BRVVp+T6xlR6aMYF2TYW3UibseIo2OX/Hm6wU7KitPkR26Swkhi+IlWLBVYnRcvnDD7DxBvIj+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(1800799009)(451199024)(186009)(31686004)(36756003)(82960400001)(38100700002)(86362001)(31696002)(6506007)(6486002)(53546011)(478600001)(2906002)(66946007)(66556008)(66476007)(44832011)(5660300002)(8936002)(6666004)(4326008)(8676002)(966005)(6512007)(83380400001)(316002)(41300700001)(26005)(2616005)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVp1UUNRSGZqMWI3dnlYV1lhajVDTEJkWkJ0ZG1uZm1TWW8vcVBTYXJ3K2dQ?=
 =?utf-8?B?WFJUM2hzVFE0dXhGVFdReGFhTklaZTlaMG1zazRQU3Nxem1NYmRNK1p3V2hM?=
 =?utf-8?B?VC83NVhEVXY2cGxQUDdFK3RBNFpyc2wrUmd2TEFOcUVBQWFkWXZQbi9GelRG?=
 =?utf-8?B?M3Bpd0pEMWtFR0VhcDVURXVIaWVGRnZqNXNaN0dNbVhVemMveS9EdTRsdDA4?=
 =?utf-8?B?cnlkeVA2ZjhoL3JPNjVsdDI0Qm9xbllLeEdoSjBVQUwwTkpvM1VCbEhEZWdQ?=
 =?utf-8?B?b0dGdHJFVU1GQzFOY2xqLzdHRU5WaUZaelN5bXQwNlluaGtxY0xzTW9XZW5V?=
 =?utf-8?B?Mnd1ZmJmQ0g5amY0dHRoRGRVSVF6ajBON1AyQlRYK2dUdHVxYjNOT3c2cjlv?=
 =?utf-8?B?SkZCZVhqcXNVRVovcWN3b2NHQzcvbFBsZitWcGF0VFJ2Q2lzN1g2R1MxcVRT?=
 =?utf-8?B?MkFOTkdsUUdJOW41eitQZmJWOFR2MmVjZkx2WDJiQWlGNDhUSmVOYW1LbFJP?=
 =?utf-8?B?S0xrYS8wanR4bmFKU0hnVzd4ZjgyWnp0VGtGdXBnZ2h1VEV6YTMyaVhlZCtV?=
 =?utf-8?B?Smh2dzJWcTNDZFVkS0FsWHhleUZGZkZXWVpTeE4vRkw3SEd3SitzdENJT2Fh?=
 =?utf-8?B?MkVDazdHa2hyOXRDNGNvOXlmbUJBTTZwK2ZtOUR0US9XSEdLQjdURWdvRDlE?=
 =?utf-8?B?STg0aERSbmQ3bnBZVnB6dENwNFlnRTUxVFhWY1lDQWJrMWZZcEVQR1JEUCtQ?=
 =?utf-8?B?UTdhWHpYb0hMVHhiZmFFcUJPL09XbzFLazRETjZ6elZ1d0lSajFxbnR3T3NY?=
 =?utf-8?B?VURDbS9ScnAwQXFwVE5kSHRCM3hhWkIvUVJkT2lwbmxreHJsKzQ0WmpwM2hk?=
 =?utf-8?B?VG1SVUpuM2gveWJnV0MwWHRaQ2hrSjFHNDJCeVZVb2ZlK2lqaEZaOTZwZWly?=
 =?utf-8?B?L1ptTDB4MHArZ0NPQmNRUG9PWnJEZmMzbFh0MktiQThJUU52NG1NbUs3aW9x?=
 =?utf-8?B?M1dOSkxlMDcyeXVZSFIwamo5bXhrelNxT1IvVFRhR2dBNnQxT2t5MFo2ZDIr?=
 =?utf-8?B?TlFtak9KN0VyL2Z2cnFzMDREdmFNTVhaOVNEdzcxVVJWN2E4K3NWNmJBSWhS?=
 =?utf-8?B?YkxBeCtzY05qczRNdVVUS1hMZWF3K2dFa2ZNeHBKTEtjQ2lHajBaeXlyczdu?=
 =?utf-8?B?VlhVSHkxblhxUmZ0K0lLTmtBa0JUV0JOWmIrbmRZdjgvU2JzNkpWU2haeEpG?=
 =?utf-8?B?VS9vNjBLZDFpakpicUR5UEV6NjhxWjFmMVJZOW1aMHdNZWwvTk1ZZ1dKb3hW?=
 =?utf-8?B?aEUxSWR1VEZQbVN3VUlURVVtdERoNjdWVSt5RnlxV2hOcEhsRHh2THV6ZlJG?=
 =?utf-8?B?dTN0Q3ZjeTFpanM0MWV3d05IUSsyNkozUlA1WWRKdTNtaDQ5RGNaVWQyb0hM?=
 =?utf-8?B?Smp6VlpFTkl1UjZJa01vckZsN3JHYjc0SU4zU0Y1azRNak43RFF3TGQ2WmJW?=
 =?utf-8?B?d3R2ZG9vZkNiWGU1WnlHaWZORTFkY0lZa0poUGVSaWwyd05BLytjVE40QzUy?=
 =?utf-8?B?M2FSV3o0SkhJK2wzbG9UWnRjTm5tdm9BY0RuMDlpNzlsbnhzWldRMzk2WTlW?=
 =?utf-8?B?eWdNQ2NzdldGTHJEa0JJKzFSZm5uSHBWRjdGVXhPOUNuN28yZWd4TVRKT2F1?=
 =?utf-8?B?Qk5HdUZXbjR2ZlVSMVhWWVVhZElMS2NDYVh4aXdibzcwdzFDTUpvQ0NoYlpS?=
 =?utf-8?B?T0RpM1JHU3hPYXlHMzhEWm04QzdWaGdReWgwWHovUElpcVc3Q2dWNGNPL3dp?=
 =?utf-8?B?SENzSThZTEsvNDR0SGpHYXcvNld2QUpEKzR1NEhYNXU2V3JBQXBoWmduRVdm?=
 =?utf-8?B?YTM3V014OUdudy9tTlAvMDRhT3hFNGk2SElPZFNSWlBESmROTGkvbytNR3Nj?=
 =?utf-8?B?YnBGU1Z2KzNmMjhsRUQxOVN3clpUbWhxc0dlNTl2cWVWOUhCTW1JSUxkQ2xX?=
 =?utf-8?B?VVR0RXJKUkJqWDhMM3l1a2VTckJmOUM5b21Hd0xpRUF1S0xwK09KRERQQ2Fx?=
 =?utf-8?B?cGNGbGVOSmR3MGZmMnFmcGVlaGpKU2RxTGxMbkl3YytjYmgralo1VzVheFE1?=
 =?utf-8?Q?qlY45WraPqOYdc0bt9bsHkzKP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7852cf29-7c6f-4cdf-465a-08dbb874113d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:21:25.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IY4sqyYp1NXMpXZx7I0smK+yNyUyUvemlX3JaIKTrufQ6DlI2vwPhLyLGBtssgERLuoNaXL7H3sAwtu2SQ6ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/18/23 10:49, Ira Weiny wrote:
> Dave Jiang wrote:
>>
>>
>> On 9/15/23 15:11, Ira Weiny wrote:
>>> Dave Jiang wrote:
>>>
> 
> [snip]
> 
>>> My gut reaction was to nak this patch because I'm not sure how to enable
>>> trace events prior to module load.  Then I realized that this is in the
>>> cxl_core and is only triggered by driver loads.  So I've not tested this
>>> patch but I think the following sequence will work for these 2 patches.
>>>
>>> $ modprobe cxl_core
>>> $ echo 1 > /sys/kernel/tracing/events/cxl/cxl_log_type/enable
>>> $ modprobe cxl_pci
>>
>> I don't see any other way to do this. I saw this [1] but it doesn't appeared to be upstream.
>>
>> [1]: https://lwn.net/Articles/432186/
>>
>>>
>>> Is that how you tested this?  It seems like a pain.  But perhaps that pain
>>> is fine because these debug messages are not as useful as others?
>>> Especially for all the unsupported messages mentioned in patch 2?
>>
>> Yes. Alison mentioned seeing maybe 500+ of those.
> 
> Ok it seems reasonable to me.  But perhaps we can document the above method
> somewhere?  Not sure if the commit message is the best place but it is better
> than nothing.

I can add it to the commit log. Maybe I'll send out v2 of this independent of the other patch given there may be some differing opinions on what to do about that.

> 
> Thanks,
> Ira
