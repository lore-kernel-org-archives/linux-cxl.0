Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE4C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiLSQMq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSQMp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 11:12:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4077B95A0
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 08:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7pzW9HoGQh3fGNs2s5qOcApBAwNAMYNOZNtb9ihcf2FeBpTJUjFuTXoXXEeA6FV6n07YMXZNfNwZjLC06+Lax0nwS+7+FkAMauJXf8zZca7cX2PWGerJE/Gpl0uPMvFZC2Lvfe0yUyTcusAB+5909JxiOKQze/isC9g91RyoPpAR19uow5EseW5kpVah11dex9RPtVTYI1nZ4lTFXgnq4HcLrbH3GMaFWUY7QZ1gEjOnKLuUVfFntgkoRrlFpBcLmAf00gmhiANugY6xsRqSg9ph/MALr9MOuz9kx2QjEKFgOimWZytaVhSCkO7DcttcLrC30XGn8GneyvNe/+Lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIlNWpRvNQiagD5PJ1KNa8BiVxUMfoI+XYyZg/Ce/s8=;
 b=KzZYfTPLhlBjKovronR0+dDnKtNryOaM+5d3ZGunlp0cyN0zfeH6pvDyRN4IZ+G0q7UXY7wU/AXAU9MFEvP0MGat0J30oP2SM3ijNiPCo60hODmOgYeQlX5h14PztXNQFVrdW7vV6GmZOy5YNc/3quQS6xrQKnL2ZMibF+Ob5RYgz3CtUZSCNyfhez9KXBHLv30n8bWGB6ZKeOqcKMTqX82wAFLj5jrOHWwpVDN9G8UzrDRZQFPfg3AgqUPB0SwGWtJwZcOToFeFNeSc48hzCHZqzN9cNskXWfinCd8GYHfR/riUJmblligr0+DlT3RLfhTVYysnXRuD+lgcO/4KhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIlNWpRvNQiagD5PJ1KNa8BiVxUMfoI+XYyZg/Ce/s8=;
 b=qfKCPWV3MMhKu0h+6mYzYWjrirpHRm0DDqBh6HudKa83F/duQXbhZzVthU6bi6VBtKCNYA+AJ48CKtHglQfaEPwkKwRF9O4CGo520DuksOrw9im2ErPIDVKWCu24s4O0sv6HVOD6fX2kloqXT6+WpwnQPsiv1qocHbqWqG1muB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM4PR17MB6293.namprd17.prod.outlook.com (2603:10b6:8:10b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 16:12:41 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::3299:1f35:894f:69df]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::3299:1f35:894f:69df%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 16:12:41 +0000
Date:   Mon, 19 Dec 2022 11:12:34 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <Y6CNcuIzUVmKL0SM@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
 <20221128150157.97724-4-gregory.price@memverge.com>
 <20221219124211.000032b7@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219124211.000032b7@Huawei.com>
X-ClientProxiedBy: MN2PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:208:23e::8) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM4PR17MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 588dac1c-5e18-443a-7312-08dae1dbdac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbMkEYwRRNHd5V2Mw2MewWMmbcFohBe9XZPCplhJ52oiBhohAkqfAJcewFMlmIAzpPPG8Av/KyVv7sflHMFUgmBUv9nP2GJZA0t9LGCNZa6FzHhroQlWOE3MA330L+5Wc1fCOVMxG5b2j5ZPQrj1If7LQ1yzwuLJ4xs8PLQAnYl9hnuaR50LGXijx5jK3AalPJnpUNoh3SPzDCIY3cxFJSY6SkxK6wjyfhGbtD9uoeQn+mcQH87fahr9pLUcKrYMg4xbbKwWBMw5LAp1sWUpyzXqceNkhdTza7jr70jwWHGIF1Hpm4YA5064XPMtbFCBgGeS3GksbAnWfb5sdo7g3PLTojAEQOOGjCubJBANRN2RGUCR5V6ZFQ/LvYJgZUoXsHrOpEoXndXiafrlRdApn2XSpYKoZw9RObHDy1Wmq8+aX5gFUcMykMt6TdKZEz6UYB/0nroNmrPXzt6BXyOSMPmgSxCtk2EFtc1gPBiHUjImEhc5/S913+F9rMIDOUrNkJQnPVFO5HJ4IY1usQukCdyBFod60GJaZ7FwJsRxGl3lJnxpYXH1vY/dxI8l+fm04U6+khxAFRCGv/jsU+Vgf7Nw8Lft/diQHyZaVuHdTJRk0FmSiQFYI6xR/khOCqz9VD5dL3JZhi4l+Ho8Iw+dtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(366004)(39840400004)(451199015)(2616005)(5660300002)(7416002)(6486002)(6666004)(478600001)(83380400001)(6916009)(316002)(186003)(4326008)(66556008)(66946007)(66476007)(8676002)(8936002)(6506007)(41300700001)(44832011)(26005)(6512007)(2906002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+BA/j9LEKHdLR5jslh2McSKTp23ZvTtMS5Cnf17Uyj9yaY8Oryl0TgltMhr?=
 =?us-ascii?Q?Ni9NTbcW/nm29gYZzQLVDXueGxAyhKE9kmRj1Wa0Q5N6E095e1dQUSLYsk2y?=
 =?us-ascii?Q?51uyxqFk5dB05/1MGJvYy8GlplD1w2XaLa4ySh4wH4HSwCzIcFuOnwW5D+V5?=
 =?us-ascii?Q?dkoVUwbdzFjNIyELaAjRzAnftQqm8znV0a2dWM1A+YvVRzCoGqZ3eTF9GtmG?=
 =?us-ascii?Q?EG/wNEYLcyPd5jUBJAA/9g499LOdCQ/vBzE3F0fqnUZY4Zo3THGun9xHLLWB?=
 =?us-ascii?Q?iTfdL8rCCog0crZajp2XIA9g8nVSfGwowragphANgG7d73wnQ9PXzc5eDlB9?=
 =?us-ascii?Q?ikGIWczESPH1n9EfwSuxeuy2RDbubyyjz8xfnlJne3VOiL0anXsrjg/UT2uD?=
 =?us-ascii?Q?uu+AdhvJmHQkeY4MFMNtkECbjvj3OxtNtHj8hMejlv+2Cl2Pa8qow6SgYqUU?=
 =?us-ascii?Q?MljNVg+liGz2fIzfhZXJvOzcXe7jiwHmKPLrs1uKlgmfchhH7IHmXEdADHAJ?=
 =?us-ascii?Q?RquIjo9Cb4UyyYHUQ93XjEOMU/GSuqhbLo/PgDcyzQOPpk3Wu3EjgP4MrdDT?=
 =?us-ascii?Q?JjizkLQWHqSSpMm13+DRPXogku/q8eFM3Zt70RGNfSCZRmfETkA4VRAZaqS6?=
 =?us-ascii?Q?KsJxxX6r5uv6QsjQ6KxQON4j1S0kpotLursYwnQNBOUG4WaZUf3PAaEevFC4?=
 =?us-ascii?Q?qXlezia3IHMtL4Hio9CiVzrEbAklvE0vbm8cx+Pp+bp5b/lmQf4WdXCvH3Nh?=
 =?us-ascii?Q?3NLF+mS835ht7S3UACjS608tBQBUiCEmR/AiODkJqrkTE3f4+4NREdISoNJR?=
 =?us-ascii?Q?4BfW4QGnkrCc2Ye2H5+iBqTwgFpMHmGm7IEF/kLBnWXhh5CmR9A6Ps/jPi1J?=
 =?us-ascii?Q?mcCJiyLM4GxeihsHYuQEpt6Sofwq02bv0J2RXHYDUjSKGdKo26gMgpWUVBAl?=
 =?us-ascii?Q?KtQRD2tkuKhTFNSKFezusQapCvytj0mdHIxOguaV98vSIBnTdqMmg4PMUoOa?=
 =?us-ascii?Q?J8iDRJGiurRsoOa2OFSLYBVC4lEWeU60mQAaPbcMhhCnu2og73kixh5CCZgQ?=
 =?us-ascii?Q?c2ogv3Ww8leXGeZrqRQXrFpgX4vYiZG4zS3+sJPDd843s6nVlP18n3OSgieo?=
 =?us-ascii?Q?EsiVjhCicYTvuAyknCC5wQ5FwxEsFyZVmWfaqXbIf089zUpmHDo2Gk/NblIU?=
 =?us-ascii?Q?PTN0c8mmHXPpMSH3wrSUJW6nrzv+7PTJb1JoZf3uh+OidnozfJkixmxBsNrZ?=
 =?us-ascii?Q?aMQZAybBZTubcWTvLWoPsOiXrOsQPYpQjWJiWqqGrTwofWD7J5R++AqWQx3V?=
 =?us-ascii?Q?aPgSGJfzbyRucJUcYv0o9ob4nkKAqffSQh3cf8bSczAOykzz+6scyLVugoBL?=
 =?us-ascii?Q?5mbqctRv/pPq9Q3mI7wKbvNgXLBy6OE1ZishtQyLOu4d1kqZFODUt7+dzjCI?=
 =?us-ascii?Q?Foc1qGKKyBTyRhvKkVCyjyJqnLOzg3i9fz68eApTYSvvw9djQVBvIKJZqePR?=
 =?us-ascii?Q?NgRwcu7XREBYBCn/v1WGJavNT7AxBTZRDnU+HaMf6oYwgyqkdfBTNLJwQPer?=
 =?us-ascii?Q?CjIV0Vn8YarCtkgXmpaMi/WGxu3MYMmErSWaCVi6NnrCpjMk1uKGgdT9CwPh?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588dac1c-5e18-443a-7312-08dae1dbdac2
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 16:12:41.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5yOymBQD6Hir781vC6hCIhcYvjV9EHtdNMWCX3oBVuOqZ6upArf0Xmm/sIu4SHM5RKSjC7li5RBsZ/37OcXmglwrFacN6QTtHqxeq9c0Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6293
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 19, 2022 at 12:42:11PM +0000, Jonathan Cameron wrote:
> As a process thing, when reworking a patch I picked up for the
> CXL qemu gitlab tree, drop the SOB that I added as it's not relevant
> to the new patch.
> 

ack

> Still no need to post a new version unless you particularly
> want to or there are other changes to make.

ack

> > +Deprecations
> > +------------
> > +
> > +The Type 3 device [memdev] attribute has been deprecated in favor
> > +of the [persistent-memdev] and [volatile-memdev] attributes. [memdev]
> 
> That's not quite correct as it sort of implies we could previously use
> memdev for the volatile case.

An early version of the patch explicitly errored out / warned the user
if they attempted to do this, but that got rebuffed.  This could be
added back in.

> > -    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
> > +    if (vmr) {
> > +        if (dpa_offset <= int128_get64(vmr->size)) {
> > +            as = &ct3d->hostvmem_as;
> 
> As a follow up it might be worth exploring if we can combine the two address spaces.
> I'm not keen to do it yet, because of no simple way to test it and it's less obviously
> correct than just having separate address spaces.
> 
> Would involve mapping a the two hostmem regions into a container memory region which
> would be the one we use to build the address space.  Advantage would be that we wouldn't
> need special handling for which region it was in here or the write path as QEMUs
> normal heirarchical memory regions would handle that for us.
> I'm not 100% sure it would work though!
> 

Originally I had tried putting them both into one, with the thought that
since it's technically one device address space there should only be one
way to access the address space instead of two.

After investigating, the address space has to be initialized with a
memdev, and an address space only supports a single memdev, so i settled
on two address spaces in order to keep the memdevs separate (considering
each region may have different attributes).

This opens the question as to how to actually represent a persistent
memory device that can be partitioned as volatile.

Consider the following setup:

device[pmem 512mb, volatile 512 mb]
produces:
    memdev(512mb, pmem) && memdev(512mb, volatile)

But if I partition the device to 256p/768v, when i access data in range
[256mb,512mb), then i have volatile data going into the persistent memory
store by nature of the fact that the capacity is located in that memdev.

An alternative would be to require a vmem region the same size as the
pmem region (+ whatever additional volatile capacity), but this
means using 2x the resources to represent the real capacity of the
device. That's not good.

Another alternative would be to create a wrapper memdev that encompasses
persistent and volatile operations, and then create the partitioning
logic on top of it, such that it can use a single memdev while handling
whatever sematics only apply to each individual region.

The tl;dr here:  Going down to a single address space would probably
require writing a wrapper memdev that abstracts away all the
partitioning logic.  Maybe that's worth it?

> > @@ -744,30 +891,35 @@ static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
> >  static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
> >                      uint64_t offset)
> >  {
> > -    return size;
> > +    return 0;
> 
> Hmm. Maybe this should return an error, but then we can't use the uint64_t as a return
> value.  As this function would never be called with !ct3d->lsa let's leave it as it stands.
> 
> >  }

I originally wanted to do that, but I chose to keep the current contract
semantics so as to minimize the change set.  I agree though that this
should probably return an error.
