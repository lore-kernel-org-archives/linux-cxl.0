Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E891C05027
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 18:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBBSSr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjBBSSq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 13:18:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F7B68AFF
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675361925; x=1706897925;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6iiNZBvlvP+fcE2FYzw430DHAXn44ih2o2fSDxphTsI=;
  b=il92qro6qAR9FnwM008x3Np1rPxAZlMPZKMC6dTuBOxAlpvgN4Q0ZyeX
   lLsNvR7/AliyCIAe+qZCNlJlZ4HrmY9dFteH8pDJCPCmLwBlwIc7JZ2ye
   LiOc84drzNRKWdCuKR5G2bYmkSePjXhSfo1S+pzcSIOO+6agxo9TKoJ0J
   xaL6oJOZWPJ2RLKXmu9lSvR5kBe23nBnw0oXcy4eopQ6ldC+delOuNNBr
   +dCnJt/Wcf+rT3V/rHMSz1l/PwSZsRZI2FJcup9juYTtdt3iksHVp2iSs
   tkfdwSqqE8AnU40wFkGL7CUn8Wbp2kqYYwr0Ey9S1aMyvLxjK7biHdGyR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="390917185"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="390917185"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 10:18:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839301723"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="839301723"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2023 10:18:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 10:18:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 10:18:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 10:18:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 10:18:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd4M6nGeYVW/1DzHxRxqfOmiOrpXAx5CeUx2IN7JgLyJmwMYQnKsvffF4XfyXZyVfTF/wavBz1sFEipQiKebyBIYCZ1/9N/HmMAI/NVo1i1W7aGKyPliYfjJbBbzMEbJRxETlNSFvfUXunGP0k16kPSpXfdxEIhYP9gSurFvpQabX4WyCYf6cc57J5/d95zEPyHDF6FRuCquzu8zeifwiq2gPRW8Z96eNKCsal+w3+Ki3MDv00ZHlnI9eyGBtc+dRMFdnXHAs/rULKnXDbc7sq9zEPUtxmFeH3mj3P+RMQiGlZPNB9NMjTuOEYi1bFQYYwcixGuJn8avy8BLd5d2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H61K7iG8Hm2Yo/0qnO3Vv3GtDk/Gn+xac+hU6jGCBFU=;
 b=BwQcC+YVs3mrcImsW4rZCeyH4gAdEJFnAW07dA/5kbFq9cy4uLl/C/5+J0eNfPnPsJq6TSkjqbKKM8opjHvMhNPtbefiBY80PtFc81YXZ6cArImUFYAobtSB12a1HDya3UwJVZYO/nfGgQDp5XPyI75wBGUXZGArjL8llxp/0H9TGZb/SPFC7CiSvi2SqoOQr5bcmRivwnIKibr9u6rUE2p1h+aAGaNee2c6t0vmutmOwA2/A2xJETgqGcLVmqmboVfRd0gxO/CWCcATwvzBudgT1EIcj3ue/ermEgKzMeYp4eRYVbvQhCr5mN+Eeq8AZo6LInRtGkyYDZo7+gwMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5799.namprd11.prod.outlook.com (2603:10b6:303:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 18:18:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 18:18:36 +0000
Date:   Thu, 2 Feb 2023 10:18:33 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <63dbfe79dbb44_ea22229468@dwillia2-xfh.jf.intel.com.notmuch>
References: <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
 <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
 <Y9meWfDiCGbca4nP@memverge.com>
 <Y9mhe2xPGRE1/7cC@memverge.com>
 <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
 <20230131235003.GA336751@bgt-140510-bm03>
 <Y9n4zjtwf+w6xnmW@memverge.com>
 <Y9rWskfaz9dLoW+l@memverge.com>
 <20230202160314.00002cfa@Huawei.com>
 <Y9riPw7ccA34FQG6@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9riPw7ccA34FQG6@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ecc4b5-1ba0-49f9-24f1-08db0549e69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uyi5Fo8zoZAYbpWUdEnI3f0zrvZJKPI82aGg6kvSKAnHPFG0AxzpvXlU31sFcqEAvwg7uBQwJucsmLRmAVfGdVWh22iNwn85fgkVKPw//nxAJhEzHR4KQoa6iSEJRlfLnxId9YgqBL55gDAVRdPxy1w/A6l0+344qEA7ss7IQc5tAVZBCnpF+FgeJMY5+i3esS9NfWWKuW9Zd9G4J9Py9EChSmpXr3HqiBcFGh+/yCebiWv6TgkEz7z3mQ20BLWNx+6Y/D+JkyjCYc/fodn+4yEOLY8TlrfldgW9frwP15rQvFtB19Ed5oTap8y7FnfsfI3oEmKkEnpt2l/AlMq6+y+EUX2RzNqlbvruVlpfs7ptl7+OuEoTZncGa06ZKDybcU+SDAudadyv0yArNTBsY1jHPJRqStW892+Bps855bvRcjtOXeG0spPRh2laEWmdcshuvxmT6Hyfsp9lA8piMs2vDQ/+VUGuCOwrppeoF7S92vK+mfbifodz/5Q+8wc213mecPP2VqwZBdjeOlKY68Zr6vVNoNGhgKmzqydulI6XVhdQDn95Aby1hANV4epeotVvDNqWQcTsKrWXdTUgdeLCj+N42+nqwahWJKIx+fRDb616GxiYUZ/cIsBcFApRtSkpG4P0aY1cGjpdaKPGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(2906002)(478600001)(6486002)(6506007)(26005)(6666004)(6512007)(9686003)(186003)(5660300002)(8936002)(86362001)(41300700001)(8676002)(66476007)(66556008)(83380400001)(4326008)(38100700002)(82960400001)(66946007)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5Fi2fuBbP4jHJOBRB0BySfUcM45rjruvDoGAEjKYwAiG8aAQqXmpHDupl6h?=
 =?us-ascii?Q?++gDYDV69gP6XYeOnMXmqWcKuz/u1i25zWz3CG05jUAIEWHdST16pC0IWcvC?=
 =?us-ascii?Q?U+dtZ74ouZf4z6WmUueZvj1eLg4fsp9Opj3OR13+iHGT3a+qYuEdUtR6uvHb?=
 =?us-ascii?Q?vfj+r/FY6ruoiPeHHLwzbEZqR1s0umRxXRXosshHzXy9XzGWeQofuaZrBPFF?=
 =?us-ascii?Q?q/KgvCrtFfw/q3Bheasc01cFuJZCrJww8Ez6Qt9y/K67qrpWN/sR8trtxwbE?=
 =?us-ascii?Q?eejOkHezPj1B/2iYAXNrIOiDTYK1Giuk+D3BApBJ4DcmKudcYW/BCzgTT4rE?=
 =?us-ascii?Q?oWx3VCSGS0e4FcebjI5uBgsgK6ODvoMEGFsCCgDgO6GKFVL4snzNtwGnMeXh?=
 =?us-ascii?Q?RyaXyjQwQ3rN4QJlgqrC2Hqx1b9mtBPUKiBAtl0rH+Pnbu9/3zC0UeDHPo/l?=
 =?us-ascii?Q?b8kCEF4XIivgRgx3mdoC6/RqKQGgx4JPHVlBFN4r0E5qbEQId84nvhyz6eCM?=
 =?us-ascii?Q?3jEYINSVdXpwODL6ZbH0KW0/dKEvsU/q7VjY0JKyuG0hsW0wTU9YdJH9Dt6K?=
 =?us-ascii?Q?TVF0UBEuNj+0aQQCPd6ZxMMZ/u9sHCF+6iJEsOs1wAtYw1GhDPVGtAINZcq1?=
 =?us-ascii?Q?QAcY6c3SfNbmAbG4U1MnpNUYi+9ylNyNiiAGZyE/5tyujbMUCTy5Kbvv5EVs?=
 =?us-ascii?Q?Ff4eJg8N16cnMIPuRz2/IuojUzyMOsqwRjj2P0B7BEmbulEmRWXYCY+Q52oR?=
 =?us-ascii?Q?aZfJ3H2vAUbqJdKCnQhyWcMcIEhIcwXkohzcFTogFfVbJwbKEN50syLF0QgQ?=
 =?us-ascii?Q?40Xp6e0SLz4IPEV9Nk3BLa8UohvMoQsmz6xwo/VT7YLxWHyTprvJ/JL/h0G3?=
 =?us-ascii?Q?QjzWZJ6HdatzrcLzLqYpBHmI2xpoM/WmF0a4hdFVTdHrGprYxS3341EnuSls?=
 =?us-ascii?Q?WEge28/zhOyEm+SVdk7Dmb7AFG6xnpZY7zIMSaeZjc8LrzJZsJbm1CvIIoVh?=
 =?us-ascii?Q?3Hz4i9SQzOW79D65/hrjATRo+wPhAHSoAk1yXzm1Ujg9LHfBWF9csiCJwo0V?=
 =?us-ascii?Q?D0SiUhfgniPJimSpOm+GYYfCkxtojUIvFMd7msnNUQFYzCh/7O7ATWWihn3u?=
 =?us-ascii?Q?1v9BKSM20FnSL/L1nc3QkY67EZzDZx6lOwxwRZi0XcydIfIgoEtz76dad88Y?=
 =?us-ascii?Q?qUCfJgYFr7A2vXHGOvOtfsyceMYil+qQUrLpaw4IZ6DHoLdTF1ALyt32RniL?=
 =?us-ascii?Q?apMJXBYw73Gbh7ENXEQPxYEComD/jw3fk4V8iCg+3H2AnOxCJvpuIc/vFd8j?=
 =?us-ascii?Q?cpxkKAJwuMzbFJD0MuHy2Cal0vdxgFTLRw+xO18uYs6sCGUiRiNKXvgkbfOY?=
 =?us-ascii?Q?zUPt9uirILDgCY0BqnI3+1GqvC/9MYmPPuQEfodoB3mVFfhZSCPCP2qtFcus?=
 =?us-ascii?Q?7gGay311Sys1G1VO4R9Q/tDaJ45kqFWuDcm74TADOs67pm9VcLcXo7lEJIHm?=
 =?us-ascii?Q?pHuxwSYBOYEXhvaUXr0D5TK5AfHCetZoyptO8n65vYIvEIduxdNh52qlTZvv?=
 =?us-ascii?Q?6KvD0+ermKXl0pYp/qMw4gN3CEX+80rgK74m83Mpr6h1d4s+TUepJlQ7PEyB?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ecc4b5-1ba0-49f9-24f1-08db0549e69c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 18:18:36.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLQl06IvSEOT5NYnjrp6tqeDsnr+ttll4NSpcQWLhkAnbgoVdhU1jC591/1tlbWqfpbkRw28CCiJe2cCpOox2XHSK3DDzGbOhSHoHyXgCyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5799
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
[..]
> Some speculation here:
> 
> The crux of the issue, as i understand it, is the invalidation path.
> MMIO doesn't traditionally have a mechanism to tell the caches "hey
> i got updated, boot this cache line", so whenever your compiler accesses
> MMIO it - at best - does a fetch-and-discard, meaning that instruction
> translations can never be cached.  That's the source of the slow down on
> the QEMU side, you're constantly re-compiling the translations.
> 
> On the KVM side, it likely requires a VMExit to handle the MMIO, and
> when it sees that it's an instruction fetch it probably just falls back
> to emulator mode to execute the instruction before re-entering.  Maybe
> there's a mild optimization where it continues executing until it leaves
> that MMIO region, but you're still getting QEMU performance over KVM.
> 
> So that all makes sense to me.
> 
> To me, the solution here isn't to change QEMU, it's to change the kernel
> to try to get it to aggressively keep executable regions out of CXL by
> marking CXL regions into a new zone type that essentially says "Use this
> as a last resort only for X pages".  But that would likely require
> adding migration code to the likes of mprotect and friends.

No, this can't be the path forward as far as I can see. QEMU is a test
vehicle for CXL enabling, there's no expectation that QEMU is running
CXL emulation in production. The quirks of how the QEMU-CXL memory
behaves are not something the kernel should worry about mitigating. CXL
is "System RAM" especially in the case when it is mapped by
platform-firmware. If it's not suitable to be treated as "System RAM"
then the onus is on platform-firmware to keep it out of the general
purpose pool.

> In the meantime, sure would be nice to have a userland program that
> grooms software to detect this problem and migrate X pages to DRAM.

As far as software is concerned it may not even be able to discern that
DRAM is DDR vs CXL attached. Something is wrong if that distinction
matters in practice outside of NUMA policy or dedicated device access.
