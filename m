Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBA1842
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lp1ymkHU"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D26129
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698202193; x=1729738193;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Mnh/qEHD7YPrR1PtWoWB3qjq596r/Q5AF5qXbQabgIo=;
  b=lp1ymkHUGeagpiPCIy09PtINi6OnXtq68Wiuj4Fw8GYmKmfGSq2IQ2O0
   5Aa7Bsr0scbHYtk/5FZwieIx0wRceyll9Buj4kVprKwnmEHernNtg7Go1
   1P4+nQU4Em9/c1cLbU0IH5agcvNJ9CcMgcJ4oMGZe0QfZPOEBkxcTTINp
   ae3pzFo1pNmmVYCvxtNo5/4QoE+DEprO8hJjC/O0Qxj7UrMWKiHNDCWTM
   X23gAWwAL/gW4TY0Tiau2vC+x24AyVpnWEkXLuWqkS+lnNb3tbAwJKLyv
   v0Uyes3PXaAAoOqdqLuEQgp6QvFQuAf9Pgn0W29G/IhtnCBwfTgbcIR8+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="473460890"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="473460890"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 19:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="793721119"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="793721119"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 19:49:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:49:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:49:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 19:49:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 19:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZ6IP6E/2J1cMag2aGKIQomdytIEOr6NxRLatUnvynz0m9mYLnTslqyFd1WGi42wwtMFvNqZIgCoOQzyHq3/UJUgHKOYuA/oAfMs1YTZ7oZtAbifdTBaIKcAwYeLbPw8+Bv2vhAPeTOjlIUAshSpu8C0Jd3MuBu992rMff26C9xr7ZnEPU/dmzXEfmw/wd07zeBSm8MD1nLtFa2/ZY0qgl2/N4uY0qC3MCNNIkivne7WvPVXJ/s63dge1GWaBb05vrFAaqILDG9ri/kai/xxDKXFgNfnrId2DuHsgq0drxdmJh5RJMgfPVMwSqQI4Qlf2ynUm9U6TGJOCEFa3SWw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNndisgI/hK5p2I57GbOeS6fnveLqDpWkceV9WUa+kc=;
 b=moZO/vDLmNLiNVipz3cL/9ajJV5mwnkjdNGkAiEdT1yLOoi8HsWdBEHNF9R/2XwLmVv0sTnEVq/BthRMr4ztSCVRs9vJBPtZJj0i+1hy1G/6B76xcvMCjb0CwNy0G8PiDVYb2M9wgv5L5OFAW01tZdIPmLnIOLbTknalU3/PGsZ9nc5SE4HaPxclmQOb+ClCzf70XCNoRcKFJhW3H096xTW3YNfzjXq2Z9hoQwIoaoAchqQXjTlr6guQD/esAWmVwxJv0gfVZzX1iKfSp07Mz/1dCoFlrbRNf27QIfvoYwanXL4F+IcIAd1KDfV1V7WP2AWJ243v9UfppT0jK35dpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:49:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 02:49:49 +0000
Date: Tue, 24 Oct 2023 19:49:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jim Harris <jim.harris@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: Refactor logic around check_last_peer()
Message-ID: <6538824b52349_7258329466@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa@uscas1p1.samsung.com>
 <169696721124.1190606.18028412676865061799.stgit@bgt-140510-bm03.eng.stellus.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169696721124.1190606.18028412676865061799.stgit@bgt-140510-bm03.eng.stellus.in>
X-ClientProxiedBy: MW3PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:303:2a::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: a3453d2c-8868-4484-0dc8-08dbd5050e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0+I/j92M7GAH2qZhfixi7SC+DkkBuzanS6wkT2iVZup7ePLSqsHeRTvaThGpQ8/mI/vxdjkMEMSnxxUFJ43cg8f6DpXyUc1hhlF3bxXj/z2mMwfZ8gc2tLGblvjKA5bYt3GOks2ibnoxh/h40nmaJBZcMoMWY9oXKRfds9GqGRN+ef4hMxSzfwgcM0l/yLQrpxyB/Bnfslf/cpx37VQvGRb+1yxdGHfgZylMbUo59c1eomzQAyz6K3F60g1wbQWC7CwFAeQDbcneuG8+iR0ikMNPP3XfwB17LqnKRjKWvOSq3KawAZfwgS8JkLIZlbkGiWInCn0Go3Se6/O6CLjET4ItBtLc0XQB9z/HRLAK3KNP3j5C5NX6SN1wD07q0iPRCR3X3S0kNi0XcAyJ3KJWkbMnMIAgyZ14bl7PhVpnh9opiwtGC/HIH+NYjkH8qK4XpC1YaViXbbTe0CoeVFRCc/3H84f21vtiYUMa6Il3lN2xRII/ocqGQrGGshaq98iWZiLCqVUsg7fsJxkXdBbgHY9z9QP8WjDyrtgBzzXfbJF5WUHOZ76pidD6lL3Y39t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(38100700002)(2906002)(86362001)(5660300002)(8936002)(8676002)(110136005)(478600001)(6506007)(6486002)(66476007)(41300700001)(316002)(66556008)(66946007)(82960400001)(83380400001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQeX/Xc0c92mLhronE6pqHdSDWIMetzzG+1lH2c7BiIMZEgAttvOe41ZTLlp?=
 =?us-ascii?Q?ah4ANTjyKxFyHo/oMJb3IUXIIdrE9b9k9rsGZx4noA5zDIn4gQUEa74fNh9L?=
 =?us-ascii?Q?V1qR06HXQ8xDoAt/tMP3koMCCtBm5fXOfeMfoKdJuCKrei1T7jKXsdZj2FTz?=
 =?us-ascii?Q?oICJRgZ5yGngGb/bC2kdBvBNpPEG16rytC8ZDbB4NZNGjdnyxO7DhpDOvUFD?=
 =?us-ascii?Q?+qod1v4KXZmL3nss0idmVCIMh8zqJtVrsLB0kUjdOmiGu99CV4M/Vgr6SbqV?=
 =?us-ascii?Q?N55uA6l0o/LmeFVonQAvvvxyIAXqzWdSOidGcr86sfEutdbVo1PwkPpY5jJc?=
 =?us-ascii?Q?mNqYLCZmloILqSILuHxCciGi8Kj7Cz/Ph2sBKXHWNCNbZKzCBviYUxnBVgWz?=
 =?us-ascii?Q?bC4GdWDwCoFTDf5va08Dy3P8RgE4N6/gHaCFNaOal/c1O3Se02VAYAWcHS3c?=
 =?us-ascii?Q?bhs1qVgK0vuUJaQg8RILK26PEtkEMGjGBy02s/y0C9XBwGfq8rt3zIMvTY3m?=
 =?us-ascii?Q?/b6aU6lhWq9Vp1rz9oE8ODA8GRmAAiR7e+vHwvkECSM5HwiVkmM1obfM/5XM?=
 =?us-ascii?Q?i89nkXT4NAAc0fCfFxpsit9ukKqdPo3d0nbbc26Ubvb1OxjTMD7IQmIn5L8B?=
 =?us-ascii?Q?fiZO+c1WYNbzD37ARna4kIftKj2U4OWMDgFsxwJRLV87gpL3GGIuu6YTpAa6?=
 =?us-ascii?Q?DUnIkiloJxe9otNWGyXC7GfkfzVkZn584eVUWpz4FDSnp+V2FWq4aTyXiF0X?=
 =?us-ascii?Q?hPH4mR6Ru0hYztfAHToHop/i4esJYrmJUCimfh469H65GiQmhb+Rq9CtWUhJ?=
 =?us-ascii?Q?nQbxtOe1CtWOJ+NUPYhz2xTDBtmVL9PkT2Hq33E+AemFcykxHBgwmvzKgEw2?=
 =?us-ascii?Q?nKf9wYFMspAD2evKflzZ3ce17xjG1u6KtRXkfFfb42HyL6uoMQgJSS9kYsMW?=
 =?us-ascii?Q?fV3qr8jdOs9N3d1zxUDLfWhbcuUymeSYkry8JlkeU4LFY8KqIOi2PfYuXObl?=
 =?us-ascii?Q?C1V/6YMWpj61Qy1LBS8ABYZOv3uSw0xTeRVSf4eHwcqyKQYH4IMX2vET+GkT?=
 =?us-ascii?Q?fg/Qw9QHXaK4BDkeYwO5oR0DnRizMqBSDBLkEvENmEOmiMKmUscIqgXJoMMY?=
 =?us-ascii?Q?/yZ8UV3w3qSrPGLPTq9Nz0qgx7d+LQ1JDsMKpM88Sn/2u61X8xIbd+42uARo?=
 =?us-ascii?Q?mLUPxrXhShH/l3uuTlx22MMy1guD4YCGJRzLKXTGSIwQ/FXN+H8qIWsvF6FY?=
 =?us-ascii?Q?2zrtu0Wv2M6TEl40j/wFH1OHFoajObt/DcCwTnZOGmNgmeTxzSHqpwZCz7Tq?=
 =?us-ascii?Q?qzwQU7nrOOl0DFIU5VBnLG/GuwypxaJOI6Crcq+5h5hXVx4zSlbgkxRAmJpQ?=
 =?us-ascii?Q?R5UmOWwgKLeRBAbLJscBbMoHmLITAplcQzNlAyvs8rhE7m/whPrRFPrJ6ZNW?=
 =?us-ascii?Q?PxNQ6LfjWkyNX3JKSAprPE1fPms1yn4r+7VBkmhQvK78wevF85ELQoHWTZj4?=
 =?us-ascii?Q?yODUA3ExN58PSqToUP4c98cBTyKa+7Zry19pYNykBTqAUGaOSmyxtS4tN//c?=
 =?us-ascii?Q?QtnG3y6xIBGrfgfNzmcO9HUfD5y6hXHA3SoAEFJ7DY07PAefcT44b+HpgRUj?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3453d2c-8868-4484-0dc8-08dbd5050e20
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:49:49.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN9Dw0xmmRQ0RVpt8wGefiEwJMkKekZzgibAoBMFKGGVpFvu+9pvdJnT098unELtrhcb8v5ZLCARnHPBYHI/dB0jdgBbjpBD+vk/oesIYuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-OriginatorOrg: intel.com

Jim Harris wrote:
> 'distance' is equivalent to the interleave_ways of the switch decoder
> of the port we are setting up in cxl_port_setup_targets().
> 
> We can also eliminate the special case for passthrough decoders (i.e.
> interleave_ways == 1) - check_last_peer() will just compare this
> endpoint's dport with the dport of the immediately preceding endpoint
> based on position.

It turns out this patch fails cxl-region-sysfs.sh.

    test/cxl-region-sysfs.sh: failed at line 94
    
    [   38.367581] check_last_peer: cxl region8: cxl_host_bridge.0:port4: mem5:decoder15.1 pos 4 mismatched peer mem7:decoder17.0
    
This patch looked so appetizing that I really wanted it to be a bug in
the test and not a bug in this patch, but I think it is the latter.

> @@ -1111,20 +1111,17 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>       cxlsd = to_cxl_switch_decoder(&cxld->dev);
>       if (cxl_rr->nr_targets_set) {
> -             int i, distance;
> +             int i;
>  
>               /*
> -              * Passthrough decoders impose no distance requirements between
> -              * peers
> +              * Check if this endpoint's dport is already in the
> +              * switch decoder's target list, and if so check that
> +              * it is positioned correctly based on the switch's
> +              * interleave.
>                */
> -             if (cxl_rr->nr_targets == 1)
> -                     distance = 0;
> -             else
> -                     distance = p->nr_targets / cxl_rr->nr_targets;

This calculation is essentially doing the "top-down" version of the
"bottom-up" position calculation Alison introduced in her proposed region
assembly fixes:

    for_each_parent_port(...)
        pos = pos * parent_ways + parent_pos

So in a x8 region across 2x HBs with 2x switches per HB. The "distance"
of peers at the switch level is 4. This change makes that 2.

Maybe the right conceptual cleanup is to still ditch this distance
calculation based on "p->nr_targets / cxl_rr->nr_targets" and walk up
from this port and multiply the local ways by all the ancestral ways,
but as is this gets the answer with less steps (modulo all the work to
build up @ep and @cxl_rr).
