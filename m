Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9AFC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 22:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJMWrp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 18:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJMWro (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 18:47:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC98A156265
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665701262; x=1697237262;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XWPEJtmvebi6hpe6OF9zkdH9SmY/ESzQOMMWzQmDqgI=;
  b=CKc3nklbc4bsuSR0CaiWQMsbsQJlbLxDXgV0pPxgOsHx02wOrCwOoPCk
   FLi3L1bQmxzh+o2802qQqMLBew3/97M729EtUUoNhwtpC7lPvX0zX7CMD
   stRZ11Veh1m27+ff9c96XzLHS/gs2W7uDtRyTFBW5GJo2OwsqLqvGzRkC
   VFbdGX75rmjz8YaYYBxlYKkfavjo3PjXjBZeV5L3ktC7ibihNoKctfMPN
   PbqtwXDdLPUm8auTKWQT/zLRIIY/a+GMbky/Fp845+uO8NrgQs41nmK7r
   9G6BJU1boMXl/JkntaltCnApdj01T5/e3bzfhtR9igHzv9Rt/yCpNh7Vd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="284951497"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="284951497"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 15:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="769808039"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="769808039"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2022 15:47:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 15:47:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 15:47:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 15:47:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 15:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwaRnQLiasKHE5BPubdpEpiuazO3rFJ5RxVVyVAAkNJJ3uIJvrlzmK1Gk6RrRE+EkhUTa3mqOPJQpcBL1Tvnk77DmlCyfIbNYnMPQw9Ecqz798/KKM6eW+yIc0yzBPDJjphEpVPCvnlraZz6P8TMr2DGrj18X9Zs5c2/r/BOyyevSHiZXKgaXgeZ8aeSx21+4/YwXc34Vp5NXzhJZo4tgjbA8/sSPOZlzDkkKkRoP17bk50foV5kyCY4s5wcuip875z6Qy0nhojRLbn4KrK8U/jXE+pKJlvEUsxEzJigFzgIW2EvumkoNJC/ouNRyeB2eI7xtAyKWI/WT+PmlbGG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGiD9v0iZwGvrCctGVe30kF/GIacyE4K/CF3Hm1watY=;
 b=JDPx0Bzg2nWr17BvZwOeZCWH60SeQv0o1QZwivz7Nyp4eVRqYj0g/IOaaTHRv9k/c41gdO+0Q7mC2GqUH92IRqBfDWYPprjMxQuoilgXURiOrihXYDA+1kgw3L1Uh1MttnPS/kdIY0/H00E9FrhWibney/5LT/lkT2zdGa1OAnUEr3kaz9nrj1IbPorYJakG+eOmzCaGujUIoYAFmVoguhXctpGZghQozLvQTE3XRkxyWUuIf8VicsVKDzn+nlOeVSS1JNpOl4An6rKZKANb/Dgwc300tdsVp6fgREAVlIQpPS7odw0+87TNhDXqJQsW8fqNtLMrMdDUB5nWv1G/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 22:47:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 22:47:39 +0000
Date:   Thu, 13 Oct 2022 15:47:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Maydell <peter.maydell@linaro.org>
CC:     Richard Henderson <richard.henderson@linaro.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] qemu/bswap: Add const_le64()
Message-ID: <Y0iVhkrxvR0r4PSN@iweiny-desk3>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
 <20221010222944.3923556-2-ira.weiny@intel.com>
 <CAFEAcA9yVKWCZ-PhCbHqpaEW7Tgtqoo=wSQLy6=U5yfq2uVfPA@mail.gmail.com>
 <05ed1f6a-0771-798c-408b-272fb57b4582@linaro.org>
 <CAFEAcA-M_4Srp2=9OwG81DGCxo08fJRnxBY6+NEUn6j1idiB7Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-M_4Srp2=9OwG81DGCxo08fJRnxBY6+NEUn6j1idiB7Q@mail.gmail.com>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ee92a5-f2bf-4607-795a-08daad6cee90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMa0t6+WQNUa4jlKG0pzqWDEidUH3jYsusSJtTh0qqzER9fSdc3W+X5mJgSSNy2gUks+rKjdG6uLdXd+NJwQ65N2tnaAFGJwD55eL4uOEq9n1X5YSgUu01y7BRSHv3u9c7A7sEqS218kFpZUmdDxAmeBCbquKiEjldoB7N9qNb9qDoTiPWzTWtqCU60J+iAQvgnJG2Hhhlykr12ETu8VBMdpwCvk8uAOkJdciCQOqnvHVW27gwsI5UWQndY+uFq+8+DaMv3h94eHdpNUtnpUPCqm8R85e6YTPLebBKVK12sH504a/YnxyRjkoivB3+U2nY4vdrYTNDZ3KBT8sESfllq4O66TSQtMHIHxv2XoE4bXsjslojkHI+4op6uEjQRz3ZdwPXPnnalDu/hN7y+gGDiAwPEW/AwfMIWDL8Z37g1tAaqMXkbie3q3cII4f4fjZCiAPWxenBp4q9BJeDfrhz09bCW7XUWhuhy83mHITyJypqjJ6U0go2pO1bigP6OBXo+pUpHALgHi/+d3JT/MpOSbtqj9gYWyQdx5LioKlLcFdof2wPBUuGCWpH3de/ENeP1Dk9F+5AcmfyMBwkw8lRURULfsig+jryOCdasHnI5AkeLaDpMOIUhk3JX7JCKoTq+lje1CTEBK62o8/+upbim11JsuXiPLRZRbvxRmFkeTHhZn23BzfdacuhThIaZ2Br5a8/rodID0fQWdFsJ9Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(478600001)(316002)(54906003)(6916009)(66946007)(6666004)(6486002)(4326008)(8676002)(66476007)(66556008)(6512007)(9686003)(8936002)(26005)(41300700001)(33716001)(44832011)(5660300002)(186003)(6506007)(2906002)(83380400001)(82960400001)(53546011)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1jLiyzfdDTYO+qVh/3nPuWifFiLpjCQeKvSe747Kcl1APdW3F3V8/NktlbSC?=
 =?us-ascii?Q?qOY05FgRGQB77SkuTwTy0b62GQfOOn8m+LETaw7DND4R24MX+GiGhVmweEvG?=
 =?us-ascii?Q?RI2j4G+2P6+k52Gpz9RaxQ3xTQK3XBPW6UywOsWi6HceGsWAS2x+jPmFzyRv?=
 =?us-ascii?Q?s7TvggN25K/WyhJbpbiD0/w6/yv7rdp4JW0tFZ4KGiOf33VRsJho41InwxzY?=
 =?us-ascii?Q?5cUpbi7D2nbeOoxTh9qQKFxj7g4NZ/LK2b32qUzDOYjSug31sckLXV4siseb?=
 =?us-ascii?Q?Tnm2NWNsfMFlTqt883IxMUZOc0roeAI+CNsSJZXLh9Dbs9vmQ7ZWIJ/H06JG?=
 =?us-ascii?Q?C6S6nyIK/XTn3vwhNLiD9otQntpXMJY504fV00Megxg0ak4QSf+JE7K1h+xb?=
 =?us-ascii?Q?/+WZMEigPF9lEREQnf4M63BKKn1RcocDDaMx7d1Da9Lm5ahmaDQhjFRmdign?=
 =?us-ascii?Q?w2Kc63pRm4kp8ON6DnUwHYEkHxVnvqjc1lNQ/6r9ziMVEwm28MXWvbECX7hc?=
 =?us-ascii?Q?rMnWaf+WMjwrMuW2a/2nYUVw+uF/TaOp1+iBu5/Zm25NT5xDSegwlQlEOC0V?=
 =?us-ascii?Q?RBPxCP8BWWFVuh+SgjCYs51wallOa5bQ+JHDr7TxyVEgVFgG9oVsbPIw8bef?=
 =?us-ascii?Q?IztO3BSO0I+6RBuU0sCvMhDWZGZGMW9MC0/QAgFpxPaoWeyFw1BsjkaZTdWn?=
 =?us-ascii?Q?QXwSH48i49SlORp6P+evMKF17gHrZRvoLy0yNNcohBoYGOkS+iPtvcvel2/M?=
 =?us-ascii?Q?HL9gwVMYGMrTcjCQSQ11ovP5NkzbYuLIfPfQPhgov9wm6yRtDq95hkRGb3d8?=
 =?us-ascii?Q?ciLqSALN79F86RSS717xB1zkiv8w9KdpOlAgBe4xuaydlfd3g5L6Q90ohtve?=
 =?us-ascii?Q?SBM4+uyFpjTiIPblu/YCVUVhy1vpw1OMt1nO8TNOLMX4+BBnQSnOzbHkjrM3?=
 =?us-ascii?Q?sWjY6oG7NimN6LihekHIWlqg8UZGbmIFjXV3cceHTpBdaScUpaNV8hU1706H?=
 =?us-ascii?Q?E3epGAcntDJqT85V/FB/kOg1vG6qQRFs/P+SMMpIOVTOTSLlw/NFElkSI+r4?=
 =?us-ascii?Q?QpOLU61S/C9inEdoOkwk9laDMToFiouE8uOMPHqZzi+h+txZtr2JPW2+uxU9?=
 =?us-ascii?Q?gWcSzcGrKCx3ZoDHoXrdt86Qx42rgNHmqpYV9YSEFBCTiNLkWrbO6IowzCaO?=
 =?us-ascii?Q?J+Gh5YhyHkOFepWQB0+umID4wl1Acdd7KAO8Epy9zU8Ju0Y5IGpWTTmA80ZY?=
 =?us-ascii?Q?3hWro6IIhrXl9MD5lQkt3BjkmSmdapDonj+yBweHoTlxQAG5NotnfK+7z6a5?=
 =?us-ascii?Q?sOf9KeM69B0DcIGd/faq2e9hoTWdw7YflpXbekWJc0GnSIjnuWAdKJP+6pRd?=
 =?us-ascii?Q?OcS1hXUG4JG7I93lXJtCHA2WDz5/1glX9N9kk/cZx1Vtnrtkcqr0V0RpcfS7?=
 =?us-ascii?Q?8dSP3QHrpbL9aZdIC53UKw8R/rNUzq0lgZFbMQVR/QcLWdRI2/CmnxSsVPpk?=
 =?us-ascii?Q?cV0633zmkwlgy/X8GZQRpbGT0ZFobvFYbZwjECXBjqjEHxo0LUPHzdhHnjNV?=
 =?us-ascii?Q?+odfwBFzh4spxTMRvMbJPl+2mWR/9nYGosbsCaIP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ee92a5-f2bf-4607-795a-08daad6cee90
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 22:47:39.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9mUZCA6rnwls3EQp25+Vc/rDym4vBqHdrsaA8W5PJ8tEoD3B5c24+w6a6J9YVUQk0G6wZw+83WEmyQ9NjH3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 11, 2022 at 04:45:57PM +0100, Peter Maydell wrote:
> On Tue, 11 Oct 2022 at 16:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> > On 10/11/22 02:48, Peter Maydell wrote:
> > > This is kind of a weird API, because:
> > >   * it only exists for little-endian, not big-endian
> > >   * we use it in exactly two files (linux-user/elfload.c and
> > >     hw/input/virtio-input-hid.c)
> > >
> > > which leaves me wondering if there's a better way of doing
> > > it that I'm missing. But maybe it's just that we never filled
> > > out the missing bits of the API surface because we haven't
> > > needed them yet. Richard ?
> >
> > It's piecemeal because, as you note, very few places require a version of byte swapping
> > that must be applicable to static data.  I certainly don't want to completely fill this
> > out and have most of it remain unused.
> 
> Makes sense. In that case, other than ordering the definitions
> 64-32-16,

Done.

> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!
Ira
