Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D23C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 17:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjA3RQJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 12:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjA3RQI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 12:16:08 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E171B540
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 09:16:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eX7ybODJZcGtGUMDL5rcTSGIQemqQ9hiWtWAtQ2G8hHcZdc2MjU3M5BsGpDqRssMfoeACPhLOaOjmfTaSGrvrCku8G9s6xcOrEf7FENMo6UOgaG+03hVJYpWQL59uNihGVRwzoC8Y+q0PwiH6/mYDMxW9T5RYsQx/9Zw1mXOqU9RwKBAQBAmb0UXjCoTUeIvQDwKFSCuDYxqnKe9pea7TQqDgKEHsejIb1XOvrNoe5sziWtg8hxquN4pPQ8AJ8LCAUw92Kuz2PIvCESPPqYDNlEgnDHwYvxHXN8XeK6TbowT4RB6OSz5NC4TnbtzX91iC8j+ZoDmRoFhB2ROiRPFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8y6L9BimaYAJY6ENVE1B/tBoU3juv0Fe6dUMwUOCrc=;
 b=RYah/XVK0aFkHQiUR/QPr6jgqUTGoGdux6uW9OswydQ7m6yHAPU3ca7RZP2Fr7doeUc0r8b1jgHlTMLIV4Kbfd/yKW1lq5W8T+ImI498/0GkaLxNUsldysOdZkK/CnCWHyqp7G3dkhXTkbkb8+nTTSLT9amrTU9gMK7SP2g+alY4gvRPFXTSxB5Z/DEy/JCXQxTKXlebHnBfZoJo3Gd7QqaUUTVWUdh28VZNHvKRz3ceCgJEMsP6heN93/v8guATPYPobuzIOrrz3pn0W8/+TTGXKEGzCpehItyn2qLXQ55WXnzg4t0rQ16g+UbMhXchMCFQjdlXlMzznI6ZZ7FegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8y6L9BimaYAJY6ENVE1B/tBoU3juv0Fe6dUMwUOCrc=;
 b=UXDPh1HZUE91FQdfWSWmFkWE2OLzL/ZuF9/rcSrbo76JfpxwPyL6TVEbo02K/RWHFYJNoWnetdhhXKJm3W10YM8eoSd5hzX5LgHaY3G/UxKKdkZFlied/BR7x1exNBXvvcPxD5Riv9nNb9ddtjTlQrFt9ct1ViE640eb3pKhbQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BY5PR17MB3987.namprd17.prod.outlook.com (2603:10b6:a03:23f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Mon, 30 Jan
 2023 17:16:02 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Mon, 30 Jan 2023
 17:16:02 +0000
Date:   Mon, 30 Jan 2023 09:38:52 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: Re: [RFC v4 2/3] tests/qtest/cxl-test: whitespace, line ending
 cleanup
Message-ID: <Y9fWfI1ul9J86JWc@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
 <20221128150157.97724-3-gregory.price@memverge.com>
 <20230105143807.0000315a@huawei.com>
 <20230130131150.000023a1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130131150.000023a1@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|BY5PR17MB3987:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f2c345-9776-4e7e-767e-08db02e5a9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56tIrPT962/AvGbeoi8SUiG6LdLM38InShNLWXdAFc9jQLpVNfo1Xxe/ak6OdMJvnyrDhQFXJWv3Bw/F6Ke2IkuB/74Y/+KrFdRFrnHjHdKDfTfp3Sp5l9eH74j5p605iynzG9e9xc8uDmOoPw+GhP46p/xEeGiHVaWA3pkW9yrhoj/wNRTzjbQOU+W1v4pG+Qx6VT66SGow+18Mjndoks4PjK76ug7+XzfplyvQvxsFjsJCPDoIrtiRFknNyi/TITo0dm2ucU8ZipqMJYFt2lr1sfwK33N/gaTuT4uBft9aZ2GrKeaJ7W1SmwTF4towLDtEyVifRMY7TaubrRtY9lnluy/+UZHwYCsmFstp9lcZlnpEd4rKM5ZMmGWd93xyEVqQL9YbksM1CAoQhqXEfyDHs9Tbf63KQHdWbNOyOl2eakUh0PvBrdAImQcud8X1Hui7kuL00uaPrVbVNYzPw8MzSaVevgrT6ZMHQG8H7fhgExhVqJiAUMLvFcpH4roMB2fEQKN4NorJzMd9JFEk6hN9/DEPEB5pvfUxq2Id74UILeaxCthJSwGY0nsPjiNSlESfQMEAGPbgpajbVMAjr2hSZq2liXIEzXPTjyVxSrRWrFG2SNPjwCskE6T3yFYG72MacBcVZ3krmPbgmqceSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(376002)(396003)(39830400003)(451199018)(7416002)(2616005)(316002)(5660300002)(2906002)(41300700001)(8936002)(66556008)(478600001)(6486002)(6666004)(66476007)(66946007)(6916009)(4326008)(6506007)(6512007)(186003)(26005)(8676002)(44832011)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfImD+XrKBKAwKTp0ndBy6h27oS1yKSWgTiCVcJ8EISQldbn9QdZI8pwx8P1?=
 =?us-ascii?Q?DXAbuvesNB+QEHddUPBtWLsqxNSf+RgD8GC4gGJq3DJ0e37xlvVU0WDZmVSZ?=
 =?us-ascii?Q?UXzT7mmkVo9mhRc6786R8XZc0B9BbgxNf5TBjpldsZEBdzP53cFxblBciIxk?=
 =?us-ascii?Q?ma4LbLhBKzXiNDwB5y0MJbPXLmyEXNTXT7GDu8i8XW0up8W0uSaVIsQS9UaT?=
 =?us-ascii?Q?jA2Z4uI4t1Tv1sfPhYluJ48MuPvhUObq4B6kARmOXr7pmdr22PGnczK78afv?=
 =?us-ascii?Q?Im5e+Qm1AgvMxleJ4uHkdiQkcpEBht0a3RgSf9v/4/ErZsLmjiui42dyXpwx?=
 =?us-ascii?Q?UeUL2nBwjSDO2Pl/ZFwjEGBmhzRJ1OUN7bJk5LUFVI91BekkJyVS1k+LwGeB?=
 =?us-ascii?Q?T0BbL+EqNQqOaqyjc6oqu19kVNhMr0oBzj6DhLs1vYdFhCLOiwKrbOWXXJR2?=
 =?us-ascii?Q?wQt5rWNbGiHlQWmFJV3zfpCYdV46hNBBEGLn58GPYrUx2FNcGKSh1wDS3egL?=
 =?us-ascii?Q?zd0+nVFyMniRz6HZCbMnlny1XMNZlVnJPTtwfzi8Gb2awkp88NLVbCvrJxbf?=
 =?us-ascii?Q?sobTzVCe7BncpzxnZAQBcwAPg4aNxDDsa6myaovTRlE3alFib1rCUGknw1F0?=
 =?us-ascii?Q?9I2U4NvB5q0eFPht6vNO7S2Ov+SjKcWwA692bKd4/oOSICkCFGxTWROnP3LX?=
 =?us-ascii?Q?dhOudYRnZKbo/VfqnTjX8V2qPBuweuGOO2zAnN+Fsg4plUOWHYgieNL9qc21?=
 =?us-ascii?Q?LC8JQmLAak7Y6bm90QBnJVR09vcE2260hai0mXHSApWy5/ypHl5dwhFqGVku?=
 =?us-ascii?Q?+4bXyWWZU7plrb+rTL/VYBVdcgkWPqiIKYcbTkCMLKBE8AN5pzyIbYVDvosJ?=
 =?us-ascii?Q?0m3P2tUFXIT6JG6GoJG5ySQVU2zmiqdr7GMN9ClxMVxSwZOQlf7nEAubZzYS?=
 =?us-ascii?Q?qFXTQLPtR9c3kYFRCfvMS7G5FzVDqOFcPdIBo7VgVNvEXOWe3eJF3LvVDZGx?=
 =?us-ascii?Q?Ofq9B8afZGmYwxtenPCTf0FNzF38Wulh34JDhy3AO4oLtFRyyZ73nD1aDUOc?=
 =?us-ascii?Q?e5YzNVU6NrUOk085pIccKxJ8fIW/VbM6vjgZgYMQEFvU+3T83F1lEXedEz1X?=
 =?us-ascii?Q?kM28ZvOGky2G9bx14zh4WbgOI7Tcae4+Mw4hGoP9/Dzm04nQKAZIZrI3AiYc?=
 =?us-ascii?Q?bmMcbez3Nt1D0S9CltuKp8WE9cR/hQOo2RZsRCGmLu3rtRPMeKzFyAXhFtMj?=
 =?us-ascii?Q?8XPdvVFAFsMTcy06bP/agFZ0eiJht0hbEpTMjWdg3Ts1RGl88Pu7+GrzSYrM?=
 =?us-ascii?Q?LbP96YU80yQPnIdMtMOSNL/1BFBPrYS2kVUM8LptVGx1QKt8xB5FZvk3AdvK?=
 =?us-ascii?Q?1yO+St4MBuT2vH631Qcf/l8nPRwRz8xe9LBMm1YLvPzXWgpqt4Bz1JumSved?=
 =?us-ascii?Q?QYvS0vWKzby0UvBC0MB55yTZjH7lNAgQtqX8OF3O4pVVbd+loJCj4hv5AgaT?=
 =?us-ascii?Q?s7DrSBjbjv+nM/XO6y9o3yS7v9266F/ULItnELp9L9LBF+ftmBJh4H6s46rW?=
 =?us-ascii?Q?VLAufP6ThRuzfhuxuilaUqArmwBVjQCNWIKHr1LTxavTkR0fmXYANxp9elR8?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f2c345-9776-4e7e-767e-08db02e5a9de
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:16:02.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEvjSazrG0n79n1CJlwVeVLYvHS7iMTqXD2pW7ahrC0vu4IJMbMRJLhSZvnRvZIo1G8FJRElf/418qycTPoPF/rQ+aRZTQt4ksrtrE9xxcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3987
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 30, 2023 at 01:11:50PM +0000, Jonathan Cameron wrote:
> On Thu, 5 Jan 2023 14:38:07 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Mon, 28 Nov 2022 10:01:56 -0500
> > Gregory Price <gourry.memverge@gmail.com> wrote:
> > 
> > > Defines are starting to exceed line length limits, align them for
> > > cleanliness before making modifications.
> > > 
> > > Signed-off-by: Gregory Price <gregory.price@memverge.com>  
> > 
> > Hi Gregory,
> > 
> > I was just reordering my tree and noticed that you've only
> > gone with 2 space indent.  Given 4 spaces is the convention in QEMU
> > for other uses, I've switched my local copy of this over to 4 spaces.
> > 
> > Note there was also a single inconsistent 1 space indent - see below.
> > 
> > Jonathan
> > 
> > > 
> > > ---
> > >  tests/qtest/cxl-test.c | 99 +++++++++++++++++++++++-------------------
> > >  1 file changed, 54 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> > > index c54f18e76b..e59ba22387 100644
> > > --- a/tests/qtest/cxl-test.c
> > > +++ b/tests/qtest/cxl-test.c
> > > @@ -8,55 +8,64 @@
> > >  #include "qemu/osdep.h"
> > >  #include "libqtest-single.h"
> > >  
> > > -#define QEMU_PXB_CMD "-machine q35,cxl=on " \
> > > -                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> > > -                     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
> > > -
> > > -#define QEMU_2PXB_CMD "-machine q35,cxl=on "                            \
> > > -                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> > > -                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> > > -                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> > > -
> > > -#define QEMU_VIRT_2PXB_CMD "-machine virt,cxl=on "                      \
> > > -                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> > > -                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "  \
> > > -                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> > > -
> > > -#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
> > > +#define QEMU_PXB_CMD \
> > > +  "-machine q35,cxl=on " \
> > > +  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> > > +  "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
> > > +
> > > +#define QEMU_2PXB_CMD \
> > > +  "-machine q35,cxl=on " \
> > > +  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> > > +  "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> > > + "- M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "  
> > This one only has one space.
> It also has a space after the - that I somehow missed. Fixed up in the version I'm
> carrying. Will push out a new tree once I've caught up with some other pending items.

ack
