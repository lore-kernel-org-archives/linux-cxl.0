Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2167C636D6
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 19:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBQTh2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 14:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBQTh1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 14:37:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761734496
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 11:37:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyk5CfL5Av7j8DfE5LtlQYmZT3QaHN+Hz13PRhu064mHG/tVU8NwazeAg7h0yYIQGqjR9j4R3B6wuya9LZ0NZH4h7zmCkdIsTrsyW6FneMQ5HKISSTwzHzwQ1I9qB595rS1EdVV+VGV2iMXP0/yFcT7zMNdTIUsQLMpsZyy6JR0+0kNbfwH2/L6OoA0T+WTBd4m+tp4Yeynww1kiQfPoYggjdHLWG+4EuoX1TCYdjwDO0c+GgUmH3aC72+V7a0CMFwzr/PfJa+pv+5hZxssfuOosNTDXwKUd/Yjbq5KUYkSv/iWevohYD1QXx2GrXfMP6rscfJxJxQoOX7h7nqjn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq7CUWXPy6P/+XtewQR4n0C4cngfBANI2dYsnKnJj0s=;
 b=jBwSiFzK42ySsmsLCP1AwssmeHzek32syhN8iQVxkaUqCMXgy5is01e30YcEPK2BHPvyCPciTPqTTHyFdjrhyX6wcYZoay5Ilf5SFPXSt8NUEmGmo6QH84VmHVbKICWIoJ9v14b+TLgWUzAo/WuHgs2GGtmwad97niWcWBtUwhkg9KRwNeis2gz/taHy0Mc6IM7ewQmHWFq+ICWk0qIQBt1kdkqAk+LYSBUTZM6ewfnyNphO2lmaajVapJuK0r7vWcNn7/MqlBAVh4dKuJ2VjVsjACYxn6LTezZQO1vzh3Pa3SbshQQa6fnvF1cVh7owIiAXXtG86QONLKSXmii1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq7CUWXPy6P/+XtewQR4n0C4cngfBANI2dYsnKnJj0s=;
 b=uDTVDmFsZkONbzpu/E/T+N0R/sioT0X+6OveVH9kCz69ld/l6mQ9qVhP1rx13z9/SklrfxiLkIHSNxHGhoOvhdd9+ljiQNAsDNdi0HLL7WX7X2IWSgS6KXaYERF04bqNTp6BtE134BK/jQhIMymjjI6CLng3ypEqodMv19U+nWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CY8PR17MB6211.namprd17.prod.outlook.com (2603:10b6:930:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 19:37:23 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 19:37:23 +0000
Date:   Fri, 17 Feb 2023 06:08:57 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <Y+9gSWadbRfdqJGS@memverge.com>
References: <20230131163847.23025-1-Jonathan.Cameron@huawei.com>
 <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
 <20230217161617.000064d1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217161617.000064d1@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CY8PR17MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dee29d-bab6-4b7f-cd2a-08db111e6421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcXMVtT429jfZsbdLqvZaFtACvm7HRdiHyd3h+D00gYeiI0XLZJPsUsfa8bEEkF1+w5uRHS5+5fPEQqz0ipBtq7Nzgkobib3XDaSXE9uJ9C/tMQTAPlXK20EmBTO62cJ7/qoTLYBNCGOdgUyvI2m+hFU/tgwxezoxnVNeuTR7AqZ4Oxwky6CxeC0iIX9qKdrWG9eA4dQjIXb5awZTweofSmI6kyOrUdqufN0G1pbZBDdn/EMn8G+ZvVlbkROqSXPcne9amC0qkDHw2AD2ECcE0VIJaBl/qRw4VTzMur0KJgbHSF54evsZVM8yqQ/ps1RjStUNoVfu6QpxDwPDUt25DXySEM2VywUTGvpBUZfHr+jKuq/LHyHBfJDEIOZAxnCgOsMCgL9eBsouG86mD7JhnqXHq2AnRQFcwqej0w2BdS7jzTFkybUrPfP72OZf5YxKAbuhgLRh5bpIwKlpflK1K/lwN4xf2L0aT5LPewu0Sxw3MDUt/dWac2aTa8qYiyNvzndrtyB0oX0a4de2v3NxHjic8CtizpHY73GAwrAIiauxUwA6bu9luiOs5qr8BNPFEWZ1CTrSVRhfyyMkTKGAJ2cjVKDlelU5w+dG/3iIoKaWWSkm+FqGI/3nceJR4sux0/Vzi/fh3klCI7yxI2/NfM0BAoPmPdrh4K+hWwFH1DM85Ryyij8uQcTpUUungoj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(396003)(346002)(136003)(366004)(376002)(451199018)(83380400001)(38100700002)(86362001)(36756003)(8936002)(5660300002)(44832011)(2906002)(7416002)(6512007)(6506007)(186003)(6666004)(2616005)(26005)(316002)(8676002)(66476007)(4326008)(6916009)(66556008)(66946007)(6486002)(54906003)(478600001)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PR2YnZkGMxZnuVs7IKAsRpFZt1jXk75NHcHB6aBeolOaEhijFUx51W/JC2e7?=
 =?us-ascii?Q?DFON/aVy0uTew8Sd/gVFD1PhjVKQCy1FfN+xC+wLpXIwWWPa42FeftAmYVq1?=
 =?us-ascii?Q?OoBQBSrIUSgymj3uYCoMYODyagm1I/6DVQBYH0S2sv1+MimVYf79OwCbHMhV?=
 =?us-ascii?Q?/nTvmonrD3jSWIbZ8bo01dEOAVEej+8NMDkWRWsForBfeMnOXIn5Xy01OFeT?=
 =?us-ascii?Q?C4s1HIK+37sYlUiG7Mz88DEeuxxkEyGvY4DRDKvq03UC/OOXRWzkv0a7XpBp?=
 =?us-ascii?Q?QaV0gfddq06TP1clN7MB/leniiKccpR2Bkg0DJMoiVn9WHw23grgDCRci8Cu?=
 =?us-ascii?Q?A5w8FFnIgBjSmI05ClDtswQCIHRg5K2ELGzkDgTQburet5XctARaY8B/7Qbi?=
 =?us-ascii?Q?+RJYAkS/WcfH9+ZopLJWVN3Kz6xHI/KnVfRy/f/vt3XiVH4eVYUNFfChn3QZ?=
 =?us-ascii?Q?ywX9/tbA7w9HDBE87dEIje66KWQdm8YmyWltg1xBvNaWliW/G9p/ZW/BUd8q?=
 =?us-ascii?Q?N+pQ4RVUvf2Qlh7v1OP9wGB3x/bzP43CHeGoviUqCBIN8BpD+7yRxPUCIBtN?=
 =?us-ascii?Q?mZ852p3wmOyon+Hd1jCdf5sN2zUjXKiO8spnMZEXF1QjA1b6JtMNMYn5m6xx?=
 =?us-ascii?Q?pbt7GTWL+Nl8Nj7Sn9HxStaYrQlN8krJiqQboCye4kBCE5lcF6scB6Qdy/Sp?=
 =?us-ascii?Q?sFXIIjJ8IudM+vDE2Df837WPo/O3gyKy0w2VE0Tw8t4PEO2+r6sQrUe1cy0j?=
 =?us-ascii?Q?7eMsiKOw6SnF1vSjMqztXNhMEenU8Y5wEfNRaG4j6SjtzioLEbDCNSDyxM74?=
 =?us-ascii?Q?EXXRI13I9QDNoYmZ7Zs+hvNoOFlduTpdHeXsWuZRsysWzmJrlpZY6e46pGxV?=
 =?us-ascii?Q?iYryvmUG8Jf/0SrwANcWNuB4Jal8k0HW/Io2990up7h4s8Wdbj1CXonagWjB?=
 =?us-ascii?Q?ElyXMWijWysFRxCMuqe29tOw9A2k+lErlrmM7eqzzFo2yCdLrv0+FR4PqKai?=
 =?us-ascii?Q?tFy/PzVamfQtQ14bxgMKmeiR+9ivAlvjiyFJt6tqXmDZbGp0PBpfgfXPuTK/?=
 =?us-ascii?Q?FoQRfFlJEf9AxuUjKgO8bgVHLbGKr7mBVsEjkAZf8fLwXVsfBYG4uJBFgzmY?=
 =?us-ascii?Q?sGbf3D8k0ZfXRWAjScvqEoXA/+0caIBs1Jn4dOTfcqmxN9HiIu8xHyR5wsj/?=
 =?us-ascii?Q?vrJxbXPq8Y2qB/+rQCRjcIqjFumksfu7ymLUpOzYr/aJPbAOdn9PB9sVfUHS?=
 =?us-ascii?Q?2HR+C4V6w1WPMQsI0wAe9naFHowkvE7nNrsqHZLx7CL5l3Cwrq+A/P856i0J?=
 =?us-ascii?Q?2Ijs0GUp+Z4xHA7jyVr1XLhwVou/r6TC8rjMjR2FUBSBArpzo9WYr9LzCl2H?=
 =?us-ascii?Q?Az7VqH1Rr94QWaYJzDFfNv5wlB16CU/i8Z5/C6lkvplB4gD/DF22kUE7+zFP?=
 =?us-ascii?Q?ROwmt0BQyFLf54TGG+1TU4zuXh62CRc6sqeKI76R835gW6mYFB759Qo9iH9x?=
 =?us-ascii?Q?1nhHT2r6vMYpe0UroRWTXBYUaxwy3+iy6V1nDIB4eEfW+BQedatuhB7125IE?=
 =?us-ascii?Q?DZL/75+PcTurfGAO76haLWTZ01564krC4C5ggfPF5HrzZ4Q3ah5HXAE0I5sk?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dee29d-bab6-4b7f-cd2a-08db111e6421
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 19:37:23.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwIHdb83ny2I7fbdrBzBctcuYLssyJ4i7RBhZWin0p8ibNYSgDJIcpQ1fen5yRC0W5t1C52uiDZa74ulw3Izmbd+OkZY7VHWY/3+m1sY35Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR17MB6211
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Feb 17, 2023 at 04:16:17PM +0000, Jonathan Cameron via wrote:
> On Tue, 31 Jan 2023 16:38:47 +0000
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
> > From: Gregory Price <gourry.memverge@gmail.com>
> > 
> > This commit enables each CXL Type-3 device to contain one volatile
> > memory region and one persistent region.
> > 
> > Two new properties have been added to cxl-type3 device initialization:
> >     [volatile-memdev] and [persistent-memdev]
> > 
> > The existing [memdev] property has been deprecated and will default the
> > memory region to a persistent memory region (although a user may assign
> > the region to a ram or file backed region). It cannot be used in
> > combination with the new [persistent-memdev] property.
> > 
> > Partitioning volatile memory from persistent memory is not yet supported.
> > 
> > Volatile memory is mapped at DPA(0x0), while Persistent memory is mapped
> > at DPA(vmem->size), per CXL Spec 8.2.9.8.2.0 - Get Partition Info.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> Hi Gregory,
> 
> I've added support for multiple HDM decoders and hence can now
> test both volatile and non volatile on same device.
> It very nearly all works. With one exception which is I couldn't
> poke the first byte of the non volatile region.
> 
> I think we have an off by one in a single check.
> 
> Interestingly it makes no difference when creating an FS on top
> (which was my standard test) so I only noticed when poking memory
> addresses directly to sanity check the HDM decoder setup.
> 
> I'll roll a v2 if no one shouts out that I'm wrong.
> 
> Note that adding multiple HDM decoders massively increases
> the number of test cases over what we had before to poke all the
> corners so I may well be missing stuff.  Hopefully can send an RFC
> of that support out next week.
> 
> Jonathan
> 

Very cool! Thanks for pushing this over the finishing line.

All my testing so far has been really smooth since getting the TCG issue
worked out.

> > -MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> > -                           unsigned size, MemTxAttrs attrs)
[...]
> > +    if (vmr) {
> > +        if (*dpa_offset <= int128_get64(vmr->size)) {
> 
> Off by one I think.  < 
> 

Yes that makes sense, should be <.  Derp derp.

Though I think this may alludes to more off-by-one issues?  This says

if (dpa_offset < vmr->size)

but dpa_offset should be (hpa - memory_region_base),

The HPA is used by memory access routing for the whole system to determine
what device it should access.

If that corner case is being hit, doesn't it imply the higher level code
is also susceptible to this, and is routing accesses to the wrong device?

~Gregory
