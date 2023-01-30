Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6972C636CD
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 20:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjA3UKQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 15:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjA3UKP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 15:10:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C322FCDB
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675109413; x=1706645413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HwA2yIkoXD4L47BtZB8GRvXtdM6KvVEJpCAWg/wXnrQ=;
  b=MhTSplHGGRX9W/jaghRE6UAuJIFITbOOEGoQHMFr4eXYlnXH0FB0mC6G
   iTBrPw6n4iixKVuwRCLExmNIpZxb8uASDGNdb2/R+vMfNuHvOGVkHuPob
   3H8H/Oi013kID/doitRYynzKmgHAfkoIvMbapLXpKSTppgjG/UztT45MK
   Tds8eq6i612zFd04ocRH/KAh4UPtlE+3p0unzU0KAAGc81rv3uML8Rpth
   dGuDAMEbOlJMnUBAZzrdjjIGCcTcFPzBNkUxT5Vqk5MCwG7FxugTvnGKj
   D0FDZagenU8WKvymDEKaCqOGifk9qT5hR8q7Hc+NhdXw7ulmiC9k0y3/5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307315879"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="307315879"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 12:10:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="752962199"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="752962199"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2023 12:10:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 12:10:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 12:10:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 12:10:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 12:10:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F784kKw+AUtyh49I0098xV8wJsoNDwLzhk+eUDod4CQvZdQ0EMPBacSm4zHOrjhT3E292hiLWWmJbYntvdyA6tXFkQB9bH7a1MoxBVh//GzJzTclJBPADIBeHQbf3UPj8GuvaB0E7gRzaX7khGkNI4DpyU9iKHdyILiKCrIzMKVFCPnXyopszGF+A9kKHsObtsSv6MZa4xLn5EKcqbsY+hstYNfbgpd4eiGdGL+eclA9F9jLiz+6mhfGc63+aoKIRYdxtqzLWv/jjuTHNns3ev+GCEhazE2sHveg8u2snOnPnZyz7o8FwVFXfCXJUl+mya2+IWohhp/TJbvYSwZ0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYJNv/djS0WeUrWT1nmYi9tmoiPW1w0Me4PYG5B/vhY=;
 b=UUAT+Q7hmXH+kaiNR4UH81/a3LQO+JyJXqUjd4OK+TegwgryLO8Vv+7CwY8WJDcgO9qV881rXgHvtztwi3NbuVuuaj6SPqwfT9ZVhunDZLO2k6Zja+1/JgFxPjre2GzpLs7SP7mPxWkic3Ylh5hoMhBoWKNKLrybIJM6ewaTo239vsd3FfrXjQB44GVYGWMttShpQFWU3tkb58ATZAcsLmVKFlVbJ3/ywXJDfWLNw+KesWNjOhYvu8TbJHNqE0pKpqTmGAnUDtscajs1VlSuWr/Si4NpFxycYtlkxnQoAnAL9G7uZCvoaXy2D/QE0MvzesvXpMahMPH9KI+qDHPAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 20:10:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Mon, 30 Jan 2023
 20:10:10 +0000
Date:   Mon, 30 Jan 2023 12:10:08 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
 <Y9fRVu+yLza4d5Vt@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9fRVu+yLza4d5Vt@memverge.com>
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5efa70-6f71-47e6-b9ec-08db02fdfd5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBlldiR34NRnOq1UxuJ+R/SK5LmkF6GEgDrrDulIcmCnPlbV4JWHlA3Mn58CLFdRbZyx4ykQx4q8m8ScpRXbSHiTmKAUUNYfmjw1vRuX/9XpKBBdb5GSEHP4phWmHa7HzcR2M72zz3JlK10P+4ZAy1eloyVAMlvI4ofxlFIvs9RKUjwe+l1aegHknJl4iMNK6qneKFnUEI4fpW92e4wgLxzYz5VnMzkcGO7VcAJGBtfIwyf5vDtCSZLTFvAl6O+ohp4JwsPR2VbPk5yg92WD87Wi+wE8Wsvt3IQtAR3/xBl1DI8ZVfp9FMXQys9ZL6jsAsS6WLKuS3YmCxF+GfKJLJtbpHzQsZmAPn7wpOSPHnw+Krz4ifKXqIvjvrpWiLwb8WF5zstAMm7Wb4AjOW11W86Vy5+LSLyrNTjTcRvkrp3/o6kLPyGZ0UfX+lZddOfjJXbnqXiUKvYXbeJ4z5VZx4Qtkotw1YkImmKIWsOusaIJ/ztuSGoZWRBMnUmAfky4+Y2bUu3MSEeECb4UKIh8J2XcxSebPKSDlkrlg3rjdxCIHdaJWNMNANp5Zr0e3bFgu/zeUNDQhUXaMJVHRxTlETc0vZnVJK0W0HO7rBg5mrmoBfQkR/CB/TTM+7DPElK4a/We0HMFlOXBxRqcgcd60w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199018)(8936002)(4326008)(41300700001)(66556008)(66946007)(8676002)(66476007)(5660300002)(83380400001)(6506007)(6486002)(478600001)(110136005)(316002)(26005)(6512007)(9686003)(186003)(38100700002)(86362001)(2906002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nW2P1CAOan2rwf6ECo5thpvedGUb5zIZORgI80UElnP9mtAaHusxMWFriOFK?=
 =?us-ascii?Q?h6xIitDIuogdLYBDeaduY8C2fGBv02OIrCCeDA4HvebcnS/SFWu9Ek2eHFU8?=
 =?us-ascii?Q?oGw1H6JYBjHoJIv7jWje+sKHM4qyp8Vcj2P9GCJnu+aPCiR5JQ0oCH3uWN8e?=
 =?us-ascii?Q?Tx37If/4f2KkYB6NlW/6k1FtkFeKLxFEdYJJe88ItXVoheudm6+4/WbOrQRe?=
 =?us-ascii?Q?fc1clrvDrbT9p4wQGnPMtgKbLT1G9pbr5gKZOqyPeD1V2OEx2vWwhZWXJhOU?=
 =?us-ascii?Q?tN2HN8F2hglv2+x42ORDetGv2yi0+LoqFvfCDTMaLsH8LUvqv1dzBFs356xi?=
 =?us-ascii?Q?uZ9IZ4UXpBO+obBIuAMXqZYZR6kiFmslueDWzFeoLPrBsX8ni88/DWGUjR8/?=
 =?us-ascii?Q?KTMt+rdyzHaBlOzRkjp6NFAAWO4mqILKikUM6vaMJLIlppxHfhO4N2ePkLs4?=
 =?us-ascii?Q?/p6pQLEMUmgRIho++YxFs9ENtobJ/e9F+cGv5CqlFjvj3AAcizOtVI6O6t8v?=
 =?us-ascii?Q?KNPEKKIQH9iqcqUsW6abILMgqHWXLHlaokkbyMqD42XpSQIGwui89oO2rVMy?=
 =?us-ascii?Q?New+7TtTunbbBQ9R6z6Dulx3LIwqAoB/NUFoNMrL7qNMamMfbPOXux2ZZWGV?=
 =?us-ascii?Q?uWznSNAB3xIUDKYjqh90ezF6oOPQbVgzm83Sh/3JM9d2IsRUBFpiQfZjtk43?=
 =?us-ascii?Q?5EiKIjyO8ws5haf7wWcCofuYxCCzjevgbP7Pu1pkiuHV5lnW0ki4V93l+ZKm?=
 =?us-ascii?Q?u6uQ8m4UaezBXuK4di/ScFZ3OVaeKTF6fu1ml0/ghjgmurO+8WEdzs4kpKYS?=
 =?us-ascii?Q?BLihCYMxVCMWhwT5SQf5dnjzWiq0M9FU2k5YIWOyMmy2bz7YCjlNpnqr3EQw?=
 =?us-ascii?Q?MINPjhVXBUQpJVNKKJ52ggcOqjDL4hTEFZusY1xDEZ0bbaX9KIDmGkju9kPG?=
 =?us-ascii?Q?2OL9LdpxzYFBGAifGNU//9r/CRPjPftGC+vErsEkQTvPzV956xNeUOVIfTWL?=
 =?us-ascii?Q?u4lKms90eI676fIsoe18SojHuJ95XQClheevfexWTc19CLzJ83jBJpKrDbc9?=
 =?us-ascii?Q?5JcbQkTRD3p8agL4bA85Sw1J8GXzbaqKtgdun13qL1ZVKiZjwhwSnyWqRRn6?=
 =?us-ascii?Q?fX5eNsoLYd5gW1EO4acySmaHoiOQ6R6enOgWQN4HxmRw2JX3hd0lqfvE2O4M?=
 =?us-ascii?Q?k582+BhNzDTnNk3QO0b3l0Tge0xbPleTFWUMf9tCxrS3Eb0JCFaVGn2lf/bE?=
 =?us-ascii?Q?1VaozI2hfdeha0QCtUzlmzvXNMpcRlPTKbQTrk60jIu7CrGoABgNzKP1fqTn?=
 =?us-ascii?Q?QliKHT5vsEkV4skTeETCF0N3s/imDTy3IYrFMwY4Aod8jHjJaXnLS61PqqF5?=
 =?us-ascii?Q?Kzkm7IKd+rYRur7007KDSXyAe42gLjwwH+zgDjSVOfzIDsOmn/QbS6Q3/KAz?=
 =?us-ascii?Q?TaEhcWucju2XgOG/RNTHC/LyTajFKQF0ph0o2put3ux2AWECd8CdKPNQIlWT?=
 =?us-ascii?Q?BMG6t3B6Kcx7ejOLRfNOUBJOaHY1l0iMyGt1csofUbUqggsIGmJUsBfAdMKq?=
 =?us-ascii?Q?sek2t6M/9QKiD8fwc/FkTK9tVg60u9o3pOeKajS9y/ulkxBlYJPOrO5gTEc1?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5efa70-6f71-47e6-b9ec-08db02fdfd5e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 20:10:10.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9Bau4k1n/buzasddVW/+FCcHmXI/8sNfPGifukbvgwyzyVZ5xWqjCwhV2whhveTWRen5Fq8I0n2F2YUXDWllhbytykwxynh8lYdioi4F2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
[..]
> I found the same results.
> 
> Reference command and config for list readers:
> 
> sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
> -m 2G,slots=4,maxmem=4G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> -object memory-backend-ram,id=mem0,size=1G,share=on \
> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> 
> 
> echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
> echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
> echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
> echo 0x40000000 > /sys/bus/cxl/devices/region0/size
> echo mem0 > /sys/bus/cxl/devices/region0/target0
> 
> Not sure if bug/missing feature, but after attaching a device to the
> target, you get no output when reading target0
> 
> ```
> [root@fedora ~]# cat /sys/bus/cxl/devices/region0/target0
> 
> [root@fedora ~]#

Hmm, did you not get:

"-bash: echo: write error: Invalid argument"

...at that step? Because targetX expects an endpoint decoder, not a
memdev.


> ```
> 
> Would be nice for the sake of easier topology reporting if either this
> reported the configured target or we added a link to the targets into
> the directory.
> 
> But this looks good to be so far, excited to see the devdax patch, I
> think i can whip up a sample DCD device (for command testing and proof
> of concept) pretty quickly after this.
> 
> 
> One question re: auto-online of the devdax hookup - is the intent for
> auto-online to follow /sys/devices/system/memory/auto_online_blocks
> settings or should we consider controlling auto-online more granularly?
> 
> It's a bit of a catch-22 if we follow auto_online_blocks:
>   1) for local memory expanders, if off, this is annoying
> 	2) for statically configured remote-pools (remote expanders)
>      this is annoying for the same reason
> 	3) for early DCD's (multi-headed expander, no-switch), the pattern
> 	   / expectation i'm seeing is that the device expects hosts to see all
> 		 memory blocks when the device is hooked up, and then expects hosts
> 		 to "play nice" by only onlining blocks that have been allocated.
> 		 (there is some device-side exclusion features to enforce security).
> 
> Basically early DCD's will look like remote expanders with some
> exclusivity controls (configured via the DCD commands).
> 
> So with the pattern above, lets say you have a 1TB pool attached to 4
> hosts.  Each host would produce the following commands:
> 
> echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
> echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
> echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
> echo 0x10000000000 > /sys/bus/cxl/devices/region0/size
> echo mem0 > /sys/bus/cxl/devices/region0/target0

> and mem0 would get 4096 memory# blocks (presumably under region/devdax?)

At 1T of size, mem0 would be hosting 4294967296 256-byte blocks.

> A provisioning command would be sent via the device interface
> 
> ioctl(DCD(N blocks)) -> /sys/bus/cxl/devices/mem0/dev 
> return: DCD return structure with extents[blocks[a,b,c],...]

In the DCD case the CXL-region would be instantiated ahead of time and
associated with a DAX-region. Upon each capacity addition event a new
devdax instance would appear in that region.

> Then the final action would be
> echo online > /sys/bus/cxl/devices/region0/devdax/memory[a,b,c...]

Something like that, yes.

> or online_moveable, or probably some other special zone to make sure
> the memory is not used by the kernel (so it can be later released)
> 
> 
> So to me, it feels like we might want more granular auto-online control,
> but I don't know how possible that is.

Yes, I think it also needs to coordinate with the existing udev rules
and policy around auto-onlining new memory blocks.

> Note: This is me relaying what I've seen/heard from some device vendors
> in terms of what they think the control scheme will be, so if something
> is wildly off-base, it would be good to address the expectations.
> 
> 
> Either way: This is awesome, thank you for sharing the preview Dan.

Thanks for testing!
