Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D6CC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 22:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJMWwj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 18:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJMWwi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 18:52:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37C159D52
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665701554; x=1697237554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+c/wZFoQ0M4bHKxRLJOtw1X8F3ttcIRojQ++nzEmJSc=;
  b=QNkfiQ5CDv+CGMAE8DdnaXf6DUwLO95G8n6vzb2XGbOsH0QUeONNs0eT
   1k+g2sJI/PbNC9ODIVNiLhvUHwMCB0WDPaDGx6qLZSeLa7a9rwmixRHdh
   59RZSD0en3CkevGSPPhom32Goo78eEaBqU4gbqJCO03Zwk8I7ApRzzys6
   UaxJAwZV2mmvoU87JptRuYUkzc4KF+EI4M61Ji/xvYIBoMSURi9CqDCXa
   b3f6UOjvizCBNfSnPf+f1oq+X151UKWvn6DJbETjycqhSclMWj2wBBjFh
   MipUMsWXDROvgu871wz8Pkuc0PLpiy++3NJuE32fYkdapUOTD3WNxmGRd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="303970483"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="303970483"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 15:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="802420597"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="802420597"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 13 Oct 2022 15:52:33 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 15:52:33 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 15:52:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 15:52:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 15:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+7COvKpqH6CRLJ9HvYYHlT3QI3ptCLzro9MDIGomQNAXH3ZHszA3HN0QUCBNITquDMsnnJSRb6MJq96MJMmakVqru/yTCfRq6KeiLOkidmjh7O4a6qUnWgth0TSb+JmsCZyh/xyIiVs8QzXgF/TOpZf8D64fXSyZFnPjD2MvJpGKWlbzn3o+V5hLuCXF32QJVgDZPcJgz9kG94fSPn0a9qD1UPThAbl70agZUw9UXwj53ory27CBBGwnRPUJGq6+mpUcjBmvYana7nyNDtbeo1ZIgdVuymrtDilHK2gloJh326iEtc5Vc7W0VjuxO1SkAbSgCLzmjjLG/k/XrYHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnqf8oQ1Xsuzhplqvgh44xCMKIulo4aBeEaVIVGHtF0=;
 b=TELmPuzaMhzXJY3pmidOXH8MkGUxhpmYW+VPXIoPKvIhEuna2D9LpgJJsz5lFgqFiE/qJ4OjjSo/anfmSveYHl/CNrQiqITLBQSSMeW3jdKm9/juWXNhEi+7mxRsN01kKlvfRSRjsPNfeps06GtJHw1nE6Mg1OgwTQbFxOdhMU8ohM8Fodi0ccGSUJHrPvwc3gDdnpzmBqC6XmUrWTlGrkhIxQJdqBbRuY5p81qmz7Q904nw27hYuS0VBh1qiSmJOHcr7fy9g6hDv4oaQGGmSrvvit6csj3ufCQXuZuyz9N2gnYHRuNH3lAARaxvV4yXTAjB4qEoRsTE8ggZJrU+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 22:52:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 22:52:31 +0000
Date:   Thu, 13 Oct 2022 15:52:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] qemu/bswap: Add const_le64()
Message-ID: <Y0iWq3X15bObMTXk@iweiny-desk3>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
 <20221010222944.3923556-2-ira.weiny@intel.com>
 <20221011100300.00006c99@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221011100300.00006c99@huawei.com>
X-ClientProxiedBy: BYAPR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:a03:60::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: af6792ff-cb2c-4c10-5ab9-08daad6d9c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRTmoNAyCE8+drE0YjoHgGVlwwtNtXp1QpBlZu74Q1beBxhCXI3Z1oqXyKYR6BGb0JTQWHubjMGK9Kxg09dQcAOVfv3hlJCtU3cnyRgG6/MnXqX0Lx8oy3Nb23P4kRhX33ZTKR5weZQ1HWeZrWM/1g6qLphDTp0Ig2JayTPJHmet4OP1Z74lRKhIB/SuHSIiD3g+KyAaxlqbs7kH23RXdVOmWrP38grbtHjAx7purJo9Mv0Y5rKnnuvIxd6u6Hc2rn5+EE6hLo8GNTocSG3Ijx5J+GXyJBvK4PVpkSgVlPLLptRXdYhdOJcqH0om6nMA2yVuuNMVzF3SyyN3PAsp5RxLzZTvuYCeoiuSd9H8tDg8/3pi2SOUcxT9rmJ6GJqQDW7IvWMtAGxiHHzppdlB8oUl9nknBOfNmbChjkpB9+35zds/ih59NEUyzsongY92aOOB0ZmauYebt3PFEuM54sjp69l9mt74cDLeaM8vDPBFqq484fV560aRUBrXPPzDzpjUaOnKWNnbVcrWlJqk+XiZ7MQGwuNAYTBMauPKbSSxe0ng2wc/OD0hqQ3H6YBKSEK1MiWotH1/jQqt8b+Lfsnx10RvmkuzgbHFybgCwkmCAP/0T99w8ePRV/dq15JC7E6CPRn5C4zAe+cF4mUYZPBBQ4Pd6pZQyelhSbQI0yRcdG/A37YLPNiO+PstCMAq84V9WulOOlsa45QjnJozGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(478600001)(316002)(54906003)(6916009)(66946007)(6666004)(6486002)(4326008)(8676002)(66476007)(66556008)(6512007)(9686003)(8936002)(26005)(41300700001)(33716001)(44832011)(5660300002)(186003)(6506007)(2906002)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6hej0YcZirtxuwlKAYA67B2dHFATNlsKvDpbWjwrVAFl4AyYtnfRm/nJORfo?=
 =?us-ascii?Q?W35Kc2RNNA+8edvCm+tVNxK77HQNFhg7PQC7AK7bqAmob+Cb5j7DXtyO+4Lb?=
 =?us-ascii?Q?Mfutlmdbmx0xXvDDUFxZkjSE6JFm77uFrsVkwoW83wETsbZnhe92yj89NgKr?=
 =?us-ascii?Q?kcHR9i2LIyaAYudA2284IplQijGpn7zjw7e8v5Wja09z91nB21DSktyp2aNy?=
 =?us-ascii?Q?ejyS76nLsgXSJYZydACzefcYv9dbGsUhT7YsNVlU9NKwg9A2pyBZ3WnMhtEc?=
 =?us-ascii?Q?nW/1Jt+hqFkVajzlAHFaL1DjNrSpNBBfcrgzg+CUDjZLom3IzE0Li4PsV9aX?=
 =?us-ascii?Q?lvevc0nR70WcJ7ZIAJqn8Zs40Hrbqp6EduX1RgR3tKxtwTudEABzxDyWRzPt?=
 =?us-ascii?Q?Qu9sXCDnmOKSMUQPZVb3zwTkCvzSt1aoOFQjMF51O/MDUmsajOObQJ+/Xajq?=
 =?us-ascii?Q?3suS9MintF0WSExyQfz9Nx81W5oQUkVvAPSqkzcAQe9Y5w3RiErkHAue/hdW?=
 =?us-ascii?Q?pW/LYxPm61+YUpPALWfKbnbhxdJWQd3ADUM/6NjjEdlB3ZWXjunGY0wpw42k?=
 =?us-ascii?Q?XSIy5qqzh3/ZYU1jtjM6hFGuX39OP76yuSxfJIP4/WJnMaQXMgDjBflSO+bN?=
 =?us-ascii?Q?OtpJQRCDrfNxJVkGRCtsYlkXReaqS1H/Tu78DLf3siDQsBXzwhsoRE6pK2Y8?=
 =?us-ascii?Q?IfG9UslUh8zTPt9czDz13er5oO4ixgfmSOvqR7qAW5dLgpkvo7mQ80h4gaPJ?=
 =?us-ascii?Q?LK+Dlh6AIWrtdVU9lZ4A4dgvhPV/Pg0cpibMoNWS93kK4jYmawRwmYpqsN5e?=
 =?us-ascii?Q?8if+nQhDzsx7XQ6D8WWVMMhjMbhYj3zoLRDYe+jDHCfeKdh5HG8xTiZqeSaX?=
 =?us-ascii?Q?XXlbJfWiF5LclrFTzXHDpR17LE9UCFVZJ7J1w+LdVJDh4UrhMeFoJXLbDig/?=
 =?us-ascii?Q?CdwzkfJ5l07bYb3RA9aFyAXmg5zgQWPwy/ZScMMuZ48sUdkewM4cJtjXL8Qd?=
 =?us-ascii?Q?ilCsVEEUPRgGHn5Go4eG+j202FV6QG6hs/DvmQrk1Eznp9bs21OUWs5vhyjH?=
 =?us-ascii?Q?D70sdcvsDJHQeetogKuZR6nIcKnm1kn4fU2EGqvm+/FdXeR0f+JvjWYyjSGH?=
 =?us-ascii?Q?zr80fiN8prK6LcAuPOPGolKjV3KVuf5Y119CKGq1U/i7B9rhFuno2jsUS14V?=
 =?us-ascii?Q?QhL2yIhkIlvDMFCCESw4AUneupPozLy4UOnPRH/+x4Uq7xbBkM1GrfOA2tGf?=
 =?us-ascii?Q?TqfnpCPgU1i648NhT4dGn+0+hUjpe1ZGnbFMOfHYFgvzimIhjNOeyb7zorfl?=
 =?us-ascii?Q?OchGmS4fnkbDQnSx9gfYNIm7Ma1KqRlFoqVkDqpqOZAE2VRwykM+1B759Qu6?=
 =?us-ascii?Q?P29XOuhfhBTpBcuw6CMv1FQysEfqIAGzem1IXTPLJKhlVyJz+OnDCP1y2uDO?=
 =?us-ascii?Q?6irXH3y7ADgZX+a4xuuVADQq3WW9YYYKppjo9u/n3yNhB/cWuZw0PFi7bIZK?=
 =?us-ascii?Q?HkrUDbcIC6JIV54gBO8yYGKe9xRPtBVBZuRiKv5pAXRxhBhfibmxYRJtQa1x?=
 =?us-ascii?Q?3qizy0saOASIpCxRWeZPcJqvbII7ma9SjmzMpAZq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af6792ff-cb2c-4c10-5ab9-08daad6d9c32
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 22:52:31.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekfe1NsK4RvXIs0kHoUyXgp6O/NeI7a16a0s52oLe8QjLclB/bkBIav3ZgX8Ycj7jSOspebACPNLGCjP62VvQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 11, 2022 at 10:03:00AM +0100, Jonathan Cameron wrote:
> On Mon, 10 Oct 2022 15:29:39 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Gcc requires constant versions of cpu_to_le* calls.
> > 
> > Add a 64 bit version.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Seems reasonable to me but I'm not an expert in this stuff.
> FWIW
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There are probably a lot of places in the CXL emulation where
> our endian handling isn't correct but so far it hasn't mattered
> as all the supported architectures are little endian.
> 
> Good to not introduce more cases however!

Agreed. Thanks!
Ira

> 
> Jonathan
> 
> 
> > ---
> >  include/qemu/bswap.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > index 346d05f2aab3..08e607821102 100644
> > --- a/include/qemu/bswap.h
> > +++ b/include/qemu/bswap.h
> > @@ -192,10 +192,20 @@ CPU_CONVERT(le, 64, uint64_t)
> >       (((_x) & 0x0000ff00U) <<  8) |              \
> >       (((_x) & 0x00ff0000U) >>  8) |              \
> >       (((_x) & 0xff000000U) >> 24))
> > +# define const_le64(_x)                          \
> > +    ((((_x) & 0x00000000000000ffU) << 56) |      \
> > +     (((_x) & 0x000000000000ff00U) << 40) |      \
> > +     (((_x) & 0x0000000000ff0000U) << 24) |      \
> > +     (((_x) & 0x00000000ff000000U) <<  8) |      \
> > +     (((_x) & 0x000000ff00000000U) >>  8) |      \
> > +     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> > +     (((_x) & 0x00ff000000000000U) >> 40) |      \
> > +     (((_x) & 0xff00000000000000U) >> 56))
> >  # define const_le16(_x)                          \
> >      ((((_x) & 0x00ff) << 8) |                    \
> >       (((_x) & 0xff00) >> 8))
> >  #else
> > +# define const_le64(_x) (_x)
> >  # define const_le32(_x) (_x)
> >  # define const_le16(_x) (_x)
> >  #endif
> 
