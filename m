Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D88EC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJKRWy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJKRWu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 13:22:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CB77F26D
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 10:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmgHTFl2oPhNvfl4GCJppLkLKxsNDnfWlHI3ha5HuvWI/Mvqw2EZLXi1avhNFaqG3EzLhV9cgC2JDYmTIf+/Y3bOcGsrzo7PCRZ8W2A4ZWDE5J8MJtBZx0ykQ+jWLsaeEGE+1dNwQmVdvf97oIC35LtdnKzJoEVqjsg08yByLAbjFG1iIBflMctcgbHfe4eRpYeFXylfZ5nE4Peczvx3Mr8KZaXEdXxG17iGrMH5rf0zrFqjJXADbkQERDWO0rAXwLKigrF15rHisLVnMRmE6XUXiXXtUAbGGoZTROvnKd9Cn7RSneF9Z9MJQIa3eDr3zA4wAgNNNRi8JaoTTy7C6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFBfBN8PjH6vs+589hJx6E/2CdwWpLyG7zwmjcFFHqA=;
 b=dscpKnfKxlaWxCgAtzbrsiNanOA9fweOtnmiUOyqsDfWeP/tkSlH5uclNafrQrr0XyyOLATev5AZ7zqdLZG5YI9p85YaBmko5OaqVtdi5Y7AqQKstC38b8ZAko1CVvgnxfpsjM/3vN78VbZZFVHw45IDlC+rO5NJ8RjfB1CagLPmotMbjFvXLunsk/K1XKdSUlmHN51T+6uIRTKb9L3L36g16JyuR7GgkNoKbe6yUYRQHsKYD2FoFWeQRNPYvMT3H4CXTGMuUyNN9KIBNz4N5Flr9dGLAKCXhnvkdNKCuP68z2qo8/HDbmWPxEFGQUa4ajk30ejD8QFPoDBx5WjSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFBfBN8PjH6vs+589hJx6E/2CdwWpLyG7zwmjcFFHqA=;
 b=E7OFgGrnksVDp4dvG6n8L8GQMblvhG/YOpiL5D0sRpG6Cr2j3//GvwHkF7ydvsIwnS2YfVHQMiZIrj4eCoadTP9sxit49Q9U60t4lAbMagYMdGI19I+P9FVMpRSIeLOBqxhuZ4JAc4sNfFqq3ytyFlPc29UF9OY3WVc93BqWVKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MN2PR17MB3726.namprd17.prod.outlook.com (2603:10b6:208:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 17:22:43 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 17:22:43 +0000
Date:   Tue, 11 Oct 2022 13:22:40 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <Y0WmYNcVHhVHeyH+@memverge.com>
References: <20221006094557.000035ab@huawei.com>
 <20221006095007.00001271@huawei.com>
 <Yz75ppPOwYCvNamy@fedora>
 <20221006174214.000059c7@huawei.com>
 <Yz8QlQ9yLFrWxWsN@fedora>
 <CAD3UvdT1ZHJDaqj05C+n7t4rM7yhjZyM6fooXAfG12rAYnBqmw@mail.gmail.com>
 <20221010161809.00006f8e@huawei.com>
 <Y0Q5a2Wx3qFB2eKI@memverge.com>
 <Y0TFg6198AHKjfux@memverge.com>
 <20221011171438.fwlgobgaegns3p7t@offworld>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011171438.fwlgobgaegns3p7t@offworld>
X-ClientProxiedBy: BL1PR13CA0259.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::24) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MN2PR17MB3726:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1d554d-e849-457d-1282-08daabad34b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3paDoTZQJDn61soIgWKqotgTCkBbwWi1yT3WbQWSDc3QFSgMEnHw3lHshlG3TJJJ762MbZefIev9W9Hhh30J33/5YuU8QpxRumkiIA1RopfnAi9Z0Y00gfuiIrNp5vLx99bFPGhdd52hKsRCBOC9GmPYTlJbbQAxR+aeodqwK9J4T73pcOSYpasaSUeMRqS2iiE75ZXwgZ0iT8RaNFie0cooElVFVnBIro3bM5d/zX/Gp6s45FPdKvpcxHODweC3mehoEib2XK3zLtUGx+rqBQgelAvIdznt4E/A2Ahx+I6mhfiV1P/8Cx+JN3XNESaoYTdUBu+OhXqiSOS13SH4FZKxNPmJut6dmaCQpPIQQkJ8bOknm/u70u1iTGPVEF4Se+VFxGUsk8B9gOp1XQow9hU/tRKwrA5c3dzzZnMTVFLSgW0vdKab6zjQyfBBdKqZn8ve0iEYtMG+Wx6E2X5NXDa4UT9ERCvUtsa0gGlDUI3/pMSm1Aed195wbnkp/oa9mdLiLNwUUh+aAV2rnzA/remSkxq6jatvdIo7adhgz/vVqB81EiOX+Z6XAQX6ZgB/eTsiwKCD1xSdAiy1EJEGz8CSJs1kx/3OS3r2zBT3mQaupP1ha15RNduCSwx89AoamPZ8l5MerpdO2GoCqd70OVlKLrUQRrVvhRLJ9Alw8+rb92NSPz+pwRXuAySoNryT/r87pYLp7cQLJNrW2Um83stHVxpn7SjAq7UtNrUCMMQCfvIk7UEmOA8kmn6R08IRl7a9fRAUeJV9J0/jWvVN/BIsJLPKpBjab5BMbNtq3HA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(39840400004)(396003)(346002)(451199015)(6512007)(26005)(6506007)(44832011)(5660300002)(86362001)(2906002)(66556008)(66476007)(66946007)(4326008)(41300700001)(36756003)(38350700002)(8936002)(8676002)(38100700002)(316002)(54906003)(6916009)(83380400001)(2616005)(52116002)(186003)(478600001)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxo5qMHE7CxfJZN7HsA4EP0Wizc8CRqK3Fd1DvRbyVWI02gnbHNKcPq/D9wc?=
 =?us-ascii?Q?RgVHFffui9WDvV6ZhkCP6Ex71kLc0CI9PP0/fIwi6IW1NTUDy+7irEknCf5l?=
 =?us-ascii?Q?6C7j7t8fWev31fc3BX9WUV+75Pt3+KmJmsHXgZdNwtkYjKrPQn6H6IDymlIt?=
 =?us-ascii?Q?rYBQ7uSY9Xsh7kIh3u6A50Ys//gvZAtvvQeCuh6ddFS20ababZyi2Vrbpi89?=
 =?us-ascii?Q?pWzRCuhFzA1/Gs9ciMYFVe9bJJcAvzl+RRjIgOOdu7Obc0gVexmVHJqiqiO0?=
 =?us-ascii?Q?z3fdtrgskkuDRCA2rlFKRdAnnTLQE4KvVKtUb5yPfCjI/YlTRP7uE6dlzDFC?=
 =?us-ascii?Q?BL5jzkHPP0peOTFOBHn7MO+eCSYik+jvW3uP33xqtb4ApFBlIMsNWzfxU7ZO?=
 =?us-ascii?Q?3dhHm2O++DJicsD6V9DAGaTohtAchSPp8kzd5ITNbtZUtZ3nEm6PHNxLhBfv?=
 =?us-ascii?Q?jEjiafiLmpIZaQjdUoO6R/AGI24nzXAi7xtM5nHJ++OsSn1dpBZI5c17Oy0P?=
 =?us-ascii?Q?KrjfPTjfXv0CY/YNE23HcttdPGe6EetRSpZe1joGkSLzFFMCQJmpb4kI5Mlw?=
 =?us-ascii?Q?/ebHJfCwjwDFHTKeKRqIYGT6JWsa9JkKbVFrsEs6+Nlxf7R1+Tx3/mk590sV?=
 =?us-ascii?Q?RrWxZTbkvKKwUlpNCmxKCbrH9cRP1W/IJ9HAeUtg4U2gZ/diaDXjuyN+p7Bp?=
 =?us-ascii?Q?3b5ci6ynQ2GJ22x6QT5CyQLgr5GlDfQ+jO1OhHMb1W9urwVM5dYDdWCvszim?=
 =?us-ascii?Q?D8GS1b6EPuqHBAA4mvk8ce1RT2wXtLnLmyMAS29dCXVe20DSATyOdQk3/5a4?=
 =?us-ascii?Q?QX1Am5CdNsJm2yW8Dje/+rohYPtZsIcFyURDhVlw0aSVvIj9UVZLfle1reRE?=
 =?us-ascii?Q?cNc+SXMbbzilbKCDWygWT1rqHiPTI15KTpXtyslJz2WWVErMmGcp6/cIL3Nl?=
 =?us-ascii?Q?lzRo+KEWeK6VrcYTkwfAQz+i4xoEoXnpEL7GKL0gycuOIaFWrp9fu7LvVc+g?=
 =?us-ascii?Q?rMyVAzquHDvkFcKvj+hvscoD1qJhKCx8XqvqbzHETJEz47iTSMjQW5XElXI5?=
 =?us-ascii?Q?bE+Az25KuHx/kol9NHpoXArfrSAqn07oaFHiBPC9984xZEJc9lph6swjak0B?=
 =?us-ascii?Q?dU13smXnTFZQk0mvtQmhDGkny/MbtoZ93S+nNpa4wh3+ClLiQVrpT3iIGqqc?=
 =?us-ascii?Q?A/fWyxEzMHZ01UtdS8VLDorx110mxnq60f1lDAA1eCRUGKbYePRnSqgfVIyN?=
 =?us-ascii?Q?RL+cULH8mtu6NQ9qCweTuWdGfPPUy5RrqKwouKwBD+sT1+3c+9QxmYnxDgY0?=
 =?us-ascii?Q?4JpMofDdYvivg7VSkY/rL+8a3qk3b5fQtWEMmIWz8tWMy4EoMQWrqvsE+Ent?=
 =?us-ascii?Q?veTZFtSzTE6V0rKhh0sZYMF8s16hmI9RmKUXdmBUjZDef3zQ3N0PgZYbOv0a?=
 =?us-ascii?Q?Qd5P+OaYEVADIMMTu7UWAV2L59YAzrFOJe5vVvF2o36zXd7dbTK18K2A67gt?=
 =?us-ascii?Q?w6xhveH5qjTtziCRdsj288EG1OFQXj1ac+x5MI6IGnjYrE0wxfGHStqSzjuM?=
 =?us-ascii?Q?RJoZRCN9jjeCWY+8SRfdeMgwe85RWTcvCbdBOOoABzlyD/66e6jwak1WU1u5?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1d554d-e849-457d-1282-08daabad34b8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 17:22:42.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/DPVTR6VF4BoKaHg5h3ZAHkLLJDvogMWRnjC4/nMiy1F0SZBvyjiC6zdqYt/MZe2ywhCmi6BUtIe1xqPGCQPvEcnd5/3WEWUaLbU0PHdOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3726
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


I'll push the patches to qemu-cxl and linux-cxl today or tomorrow, I
wanted to get them into a state on gitlab for Jonathan to rebase and
merge into his work.  He'll likely end up pushing the entire series at
the end of the day.

Will update the tests/docs accordingly.

re: changelog - i'm new to mailing list contributions, where would these
go exactly?


On Tue, Oct 11, 2022 at 10:14:38AM -0700, Davidlohr Bueso wrote:
> On Mon, 10 Oct 2022, Gregory Price wrote:
> 
> > I've pushed 5 new commits to this branch here (@Jonathan I've also made
> > a merge request to pull them into your branch).
> > 
> > https://gitlab.com/gourry.memverge/qemu/-/commits/cxl-2022-10-09
> 
> This series could perhaps be posted as a reply to the CDAT extensions
> cover letter. But regardless, at some point it should be in linux-cxl@.
> 
> > 
> > They're built on top of Jonathan's extensions for the CDAT since the
> > CDAT has memory region relevant entries and trying to do this separate
> > would be unwise.
> > 
> > 1/5: PCI_CLASS_MEMORY_CXL patch
> > 2/5: CXL_CAPACITY_MULTIPLIER pullout patch (@Davidlohr request)
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> However this needs a changelog; for however redundant it may be.
> 
> > 3/5: Generalizes CDATDsmas intialization ahead of multi-region
> 
> > 4/5: Multi-region support w/ backward compatibility
> >     * Requires extra eyes for CDAT and Read/Write Change Validation*
> 
> I'm still eyeballing this but it certainly looks much more complete now -
> at least with the minimal support I was hoping for.
> 
> > 5/5: Test and documentation update
> 
> I think that there should two examples here with volatile and LSA usage.
> The first is without as it is quite unintuitive otherwise, then a
> second example with specifying the lba. Also in these cases you want
> id=cxl-vmem0. And the documentation should be updated to mention that
> memdev is deprecated and {persistent/volatile}-memdev should be used.
> 
> Thanks,
> Davidlohr
