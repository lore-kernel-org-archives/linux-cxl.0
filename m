Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CA0C77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 20:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjERUTY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjERUTX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 16:19:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A957A9
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684441161; x=1715977161;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nbMTVyoe7raqD7/6iDMJWlY+IqSbzwK2732iS8+dles=;
  b=g6XFkyey4+TcTJ70BCdHYN0NmGlsWCBoIdksVDquiglJ1ipjxMGnd3+E
   oa4nerB6BPvreoSYaqu6HTlozZRlzraGCn5TU0Ppe2esyxQG9sWdBtPSD
   FleKtfoJ8kACzkc/NJxa8v7wcnWQk/+J5BVlsqkxl92crU5+Dlj71exYQ
   rMtaXrX3tsGhsp3/Ut3cx8FlDcpUxJ9twbA2qMK1/RFtCARWkSP5VpCQX
   O+RgziYItA5131p/k0afiyGZBo/dWNZvFC5t3HjEqMsmZotU8ITVxD964
   hOojM4p+z4wgHifZT4DAeQuovxIZMQeu+HPGI3p+0NShsYEn7eFfhwM74
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="351022774"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="351022774"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 13:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="1032335184"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="1032335184"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 18 May 2023 13:19:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 13:19:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 13:19:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 13:19:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 13:19:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeYOG+5Ht/Rlywk5Rf+u4bdp172cya23zAKNoN/nSKP07zY2mK4Jty6uw/l8fX5j159hknFX0rBcj6QyMErfvG0Tt4PXlW/1YM9LORRtbTkonw5LdONxgz3teRYtIEUnIpSY4c0CZ+OBFjdEbu2WfWO1ycawrU+G5XsfPPST6q8PSwI1vjNyylfBGu+zhuIIVmUQNVAe0pMl4zDb6LmjGQU3xJDdb7ppJxMEyGzhizDfCRqU6W99I7LjITCWxjUjyMsNFI0JCVKtQ6ZsvXuldNOWmJZbn+tGH8JTl6ToBGgIoF/02H3clklV5xnBCZF3Bl2q2IEEx009t+19QUtgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWVzQxKAQkD2BqllWGNzJ+rfOoVgAp6heUumGFTwni0=;
 b=PppYlU9xY5VDSE0zioxxzWiMJ3zqRedsOoZHEeS6thiv/B8TaX+xCe+0Ho6HPZKoAaALglAWTY4z4rv4f5NSO68Va7Vf2RbEVvLTDvxUsUUk2ZuA/zb9aDqRUb8Y+P6baoLdPpNEDsrnW5ZIUIVALn2Hyl/DUAfekaZYv20C2DVAVKCHPIsbXdE/ehQdm8mLuSIpYBjzNwjwwfnA2cGPtRkE7EtOiurV74GLEgqsjK/q5JiBajoFL+UZrJPhteZ5hs88+dzhiS+Lpm3p3hB6aDCwOPzZq9+U5E2o41JtWcekRH+qyCaz64gVHkamBHqY7BTil0kU9Z224RFj6oSDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 20:19:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 20:19:19 +0000
Date:   Thu, 18 May 2023 13:19:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 1/5] hw/cxl: Use define for build bug detection
Message-ID: <64668840a067b_114f6029416@iweiny-mobl.notmuch>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
 <20230517-rfc-type2-dev-v1-1-6eb2e470981b@intel.com>
 <20230518105416.000054c9@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230518105416.000054c9@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2cfba9-edfd-4a6a-15a1-08db57dd28b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqToWcm21ACpPOA+mI52DVDtHa8dg+dcmaMCh8R6HMDqBY3G+mnvNNK0VyDmmwq6f8zjB4MudS3GBCn832zbqFTeYijryU1oFT+iC1UFTrfBd/eRJl2bmR8bwqe6cBg+VLZcg/xiWDuZt/gmcWBY+c/nDX7M1UARoz4C0s+L9ljWsCjJfrQZiXXuHBn48PXg9m5fYRXdK9aTGBk7ZUfQpc9NUUSBTquOWn4ZybjzUDZbK2uhyz9H/WAq+NL5A5NnygLVBT5uQ7VfuxMZo1QkwDyJL7X6Nti4WmjBS+uspXZSJL8LOWJFnwn26QAcYsNLnDNwA4vyaIRuq2hXIXJIc7+HEzcWaaspKEL/muG3yNCZ8uhrXspUZcFXPc+UiweUNDBlfgr1vCRgft89LDo604yNXte8W/Yu6L2xwNVNXEtp0WvKenaeTv3ZY1Y/qO2vJdhTa/J/ledlIkQnyJjB+hgW7SDLQUnj/7t/H5uUMbnsLZqCxzjOf5EfyQMPtu0RkkL6V/hByjpLU2d4CYs1Eg7LKmVjdXEs76dJxB5bsd/STyPoeIaykKlRxnBHr+TR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(5660300002)(41300700001)(83380400001)(4744005)(2906002)(86362001)(38100700002)(82960400001)(8936002)(9686003)(6512007)(6506007)(26005)(44832011)(186003)(8676002)(107886003)(66946007)(66556008)(66476007)(6666004)(6486002)(478600001)(54906003)(4326008)(316002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RciLKuPqNNJ6Z3ScwQGJolwc6Zj66uxAAJMo1R2HVEr3D79KMG2k9KOMw3Ak?=
 =?us-ascii?Q?sVq3OrsUfq5AOk7SacZEDGTV0D1JOqm7JJrRtDtHHNicO+T7ZYQON+0isQEt?=
 =?us-ascii?Q?dBJeJzvLTNurutUrx6WQ7BfT6aJoW/7Twuia9B6/fG/7nmGkYLzlmzyPxfz/?=
 =?us-ascii?Q?kYgGlX2DsVn1Qd8B08alXn7VvfRXr6UPMy49o5QYudRYdz6X1ht64qj75qpY?=
 =?us-ascii?Q?KgZeC8iCPhA+Y8RTsc3+TCu5VQLDViIpbRbUNRqXazBDTymN70eYqHz2PbOo?=
 =?us-ascii?Q?Sl700VmNxJqxO4hvvMiuzz+px7SCe8CDSZNd4BfwLyt7j/HIlx9uje0pTW5o?=
 =?us-ascii?Q?rF+v9p5JMmPq7jmWZAeZFhe5AmQax2Ta1FNMNe1AFuMF0h9PhLx7AdjNkPrr?=
 =?us-ascii?Q?67TEgPopuL5bftmLt7JIV5VXHVp2YrVLyOsqAvoLgQ1gbB+3BmeDPCFRUDRP?=
 =?us-ascii?Q?YpxEkR278LcCVRZDdBByjbwmrgq9Feh0OCC74lsRDWGxr3UzthtFo3JO5u0r?=
 =?us-ascii?Q?s9i8A6BT1efu2K1R5JiTfmKvrxcl6xB0KoSwpgTiERnezm62Csf5w6fC6JCN?=
 =?us-ascii?Q?iuK8qq8wpxUsTjJ4fb+axHxXN/04bYsM6iWWusRtnDJXneeHnGopKTYDQMTj?=
 =?us-ascii?Q?vtsao5wEvphUVdVnTq2zPNPFz40MMSl57QuOHxh6MdtlK6lLsATEM2DbpcYj?=
 =?us-ascii?Q?bAlEfVsBf6uM9jyhcBZYmivUfRz/2yJWAsM56ODjxXKVdQQwIrJoPKY0e8c6?=
 =?us-ascii?Q?jo0oxQVm5P7iOhDGpDrOORMeL78vnYjL9Va4uMorQ074SmWSVs7B+peunhDM?=
 =?us-ascii?Q?bEvPoXlSJCrWWR2tX3hTtGg78qe7UbnViorxDX0sEG1gP2vOWcmkVRjkNpp3?=
 =?us-ascii?Q?AqDxedyVsBWYAPcSVa5/XnINV6UhD7LuaVRdJv+J3GCZn4BafdcDLknEJgpy?=
 =?us-ascii?Q?ua79tFZPB3fyOgUFyPWzsdqmp0a9h0eJvHGuEGkg+KXFFTx/iYCObNd663X0?=
 =?us-ascii?Q?kOXiby/cmtPb/pRlmbe8WRgDxYmycAWtG+xT/Vj8+GX8FKv0GBGfC7LctXjJ?=
 =?us-ascii?Q?Xd/tmP0phU07SguXViMzRu0A8J1XDg8TD+SmPLRX8Xl+1Enens4YBxiSBkEl?=
 =?us-ascii?Q?2tBHM6N6WKBi/s8IIoXO1ozKz4Qywlcmp6+VbIW1FT7OD+yA+bGqHct58vUT?=
 =?us-ascii?Q?0q/bJdWgB2Ok4nZZO+jF3maIx/X7yhm1QaKdVtAjB75OLiLn6Ojlugc4Qitz?=
 =?us-ascii?Q?W+tgdPNZGtm7WmDxndXsT81FiHLnP/T9gCQGc0wIOWtsbIP4o8Wodb9kqLGL?=
 =?us-ascii?Q?n+sMUhDCDZVmkR9Xsgl0uvHw7t3zItL3347yp1OyI/++8JIv4A4pjL2mJgpS?=
 =?us-ascii?Q?P6PBINLVCbkh0rkBa++4vcUjXJONcVfllOlO4/rzua88HrOGNsz9twMK2fCZ?=
 =?us-ascii?Q?C8983kMjxiT3bfhDHM7L9K6TSuGV/i3Hy9yg3bpEAJOnKldBDm/cXx/+y4kW?=
 =?us-ascii?Q?ablOxu+/f37z1eTEsOXUq2SRTTr7YasklFn6Ix1f1GBSiy/f2J8ndfqD9Rls?=
 =?us-ascii?Q?8hfNOhJQ3OKs9l5lOP6NS3kseJHLzyChhotI/zMT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2cfba9-edfd-4a6a-15a1-08db57dd28b5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 20:19:18.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2njHQI01MCvZ5JVfWT2VI8vG+BLYCjvnIYhQsolH7UMPMNM7YokNnHhW5MDOt0wDf3+zBg8rL/VgbXK1dwIcJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 17 May 2023 19:45:54 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Magic numbers can be confusing.
> > 
> > Use the range size define for CXL.cachemem rather than a magic number.
> > Update/add spec references.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> I guess we should do a scrub to move all refs to 3.0 soon
> given it's horrible having a mixture of spec versions for the references.
> 
> For future specs, we should only do this when sufficient X.Y references
> have started to appear - I think that's true for r3.0 now.

For the kernel side I think Dan is taking the 'if you are updating it then
update the spec' but otherwise leave it be.  So since I'm touching the
code I updated it.

I agree, it is a pain to have to look at the 2.0 spec but you can do it.

Ira
