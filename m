Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C00C001DE
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Jul 2023 18:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGSStU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGSStT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Jul 2023 14:49:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6438CB6
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 11:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSMU+PnD08jm8vwp+VyUbrrw3SSbRY0vw9u17ztfuH0ofCgbN8wIBmNGyqLu4IosHpmxQ6lfZqhCq1N35SLBdnbeylk74Iqt97SzJXn7Iqn+zPqa2dkQqAQdv5m0slvgFnW+ZQypZ6DTeA4qp12txapBBGO+xYoiI/ekYFGPirca9Ga3kjl6pgqBExN3jiUP8CB4PBFIvkiPWuvg+7R97X/CJM82OcsUOX1kQKrqJQo0BEQ0Dc2KYl4L7JqemxawD0hbO/qmIk/r7XOwMyP0GlM88or8cuph73vlTZw91Zku0WjlBrf9dewhBWM06sgATeeX5DZVjJWC9vRcbhHqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvUSnJq40NvTtZaWvtK8QOy/aitNrXeG/1bi9fAS/IM=;
 b=BgatGs2DBL4jT42UpgiS6ulNN9FkFFBgfFT73IIUScSbP9cFzh7J7Q/1gzch22a43D1XEMpv3/jfFVoghY57oNRGqrzEuPxp6uIZK0eXcdIinTETX8P2pxORX1n/3JiZnkvtEbRxx8fKORbh6ZwUqiS/7We1qWA9jfgPn3yjhNKtRT4wb7ixy1hIr2yCsjKzEJ9ZDm3W0EG07KaEDBl93fDgo6izLahyLwxR3UIEjfqn5JI2O9lqcK9oxaHdXQW2zbalvNx/ThA722Xo40EwXp1SDXIsSLrwZob3jrXIeHSBVEMU8spj9ZsbcqDQJ6dGEu3UQPTSTL3BfzEBB5SKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvUSnJq40NvTtZaWvtK8QOy/aitNrXeG/1bi9fAS/IM=;
 b=kyxBuxQTPWCa12myQrzGebZ4aM5TWiFly8CrhETHBI3H+mMhjNiufuBXvXRp5aqImO+mGKTiChWq5Sje5P8PnHqOI+H+boixgIBqeAcAlLqKYYR+xXUZ21yHL9MkKc2j60Z33j2ZLENhRHX9R6IZJYa9UGdlEcD//eg5ut+4bmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CO6PR17MB4900.namprd17.prod.outlook.com (2603:10b6:5:357::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 18:49:15 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::d6a5:10ea:ff7d:9578]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::d6a5:10ea:ff7d:9578%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 18:49:15 +0000
Date:   Wed, 19 Jul 2023 14:49:07 -0400
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
Message-ID: <ZLgwI5N/4RV2kpq1@memverge.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
 <20230717171646.8972-11-Jonathan.Cameron@huawei.com>
 <ZLcEkSLAj5yXVOVc@memverge.com>
 <20230719091947.000043ac@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719091947.000043ac@Huawei.com>
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CO6PR17MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: ad39d734-1373-4efc-30df-08db8888d9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmVpddtOzCwaTPxuxkORPbNN14I1Iwp+zkkSfSHYjOIl9ejR2LtZQbEnZGMBz3JPtNRCRzHOplCPxT7qqcUdJgjVms4ITEiZoAlfPXDqHP0R8iRiKcON5IuflT0zQKKTyI5oSdb0tomS4xH3ONnrHeVmbw5TJ7UUB0Y2cZ/zsd8Q4d1/bNt4lYbx6teOOz9SLeCfiYrUH9KD2gQ3v/3i5U755HmdVQpLjta90ohPJ5xM7IPU+X0HOt7HfFZalsv7J4e4Qi7fvu4N9jAaSIronAyV1wFxa2pfFtbFgWg1uqcrCDD8TZ36dqemr42kH/kuTZbIYoPIMctjn8RBTzQBkd5vpKSf00LkvnlvGPsHe01rKqTsGE/miQ6NovoqnJuMJpvoyWvqU2+AmV/IgYjc6ZwlQOFxXMP0jbW/0GlmVy3zW8k3gTw/+/A74NZUPmcxijymJ2z1tuiFWA3sn94nH5AlN/SUuK9vZO/z8vd1Dtb5HXAzewixWeQbPcfdpLuRhOi77zyG5dU9vvYzMEKYVQW54mPvQVH0hPgqU4o7DMIb9H9t2I+pxlr88L9TBLdA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(366004)(346002)(136003)(376002)(451199021)(2906002)(44832011)(7416002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(4326008)(41300700001)(316002)(5660300002)(6512007)(6486002)(6506007)(186003)(26005)(36756003)(478600001)(54906003)(6666004)(83380400001)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q0+LYk1KoEhNMzQogYPl4xZJmbZrUl7jx2/phKLKnRvi1XpfB9nXaK2xv8Rf?=
 =?us-ascii?Q?0+AGCboTf+IjirAwbu0O4uAy1x5sjPfXV+8EkgWMacjDfpsUbFd7UPQwU2Jy?=
 =?us-ascii?Q?EOk2yNdx+1Fr8gvuU5apIGmFreEMl99z82YwLKXUl4IkbfLncZ+gPVz0DUF+?=
 =?us-ascii?Q?5w5/RsgsgSvosBCTBqJrOaSvAPydYZJoGRTLpXetZ/UpkGEXeo0p3gVaIb3n?=
 =?us-ascii?Q?1MulKEVe9cV0xrsquKgZ5w99/0obNi9eZQi7GegolhIBjK282bXOO7ORgSd+?=
 =?us-ascii?Q?hRKZDwvc9lc4i8v25B/Q/vNXwVPsFTLa6wbnmqoT/bLojA9vNjKNDLtJuj/j?=
 =?us-ascii?Q?njxMWA9urW2ZFmIV02KsUDHQn1WXU27FcdkjFnx/0s4dfIF2xQUSGUAg4NHR?=
 =?us-ascii?Q?fQVXYlmD3hpbIs6Gpuajvdqp+ubEq53ekiq3Czy+ss5UFGI3zx7g020VmWQA?=
 =?us-ascii?Q?geJdMs9rVyLOjdX0x38rH159QKYVj3C/MCXQqNiiiLnUX2Ly1Dbpsrf/hGJf?=
 =?us-ascii?Q?MIFeDSc9+C8rh6rTxUluUTptTT6DToQQbwWEJ6hPfSMoUcPl5KR9xNRZsttt?=
 =?us-ascii?Q?8FTFO5hVfWc1VNoo8o0Uy970Cao9qqXYKXDOmmv0v1LzXXBEMmCWqaPp7I/6?=
 =?us-ascii?Q?NvpPvQVNNtjPD8TgjvXc5TliXo7sXd5ZxHNqiy2qqbuAC40NhSzC14zAaVzQ?=
 =?us-ascii?Q?nbKMQi0sAPeMBIfp7uA3chzwfHE9606HQ/3sY+3r9caYWcllR4navosJOsPp?=
 =?us-ascii?Q?hpRddgtWsZD0n9+LxEvOXb4U+Hkq9PT6ds8vxIWYEAPFaEybc2HQlOsz2ibu?=
 =?us-ascii?Q?78Y4WlkcK5izJj+dqE+muiVKFBvTj4ot6jTm1XaAgUHZtvNtVJT5xmfcD0Aa?=
 =?us-ascii?Q?i870jbcoh/CEGuAsUoOM1jCx/Fj/ZCI3Vci+XsP96LOmVmvQ1zcgVWiTCWxz?=
 =?us-ascii?Q?I1/6c1e0aguns7tNGj6RWInCQYeoFn03tNshRPcHYvaTM4a4g+OaP+FjcBih?=
 =?us-ascii?Q?QOST7LNzwTEBF76srcqg7hT35xrjPcN6f2tYqG+FvOITe/zAVGcFhKtUINYR?=
 =?us-ascii?Q?2rpGf/mtMEIJzttbtvPXGU6/iTkgWH5qhf5jxx2gdTEPXOoyImTJS4ed1sqj?=
 =?us-ascii?Q?bDyOBPDt7+rl+n50P6teGOkFFt1Gg+odrqjXpzbuFZZdyutX64ReXHLJZrUw?=
 =?us-ascii?Q?0lid0ZSc67snXGyXdtj9jCSXkFRZJVjvOwf7Qtu6LXXC3zPhiQsf1Ti37Kg6?=
 =?us-ascii?Q?f5/pJLjQDQoybxmcO312auuH5wn6wIMbCx38SBikkTKa7qEJZ61c8m6DWJ6C?=
 =?us-ascii?Q?7aHEwhXa0ipyUjGptaafiyObzhrCT6/cvJkfW9oEIi4YUrIRsfCzq4ELo4Ll?=
 =?us-ascii?Q?O01S/dBChqjJyOdZ+oXcWMe8x2BLtXdif95tQEoM/j2dIOaaN6XD6PsJRC0z?=
 =?us-ascii?Q?amYJCmAtnb2vx/Yo1bOumD3gmCvaLwWdUXTFuBbEjvkoVKMvP6L4/KqfGTqg?=
 =?us-ascii?Q?iCAVMitK+omQsXxGQDJm6D8wrH/En2oiQFXMObjCBM3esAwRFZzHwdC+uD//?=
 =?us-ascii?Q?/cIWBsQJIdA5ZfjisDMvfqEY9trGuwpfcVRmx8CI10T3pbQdBdZUd6ITL03W?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad39d734-1373-4efc-30df-08db8888d9c0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:49:15.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NaL1Z2K3SrB+MwkKsOvtsWvNCQohCgutr/K8zhGYKJap7yL0bhm8RyKMXzcfzBgYZk1RHNUv62k1fwMl9IB1rTVgQ1+gjx0hBmOCsp8oGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR17MB4900
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jul 19, 2023 at 09:19:47AM +0100, Jonathan Cameron wrote:
> On Tue, 18 Jul 2023 17:30:57 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Mon, Jul 17, 2023 at 06:16:39PM +0100, Jonathan Cameron wrote:
> > > @@ -397,8 +401,9 @@ struct CXLType3Dev {
> > >      AddressSpace hostpmem_as;
> > >      CXLComponentState cxl_cstate;
> > >      CXLDeviceState cxl_dstate;
> > > -    CXLCCI cci;
> > > -    
> > > +    CXLCCI cci; /* Primary PCI mailbox CCI */
> > > +    CXLCCI oob_mctp_cci; /* Initialized only if targetted */
> > > +  
> > 
> > I've been humming and hawing over this on the MHD stuff because I wanted
> > to figure out how to "add a CCI command" to a type-3 device without
> > either having a billion definitions for CCI command sets - or doing
> > something like this.
> > 
> > I don't hate this design pattern, I just want to ask whether your
> > intent is to end up with CXLType3Dev hosting many CXLCCI's based on what
> > wrapper types you have. 
> > 
> > Example: a type-3 device with mctp pass through and the MHD command set
> > 
> > CXLType3Dev {
> >     ...
> >     CXLCCI cci;
> >     CXLCCI oob_mctp_cci;
> >     CXLCCI mhd_cci;
> >     ...
> > }
> 
> Yes - that's what I was thinking.  In some cases a CCI may be accessed by
> tunneling on a different CCI on the same device as well as the option
> of tunneling to different devices.
> 
> So far the set that we'll end up with isn't too large. And if some aren't
> used for a given instantiation that's fine if it keeps the code simple.
> We may end up with other MCTP buses and to keep things consistent each one
> will need it's own target CXLCCI. If we need to rethink and make it dynamic
> to some degree we can look at it later.
> 

Maybe a dangerous suggestion.  Right now the CCI's are static:

static const struct cxl_cmd cxl_cmd_set[256][256]

how difficult might it be to allow these tables to be dynamic instead?
Then we could add an interface like this:

void cxl_add_cmd_set(CXLCCI *cci, CXLCCI *cmd_set, payload_max) {
	copy(cci, cmd_set);
}

This would enable not just adding sub-components piece-meal, but also if
someone wants to model a real device with custom CCI commands, they can
simply define a CCI set and pass it in via

cxl_add_cmd_set(&ct3d->cci, my_cmd_set, payload_max);

Which lets the existing /dev/cxl/memN device dispatch those commands,
and makes modeling real devices an easier endeavor.

Only downside is that this may require changing the command structure to
include a callback type and pointer per cci function. The upside is this
would also allow commands to be written somewhat agnostic to the device
they're being inherited by and allow for device nesting like...

-device cxl-type3, id=ct3d
-device cxl-mhd, target=ct3d
-device my_vendor_cxl_type3, target=ct3d
etc etc

otherwise we're probably going to end up with a cxl-type3 -device line
300 characters long.

Maybe that's over-generalizing a bit much n.n;

~Gregory
