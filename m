Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CEC433C1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 22:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2D2619D2
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 22:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhC3WKM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:10:12 -0400
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:41313
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232884AbhC3WJp (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 18:09:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQor5Y7YjEknCgehKPWqOyosC+ri+FoFNl07ASjZ0LhMdR0P3xZdMxV/boIcibWtAohel/2PaV90CjQZvkQhmZ+SlAJM6SN6PgcrBbdR4lyZ5KEbwfvnwNXDaOtQiRfm+TXPgiwKOiwXHI8VvVhFhHbVxwqz915xufZZmcBoeUXmBUyanaA4A8oF7p8VbQBeYL7WJQwZGiHLMKTIlLWN/o4hWgdU9YtAYlNy3MCKXNHt/SLNHCXCBQVNYH/KIeVaKOT7/CvIjpY2RklOUUNfxmEytOaEnGtUSFDvOfjxZ1cKXl6UOT4n+HNmkvZ91S9cTF25irnaBnAuKNv987CIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uku2txP52dfQubAmtrEpOtcgJjeNAv+5v/+E/8S5188=;
 b=F5ADvDJdLl0EYm5sPbHd/5otn7bmXg5bSe9nCWsJ22Bj5zlu/tLJKoGdNgHtsHaIMXbvhWO35Vxf/bv0o0cMussPZjhom1IJawKJWr/SEBKE0BNYN3nF6pZTdVpVmAuGKVXwjo7CnaWsfQdjFY87bzfsxVCa+6GIPEIryNdCpkJTv19E4jBofJuBTHmzZ+mreZgRFpuEYZLP5tMxjButwYYLVQKkonh7tWjWytG5gx4oMHS2jbTfhfrIw5i8kB1mL5+kcn5DG/HxTSpldOLrv/xmi9NePJ184WYK/qIHSwxxUYMEcJsCxP/LZAaFfdSfvVWM2gkb/8xBVLIPPECOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uku2txP52dfQubAmtrEpOtcgJjeNAv+5v/+E/8S5188=;
 b=bFSIAkbuPfAv21RgrvaidxJODK553ZtN5NnqNEMgrXHRJ3p6q6XuYuGrRxZSgJLiXOhoPSGQGTNr5C5iZ6j3++qEym0h+qU8rXi8Jp2kdhvYOrX8kgn7mgdrXwWlKWZjT9u+Z3nsMJIC2JjDzb1k8XgyQfi6rqU3TTxKAnA8GuzZE0FYJpJcj1ZCED1MdsawY7oSX3TKbN9pcv41ICFBQQZEU9X+7I6PhYmX5lmIGXV/fktZCptqnOK7wa7OL+jBUrvjefjrAeNQDsmPIja+OW2/Z+FOhv0Rg43AYusdzajO8FAD5/gCwn6UyD1lo4JapTny5mxvTMAJrmumxyq/yw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 22:09:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 22:09:41 +0000
Date:   Tue, 30 Mar 2021 19:09:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
Message-ID: <20210330220940.GB2356281@nvidia.com>
References: <20210330154712.GR2356281@nvidia.com>
 <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com>
 <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
 <20210330175431.GX2356281@nvidia.com>
 <CAPcyv4igMvwfZNgi-Uap_QUJi+uocMUD3KZBhXUy56AuHZQtqw@mail.gmail.com>
 <20210330192608.GA1430856@nvidia.com>
 <CAPcyv4h1qgQAP1JT88rWOf9xZz_1o2yPvMFETNY2dFn17uFwhw@mail.gmail.com>
 <20210330195143.GB1430856@nvidia.com>
 <CAPcyv4gwha+fgLbW_LCqRhRtC+N6Ws2Cnmv==C661ccv5GoOdQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gwha+fgLbW_LCqRhRtC+N6Ws2Cnmv==C661ccv5GoOdQ@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:c0::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0036.namprd05.prod.outlook.com (2603:10b6:208:c0::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 22:09:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRMYO-00668j-5z; Tue, 30 Mar 2021 19:09:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fe6d04b-468e-45d3-0876-08d8f3c88473
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107335555E27479659E645AC27D9@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EoHIYCSofLl31YsQpGF9w8TkSB5j47YOAHUP0hn0hxjK8BksrVVlk0fQlQvD+SlEQMh7PBsXJCDdj6pRtwtb6VkTgtqeDinR/4ZwMU7INO0ZRR/KwpZIk9L2acRYZdo25APVurNmwwWIELPhSkCwhpqrdtzKk2exYqCCKeXLgfLlqz+WfiOFGddx66e4VrjgytO4dbJbmSeWRDhuMl3nSHNnNNFOwE2WNR0nI+bD55L5K/LdxtF2brgVlQNqZk9CgMp0ZqNYHxl1r8Tk5tZe7M2OYn/tD84ZrZCNmJnrK+BftL5CEgkFoWcgR6SjE4VK1o+a3+o8GDkpEdUdzrdPkLGbDZ6CxCl4frrLxy5Lxerp8VyEDWP2BPQO29+jR2FWFFPTaw+xhlvOJ2+zIRv0+oW2PGSoLnQwRIHMFXic+UVCqGIFnlUOrORFUJt3aaOUcZmMOhNMtM0VMlZMTIw56f3B5hrncM/6FMgdT2cc+DqOPtCo81D4Ki1f1vuhovkYt+LcMmO+mKni7X8Kf6rs8F8OGZ8RFKnxrk3EEKq18e8QkfLFnvqRnEWmg+UMxbHUiYvpx6niBnwpYWH0i8Y+iyT6pUEZTKB1W9MyWqch08U+8UWl3lrsa3llbb+n/vJVclk/JBVK9Y81Ez/NNqXKkWHtbywhmtvWvn4wMXbTko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(8676002)(33656002)(1076003)(426003)(186003)(54906003)(316002)(26005)(2906002)(2616005)(38100700001)(8936002)(36756003)(66556008)(86362001)(478600001)(4326008)(66946007)(9786002)(9746002)(5660300002)(83380400001)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rVzXTp+6A8jLokZnSPHd5AvQMoRDJ/1MyskCDiZihPxBgGX5Hqjcic2GY/79?=
 =?us-ascii?Q?L8eEwLjLz4s4N5otb35ctewWt6JCJIa6wmgLosbxFjAPwDvORObjCV3eTBm/?=
 =?us-ascii?Q?K8f2K3jgHNilGuqfBbssXBNEHyiDk2jpfQodqwzhyA+waBCzwvDTN/S8BwFe?=
 =?us-ascii?Q?P47BALAHrx+qXKDKbRnCKkeztTjfj89HOqSIA3emqjyzv3nvLOleJIvsalhs?=
 =?us-ascii?Q?fmsCOkTHKVwmgkj5oekUHR9Xn4J+S/bzvFOt0/k5ySaGbZ5bqHS7vK3oaEWn?=
 =?us-ascii?Q?EerE06r2Gbyz7fwEmUdG3qpYl7V99AuqpvT0GYB3lP61QK3C9561e2S7P6o4?=
 =?us-ascii?Q?MoU8POgZuz6YyXWzFAkh3FevYguuxHfKMADLWuRrITiNj/ZoKOBP4wJ8SZGp?=
 =?us-ascii?Q?EXzQhf8YcePA1zsBKwilML0v+HpbUP/eyh1T4x9XCZdFSqQaaqdPXmA7iilj?=
 =?us-ascii?Q?yJkq2zK0hFV1gOuiF/F8pkn6bo3A0f/ojLGN9WYYtuczvviVZaDbko76zDLC?=
 =?us-ascii?Q?G/5UlR4aNaPI1b53sbLtN7lFXwn30b/nvty3S4CmPO8BY7XWe+DVCU7fYt1e?=
 =?us-ascii?Q?7bF58OXqVo6tntUPPxPYVqsACt+NqtIyT15zPzLoPMze3jlYgRx3zrZ0Ygzl?=
 =?us-ascii?Q?ZS568KQWyMu2ytdeRufgT9yiwvEu1aa3zGT4SJgSZM5D3Sg4dzxM1s4YMkds?=
 =?us-ascii?Q?05KmElDm1Ts7Aio7NhnIy/f1k50B4wUSYdSarNiMAGR57Q6EsEDVe6hIZfwN?=
 =?us-ascii?Q?1+fnKo2QsX1BMFSne6tt0i3NL+g6z3ucOUkqEe/g77sbAG5RXiHzXpWcUZtO?=
 =?us-ascii?Q?+piJRSn0F7WWUf44uRwb9flsqWSMkBdjxZg0CCwGW8L1HMYPPD3CmjUlYdxo?=
 =?us-ascii?Q?V5vfAp88yZws0icB26enO6EIWJ//+uqkoQXscyaN7FYF8tPxgAkSBizR0AuU?=
 =?us-ascii?Q?2OyoqX8vyUwsc8DRfiX4X1tGCzmstGUR+8SPafqcBV4n+7tJbtn+ujMHU05b?=
 =?us-ascii?Q?bC+JOS2H8SnUfM4dcRSytaIcR38PkkLtuM0z0mIE7zkL3ZvGx7LKI1m3QMW2?=
 =?us-ascii?Q?IoIr2oJ9in3cFHtSHj4F60fe/6fH7MH9K3tOlMk2PWhN9fflafQNU9qv+1Ga?=
 =?us-ascii?Q?uXhsJsNGZ223sv/+LwQV/eDQ6UaRvjCCNxkHeRW+8DDN6PC9LG8L+ZpT8r4s?=
 =?us-ascii?Q?A1MPuKI2uA6hOzKXiPfKyTE/crgxP+6qicsFR4sjPrIY3UVPvK4CB9jhjxEE?=
 =?us-ascii?Q?4axRou5BYK/doQFBjlLb/3G0FRZYqbJ30cxbpYnZmk5GH0R20cq6jE1dHuE/?=
 =?us-ascii?Q?uBzDVjhVdAXUVjbPV2D3x2C0aui62PYcT0M0e51fPW/i8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe6d04b-468e-45d3-0876-08d8f3c88473
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 22:09:41.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVV5jXk7C/tCtBfgPcT+SVv7lefkeWIPLDduL9AhnzkYruicguNNSmwvbCaYHzM7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 02:00:43PM -0700, Dan Williams wrote:

> Ok, so another case where I agree the instability exists but does not
> matter in practice in this case because the cxl_memdev_ioctl() read
> side is prepared for the state change to leak into the down_read()
> section. There's no meaningful publish/unpublish race that READ_ONCE()
> resolves here. 

Generally READ_ONCE is about protecting the control flow after the
*compiler*

Say, I have 

    if (a) {
      do_x();
      do_y();
    }

The compiler *might* transform it so I get:

    if (a)
       do_x()
    if (a)
       do_y()

Now if 'a' is an unstable data race I have a crazy problem: the basic
invarient that x and y are always done together is broken and I can
have x done without y. (or y done without x if the CPU runs it out of
order!)

But I can't see this at all from the code, it just runs wrong under
certain races with certain compilers.

READ_ONCE prevents this kinds of compiler transform, this is what it
is for. It is why in modern times it has become expected to always
mark unlocked unstable data access with these helpers, or the RCU
specific variants.

It is not reasoning about happens before/happens after kind of ideas,
it is about "the compiler assumes the memory doesn't change and if we
break that assumption the compiled result might not work sanely"

> down_write(&cxl_memdev_rwsem);
> cxlmd->cxlm = cxlm;
> up_write(&cxl_memdev_rwsem);
> cdev_device_del(...);
 
> ...and then no unstable state of the ->cxlm reference leaks into the
> read-side that does:
> 
> down_read(&cxl_memdev_rwsem);
> if (!cxlmd->cxlm) {
>     up_read(&cxl_memdev_rwsem)
>     return -ENXIO;
> }
> ...
> up_read(&cxl_memdev_rwsem);

Sure this construction is easy to understand and validate, if a rwsem
is OK performance wise. We can do it after the cdev_device_del. Here
the cxlm is the protected data and it is always accessed under
lock. 

The rwsem can be transformed to SRCU by marking cxlm with the __rcu
type annotation and using srcu_dereference (as a READ_ONCE wrapper)
and rcu_assign_pointer (as a WRITE_ONCE wrapper) to manipulte the cxlm

Jason
