Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BBC7EE23
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 04:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjEXEHV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 May 2023 00:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjEXEHT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 May 2023 00:07:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B4E6
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 21:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684901238; x=1716437238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V7hMKSFvas43z1WvtWjhRVmZZscV2YBImohQ2h2PK8I=;
  b=cY9tHhJo20Nq6lkDVOf3A1nhSwU2K6smk6T6qxf0bOAgOrQCvRpC/2Br
   AADJSE38Lv+83pEvejdh5TrpH5wpxYzUVI09SVf1bS8dZRSfzDcUAWT/o
   Ndt6WcCD+RpQy6wbzCPUSaKCtxmzfnBcYI9hba9a57h7G9O63QDkyBODa
   aIhCSpS9PSQ3MdBeTG63/SEl0DeSWhsZFwW51OcPjg2JmbIk+c0lP+z/a
   +MF8sj9uC9uahlHsG4njp0fDn/zOuvfCevFeBcDAec7BtKbVVMrIGa0Bv
   iB3stakBjJViyxn+z6Um1237U0qWEouLFvHrJIySacnkB6bYJ4T05A+nO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="419160337"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="419160337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 21:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="878476685"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="878476685"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 23 May 2023 21:03:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 21:03:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 21:03:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 21:03:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 21:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNRHT2ESfzJgQaCW8NJPPSYUVLItj85cLxAUP43m7uRO/vcIDmMnnVuHBs5oEK925iOFTtDt/LRDw3UhgocG5HLQrZ0MxOYPgIRbe32E8ZsJ6fxES48U3OEu5ZQ1od/daS9Nk/ckFnitSMG+Eq+cJh3X6k9fQ93D88ZBX8v8vtFlv53pjPJqViRHWbChVwIZ81WBeX+xKRZkZVJF4EkPBkyg5+UkwXU7KbtPjyp+tx9+QQAX9rHV0SkVY3PfR2/WPZ0FLZtOuIXN1/x/QgjAp/I0Ue52TSteuABGJTUgZTExtMyyJrtOdeJezgCfc7htZvQH/1Ip42C+hgyvCDOwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDrMHkkpQuAtcecObpfQlhjlFFvFlUaMgrzi6vz6JPc=;
 b=VmM8SNgo+UReHvjy0vHW150gCBlPW6gyWGofE3fWWD5VFjMWvf0i97Kb2t6SX5WBZ7pDE+n7r+CWgf/uisRG1HyOV4+ZQ/mOU86htE3hwzdsHfRz3zMrfI1rk+V8otQgGEsV4J175pZvVn4UhNj2ldY/In+BgeMSI6dREaxlhq+apq4F4FK0rctvf3hOzK2lpGUZ18PMlHCTlB+e8/0hstvgqKkCPEdhjnqeTjto7qf7JD8gpjm5lcWzXuSEHG48uE07yJefo5iswzT+DYGM2PJfWk1aNXKHkOuXYpY9e+M3IdD046H+SMPo7OknvfjnX4vx5XhaBcX7Ue/HAM7ckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 04:03:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 04:03:05 +0000
Date:   Tue, 23 May 2023 21:03:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vikram Sethi <vsethi@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 238877d8-a23c-4e8d-70fb-08db5c0bc65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YO+7tmpA9FT/4d+anHp7241zhVxRY593YteRVK6PAi4JIXyCay2UJfcYMMf3Je0PuqY+n9acBMnBG6BQ9CYEim3kcn3FCQWCW1K2fb3ZmsfyK/dcNA9mSClutVT2VeJIaTUG6iGrMQshuM+Oid8H62mCxKaQFLAJUylO9hsyVnEawgZzFNj5NAthMJY0W7B7VqPj+PazRCHcmdH8ax2/QXZr7sUp66g9I7sA0D6lcX7RmNPQ/eHOXEVL2cXdLGWTReXolbN/MsAheVLcTkJ374vyznLgzxilhwxjHIC/PwnTTr4R8DT/invGAP7gS1+c0vwFrxsYVpmE/Ku9FerGz0Bsgk6koi8TJUiVv+aWG33/rcGis5Ql2xzFZ1O7iSxOBItoc0lX0JhCOwdDdJZ9Pju/5cYcIeAlYGtn4NWVpWtpB/bmRhsB4xui9gGRDHuYomeO+T3R9IZdRVR1cxeJTbiE8jZj8n5zmz8eKpnaRc5XVBJkgVIqzsV9WlUwFPaTfaQ2bRsbGrtIPl4UrEuSSZOWUpysYo8XcFbCT4sHBqSdYV16QGDNs/GZGIBDHxW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(66946007)(66556008)(66476007)(4326008)(6486002)(110136005)(41300700001)(6666004)(316002)(5660300002)(8936002)(8676002)(478600001)(86362001)(38100700002)(107886003)(26005)(9686003)(6506007)(6512007)(82960400001)(186003)(53546011)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?caAU8fxAmyRRML1041pUs7fHnpNzap9NPnBwQ5iUVy4aCYCxnXr/VSBQWLxp?=
 =?us-ascii?Q?U3E+6Y1JLqO9NkDNfyKaznmiNCX+ZJ0JKpn9bii3tLvn25pm9p9OXw0f1OFS?=
 =?us-ascii?Q?MlcoHJ2pyYYSRcZ2MjJVcD8M0M9fxzhKuHGpxOhx7QF7mpV4ho/mWcMAPlo6?=
 =?us-ascii?Q?Am1HzagS1MDe/S+a9NSD7BqBZzMZPE8a72XlmwTnwx6qD27/3wgktJWlDaP9?=
 =?us-ascii?Q?E+t4GzJVx79pLhM4YM4xCikcgOeQ/Jgbuwn74CIBHjHTSjslMZNAMFkeHWl2?=
 =?us-ascii?Q?XZ9BIkkLbsgTU7tdhXRaQqKd+51RHNh2HTBHQFNUooxxOtfQUxILPpBsVAhz?=
 =?us-ascii?Q?AVO6dmncVEYJurFTUbIgt3O8yGIi6t30xG9U6KB5E5C9D/riYScaK6U/GdVq?=
 =?us-ascii?Q?xJTGJAcRSRPfX5PDvWcbidmLRmc2n2nTpy8BmI1sJHNGq/D4LWHc11cgOOfO?=
 =?us-ascii?Q?ZnKtWPvBr1ZcYsjIi/kaC+poqrM0++Z76M0xr0we1QuuWCVOZFBf5bTd3dTy?=
 =?us-ascii?Q?92ZQZvGDc1rRRTmSZC0vlYUTAfIdYNEGicxO4//M61UcdTDOwap6x4Yff+nc?=
 =?us-ascii?Q?F5rS7YtEI5eR31ZIL6tbatzo35s12g8Ok7fx56YwY6DE9Wr1goY6NcM+yWOZ?=
 =?us-ascii?Q?z/fgjQCyxVjbUfgIaXvozeYPe+0FLNiHF/cATgmYaFop7KcBaGveYQHQFnLB?=
 =?us-ascii?Q?q36MM1PR5w+dl7+AX3UVOUwqQe4IFhwVWpaeXkF1AWckAbGsM99zC/5oTtaw?=
 =?us-ascii?Q?yx/JUEQWRDe83uzcOlTj1MTXTxrHFBaCIQ5r0D9hiiSTQ0UHujeIoQMsXu9T?=
 =?us-ascii?Q?tJT96WEUw7BqoRIytyMwl00g8ZYtq2WOeIy8/6fJo++aNPe3IToUHO/S6Yld?=
 =?us-ascii?Q?NkWgMMY47yern0rw4p+Yirni9NXnp5yjiByF3Ddpwm4DjcOe7lrE5zsMcl15?=
 =?us-ascii?Q?omggnn3RvU5DHbI3Uo5q6mE0RQg/JjOTBo3eXkqoUyFipoRilHkwlogve+lM?=
 =?us-ascii?Q?eJraZ0pmOdd+HbGEDp8ptIsek9p0KWYY8vBJU0mQePmMtBJBY1NbdXPUi3Kg?=
 =?us-ascii?Q?7BPNPG7/oGUgJtvQ6cLkNUOB59eL/xSuznBptgoX6IdSMTxQBbPjTXOy2Hxe?=
 =?us-ascii?Q?xLvEusHi7xUmIfXfFp+5n5FWWj5pQiBCisB1HA+WII34BnY4QhfmVrNwY1/u?=
 =?us-ascii?Q?o/DKYFQbOP6X9NWngtm33aAej1ulcEVM1+BC8k6KcgOVBFwiX2fpPpLUMiOj?=
 =?us-ascii?Q?HvAnPPMUZBIgguqtaZSkukcl3/iypClxbLk204syTnQNKpVckGRZoHT3zj3B?=
 =?us-ascii?Q?l0zWeXmhoRGPtbchJPuh5IOMQMmtWTz8WAa1c7+/7dhFtIoQtLnJfsR9/U62?=
 =?us-ascii?Q?2HhP4A9q3HOoeLZZjBNxvcEZX0Nqj4Jp8d+HCWSs4GVbftZaY+t1Xjfxxd7t?=
 =?us-ascii?Q?Ir+1KUnE/uzqb/TgPW1gOr66BZFrtD2LBldemOWu1auD6bFIbr7CeyFKwsZp?=
 =?us-ascii?Q?sjmtiF1SmNukehZgyZWeL78O8c1mwXQCL7QA3LImoclgqV3gra4WN9Czwuej?=
 =?us-ascii?Q?2mkNNq8VW5Icf33A8RCr9Y2nyRYl4IZ6OSyOaSrb1tuuKMs6GOWsiDQnnOfa?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 238877d8-a23c-4e8d-70fb-08db5c0bc65f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 04:03:04.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCir0REUNTfb2jm3msIiRzq8X398APy/YmySrdnndstjuvjqMTRu5QIch5LECpqTMIW23j9sot0rtCuVEWd0UYbr1yzttDqOQpk+zv2ili8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vikram Sethi wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Tuesday, May 23, 2023 1:40 PM
> > To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> > <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>;
> > linux-cxl@vger.kernel.org; catalin.marinas@arm.com; James Morse
> > <james.morse@arm.com>
> > Cc: Natu, Mahesh <mahesh.natu@intel.com>
> > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > 
> > Vikram Sethi wrote:
> > > Hi Dan,
> > >
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > Sent: Monday, May 22, 2023 7:12 PM
> > > > To: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>; linux-
> > > > cxl@vger.kernel.org
> > > > Cc: 'Dan Williams' <dan.j.williams@intel.com>
> > > > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > > >
> > > > > Q4) Current CXL drivers/tools support Hot-removal request from PCIe?
> > > > >
> > > > >     CXL specification says "In a managed Hot-Remove flow, software is
> > > > >     notified of a hot removal request."
> > > >
> > > > Currently there is a requirement that:
> > > >
> > > > cxl disable-memdev
> > > >
> > > > ...is run before the device can be removed. There is no warning from
> > > > the PCI hotplug driver. Which means that if end user does the wrong
> > > > sequence they can crash the kernel / remove memory that may still be in
> > active use.
> > > >
> > > Is there any notion of a cache flush when memory is removed (or in future
> > CXL reset)?
> > 
> > No.
> > 
> > > Generally, CPU caches must be flushed when memory is removed because
> > > any evictions when the memory isn't present can cause async errors
> > > which can be fatal to the system or at least to VMs, depending on ISA.
> > 
> > This seems incompatible with memory hotplug. The cache flushing is only
> > done on the subsequent reuse of physical address range to make sure that
> > any pending evictions are complete before the newly constituted address
> > range is put into service, or that any prior clean cache lines of old content are
> > dropped. See cxl_region_invalidate_memregion() for where this is called.
> > 
> > > If the kernel does the cache flush, it must be done with only
> > > uncacheable mappings present to prevent speculative fetches after the
> > cache flush.
> > 
> > This is why the invalidation is done after physical address range is populated
> > by new devices. To flush any speculative fetches to the old composition of
> > the address range.
> > 
> I don't think invalidate on the probe path will always work for
> devices with snoop filters, including HDM-DB memory devices or CXL
> type2 accelerators.  After CXL reset or hot plug insertion, a HDM-DB
> device's snoop filter isn't tracking any lines checked out by the
> host. Even if those were just clean lines in CPU caches, hosts can
> send drop notifications in CXL in response to the cache flush
> (MemClnEvict).  A device that isn't expecting this evict notification
> can go into error state and optionally raise a device internal error
> interrupt. So you could end up with a non functional device.

I don't understand this failure mode. Accelerator is added, driver sets
up an HDM decode range and triggers CPU cache invalidation before
mapping the memory into page tables. Wouldn't the device, upon receiving
an invalidation request, just snoop its caches and say "nothing for me
to do"?
