Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63494C25B06
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 03:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiHLDWU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 23:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLDWT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 23:22:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720DA345E
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 20:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660274537; x=1691810537;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=unhxZCIqkHS1c1+bS2HXr82HR/OtJvNidd0cohAyQU4=;
  b=ejBdAtk4dh6RxoS7NJDaVaZR3Wq1MYcJK+VFO7X0AU7AHbauodTgR9WK
   fNsnkJMNEH2STVQQgzzI41KNzpiKWlbD7hhJWFAPRF0BI3G6cJe3fdhv5
   TvTHY9ZMe4sBRs0zAv4t1sChXegq+9twqpqdghAWyQkf3WM6Z6kEWrotM
   CPB0tUr2pobmBBLExTM8lyGEUhvatisTkJkYYxZC2nASedLyGUvumfVfL
   2xs2WCEImjxSC18RgZMHVM9dWDdlk2WIhgwuuEE17ssiMhASjRmWVxOBK
   J46A2lYYccNMqWaVgXCuxv3Csfv2EuxcYeQQ6SHFCouHNBwkuxeyo1LYx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271895552"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271895552"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 20:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="634492207"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2022 20:22:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 20:22:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 20:22:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 20:22:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 20:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI1Yc1hzDpObPzNCIQM/yTAtdrlsoT3sMO/yIGRB5TD4mnLU+sD8h19ob4EanzPjj713bX4iVdjYva52GdsCiAD1UrIPAnjK9nxAbPY3AmSgT703R6M4+e6rv9z5YqZOsm7gw96KEkInwSqTpb44A38BltlG7r6yDqSxnVjUVktMgzXsaidSupmw6EEAZX/EBe2EC22nrcUrIntxvRY+tod25qWWyJVwHHlMAyRi8oAMKhNHHi8DP4gy6sEMYu8mRu/GfhemJ+Gwj+DzJ8RFvZR9I09wMVKt+Dc9cqOQLQYCv2SZcjTf8TS5oymTstnrSMi90LS+WsQHYzGk8CXdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6glFgQrU282hu5U69YH5+1Hoq0R/W2FZnzJDo1gICFo=;
 b=lDSfoA2FTFJ2W++Yll6WfGLU5tsLEO6MTpnIQuLNye384qiTC5XT5Cdl1Y/pgTtkQ/8ohvpfqn19IXRWpzoXd0MUPK6BfvXx56VF10dCEttbJr5Qi3YWBLLLgYep9Eih0GwluaL+fFQJm4EAq7WkC87hMVg/bcANLTHSr6emo/YqIrtuECBI35ri9q/6Kp4kMWEfe8O4ydXReePXrPcMj0eSTtxbrIoKAamOl36CNUVh0Ue1MPZe3Dx1wJpG/wQ8Gxtssb3F4lFH6MQDf6Wi0j9Y3Hndg2xFZjwsokcBsfFIHuvkfwvdb34Fy02LXdIo79xQyiA1j2gAZBHs5cMPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4125.namprd11.prod.outlook.com
 (2603:10b6:208:155::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 12 Aug
 2022 03:22:11 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 03:22:11 +0000
Date:   Thu, 11 Aug 2022 20:22:08 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 0/3] Add sanity check for interleave setup
Message-ID: <62f5c76060f1f_3ce6829494@dwillia2-xfh.jf.intel.com.notmuch>
References: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4ab19f3-717c-40c8-020c-08da7c11d812
X-MS-TrafficTypeDiagnostic: MN2PR11MB4125:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dium1FT160DPr7FnynyEl+s2hp0TEw4lW9Pjs/+PNkHgtXamNlvSpqqrHmTsfLW8va2YPzpwcsmFqZjBOzY14NpYLEOlb5npG57m2RG5kBvvfi+qOd7wrX27voedSLXfLzqbUXAX1QWaZeaSbe+O9L/dUe+BEwvnuCTgktH/0xHRfYSoKDDQEdLc2kEoFn5xwQSsJXv44ZUwfndV1nsc7nK8epnhOpLjoX5u0UL327CS1GLIpGFmPYr7CnBablDovfx7PW3yOqJ8sjGE5lSM6AFhKLG++cgl06oFyA2YPXi5yOVxZ4WfeZmgQOhfPOiYAUfRt8OQ5YrZe+cjgH2Abe6ZzUbhRrA6w5TbbYAQzBYagK5aZPvXIq41c787CxAczo8nthCrErDH/OBrllesp14toc90bjviX752m+MgoFfZTFY1AtQ+/eG3ADXi9GVy36N8bQ1qaIY/hRURxN8ZpO+e5juKlH+8CYRvQg9gUnkzmEUgRGkvNqp7O0h4IyqYJxiGNx32u1eZNP+8AY/t4hD0E4fmGf/INPdIHXt3lZXjDi5OI8gEyFN4u08TEmdWEvafQRTdxijXYOQEBCx9uQUHustcxbPG3FfJdIrryMY/DPvfzwe4cq0Z3a+RyJmehdLNQnWGTfv7p8crqp4/w+zxZoz+Orfuo2cOsDxqX48f268k9+zDgbiE/3UBoDSMYSqAV8eJ2w6f3tBJLjY9xR0EwJB4CpDK32nmPoy5IT+1CdYGFVH2JRQByjZyUn8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(83380400001)(86362001)(82960400001)(38100700002)(316002)(6486002)(478600001)(26005)(8676002)(4326008)(66556008)(66476007)(6666004)(6506007)(41300700001)(66946007)(9686003)(6512007)(2906002)(186003)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M7OKPBFL0bak0+w7F5pz7DWYCwDufeal9VKmkElDyAH6tGQ60bXJ4rJbrY3x?=
 =?us-ascii?Q?juVX12FJs4epY2QgZl9jhJjORz4uZHiGiKDxHiBLvmC7+rOLg9REEVt2X4VM?=
 =?us-ascii?Q?XSvrpOk67QYeYgDIk2NrFX0CwErVdY7A37jNEf5KLVH3KJmZrqly/l/354Yr?=
 =?us-ascii?Q?tkiCy4c7SIZk2GjNZ2HOcW0miCE0915Ixf2aQdvfdwOHSJls6okSw2uCDHq4?=
 =?us-ascii?Q?50VWQk5epZHI1iUUu4khQN7UGwlmgiIFhzytrDcSzWXSCKAbiEkYUkPIwxYy?=
 =?us-ascii?Q?IAF2OTj5fKj4xna+6il/s3pftZc6N29R2SdY0G2urSkdhcMqMQ5ZwerCbSzW?=
 =?us-ascii?Q?Wmd67mtTiCDKQjyfrv3/ORKJnchbrXw1u95v9YNkfG7sh7C1GXPRLWJfXPW6?=
 =?us-ascii?Q?wzWmf2tnD00GPfnzHWia2mnvVQWCiBA+AWjOVzN2AS1nONMFs5+7RtDfwTEi?=
 =?us-ascii?Q?MYCE7xrMURUWOThrVDReT0lX41BnBXiU1m9RfPzW2XwaZaU/+mc/PvimnORM?=
 =?us-ascii?Q?OIxp7Y/Q779D5upgdkpJo/l++3voSnLg+JmZ2ippLsXwOU9Q4ug7wX4fYVGO?=
 =?us-ascii?Q?4YB4AJN/pCXFtiiZIAoaeTwdqav/MbshX7/xu5McgsyeY7ZMi07TXldY9sUH?=
 =?us-ascii?Q?CBANetPZdOzpeRopMOzYheIQb/xc1Lq4Zv4s+RNcWQccXtuydYNerXltEgHU?=
 =?us-ascii?Q?eqoYD47SJGl08t8WuksjoxbPLRwM3PjwkQDI0AJKlGUBNICVTPLkko/WDvC8?=
 =?us-ascii?Q?+w8yN77RkmR5rbsrwNbUc2+bN3DCzvJQ5kAslJOnFw1kJ51k9aTERiGt0JPr?=
 =?us-ascii?Q?+TSNqFLppfVbRqZ4cSL1tDLzGsHq93tp4nc7hof0Mc+VkvhsY4NH6QJTigb0?=
 =?us-ascii?Q?9/C70Z0cGvDW4+rqSwSrRl2/G6NMgffn91bb7DVhLM33HN+OfPj7v6H7FiWa?=
 =?us-ascii?Q?3xJPl2vHxmHLLOu9hDwdTgkQ8CT+NTIAnE+NxZtQ3R11VVu4e1ZEMUNen2ik?=
 =?us-ascii?Q?WnlOI9m7WqFTIkCqlQqfGR+MnZQKYHqkQ3ZqIqC9uAke4Wcql0ec9CpotzXt?=
 =?us-ascii?Q?yIR1jxCPt7/l4HbdgehCW1Swwf2pTJZ/LvhhymcutG+ETrxeDcks5p55T/sh?=
 =?us-ascii?Q?7v2s1kqEazSHeRhHIsHRv4Zy7CsKaoRj1RUkkrAyoPNKbu9D7sL8sdILpOR7?=
 =?us-ascii?Q?4Vk9BdyWFxgCYObEje01j2J/uqXOMmEoIySAGrFJBW73XFRDvYwdFwOtG5AD?=
 =?us-ascii?Q?imaNI0TA3laihVTKGM0opZWQmpgONjQH/m1PcQO6vxp968+RW9IFl6YpvCen?=
 =?us-ascii?Q?eFL71QgwEr8bAPu2mVjyfI3DVRkI7rItdjE/x7+nzAaAcCeuu2OyfLxqyWSO?=
 =?us-ascii?Q?HEgQN5Llg62455T1ndBJs9+kKExIB30fv5SYUj+I3hzCMRK+3+XmoH/iXX8b?=
 =?us-ascii?Q?UmsO07VxgnTVuMzU3yrYxDeASVKxh+o3vfOUNrNgCIGrXjX/m+4kQlC8KHV0?=
 =?us-ascii?Q?fMpMX9Po0R7A4WyRG/lrJZl4I3iAJghyyqgyoMsotoq0s1Sm8HqiWrAf0jqE?=
 =?us-ascii?Q?6nvHpLY6H/9/6imGJRmI3Hm6c+o2FyOgz84UuZC6Tdg36p0SRiXoG7DBDqUD?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ab19f3-717c-40c8-020c-08da7c11d812
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 03:22:10.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQNycdqC6g5GXBvTzku6ENU91H20qj9wng+AJeh4gJ17ZLwpG1Pr2M+i5Dw5IvMwjBvKR+TmZ7pPtVTd+K3lq7Kg9MIKTtT0IU5JgNYlMJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4125
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> The small series adds sanity check for the combination of interleave ways
> and interleave granularity during region and port configuration. The
> calculation references CXL spec 3.0 8.2.4.19.13 implementation note #3. The
> checks also added HDM CAP retrieval for the support of new interleave ways
> where 3, 6, and 12 ways support as well as 16 ways support.
> 
> v2:
> - Change cxl_interleave_verify() to cxl_interleave_capable(). (Dan)
> - Move error output inside verify function. (Dan)
> - Remove unneeded enums. (Dan)
> - Use is_power_of_2() to detect encoded interleave ways. (Dan)
> - Change iw to eiw and ig to eig for encoded values. (Alison)
> - Change interleave capabilities to mask for easier comparison. (Dan)
> - Change valid_interleave() to valid_interleave_ways()
> - Add setting fo interleave_cap to cxl_test. (Dan)
> 
> ---
> 
> Dave Jiang (3):
>       cxl: Add check for result of interleave ways plus granularity combo
>       cxl: Add CXL spec v3.0 interleave support
>       tools/testing/cxl: Add interleave check support to mock cxl port device

After reviewing Vishal's create-region series, I think this patch-kit
wants one more patch in the next posting, or as a follow-on. Add
'interleave_mask' and 'interleave_cap' as new port sysfs attributes.
Likely they need to be added to cxl_port_attribute_groups since they are
only valid while the cxl_port driver is attached.
