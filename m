Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C0C64ED6
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 18:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCASqh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 13:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCASqg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 13:46:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B77A15C85
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 10:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677696395; x=1709232395;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KvU8i7URqI/SVtoqJbGlxh/1nX6FCs6UcgWu8SxKegc=;
  b=DqlVy1Z3qvly4HZ2L4kx7uIpjHqDm/93ypcqhTZad3apczLlJmKxtiHH
   ktQLE2RAj7gyIfn/0MHuTLoYIj7XQwdHnh8zO5rrHEXKuRpnoxJZfsPBd
   ckPvsBes4OB3bMkyhw2GNdKEZedeHuGMH8DACe3FYDeoPkdq+luzgH0i5
   BHhR/Rfjzgzkcry/+/ObbE6n/GYCiGZc05yPSMwLPiidRRsAWuN9vOuMK
   uAWj6JcVK/oORBFRjcr09VpaYqglbSJ8q0cOdA7LfsatQpxkAjtaZ8o3B
   gl8pruU/zOf0+r/JkPCp4f6HgzJmbmg3WDyUvkvnpAIPWRr4DA4mKD00i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333216899"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="333216899"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 10:46:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="667967177"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="667967177"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2023 10:46:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 10:46:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 10:46:33 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 10:46:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlC2Q3pGyvJLC3LataLnYBTWuOvi5PwZFhb0Fbm6s+tBm4+9zk0J6FaUt77pAp1xVeVMvKmTD/Seh3tbbvccCwJlo8shc8cp9SJA4DIiNiP1ZnVN6QubfmvcCLfRi3t3t5y3LLik/czMGmrbT4jVPl9Dv3ReCO6z0kjxrr/0bsgyXcZag+DsIgSZVz8SmnsgyD3as3ps9jcC6pGfzIXm/7MBYe/dEN4iMQ8rpMNFyN7LI8nqG1zgJDH76r+cfzZatQLH+6AOKO3lbU3TgwM/S4vcaKy607oRVAeaiVKWDFu13MXfZjb/eJB0IIoXzTgbYfABkcfCqfC1JZKa5Q62MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1FRAopfCMklLSTsJMqFIAIcJdFksYik2+V8jTew/jY=;
 b=J53auJt2JwXV9W1K6q9t7RYqxyxcFOWOCjQ9gceM7ZnjnIkbzhviKJ7i69fgb0UT69ajzZf8ZMa1bdhRPMEe0IQyzDYK8b4lblcYwLFS8GfVDXcbwGUMy9ZQK970jPe5q3lG787RGddciysuTk3PVvn9y3fGIFRU41O5Ryyn3gTUcscBi8SzcjC17I7xp1RqQiUNkE7M6lGA0q5wvo/AywtPDN14sIDYFxnYXFTzUKNaCF53XirEh+ZUe8ghqZ5R0ho7IrkidzWUMYcQqSNubAfQYpIwWBOGl9BwHCgWH8SjotnPxV3ybzmnOM428Vg2WU6jsEfTP9lgA4MwQKLVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6542.namprd11.prod.outlook.com (2603:10b6:8:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 18:46:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 18:46:31 +0000
Date:   Wed, 1 Mar 2023 10:46:29 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 0/2] cxl: DVSEC Range emulation fixups
Message-ID: <63ff9d85215e_495bc294e2@dwillia2-xfh.jf.intel.com.notmuch>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <Y/gPhE3hDnTEd6PI@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y/gPhE3hDnTEd6PI@memverge.com>
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: a6345cb4-ddb0-47f7-9bb8-08db1a854619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0rTUMK1+PK6ugHwerLpyNYi/n22EmagRZo2TdUg1gKWqdr06OLWHhNlMDfDgsXoWewBRPu81+1HIsbTkcBpW+YD/wii7vzhdum7mXOC4nGIIbjk4GgaPid2AUeqbJwszaQ4PPFHiBvCcfdGxJYEVoOx6qgLPt2gL0NYEfxQzoo4z7+AJ3jtnwQNKFzHb2Cd/YFfxAGxT7mrr6Bh8OAwjZdNhA8NoEyd4FRgcjFJw9InhV7RCJpiG/l3KCOm8fY8OxHGZwB+f09icwuplXmNNg0k4/nrpKFsev/QXaF2u6EXF7jOgJZL2Y9rm4KdfvwWQ/ImH5jPXoVnVL2GplgF0Z8Scul0YNwc45pC9rsLfvGhBfkVzIFmr2aCfP2IHPSgv5Z23drEPX45sqbgFtF5C7XQ/BQPMtv9fzjuLcJG2Cc2ycrOa71shnzQtqfbuAxCJKu+XyR0akniRf2Y6M96zSYRBUFYWUeA8hQlKfeQUnlQwFSjdTQrD1M2KPAKJXwvtooYUoAaPlDo+9wuAzkCkmCK+rFP8FRz2Bg4BhvLN4+zJFUsIC77Ud8FQhNqNhQc8g4TMWgL2opd1lgW0dbaNiCUDQjP3l62mld1WRsk0e9ZuPHy4G1XEtqfiKMzBvGdA7svs0BHsNbUELlUP2ztQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199018)(83380400001)(110136005)(316002)(82960400001)(4326008)(38100700002)(8676002)(478600001)(66476007)(6512007)(186003)(107886003)(66946007)(6486002)(9686003)(6506007)(26005)(41300700001)(2906002)(66556008)(5660300002)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4D8jT9DbBrFIYvWaS71W8gCjAK11ZeRlZzdk3oBlfVaHO9ZIghwBjwv1b6hI?=
 =?us-ascii?Q?Nk0x64R+48hVGff4f7xQZ0yQycci+IPrjd6UG+Jmm0fQzPGqdPkJgG+3y8zz?=
 =?us-ascii?Q?kPsz5sLYe7G9iRw00W/0UORsVyZhttHW3PY3DdQ0QeO45W/DlAS6W7rW3Yjf?=
 =?us-ascii?Q?94DcbrIDlmFNKgu0Bt+IY7eped0JwWMHDWMquwcUSki0fAQ1kXGsukztgc3v?=
 =?us-ascii?Q?BzjwjIrQj64PT9Y1oPT0+1AKvrO+th/lfKoUe2KXUxfYavrsHq/bsZb4RVPb?=
 =?us-ascii?Q?KN89yq67i0sGF9bpxbuNziSdwWGdPV+rI9tHiS56YwHuEb9tk65ZkeQP7aXs?=
 =?us-ascii?Q?emdwWN0gPyeVmDHkvmpNUPGdK9sptx3KWKVbh/+l0VurhtxS7zd/sZ8JoSmH?=
 =?us-ascii?Q?dsp+wOSF2cSHYoC8dh17EAc7u4b2eUPsaprSaSF+1EYXUY6ymL71ONv4GwYw?=
 =?us-ascii?Q?chPmjPN1QSY1CZv1PDQXSKhCj48nRmQg9Zbxp9VQUp9VpDjsW3fwkEzLbKmM?=
 =?us-ascii?Q?JMhCPAt/PjdJ6+JkOyhnphr2Zar4n1qcgO3ZlJQM0S54NqNs2BsldqYO01Ha?=
 =?us-ascii?Q?31FQwmDXvXJ5zTjK/1mb16FJom0tlv2HAkHvi9qSXvwX10aKPyZRWbTGzbcT?=
 =?us-ascii?Q?O6NSo+pgdFIfj//3UlWBFiMLOrIbnpqJxCwWkVYphg7qVdQoXFZr37PHvhLP?=
 =?us-ascii?Q?FKjM+8sqtjwAmLLLPudiAK2IzsZgbTDvvPtXqyyTdelUUKrITrFDU3GAAwMN?=
 =?us-ascii?Q?fGO8M78Khn+PSRoZq0UbFe1LcQmkHL6KFe828lmlv3w0XBmbVSz3c0DUZLhC?=
 =?us-ascii?Q?9Ash4re63cS9w+xVEehppATfjtVpBfp3IsUK3DcDTYOBgAacNEfy4rmhb41E?=
 =?us-ascii?Q?MjcF8BMLspV42ncP77hpiyxcjJDPTV+QUxRPE4V5EDmfwxSfFI/Utps74ZH2?=
 =?us-ascii?Q?pfYELiTUKoFSV7aztMiGFhph3SsLeJHEffatMF/XHuzaBG1iKDy8duJhPnV2?=
 =?us-ascii?Q?KsNlJySn/AgZSiqsN5qssmY9hPh+OioLkFKTQA6/9nKQPqYmlVXq/k24D/Ns?=
 =?us-ascii?Q?glrGBEp1XBBrU2ldUcLk4zc6BRVDXVThm16yGMWpnBHq2LEEVZcxIOT5MF2q?=
 =?us-ascii?Q?o0+QriHuM1JoxWLvYJ082Hkmhb2YfArBavhDzdufZBnnh12pSrjg31bZtZyi?=
 =?us-ascii?Q?DLsV+YUtBVkLEHb6ARCSSb6HSQ+fmcI39lTzvXdpVek/Az8x8LzTtsOCgHIg?=
 =?us-ascii?Q?mtAPFFidBfQgDXVRH1AyGBcs/dhjMjaW4W7Av054PjzS6wNf2uemSgnBf7Te?=
 =?us-ascii?Q?IxD27y/GJqpvzVUSlKIKLiBL/seVLxJb/WbIj1cy4Fhx7QJtm2cToRxczbJ9?=
 =?us-ascii?Q?Wqvu3y0+dIwBylKrfkficCMRyMLaxKWcxj5DHNr886+364mJ/aGv3eO1q8Th?=
 =?us-ascii?Q?b6DSI4XHvB74n1V3LDwnQO4tUoHYBvrTdcsy7ru8S6K6Ky7oNdReBPtXT3an?=
 =?us-ascii?Q?RhIS1v+h+x/Jc6g8WONuPGY8aGGO0EbDxXP3meDdmYkyjJfRDuDyxJJCBSt2?=
 =?us-ascii?Q?B2jvjy05aHQnTqLjYq/7SzBYcgZn6i1eJPceBFQZgtxXCNiTXesWPhib4lsN?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6345cb4-ddb0-47f7-9bb8-08db1a854619
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 18:46:31.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtG/0NYintw8zv3Bomjpcwo/ZKRcMHoJbeZwTJILOF6U5sR80JAfkYgFkbHliLBnocrk1SWPSZg+uu1iehYrKMVLXdhVvoms46W7R4Qnl84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6542
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Gregory,

Gregory Price wrote:
> On Tue, Feb 21, 2023 at 05:51:13PM -0800, Dan Williams wrote:
> > Jonathan points out that the kernel is too agressive in assuming that
> > DVSEC range registers are in use, reliably skip emulation if
> > 'mem_enabled' is not set. The helper devm_cxl_setup_emulated_hdm() is
> > needlessly redoing an allocation, clean that up.
> > 
> > ---
> > 
> > Dan Williams (2):
> >       cxl/hdm: Fix double allocation of @cxlhdm
> >       cxl/hdm: Skip emulation when driver manages mem_enable
> > 
> > 
> >  drivers/cxl/core/hdm.c |   65 ++++++++++++++++++------------------------------
> >  drivers/cxl/cxl.h      |    4 ++-
> >  drivers/cxl/port.c     |    2 +
> >  3 files changed, 28 insertions(+), 43 deletions(-)
> > 
> > base-commit: 23c198e3dfaabbc891681aecb0855b9e0ac791e1
> 
> 
> not *quite* sure what to make of this yet, but i get stack trace on boot
> on real hardware with this patch.  I'm debugging other issues with this
> hardware, so i'm not sure if it's related or not, but prior to this patch
> I did not have a stack trace.
> 
> 
> I think there's two issues here:
> 
> 1) The system I'm on fails to register a CFMW/root port decoder.  I'm
>    not entirely sure why, other than during cxl_decoder_add(), the
>    target map contains "[0,]" as the target id's, and the only
>    registered ports/decoders are the endpoints.
> 
>    I don't know whether this is because the hardware just doesn't have a
>    root decoder, or what.  But it makes the volatile region patches
>    non-functional, and i have to revert back to static configuration to
>    use the real cxl device (i.e. don't mark it EFI_MEMORY_SP).

It looks like the BIOS is trying to report something in the CEDT.CFMWS
but it looks

> 2) Per the second bit - there's no component registers being registered
>    for this cxl device (plus some spurious DOE error).

If the CEDT is broken then for RCH topologies the device component
registers will also be missing.

> 
> 
> The no root decoder thing has been throwing me for a loop, if you can
> help me shed some light on this i'd greatly appreciate it.  If a socket
> has no decoders, should we expect memory expanders to be managable via
> the volatile region system in the driver?
> 
> 
> relevant dmesg info
> 
> [   21.928436] cxl root0: Failed to populate active decoder targets

Would be interesting to know if decoder_populate_targets() is returning
-EINVAL or -ENXIO.

> [   21.929077] cxl_acpi ACPI0017:00: Failed to add decode range [0x1050000000 - 0x304fffffff]
> [   21.933150]  pci0000:3f: host supports CXL (restricted)

This signals this is an RCH topology.

> [... snip ...]
> [   21.965126] cxl_pci 0000:3f:00.0: No component registers (-19)
> [   22.001597] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
> [   22.002351] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
> [   22.003265] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e
> [... snip ...]
> [   22.339973] BUG: unable to handle page fault for address: 0000000000001000
> [   22.340584] #PF: supervisor read access in kernel mode
> [   22.346801] #PF: error_code(0x0000) - not-present page
> [   22.349059] PGD 1339ec067 P4D 0
> [   22.350877] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   22.354558] CPU: 45 PID: 1351 Comm: systemd-udevd Not tainted 6.2.0+ #7
> [   22.358357] RIP: 0010:cxl_probe_component_regs+0x23/0x180 [cxl_core]

Can you send the output of:

scripts/faddr2line drivers/cxl/core/cxl_core.ko cxl_probe_component_regs+0x23

...from your kernel build directory?

I suspect this crash can be avoided with an explicit earlier check for
missing component registers, but that's not really a fix for this
failure.

Can you also send the log without these patches applied for comparison?
