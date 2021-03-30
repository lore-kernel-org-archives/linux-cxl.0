Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABE7C433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F26661989
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 15:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhC3PrW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:47:22 -0400
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:52577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232263AbhC3PrQ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 11:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbWV/faEQSlQzj0UC+J0nk/RPTxJ74dHaaGoZyovfQ05smFvklXdXUq9x6jhAOwLzhL+NX5DDWoz/2leRR9AZCbaNsDtWtZjPRwDBjNo5QIEqJGHtPfenpcjI10HfceWWVN0pXempPCXPT6rweNHK/Yu/rakWNFJ0sQImUb9QC9SYW/cZf30keadqFwzbx/r3NrY4FoSrW5TfZrErxd1cx0SeevidPH6fIDk1XUp85vBZROKR+l/dKBpvxmKTE0z3l6LgxyHP+N8mrfv5P0A7uopIAKCzPZuGmdyS/QiTNq6O5AAOihA+ENVqKWCaimmWxFSLYm9w7/5fyaeXhRTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miSRgMmBQwbSQKtLZlPbZYDzP3rnCM2z+mWSYmUVNuU=;
 b=GjI29mcN7YFkjA/PlDKO2TqcQJYGkpXi2E1GyDGctEaJMtU1jhFaN+cVslzapflw+wRpE3Rl7Q5ecE9Fj24BRYeocIwWeQQb4CSEgr2raUDgcVh7fIGw4Ip6pTTaT4RIhm2ObVmSqf4MM247qUqS4g17U5vl8LcRyCz7i/GsMkPaMYF9rSCrNzouslxJhXifZq6wURyc1KG8Ztnt1Oj+t7LPZRDQRSMug74+EcaIGXM+JLuS1r2r+OdgNuCQopL/A2z95VH+qMhBfxbH/t/3QcqORsCkuzkyrcTRkQ/60XOMzcDqCFEI4tdOSNuij8JgByfE+S7CJHyX1ytOPKyY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miSRgMmBQwbSQKtLZlPbZYDzP3rnCM2z+mWSYmUVNuU=;
 b=Y4ZQXBrDuSx+WcAX0TtC1gapRSBVtQBzneKs4uW3qbMmfiXVMXrBjntDAZGt4VrbDoeu+4cilXQCfusbYRjN9kmx+7HWBYnLGxHm1tY8CZN0lupyp7Dya1O8EyeikSnvwOhrJ5u5X4UcLqJ3QiBo7dtBLwP3JA5HodhHfagkKv8KCjvQ0vnzbf5mS/mCcxelqQh2RKWUM4AsenEZ97qRbsPHAri+ugiSCofrP9d2VnI5WeKmqEXqHFdUUTmm0Y5hdcz6Le03BncfByTfu7cuiR/xdhmXxL/iRSoyLjqvzt5FwmYb3Kmjal/+iXNRZnFeAX5fzJenJSceYHQHfD0AFA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Tue, 30 Mar
 2021 15:47:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 15:47:14 +0000
Date:   Tue, 30 Mar 2021 12:47:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
Message-ID: <20210330154712.GR2356281@nvidia.com>
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com>
 <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:208:23b::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR11CA0029.namprd11.prod.outlook.com (2603:10b6:208:23b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33 via Frontend Transport; Tue, 30 Mar 2021 15:47:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRGaG-005vzN-5A; Tue, 30 Mar 2021 12:47:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6cd0ada-4a9c-450e-88e1-08d8f393168c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882075F056EADE806497A6EC27D9@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5v+M48q3j7BuRk3Ufc8+7Yujx0NVKh53tTCYpe0LzjWLg5nQnR/3+ZbOb5vWHvjuW18HPafSBbddfsB4C6wO+2wHe3/Y6diu09zemSd0y/AsAKRxsQYqdesbKQ2comrEOPV65H/ODirGMvRK/+FyrHklgCtuK2bqZR3S4TckQk3YTpz5opFkZLaxinsjdz5Qj/4c8axZUkBrazEkZVO/xb6B8olPCaJJjRsC/OffSfG+gomLcUY+IjC4qXv8zYvNh8LsNHyuNa/MOtT9sCtun4sYSoV6GtlYVAom6MoyBoorqL7z7oV3JWaRn/gFf2l6QxIMvRPKwr66p81i3K8i0ZFlbCvKulri+mTACjf5aCMOFW+Tvvc0gyG6AKCiTXJ4r6XNH3GZM/lG4wXWFhnMjvY/mERUni1Q4Uw8ZdsOXKaxOcZkGiSHwNltexsHDJgU/Im81y7EzH1kmu+6loiNnRhCIx2DgTqVm4ae9K5T5guZ6j2aAIUDKOgJvZ8gtWjDlBFmFwoHU2PGxUfJcb0E33wQeZz5JiN4afwcpFMvE6eBbRRLdvXbGuRuSJqTzfHArN8FrhgshMJaaNc8A0sDlAWL5+WW0jQ4Zm45y9hQD88OFrFbEYrmz2NFKQi3JXy/HWUft1Cp2x2e7Zm9M5hg1sGyKqrEb6ca94Vn8R100M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(2906002)(36756003)(86362001)(83380400001)(426003)(33656002)(26005)(2616005)(186003)(6916009)(53546011)(66476007)(316002)(478600001)(54906003)(4326008)(66556008)(66946007)(9746002)(38100700001)(8936002)(1076003)(8676002)(9786002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?izjxZYSF3hNShbR9p7hhwa8h0EWQfkjMcTvjE/X7HNwLrpCY5Y/KklRzU8rh?=
 =?us-ascii?Q?mI1zUAOnWBCfvqgxfbyhpc/mAva1rZovwGCQJn039Qv/DbVLOERJwXS1vFQH?=
 =?us-ascii?Q?R0Z9QUKSD2BeeNYhCEorkUqxipWliICIWDU1ESHZYQ5AEvoiOpOjKYRNQnVU?=
 =?us-ascii?Q?PUSlx77ZR/T3nm/7Rz1zXpKG7hG3rcpsEKSeU1KERv3KdUqahVxb4uz5hzgb?=
 =?us-ascii?Q?RtuLRKFVv/jmeXCaS/rPVfdkLToNo4Z+EK8BtEvMFEYwimK2/UPW2gI53Dfj?=
 =?us-ascii?Q?8CLJrsLFWlIvgBPvAOdFD7svJwhQhjdK9MjGwXQ+Fnw2umbLGfJsl4agIEBz?=
 =?us-ascii?Q?uuP2xsVEE6CHwX+BiPWi5UBLp/U86xM7a29qYs+uU3N+5MoN6rapBA19mmQ0?=
 =?us-ascii?Q?i4NgYve5qNz99xpEuf7yKcRUZ0Qt1R5FoD6pO0L8nHyVhvl73tgGg6ItWGyj?=
 =?us-ascii?Q?09B+a7kK8uvpD6bqSmng0n6sUVQsetPt7CpbOSJfmG2HcXpjQ1MIcJz0R5sP?=
 =?us-ascii?Q?21UQITWY212cOn4cTed3P4mFHh7RTPlB4kl3h7gb2YvA2wS9B0P2L83Ov6KU?=
 =?us-ascii?Q?bXP4J0bqJsmuYbwtz2ik99Se3E1nTOf76wXrqq/Er3sfvzOrJAhm6OJTOKos?=
 =?us-ascii?Q?7URUNGvppLb1rNzbRFFl79E5XiDCGyeWbioAZwiVyuNNIZYcjhlklXsn1Geo?=
 =?us-ascii?Q?IZHLsS11LjoLStvwgVJreAnjpb5eAiq/tzDsLGj/S0pM7HKqXI+LWBNFE5oj?=
 =?us-ascii?Q?UV6Ny+jHcxVcPoeECeknQa5J44hs3lv7n2azW5PZB7Dx+XlD/YB/3eBnu9VO?=
 =?us-ascii?Q?wbQKSlQF0ktiiOlJnFIhR4CfD7nUcfcQzdpkezae7Jh1IvS/JAdIi2QSjC2h?=
 =?us-ascii?Q?ZuH0SOi5Zp3bueI7Ah1hPigUIdFWC8V+R9xslf7et+EGLswabZkXT5HZOErt?=
 =?us-ascii?Q?0irxY37RC50lSTlXG6dASYkynD5yHHYn3MA+ILR8lj4F2So2QXgxEx3Ao8V8?=
 =?us-ascii?Q?H7cxK4tolXjyRY17EGOcpfMRJYdTzbyIMj3zQ8GNahNBZyMPbZR85Wr87x/U?=
 =?us-ascii?Q?0VBsU5FeDriJ1i4sRl8//yVGvMtlcqPsgDFUnrAiGMquGuHBOBjSNRMBCyC3?=
 =?us-ascii?Q?4a+z078L6gd+eftxBzAHs1IM6Sh2/nwwTIhmIVjCG5ZAdAgOHd5q0tJi8Of1?=
 =?us-ascii?Q?mjnUlewwI3OwJUzg5QoZgLgGvNESVgFcGYes/QCKIUwBhxZaXAZBc6y6DDb4?=
 =?us-ascii?Q?vyVUc0P4N600ACcuLKdqZ4iRbeYUUrCpISAxtd+EYpqs9z0i/qxPxOMS2p2N?=
 =?us-ascii?Q?KqZGlmXMRPppEx42ZTIXXZnvgpSQmcjyAGovqObhd75feg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cd0ada-4a9c-450e-88e1-08d8f393168c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 15:47:14.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRoJcRVW6YGV4Ezz6e/2vOOQD+LARZGN8YVs6x8CTSrN/dHY1rLCNmrt/HXFjMA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 08:37:19AM -0700, Dan Williams wrote:
> On Tue, Mar 30, 2021 at 4:16 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, Mar 29, 2021 at 07:47:49PM -0700, Dan Williams wrote:
> >
> > > @@ -1155,21 +1175,12 @@ static void cxlmdev_unregister(void *_cxlmd)
> > >       struct cxl_memdev *cxlmd = _cxlmd;
> > >       struct device *dev = &cxlmd->dev;
> > >
> > > -     percpu_ref_kill(&cxlmd->ops_active);
> > >       cdev_device_del(&cxlmd->cdev, dev);
> > > -     wait_for_completion(&cxlmd->ops_dead);
> > > +     synchronize_srcu(&cxl_memdev_srcu);
> >
> > This needs some kind of rcu protected pointer for SRCU to to
> > work.. The write side has to null the pointer and the read side has to
> > copy the pointer to the stack and check for NULL.
> >
> > Otherwise the read side can't detect when the write side is shutting
> > down.
> >
> > Basically you must use rcu_derference(), rcu_assign_pointer(), etc
> > when working with RCU.
> 
> If the shutdown path was not using synchronize_rcu() then I would
> agree with you. This usage of srcu is also used to protect dax device
> shutdown after talking through rwsem vs srcu in this thread with Jan
> and Paul [1]. The syncrhonize_rcu() guarantees that all read-side
> critical sections have had at least one chance to quiesce.
> 
> So this could either use rcu pointer accessors and call_srcu to free
> the object in a quiescent state, or it can use synchronize_srcu()
> relative to a condition that aborts usage of the pointer.

synchronize_rcu doesn't stop the read side from running it. It only
guarentees that all running or future read sides will see the *write*
performed prior to synchronize_rcu.

If you can't clearly point to the *data* under RCU protection it is
being used wrong.

Same as if you can't point to the *data* being protected by a rwsem it
is probably being used wrong.

We are not locking code.

Jason
