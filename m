Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9506EE14AC
	for <linux-cxl@archiver.kernel.org>; Wed,  6 Sep 2023 16:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjIFQPM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Sep 2023 12:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbjIFQPK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Sep 2023 12:15:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FA1995
        for <linux-cxl@vger.kernel.org>; Wed,  6 Sep 2023 09:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPQ4TlFXIKanv0wU4S+fke5RHTi6V1v9XBOJ3ljrVC5WYU9Q2aYZFnIGYMcqUFM6UU0qhqmZfUHkO4lPhfgyQC3jh96EtyxWkNyvOm1ddIWOjw5KGRB3MPHbJfn0qVcgg7dvBKAp1MhFcjPVNRXintlvGrkPayRZT12l19MygRg2uD4S/XwE2PNr2QXv+KeNi4xb9UCsYohJX0V1ONZTcD5M6ICyzqamM09EtgZVxvmKLSmfb1rEjD9lY4jm2GwD4u/FZeoTNHkm5oVm4LtwrSOrV8Lt1bEXb+MpU7M2mw+U9/iOtI4BAOUF7zaGcXtsCpMdI9OUZ2nqmSRCOoFS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bYS/ZunbqVoTm0zqs0PHV3JSeSRAqJYFbmJoYbcRmY=;
 b=GJqi2suw+ZpquCKYpMxmIHWtwgVAkq6dMJ8vipzJcLZ1O2hfnrGuMEVZa/zPyivxPf4TLkVCkKfv0FgglrhEK/1NNS5GVgLGqCLE1cH/b55GeQWmB3U9mYETEnB60UH/fS+G07q2RpqFN9tEelDuqHBYU3i0Hv3chn72+wYuhDw3dr4bJ+52tU0FIcPoubrHgkpkD9ccprfKU25g66rbqABvbu8UEFuuYCHhczYH19kXcrhCil/xgtMAo87u8U2LDzbwe1AdPokBBCfRdtLCdUEVy4/TtSvgaNHBJt/Q0PghAjyibdgzM051JbmQh+ooFLPxLgrkT1caiv3GolGwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bYS/ZunbqVoTm0zqs0PHV3JSeSRAqJYFbmJoYbcRmY=;
 b=SRLi8t8TmwSRzrQpimfzAVvEZetj4bgTmIVVEVcZAp+IBpha61svsFo1nSaOa2a6Z4sp/4thhAhSZ5cLDWSmdJ2gbsI+/vv2dR70Xzr+cQCh3UuidkKd3WHFqNT4t4Nz1bzt5rFsE0A8eRqEDCfn9hgMEATXjZSVMHkO5LcBC54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY5PR17MB4081.namprd17.prod.outlook.com (2603:10b6:a03:233::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 16:15:01 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:15:01 +0000
Date:   Tue, 5 Sep 2023 12:04:29 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, junhee.ryu@sk.com, kwangjin.ko@sk.com
Subject: Re: [PATCH 5/5] cxl/vendor: SK hynix Niagara Multi-Headed SLD Device
Message-ID: <ZPdRjVjbbe9DkHW5@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-6-gregory.price@memverge.com>
 <20230906140445.00002acd@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906140445.00002acd@Huawei.com>
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY5PR17MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 527c3034-c942-4de8-2e76-08dbaef46bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHOWCGxPQhpwtORShJo5mEF/53SikNDf3F/7i/h+gtfIN9jrqeJMP0cQQ0n9u9S0PhKr3w6rnkweHfKOCt6n+hRdW0DsVq8y+6bvuG+5dqozS0+vGtgu5t8Baekcwa8mBeeYSPTCGWBFCqlg+ecAB9gGbootUT7HOR7MOi7UWK/c/R8VIaXYqfzyAGdM0yqb7HiwlFl+yRjOcZIokyhKa3A+2jb1uwBvSkMlxUqWd/+cjtn6+LZEnno+5hfRBkmhaj+OchPg+8YvU1F7E0mbWgBZMNfCmXlZwXGg4svswZjUnzUdzL7jllHI+GrXzrmD6RAxnpLFmBunepd3Fsqb0SiUw4AFTbTbaCSl21IdoUYah1I0QB04VfSFL+NoK8ZZLxh2MFqZHV2/aTUEbYTQYpGiyEMmp5LbaGbYqUN75/lTeGOzKBtHn/uMIm1lQ2SsaSj+lQ2AjQsgcoNKH9Gs3UcXoliqQGOGjPfRt7a+XmZC5YvCyxKDwcbfpaRBcA0z2Yqdsh4ngA1E4X8OUKxfSL3tw6Its7awz066tLe/pIW2iwZ8w+aidukil3NZBkza
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39830400003)(346002)(136003)(186009)(1800799009)(451199024)(41300700001)(26005)(6666004)(478600001)(86362001)(83380400001)(38100700002)(2616005)(6512007)(6486002)(6506007)(66946007)(8676002)(66556008)(2906002)(316002)(6916009)(66476007)(36756003)(8936002)(5660300002)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eezMfX97lcnuSnXtZ+2z/W7H2KtPJ0QoUsZaW/qTqWIPjIFXwjyow5pFMiUr?=
 =?us-ascii?Q?3/oJz6e2ndTV1Jnoi3aLEmAv4+e+TNQVW4wO09SV18F+JLtWZLt+rxRN4k1Q?=
 =?us-ascii?Q?yH4dTCV3gBoxZRvrmup3aCXcKJczmO3sE+g+jImtvX/BxyzUvg4Dg6SzjJ6u?=
 =?us-ascii?Q?i98fi/Eckp+DbOACQuy8uO2UW65YNWXYZx7zmGfx4OBRBxuZLe6EJ7V/rioQ?=
 =?us-ascii?Q?pfY+k9Vawh5pNSR16BAv8t07tiAOO6KYhMe0nFHFlPaCYo35KtIjIS+n5JRU?=
 =?us-ascii?Q?9W25BKATUgawlyoJRDZ46C5MPO3Yovf3v3xxL0aapFiWOgeCoDSHQ4TLXs8G?=
 =?us-ascii?Q?uTFl1bLiB1SqYZqSGXM+IMaQKAcJBhDajuzWUn6erBdRgA1aXWzFBOepJ/gN?=
 =?us-ascii?Q?PBvJgEGFXH1rDL26kcYHsOGQhu3LmwM7RB42TImYXL2+KtSOY6GgBbSIO1g9?=
 =?us-ascii?Q?QET+ALm8WkNX5E1GuH7Xi+lcfBd4nzLEuncsbHzfn4jVkKGgwK0PunB8hMvD?=
 =?us-ascii?Q?RkDGXX7KHyNb7GSWwDnFFGZxQ4B4f2NoqtMIMZiVrXApDlznpTKt+olcyUG1?=
 =?us-ascii?Q?/y3c9hxTERKcBbj5QWO/+5w81swehve+btBzI3pyZKwj8q30bx5+RZZS9A9F?=
 =?us-ascii?Q?ZK/C1i44xLV1y7tmW4f2O/Dv31MuLjMayOoEC55Q8FcmX6NT9HXmYq6GdMc4?=
 =?us-ascii?Q?Cn16L3MAhyUVh9dP/+eRPZBhyOzBqq2Nd8JaWl2HEzVguFD+tVFraLEWZZZO?=
 =?us-ascii?Q?Q4+8ZeCcU1HbJZD7izSjxFpQtmM3OD0FETj396sKtqhCB6BhMBG5tsFDclmq?=
 =?us-ascii?Q?5nwaxlMUtrMZZWn3zov7g5Cdf1R1GSMyKLgBil/PEMjudoXGNBISY76DhOUO?=
 =?us-ascii?Q?nIXV07MRKA24wCsOZasjEDuGJfhuyWzchuV2n4UwQCdRss+et/je+p5JqGK7?=
 =?us-ascii?Q?psUVYX4xcAtDCLcpu2XVkiGCN8vCMAiBmfBS974gKM1XbDzLwZLWWP8d33mB?=
 =?us-ascii?Q?ytD7ifcmst05HaI6ctnubeJtorOu5OhV6l1qah2RZ1FWF8018N95IXD+udBM?=
 =?us-ascii?Q?vJWycOEdxvBnimNHm68hts1uwwlo8TEpoHfAvQMuoAMtqmK573wD2gErnTD4?=
 =?us-ascii?Q?9SW7YKg9pA5aIi1cWyFmpNGfSkEq2q65FSokxwoW0h9sJysX4AgDwEum55Jt?=
 =?us-ascii?Q?iCUoh9KJwKWeoX8Fd6B5Gp0odsUMOS9fhMU+zjbj8FP+/TEGtS4fDfOA69MQ?=
 =?us-ascii?Q?mUAjS3fbEfjZAApXY/aMUa3cDdpQxCqFSsi1wJ3vsnaaeNiUnX9hFRFxbadx?=
 =?us-ascii?Q?ISWNU6fSS5fvSKUgFw7b3T0h/gYRuKU59JhglsBdulCFwt4JVWezoyTIw+DP?=
 =?us-ascii?Q?Y1j6K25aNX1XfAtP6AwC2XveUc1UZ/U1xlcNMi14RcY79CNsKqO4x09Nr2nP?=
 =?us-ascii?Q?za5ps8X+crit8d6aD5+N6UqO4XqnqLX8x5GA5OvzNLHQ8HUFcTNqOLnst5vk?=
 =?us-ascii?Q?7w+gMI1VEajmDyGRO28SCt26fyuu1G6cfSTQUjee3IK0iduS+szbR2l25uM3?=
 =?us-ascii?Q?cHmvacsd9QZ4ERpq8itPjgBl+m5Nln4QYgFPiG5N210+71stZRhZjtAvJ7Fl?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527c3034-c942-4de8-2e76-08dbaef46bc1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:15:01.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzqk3R8rT/W0tpo2qAwvzLfQ1fmJ6zyy88kgs1z9V/LEtYdcbr3xvvHTec09uP2VyNuujoS2yDkMu/OVOVJYVWVvvC7QMxvu4Pz28esBbfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB4081
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Sep 06, 2023 at 02:04:45PM +0100, Jonathan Cameron wrote:
> On Thu, 31 Aug 2023 21:29:14 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> Hi Gregory,
> 
> Some comments inline, but I'm happy to add this to my staging tree in the meantime
> as it stands (might be a few days until I push a new branch though).
> 

I'm going to do one a quick v3 today with the feedback and some cleanup
in spots i noticed.

> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > Signed-off-by: Junhee Ryu <junhee.ryu@sk.com>
> > Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
> 
> The SoB chain needs cleaning up.  Is this a co-developed situation?
> If it is use the rules in the kernel documentation as I don't think those
> are yet clearly stated in QEMU docs (and they are confusing so I won't try
> to restate them here).
> 

TL;DR: They gave me the command list, I wrote the model.  We got
approval to release the model, but I wasn't sure how to capture the
copyright/SoB list.  I suppose the copyright covers SKh, but since I
authored the model, it only requires my SoB?

After reading, I'm still not sure how to capture this lol.

Should I just switch the skh folks to Co-developed-by?

> 
> > diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
> > new file mode 100644
> > index 0000000000..4e57db65f1
> > --- /dev/null
> > +++ b/hw/cxl/vendor/skhynix/meson.build
> > @@ -0,0 +1 @@
> > +system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
> > diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.c b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> > new file mode 100644
> > index 0000000000..88e53cc6cc
> > --- /dev/null
> > +++ b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> > @@ -0,0 +1,516 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * Copyright (c) 2023 MemVerge Inc.
> > + * Copyright (c) 2023 SK hynix Inc.
> > + */
> > +
> > +#include <sys/shm.h>
> 
> This will need some osdep.h magic.  There is some there
> already but it will need relaxing (unless you want to run only on sparc ;)
> and we may need to make this device linux host only.
> 
> 

Good point, I had not considered osdep issues.  Do you know of any
examples of linux-only devices I can use to do a quick patch-up? I 
can come back around on this issue later.

> 
> > +
> > +enum {
> > +    NIAGARA_MHD = 0x55,
> > +        #define GET_MHD_INFO 0x0
> 
> Is this standard as it's in the normal space?
> If it is then I'd like the implementation pushed down to the
> type3 implementation (with some callbacks or similar.)
> 

:thinking_face:

maybe a similar pattern to the callback from before? I suppose I could
push this down into type3 and add an mhd callback in the class and have
niagara fill that in with the callback.

That *feels* right, so i'll go ahead with it.



If I misunderstood anything, let me know

~Gregory
