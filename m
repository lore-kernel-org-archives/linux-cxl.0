Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD558EB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 19:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGTTdr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGTTdr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 15:33:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B12D40
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 12:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9oKcaxHxevaDBU3KmBc1I73KfEsVa9CK5aXUvFiy7rcCFhAfH4e+4D8Vq+E3k44Som4NX8F7sNc21jYoPYWiDI+3AiW2MeYf0XTsgtcp7gRvTgC8JOd2WFzSsmv15ylZFsSeFKLRUnzNeejxfcwHDNEJiUX9/POvhMEJ/DbZKuolCal239I8ZI7cJXm3r2OzFoH7KRG3oP0fC1q22oCfR5kUVaeZyEoMASJGZtu8cwnFJXYgfR2PdojnreT5jTtYRcrKdymLRLKG9JZt4OtkaQp4ZQuGPTPC3hJVQ28pB78iDQPGCQsqOAoZ+q9U9lptqj76kmPKMj0aonvs2ZaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J92AIRQUAGN4j+PfWNN+G4OBYaR3QK9lnxMxuv7rZDk=;
 b=Gsm3JV/mrpgVWywozaYKy/3fJrD5XNcagHXtJdWdw2Gr5DtLuyPsWAQhk5gHIuQZ62k0fACXskkChw6tfcrh2nFFbxxH3SOGP7XH+9VPyOxjVzKFoKwvtciSjh9zE52jxfFk8T0dsFQyW3INC7saOWACB2H4Dx2eIRMrrV70fqQy/FBzNHs9hF3PYALzEZeYM3b5G2P4e3TC8MHLcAV8jW+OTL4S9d/rd0Z4dMj7niAfXi2mMV58bjRsxHkEN/GvQUYWe72TQz3kHn8ThXzUFwLKopYLD5Zu2wT3WvIC6F2pqcBdwbSG7988ClxMILgcsqjtEcQU+8I60NbBOBwJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J92AIRQUAGN4j+PfWNN+G4OBYaR3QK9lnxMxuv7rZDk=;
 b=oEdzvPgmZkzbMKTr4AK5Ja728BZstlp4sye39XU01Dgk+h4isw5qoYj4zTCFd2SHRhJk1deYEQWDhKCjbgi1w4DuXooZKpKPZx0+qTcyin4b6HpqENCjfxJb5DOw9p5nJkLDo3Cj8E7D6PVAUvZbYfyGeYSSOnbEYhioNiZc39M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CY8PR17MB6604.namprd17.prod.outlook.com (2603:10b6:930:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 19:33:38 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::d6a5:10ea:ff7d:9578]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::d6a5:10ea:ff7d:9578%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 19:33:37 +0000
Date:   Thu, 20 Jul 2023 15:33:32 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        qemu-devel@nongnu.org, linuxarm@huawei.com,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [RFC PATCH 10/17] misc/i2c_mctp_cxl: Initial device emulation
Message-ID: <ZLmMDBRoccoJpphM@memverge.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
 <20230717171646.8972-11-Jonathan.Cameron@huawei.com>
 <ZLcEkSLAj5yXVOVc@memverge.com>
 <20230719091947.000043ac@Huawei.com>
 <ZLgwI5N/4RV2kpq1@memverge.com>
 <20230720131833.0000575c@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720131833.0000575c@Huawei.com>
X-ClientProxiedBy: BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CY8PR17MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b2a22f-ffe2-44dc-1239-08db895836c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeZLqFY5yI9KlhJqezGMgps3Fcs6T7dR3pzyG3GTc2SIqfQUvsYB5cuw+xUZy5Yoc3Fpfs8ThY8XNZixsHg9wI1iXTAXK4bJQwJK3xoyqwvqyA6B7vdmi9aBzRktDzPf5j02sSCCBd1O/TBnkS0nLEY8Utt68fMAiRiWVLxU55tBWt8B+SOWXUevSoQTvuumXm1Ns2B7fyRi/pVgiBTJXM689f4/H/rON9IWp7Qgx2FuT+4Z73ElBEggBAOtlqi579HAxnl6a9VfX8PuW4OIcIoMqdYCkIUZygBGsmmB4kLZ+0ShZ3llwEk7KWGrRfBfuMq7LnlyU8sVAE/520wX5mTv3QSyj3wULbQxg/A8awmKypiaFpOtCkQgJZSyfwmmLHjb/66wfoA4NrCJhTE7LRK9jK0UvUcatvRMFzknglE8Q+T8otyxS1mw9KX1Q/PT7yZt9UCXa9RSiLkvno4L4P5jdoeHJbXLlwRx/FKBPzlf38FBFKWr9EIpdHYhe7C6N3a1m7v7lCpy25LnCEL4TZbDEyLT3U5/QKhvxfbC2gk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39840400004)(136003)(451199021)(478600001)(2906002)(6512007)(86362001)(83380400001)(26005)(6506007)(2616005)(38100700002)(5660300002)(966005)(7416002)(54906003)(66556008)(44832011)(36756003)(8676002)(6486002)(6666004)(66476007)(66946007)(6916009)(8936002)(316002)(4326008)(41300700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bjB/VNFAZK10ZWIkCMegp9/q4RuRC8KY/ZxW+yWIUE6A2ozWs33CPUhAeGtH?=
 =?us-ascii?Q?bPurhPtvAVFwyH4LOYg4kFmroosYavybYonRbxQQeipHOmM2ZUziuRJL3km/?=
 =?us-ascii?Q?0VnNGdCk84IAseOR9/gh5kgnvcFuGxqaEm3mqXYXU5HqH3LUg9vnqMv7DhXD?=
 =?us-ascii?Q?pdGstsuEcnkCBeGgovajuSMMoEtC6CEPhT8QmbmS8+GWzyn94wPvkH6adA+V?=
 =?us-ascii?Q?9z1oZDHZvp3WUJidrg5MjK006iJdUGKlNRiY61wEzmMbjWWjD+7NNToJgrnA?=
 =?us-ascii?Q?WLsZu+E8pfdZdf095Eg2CjUYClTVWt7u/oC+zApdUjrCRSk7I0rEHMa2L63j?=
 =?us-ascii?Q?tMzIN/fI6ViEEqeruNE0VWSXEJCWHiuNF5jYCdVSpJd30Z9RhtWDSXRSh02Q?=
 =?us-ascii?Q?wyjpVcLmkqw4fq71UT6eu3Tcbnq0mIQgRhEPjAPuAWmqHVsYNQfXmB2FgCM/?=
 =?us-ascii?Q?K4EX9l6uBDRrVE0l7LyGxHrwNAN9hUT+UX9y3PWLpohh/E0GEMlVt0iiIjrH?=
 =?us-ascii?Q?WI2Q2XZqTDSSgwZtyStfvWLZ+1xuKx+HTXvMeKx6H+5Kp/bs1d0qbQyqlqKP?=
 =?us-ascii?Q?WJlu6y2MHERVwq3kv0nvMGSW69J2+ZB9R3AKQRdxA/WVNk57JmjYgzzBJC8u?=
 =?us-ascii?Q?M1z094KiPjpGuIYeFNsDLoSJpY4zSknnI+n9ejVxvnLHZzJdnDhnDggyBKDI?=
 =?us-ascii?Q?DKDODRgCQb7QACKUWaO1bfto5TLs48ykxjJMrf7B/vYmPGP+Cqe5X59vsBCf?=
 =?us-ascii?Q?oJJuBlrELWumv1G5YIxuyTrbRSjsLtvUN2HQJfLsxKCmR+FziIoWj8ZzKLS0?=
 =?us-ascii?Q?RcYuCwYX2DfVuL0cchE0g7WPW7fdYG8YsMIOef4CFBWuH9E6tMTmmUbNgVUI?=
 =?us-ascii?Q?CNOcGjYF009VfKe47CS1BAkrceVr6M0M9jVq+c5qt71pfblYRqU2bGgEV7xq?=
 =?us-ascii?Q?EA+WD0++OrPw6uP0GWX3pzvOmWgmVyGFe3fKZOpzxHDUdgzWU5E85IrBoY7/?=
 =?us-ascii?Q?EExMrezXfHqcwvgedDIbrjtMuZdM0MNpWyUP/fwO3Scn49ZqtnAUoYAVWx1I?=
 =?us-ascii?Q?eHRtqtMe8eYyMJ3V/oNWxwmFjh/8t1i1BpW0JNA9x5ec4TFLNtnQtIS0Xcpr?=
 =?us-ascii?Q?EYaNI1BIxoYCfBigtxqLWP8hvzAIZVJy2YwYRQG75RQLjbi5fn2Fm5pR13X/?=
 =?us-ascii?Q?imtzuAUcSCtMZ6jSdghYtKEBN17OtBqgGmmykhr6TcQhi648+f4GWsq2dRtc?=
 =?us-ascii?Q?+hxZQ3xFDhlZSnZ5C95dAa/Ig2QgNv5swn/BMbz0Jtzb6PgrBWeR20EkbcYd?=
 =?us-ascii?Q?7FZxGehmq605TGvcFOXd4gP3mywFDCjZSiXraJR3bXsfHBtH25F2fk1bUaYH?=
 =?us-ascii?Q?YKwwBbEcrTt0bpsaQxmuR74lw0R25lil+dUqTUMjmbcKOByFSD9FK66c9vGj?=
 =?us-ascii?Q?uxwa3k07Dn7eFbt7qtrSmi5sZhcekAR/PWr8/eTFmpvaYLFnlBYX81znqj3P?=
 =?us-ascii?Q?Z8zOLe+kT6n08aHxmB6KexXJFWL5jSMc595++u8LAivWXT2FTTl5UBMSfdCe?=
 =?us-ascii?Q?Wh5X4+0/EGj4TSfAA2fiEgMxGA0OCnpO8KaVwdF8Pw0ewr/CHjkY1v/JzJ/4?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b2a22f-ffe2-44dc-1239-08db895836c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:33:37.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ke1+NunjAJMYZbx+87ytzuBQICe6lxx2+mV9TwKmLkQ8hjouGOe8ni01myX5p96ikbQgNNArCSmHxYvKPZrDysEO8n0rY3xozEsGev4JHJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR17MB6604
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 20, 2023 at 01:18:33PM +0100, Jonathan Cameron wrote:
> On Wed, 19 Jul 2023 14:49:07 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > 
> > Maybe a dangerous suggestion.  Right now the CCI's are static:
> > 
> > static const struct cxl_cmd cxl_cmd_set[256][256]
> 
> That's defined by the ID space for the commands.  There can't be more than
> that many currently..
> 

Meant commands beyond what is defined in the spec, not beyond the 256
limits.

> > 
> > how difficult might it be to allow these tables to be dynamic instead?
> > Then we could add an interface like this:
> > 
> > void cxl_add_cmd_set(CXLCCI *cci, CXLCCI *cmd_set, payload_max) {
> > 	copy(cci, cmd_set);
> > }
> > 
> > This would enable not just adding sub-components piece-meal, but also if
> > someone wants to model a real device with custom CCI commands, they can
> > simply define a CCI set and pass it in via
> > 
> > cxl_add_cmd_set(&ct3d->cci, my_cmd_set, payload_max);
> 
> Ok.  I'm potentially fine with people adding an interface for this, but
> only if they plan to also upstream the QEMU emulation of their actual
> device.
> 

Working on it :]

Hoping to show off a fully functional MHSLD with some custom commands
soon, and I think I'm happy with the abstraction that fell out on top of
this CCI work.  Previously it required duplicating the type3 device or
hacking directly on it, which is a maintenance nightmare / not
upstreamable.

> 
> I'd look to just inherit from a cxl type 3, like Ira did in the PoC for
> type 2 support.   We can then easily add a path to replace the commands
> set with whatever anyone wants.  I'm not sure we want the command line
> to be used to configure such a device as it'll both get very complex and
> prove increasingly hard to test more than a small subset of options.
> 
> https://lore.kernel.org/all/20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com/
> 
> Jonathan
> 

I made an attempt at this at first, but due to the custom commands, i
think everyone would (rightly) scoff at the idea of adding
non-specification defined stuff into the core type 3 device.  Once I
shifted to modifying the CCI and overriding entries, the entire vendor
device ended up as mostly the CCI command definitions, which is exactly
how i envisioned doing it in the first place.

I'll post some additional patches to my MHD RFC, the changes were pretty
minor.

Hopefully will be able to tack on a concrete MHSLD following that..

~Gregory
