Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C87CC001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 16:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjHDQmB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHDQlm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 12:41:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79402B2
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 09:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtf1p+6/Z5xANPCpsLe72JCubfVNkRTqxAb7Lvpt0hFQQ8wNXO8Nyhm63iJSR1t9axgl6cxFT5n9kCzOp/sNB7j4cjkoMnKt0dIAJ33nvw1vAp+2FIEQ4DzhgvBPJta11SEs6QW3NWEZTZIeAXzN027QRT6J88kPL1Z/oPimtJzXrdkX6c9pbub0qt4fC+82v5Hx6ffoUh/y+vvO1cQenaEi2c4rQidxDZ62a956DfXFQjYiOuQUBAI1ritDZfOc6o/xd9CVkQfNrkWgvuCtLw2evPDtirBHXS3AMqSBKpU2jfGsXehGNrUkJPCXu7UzUtDvWTMjWRRNUXl2yB+qwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKqOWo/deKUHHtKe+tveTaWLRJoX2tc/N10v6a1x2R0=;
 b=S86iZsaA6MnR2m9ceidaIddOEDHnG2ROstY1Pygj/9AaUQ5+Cu5Z28Kn1xlwGG3CXIfegzwCnHX2/gnsr7WJxSEOyInRN4D9EXMm94EOknOWRiJa11/BWhPpqzOzyidDipRZio5KclW5o2HC14KrcNKdw8iUdmZci4rnQE1KovjOsBvngn1J80IGu/mAPQSaxi3MGoR8GGijjzz9XcEqCa/q6OCugmsG4IKIzkcUJhmnznWrpp6bG1quFtt54UKxQZq+O8bOcNFL3wKPnZBPTxvmcoWdDBKD6kbeHfWJJbA8oDfKaJ2cRH7ztpiNPyCT4bLL1iSHPyUeMtcJPKJEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKqOWo/deKUHHtKe+tveTaWLRJoX2tc/N10v6a1x2R0=;
 b=I42JmKLqrfend91+whLxwjfxsA8Nswz/SPOlrEDCaEE1R1aNj1sqpM37RTQdJdrfXY5EWhB0Xy4BuEfK3lVdNUKeBXI4HWUT36fE5mISHrHeo4xcn0rJ0zKoVdTa2xMfMJU6XE3KYFp6N7z+b0p5+aPZNUXE3kgvlsp9UGrauvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB6532.namprd17.prod.outlook.com (2603:10b6:510:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 16:41:36 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::28b3:ad85:6a11:3872]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::28b3:ad85:6a11:3872%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 16:41:35 +0000
Date:   Fri, 4 Aug 2023 12:41:26 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, junhee.ryu@sk.com, kwangjin.ko@sk.com
Subject: Re: [PATCH 2/4] cxl/mailbox: interface to add CCI commands to an
 existing CCI
Message-ID: <ZM0qNhbVxsSEs7nQ@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
 <20230721163505.1910-3-gregory.price@memverge.com>
 <20230804161414.00006eaa@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804161414.00006eaa@huawei.com>
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 7594983a-d35f-4687-dc59-08db9509a99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rktlwGLFmdl3VCYqTAoBZ4RMLqXa5ydYVnIlu1kQTkaUSbuuF/KY/GjESuqOGT8iPlikJ25DSd2AbM2LrMp1QzJaEwONVdHOle4N50pYC8NEjddcvHVvBOtX0RP61q5V93gI5p/lZKN5cNmQHKKb0vsaK7/kXOqc5mQHMAA9zFngfnbytzbKRfGSGCrNT8EvJwhbPYBXqAtAMPNJSHweVdiPmWcvQxj0QAxgdX3CxpDTn9zZMNarOjugd9Es9Mlse6Vi4aSjbifcXlC8U+Oop/boeV5ET/LE65cvSjOe9v94bEAhi9eQ2GfbCS72nY+TnMPIiosGkUCtrvGJ9XBhhcR3Mk+bZLwpOqKebFQ/R8AYwIW3+Dz1CiDd98O3gNJ6Cs75UT6/S/0IXkYORkBXUB4gipZXrr5v5JPMHRbii3+aaj+ohUnnAINc3Vq8fmjCMDbzy9dwvsnaEzBcT8R/lUlsEyKAfZJqujQSCIATkc/x/2zL57cJI4XRWyY3pQvqjyPxr/Flcakpr+GBsUn3vfF8ICkfUusKOEqMk/Ohxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39830400003)(346002)(136003)(1800799003)(186006)(451199021)(8936002)(2616005)(8676002)(26005)(83380400001)(6506007)(53546011)(4326008)(66556008)(2906002)(66946007)(6916009)(5660300002)(66476007)(316002)(44832011)(15650500001)(6486002)(6666004)(966005)(6512007)(478600001)(38100700002)(36756003)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZGV8MEIueTJ83g+4kBCWTodmiibQUAd1jHxOrdoS5o1VpGOkTKp1xHAADwx?=
 =?us-ascii?Q?UAHWKl3CZlEG2NZ9D2saLEGzE6m3GHtE/3H1WW4E/0tbBppQHYl2ZyG+YU0A?=
 =?us-ascii?Q?7MAyEPGx74luNBkmDWmi2mDAkUZ8OO0XmAm5uFqPAUiZOLIjZolCjKxPPUjj?=
 =?us-ascii?Q?myYvcQw6E8RzYJXg79BLptAtmp6nTFuASMdoM+LEKcbu/+E6z/4mRxc9TnJ6?=
 =?us-ascii?Q?Wh26vl7K80stAvEuF749Lv0dzi9nXitqUspzZhV78zIigWLRR7obFvrrXVM/?=
 =?us-ascii?Q?KwEI+I65yHkznBhSL1K/UZSaggMVq9eWHh8mhsR66t2prZ8T8eO6fEQre3Aq?=
 =?us-ascii?Q?kam8kVsmL1MesKpePvrZ7zK+KYtC/STtlZ8nTVCW9RBj9ISjLR5NifafOK+C?=
 =?us-ascii?Q?2Sm2q7IdzRVguSi/Q6KKAgqHM0UoH8B2aBHzMzau6Iw4BzQisiOBwHgEAJC2?=
 =?us-ascii?Q?UUqk4oeoosvxBEf3xeQOTKTRtyHHwbo7rj5cum/zRzkq/CfVj5ngkqx3GwO1?=
 =?us-ascii?Q?h7IjKAHri9IjZSKlSxLd8Qgs0wQRZWYjXFdqcDcEuRdEljIErRFe9t1AS5N4?=
 =?us-ascii?Q?FCKDsO2GmKifqiYQU5taoOAeuZA+TL9FrCBYskY/6NVy3js13wl8id8qP3+T?=
 =?us-ascii?Q?F1ERTYml+NToAtvdBivemRsotAXUmFsqC+QPxpAejXFCfc5nW81h6v7tQDKP?=
 =?us-ascii?Q?xZokhypCET4jGC0dpzzrdBJY8FrkSvRocShateCkTiKBx4UifBc3TUCU+5MM?=
 =?us-ascii?Q?YWoqJza/xMAFVP1LC8bR3Dsx1fXqkIIWGuubNUTFiB+4mMHKPNgoA1JlGoO4?=
 =?us-ascii?Q?9uZLUX0T8AiI/I0dYUPK0bBE2DZhuE0lbygr0ZrWdM05odBLepC7X2avHuqc?=
 =?us-ascii?Q?jkcW5rDI6UQyEWL5HQcjBPdmUZqcPNHsfY0bFsoQVJk0Aul42Y287i2ur04x?=
 =?us-ascii?Q?uphfp2jH1QLQBI0mX3FrHWQWHJc96X7dZ2hvFGdGQqLus31JSEhJTUZgRg8b?=
 =?us-ascii?Q?47YNxx0TZIeFobeBWNpsm3ZDjvmLP1GgKFu9JD1ep+ikSLh0G9M9vPXpD3k0?=
 =?us-ascii?Q?wAAfSEcPOPuRHQhSe4Zc9rewIOSO+Sn/EnVDvResd3GmvQOP1+kgG0XJKI7j?=
 =?us-ascii?Q?gxXGCMDEkk0r503nhrTnGkBzn10uix9i/5C9yc72WIrrz+xHIW+X2Hjjgg9V?=
 =?us-ascii?Q?gQ8LTVwwjI4e3iX1u8Nqb1JhxBbl0/emilLLXLbC9lZYc1yW3wgKe0OTobGR?=
 =?us-ascii?Q?eiwOaXFBFSBjL3oSObHsignZPGs+x/xQWPtcGkorJt2L9WduhmVxKC9uShQX?=
 =?us-ascii?Q?b0MpIDvvLzDdVK6a1OIo4Z8HpnQnPRFrMazFbHchxHJnZfaycUJ8gSVvqM5s?=
 =?us-ascii?Q?tZukuVU6P1Z0bCFLxoH84xKNPjGaF7zFFaLGuPwTmzyNROVLcyj1y5wlslUK?=
 =?us-ascii?Q?4csAtg/yorESwvFm9gUfq6WA/lq5ZBg5ci0r4msOQJUZjzAG5aHkFE/pPXDE?=
 =?us-ascii?Q?+BbvWz1hTK6ckPQc6sdm6GRAnBUXD0czYbsYdwYczmd9Ym9f7xy3bCqV15KX?=
 =?us-ascii?Q?JGXEJAg35W/28sN0HfJYA2xHu2Xs6LHb1OjF7sjaR9HyiqGVvu8irmgZuCKq?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7594983a-d35f-4687-dc59-08db9509a99d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:41:35.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13VJcCDcttuQm9jJxfyw7KucNXuiKSOfKwi7zrGxhlE8oValv/5xTZUjbZqHozeD0AvtcWjSwxoGh4MPhJZwiu+RYEKXbOTkxSEvq3gkKwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB6532
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 04, 2023 at 04:14:14PM +0100, Jonathan Cameron wrote:
> On Fri, 21 Jul 2023 12:35:06 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > This enables wrapper devices to customize the base device's CCI
> > (for example, with custom commands outside the specification)
> > without the need to change the base device.
> > 
> > The also enabled the base device to dispatch those commands without
> > requiring additional driver support.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  2 ++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index ddee3f1718..cad0cd0adb 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1383,6 +1383,25 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
> >      }
> >  }
> >  
> > +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256], size_t payload_max)
> > +{
> > +    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;
> > +    for (int set = 0; set < 256; set++) {
> > +        for (int cmd = 0; cmd < 256; cmd++) {
> > +            if (cxl_cmd_set[set][cmd].handler) {
> > +                const struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
> > +                cci->cxl_cmd_set[set][cmd] = *c;
> Don't interleave definitions and code.
> 
> > +                struct cel_log *log =
> > +                    &cci->cel_log[cci->cel_size];
> > +
> > +                log->opcode = (set << 8) | cmd;
> > +                log->effect = c->effect;
> > +                cci->cel_size++;
> 
> So my gut feeling on this is based on the large amount of overlapping code.  I might queue it
> as it stands, but I'd like to see this refactored.
> 
> 1) Single copy routine used in all places that copie in any new entries to cci->cxl_cmd_set[][]
> 2) A single cel_log builder function to be called in normal path and after an update. Just rebuild
> the whole thing rather than trying to append to it I think.
> 
> Something like (so far untested but I'll poke it with Fan's code in a few mins)
> 
> However this is all proving rather costly in space so maybe we need a better
> representation for the sparse nature of cxl comamnds - a job for another day.

I'd certainly considered the issue of space, but it seemed better to
blow up the size in one commit and then come back around and change the
structure out from under the work this unblocks.  What we save in space
we sacrifice in complexity, but the structure seems simple enough that a
change shouldn't take a ton of scrutiny to get right.

One downside of the approach here is what happens when there's an
overlap and custom devices build up over time.  As in - if i steal the
0xFF command group for my custom emulated MHMLD DCD Everything Super Device,
what happens if the spec finally comes around to defining 0xFF as a real
command set?

tl;dr: Should the copy function error on overlap detections?

Quick read-back through the spec, I don't see explicit carve-outs for
reserved command regions for custom sets, might be worth a discussion.

For now it shouldn't be an issue.

> 
> 
> From 8ab48adfb2b481be0702b84a0d172a4f142b0df6 Mon Sep 17 00:00:00 2001
> From: Gregory Price <gourry.memverge@gmail.com>
> Date: Fri, 21 Jul 2023 12:35:06 -0400
> Subject: [PATCH] cxl/mailbox: interface to add CCI commands to an existing CCI
> 
> This enables wrapper devices to customize the base device's CCI
> (for example, with custom commands outside the specification)
> without the need to change the base device.
> 
> The also enabled the base device to dispatch those commands without
> requiring additional driver support.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Link: https://lore.kernel.org/r/20230721163505.1910-3-gregory.price@memverge.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> Heavily edited by Jonathan Cameron to increase code reuse
> ---
>  include/hw/cxl/cxl_device.h |  2 ++
>  hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 0c9254dff9..2a3050fbad 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -297,6 +297,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max);
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> +                          size_t payload_max);
>  int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>                              size_t len_in, uint8_t *pl_in,
>                              size_t *len_out, uint8_t *pl_out,
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 37703f254f..852e5a046b 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1353,9 +1353,9 @@ static void bg_timercb(void *opaque)
>      }
>  }
>  
> -void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> +static void cxl_rebuild_cel(CXLCCI *cci)
>  {
> -    cci->payload_max = payload_max;
> +    cci->cel_size = 0; /* Reset for a fresh build */
>      for (int set = 0; set < 256; set++) {
>          for (int cmd = 0; cmd < 256; cmd++) {
>              if (cci->cxl_cmd_set[set][cmd].handler) {
> @@ -1369,6 +1369,13 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>              }
>          }
>      }
> +}
> +
> +void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> +{
> +    cci->payload_max = payload_max;
> +    cxl_rebuild_cel(cci);
> +
>      cci->bg.complete_pct = 0;
>      cci->bg.starttime = 0;
>      cci->bg.runtime = 0;
> @@ -1387,10 +1394,19 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
>      }
>  }
>  
> +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> +                                 size_t payload_max)
> +{
> +    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;
> +    cxl_copy_cci_commands(cci, cxl_cmd_set);
> +    cxl_rebuild_cel(cci);
> +}
> +
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max)
>  {
>      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
> +    cxl_rebuild_cel(cci);
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> @@ -1399,6 +1415,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>  {
>      cxl_copy_cci_commands(cci, cxl_cmd_set);
> +    cxl_rebuild_cel(cci);
>      cci->d = d;
>  
>      /* No separation for PCI MB as protocol handled in PCI device */
> -- 
> 2.39.2
> 
> 
> 
> > +            }
> > +        }
> > +    }
> > +}
> > +
> >  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d, size_t payload_max)
> >  {
> >      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 9a3c8b2dfa..abc8405cc5 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -297,6 +297,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
> >  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
> >                                    DeviceState *d, size_t payload_max);
> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> > +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> > +                          size_t payload_max);
> >  int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
> >                              size_t len_in, uint8_t *pl_in,
> >                              size_t *len_out, uint8_t *pl_out,
> 
