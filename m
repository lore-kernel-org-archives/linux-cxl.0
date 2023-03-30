Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53721C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjC3SQw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjC3SQt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:16:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7754EF93
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680200207; x=1711736207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tSlnTNGPkBiS8Ioa8go+Qn4TcUtNe8fmku1UOnv/nFI=;
  b=jVfqhlYaJ5WkeGUD9N52rmgbUF3nv+AM5WhGeaz3hskk4zPJXugsCjMG
   d5b/YBy/SMcnA7EitozEbzp8ezXisb2VvaEI8LvbsXH/Lx9cIwsCjLCy5
   640RPb+QU+VRr8itd81gq9xe5ff88nE4g9EpjZwF1KRzQVeVk8tMHxDkc
   2VnVxphzyIfcohZKPeCFINC7I/g9UwPV/3qRv2FDuOjlJxJgyKszTYjOx
   WlTO3dg2QooEXj6TO2WVMNxIDNo8PHJ+rzl7gbwJ9q0+VCDq7VfcplBJ0
   mD4ebBj3zfBaocSmY+09iNTRhUh3pLTcu8fGD/1fTCkSP8AnsA7tCiGte
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="338751523"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="338751523"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="795764815"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="795764815"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2023 11:16:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:16:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 11:16:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 11:16:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDeqXYfulMEL1/2Ba+tsoFFeMeb0G3etZg/xFj4+fhvROZKpzQDQZUQwA+Xr8EUrrYzRkWzsstDhYuf5LsL3BJZdFIX9a7OGCD6ozxxAUXY2lpQeEwzVHsBYBybbhluBPGo9uQ5o36BzLEgx4v7m9k9pHSVTK7nZmKaQBtIEg8DskIFEVg493BPt6uARjy3wmDaQsdXgNgQYYNTZaEv08OQ+XgYSi+T2iLVQTLevCLDAV3z7T66OfQmDo0ok4qdcOWFdBRl5CJphrlZgcvubHi5CmjxTPrZE9F07jGPygW0Pt68wVu0Ob++UewonT38Odky34t1C98VPwzJa5CC5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSlyq97V4sCFNxWzLp05eP277jb9RzxKM7V9dKuy1gM=;
 b=D6o13IG4TNFtFJ8LpK0j4IIV+eXrFWapXz8LKwRNL11PY/a6rraz/s37yqh5z/dk1U+H3GFxfzSfuwmfi690d1sKWB3oDeRQ7iFWWXJQsgbUoD93cG1iY/LwpLZ4xJ2xJWmsKdyts8LcxDwmPrYalNL/41I3a8VexMgUFIv0JnIV77cMC+7vLoupqgX6tFlhlcflg8EBAG4z1TA/PyU3DW8s5OyfIODy9O3b17w4PLsCHCHUXQbBBRyRdaVwFEXkR2KD0lhQRVWN+Oj9c++ZV8A67bdGKASrUl2hgxCqHcn3RJZwQc2QFcwFYvljnd6ifytoOEZlrzJ8Np2Ipt1ygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 18:16:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 18:16:45 +0000
Date:   Thu, 30 Mar 2023 11:16:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/region: Move coherence tracking into
 cxl_region_attach()
Message-ID: <6425d20ac14fb_c722294c9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168002858817.50647.1217607907088920888.stgit@dwillia2-xfh.jf.intel.com>
 <20230330182807.0000662a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330182807.0000662a@Huawei.com>
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 38593cf8-07dd-409a-07c5-08db314aeb2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoJdVi58+4WN8Y3R3SHh5E9e/MHk8zIRnFsB4uBVt90htRd92stY7E2GarcgyxHOE6jxT0SmcYZNKuW5iWNPGCXv8CMeZXq3tE01vE7WE/f03hb/GO6GFVrej28dOufP+XLJuMcjK822mjtq11MQ39PfsMfA5lJ6e6K6l56oHkWI/0JiR4/0JtZnorXaRnFtWBkYV+6agW2jYYffwKdKJ+kpu3WHhvBkcwtRz0bTX9dmKxnqtZHuwZ9K8Aa8+ppb1HKnRQqrRsKwGsJRDBeXdZRLCqwvOvSQiEAF3Z9SjfpcMbzoE5o3eGN/noltO6e5dAR6SObHEUbZr15lNNDoZ0OF+BSI7GYJZ9Q1rUG5wTyC7QWNuMbD7IFpvGJJfd00zFqF/QtktEhEsU8boKvwowr61tBB0EwAqgeCQ69ceV3VuCkQdFqoNyi+qvt8GtMUWX056SOKuDKcL5kP28W3+mDKoQy5QXZYrzDf0cVcByBE5ABSPKYHDjjCCZbnAQ8fRm/1CqdUpPz/MIQAJssUulFR2fK03ibQXvJpNEKbuVfQM8VcA83uWLiUZdFWH3D7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(86362001)(6486002)(8676002)(66556008)(316002)(110136005)(41300700001)(4326008)(66946007)(66476007)(478600001)(2906002)(82960400001)(8936002)(5660300002)(83380400001)(186003)(6666004)(9686003)(6512007)(26005)(107886003)(38100700002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmGLr6XgxbQHvVO6+dGmK9+tj7fD3Nv8aqSsaJkaz1fXyWaop/d94pf7Zxvh?=
 =?us-ascii?Q?maR5oy4Jzt9bV91pxKJp9nLqTceTN/8D8yBk1VVlEZi68jUC1rCzr70CNP+2?=
 =?us-ascii?Q?hpQyYLGeAUx1NsqvQJDWiwymXZQ4AZ6s1vwXtE/f1Hur5n+fa2UGilen/uHV?=
 =?us-ascii?Q?VZerTOU54n/W7QYN4f51ZOdtMs+S/p7Om7rKlTXqhETgYlYGgfHV3Kq8hjqk?=
 =?us-ascii?Q?lRFQyGxsn6jMnkcKXiUvZOc/oRWr+uC3cJVeOLqM2orAIiWTj2xvKixgG7Yy?=
 =?us-ascii?Q?zcI6tD5gsfNayMEhvr/43+wpxfMlnQIjKhM5ePNsJ07I8vQqrVJcY4oXwkii?=
 =?us-ascii?Q?sFU16mrkGnNdNNtlI1QJzdPcFDgVlADRlbuGYaK5BbyomDKnfs/zlFLdVltk?=
 =?us-ascii?Q?ePP2iEaVikASIpYqX7lMqBdarqBgdHN4//H0OOyGjHan4eprBcP9/Pr/cP0y?=
 =?us-ascii?Q?JwdXCz5A3weqdDgSbxm2CRfOcCJDtmYsV6zMoxopuoQLWhnvlGQmF8hEuG6s?=
 =?us-ascii?Q?LHQj36E3WZtp6W/WlqtKI3YK/520ew2ZHkh42kMVVUfBhGHj0cDfMPXOSbvi?=
 =?us-ascii?Q?rctI7aV9T0WgRA/YjZg/QeCn/pRj0+fsIWRXUiK6vtUtkohUxKqi84fh+Uc0?=
 =?us-ascii?Q?Q6S4Em38aCaQ3cjZzUakDOnZb0bzCCcNbOJhP5bv9urO4+mwuEWkCIQ4L++I?=
 =?us-ascii?Q?z7LvHdnmZC6jN/UjII1AosywFnzBChovzWnZhf6kEEyYjJKSAgV+OOYsmDue?=
 =?us-ascii?Q?uM8pcO8nZh7JPGF3vtwrSuuCJ+kl95mirUxhsgh0BlJtPpjnhgVew4FZj/PB?=
 =?us-ascii?Q?+dv2gDhZhQFxkIpjcc7Hj775TwtW5NMUrcqpeAzNr86Jp2I1Zw65mLcIxTRV?=
 =?us-ascii?Q?CuarRh4jjuHWqZyVWNc1tp5R6rYIyWXQdEQhYVG/9vKaxko/1XZk5goD7DL/?=
 =?us-ascii?Q?B/prNji4MFk6hbw27mc/rT9eSBdykKQjkHBZWC8AjwDBucUel/bfWRHMMIW+?=
 =?us-ascii?Q?JuWEx0YqL2ayUHCjFv69PWuRwvbJ4sNdHa1LK/Z6LhPiVGp1jVJXloMy78xb?=
 =?us-ascii?Q?5JLQjJaiuzkP7eMk4gnd+0fph+quLdkwXKv4x75wAXU+PDzTVCq+HzAE5lLc?=
 =?us-ascii?Q?k/RSonxH3+DJ6flPVoPjQR5coi6MgVZQFqmFbLGjF6gH8wnT1LjAa4Z8eNh0?=
 =?us-ascii?Q?enVIZRXxie82CCUSIkiRFVsS5Q+NVpWpwa/ZIlZL4Z+Xk+P8AwWCiZSl6U+L?=
 =?us-ascii?Q?YI6N/FOmfxObeaCd3kWPAWvU2L0EwUhB7txAFbN85ZgJCVyqSVpLxZNII/Jg?=
 =?us-ascii?Q?HC0+pTpWWxoritfhvWPAVyLXu2BwSXLpEhjov+LNeGm0ywcEMw4KP7qWpKMq?=
 =?us-ascii?Q?y0Dm34FzcP64/RjsIoHp5UaC9q2Z56HoesYQp5zP31YU9TZyMLqynJkee8hH?=
 =?us-ascii?Q?Njx3pSpajiWy//96Mw1INbvKLDDvgOmftjVG+1/qTOkhsb57y3WjTUrYGaDA?=
 =?us-ascii?Q?KB4MQdADxYwDBZZoLptO00bCKJrYmLVxiygvwJ0gTNzAvubEi1bc6lcTu2wT?=
 =?us-ascii?Q?i/+8lh20ecuvUWpjkpkkz018CR3/c/T6gYZR/mdHh9hxwgIKodo67f23T6uq?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38593cf8-07dd-409a-07c5-08db314aeb2b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:16:44.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrMqz/T7ZwvZnO/HsD73vL9wFtJPpm8zlEoZ8SXIFOO8J/HjdfsPRVUJPiL3zf3lx7dk3o5yFaPMgyj4aqcxjXUApt/Yi2fKF4+hRKNOHZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 28 Mar 2023 11:36:28 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Each time the contents of a given HPA are potentially changed in a cache
> > incoherent manner the CXL core sets CXL_REGION_F_INCOHERENT to
> > invalidate CPU caches before the region is used.
> > 
> > Successful invocation of attach_target() indicates that DPA has been
> > newly assigned to a given HPA in the dynamic region creation flow.
> > However, attach_target() is also reused in the autodiscovery flow where
> > the region was activated by platform firmware. In that case there is no
> > need to invalidate caches because that region is already in active use
> > and nothing about the autodiscovery flow modifies the HPA-to-DPA
> > relationship.
> > 
> > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Looks correct to me.  Might be worth making it clear in the patch description
> that for auto discovered regions, we have exited cxl_region_attach()
> before the point where you set the flag.

Sure, added:

"In the autodiscovery case cxl_region_attach() exits early after
determining the endpoint decoder is already correctly attached to the
region."


> I'm also fairly sure that in previous flow the cache flush was happening on
> each target being added rather than just on the final one being added which
> would be a significant overhead also avoided via this patch.

No, it did set the bit multiple times, but the actual flush itself does
not occur until the region is activated in cxl_region_probe() (the only
caller of cxl_region_invalidate_memregion()).
