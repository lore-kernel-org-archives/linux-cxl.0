Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB0C352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 01:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLGBza (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLGBz2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 20:55:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FD72ED
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 17:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670378126; x=1701914126;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tRj8DAvf7t/UdxfLWW6yVvgq1VEBtpCv6zu8qrdw6+c=;
  b=LNaj82G/261rnTnp67FN7fqdeJbooVSbUfZ7sVuQhEnMXDnZRm3T0O29
   CmNRkxyk68zbXExip6omKmYSAv+XjSP8/rkLMrLClftJei9NXw5vzTTCf
   sePUJX8HMqscH4LkWXeGXPUcYsdFcrCR8lv1WPBqHC2wUrYusQynIf15w
   VfLwr3j6wMyCE9n8yaKETRx/45i9CDL5rCyvkTvBXLdBzlRDa1sZSCiYs
   q84fI6NI3Xd76wbGcai18gWLJkJlFRm9n9hwVPpJCdTCb4QuleoT9zxMF
   aaoJTnYMjQT1ShqqJ0l9an1Ni7P9UoW6PSNnDA76mL89sITwinboja94N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="315495833"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="315495833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:55:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="788710604"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="788710604"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2022 17:55:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 17:55:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 17:55:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 17:55:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 17:55:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsKhil6Mxbr/jyrv6lLHl669UxM4+62I1PpsCpuLWBAup8zBDh9tCKj4LJ0DeYkap86eL7rg2wmqdaK2gfUikT+0LSPf/GwCo7UnaBKEOOyAy+GDhZNg9K2Z4BvUs/VjMDr4bpsrMtvp7jTHntjUtm5nwEXvwfv0QQlTQQt66l+A2MeVmarYzk1B41HyqFEmYDsbu+4Oi/RtyEJqBCLNozcKyOmGadZD0sQjCVsARUrC1P3RZ8HP1GBprSWL6dM0fFEseylxhNpgYACta++9GEdAGK2Bi2rauNnSsmD/pdRgIQtzIf1aDXDr69SImYyGX+y5/0x8RKW+i0l47DEWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRN1+1Nij2oxdgoF4NFiIQt6f3jHKuSKb7T5eqRPDS0=;
 b=IPZca+sojFcdCL3JIsJhYaCjYA9y7wzWZLscB2x+QE2yodkiavXbVbPNBPNdQTj4rOOGw8Hr+yuJ22gBNavGpTZbLwgMTQJJaC5uYMKUuNiLYIVCxa304txJSUJrUdSJ5DRDNSiAI2Fb9ZCrNYM3Sb8IbZKAmShBZxSFNnAyhCYHI+OkfCWqXOYOKN4ylaXNzY1lmagdV8+uOd6j8suEkA4Ahl/41/PyRLHqnrp/GK8exXt63w1gfMAgs4MsQ1UkgM4PKJxtoNzjS7F7erWd3WaQy5rQhcyaVSpBRP07aOn1xX3w47AgaIhKtGQkK+XbKAeeYmHye6Xu25vqX4AHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7068.namprd11.prod.outlook.com
 (2603:10b6:806:29b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 01:55:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 01:55:21 +0000
Date:   Tue, 6 Dec 2022 17:55:17 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Message-ID: <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221206011501.464916-2-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef27e3c-a98b-47ba-edb1-08dad7f61893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/yFN5gnPFFX++zWwmSvs5l/8Qj786aTKzYBrviJ/qpJuL/RHlPQWjhA7mOaxRWTw70f33ceLIvks2W7DM1isdIaDoZN32coCo632GzDMqIDknkDlzYo9hKmQM7IZYgaiYz0Qk0Q9wlJR/N0aswbSHpnlQ5gG9ovXoNEmeqUPoHWG2cDGFO6iDyNwL+q2+ecvGk7gvYPnd65Eti/KJvTPWAi+jaOooQ0Fuzufq60FCMt7cvuYlNaxTXretb1IV5a08gdbBEByWaRNjkcEMLwJ0dxZ8girYH6SUZJBSAP2LmG2xBtbkTofCX/+36VlkMIsTacK3i4jH0CKSqZBhlGlPQyZoXCN69wwMpVdKl9mHr6sXBw+9MTY4wI2GTgOoU2gL9PCrx3+Ehu88vT/Ny8EMvLpKhcJfShi9jDkZqNnxA1QqP65C3EapR3bXQ7Yio9aq7zmFR3QurzTfkUwpmEzn88hcTxORRDZrMQdl9/U0t96coP7lfe64dELsmYt1QCmfQ2N113gmX/G+dAYfi3yeCbyEy7FjLG8IXUrg/CrmrkA+0FlPRFwKdcGWWGAexFwFTrt+2xS7co+OehEPcP8HN/qnTt9g4JpQZrLA6evD8CuigsnVY6Js5/lDhzUpU6GsOb1iQUaNNjkVNz5E+joctxKVh9zL7qHpdeebcVQxo7zy1hpf3yDUAek7IzfOH7J1dHdDPBvM4rsRllTgdGtTO3o6OE5Fd0heRHc0bYgbxLsfaUfYg1xPuw/sLgboK/BFV6NN5LEbQAO5tZjBe73Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199015)(66899015)(86362001)(8936002)(66946007)(66556008)(4326008)(41300700001)(2906002)(8676002)(30864003)(66476007)(83380400001)(38100700002)(316002)(82960400001)(5660300002)(478600001)(966005)(6486002)(6666004)(6512007)(26005)(6506007)(9686003)(186003)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rCPn5ZNFt1Zx0x9efFzFMSTyFEs6Nr7UGkyW12nJXFiuriGfj5WtQhpot9Hb?=
 =?us-ascii?Q?CiQtYbyie2GoEPjAdU5Cvp9xqi4Ae3/Tozs7AmL4GeSrChhh51v9Q3eUnk5X?=
 =?us-ascii?Q?oj+8pAY1y+zzG3KGCffoAplJSu6UD5/WHhPaZX4G0ofPimbhGdKl6jhJXPtK?=
 =?us-ascii?Q?YSFJBc6kWMFNfIOQJY6IUYYF6/2KzU/s7eYl8utwRojPtILN5anNxss4XEow?=
 =?us-ascii?Q?vqZ0FXHTr5nu7qLs2UnOToFAaP0Tg/79lLN4PVMxl95ue2jrLRMjTb2PZ0Da?=
 =?us-ascii?Q?nYpEpKff2yhTU5fcGOTrK+7chkiWvlYk2TvvNZvoXEsQ669DdI87llh0RPAX?=
 =?us-ascii?Q?OnvS6g65ghhLXgTMWcwQGCIiOwO+Ohmx7rP7Zqv1o4pZ4eedaPmhZVe+uMTa?=
 =?us-ascii?Q?ikDR7hHcvVHkG0FNVnvRJgXt+pD/HDao6+qI+5XHUizhnl6CUkxfYYmnt4A8?=
 =?us-ascii?Q?R27bINJqK/WhO/ml2Cwae+OkT8f5x8ZKplGoPBz+6HghP9dDMWi5WpbPWFEj?=
 =?us-ascii?Q?a01vPJN7qdj5NVG+nw5mefWgYfWgKLkrc4gsGvlOz7o0YtkzxF3XnlK2ZXf0?=
 =?us-ascii?Q?x8idEBOzjzENPgU67pb4V0+I2M2IQ4zj3wU+ZMn5DyvaBju2VMf4Z2YXKm7z?=
 =?us-ascii?Q?/JAPSLtX5VWoVgYKVIzZBtlBvxFGC5o/RuHe1bWhP3zyc7MCC+0lI2qBV/Ru?=
 =?us-ascii?Q?6ttRMvHMwppM51wVX4Be7mlc69ClNJ8Cz1eLQgqK12ktVpppBMt2vOOcl7wb?=
 =?us-ascii?Q?2IxNWEOAFmuTKt0HtXMKvIeSu9S2uaSpyN9lPxhrcuKwPw67X/iqoh19CnzH?=
 =?us-ascii?Q?V3i6MgLIfVfR2LKs9aLs6SW5fYfIdIsMHTCQXpcPyH16EushBQZNBDaW+PrN?=
 =?us-ascii?Q?iCR4HWrXvwXJ2mfvo4QI4OQ6Xv+Mhc/rquSi5YWGaoVkmNEtuiITGApBjWqL?=
 =?us-ascii?Q?HVxhRv93u7ZUqurew86gcxZsBoTRYuFsDYdd3i7Nxr20sgkxQeA/y8dG0nW5?=
 =?us-ascii?Q?mRqQREoGxe2Mi2913yRIzSfWfeq8XEjYfF+cEDsAF6U2kGTnkgO+DVz+DigK?=
 =?us-ascii?Q?LJYO912HF5CFN3lM9vIU50EISdqRsGzMu+aGxgbI0woiUj0rbDtlGhZr72Wr?=
 =?us-ascii?Q?yPs0iN+1HjEfc3q41V4P4swpsR458OKda6pFWsaksF7ELoGhKK1xMI3VEUoA?=
 =?us-ascii?Q?LQSzhodKlgDK7/ymcIOV7/0ReI40QiFjUBM1iDHU70HpfJqFI3cMFagH89oq?=
 =?us-ascii?Q?sA/bwgr4FhMMX1saR6qmajOZm2yTTM3QbXBPF6oLIFyDJsWNTSi0WBtMDKwL?=
 =?us-ascii?Q?hZkseh7b5S/vWMHaD3K+SbjINnkdk6M337vJAGP4oxMMuwNJzwP1p9UdEpCD?=
 =?us-ascii?Q?c1hDTnStMnsQgZmuERG43PQHGYtvEJRF/6gJMJXD66DHmGwR5N7lsyXWdIlt?=
 =?us-ascii?Q?gOZ6gasyxmiF4/dc6SmJYuLnYeoWeRe+Eq+x3Y4jFopE3O98bCDyAkTp0V+q?=
 =?us-ascii?Q?VVa0Pm+ibx2YjM8fX6Xo+Olafy5X5u4eT62pRxLysBlkhy1RYpZn3dyFFA5O?=
 =?us-ascii?Q?1rEVnyN24yp8u2xrEUIA35OHNEc8Xjt9BbYP0+iUymFi/I7pB0Hph5gbElSh?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef27e3c-a98b-47ba-edb1-08dad7f61893
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 01:55:21.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGFjgir6plS+j0qOhzYFrV8+Rt4ReBg3zWjj3F698R7XVn/J6sq2+Tzgn6+FF0LXqkv0AhXla/CxD6PLK0TGqTlbZu1GYSD+hB4pnvF0Zps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> This adds support for handling background operations, as defined in
> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> can run asynchronously in the background, these are limited to:
> transfer/activate firmware, scan media, sanitize (aka overwrite)
> and VPPB bind/unbind.
> 
> Completion of background operations, successful or not, can be handled
> via irq or poll based. This patch deals only with polling, which
> introduces some complexities as we need to handle the window in which
> the original background command completed, then a new one is
> successfully started before the poller wakes up and checks. This,
> in theory, can occur any amount of times. One of the problems is
> that previous states cannot be tracked as hw background status
> registers always deal with the last command.
> 
> So in order to keep hardware and the driver in sync, there can be
> windows where the hardware is ready but the driver won't be, and
> thus must serialize/handle it accordingly. While this polling cost
> may not be ideal: 1) background commands are rare/limited and
> 2) the extra busy time should be small compared to the overall
> command duration and 3) devices that support mailbox interrupts
> do not use this.
> 
> The implementation extends struct cxl_mem_command to become aware
> of background-capable commands in a generic fashion and presents
> some interfaces:
> 
> - Calls for bg operations, where each bg command can choose to implement
>   whatever needed based on the nature of the operation. For example,
>   while running, overwrite may only allow certain related commands to
>   occur, while scan media does not have any such limitations.
>   Delay times can also be different, for which ad-hoc hinting can
>   be defined - for example, scan media could use some value based on
>   GET_SCAN_MEDIA_CAPS and overwrite has predefined values based on
>   pmem DSM specs[0]. Similarly some commands need to execute tasks
>   once the command finishes, such as overwriting requires CPU flushing
>   when successfully done. These are:
> 
>   cxl_mbox_bgcmd_conflicts()
>   cxl_mbox_bgcmd_delay()
>   cxl_mbox_bgcmd_post()
> 
> - cxl_mbox_send_cmd() is extended such that callers can distinguish,
>   upon rc == 0, between completed and successfully started in the
>   background.
> 
> - cxl_mbox_bgcmd_running() will atomically tell which command is
>   running in the background, if any. This allows easy querying
>   functionality. Similarly, there are cxl_mbox_bgcmd_start() and
>   cxl_mbox_bgcmd_done() to safely mark the in-flight operation.
>   While x86 serializes atomics, care must be taken with arm64, for
>   example, ensuring, minimally, release/acquire semantics.
> 
> There are currently no supported commands.
> 
> [0] https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/core.h |   3 +-
>  drivers/cxl/core/mbox.c | 213 ++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/port.c |   1 +
>  drivers/cxl/cxl.h       |   8 ++
>  drivers/cxl/cxlmem.h    |  55 ++++++++++-
>  drivers/cxl/pci.c       |   4 +
>  drivers/cxl/pmem.c      |   5 +-
>  drivers/cxl/security.c  |  13 +--
>  8 files changed, 282 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1d8f87be283f..2a71664a0668 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -69,6 +69,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
> -void cxl_mbox_init(void);
> +int cxl_mbox_init(void);
> +void cxl_mbox_exit(void);
>  
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 35dd889f1d3a..bfee9251c81c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -10,6 +10,7 @@
>  #include "core.h"
>  
>  static bool cxl_raw_allow_all;
> +static struct workqueue_struct *cxl_mbox_bgpoll_wq;
>  
>  /**
>   * DOC: cxl mbox
> @@ -24,7 +25,7 @@ static bool cxl_raw_allow_all;
>  	for ((cmd) = &cxl_mem_commands[0];                                     \
>  	     ((cmd) - cxl_mem_commands) < ARRAY_SIZE(cxl_mem_commands); (cmd)++)
>  
> -#define CXL_CMD(_id, sin, sout, _flags)                                        \
> +#define __CXL_CMD(_id, sin, sout, _flags, _bgops)                              \
>  	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
>  	.info =	{                                                              \
>  			.id = CXL_MEM_COMMAND_ID_##_id,                        \
> @@ -33,8 +34,13 @@ static bool cxl_raw_allow_all;
>  		},                                                             \
>  	.opcode = CXL_MBOX_OP_##_id,                                           \
>  	.flags = _flags,                                                       \
> +	.bgops = _bgops,						       \
>  	}
>  
> +#define CXL_CMD(_id, sin, sout, _flags) __CXL_CMD(_id, sin, sout, _flags, NULL)
> +#define CXL_BGCMD(_id, sin, sout, _flags, _bgops)                              \
> +	__CXL_CMD(_id, sin, sout, _flags | CXL_CMD_FLAG_BACKGROUND, _bgops)
> +
>  #define CXL_VARIABLE_PAYLOAD	~0U
>  /*
>   * This table defines the supported mailbox commands for the driver. This table
> @@ -63,7 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
>  	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> -	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> +	CXL_BGCMD(SCAN_MEDIA, 0x11, 0, 0, NULL),

One of the recent revelations with this patch:

https://lore.kernel.org/linux-cxl/167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com/

...is that commands that are not meant to be called from userspace
should simply never appear in CXL_CMDS nor cxl_mem_commands. The
motivation for defining SCAN_MEDIA and friends was to use their
definitions to block the RAW command passthrough, but ironically that
enables the ioctl path which is also unwanted.

So I think this patchset first needs to mark those uapi command numbers
deprecated. Then ensure that all other background commands can not be
submitted via the ioctl path. 

>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
>  	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
> @@ -145,6 +151,136 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>  	return cxl_command_names[c->info.id].name;
>  }
>  
> +static unsigned long __maybe_unused
> +cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode)
> +{
> +	struct cxl_mem_command *c;
> +	unsigned long ret = 0;
> +
> +	c = cxl_mem_find_command(opcode);

Per that change above, cxl_mem_find_command() is only for the uapi.

> +	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
> +		dev_WARN_ONCE(cxlds->dev, true,
> +			      "Not a background command\n");
> +		return 0;
> +	}
> +
> +	if (c->bgops && c->bgops->delay)
> +		ret = c->bgops->delay(cxlds);
> +
> +	return ret * HZ;
> +}

In general I worry that this is a bit too flexible. Instead of callback
ops I think this wants to be straight line code with something like a
poll_interval argument in 'struct cxl_mbox_cmd' where 0 means the
command is immediate and non-zero is a number of jiffies between
background operation polling intervals.

> +
> +static void cxl_mbox_bgcmd_post(struct cxl_dev_state *cxlds,
> +				u16 opcode, bool success)
> +{
> +	struct cxl_mem_command *c;
> +
> +	c = cxl_mem_find_command(opcode);
> +	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
> +		dev_WARN_ONCE(cxlds->dev, true,
> +			      "Not a background command\n");
> +		return;
> +	}
> +
> +	if (c->bgops && c->bgops->post)
> +		c->bgops->post(cxlds, success);
> +}
> +
> +/*
> + * Ensure that ->mbox_send(@new) can run safely when a background
> + * command is running. If so, returns zero, otherwise error.
> + *
> + * check 1. bg cmd running. If not running it is fine to
> + *	    send any command. If one is running then there
> + *	    may be restrictions.
> + * check 2. @new incoming command is capable of running
> + *          in the background. If there is an in-flight bg
> + *          operation, all these are forbidden as we need
> + *          to serialize when polling.
> + * check 3. @new incoming command is not blacklisted by the
> + *          current running command.
> + */
> +static int __maybe_unused
> +cxl_mbox_check_cmd_bgcmd(struct cxl_dev_state *cxlds, u16 new)
> +{
> +	struct cxl_mem_command *c;
> +
> +	/* 1 */
> +	if (likely(!cxl_mbox_bgcmd_running(cxlds)))
> +		return 0;
> +
> +	c = cxl_mem_find_command(new);
> +	if (!c)
> +		return -EINVAL;
> +
> +	/* 2 */
> +	if (c->flags & CXL_CMD_FLAG_BACKGROUND)
> +		return -EBUSY;
> +
> +	/* 3 */
> +	if (c->bgops && c->bgops->conflicts)
> +		return c->bgops->conflicts(new);
> +
> +	return 0;
> +}
> +
> +/*
> + * Background operation polling mode.
> + */
> +void cxl_mbox_bgcmd_work(struct work_struct *work)

Is a workqueue needed? If the goal is to make it so that all the kernel
background command use cases chop up their work so that one command can
not monopolize the mailbox for a long amount of time then the
implementation can also assume that foreground commands that collide
with an in-flight background operation can just wait synchronously for
their time slice.

That makes the handling simple, acquire lock, poll for completion,
and everyone else just queues up on the lock.

> +{
> +	struct cxl_dev_state *cxlds;
> +	u64 bgcmd_status_reg;
> +	u16 opcode;
> +	u32 pct;
> +
> +	cxlds = container_of(work, struct cxl_dev_state, mbox_bgpoll.work);
> +
> +	dev_WARN_ONCE(cxlds->dev, !!cxlds->mbox_irq,
> +		      "Polling mailbox when IRQs are supported\n");
> +
> +	bgcmd_status_reg = readq(cxlds->regs.mbox +
> +				 CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK,
> +			   bgcmd_status_reg);
> +
> +	pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, bgcmd_status_reg);
> +	if (pct != 100) {
> +		unsigned long hint;
> +		u64 status_reg;
> +
> +		status_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
> +		if (!FIELD_GET(CXLDEV_MBOX_STATUS_BACKGROUND_OPERATION,
> +			       status_reg))
> +			dev_WARN(cxlds->dev,
> +				 "No background operation running (%u%%).\n",
> +				 pct);
> +
> +		hint = cxl_mbox_bgcmd_delay(cxlds, opcode);
> +		if (hint == 0) {
> +			/*
> +			 * TODO: try to do better(?). pct is updated every
> +			 * ~1 sec, maybe use a heurstic based on that.
> +			 */
> +			hint = 5 * HZ;
> +		}
> +
> +		queue_delayed_work(cxl_mbox_bgpoll_wq,
> +				   &cxlds->mbox_bgpoll, hint);
> +	} else { /* bg operation completed */
> +		u16 return_code;
> +
> +		return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> +					bgcmd_status_reg);
> +		cxl_mbox_bgcmd_post(cxlds, opcode,
> +				    return_code == CXL_MBOX_CMD_RC_SUCCESS);
> +
> +		put_device(cxlds->dev);
> +		cxl_mbox_bgcmd_done(cxlds);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mbox_bgcmd_work, CXL);
> +
>  /**
>   * cxl_mbox_send_cmd() - Send a mailbox command to a device.
>   * @cxlds: The device data for the operation
> @@ -153,6 +289,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   * @in_size: The length of the input payload
>   * @out: Caller allocated buffer for the output.
>   * @out_size: Expected size of output.
> + * @return_code: (optional output) HW returned code.
>   *
>   * Context: Any context.
>   * Return:
> @@ -167,8 +304,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   * error. While this distinction can be useful for commands from userspace, the
>   * kernel will only be able to use results when both are successful.
>   */
> -int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
> -		      size_t in_size, void *out, size_t out_size)
> +int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode,
> +		      void *in, size_t in_size,
> +		      void *out, size_t out_size, u16 *return_code)
>  {
>  	const struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  	struct cxl_mbox_cmd mbox_cmd = {
> @@ -183,12 +321,53 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>  	if (in_size > cxlds->payload_size || out_size > cxlds->payload_size)
>  		return -E2BIG;
>  
> +	/*
> +	 * With bg polling this can overlap a scenario where the
> +	 * hardware can receive new requests but the driver is
> +	 * not ready. Handle accordingly.
> +	 */
> +	if (!cxlds->mbox_irq) {
> +		rc = cxl_mbox_check_cmd_bgcmd(cxlds, opcode);
> +		if (rc)
> +			return rc;
> +	}

Can't happen with the straight-line approach as all an interrupt will do
is wake up a wait_event_timeout() instance for the currently executing
background command.

> +
>  	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
> +	if (return_code)
> +		*return_code = mbox_cmd.return_code;
>  	if (rc)
>  		return rc;
>  
> -	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
> +	switch (mbox_cmd.return_code) {
> +	case CXL_MBOX_CMD_RC_BACKGROUND:
> +	{
> +		int err;
> +
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x: %s\n", opcode,
> +			cxl_mbox_cmd_rc2str(&mbox_cmd));
> +
> +		err = cxl_mbox_bgcmd_begin(cxlds, opcode);
> +		if (err) {
> +			dev_WARN(cxlds->dev,
> +				 "Corrupted background cmd (opcode 0x%04x)\n",
> +				 err);
> +			return -ENXIO;
> +		}
> +
> +		get_device(cxlds->dev);
> +
> +		if (!cxlds->mbox_irq) {
> +			/* do first poll check asap before using any hinting */
> +			queue_delayed_work(cxl_mbox_bgpoll_wq,
> +					   &cxlds->mbox_bgpoll, 0);
> +		}
> +		break;
> +	}
> +	case CXL_MBOX_CMD_RC_SUCCESS:
> +		break;
> +	default:
>  		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
> +	}
>  
>  	/*
>  	 * Variable sized commands can't be validated and so it's up to the
> @@ -575,7 +754,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  		int rc;
>  
>  		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LOG, &log, sizeof(log),
> -				       out, xfer_size);
> +				       out, xfer_size, NULL);

In the above referenced patch I fixed up cxl_internal_send_cmd() to
derive all its parameters from a passed in 'struct cxl_mbox_cmd', that
should make it easier to add new parameters.

I'll stop here until we can come to consensus on how general this
solution needs to be. I think this really wants to have a single
background command use case in mind to answer some of the use case case
questions.
