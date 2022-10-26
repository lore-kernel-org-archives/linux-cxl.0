Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6724BC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 20:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiJZUrd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiJZUrc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 16:47:32 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6237CE24
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czaa8ITIrcNZZZPZE0Vze5RFGy3N0ljXSIMt29bBs6n5gQSJrk2SgQyBoD0VXakGNVKtIO9a/zcpZaNCou9fpFTP8vyvka/at+uSbKRQOuh9hY6VWAuXTHPh6ogLl+Ri0cVLzgrAm8EHDEQ3qGGzgK7nFWjX9W7Y7MYQK2aXI6fSsjvp1NX8SKuV6Wr3kubcPrP8WioTsY/TMZPFjulvC053ek8WWxakPyJndagQgRmK/iOzXfl/cfgzr5oF9FLhXYBfRB2df5xg2+dRlvJZs/AOW144kcTmWEbdHUg4U1Aq1F/BxMf04i6WA5W9AX4XlOSgNJX1E/U0T1Hx5i9O0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Te3zUu7zSE03ufqpR62panhnRwz+AfmQrhoQsCzEXg=;
 b=mtg2FFvsYPgF5xt5x34h/EfMwxSaHpth2HV6l5E8vJEle/jS6krms5Lux1wr8ZlymMu5wwEQqn/Dtp3PFM52hwT6UCALtbfSH3QtIKTg3LAjkrcGQUbMU4pMsQVA26l4gYZ2xrgpn3KQs/La5El9ThTCsB8nxC8HBMn45IPRJdf6AcpyXBGm8xw7LjhNXY4kwC8Kmtua2p7GrO20TOMHoCzuVStKJ7jAgq0uGdDhzudImsI9OKGKO9P40/NmkpA44wW9t7h2nIO5CEVjegchjyHOPRkitX8JXds+Eyx1+3D0Y3sQi3pvQHUQlK5FC8XYcDO7Y9cNTA9Gi/TTr+XXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Te3zUu7zSE03ufqpR62panhnRwz+AfmQrhoQsCzEXg=;
 b=np6f/e1/YTQhkeNt3hRsga2CG/Fjgr9HlaErspnWkzbvRq1CnMa2qVvbg4d8jniX+JP31jPCWA/XR3gXT7WeU6q5Z6Q0nfy2BNI2kOmi/oiRD4FHJxgtxpC/FF4aeA7/B2AFbgedERqiDsM3ghjazcIsLF1a/7l8oOCX1DL1F3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB4478.namprd17.prod.outlook.com (2603:10b6:a03:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 20:47:28 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 20:47:28 +0000
Date:   Wed, 26 Oct 2022 16:47:18 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "ani@anisinha.ca" <ani@anisinha.ca>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for CXL
 Type-3 Devices
Message-ID: <Y1mc1mvxsGS+7JBp@memverge.com>
References: <CGME20221026004835uscas1p1d37255ba8daaba8fc7e16e5129cb94b5@uscas1p1.samsung.com>
 <20221026004737.3646-1-gregory.price@memverge.com>
 <20221026201318.GA308524@bgt-140510-bm01>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026201318.GA308524@bgt-140510-bm01>
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: ff63e770-13f2-4f08-03ad-08dab7934b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2ofOPN0k4EB4fPh+OBxgEajA0NyCbxWRJEJpNGiPHWcQFa+KnFwhWkMhYgMbOny3XyTZJ+TfYvI9wK02g3Zp2Cbp4LSFK9Vwn0VVGOiprkRWQSn2gxU/tDqHw4OWFcTcuVDyo6C7gedRDB54eClV1YojyYH6TPAIwLZkhryV6TmBfvOpa93kx/iQqSTjCusIu0frT1n1PMWhcGQC2Lj0do7lvx1oMydbCAXE6y3kM1xJCitwncJq3mggtnORLP9SniDS+HV3uxBZpuhM+usrvo6WmbFaVc1cN3vbzu2V3XdH+bYDMVU54NlkvB68n2oW8n5rqHdGw7eO6FBrihMgBJ5xKg7w4KMf5x5BTWJ0tKc+1eGxor5lOhPhXAc0DTpH6xeDtnpI1nPfeqlGZHIku+Q4cy38vc2+5z78aUmZgetuGXtc6ALHCyt4MLsd1WjcSikIF6vPm2hC4krfVQdDp90k5yMKsmGQSHCoVSW16vrgTA3/tFi/NWfVcr2Z+Swxj46MKEx9BwrmOutK62eKB18fR94lcyJzpqq89R13TbWbwRXu1GKEpjN1sPpCJ5hQEAcYdHeQxpqq4W07OX4+In2ka3iW4dKLzNWSszwjNgw2AfN3VOWCbq3HGU6Ki+QdqKhO/X5f0pg0nQX0HpVXEfWESDeDif+AeCPM9zont9yW5WJPU5PrNHSmhzCW9sAetQgDMnPG37nFV8KmzFp5AvCcun8q/Fs7oyefMGnNdd4DiWJEo99p8MISF482ZNAAohMjCDA8GZuw2fkNI7yzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39840400004)(376002)(396003)(136003)(366004)(451199015)(86362001)(8936002)(83380400001)(66476007)(38100700002)(66946007)(7416002)(66556008)(5660300002)(41300700001)(44832011)(4326008)(2906002)(8676002)(6506007)(6666004)(2616005)(6512007)(186003)(26005)(6486002)(54906003)(6916009)(478600001)(966005)(316002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yONrlwCuGnZ0lnDgciFjdpjh3dZR0+k0LUbPD31hiatUkvwWVtpwbh0y+eTR?=
 =?us-ascii?Q?9ettuNSjiqxD/WfQs9yLOXKo4MItK86xWQOIOJrqPwjV6/HxGk+TRyj6FaCe?=
 =?us-ascii?Q?tlhoJ66dZ/n/ShIDch0lLdslixwz1Orwl03CIWTGn18kX3KsIwS9NAIr52o9?=
 =?us-ascii?Q?3MvPUlkIUDmo6wo1b4U4BQN0sDtpX2nhMpfusGmNRdFjw4Mt8WxDt6UqHDg6?=
 =?us-ascii?Q?ooxJcdG+YXZZOqx5tgp2AD3dnhnOS9vmc3ohvrUmSCYOKcBN/BGUmeuKWoVe?=
 =?us-ascii?Q?rUBHZq+I+VSAYJ9x5m6IPfD6xmY9waWOnwQBwvRB2Q421LsSu8vXCx1HHddk?=
 =?us-ascii?Q?s6Y8NV0Y0DquRzu5ySD0yrYd2/j1870B3IrK4++yErH+kNYjaUW7tnLCimsO?=
 =?us-ascii?Q?C5T7lmugYiKlErybsG86KqzGWsghOi5F0aspkaNUacN1Utj0/hVSuQI/Vqlv?=
 =?us-ascii?Q?AntUiwHgN6LNntIH4TxnaeS5615zybqswdmfWrTD9/TqKDUf9hhA1oQuZ/pi?=
 =?us-ascii?Q?apfFcyCIs7HRHyVSSfd639zt/iKX6oQioTt5GzjWArFJJhohWyKF9bI9TRHE?=
 =?us-ascii?Q?KlQNWrT1oJqXpSFloez2X54lh3polHeEHf0SzuozWH6yJHTPLO7yfdKs0+dK?=
 =?us-ascii?Q?j5d6GeszcSKv+oc5vK6hcqorFxHHr4J/YC9UkUmtgsuULbrpPPqvj7JE75th?=
 =?us-ascii?Q?LeFDaN7yKLb1/ON5qYOEuskXknRk7LJrwpfcGssbOujqLmuwNASbybZ78TRa?=
 =?us-ascii?Q?3oIoBQWvc0FyZzawM6vRkoQkZ8CVNcY9kfZAqyXiq5up2TvN5fWWilUYB0PW?=
 =?us-ascii?Q?/W7OWyRnpebgS92rNBT+j71w6jPdE166q85UVOXbtDR1ThhJ2RNXG+zbG4e/?=
 =?us-ascii?Q?1TnmXbBnsNp8/rBiZ0m4O2NXuZ/XrXeZ0GvMmhD8B90Ma7804dvTeqM2JmVy?=
 =?us-ascii?Q?qOdaNA6AK7m3B9vafugOWhjhEveuXiS566vdc6NpUim0A6cVSVPggnMjSTXi?=
 =?us-ascii?Q?4Df+AFbyp3NUTM80e4RnGUxw6cSKVdeXPWw52l7JBr2f66fc+uN91Rz1QafX?=
 =?us-ascii?Q?QH/qbN1opJG3a9LSuJdX1V+4Uudt1DP9grc/4sRfd6P93JDJZCvwlFCpQK5s?=
 =?us-ascii?Q?zcmvREvQ2kcZjwHk2eiwOUknm7Gt1jREmibuxpWOE96tpnqQWP7BHXmtDY6n?=
 =?us-ascii?Q?l3sE91zsJ4rnPBJmaofmF2LoPZuMplxPvXWeIjc2kIBaiQWz++x78E2KOAcO?=
 =?us-ascii?Q?uaKLSb2gg/si4HEVPdA/jtWgn3I0kG5Zp2eKTTP9YlAovXE2l+QvxvWh6CBw?=
 =?us-ascii?Q?QJXlL9igLuqYMd51lvkHBz/cNedymwNUxtXj+99rISsNNAeVoNMyp2Kx3soy?=
 =?us-ascii?Q?AOA+ohUMl+hS2Httgh3nB0Ydybb3l9ALXnXoO1m4rlgogFFxUup+UAVOM90P?=
 =?us-ascii?Q?51cPTQhaxPocN+iV/Bu2oixnXkT3sqIZkdXNjWYfmxUqVlCj9nzoMJ4ZT/3/?=
 =?us-ascii?Q?gzh/TzbJ2XQCFG8smXzOQ0HrrWLXTvFObi2HVLNa+qUjF+iAN5UzVwesxD0s?=
 =?us-ascii?Q?qPD0LB0O+MDRJFoZJoidGEjaz3v+rLXE6/f5nrXtumQqjqtEPeVvxqXkzZyB?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff63e770-13f2-4f08-03ad-08dab7934b69
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 20:47:28.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7T+TwIfRHD5T+K7WogCQ6oOCj3tHDzKA5ic208e8wtBp/9KNQw1SYpsJuq2eea0P9C97iOaYXBulECeNhZ5EI7LOkQRd19eplbx/1nXzer0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4478
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Oct 26, 2022 at 08:13:24PM +0000, Adam Manzanares wrote:
> On Tue, Oct 25, 2022 at 08:47:33PM -0400, Gregory Price wrote:
> > Submitted as an extention to the multi-feature branch maintained
> > by Jonathan Cameron at:
> > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-2022-10-24__;!!EwVzqGoTKBqv-0DWAJBm!RyiGL5B1XmQnVFwgxikKJeosPMKtoO1cTr61gIq8fwqfju8l4cbGZGwAEkKXIJB-Dbkfi_LNN2rGCbzMISz65cTxpAxI9pQ$   
> > 
> > 
> > Summary of Changes:
> > 1) E820 CFMW Bug fix.  
> > 2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
> > 3) Multi-Region and Volatile Memory support for CXL Type-3 Devices
> > 4) CXL Type-3 SRAT Generation when NUMA node is attached to memdev
> > 
> > 
> > Regarding the E820 fix
> >   * This bugfix is required for memory regions to work on x86
> >   * input from Dan Williams and others suggest that E820 entry for
> >     the CFMW should not exist, as it is expected to be dynamically
> >     assigned at runtime.  If this entry exists, it instead blocks
> >     region creation by nature of the memory region being marked as
> >     reserved.
> 
> For CXL 2.0 it is my understanding that volatile capacity present at boot will
> be advertised by the firmware. In the absence of EFI I would assume this would
> be provided in the e820 map. 

The issue in this case is very explicitly that a double-mapping occurs
for the same region.  An E820 mapping for RESERVED is set *and* the
region driver allocates a CXL CFMW mapping.  As a result the region
drive straight up fails to allocate regions.

So in either case - at least from my view - the entry added as RESERVED
is just wrong.

This is separate from type-3 device SRAT entries and default mappings
for volatile regions.  For this situation, if you explicitly assign the
memdev backing a type-3 device to a numa node, then an SRAT area is
generated and an explicit e820 entry is generated and marked usable -
though I think there are likely issues with this kind of
double-referencing.

> 
> Is the region driver meant to cover volatile capacity present at boot? I was
> under the impression that it would be used for hot added volatile memory. It
> would be good to cover all of these assumptions for the e820 fix.

This region appears to cover hotplug memory behind the CFMW.  The
problem is that this e820 RESERVED mapping blocks the CFMW region from
being used at all.

Without this, you can't use a type-3 persistent region, even with
support, let alone a volatile region.  In attempting to use a persistent
region as volatile via ndctl and friends, I'm seeing further issues (it
cannot be assigned to a numa node successfully), but that's a separate
issue.

> 
> Lastly it is my understanding that the region driver does not have support for
> volatile memory. It would be great to add that functionality if we make this
> change in QEMU.
> 

Right now this is true, but it seems a bit of a chicken/egg scenario.
Nothing to test against vs no support.  Nudging this along such that we
can at least report an (unusable) hot-add volatile memory region would
provide someone working with the region driver something to poke and
prod at.

> > Regarding SRAT Generation for Type-3 Devices
> >   * Co-Developed by Davidlohr Bueso.  Built from his base patch and
> >     extended to work with both volatile and persistent regions.
> >   * This can be used to demonstrate static type-3 device mapping and
> >     testing numa-access to type-3 device memory regions.

Regarding "volatile memory present at boot" - there is still two ways
for that memory to be onlined: Statically (entered as an explicit e820
region after reading the SRAT), or Dynamically (hot-add by the region
driver).

This patch would at least allow an SRAT to be generated if you
explicitly add a NUMA node mapping to it.  Although I concede that I'm
not entirely sure what is "correct" here.

What this ends up looking like is mapping a memdev to both a numa node
and to a type-3 device.  Though that seems wrong.

After further testing it seems like creating a CPU-less, Memory-less
NUMA node with the intent of mapping volatile memory regions to it is
not supported (yet?).
