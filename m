Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DAEC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 01:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiJKBYS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiJKBX4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 21:23:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C65E83F05
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 18:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2lCo8apD4y0c6UXPLJvDe9mI553RXOwpc0Vftx2x0BBzHs1zgnXqOMgX9TZmDSqr84QhKKZelW+HCrr3zCrEiwMGKzUBeDmlihl8q5nrb0FBoYzTKz0lxY7o2xNpDSBHUZpHDtFFL3ClLPMKqpPCfq0slQvmTKJvUSGnIYsnD/0adbiMd+2RY7XyhherPFXHQEbLN6c0oRJD3ZFuU0kKBrg+z9gyZXIZ8JGDYUBynw2Z1o9FqhTRkJm/jXnoNk6Tzc1rphq9IWSmVfO3LVO8K2v7QZN0jZ0S+Elzd+QNhOh1EVBz/cRY/plKmfYcnF4x+XfC01hjKcJgYUwmoIQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mug8xi5kbh3wYTCBuZUS07eWrAFjWcyZrDZfA+tpJUM=;
 b=EWrdxlA2+iAMG1loZ/KHy63OGontyofTADBG82bePqrLEXc+emKTUr6Vc3omcrR2OuqzQd9/MKFfcyEITWYtSjCTq3ZU9DioXdXgzR5R7A0EwxDQZ6zmES3o65riz0vgfU9qJVQfAr6cppEJB1T+pf0kwtae+MftiGp+pTpPwULJgrtTKG/UPCPgy9HNWSRWSX1b+7HLq3cBQSuDwN4S121JoLjOTuWaxUaDihn6cSvFeSQLlp+kXQJgIiJZzOXnADHFHFgMgjJ9oN80bcYWhvRHYYj39ZsgoQ4xiHHkdxTf8EWt3sILCr2/vjdLU3FWsiCM5Ntx7hICQL82Bxzh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mug8xi5kbh3wYTCBuZUS07eWrAFjWcyZrDZfA+tpJUM=;
 b=mijNrlxJhHvdU8TDXgqnEmkDWr8wCRGx5CL2E/+uNPZ6Kwfqu8DFERKNiQhb+xVw1equytPS/QFlEeUbK7IUoAn2lBBeLnOmfqZpltPEKr10nCqp1Z45tNgGLnntnKKrigRh0slRTBanYdlW4vE6PbNtM6lCRReP3GfXGKaq7Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DS0PR17MB6301.namprd17.prod.outlook.com (2603:10b6:8:13d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.35; Tue, 11 Oct
 2022 01:23:17 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 01:23:17 +0000
Date:   Mon, 10 Oct 2022 21:23:15 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <Y0TFg6198AHKjfux@memverge.com>
References: <20221006000103.49542-1-gregory.price@memverge.com>
 <20221006094557.000035ab@huawei.com>
 <20221006095007.00001271@huawei.com>
 <Yz75ppPOwYCvNamy@fedora>
 <20221006174214.000059c7@huawei.com>
 <Yz8QlQ9yLFrWxWsN@fedora>
 <CAD3UvdT1ZHJDaqj05C+n7t4rM7yhjZyM6fooXAfG12rAYnBqmw@mail.gmail.com>
 <20221010161809.00006f8e@huawei.com>
 <Y0Q5a2Wx3qFB2eKI@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0Q5a2Wx3qFB2eKI@memverge.com>
X-ClientProxiedBy: MN2PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:208:fc::45) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DS0PR17MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f50cb6-5744-433d-d8f3-08daab272cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M62nHagwSkU+aMAB84VHyJHNd69cXM6FzYDRkd3FddHURoN5MnON9sB7ddQyw8eZuKwdIpDhyAkOliEl1KPvnTzsf3aRfnTNhqxRj8sMq0SVR9T/LlZSMDmZkl6CXYavrF7o+qQ/tGD0W169zngJc1Upoprxl7LMLDTQ4emSoMo5baX5GxkZNIRBOILC1GcCsVIcW5o5N3OISUTGoBNvJgMkZKv+nAPUR09XfBXjCoOoKXkl+dvWwO6qlasogoW0DIHHQVEQ8CAQQ+PNEcXiS56G40XLE3aM8Si+aZ1zdb5StSpJliyucg4QL7hfdWN8FrWllbE27vbiQibKt1prMQ5be2FhdliRyh+y8wOG/hmj/XotI7pYKa24eHfsfbQX/wleY2+w8FFAicMTXZ8UHxbGcKEULDuTjPh1CfgNVtcnDOIadk6J9MJBlnEGhRQSMNsb6A59d+RzGN7tTcMaZATStbvfID2MADIclKV4PPzdOEZlvkJcimcr1A97cJTOoRsX6AbnwfFuDP2rSqUR5fgMJ0Fm7BOS1BVLfoc+zONgImu26DP1ZO4ra7fCZmgZltbpW9B9DhSgrBOTawv5GSUY9Vv4zcicZD0d2yrzhwKptqWaRKOzv28I8XtcZQnfhMeVTjKm5I6cx/5T8zYKku7a4KKa3wP0iYHrgEhA/RyjkdH5cUsExBiLI1DJRN7oadayrwauMkgOlqLHo5/X96jQbFkvJJcU4iXpIr8RcVjik64HMPt/Ta5SOLLWZAqxAjhFMk3WKiKAz9XlAUjxSw+pn5xoYnCQAEvTO4a2RYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39840400004)(346002)(396003)(376002)(451199015)(6512007)(26005)(186003)(316002)(38350700002)(38100700002)(6486002)(966005)(6916009)(54906003)(478600001)(36756003)(86362001)(6506007)(52116002)(2616005)(83380400001)(5660300002)(8936002)(41300700001)(2906002)(66946007)(8676002)(44832011)(4326008)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CPKPWiy5TIeRv13rLZFXOr0IfX95E8tjeCnQEx3k7HQNY2oSkCAZWSa95S6?=
 =?us-ascii?Q?CmvsY29T3QYKx0h2UffTcBS2uvIpWAGaiNjzj8motIQc9UItpUjmRc6toT6o?=
 =?us-ascii?Q?EbIMb0FYt7mWS31vu+VYv63ge/C0YoBkE5JgLLait9Hz3ougWvmdrgjCBtUK?=
 =?us-ascii?Q?0d+o9YYMYTR9280iZ7aCyk3pIkUf6XmfLnWJsdo5ZBCAQbjxlzNK21ZsjUgi?=
 =?us-ascii?Q?mAM8GDXfcA+fL/JQFMlZ5g/afg/+AiS7xXwK/0R5w6DiStMCfrOyvjpJ4sxE?=
 =?us-ascii?Q?1voynKHiXlz+EIGDJrSka23HAW27sjQaHu39X/Fu9fbK0ek7ZjScFQ+4atAF?=
 =?us-ascii?Q?WfFCvS5AwnNj0sr0vizbbVwtnORM0jYlBe+kX++Mj6JrFMfoBgGg1xVlEHSg?=
 =?us-ascii?Q?gMKMtNB3MCgRU4ahPGQV770LUI6BjvIndk0tNbtjpUg+MkhhU2+tRb2WoBbN?=
 =?us-ascii?Q?ZrNLY2Og6vAGG5OW5NKiysSZylDMCQGnJ3LsT3V/yKXB3VMa1i1eKXnISAab?=
 =?us-ascii?Q?r8iuSm2ozfgcDvIG+aVQtCY/YeaYhxXMZDi/W1+8MlBEK4gcD8zk8/dvZPEx?=
 =?us-ascii?Q?NQUrKOfxWIamfVRM8qmF3YNabwIu31L3g/FjHGQgOvI5kOljX+aaNWmfqUp0?=
 =?us-ascii?Q?hmFnYtE/n/pKsuvDl5tkskCEvSU1/+1zP0Y2tQs5720WHxkEpAaD3k3gDmc0?=
 =?us-ascii?Q?5/FSkfTJMibKiwNt7yBAywFNOjelmfQHKmcMYAanp4v/GouGOsRCnUwsGnqx?=
 =?us-ascii?Q?kUX+6Mw53DL+FZ4w0eYCxqPtFCnp+zNPVSblpt0I2a74PYMgfxapOxk4jPsf?=
 =?us-ascii?Q?g8SZkl6jXeam41UXBKfgjg2a79TMVFIQE3/9eW8WSCg51jlhMgmQfKRsB+9K?=
 =?us-ascii?Q?mYQ8DEq5cv02Um42yjHrejtB7M3znbZ1QQiy685RLWlacuTFaB0EHlXTsU85?=
 =?us-ascii?Q?QczU1IXGpZv1kv/LgJKAHVZ9yVFhwMWCf/WI/s1zjjgtXzp+A3R7/AuNfaFx?=
 =?us-ascii?Q?XsD5bO2/U+pPOiSaN4w23h7oUjCaDgpWiojewYaKjKE9xfvVAnWQZGuGlHib?=
 =?us-ascii?Q?FR0D0pCsu8t8phPVJ+lZ2vj/miIRgNXHVgjiXANLXJJhj9DbcZuUnhY+Idie?=
 =?us-ascii?Q?j3eAVilR5D4BUDbaZB7ZZ6y/HT8QBYQ2xT6QlmcN3AJwtqhD8DluprdDGVcM?=
 =?us-ascii?Q?MbkMr97g016i8KWbXEcYTGzl5AnLeRQptSBZruukVbInxnn6241w2KmJrUvz?=
 =?us-ascii?Q?J6TwFlqGiXgk5B7nylydmd6pG5s2LHG0yhoyi30lH004N10/qNGFtlRVe+Kx?=
 =?us-ascii?Q?DdJnUaiwFbBl61wjvDzbm69eRGvivn0TGA7lw2vQby1ko3VWbVLN4OR8LbZE?=
 =?us-ascii?Q?mPmziaQDE5oFO6eHi4rCOB335TxIYWrHpkzqV6KX3OJoiApTku9MtS7UsaVW?=
 =?us-ascii?Q?MRGuGFk4WAsJ1dAaEiBB/ENmZlvis4MxRMGPspUyFrGDCzqv3MLS1+AIyKxy?=
 =?us-ascii?Q?Z1hDiMkconnMNdD25lOS+DVYQoIIg3NpuP0C7b4JZtEzhw1zjS3lEJMHrHBS?=
 =?us-ascii?Q?5ga1507A/HCkB0sdW5dAW60OG+loOiY++0bMvSYVS1ig8mb5VqqCe7hQEZbU?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f50cb6-5744-433d-d8f3-08daab272cd5
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 01:23:17.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVQuxhmLX426xHL6w9rJ3vKVBLftA0ljy5Kgq8xHbKaihjnZTjBkODzbzojymKq9qeU0+6YhZg/ur0EOPo7LGcjfBNtuD08Ax1eR7l5r7aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6301
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


I've pushed 5 new commits to this branch here (@Jonathan I've also made
a merge request to pull them into your branch).

https://gitlab.com/gourry.memverge/qemu/-/commits/cxl-2022-10-09

They're built on top of Jonathan's extensions for the CDAT since the
CDAT has memory region relevant entries and trying to do this separate
would be unwise.

1/5: PCI_CLASS_MEMORY_CXL patch
2/5: CXL_CAPACITY_MULTIPLIER pullout patch (@Davidlohr request)
3/5: Generalizes CDATDsmas intialization ahead of multi-region
4/5: Multi-region support w/ backward compatibility
     * Requires extra eyes for CDAT and Read/Write Change Validation*
5/5: Test and documentation update


On Mon, Oct 10, 2022 at 11:25:31AM -0400, Gregory Price wrote:
> > 
> > https://gitlab.com/jic23/qemu/-/commits/cxl-2022-10-09
> > There are a few messy corners in that tree but it should work. I'll be
> > pushing out a new version in a few days.
> > 
> > I updated that in latest version to build the tables based on the
> > memdev provided.  We'll want to add the volatile support to that alongside
> > your patch.
> > 
> 
> I will rebase my --persistent-memdev and --volatile-memdev patch on your
> branch and send out the commits when i'm done.  I may also add the
> scafolding for the partitionable-pmem field but not actually expose it.
