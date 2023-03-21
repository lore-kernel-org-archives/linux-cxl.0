Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97433C6FD1D
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Mar 2023 17:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCURRj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCURRh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Mar 2023 13:17:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104B9195
        for <linux-cxl@vger.kernel.org>; Tue, 21 Mar 2023 10:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miHi2cs0e0RvYnGbA4SFAy+VryJs9xjgGLeCv4WRDxSEOpNQb4oz6S3dHxEnsZ7G3EAwXQLhCn4z0kp7VpPUJf/5J3xC+qXtmkmGswaebnnHtWusUjxeFDnxPRDCu2FlzyB+gMOpKNq4jz7RF/jdutoN9zGs0Rx334kqBL0ZN1bli8yGN2n8n3AKl1SlNjUNNy63U9TRkzKRtmr7EOdizBwCRDzEkx+4KrAL/jTnCdQVv6a8a++hOID+hhW6oj9OBzC/8wheYf+By4msWPtIeSdivpWEKzFOGddjcStIh6aTSoMfhrp8a+eNOHd5tOvVykal5AFVSRBllvkv8CKaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9otVHAqHZ4bMyKm2i+5SFUh6UUGfxDY/0ULI7i+9Y7w=;
 b=KqnRa3ZIt41Bj4Gysg4fLoykhmfVXLcpsbru4p+SIZLo+0Q57siKNk3lSLyLW1aFQJofuu/+9fcPm64Sflgf4WJOitl+97sVrH8dKsIiy8BbssZb4sjHWyjyvMp8rjfe+r6AKugEkZQJ4nmwPcRoaYuLNm6XpJwG5QbFVwPuTxnPIxAEmzUExwuZCmBAffE0VEDQclfKoYXlToGlq0q/0i6XFSQ5flly+hd+cbMWWp26Q2S8vnuLBhX9bIytrg3UqatIpcJjS2VmjW+o6ynxyUmGo3WqfUEZGUy0wY7WyT3CfESil3cfPPG/+dC0b1A5YBL25wuJX+c7rh+ebvWMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9otVHAqHZ4bMyKm2i+5SFUh6UUGfxDY/0ULI7i+9Y7w=;
 b=iKZ1DOjJj7rBvGICtGj5wUl6D5BlqR0iE95OwPzuWBG1FIKyxlN6M8UZjmVaH9pj/V4UEXuiu7GQXvCe9yUdx7YmrtV7Gb/K3Vrr6u1jVOAmThGuvf6yAnfyc9y1T4x+RIj/1qTXc41S93A+ZN+Ejh2Qe6QOpoBWu6PSO4v4jf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB5612.namprd17.prod.outlook.com (2603:10b6:303:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 17:17:31 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 17:17:31 +0000
Date:   Tue, 21 Mar 2023 13:17:28 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dave.jiang@intel.com
Subject: Re: [PATCH 0/2] cxl: DVSEC Range emulation fixups
Message-ID: <ZBnmqGxU0kqubfPM@memverge.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <Y/gPhE3hDnTEd6PI@memverge.com>
 <63ff9d85215e_495bc294e2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ff9d85215e_495bc294e2@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea035b1-241a-45d5-7e2e-08db2a30275f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CazcvkXtCFDUQGHiXy3UpPITKK59tH3Gf9mhfREK/0JLWyiSTmqmrLyj85TQ9t0bk2+huxRfxuitzWEytWbwNuglzdu/rCg5jQ+kSeOW2E+B3+9aCgS2IpGknrk5rqr7UDjr+hIxvIsfN8TNG9HYxhud++QIjpfRY5GxUbvFtb9G7sAm5jFAnzFQ57l4F3CPeym8DUaaUEcxednf92144+iazDEtB5TKOC6heVqRkCb60eMpyDtZNXWzjKUIw5291vLMS6e0xwXQuMFovlkNFH0UQ3LNS8WZkQC0kRJPLOY9nqN/K1pgYbiFmbnuvH45mQE32o55FTSCUMXhIgF6DuzimWTxEoyRXBmZf6ESpl6fP+W4r0ecWrFiCaWpNOu/AHBeIuktL+qg7mAStiEgmY6WoSs+08guJypaVZ/OwDDaFDcoKUKTrmj18Ht98qqVxsSMzCdnCMr2ZDM4Ad3mLKIL2L2MQmhJ+7Yo/4DMST2zfIRlTotGW0lKO/zOTS0Nqm6QDOarJDAihCuUjGkmw7IjRkstaqLkatDL1vI7/KZwg3837VGadAVW5475j39VBFEdITLqfbHIjwC7Ih+9k+U/6HP6PnirqvTpbqVEqKWvacYcG5HCH+iS/CR2nkftJs0jc11jek9bjyAip4Pn4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39840400004)(376002)(396003)(346002)(451199018)(6486002)(2616005)(26005)(6666004)(6512007)(5660300002)(86362001)(6506007)(478600001)(316002)(186003)(83380400001)(66946007)(36756003)(8676002)(6916009)(66476007)(4326008)(66556008)(41300700001)(8936002)(44832011)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXGPh5VAUIAvxz9J4tahfyvYCFO7YPPLE0Xyl5LIZAvRGcr5RUQk77DMcao4?=
 =?us-ascii?Q?9o5QuSsei+rqPplaixd9eDO+sehELgv1GLeIb/Vw334hM3nI0uMETfD2urKJ?=
 =?us-ascii?Q?AZbgaxxfSV57Le2HSyG861r5VJKPoic1GZOXpckrDnf/g+memCkn3tHp2Fav?=
 =?us-ascii?Q?gsh3gHyeBM61vjVbY7/H2tGwoY2uQQnUumis/l1wNG2+yWbnXpr+293dIN3S?=
 =?us-ascii?Q?AQSpj6K2eqYLScvRmbvXMbXFDlBNnI8uVbaaUYcsIcPA4yrgU7k2YPq+8/Ei?=
 =?us-ascii?Q?unc/ojw+sC//Bu1F6Z5iE+i0kcdGz8aAvTPttdKLj0YtzUxPJso6VylX/sqT?=
 =?us-ascii?Q?R34TwjPuZORP5feXaN+W4k1TRSgn+L2J5jne+J5IFflMXxyUIZh2xhBsee4F?=
 =?us-ascii?Q?rlOr8ZAAQ5DiLFR7cAqxP383lJk5be/BdCV/ceMFzAOcDedTbD0p0WRGk70s?=
 =?us-ascii?Q?h0ePkKI/7TZFuhxB9sF7q+ly7Z/vCIxVJco9ORT5Jnrp5/DwG9X54AHTiRgV?=
 =?us-ascii?Q?LLePtItHhN+vQRthktQYYgrgZDX1uIVhZKJc2sGLhdFWs1u93rGK+tsaTHpk?=
 =?us-ascii?Q?uuitLswXRbyPZCg+1RngRLuGJ1LvpHIJ7iARMILs6QS1l2044E4Uexgb6r0d?=
 =?us-ascii?Q?UMsbNnDuuJLzu2wrqWBwLUHqswBERbYDKPv5My2e6JmUOeM8SusFH0bFQlKX?=
 =?us-ascii?Q?zfRPLM5uYPfOh7MloDqHbyskp51BjUzCDpjQUuq0L8nzHN2NUO4ohP30t5h/?=
 =?us-ascii?Q?ybUoDVeAifOXXSU+3iyznck+m3lD5C2S9kVsjraoWD9oVLFwaN4fk8rmF5BE?=
 =?us-ascii?Q?yX/Smq/xurbfrUVl6zMiEHCT+LirWGREI+SvKEDZXkkoStBq1GBH4qUCZl6z?=
 =?us-ascii?Q?4X5IGtcgT2ZFgRY3gfApF8o0qoxvL5kEGgbLzoZAzwnsiW0l5SOVficvmFh9?=
 =?us-ascii?Q?DvY5vdlEsKWFrDOV0fsKYZBm+nvO+jsKg2MVY9LHWgkb3nuJVS6B9Wno4EoX?=
 =?us-ascii?Q?ubQU2BWLGwSAMi5PqoKQUvDtjqhEmcuTH4uTaEBgNHuJivV94KAA0dSt7gGR?=
 =?us-ascii?Q?sLUOeYmiTL+yl9YcmofMDGalTYrC4A9lO+5JjKrB6n+2d+5LfN7TRTNslYtW?=
 =?us-ascii?Q?6LdKos4kMz5jsygS60VXG36xPa7nBXYak0kr+7aoua4Jg+pBA2lTLRdjtKF+?=
 =?us-ascii?Q?rDslEC7FN/TUi1lz+CG1xvAMi+2UEzulCvmmsT2GZyjW9uTo+xTQ/AYLWMSz?=
 =?us-ascii?Q?D6MbJ1S/apfc1hl8Uz2sz5MNQx2fx4hqXU0Xqflhmbu5LYZ9oVOr1IgPq5Wh?=
 =?us-ascii?Q?QOsBHXB/NgNIslwCJ/r2d9o7IK1Ig4lv9+Dz1n0iV48Zk5ynyOvhpc/ljdUV?=
 =?us-ascii?Q?l0Wk2LeDo19IR84SAWxM1oe98kUIwo9TmXPsLWP6TceTJZvkKNAnsHxdslhz?=
 =?us-ascii?Q?s1rDW34LaSrztge6GvXdtKSxRm7FdAFxOCdaPHQGjOZXifXBW+bEGMQJ1sC0?=
 =?us-ascii?Q?QWPeXQyoz5EGVQixN+YBd9VK2TTmuIJ5FwvvwvAexg9X7X2jieZYA0Y+Zygs?=
 =?us-ascii?Q?p63HY5E1rvifiNmZcLoqr5yztslXanGgHjuOFCtettJJ3H+rnQOgAhmFScC7?=
 =?us-ascii?Q?HS/1BzTlB5gSyLi8pAcg0gM=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea035b1-241a-45d5-7e2e-08db2a30275f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 17:17:31.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxxMJ9qrs+F3gGbeIIu0czrRh0fFoiL0yubhCgs4ekBxG73EsIkyqTuvaWYb6Ssg40Z6DqaZ0Gtdqqw9sNgmh7F7DYLXMmDsuzDszpfDEVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5612
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 01, 2023 at 10:46:29AM -0800, Dan Williams wrote:
> Hi Gregory,
> 
> Gregory Price wrote:
> > On Tue, Feb 21, 2023 at 05:51:13PM -0800, Dan Williams wrote:
> > > Jonathan points out that the kernel is too agressive in assuming that
> > > DVSEC range registers are in use, reliably skip emulation if
> > > 'mem_enabled' is not set. The helper devm_cxl_setup_emulated_hdm() is
> > > needlessly redoing an allocation, clean that up.
> > > 
> > > ---
> > > 
> > > Dan Williams (2):
> > >       cxl/hdm: Fix double allocation of @cxlhdm
> > >       cxl/hdm: Skip emulation when driver manages mem_enable
> > > 
> > > 
> > >  drivers/cxl/core/hdm.c |   65 ++++++++++++++++++------------------------------
> > >  drivers/cxl/cxl.h      |    4 ++-
> > >  drivers/cxl/port.c     |    2 +
> > >  3 files changed, 28 insertions(+), 43 deletions(-)
> > > 
> > > base-commit: 23c198e3dfaabbc891681aecb0855b9e0ac791e1
> > 
> > 
> > not *quite* sure what to make of this yet, but i get stack trace on boot
> > on real hardware with this patch.  I'm debugging other issues with this
> > hardware, so i'm not sure if it's related or not, but prior to this patch
> > I did not have a stack trace.
> > 
> > 
> > I think there's two issues here:
> > 
> > 1) The system I'm on fails to register a CFMW/root port decoder.  I'm
> >    not entirely sure why, other than during cxl_decoder_add(), the
> >    target map contains "[0,]" as the target id's, and the only
> >    registered ports/decoders are the endpoints.
> > 
> >    I don't know whether this is because the hardware just doesn't have a
> >    root decoder, or what.  But it makes the volatile region patches
> >    non-functional, and i have to revert back to static configuration to
> >    use the real cxl device (i.e. don't mark it EFI_MEMORY_SP).
> 
> It looks like the BIOS is trying to report something in the CEDT.CFMWS
> but it looks
> 
> > 2) Per the second bit - there's no component registers being registered
> >    for this cxl device (plus some spurious DOE error).
> 
> If the CEDT is broken then for RCH topologies the device component
> registers will also be missing.
> 

Just following up, you were correct that the CEDT.CFMWS was broken.

There are other issues that appear, but I will wait for updated BIOS and
then push a bug report once i validate it in a more sane environment.
