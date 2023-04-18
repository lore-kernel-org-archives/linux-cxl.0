Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C14CC77B71
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 06:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjDRGnq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjDRGno (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 02:43:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175FD3C3B
        for <linux-cxl@vger.kernel.org>; Mon, 17 Apr 2023 23:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681800213; x=1713336213;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BMx4R3H88gDyCAXcCi0wsbfymUVgNuwS4qSkGNx/mRw=;
  b=hAFyyN1pUx5Sh5R0+d3Msl/OTdmEkNpkqfj6KSjNIjO27oIn6bZNxyPC
   JL/N/QhqOztAn49m55mZSDvs4wvaZ9VUany1R2E1NHS78flgmouZXwkUl
   gKwXWjX8I2/0Sd7VNCMmi6duBI3yqDmY7Ao0wBa5WR6xjiI7B+JRhC7IR
   TTVEZMP93FJ/wsnh3OgVbe2TZbvWZb8zG/qhM5pjlj0Yxp1Y7gZ8Flcjr
   DTeufWAAFJyzOYYO5+PmnqU1pgOeQuADBvMM2mxb+pNIf3zly/cZLD/zw
   4IW+LqiEU9Xj4uUDL7/BajbSw+QxissgfHJOx8QNcVjCy0YtT7mqE5d9j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410310709"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410310709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 23:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="834738340"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="834738340"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2023 23:43:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 23:43:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 23:43:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 23:43:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 23:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4EH6lNwO2hMc0tNhgS7LxJtP9yINhvN0Om1vbz45CC82pyASprjK3wOPPJRO6qQ77FcPEj3or9Tf3SeU7dULvQAQMx5qRW6R2V+RigDe1rfEUh0w7M/0czQ0DG+govCwUWRkzeS14Q8ePtTi4LodwKu0x6Hb5wIW5z67DRvi16Ai6Z/6cFWeF3P12b2WYvPefyG+bJERimBx8rb+UxUZeYryB8TcDTFH4FNRTiUjwzkCaU3kcmzfYKL5E40PUZZ5yYV9gVS9RARw9IX7Y9Sa2zgmpWIXSI/n1CLfDYjWg5lBiYZWODzM5veDmRry6egH47y2CQM/ry0mo02VEpjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/PjSoLqVQ7aSSPBnjGTLdlLk4wLOER7fH//y8zA5Ts=;
 b=gj+9DOT66f571skCe9p3MCmMFlRqzeE5pspVmz/7ZjTF3pCqVos+/7hZ1V1YcM+nCWGegYU3jKfwkoZ7fQIaavGFSlbSmnXoGQO8jXVo4dfjzNcqZ7fMuWP2HfVJx+CmqYPVcagjPyAnWNmIHJZoUNSIWovP68c1HoztwlQ1gmn6uSE4czNt1Ne06pbMB9xktXbKmaJDewatdADSYO/4Rl7d7isphu6MJsolQXhLwR9IGO5cWDpkOpNpg4i90yiuAKWUgBt22aqfDDUbTuDhtPviNquKC85tXXOcLmgFA8OIBH14CQjEJ99z/5Z2zVOS0vRYNRtM56e558JPkWkZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 06:43:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 06:43:29 +0000
Date:   Mon, 17 Apr 2023 23:43:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] DAX access of Memory Expander on RCH topology fires BUG on
 page_table_check
Message-ID: <643e3c0f22afd_556e2941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <ZDb71ZXGtzz0ttQT@memverge.com>
 <ZDfp/+7uTyh2wWcX@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDfp/+7uTyh2wWcX@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 45032dd5-090f-4304-44d4-08db3fd83800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIA9TUlGPyULyOJyGtQ+ytXYqcRXwscXd8coqjD83Pt9IYyVb6mWIf48CEre3ZF9RRg2vCTxa/2tZG74PWbp+V7gS31g+AWRbxJtRdonMtgGchcOIrtNigFUjN5xCRbUIpciYLrLMWv3mPCo4Xf6GOgioQFI0a3wgkm+o1JMXRGI1aZYD/+5teQbdS/6WbpTVQ0WfB6K89mcIqnvm1+TOUXS21z7ew9eZqZWzdZd9BqWBtpE5H6iI7RsJrHKnS9Nx+SSdWzJb08SISYVnyERxotH/vbL3MGbWWLWPPPQBDU8KzXh6pu7cPGP3FP6tTffNdRD6I/PJ6JIFI1EG9fQ2NxBme0ljJRkto/lsK2JOjyLRdePZdCOueJPnB5en+CoNN5dLa+2QOXssrSBaLsP5PzgmO77hPVFoRlyfayL3F5zSFMgbfA+iGK7wOP8Pn1j3vEfoAwO2GqQPXj7E3b38dFgiche54y3g9GKya8fOklDs/lQ+ua0Q55drucq58Vz+7kb2zJX85VOzUhlM0WswTwhecSry6Ck5rQ+5PB5Ra2KWhcO6GxFvCmnoHpvHy/m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(4326008)(54906003)(316002)(66946007)(66556008)(66476007)(478600001)(41300700001)(5660300002)(6486002)(8676002)(8936002)(2906002)(86362001)(82960400001)(38100700002)(6506007)(107886003)(9686003)(26005)(186003)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G/esqCsiJni99O/PIQv+eDvu30ZWWESvYW1lWJpHbwYCY2WFaEStdNvDtEt1?=
 =?us-ascii?Q?2kDLVxVaQVhtqq9UEdR/w1UWVj7yt/0r7N7twKRPfl9mDAlbIVMrAKObuD/E?=
 =?us-ascii?Q?FNxBIuQMwG6sns/njWDKr5KOv/ghY0RQyDsxKdCGa7P4eX0jeQaGsAyW0XgL?=
 =?us-ascii?Q?NlbwvRilknqqRrXTzK3sVrhxwbY/DMB11kCk10RXZ/Zs+GMIPn3vFBeLbZL+?=
 =?us-ascii?Q?DhSRyfRk2Y3m8Tuv1pLQetbh7Ba9fBwcZjrSx27rVhSw11kbnv+/8dks19L5?=
 =?us-ascii?Q?gdgbQWuGguyZzZ0c+kyBnMIidXRVspatqYVYJdo2W6wad7uslqny0NJq/COa?=
 =?us-ascii?Q?7vGwH3jneC54OOWSa1rsGEvsQgqe+MbG/HaI9Q1iYMrj0WyEzshiXKlmc90U?=
 =?us-ascii?Q?pmY8768WiYbRi23WhDy2BLKABwBh2x05/QdCZHOS+B8kjie3W2pXn2+mU0KM?=
 =?us-ascii?Q?WzcV3bgsI7O/WXrjW6zJKUJ2DyKAHeWfap6GZsi+clfb5oaiMHeU76u+6Ro0?=
 =?us-ascii?Q?XHyGunwtuWGeF28TlssEQ+ok92yB+dSyCNXsyHkgad+F9YbZz7sI2V2NTPeV?=
 =?us-ascii?Q?c7CbZlQB45Q3AP8saSXrqXerGUnNxr5QyB9XLXv6a48f3RdNQZ5fwrpRSBYj?=
 =?us-ascii?Q?q+oifNSUwfDTpm5kv5LDeuscnNBzOewenGPqlC3wg4pRIlaeA6xzm4bceUav?=
 =?us-ascii?Q?twcKslIfvMf5Ef9ET7GROqJQeNqj+D4+tHm2Y1t2mm0dmEQt7RlgOXX409ub?=
 =?us-ascii?Q?Z1xxJ8IniGkRPtEX/LQ2ObIgr8pDcGjJKYWukNEq4KDf4RxgrCeP9Yn8KJ/r?=
 =?us-ascii?Q?oQq6iV+uyVUQu7V0kpZI9PwMz+X5KBbvR2MJxZrAM1l7WQFyAjhOgn4ShoZ6?=
 =?us-ascii?Q?+B8iIu7KTtWBMvFwCsWx0DeOOIVMHdQ5T5qxYyUQndOV1KV43tH8mjzRTrjM?=
 =?us-ascii?Q?jLJKdyiajoBHSVxBMIIneJ2kGNT3BniFi6gtDE/laYs7EpUIY7Qwz2G9158A?=
 =?us-ascii?Q?ivsWLBEYd6L1S+Ve3VpjtR9hfb5EXmnddD+c5kqoe8PcHhZU0pVZNG2CXBOk?=
 =?us-ascii?Q?sLLJfmuyQG+KrsmeRom1IirXWNVTqOf2f2hgNMseZoAHjr2ool9YGzAxTf9C?=
 =?us-ascii?Q?dGEO+90YS2GgNlN5XveUmBsN8QXpXfhgPw3lKpYrM969B8n2kLOZqckoffNP?=
 =?us-ascii?Q?zzW2L8WKLvlRdEkQl3QIsfVKMqR3m3sQYgh+QsX1F0V5z54qLOLng2AXJ9JW?=
 =?us-ascii?Q?6DFRfMPBlK3TcxkGsKhdF0w8xC9Zypi0chlZQBqax7iMZLEbFUKUtAFpz4Xa?=
 =?us-ascii?Q?LAuDltmfCwVJw6OCxYk1eUaqPbROOo9gGr6znPv5GG8WmRQxaIhwrL9dLr0J?=
 =?us-ascii?Q?BttLBd6116RSgwtUlSmYI8Vg1It8oJD8gsIELOnSSrTRUFp+Yu+pQQCKm3+z?=
 =?us-ascii?Q?w9k+OBa6EIH6RmT/Ku+PIIln3ME1fII+NirhaLTrXNHxreM6ovNbCxCnXcaK?=
 =?us-ascii?Q?8UAespjqM0dGEP6jNzemDQd+5G2G/c4DovRHFwuK9l7nbP6POfCP59OrSWlz?=
 =?us-ascii?Q?dZbApE560jv536IRSOMLflme0H+MVn2s02CYmPISzKm1aPHvfgYvBPWUGQIY?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45032dd5-090f-4304-44d4-08db3fd83800
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 06:43:29.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVytTe1+8G2ExlYaJ4WjLib4uDXSCoedlhJWWms1PdqD3UVA/1kf72I5a+aoWPDU/f2JmXVMinkeFLFlzrNUTRSEN/Ep2k5tjP86hjXsiOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Wed, Apr 12, 2023 at 02:43:33PM -0400, Gregory Price wrote:
> > 
> > 
> > I was looking to validate mlock-ability of various pages when CXL is in
> > different states (numa, dax, etc), and I discovered a page_table_check
> > BUG when accessing MemExp memory while a device is in daxdev mode.
> > 
> > this happens essentially on a fault of the first accessed page
> > 
> > int dax_fd = open(device_path, O_RDWR);
> > void *mapped_memory = mmap(NULL, (1024*1024*2), PROT_READ | PROT_WRITE, MAP_SHARED, dax_fd, 0);
> > ((char*)mapped_memory)[0] = 1;
> > 
> > 
> > Full details of my test here:
> > 
> > Step 1) Test that memory onlined in NUMA node works
> > 
> > [user@host0 ~]# numactl --hardware
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> > node 0 size: 63892 MB
> > node 0 free: 59622 MB
> > node 1 cpus:
> > node 1 size: 129024 MB
> > node 1 free: 129024 MB
> > node distances:
> > node   0   1
> >   0:  10  50
> >   1:  255  10
> > 
> > 
> > [user@host0 ~]# numactl --preferred=1 memhog 128G
> > ... snip ...
> > 
> > Passes no problem, all memory is accessible and used.
> > 
> > 
> > 
> > Next, reconfigure the device to daxdev mode
> > 
> > 
> > [user@host0 ~]# daxctl list
> > [
> >   {
> >     "chardev":"dax0.0",
> >     "size":137438953472,
> >     "target_node":1,
> >     "align":2097152,
> >     "mode":"system-ram",
> >     "online_memblocks":63,
> >     "total_memblocks":63,
> >     "movable":true
> >   }
> > ]
> 
> 
> Follow up - i was investigating why my dax region here only created 63
> 2GB MemBlocks for a 128GB region, and the reason is a forced alignment
> of dax devices against the CXL Fixed Memory Window.
> 
> [    0.000000] BIOS-e820: [mem 0x0000001050000000-0x000000304fffffff] soft reserved
> [    0.000000] BIOS-e820: [mem 0x00003ffc00000000-0x00003ffc03ffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000001050000000-0x000000304fffffff] soft reserved
> [    0.000000] reserve setup_data: [mem 0x00003ffc00000000-0x00003ffc03ffffff] reserved
> 
> 
> some debug prints i added
> 
> [   20.726483] dax cxl probe
> [   20.727330] cxl_dax_region dax_region0: alloc_dax_region: start 1050000000 end 304fffffff
> [   20.728405] Creating dev_dev
> [   20.729033] dev_dax nr_range: 0
> [   20.735481]  dax0.0: alloc range[0]: 0x0000001050000000:0x000000304fffffff
> 
> The memory backing this dax region gets squashed by this code:
> 
> +++ b/drivers/dax/kmem.c
> static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
>         struct dev_dax_range *dax_range = &dev_dax->ranges[i];
>         struct range *range = &dax_range->range;
> 
>         /* memory-block align the hotplug range */
>         r->start = ALIGN(range->start, memory_block_size_bytes());
>         r->end = ALIGN_DOWN(range->end + 1, memory_block_size_bytes()) - 1;
>         if (r->start >= r->end) {
>                 r->start = range->start;
>                 r->end = range->end;
> 
> 
> and we end up with a mapping range of:
> 
> start=0x1080000000
> end=0x2fffffffff
> 
> 
> Why NUMA-mode works under these conditions without crashing the system
> is escaping me at the moment,

Why would it crash? That range is valid within
0x1050000000-0x304fffffff.

>  given that the page faulting system goes
> through the same driver.  But my guess is that pfn-to-page mappings are
> off in some way when placed in devdax mode, whereas they're correct
> under numa mode.

pfn-to-page is pretty simple, its the pfn to page_ext that's concerning
for CONFIG_PAGE_TABLE_CHECK.

> Note that the above code chops off the first 768MB of the dax region and
> the last 1.25GB of the dax region.

Yes, if the core-mm picks 2GB for the block size (which it does for
systems with more the 64GB of memory, then it will align hot-added
ranges.

> The CFWM is required to be 256MB aligned, but this code will force
> anything mapped into that area to be 2GB aligned.  I don't think it's
> safe to safe the BIOS is wrong.

The *minimum* alignment of the CFMWS window is 256M, but if they don't
want to waste memory on Linux they had better make it 2GB aligned.

BIOS looks ok here.

> It seems like the dax region ranges are being tied to memory block size,
> but that a raw devdax does not necessarily utilize memory blocks.  Is
> there a potential bug in the mode-switching code?

No memory-blocks to worry about in dax-mode. Until evidence to the
contrary, I'm still looking for how CONFIG_PAGE_TABLE_CHECK might get
confused by DAX mode switches.
