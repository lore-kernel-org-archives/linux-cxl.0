Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072C1C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 18:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjBBSyf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjBBSye (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 13:54:34 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10CF13D51
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 10:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wwat486WqRJH1YohQ+y4nHNIPPweRoGlOF+xOqFxC//wlCiKk4A2mXYGapz/FfjYQR4esYqu8H8SfnY+TOQUcslqORrxfvmBsaR9kz9xf2b2YPG51zcm5cjTOrxF16E4wO/Vr/esTaYewH2teYZZQRTVzliAEzd1aicJFiKH6YMLPJp4t4cb7lkxj01n3upN297qn03l5dNLfTgnsGJRP1jZE5ebkQ1EYtp1hYObea394qym1R032WZmIJ/GsFJtLNC0iwRAQVdxi5pOon4oo657p6Fmp5XTYW5b1We53W9kEhtS3XBuvNpADMpzzzvuJLJ6JMimD5xNo44Quvj9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHd+HXBycbaZ6MH786rvF0Re+nX/cYXbRpGtQQ3v/cA=;
 b=ViqnAtwmQYIC/weYJCgp/APHNDDwKH6iU/QyHiPi10hNY30VtsOyOReSbHvwWeGQxdozaDHUdgtOD4/kCwj6rRajlUgKFYWLVmGj6lphgsmpyI2+L6AdD4Xny4vZFnAFuMERtyZI1UzC7erVsK9x1Dhk0sOKeFNmueIP5S2FzXEAYj3Fd+HzjAfSSFGMBh7Q3EfoZRzZ9mOTO7U7dedRHv4Xd1plvqjIztxJNdRD7/1pUc7Xf5/VAhHZzy2iiGAtYNC3/aeeaA4KskfoCrmsRc36iBL0N8QX5F7i+3kXmaVGfcSV91PKBq7FX7VwGl5j3CAPQjSG7xTXmBh8OQprng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHd+HXBycbaZ6MH786rvF0Re+nX/cYXbRpGtQQ3v/cA=;
 b=SzVX6zydaY30lAzLX0qFP3eEkKDcjjC/B0WGdveJBJbV2VHO1BbXWytWuzFQD7s12VVggJGSuQ9jgB4frP8WmgLntgTKUH8wP/xVgk0aexT6UxSlBNjlk6LYSkNgc7Y9MS8bbdm0dMe/GDz/TPdB46i0XfNxXp395X/8O9A4lKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB5053.namprd17.prod.outlook.com (2603:10b6:a03:3bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 18:54:29 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 18:54:29 +0000
Date:   Wed, 1 Feb 2023 19:43:21 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9sHKYrIvCTAZu3r@memverge.com>
References: <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
 <Y9meWfDiCGbca4nP@memverge.com>
 <Y9mhe2xPGRE1/7cC@memverge.com>
 <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
 <20230131235003.GA336751@bgt-140510-bm03>
 <Y9n4zjtwf+w6xnmW@memverge.com>
 <Y9rWskfaz9dLoW+l@memverge.com>
 <20230202160314.00002cfa@Huawei.com>
 <Y9riPw7ccA34FQG6@memverge.com>
 <20230202181357.00002827@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202181357.00002827@Huawei.com>
X-ClientProxiedBy: CPYP284CA0070.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:80::21) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 87730e06-4862-47bf-2ab4-08db054ee9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GyTYbdfqGQdlm8M02OPGxWiuf9Da29bBW3LC9Y4dK0HaIihAPMdFJA0bFDBG47VTW+KSJQ1A/KobI4rST/TzU8RjPnQnXWhcCNCqgVYFlUZVVXSWy2S+vIchBAAVzv0f5iKSmrb/NgrjScTxAgQwQRFR8/V3bOkREOhCWTstSB0xTxJLYHcLQSFM+dR+hUQ69TtaaQNO2tGXApJKlViCPj0kfTWhzzQ4hR9dUP+vWsENWRRoytiqKS8GTi0Cc043CIKyjIJojbZMbICNjtpL5wDAKeMAgRbdhcn3ZLgHLJq+/+6u1xybwtgDnN418QPggZmfUEyN5353NYXV7uTv7EHP2r7XkqeZyyK0Iauwl1GXXUI1glUTyc1ZRIaiHx0NyRgO8C6SyIis9h46yabnoSD3L+x2lGpzDNkPxZxux2//2mxJY4dwwjy76d5FeqM7ghQnRvfICE8Mc289DnZETvab3kx1CFWOKaoC1Eqpndxu4lqKbolaECdR4AoWz0AzLxTz38tsH21A051/NcqBhISVRqkbzAZHxQO5xNlUlVOqV9kWh7SGtsjre2BFNht5ixOjK5Tq2IN4BIXTnsfLTSH3F2o7C7RahsECtRrEXOj8frOEUIlAo8RY7KElI1NQ/XifE9vB5djaSkHbgcd/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(39840400004)(346002)(451199018)(36756003)(44832011)(66476007)(66556008)(38100700002)(66946007)(83380400001)(6916009)(8676002)(4326008)(54906003)(316002)(6512007)(26005)(478600001)(186003)(6506007)(6666004)(6486002)(5660300002)(86362001)(41300700001)(2616005)(8936002)(66899018)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hA8ztrFMdtNX+k/nd4jl3J9XoWxx6CndXpZvaLx2JJIHHDobvLZY3UbqW13f?=
 =?us-ascii?Q?woMNZm9CCpIF1LZBMGkIjLHJ+mEbXabqa7+0NKDO8XfEGVGqZAXu/gwWQCa2?=
 =?us-ascii?Q?YBiokguVUgqIWA5S4sSv5MFSnxUR7j8O+3NqWhebB64kAtUBI3nx/qC3IBHA?=
 =?us-ascii?Q?eue5LUBN0QqK898bIm9Vx3nMfe78rQpaf4xBvgj92PCcHfn87yuQH5CSN16v?=
 =?us-ascii?Q?/PiR9CkuYv1lqxNtvkgneQGrRDDYtYRVdBX36Hln/faaIKdELJGlws3eNvGu?=
 =?us-ascii?Q?TAAvB4laEex/OAumE+kAHD+q3MD2oKrxsbyphhcOUubfZwFmOtLZx1yHxnHQ?=
 =?us-ascii?Q?m8FZmKOpY7DxlpSYWVfeY8H8VFP0QMXid8cpsqxuU9i8dwPLTm0ilSZcOxv3?=
 =?us-ascii?Q?HPh9k7KokMlcIaimeHfDhKhGsRKbwxBMyCp/cPtXywj1aGnj5t/oPydtN6A7?=
 =?us-ascii?Q?hesyAjnC6/Sm7sC5dd84XHp5y+L9+8eIkBtO+HFhuLdE7Vqj+j1TZAZNJo5+?=
 =?us-ascii?Q?atxwQLP6WQZQVombO6cZbFoONeiz+cF6OpOgpXWxaBcSZYrpVpaDLK7Ay1m7?=
 =?us-ascii?Q?EIlEnfm35WtWTSenDTUZcOjafGHJOe7z10878MBVfGjxLkZFy49VqLNnVaLH?=
 =?us-ascii?Q?bXbheGPCEYi9jSxp6fLsjh31aYKIhWJD17fzB1HMyOcl7mVAgHoGkjprZxJ5?=
 =?us-ascii?Q?upWcAhxaRe474dSrSAtnsqdBy5aS0NrWpJ6ihALPXIO3RN5ZCoGzrt/kxUuy?=
 =?us-ascii?Q?LLTOGxT8Xipw3WS0o5B7J9FOpmZyKTlwuP76rSthI75xUaOghm/vetNizdvx?=
 =?us-ascii?Q?+SDHc/nJRrZ2OrFrCqSPdi98750IeoqoprBFSHHjg+Ft7X4pNJZr8kO82rY7?=
 =?us-ascii?Q?LaDMReIcluCeXsXIEN8j3rx/RLVD6Xib0svy3KadD5ggGzHhuCoC85fnp4FW?=
 =?us-ascii?Q?+EK6iBS8jPOJdCfefG2qZUOuyJh7WUdF9imIYzQb/1u1sJJPkzSliBpvHv4n?=
 =?us-ascii?Q?RdAVgY4sF/ZB5D7lSkDc57vMsQXsrWonNMQh7/0Un1kYPcinu9G3NJRAjIlY?=
 =?us-ascii?Q?u8kGufENbGZBzMHaQ0WY0hBcJr9p/PZYoJv+BzqGcKBpN508J+acd5mZVsgU?=
 =?us-ascii?Q?yloTVLY2nV4NDTIVLCUOSt/4U1hXgxHuDnQA7vs+rcMjWvUJvZBIDeHuVcLP?=
 =?us-ascii?Q?LtFU8umMd9YIMBzwonE/XgusoSLzAxts0H+dMvXWfIQoAlpjoS9uOWaVIPM/?=
 =?us-ascii?Q?icoelg36+5w0WbjxH5Q0/0Ob3EzqBgy2YfRx8PB6bsBDM165wjEM0SNzQmAx?=
 =?us-ascii?Q?bGL4rVrhYTgDRrdTB0b10uQKAP6fer1tAyPG026F2+LtX6cRJpK7Wr6wtI/b?=
 =?us-ascii?Q?ARmYmD09husDOc1lsh4TZGi/FTFvnz5uGLIyAEXo1y5xAe+EAXGUtg11f2j8?=
 =?us-ascii?Q?RlHm0x20XID/lv4x3iO7H6Vc/a2uzJ0JhvyiZDXW3youKyUSwiOBcIO+gmq5?=
 =?us-ascii?Q?xGCZzEHZwYamrRY2tDNyK2XhVGUBB9YAsT3m0WE3OKQYYEiqWVug/AQNezzS?=
 =?us-ascii?Q?6UnJ58BjHplpYBYQRddXvk3TJ2lUIGpzW+GQ9dimSTHvyaNURjHPQrPI6zVM?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87730e06-4862-47bf-2ab4-08db054ee9c8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 18:54:29.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfuAQzSgRmyI7JMbrLFmmcMzPLWEBv0MFAAT6+KvFXUt5VNN+NBiQPQNYlnPfkRLWq2lkL4SHBSgZKt5yQKfBloPDdN/zWDD0OaODMDRWvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5053
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 02, 2023 at 06:13:57PM +0000, Jonathan Cameron wrote:
> On Wed, 1 Feb 2023 17:05:51 -0500
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > The reality is that CXL is not MMIO and not RAM or ROM or any of that
> > and is intended (eventually) to even be shared between QEMU instances.
> 
> Indeed it's an oddity - but this is all smoke and mirrors anyway
> as far as the OS is concerned. The OS / firmware doesn't need to know
> anything about how we are modeling things in QEMU - we need to make
> QEMU functionally correct.
> 
> > 
> > That means it's likely going to require its own MemoryRegion model and
> > some deep dark corners of TCG and friends are going to require some
> > updates to make that work.
> > 
> > Some speculation here:
> > 
> > The crux of the issue, as i understand it, is the invalidation path.
> > MMIO doesn't traditionally have a mechanism to tell the caches "hey
> > i got updated, boot this cache line", so whenever your compiler accesses
> > MMIO it - at best - does a fetch-and-discard, meaning that instruction
> > translations can never be cached.  That's the source of the slow down on
> > the QEMU side, you're constantly re-compiling the translations.
> 
> If we actually care, I think we could do some tricks with creating
> a cache of pages in between the interleaved underlying element and TCG
> so that it could behave as if it were dealing with a normal page when
> executing, but when writing it would drop such a cache so the writes
> reach the interleave elements. I don't think we do care for now though.
> 
> Slow down on TCG is fine (if possibly rather painful). We just need to
> work around the currently broken corner.
> 

at that point you're just wrapping a memory region inside what amounts
to another memory region.  Might as well just make the full blown fork
of region into an explicit CXL memory region with caches that can be
invalidated.  That model's the hardware anyway (though you don't have to
go as crazy as simulating the full snoop protocol).

~Gregory
