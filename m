Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7EEC6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjC3SUL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjC3SUJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:20:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93946E3BD
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680200406; x=1711736406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O4jNm/9uAtw56ck9ApeLvlccD6y2TQmzPACDzQorsjQ=;
  b=E3X0uMwNhiTNbnG0GkWFFGEPmIMPB7ULaCNE2VmsBqaAk9DMKuExIbIk
   lWMe+Y1rWjjPRmYR0zldcp2IQ8VhRr/u7ZPwDOR/wlg9etZRArVOkWJor
   G6hC5DmTlvaz5bezE1G/825CvFUlB/ip90GM7f1sLCtxaRzMcBp8Fzr7w
   T7jgMPJdX8cR9yjLJWTXeIqVKiD6LE5vbHf1lfqyOMoQHaND5b7NJr7/x
   OIXWAfC8NlWSHauSsNssuywgm8pY2Sqy1+WXwnczkI67Ujg27epIQZ03c
   pNN9mV/CK/bxkArUAQU9VBBrC5rS8SDSr3d55DHDdKwfq4F1wZggmKWHI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342895293"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="342895293"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="828416377"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="828416377"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2023 11:19:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:19:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 11:19:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 11:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRjnsS++p9ClbcItR+8LwCwTrMCGULp5a1oxBtG5GxvnF2w3JpHNEF+TZnAPVsMjg9vhGHAGSzM/HjlVyvvJjFpTi66zpZUYqOUBazBLmmlHqkfIfC3jV8R70XRF9IprQFAe1ecKR3QEDqDcroQpL0Kb012NGn3O4kdY4UNk4/wVIQ2MkQkPrLPrjuocIOJTH2iUpFujUAYY/QgRZsLwBK4ICliaC7u11RnDCSOHqzb/1eLi61VYk5jxzQKFyyVbFakWHf2O10f0arf0GPc6xib4sFytP7JDN/UoW1mf4ZzorISgdVe5lIEvTLe8YOAtP+NaTv21x428euyny0NPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0pgQQO9DWzk0qhYb0PmcH5HGivFtHLrXzmAab2EcoU=;
 b=Td9RNLJDVhpKtzZXsi8hLQKEQXwOY/bzuvZDn3nkb88vI55ai2mNBr/bsUF/zRc/8H7CeYpbStlREd8Ddhw9IFTBMnieulHG5xJQLIMpOgJ5lKK1GLyLaMm+qsy7HqpVrPkGPNk1OvbpMRJchGHLKLwzTzsHBTJSgDWDys99YFshiaKbV4rnSPFjZKIgEXEgWz7ANySiBr+8eGQzfAKwrKkxzCyL5QRc2t3wgiYaEprMk7vEI0B+4VcC5Gqu6pftSnjiZt6AieazSv4aKia1aCQ97pZf7DPPTKm5wIxtjuLtK6GCZ65znNWn09MLqwQp8OpNUyiyYgzbXsYUZz0z7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5628.namprd11.prod.outlook.com (2603:10b6:510:d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 18:19:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 18:19:44 +0000
Date:   Thu, 30 Mar 2023 11:19:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Avoid NULL deref when component registers are
 missing
Message-ID: <6425d2be21bce_c7222944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168012574357.221280.5001364964799725366.stgit@dwillia2-xfh.jf.intel.com>
 <20230330181916.00007fb8@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330181916.00007fb8@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe53820-121f-4962-c227-08db314b563f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7FsgntG7CrJdTqrwxjWSORaLqwgtzFD9eHMlZNL3nokXzJBA9b0xDAtSafeeO4jqcEBjk6l8u0GWaW1l1a3/zltYXreDIeT1aOl2CeV3GQUJMLx+ZEcW8f4VZ8lZwE2EWNeccDweE8VqIb+TchmdX/rt7erLSaGGk743MVrJbLaNNm2dmM/Qhw0EltDjMxcERN1UoBNSdYteO6q0vfjjkCW+0OCjmVcbMEzG3fTaI+nWLl/5VEJ0tf95/szxCCDbB64VWCyA2WmVThPuGITQnf5Q+SfqGLUNn2Sqh1LbFiMWCV2R3/yvl+PkvXgOAj0cmnD8+zY19if9EgKIPR5ztNCT6okz/5lPwmqKlc5DVVTMsEDXYIsWvCM/hEc3yqqbuJ8nnGU6VRV2pXYE2jaGHhJLsdg1lypijErbEVOQsIkIp1JAxiaBSJgOPRRo5DlqUkhl6k1RqhpcOI32DP2NYnJUoiBUk8ZeX4YpxijH8cVDMLv3Kf6UaZpsWPJpFS4glD2xh5+Hx2EXYp6+kXENkYl78hVxfzjSyjVQjcy/nGWXw+Jqad3jS9kr98o07lP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(6486002)(110136005)(478600001)(82960400001)(86362001)(38100700002)(26005)(6506007)(9686003)(186003)(6512007)(107886003)(83380400001)(41300700001)(2906002)(8936002)(5660300002)(316002)(66946007)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4KHw3FCKt42uAxDIRzTPoyqBuzz3NSn3nhK+NyZsk7MjoAaytgLWqRJ1saDW?=
 =?us-ascii?Q?KjE11Ugm7IgEg9TYLaY38E1IucJPeJ78boztl/Ifd6bpavQxPBSJ421D/Cro?=
 =?us-ascii?Q?Kf7jJNTJu0qde+oRnbdBNKpMX/hLbAozixDEOLZ+rslEhLhsFGIeFpezCY1k?=
 =?us-ascii?Q?J8SsVxKShp3hxQNfSTb3oKU8X2l2gr5qqkc/vKqoVQq1mKSOE0CpDIM0O+t3?=
 =?us-ascii?Q?4OG8+k589Yy69QCx2E00v4xO13xDz2EPtIiavNiZdHMIQXGweX8wrFo+DzXq?=
 =?us-ascii?Q?0erF3YRmWwexOyo3ZTKgVr/s04T/uZAvTXz04mCpJrzvC0fq1yLJWnXbPFQL?=
 =?us-ascii?Q?vqX7s2GLSOcj31bG7PpsC0Qsk7Qg3Q+O62EiCJ59ScMnoNAy66fprP3bUjKv?=
 =?us-ascii?Q?NL0Y4CF7TNwayQuib5MVBwogvV1NdzjV4sL1Kls05gSupQoqo2p0TLq7Z8jU?=
 =?us-ascii?Q?uTT/reDY9cCnsXFM2TPm9dhYsxBfY8qqMVqy6MrsDCYsYNZr38uoYKtyaP1M?=
 =?us-ascii?Q?a9FcqAcJl2NK1kwYrxcT1MuBc09kKdV7Sotpyy8xfB2xGu4U/WSwNXnD0Gki?=
 =?us-ascii?Q?wjFtTejrXVkldQDbfTkfF9MJrpfNUCSAbV2Ue+8nDwC4ZEq3DTgWWklXGHs8?=
 =?us-ascii?Q?tsLRShI8MP97TSlMKYAf+mejacLOLGJQDFjo19HbH8hjGwv7ECb7xVpgO+T6?=
 =?us-ascii?Q?h3Tq7dQtlF945OQZtV/EVkCiE5MluKRu0fCqIDnS5NFPXzohFkV0PFSuvdIt?=
 =?us-ascii?Q?u5hEIWK+znlDBghLQAYjwsHvLEoaus/z814/rY+9bGXq7P6QCKAQyUyoewZO?=
 =?us-ascii?Q?Z7glF62EVDpWPLdjASpHcA951Ue+ldNESVeTgKl/DivhLNfwRdx30Cclu9+o?=
 =?us-ascii?Q?FNiow628gMyy3QMfjWvmEJQ6xpg5aMWspahVZj0cXDOj5c3ubuFa685rfltx?=
 =?us-ascii?Q?fTmzD+GBcPtyGlVUApq91NQT/YyZQoL19ONhS2ZbYlKw4YzJ8MzQTREdBWnW?=
 =?us-ascii?Q?6khK9iNaKLrugfRzJ/v0XAsmlr038/pFyoRIBRXDMs2dNonuVbKaCO4FMldw?=
 =?us-ascii?Q?6mFtLa8eCFxilRkhsEFGNh3VTCgy0jUBCiSzELxVSzaewcH71rKrq2X1n1RE?=
 =?us-ascii?Q?wU0hBmmOXUuKWaBWk+q8+hodBUpdZQF6rva5FFwFuA9jaqcCXYXvIsvBq6kg?=
 =?us-ascii?Q?evlklS5vhP89JGldQgxhCmniWxTm44LqMRxSb9LRLfBTxbcuwi0GxtRQElGG?=
 =?us-ascii?Q?ZAVipT5uRMCEH4u+2FwPSCd9GNML3dHEX4Rl9cmE8VWPZuw4RifIOY8RlgWi?=
 =?us-ascii?Q?Wc4oVqGtJVAMDJE7mueOBM3xSFcdlNjqcdVkTRV/tnT7SB7l8XcX3wCvEBbj?=
 =?us-ascii?Q?/PrPggvXWNE1Mf+OGLkG7EYGDVx5KI6jsWTFtJ9vLGilGmNvbVQXPiN+4PMe?=
 =?us-ascii?Q?VA1KMlDgSID61prosmGvMFNiqBmbtg5aBuJQVgrho+50I6/bY5eBRlqLwgZG?=
 =?us-ascii?Q?LO2CvWnCENZPfj0kJY8HU2IHVXdFyCR/HaqWN/VUue0U6SMmzbiKzdtcv8jw?=
 =?us-ascii?Q?nYfLuxVN9bXDJ/gffyoh3KZdOC+r7qEb2fSt3zs4qLAmK+EeEbIs1/aSW7+3?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe53820-121f-4962-c227-08db314b563f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:19:44.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CH+2AAu6uKD8Q1D0y0yKtnNrEqjOiEZWeiRWY33PJbYBQppjvqLAb2PVwoeSeYGpv8RQUtBshzrn9UQfZv5mw3p5ixjOl2kdMKpXIoaxfD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5628
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 29 Mar 2023 14:35:43 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The cxl_port driver attempts to support endpoint devices that do not
> > advertise a component register block, but by inspection
> > devm_cxl_setup_hdm() passes a NULL @crb to helper functions that should
> > be skipped.
> > 
> > Return early and skip setting target_count since that is only relevant
> > for switch decoders, not endpoint decoders.
> 
> This is a good observation. It would be nice to not read it for the
> HDM decoder path either. Obviously we don't use it so that doesn't do
> any harm, but to someone reading the code it looks like we care about the
> value.  I'm not immediately sure how we'd establish at this layer that
> the HDM decoder is a switch or HB one though..

@info is NULL when this routine is called for non-endpoint decoders.

> > Fixes: 757f6448b100 ("cxl/hdm: Fix double allocation of @cxlhdm")
> > Tested-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Patch looks fine to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
