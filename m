Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C38C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 21:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjESVjJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 17:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjESVjI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 17:39:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89480E46
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684532337; x=1716068337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I7se53o8BHQu+772KOEkODc78lA5jZkYglK1OgaPV4Q=;
  b=iZF0QLvZitYnlZEzAr45sAMARAVpRpKO0GYyRU7Q+X0Jzo2yPhpyHcpp
   SR7FA7V8MeBWmVh45d9m2edgchIGUQeZ/amQcGKpvm54HwVI2ohNlH8Va
   r5Qi4OmObu2HmciPNF5M+iYTVIDcLANFxiejNtcI74tyMGDhvUJ9hzQ7n
   IsQul2SWwIT/lq04NghgD6s3+D3xOcbNmauY9l+4ndiTQT13a5++n65fe
   9E2SRhx5H8zCml8J9HaYbUMaaKSWbCsdXfP3ZODhGUlRVuv6jcc8GgXnc
   cNO7epBRhXn1pUGcZ6PM7I0F33vuiM8sM/dyHcnFo+NBDr1tprYEUqieB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="341938439"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="341938439"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 14:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="814876583"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="814876583"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2023 14:38:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 14:38:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 14:38:55 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 14:38:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVuYHCF0Ohr87cW/2l6mbJvGr+ci1GszhrpWYzvO7pc6GmlzfhOI0gmwCgag7oDWhhLbeTVJ/7J9A9Z5ljnzDYpdNo+uMMlX+mGI1DsHYwdp/31Dnan1b4Vfmb1v/noTt87p4yxhXzCyVUay6M6t5alucPjkyJOjzZv6oi5rfPSVyQlntIGUSGwig9NR5jLuWd0Ppsrbu8K+zS89YOwX06q2m7f0Fi7PiHL+XnikQQyP5wZ1PO3MkHLwxXuh1yHMu7k9hQQWK9CEitbPsa5LB7BefeLDDgQN+8hF07SGw10QvPv3PI0iCFPemZjLoIJt/Qd8mcpZ28larkHZOYLepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTiJ2dWFP1cOO3ZmUFPnArriDUQvT6J6xWLlVjwBvmE=;
 b=FTx7e9nq+xSyYNMuG0cCKqVGPZ7wud9OLoR0mBB3hpZNQTPPrYxpGwmnYuDyuAdUaTzk9euBZhbspR0qa37LwDTp9nGXROL+4H1jh1+OnXPcX/bRaxqdE/yzDtFII9YS7T00JfoPYxrVWrivkwx9L6ukkF/rZM+Klma/dxh0nZMnhcUQ7c5PYgOiV3egvDfENlJ95bCFJDanyOxxVkNuWE5pFVamuWB3qcTbw3dnCa2Tr/i2CIxQo2fRfBIccJCiVmyPrWLRQVGELGhoSrxDI/ICJ+HqjhzZljmj4K0wqBFId75a40Omkb6UX8glnqCBPX34DILhOvZJn9reYbtwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4647.namprd11.prod.outlook.com (2603:10b6:208:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 21:38:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 21:38:53 +0000
Date:   Fri, 19 May 2023 14:38:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>
Subject: RE: [PATCH 1/3] rcuwait: Support timeouts
Message-ID: <6467ec6ae116d_682c12942e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230502171841.21317-2-dave@stgolabs.net>
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 528e1436-f69f-4061-4a20-08db58b170ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /i9hiBn7i2ZMJv/ZbmktieXCkmRyQbtf/Z0AEK7o8EFuip7VkHppGmou3d4YOCeYxJ+rmdkkYf80SoFcQOVQWLk3ctHDfycv3F5mM3z5H+i8rN0iccqq4USVRClPKcGomtlXAZaeTHuVW+l3CkkJ/NZlD9Ug3jT2C34WWAa85u795WEh8SMcXuXwY1HXT+z2mE5dE/AtpsKGRd1O+G6CYOB80z3itKqC+zEQiFsrZd0+IDN21JG5jCcjACzi0NRTKKuPPbUROYHec6c9ItADOQVYNscdekZuzSjO7DHBU1Awb+8edEWB6DTqQ/1mDMQcGKRNEIfv+Pj+kyG68Nw0QFufGZHnhbHSS40O+xjMR0zY0JodBH3gZ4feLiumyZkXcFn1VjKZBvaqLFKkhBI/pN5bmkP1kUVZiwY+3UQqhidKwd2p0GJ76cSUUALb6ODHv/LdTgHBO53IIW7e/DYjtCf/RrwIEaFTC0yL+inMTZCBFjeXxpefDTY4k0WY9hDkbfy6HmVdmyqsi78P0Sl8Ex+gzr/khKbbFU7L2czM1C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(2906002)(316002)(478600001)(41300700001)(8936002)(8676002)(4326008)(6486002)(5660300002)(66946007)(66556008)(66476007)(966005)(6512007)(26005)(9686003)(6506007)(82960400001)(38100700002)(186003)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qpOuYresGvBN2E2AoTod0T2Rlx8Vpzto/fDv6KWvi4+fJjvOf7BDRAl3BMm1?=
 =?us-ascii?Q?XFqhstxO5YbVQPK1wsGMITl9/9lm1qComTSK0C6R4vvWwaxADFZdt4cPN7t9?=
 =?us-ascii?Q?//SgmXhtoBzarsiC+EQsL/i7+3wZRCIA0wLdYSOU5a6TS1LV4/TInE8izTq1?=
 =?us-ascii?Q?Ii49yIJUh0nrPIdkcEEdWCpon8XPvEF/ZaoBppIsiPeoSg8lhE9LZbevMilL?=
 =?us-ascii?Q?hNt/r0/IJqVbZ6MJbeOThpYxzXcyZSxfhXkReEljgZMVsMHlg3in6EBaVqSr?=
 =?us-ascii?Q?pkGZOOQ2/Ny69sWOWBVvUkoOPOLon98Q82Pg/u3Zf+x70jXhQOv+hSFjCJ+b?=
 =?us-ascii?Q?hEUfPa9Okm5r++4bZ6XIhSSVAo6t/5eTTKDx+oGVJEM5xGWIr/K/ry94N3/e?=
 =?us-ascii?Q?JuNuODieLQ3ivkLy9p4Z1TBPcRQ+cE453DouDGGvhHB62fW2UudBvpf81jtw?=
 =?us-ascii?Q?qt+ieb4mJCCGtYTfXypRpbDpy/SBR1MqMYDOcUosPJlsSMubBFg5IsDXGDxq?=
 =?us-ascii?Q?GLCKP/7UYAP0haHT4neW2RJXgMrVN+F35l62Seqz+DezT4ofODX0iNIzy63x?=
 =?us-ascii?Q?kh1eQ0wK/dKEkKQYCoMAwYFpf0mcvhb7qy1X/JGKyNQMtzUWapQuRRcuk96F?=
 =?us-ascii?Q?RPnMzcDFBhCu1gk/0zLQNirfwq2YeMbvvjwHC1tkfngsttiFm39C87f6ySBp?=
 =?us-ascii?Q?8bcWMaclZuKqVyvn39NSXC4qaweMf668ZwVfHDTHdNl2UrNczdsAAQhuF2RU?=
 =?us-ascii?Q?k2I3kQSbUibKypEvgfMDMWGKILdLJv0pWCCY5giyNs7ahYIglKzy+DoBrUt7?=
 =?us-ascii?Q?7/bc+NaQN6FUl8Cs/t+dJ09N0biHyivbbXj3gqOUb1fxXV2qaJOl18mZM4Xd?=
 =?us-ascii?Q?rT2ZBurijaHHxr8oWqY4/OVALcfyoHA2peyHEgqcfYy1jDd9cHclomB55lT9?=
 =?us-ascii?Q?biR9s0H0EwZn0qtspaW/Y5QXXU+FT9FFaZveD1Zv8ufa1zlewDDCfhvprQY9?=
 =?us-ascii?Q?b/ijL6TcJoFFiwOaTpqdnXIUinxBZPgVzXLitYYU5fZmRA6GpiU+7kCw8m71?=
 =?us-ascii?Q?xjQRzP6rIkOHKiCFxBNFL6OpbtGlgccX8/YROGMPe4LNR5q1eVSQdbXHpwSN?=
 =?us-ascii?Q?cPoZOML+8EGW2nsODrDdQY8rAZR5ZXDEMBtKREGLtgJFJU5w0qPQXpmubcbZ?=
 =?us-ascii?Q?RIQAc6xKvnjrhCfGL5ek1gj1oybnEp8lRJz0XdmFp/hyEZ3YOvMzEnjCMCYF?=
 =?us-ascii?Q?vAYWktKy/cn+/qwdFwl9OCJuJs401wsJY+xWi35dVjq7eC4fuDdWmcro2PUH?=
 =?us-ascii?Q?lMciaftP//rGv/F7MiwXrTG547Zb4Hwhg8C+xATSwEVdm2TsGndBLSuqhux9?=
 =?us-ascii?Q?75fOyZ4eShANF7mq7dIFyW1HL8AUvMGrcazHEJUjQRFw/B0bjhU0CPjU+hC2?=
 =?us-ascii?Q?BgHbWEErfBDHc1rAQmECIGbA0wEUbt/qsRPeojWce5CNly8ENsiNRAKgLboC?=
 =?us-ascii?Q?9JVk5YKpsP9G1rtqjEYrUNJIovtg1GKjVsuQhehLIIg5DiNRh4VrnrtEzU8m?=
 =?us-ascii?Q?BYZqkehjhRbgnM+cO1vlG3yd299mn/rvVkscvc6bJB8eC2kx3X9r3nCgVWS9?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 528e1436-f69f-4061-4a20-08db58b170ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 21:38:53.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxVOIHS+YPcrmUlhi/zSi8u7nlEXVXlMFEs2Mm6v+7GOQSUOWGLJfJ4nKb80NEamP9dQydZMIOMzVhGOCM/Qr2w5i2h76wseMm5h1aajayw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4647
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Introduce rcuwait_wait_event_timeout(), with semantics equivalent
> to calls for the simple and regular waitqueue counterparts.

So my first reaction to this is "what is rcuwait, never heard of that
before?", and "how did Davidlohr find this facility and why does he
think it suitable here?". Then I go to read the history to get smarter
about this thing and the author is: Davidlohr Bueso <dave@stgolabs.net>,
aha!

The critical insight for me was:

https://lore.kernel.org/all/1484148146-14210-2-git-send-email-dave@stgolabs.net/

...i.e. that rcuwait is suitable for waiting for a condition to fire
while holding another exclusive lock like a mutex() as is the case with
the CXL mbox code. Did I get that right?

My recommendation would be to include some text like "Recall that
rcuwait is suitable in this scenario because..." reminders at least
until more driver people understand when and how to use it.

> Cc: peterz@infradead.org
> Cc: mingo@redhat.com
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Only cc'ing sched folks this patch to avoid spamming. fyi the actual user
> comes up in patch 3 (cxl/mbox: Add background cmd handling machinery),
> but found a few other potential users in various drivers, so more could
> be added.

FWIW this looks like a straightforward addition of timeout support to
rcuwait_wait_event() to me.

What acks are required to take this through the CXL tree? Or are you
the rcuwait maintainer?

> 
>  include/linux/rcuwait.h | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
> index 8052d34da782..27343424225c 100644
> --- a/include/linux/rcuwait.h
> +++ b/include/linux/rcuwait.h
> @@ -49,9 +49,9 @@ static inline void prepare_to_rcuwait(struct rcuwait *w)
>  
>  extern void finish_rcuwait(struct rcuwait *w);
>  
> -#define rcuwait_wait_event(w, condition, state)				\
> +#define ___rcuwait_wait_event(w, condition, state, ret, cmd)		\
>  ({									\
> -	int __ret = 0;							\
> +	long __ret = ret;						\
>  	prepare_to_rcuwait(w);						\
>  	for (;;) {							\
>  		/*							\
> @@ -67,10 +67,27 @@ extern void finish_rcuwait(struct rcuwait *w);
>  			break;						\
>  		}							\
>  									\
> -		schedule();						\
> +		cmd;							\
>  	}								\
>  	finish_rcuwait(w);						\
>  	__ret;								\
>  })
>  
> +#define rcuwait_wait_event(w, condition, state)				\
> +	___rcuwait_wait_event(w, condition, state, 0, schedule())
> +
> +#define __rcuwait_wait_event_timeout(w, condition, state, timeout)	\
> +	___rcuwait_wait_event(w, ___wait_cond_timeout(condition),	\
> +			      state, timeout,				\
> +			      __ret = schedule_timeout(__ret))
> +
> +#define rcuwait_wait_event_timeout(w, condition, state, timeout)	\
> +({									\
> +	long __ret = timeout;						\
> +	if (!___wait_cond_timeout(condition))				\
> +		__ret = __rcuwait_wait_event_timeout(w, condition,	\
> +						     state, timeout);	\
> +	__ret;								\
> +})
> +
>  #endif /* _LINUX_RCUWAIT_H_ */
> -- 
> 2.40.1
> 


