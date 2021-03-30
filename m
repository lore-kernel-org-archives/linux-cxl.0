Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B5BC433C1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 19:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E462619B9
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 19:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhC3TwG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:52:06 -0400
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:38432
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233223AbhC3Tvr (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 15:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKOV7LGXsGdrWGnjHXPzgyAAbBMYLdkdtUEQeLYEDj1Tcp73tQMX8JIFbMignoW9enyeqX3IcjC4VJtra4+2+vPw9zR/AmSvnTlFrcgFhbriwWu07Z/Pk4hY+WyMXJnfQrL/538LsV1jl8li/jpTjLRC7l+3XxuorAIoquWZ5xj9Rga0vUDIaIlv2ZTZ5+8N0vXBmxDXhojLiCDAAq7+lgUA4C7s0vZos7E4hpFslWxQOnA7AhVYAGCKu2CHhb+qgmPWaeMbQjQioLtfXHY8mz4dPeqpGp+YouxBxW1KNB4pyXuLlIzbyaoUCzWoWjClwadoRx9I2nNdCs8xCNf78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q32K4TwRwDXF66UHWEfyXT+JJjs/0Cy8B4ANnDa0+Y=;
 b=ZTqe9f7GGJjQt3cI3dw2h4s+T3f4oKkkLMs1AxS938j+37k66C3lHbq7vTQ+O8NI4ZI0mcVQlYWPczTJRxtZKtEaHIks7HeeAZaUjl1zpQcCwgy9hlvzMqHom/WvloilON3vOCeO2zLeNSvCy1qop5wVO8YhkkcXpeJJ2YPVIib+0ZwfuZ9GO1GcT7YVyTGJMomwKbsAb5GEutyMDvd6OcOuk91kNsSjGzpJJhjfKDumN8J2Qcp/cVIHReGNh6DB3FVnmKUeDJKGL5Rmm83NxEsmyHwXD6rUooEjI6YKQB2jUVche9aCOrtGCg3ijQjLxyrGc3qSF6pV2yJqHywhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q32K4TwRwDXF66UHWEfyXT+JJjs/0Cy8B4ANnDa0+Y=;
 b=ENVmlzULK6/IOwzpoKWy4ywd+rhXoGdve4H2uIyd77NUmZdWj8kLrV3Fkl5Hg2FLSyTn66oI/SnTwmCNUtx4Jcu1lWU+NN6J+EAtAXEs89LPPPdLAb6zLGj4SWBaOMlPqi65IgpSXkLda90HJ5Zj05vrw8E1TaDKF+VniaX5sfodkRikEIraYwSbEa+A2f4uB8Vzhe5MZRe3ySY+kiX6w1D8vcoPeZKs/YTOOB2vhX9v5MfojDoXKr258qASxt2bkKz4i9Tv4bfTa16MuKSN2pftcRc3uUJbiviuiAHExkb/cLT8FfPjepG8BG4MlRFj+fpacFMGuC+iAWcZQ3VWkg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Tue, 30 Mar
 2021 19:51:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 19:51:45 +0000
Date:   Tue, 30 Mar 2021 16:51:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
Message-ID: <20210330195143.GB1430856@nvidia.com>
References: <20210330111620.GK2356281@nvidia.com>
 <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com>
 <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com>
 <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
 <20210330175431.GX2356281@nvidia.com>
 <CAPcyv4igMvwfZNgi-Uap_QUJi+uocMUD3KZBhXUy56AuHZQtqw@mail.gmail.com>
 <20210330192608.GA1430856@nvidia.com>
 <CAPcyv4h1qgQAP1JT88rWOf9xZz_1o2yPvMFETNY2dFn17uFwhw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h1qgQAP1JT88rWOf9xZz_1o2yPvMFETNY2dFn17uFwhw@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0448.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0448.namprd13.prod.outlook.com (2603:10b6:208:2c3::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.18 via Frontend Transport; Tue, 30 Mar 2021 19:51:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRKOt-0061EM-Jg; Tue, 30 Mar 2021 16:51:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3bd3a9d-16b2-444f-6a15-08d8f3b53fc9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB281017CD0A98302D28BBB34DC27D9@DM6PR12MB2810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCHqFxpSUfvRuxWg9zwkkYilHeNuLI5JNbdilGxrVHzYk2Nh6tNT4Xf8mEZNFtauY00MURqgZoWZkMXjRS1ODkicWw11yv3kcxhb20o//7t8iRAAXDVzzBdGrYXh/ql7Tee6uVMI2dtKr9KDrw8QSuKEIpqJUljQIeLZrD7ziw5K7xd0xBbUYOtieAEcAD1o+IpgCedzp8UhTru83u3WCmsGY0ZhSZKB1GjSKKonBm2r08ccCyUnCa+HYMruLHehstRrKaLx+I2WUAcpGCWIJao453OQ+biC4X+lKUx6JOUQHeNdAacdYnbRHqQu7VYAgzR89bd1AQbio+trclzz2QX68Hi89l+DL8n9k280gobTEicq6ZEMx+bqd4ekkoT96mofr+HsHZWNVcvE1aTDOV/cQLVCl6qbNt2xbsD392AiJhEZtZfYyanaIXwxOU3fgP8fEEOP8kXxsUgSCiMDGZJxz5IW/j4ViijjP45l7HUNxhyqrBydxALk4Ry9KYw9qzrxiSKYk5d6x46cQb8KJcleYMAh+k1CU2L8vQEhl1wiXC+sJVeWBmboIbBSVvNvHB5XxwSC1zWtEKUUF4iJf2S8fmegHbWtVHRMLJpkldYQhzTQeY6HM7ajpCTjsaPdb2dSSenHouBkFib2AccSo4uRZ7rzHxdn0TzsSIDPIzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(5660300002)(426003)(2616005)(33656002)(1076003)(6916009)(54906003)(186003)(4326008)(8676002)(316002)(66476007)(86362001)(478600001)(8936002)(66946007)(26005)(66556008)(2906002)(36756003)(9786002)(9746002)(83380400001)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?deg9pClMqTB4un654ZYqMKGbN26/mepjGPalRB46kki4Vg1O5obHkbF2MLJK?=
 =?us-ascii?Q?Pfpg4TurlAIyuBSuSdaguOEbIswH82nNRCuNAbsWFon/o0NCHDKvILIyLZIw?=
 =?us-ascii?Q?fXU54ZS1Lu2W+zyAstZd/8AtjCRFf3J1GQSVsPOIR5fA6btlN0HoNQayCMM4?=
 =?us-ascii?Q?e9lbJ3Q8uuSeu/D69lJEcN5dPPiMlYiO0xYixV42rTrkl3zc3EtuOkdsamTY?=
 =?us-ascii?Q?sqUTfeNiwMqSdjqLY3zYg/Nd/OgATrSj4wBVBse8KBXU/ucZ+YYojx943lqg?=
 =?us-ascii?Q?XcLClSu4EcxzFrYbKBevWUusO5Nzg0jZFcHtl7wYCaXuO8PHJxVBRlZAoX41?=
 =?us-ascii?Q?+nMIXGjlsKvygdFBZ1wVpV62VoC1odZP4p2K5QwdTlcK8tnaNkWGLM2EaA19?=
 =?us-ascii?Q?AUb+ufqZQ6AifJvAvs5WzOr18Yoan1i2YehUZDruhMCQBh9z/yAciveo6s8X?=
 =?us-ascii?Q?eMQ4NmO1XpX5X7+rzZepZMNrCIeADboHPKNaaj7CuYj8oClnYjtFRyDTKUPj?=
 =?us-ascii?Q?gqnR1QyhK/zNeOPMWEn00WQ9VT1LY5FOuipRwigU/FYfqxdlTHtdBGQK3Dg/?=
 =?us-ascii?Q?PP7+J29nclkECFgBuAKp3bom5ChEodJjic3RWa+7PkN9kkQycm0iXJkZ2PR2?=
 =?us-ascii?Q?BiPmwexX4of90z9Jh2h7fUzxJbvOh5Nj8C1bs8mWlWwZpJcqKgZssWRvDsw/?=
 =?us-ascii?Q?wuhsx/6H9Ae4851oImjkVBPxZNvIQnsc46OUxq9WbhnsiurPmbHww3DOYRlT?=
 =?us-ascii?Q?tqwUL5qk+ShP6C9OZ7CVPu36UgxjloSdQQWhTIhVDF7J7qUQLKl2cfVhOTck?=
 =?us-ascii?Q?/izKFJ3kWAiyAz3YWiiC9y4F+SiLzOELxfIcRZ4pVuAQeFuwMx/8gNSrw4ce?=
 =?us-ascii?Q?2Q7id75qdmSt9grw/p92GUwHqo/okcokcjxa8oZaD0QfRake9xEInwvDpCJJ?=
 =?us-ascii?Q?H6hgr48p8hfT/w42w1LoKZlTfDTL1JzOI/UMLftejdLvDJJi97wF8a+YcsBX?=
 =?us-ascii?Q?qs/iIjuh68Kba+0+IU55KUo6ZaiR+zTiMzILbLmwVs15nImh8A3bAZToUfIl?=
 =?us-ascii?Q?Co/emvWzyAyZc0kXArNLYulexM309RmSoSabR60hxG88dNvCsW2iLFMKMxI3?=
 =?us-ascii?Q?NNPFvmTIXr4SZ44y0gQvLXxmdN1gKrAacAfWFnQbxyTDnF3APPXzfSlum0by?=
 =?us-ascii?Q?HUi6j+4r9u0QoR321Z+4bUBqHMYv45SQCOuP83i2SncVE0J9ylatUNqCOaDD?=
 =?us-ascii?Q?D1altLSBk5Ixy5LsLLfLE0BvadwG5jqEyYNZl+WCPBIX8qBPNZIfm+7W43lM?=
 =?us-ascii?Q?rEbm9bh7797rD9RhvGm2yj+tcmLdrC1/b4CR1ql3MZfxrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bd3a9d-16b2-444f-6a15-08d8f3b53fc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 19:51:45.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctO/UxicNpQLRdE4hBENPo2ADIOSH9cZGS7x1c5lU2bdWRTNOlngsx9OLyXVZWnZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 12:43:15PM -0700, Dan Williams wrote:

> Ok, so this is the disagreement. Strict adherence to the model where
> it does not matter in practice.

The basic problem is that it is hard to know if it does not matter in
practice because you never know what the compiler might decide to do
...

It is probably fine, but then again I've seen a surprising case in the
mm where the compiler did generate double loads and it wasn't fine.

Now with the new data race detector it feels like marking all
concurrent data access with READ_ONCE / WRITE_ONCE (or a stronger
atomic) is the correct thing to do.

> > > There's no race above. The rule is that any possible observation of
> > > ->state_in_sysfs == 1, or rcu_dereference() != NULL, must be
> > > flushed.
> >
> > It is not about the flushing.
> 
> Ok, it's not about the flushing it's about whether the store to
> state_in_sysfs can leak past up_write(). If that store can leak then
> neither arrangement of:

up_write() and synchronize_srcu() are both store barriers, so the
store must be ordered.

It is the reader that is the problem. This ordering:

> down_write(...):
> cdev_device_del(...);
> up_write(...);

Prevents state_in_sysfs from being unstable during read as the write
lock prevents it from being written while a reader is active. No
READ_ONCE needed.

Jason
