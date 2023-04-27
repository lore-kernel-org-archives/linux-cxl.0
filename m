Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68277C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 19:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjD0Tys (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0Tyr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 15:54:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668B1FD0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 12:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682625286; x=1714161286;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9MZ6JBlmV/eE64h96mo/KCMjrIK8KnHT4jbadmzwBLY=;
  b=ndlze5lUSCL5Wv6hnZB1Hhb14+i+unLsY9d2hJjt/8Z1tcvvHedhFMrf
   gNkFmbB5C7HidLztWfy+dl0SfzsIXCVxy8Z4uyZ8oiOmzYbJYNmRyQQAD
   X12Ab2UVpUWm6u+IZDOZv9l8XVAuP3pnBdplZ6fOyLPNzFPHrzJ+LumQ+
   vGgegRlbCcWdPlBOZsFu9QJFq4nCehlxRrVgDkDS4X28RlbMTvdB9SBu+
   Wx+Y3BdPbrjdA5w6gshLnK4ed0vpb7f+qD7bVR7kZeWeS/dnnBDp4o6UV
   O4a5bkywJANUvAq35WJE+hTn85iBSsiEF4g1jRJj59ho0MtzvPuL2KJWb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336555131"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="336555131"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="940791985"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="940791985"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2023 12:54:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:54:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 12:54:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 12:54:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEf+gLDnULvpbiIvc9XTIQ0/oUKBUp/SvrdOTOxci/Iytp8LPCj7+Cq7nSGUBk5UGO6J6b8Iylrc4G923E0t5M1v7eheklMHD3Y3uxNTq73zklsEziuusE0L28e9CGxmDcBvUd0/z4p1Nvyg4vhNAi/77YDB998d+NcOmQLNpMQTrtkgbETBntUy+gUGSs6eHauPSicIBD/GksR804IVaUEuHVfRlT24fmHB8uAvm9apbPLlxesKdKPGU06WPWG9Qp88ShtmZUhHBc+M3RXdwPdQtnqyuZUY7vcHTlJWS14SL4DNeszt+vNgia7ZIAggbPYpeJrsWNBQk0T1kndc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vd4OvGhhyhAQGSwUesOJn1jfS8dEw70kAIV9ndcCYI=;
 b=LYI2Ihv1hF59PXLnWbyUYC6rNOGytqvd2/gQMqwTxwJC37/yd/VDOsbznycs3qlwlb0ixmW6nqXoLRWTgYlMWHgykQ7KCXlgeMUspibZW3URTSMyQVbz3tk7TJ/231RF5ArRBpo8KosKK2xp6WttI7yshUWkSG6pagWRnZTaenwv/d7b+Sfztm9PtC5nL5I4Oekbe7fFgL8qVAtoxdYJMZ4K4TX+FPFEmL8wV99dbfIvQ1cfUy3BVtsiSidTn8XrryqYGhLnVxsTg7h23kozTMMUc9lgrKJ/qzbl0fKk6DKutbkwzWHgHFNRrTnud+KHSi4byTWTMnAp22ymr31Zhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 19:54:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%6]) with mapi id 15.20.6340.020; Thu, 27 Apr 2023
 19:54:42 +0000
Date:   Thu, 27 Apr 2023 12:54:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v13 6/9] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <644ad2fecc06f_58672948e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
 <rjgz474mou55qufxwwmy3vpxftagdys6ge3iqs3guqukkw3jlv@ho7vuf7bmjsp>
 <ZEn19R/iusbbkPau@aschofie-mobl2>
 <iurygq7c3gg6gskfzgnl3mkr7trbpnp3bo6nzqiwyonzw2kscy@w5s3xh6fkell>
 <644aa4369184_586729479@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZErKa3dztvM4aTP2@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZErKa3dztvM4aTP2@aschofie-mobl2>
X-ClientProxiedBy: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edcf568-ab9d-4a23-f124-08db47593de0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvaGzBbtoJYXyOH6Bst7+exUv/RrGMc4yjxctqayOeQYHM2sErR/m1q2iNRazz3gLkrbhREp4uWkkDu360RyDkDoiAiSgGNsZ/mxrbF4fRK/8zqD74XMJq9a++CGRHVDlqyBKiEQLU7AUDNJoMv1BU8j6ODYil7EDlnNYJ89dcVVtZvixEhN8Mk/o7oXZSezlJw/BG8QVOi+U6nOs6Bi7BGNE9SUJYIxrnucs5AsF7UCK+bT2omtBTXh+RB0aqSKICWLMy1bUQ31uHiwjVre75gj5Mfz/4InklyFgQcyEA+UrtxqojUyNdCoSd5mtTPVOfHSMuHHb+N5O+GyWUJS7MMXXEpCJFs/ommHZL2u446fuqvVFCQuBeDbMaGCAY9iPIdGsjj8A2OHobDk9D+GYwzKgv1ZCY0WAFk9psjH6gvt11xsJTLn2w8ysYFKnf6em3ifzJnUgdbT/WHVra+bYfxee1MUYTbK+yZsCOsEHqiyfDCWw6O6Bgtw1mrpoWSOoKSQLrrEZZhSOZLBI8HEE11ngzQcjkPI+aaIa8TZN9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(478600001)(110136005)(86362001)(54906003)(966005)(6486002)(186003)(9686003)(26005)(316002)(6512007)(6666004)(66556008)(82960400001)(66476007)(6506007)(66946007)(4326008)(2906002)(41300700001)(38100700002)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYtbMHlnAuE7xLDVLJBMJBMl6Xfbvhk7NsQNPo6D0WEq7dkek1nkGqg9TqCu?=
 =?us-ascii?Q?11lcIypmlQMVxFW29/9y08iZlUQbG3BT194olmcQ5E+8FCTQEUf4j5PSFRqH?=
 =?us-ascii?Q?pDsrFVhc0u1OQ9Pbf2ZWIGontFXxDLU8mjYIY3DB8CeG3XGv0IAf6GGp3vRB?=
 =?us-ascii?Q?3H8aKRELyGOP/yWpc9G167gESFpMVcHPgthv51+5iOAq9hEIlhcKg6YazkuV?=
 =?us-ascii?Q?l6IF1nZLTB8jMcUOO7onOA4ysIkPtx+kj3lp8nPuh9mLWzledExTQuCbxkXs?=
 =?us-ascii?Q?7Fp7ZJvKIrw/lDIhhACLKCRuG4Klxip6cos4T7H8e5R6iz8ikIeyLDKXAY9e?=
 =?us-ascii?Q?Is1SogkoPnJbgKe8p10++19eoYBw5W2IeM5oDD/cerdmzwt3xyDgizMcvXds?=
 =?us-ascii?Q?XaYNAtSLM6Dl6BmUo4ig5iV2pjC6HRwACtfXicwtbn87//PLu8TLFBL8NA47?=
 =?us-ascii?Q?hCuYM0qGQ6xTE7E3msgMi15+REznQhtU8eFV3hd3iM6eIMjbIBbnXwU0mSe4?=
 =?us-ascii?Q?pvbqFY2MvIYFwybnpOLBQV6I641bDYjBfjceKQlUPdVsSImc/9XnnOQTMP12?=
 =?us-ascii?Q?s7OmEOP0g9QUoFpJq6+SexbYGHtORvJ6DN9+fJkjWQ+IJ5BnfCWlvh8lwMHb?=
 =?us-ascii?Q?NN4xrqXntsTtxw0Bman/NMhuIij5vFJV8yWJSgi4F0hhKtbG6q9mcx8tMsQE?=
 =?us-ascii?Q?kFGDuvpn9sFnbPGtgheZDb/rhmhR3VxnC3HAjs1rb/AVz4tnbwLn2ggdHRdS?=
 =?us-ascii?Q?rvVIAtw+w6lP89m6MmBp7bVobEzOPuyvAF8GXqvkRzlD+POHt62wW7pTWm/L?=
 =?us-ascii?Q?J0KZ8G/1TVMdNWsGPMmTXs4X9B7pjnQsrp9+oJABkC6dau1b0i+0J3xT5I9S?=
 =?us-ascii?Q?CC1gVblNWgfJETT6fympinnW/Ay0KpXnf0rFBXoO43UCgT0ODuRc70k6gkRw?=
 =?us-ascii?Q?BP8NiTuiAK75Z6VZofDpQl40GakyiK5SYcKIFEz0YRPHZxCm2HaHy6WuWo0+?=
 =?us-ascii?Q?q/y+bAI+vT+GB6uZoVHixnEqdkE1fr5Pgp/z1w2y9+oCN24LDtrz14hm/wsv?=
 =?us-ascii?Q?XT+w7O5mxbgyNQU49ZsY0P+fiex2lr6kfZ9C02Ntn6BiEe850b173/94gWKi?=
 =?us-ascii?Q?givOi7LTChl2ovXVJFhvEhPiIaq0cD9j+5VTYuWD9ZQKRD0mKH33WKlQPSA3?=
 =?us-ascii?Q?bOKewFulazlQGISeog8q7g0SKrdZ/Zp0XHZA+zekUTQYd8+dGP7mx2lB4aEG?=
 =?us-ascii?Q?6WcrHVDtnoEUGMyfffFDRsSxMfLHLglqi1reA/ChN4T4w29SzG2mJevXi9FE?=
 =?us-ascii?Q?dEgRfTnz/swWX0WI3jE2p3EOK2tzbXG20Ku/Z5gdRKsc+wX10zpCrtJRN/Lk?=
 =?us-ascii?Q?b/TZiXDZKfVdZxDr+jBpfTS6KDFK/OC8cblfyIFnvxhBmmxhznFEt8aLOPaA?=
 =?us-ascii?Q?bfBAGuZXHoik1iUIzYAiE3843rlQef0VLif6k7xOOB4HRK8taqNtRa6VudbD?=
 =?us-ascii?Q?ndZN4V3+3PIU8+cDcSKdNtFd6xqKIwsacexC4G+wtOfImt1hUszDHbR1fmdQ?=
 =?us-ascii?Q?8bUymLZVh9vRWG1tKZ8+ZEm9KbfavPKNz+hz3Qkr2Cfc5mNzjjsZl8h7MH/h?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edcf568-ab9d-4a23-f124-08db47593de0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 19:54:42.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpTlAz9FaXXjghK5HIKlYtR7w4w6x1I+CEydMPyFGuaJEhgcL814Z20Rg2Xt8bsCIgIvqKbZ+T1UWemJB08lk6fbGODsk96DSHrT6qY0wR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Thu, Apr 27, 2023 at 09:35:02AM -0700, Dan Williams wrote:
> > Davidlohr Bueso wrote:
> > > On Wed, 26 Apr 2023, Alison Schofield wrote:
> > > 
> > > >At the moment, I have 'trigger_scan_media' that results in a spew of
> > > >scan media results to a trace file. I guess we'll chat more about
> > > >presenting a _nocache, when I post for review.
> > > 
> > > I'm not crazy about calling the interface scan media straight how just
> > > because it's very unintuitive - albeit users that care will probably
> > > don't care.
> > > 
> > > >
> > > >I'm concerned that a  _nocache_ will lead user to believe they are
> > > >getting 'fresher' results, and to over-use it with that mindset.
> > > 
> > > Agreed.
> > > 
> > > >Get Poison List gives accurate results and Scan Media is only necessary
> > > >when the poison list has overflowed. OK...here I go opening the can of
> > > >worms myself ;)
> > > 
> > > trigger_poison_list_overflow?
> > > 
> > > If triggered and the list hasn't overflowed yet, just be a nop?
> > 
> > What about a "poison_overflow" policy? Defaults to "report", but you can
> > write "scan" to have trigger_poison_list invocations fallback to
> > scan_media on overflow.
> 
> With a policy like that, the driver may automatically do scan media
> in response to overflow reports.

Sure that's what the policy enables.

> For users that want to schedule those scans (policy set to 'report'),
> they can do so my doing trigger_scan_media at their leisure.

It's not clear that scan media matters so much in practice that the
kernel needs to have separate controls for it.

One of the observations of the overflow threshold is that the failing
part is likely to be RMA'd before the poison list fills up. Scan Media
was more relevant in the PMEM days [1] before List Poison was introduced
in CXL that promised to always record poison on creation.

If Scan Media is an operation that is rarely used, does the kernel need
to carry a trigger_scan_media attribute? I.e. the kernel only needs one
way to kick off a poison collection event and the depth of that
collection is an optional policy setting. Whether that policy needs to
be configurable is also an argument that needs evidence.

> Would you expect the driver to retain overflow state, and warn those
> users that they are issuing scan_media without prior overflow events?

I don't follow the use of plural "users". Only the single platform owner
cares about the health of the hardware.

[1]: https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V3.0.pdf
