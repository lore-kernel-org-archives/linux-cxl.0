Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D610C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 23:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLHXGm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHXGl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Dec 2022 18:06:41 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992BC6427
        for <linux-cxl@vger.kernel.org>; Thu,  8 Dec 2022 15:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocjkiapfCL/Ig5pn56m1YZUh5VWhd/LEiwoTVW3uu5BzKwMMbfT7xZ/eZbSZ+asrJXBc1DOhQwZ71akGAks8oyrmII2Y9dFj7orQ0fPGQVJUxuCPL3Jr3v76grIsySsmqhVebGOMAn/na8QsHs3KpL7mKlEl/9mS54mkjaMb7nM9EWLqGVMxxGBoRWXXG32dRaeUF3M5fHDNdh0SiZ0a1BSCe7pmUTRgnGHqEQgcqEXglhx4nOlYxEEWXE53kUU/zF+6NEGqPkh0Kez961qcNWl8wF4dWK7x/ymDcSnuRW1bY4TobCZC8MS4HYh+INdiR9GHqHYhZ0f90x8PCsSEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBm2BqJFi6IgSi+hknI7CO2qPLWTWVEzqLmDVbfrpAk=;
 b=dG8JSzbSMgHLUchXsAL5+o6jf2qkFCq13sbmaj0mRuOAieOoJY6H6ZC90zspNvCMA0C4B4FbN3s8bUyR1q85Qw9jbFNLHrm1YuiEHdVwbtjk6HFgRBlKMt4IRfjSqmYKVA8BABXiP7hG8sz8/ewNq6alskn3cDzelyv5+oCz0D6HghQTx2tqA7NZiu1xO+Iz1T6n7WSZAtWRSpKfigVTDKQpYU5Gc8vMMfvUqwfL6UDdVV8dDG9JkE06X4fH9kJtIxk+YExbMSgvdf55fAedJLsVlb4gHBlUTp5SU87mqMi0J/x0W0X/GGtPQ8tfAGCOSWL7spSkT/tUZzM5q8d4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBm2BqJFi6IgSi+hknI7CO2qPLWTWVEzqLmDVbfrpAk=;
 b=nP1S0nF33s5mKB7mtd+RDYgE6JcIvAIBigh8/vEoI+A5S7EW5xnM2J2IGeGSz5JnRiXjnPTuBDzZdzNySyRB1Pny8kW54bi6Fpxg9BndIgh40EV77rfueFU7X9cUL+Q58edfipVkqdXHSLbwKPiu940jiAnbS2V/A+zJoF96jJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by IA1PR17MB6672.namprd17.prod.outlook.com (2603:10b6:208:3db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 23:06:36 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::3299:1f35:894f:69df]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::3299:1f35:894f:69df%6]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 23:06:36 +0000
Date:   Thu, 8 Dec 2022 18:06:30 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <Y5Jt9iPs8GX9EMug@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
 <20221128150157.97724-4-gregory.price@memverge.com>
 <CGME20221208225559uscas1p1e9e2c7c8f9a1654a5f41cef2c47859a8@uscas1p1.samsung.com>
 <20221208225515.GA2510517@bgt-140510-bm03>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208225515.GA2510517@bgt-140510-bm03>
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|IA1PR17MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9f8e4e-3cd4-44e9-4929-08dad970db1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yn8dIaQnPaJpn5jFLj4dpga6x7+JMz1p14W2lBHjzZ/r+oY1r/hvh6OMXb5ENilxIh184SbFpKHXlfWm8eZj32M2przJZBsfbijKuBlpmdoIGQSK28tXSHCJcK6kVTrOP0nhjtrYedAm1o4iWehKlHQLS/w6Nqycx0AwGSYXWPJ5nvL/jFYcacjoPXKqYwsV9u077IpMhDbP9f25JG+2Bl1sGA9fPDuSmUtN2uFsFX5CmsQ0ITZPVGXqOLnKAyig4C2a0TOyNqz9g6I3ePgnPkEPViVlkJIChVMBgcHNO22m5B4bdLEgXyA5dAOoc8nxVJ2F9Tc1OIOHPh8s66BmKpYz8Nx+7dyTBIqo+awMWRkDezmYQvYaYRcPiG/cWlyXFSQtycIx+UmPtj0ovcOElh1nVmqZSZptMSbhxQrVlBrXiiLHorJFpJeIWhMcYVlxE3rbd9xzS0cNhif36tBWaWwEoZsaKVdSuEvd+VpOrdX1zePtcoRCfizWTGOPlvFNSQJXOo+66YGim2WLIVUSYkNLouSg4yvLQehse5afR+JTQa8yQkcQ0We9HRcJF0W173o19nt2unq5wiJvSc7GFgnFKKLqCn9sMs5SRTMa+lz8XY8VbRhG1tkhnFSZmS7h8WzkYn9YgSl7xoGsQiNsHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(39840400004)(366004)(451199015)(6506007)(2906002)(86362001)(6916009)(54906003)(186003)(26005)(6512007)(41300700001)(2616005)(7416002)(316002)(44832011)(8936002)(5660300002)(36756003)(66946007)(478600001)(66556008)(66476007)(8676002)(6486002)(4326008)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6aWgm5bEBBBsYf4k9Jgbo+TbYxBrYd8qBsrzAWMOlEaiFwDnpiKPLhio40?=
 =?iso-8859-1?Q?kcui3/r/92aeSuYDAKQWLSby4Wd8+SXiLMCezes8kWARBeSSsESVX57SkQ?=
 =?iso-8859-1?Q?nAXGCt8QhMPBAUsP9OtVrWsEoTPkvwmTWJBiU1mNPpBj3jc5XuL7CuDdTl?=
 =?iso-8859-1?Q?Oz9BSW+E1YJks5rcEc0Ze35db0EeUUbckXLYmUIs/Wrs7T9SuUEGNKcgfU?=
 =?iso-8859-1?Q?eKn54O9Izi+r2sd47Fly3wjbJoJa07hmTL3en0lwnDJfgGFUbDKLZhQT0d?=
 =?iso-8859-1?Q?ThMbcBjVqDSEDalnkcF4vRTs43y8jan51Sd7Rss8euP78tO00yr2Km+j9I?=
 =?iso-8859-1?Q?gWhK5LFBKLe6YVxNIZlcTMBBCXttFNbv2K+tIaJtyjA+JBHYcjzrKPouoS?=
 =?iso-8859-1?Q?nvSVJnPBoSucFdEDXYnaZeWp3sK3hwT5M0iQ/Im/PIK++vNEkoxk6bNi+s?=
 =?iso-8859-1?Q?AWV6bWzalyDQ67Jq5eIxQ32aNo64w7hB5QTpGVIWDICndI7yS/9DpEGWjM?=
 =?iso-8859-1?Q?n+kNlJ1e8oysOZ6+QE4GtkEY8b4DUGUQKhj8+7++QEZ1mY1yXqpw8YLt1d?=
 =?iso-8859-1?Q?joTU6HOJDkCMIfkqC6iRRyq9Mk/7ipDIf8hVkxbMJ8CpcsfhDW5tHC5YTr?=
 =?iso-8859-1?Q?HtKiRY7BIq4wt8Y/k5b0FrGrNLkZzo9nuji7+jaQ3GGSJw27UJyWjTmFA3?=
 =?iso-8859-1?Q?EQw/pUIR6rh6tvHYrL6g2tna4A0TNyKIdzZgM+7HANQsl707w01TsHtSY/?=
 =?iso-8859-1?Q?XZCCkVuqsdLL66bwqXxrgXaVYUR7FM4ArE/riaHD86ibrWzBmWpuZF4aui?=
 =?iso-8859-1?Q?+j8BVM9nRWfmUdHJ4K9n/IqzwA00rR7jEgJVNAOB9taGZ+U7mYEvnucfL4?=
 =?iso-8859-1?Q?SM7Vk4ZxbC7xr+yUiXHYR08kHCqv0pASIl8lArL+e569b1NoXJhS4ny3xo?=
 =?iso-8859-1?Q?fDeyXs1Z2H8m+aQeuakP6sTkT6SbFrntXI3JNj8/WQsCQGd3W2YOpREF6x?=
 =?iso-8859-1?Q?TUYE5+LlwMg5By4busLr2u/PC9lrm7uy0aIZ0k0WTvp6WSGvu8aqDwPviQ?=
 =?iso-8859-1?Q?JwqstMMDiOn/ZWCISZiJVOM8aYd+ze6aw51pINMmFGLClcNLHFJzPqPi05?=
 =?iso-8859-1?Q?lOXIkhA+ywynoFMXNZ4In76xvmVm+LYOxQLihdWuQZHZrtiUyS5a13lB+k?=
 =?iso-8859-1?Q?iLGG54/Miaoy5SdGOvBUW3EUjwzGcUIRkDnoZY9EcMB/Jxo3tmjut1zMPl?=
 =?iso-8859-1?Q?FgZOXKcgMh9O6vSlO15D5zrdpgq2aCHwp6vbinqTX9YWZnq4yYV5KOjyq1?=
 =?iso-8859-1?Q?vIBihgatWhPCK186EN56MAnq+bChXWyXkf9ZNbhL7VMfwSPgLfaAokp+f4?=
 =?iso-8859-1?Q?47oeXYPgSNvT/wWgzr+R44zX/6vwgjDLpmVJdLhbbjjE/2rxQV176cdoAt?=
 =?iso-8859-1?Q?XE78kXGGr24FEgyt+W+5JI8pHmt1KvGUbixI2GNT79VK/8yi0nx5H7hZW5?=
 =?iso-8859-1?Q?SQfNfuyuDB59a/x6DkJjts2YCHobxGuBBlpWEwLF59sMJeIrGnESacBBRU?=
 =?iso-8859-1?Q?gD0sLsmhaoXP+ofCN5EPORoFwZrVDrtLkEybRjUsCdYHHTJg6+hSYToSXp?=
 =?iso-8859-1?Q?l+FHqd+y84engqDEpyq5F2ek4S3gWI7DjpDX8UmFh41Oe9fZgr/7v9sw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9f8e4e-3cd4-44e9-4929-08dad970db1b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 23:06:36.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR1z5nyDM+xaPPEwrEo8bKKsh+Bwgq/bsU2obelJllC2RSqeYVBqWNE6Kao2wmscDihu+fRMmxX7aGsC6x4W4Q6+Doh6INjN2PcaHvre/qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6672
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Dec 08, 2022 at 10:55:58PM +0000, Fan Ni wrote:
> On Mon, Nov 28, 2022 at 10:01:57AM -0500, Gregory Price wrote:
> >  
> > -    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
> > +    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> > +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
> >          return CXL_MBOX_INTERNAL_ERROR;
> >      }
> For a cxl configuration with only pmem or vmem, vmem_size or pmem_size
> can be 0 and fail the check? 
> 

While nonsensical, i believe it's technically supported.  The prior
implementation likewise enabled pmem_size to be 0 in these checks.

> >  
> > +error_cleanup:
> > +    int i;
> > +    for (i = 0; i < cur_ent; i++) {
> > +        g_free(table[i]);
> > +    }
> > +    return rc;
> >  }
> 
> I hit an error when compiling with gcc version 9.4.0
> (Ubuntu 9.4.0-1ubuntu1~20.04.1), maybe moving the declaration of `i` to
> the following loop.
> 
> 
> ../hw/mem/cxl_type3.c:211:5: error: a label can only be part of a statement
> and a declaration is not a statement
>   211 |     int i;
>       |     ^~~

Moved the declaration to the top fo the function with the rest of the
declarations. Good catch.

