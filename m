Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41557C25B06
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 00:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiHLArJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 20:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLArI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 20:47:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C37A00FC
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 17:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660265227; x=1691801227;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m+kS30RxbU4AyFiTu8x6U4CPj+DoPMGyJFt+79WRvZU=;
  b=KKA0GNTboflp0ECcziTatNZCKPhf9Mv81mI6nUpGx0uyWSJJIuDQgpfr
   M+PiNsiPHF9IqM/3gMBNiQHIHCiDgXJPoXntNbmOsst3dgegUczepD3bG
   aonrs/2LhJgQBDttH0HR7DDlmQ5x6gl4dNGXCXZrEN6a5hc/TtQP2FlYs
   R6IYpqSPMkSGd+WTPXtCM30n2gzEWa+bQnZxvXTrQDJ/RT7SCKEkt7FpP
   zIyWFGktgeZll1dIXRHZdKjugp7pp7B9krqb2lPtkE1xO3uT24zVnmJ4E
   UhlCivDGt1lP2nB4AH+r9oxSutvIfHdNQBhkHStR9uX/8X5Gm1ZeFlMRH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="291493444"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="291493444"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 17:47:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="638724856"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2022 17:47:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 17:47:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 17:47:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 17:47:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4/5hTaNDVEKdTXD1IEXMtXhZNnul7rWgir0ze1L/kxZvA/+ZCAXO47BiQK8Mzwa9PfiZBOeVCaOYylo3TpIVGBI/D1l/OF/YyTkuiuKA993UC07YoSraJbcgE2xEETwpVhXnMxzIu2c3y144HJqpCVf8pbq8uHDk9fVd6YJ5QRukTzTR+hiLAjNhOgXuBVzu4UB+k1qpeP2lpWUmqAyI8xrqeIZcV03Lcz0Z5jpzXUh6QugY9Jt0SfUnDH+i57YPv4G6ZyXNgG54MnZKF/k1GYaQaZ0YqpiUd4XPN861K8nlkWnFaQzLtI/ABjvBVdLHzTS2Kq38vWpcDAVp3rE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocFAsLPUs8wINdQcvjvUyFBK8qmlS3VhSsHjK5TxMIY=;
 b=k5t9M+2/VjQGuNglRo51rqIWgFYJw7x0HYKxSfUxOyE6jehXL+i8ZmH2r/9+3gtAitjYSGhckq5Cw3hXH8IW70OzGc/EqNwvzIARcgUj6PL+dQq+kRYWnk2r+A4Kxww7NEdhqHx15Yim7xAqDOE72uUHsnb/uTH296RADXGOd8y4xFhNcK2MviGrppwJM337oDmfBFsikVznR1gyP/fuPFGPH8QgtVo5Adz3F8PjUzamwu84qejdV7Dr/NL9+PjzooBB3Jx+vceHuPMiLeYmP/RccES57RZHdFBP15kaOS92KZPCYQcvLw6bNq+b7Y9Q7qqE5AM4U/f4ulfWGYGShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6395.namprd11.prod.outlook.com
 (2603:10b6:208:3ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.23; Fri, 12 Aug
 2022 00:46:58 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 00:46:58 +0000
Date:   Thu, 11 Aug 2022 17:46:55 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Bobo WL <lmw.bobo@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <qemu-arm@nongnu.org>
Subject: Re: [BUG] cxl can not create region
Message-ID: <62f5a2ffe8be0_3ce68294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
 <62f132aee401b_1b3c294c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAGr_yG389Bm_NL8CLgo_ZkGd4staocNENbtb-ULVA5vh_ywmcw@mail.gmail.com>
 <62f27a8e9acb6_1f18b294e2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62f27a8e9acb6_1f18b294e2@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1028ffa-72d4-4fbe-d013-08da7bfc290f
X-MS-TrafficTypeDiagnostic: IA1PR11MB6395:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLQoIamgNjNknIRst2wPjMtm8ax0gsFmvcuK3VmsCPNrl0JY1siSeRYNsS1pqKU7DjM2/biuRTQFs/feCo0fY8wE3NyOflBuODmrtY2UDLsAAG4jSjvy+EnOIMo8HuV7N4mZHp4ZYHw4gGOioNwJIf7wptk2b907EbL+A/N2C2j37IdbjdKFfZ4UeGxWpNSSkgl8cy3TFUh/JDOr7coqckLbef53GwTiKcRLvB5Qi6Zk93HYmmNRNqpb1aGuZiBQl0ESHrI9ELLsoiKAVqdopyysvh+SnZhTj289nOgzjc3b2VvPS7VMU+8Zpd5Jnwe0SZ3Jverd40CZxkCHojH3M5Tqb4WSDngeLLCSFstJyse3y/AESkANdMbsWV1geA96VsYG2vV95YQf5un4bWqrxm+sQWwwonvk916R4iPY38Z7AOmWHOGOCb24RDCOEkuyhAvmVZ2+DaXXgwzwR/4ndTvbDBbdAlosI+NNNlKgkaxSGpUNJ4aZkmr+NbKTwEQr5HA1vjzyiaYRdHvzRhKT52ZT04C4x3G881eXyxpo+9XZeJrcnSD7rreivxK+G0HchsLRAffFT8P1eVtWzsXCsTKIIwS+WFTV7aexUygenz8fp12pJkA1CdNwJGuJhjr4N9Nbb5uC7QfKwrEa8fqjRvJWRrzpcmfUGpiFZty2Djq5Dkc8MTcJm+G8CBTF8lAZa8DpoM+v3veYY+cLv6zv1Wl4rZsFAKcPxBtkM6PLOUfgQJIZbNDETy4DuE1DHt87
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(376002)(366004)(136003)(41300700001)(186003)(110136005)(316002)(26005)(53546011)(478600001)(86362001)(9686003)(6666004)(6512007)(6486002)(38100700002)(6506007)(82960400001)(83380400001)(5660300002)(2906002)(8936002)(66946007)(66476007)(8676002)(66556008)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6kXa5AXQgQwa2lgCD6w4B91RWyMa2jjCmFC6phiDSLUBAEci11cTcPYHqam3?=
 =?us-ascii?Q?wdaK6MwAjnZNkWp6+kdFQM47Yezi6eHRqGDvPQkbzBYh+ncvCO3kUy5N7O/d?=
 =?us-ascii?Q?e/T477JnottDpQupn/1KLA8aHouxjlwulU7soz0pfYEnO4rnPanhnhBqli5h?=
 =?us-ascii?Q?NN6rfPJw+woluyF6UwUS3YtLdHK5PzaNvPC0tomuFlmK8w9L4ji8DB2eEgFe?=
 =?us-ascii?Q?EVods8Ca6pr3f8jxNo+E+fu4xFWH4YD6vQekk8w6zZoUmdhVgrz9sqAhKouM?=
 =?us-ascii?Q?RTsRpjX+uRTeu4ORbzn7pch8XrepoFnwhS1GFQoU0xXxU1HaRM71QWZnZHSu?=
 =?us-ascii?Q?kSK+5lr7bBq1nT1vmELbPEXSkLfki2AvgsRIPmLppg3WIA4IeCr6pl4u/Pd9?=
 =?us-ascii?Q?VF2xhXIEAo8q0GbuDrCyRGsEvxCYW2q8hrdNLNFY8RqlNZH/aygjqW5Z2P3P?=
 =?us-ascii?Q?uG/7kuUyC91q32oiKnPo0MwiH2wQ6o+nJyc1a+67vrVArfuXmmzpIbPID4A0?=
 =?us-ascii?Q?9U/3jJIfpXIpbG+K1q+K9e+BlUtYVNWdkOtx81Fc0hTKJJrjwWcnAhtWqRqA?=
 =?us-ascii?Q?xVnO0Pk4rCicSHDbGHIKk/hX9H1tk9AL6kMdmFbSG0Y+iZKSriIBW9M+tzLN?=
 =?us-ascii?Q?ehv9JWey9YKtGyTNGVtHpPhZvGW5GWJt48h2wyLrcIyya4gZAoE42LvaERTi?=
 =?us-ascii?Q?zfhFeuWIzfrg/3EbVHf8a/6xa39nACOBnO2Cwa6spXzy4xaTYexY2y6/vab7?=
 =?us-ascii?Q?5lwXSc4uxgaalMnN2r/kGBNq1SJf3V3eXRIrq4OhfRDDsVtoO6mZaNvB9sBX?=
 =?us-ascii?Q?GmPrqHOrUaJdbV3fflHSh6G/YM2tYBp2vslwyDggPVK0olmuFiQ+P8095Jcb?=
 =?us-ascii?Q?AoD6zS2nrQRNYwPrHqRdZxEx45aQwIwF16C3WDSU07/NdkpPC9quV/TQSYB3?=
 =?us-ascii?Q?p8bg+M+W6xc4WmuZctPXedURCxB/diV4RpXjlLbVwv6tTb1zIHYdWHrSBfaK?=
 =?us-ascii?Q?IgNPgSW4EC9GCYtdgdVwqmkGIdJo1T3xIdUxMa5ic2FBXEV1Admt5N95fxNs?=
 =?us-ascii?Q?4iCAfzK2WLrGDvwMcGuSXOsLuu6Mjd3pNEIxrmffg3cGTjNEstPKuiD5yJK9?=
 =?us-ascii?Q?yv+xT2DyKkOky1Mz8NkV6yOJNBTwqhjFQmQ7+0fDUltlnhY3HZMFeWG9a/j8?=
 =?us-ascii?Q?3gp8TadE0LflmIVr8llxoq9eT+uoAkjsrI75gNC0iXU50o64UqBuzk8pYkty?=
 =?us-ascii?Q?ThZF6bhZGF/dZRsjuWW5tynYeSmUJfWs/NUQkue7ITTFBdCjhtVF2PHyr1AZ?=
 =?us-ascii?Q?JDIGwdJplftT7AshCkIDKyzb1gOW506p9tflWEG2lKoNct1KULcgsHb6gtxw?=
 =?us-ascii?Q?ZQnR122bU1sNxXy/OPS8/6LTYDmepB6kay/hYxR6sz5V+LcDbbHEyVJOXuzy?=
 =?us-ascii?Q?8nxGWTuJh4n4QFhFVCRfI38KXiO0hIVb94m6tlxJRf5x9ChsQCmxFHobtabv?=
 =?us-ascii?Q?DongEDfvj0KUd0iPE/9dHfmWu5Um7KJvlTw3I5kIcUwz+4UOBJssk8WzPjqv?=
 =?us-ascii?Q?Jn+NGB2751kr9Og9kfGSY7P+cMSWwqHwX5uW3AnknMCKCe1/k/pGttVvUdU+?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1028ffa-72d4-4fbe-d013-08da7bfc290f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 00:46:58.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/wnNqtK+eL2qjnHcjXQehvEBFccOcDMIpTqIcy/Yab83Itd2CdcrDNWA0cPAg5Whjsym2SGntm7uUIlLIgJ+n3+qmUnFzpmsE88/ShjFcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Bobo WL wrote:
> > Hi Dan,
> > 
> > Thanks for your reply!
> > 
> > On Mon, Aug 8, 2022 at 11:58 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > What is the output of:
> > >
> > >     cxl list -MDTu -d decoder0.0
> > >
> > > ...? It might be the case that mem1 cannot be mapped by decoder0.0, or
> > > at least not in the specified order, or that validation check is broken.
> > 
> > Command "cxl list -MDTu -d decoder0.0" output:
> 
> Thanks for this, I think I know the problem, but will try some
> experiments with cxl_test first.

Hmm, so my cxl_test experiment unfortunately passed so I'm not
reproducing the failure mode. This is the result of creating x4 region
with devices directly attached to a single host-bridge:

# cxl create-region -d decoder3.5 -w 4 -m -g 256 mem{12,10,9,11} -s $((1<<30))
{
  "region":"region8",
  "resource":"0xf1f0000000",
  "size":"1024.00 MiB (1073.74 MB)",
  "interleave_ways":4,
  "interleave_granularity":256,
  "decode_state":"commit",
  "mappings":[
    {
      "position":3,
      "memdev":"mem11",
      "decoder":"decoder21.0"
    },
    {
      "position":2,
      "memdev":"mem9",
      "decoder":"decoder19.0"
    },
    {
      "position":1,
      "memdev":"mem10",
      "decoder":"decoder20.0"
    },
    {
      "position":0,
      "memdev":"mem12",
      "decoder":"decoder22.0"
    }
  ]
}
cxl region: cmd_create_region: created 1 region

> Did the commit_store() crash stop reproducing with latest cxl/preview
> branch?

I missed the answer to this question.

All of these changes are now in Linus' tree perhaps give that a try and
post the debug log again?
