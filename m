Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C077C77B61
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 01:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjDKBsY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Apr 2023 21:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDKBsW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Apr 2023 21:48:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F12729
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 18:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrAaGAeCGoXgfWy7H3+PTOINogxm5fKmPYn6HvrwFl8C9GW6eR+TwtxnuGf+F821nbG8bR2jlB3OOC7uiZjsoKFjdc4Txo9gm0I77Wlm4+KpZxHCbxUhEgKXDgaZpt/Fdf9SE9KEt3otDmw4uJEK+ly3YPdLq33ETvi52BXrOVpZd07LS2s/npBXcjvPagDd+5Z6tJ4ioxROZD1j1qwxz0gtpzJ0hiwnG0gRvlaX+5xrCOTKwl6VCi30t/p8fs+RUqOPQfXpzdcZJ7dv5D5FCfMmknKGWgQpFd6ZJHWrvsMuF4c8aD2nBofi1QvGi8emPaFqUe9xrMVS5RoICrz0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZuJ3KJh/fFzX420vUzA5phRtvtgUBI3XW4FGjFS6I8=;
 b=Hp3Zk2E832T1WzRokeBP1O/q3y1Wlja7F6m7qiJotDApBPW0wa4GjI7gc6ayotZjNvExdmBSM1DHHEelOCQgrssguvQomDKS+ZtyvIavXMuIlEEezGQMkWb5sPV/ozH4VkQQDn6YkCTZ0N2DMX6n7LvtaGd6m7eM62C+3djKcezoHDq7ntge59shYsIZ3NvLN3spTUSq5741fsQOUeWbv63HM4YizGhf4W+PyMUW2iWR15zk8mP+526G0ZUkd/TxBFf3uUUwAPKUOs0JqiXkXetf81udUdkoDKyEKZ6AMrrG4sjsNC3zp3hdgzqQund/crCZJUy7VEpdMZBYNVoYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZuJ3KJh/fFzX420vUzA5phRtvtgUBI3XW4FGjFS6I8=;
 b=v1bNc3PSd3QtDMCzbhvb6URgAHQxumkuV6IQ+yswj7I9q9SgUHJbXS8zq1ffe9Crgdw4WhlHq20xzOqoaOLx/qAGuuqf+LmRorcNOGjirZ9U2xUlWnWLy/IZkv5djmy3Vaj7hAbbusAABwA7CqmVKf94kf7ePfPImDr4sQmnzLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB3868.namprd17.prod.outlook.com (2603:10b6:5:255::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 01:48:16 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 01:48:16 +0000
Date:   Mon, 10 Apr 2023 21:48:08 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dragan Stancevic <dragan@stancevic.com>
Cc:     lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM =?utf-8?Q?li?=
 =?utf-8?Q?ve_migration_over_CXL_memory=E2=80=8B?=
Message-ID: <ZDS8WH+yViVfsuMi@memverge.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <9d22b56b-80ef-b36f-731b-4b3b588bc4bd@stancevic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d22b56b-80ef-b36f-731b-4b3b588bc4bd@stancevic.com>
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB3868:EE_
X-MS-Office365-Filtering-Correlation-Id: 090ad7a3-906a-432b-f366-08db3a2ed12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDySl3+xpMeMcgXdbbsDtApN2v0TnlXkcKuHtqecHNRvxgsZHO+stXT76x3mH+IgVCwMSA9+yz2ZX/sw74H97bkUrwyu9eXpQShRxNU3eIdGYFmDuprdjlR23X/W1/A9u25NVBjuD3rDRI9hIxsgF3mkm1OCq2AiZ/CELloUcDWGMtdw8LITVkLM83Bn8IyQrjO43fUBd1+kEH188CFkbQZ3GXkII2DEjxbDcdb4oZ8uV+HoY2IS1Km3Uyl9y/GCjI+UXdhFHdXLZRMbg9CeJq16jsnjJv1nZb4YyQSZqoVdTbhccfBRf4qj8EgsqoxovQ7QbG9G5L/7F6UDUvEOSf8koEYuGJ119EWj4qUxpzkJCXSy5JvaeTYkpAYe/Si1OclsN4mOfCIGyT2OIKrTRT5D2ZnFOW1CMlqLHKgiuMS62P3kSkT+fTip2nIyi3yeLfXeFXnTqOfguq/x9GjgyES0YykYgnX9sYVNM9gd30kFym1P0y7bbbZBeT122k/I3Xzbrg26UJ/3b3EeSogLfXhjSsAceY6chTctqTD/FQLgT+yOK0dpbJN3Ix91dQjQ1MOqo3SDBxbtB77eac6MigBKAzUyKNCdgAJUTM1YgAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(346002)(366004)(136003)(451199021)(86362001)(36756003)(6486002)(41300700001)(316002)(66556008)(478600001)(4326008)(6916009)(66946007)(66476007)(5660300002)(44832011)(2906002)(8936002)(38100700002)(186003)(53546011)(6666004)(6512007)(6506007)(26005)(2616005)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iydgEVLi5bmpm7m9DJcpStvo5sm5T4KLhckHTI69E64mIdu+iPxTRGCt5jRH?=
 =?us-ascii?Q?RXSk+iu9pEDOPpjNFdYL1HuqzfC0Fya3eQPsESTNV5KLQB/+hx3CiWyMxEPo?=
 =?us-ascii?Q?Y6D2i65EkFMrPKvxtC6gpEazX8BK64JrILk9oYXBvV1ZGMI5lMAcC42SG/PI?=
 =?us-ascii?Q?LSBBgrGKOH1r+YuGn7JoPaOrtX0zX0Ko0ZL0IPQFad7Ud9AO/1E+whZ5KbJ+?=
 =?us-ascii?Q?Owg+AdPnWORqiTMEaFWpTskAmBgfXZrNNFo3A2yPvWYclO3JrKNns/5Fl36Q?=
 =?us-ascii?Q?F2QGWgDqSKtSYtwARc4cdXQ0V2QpmXr2mzd7Y8wbzGhOtP1LF3Qcu3RByux3?=
 =?us-ascii?Q?N9IUU90PJqiPrIA72YtGa/MdoziQ9wgpUUKg05uGgKw+e8XFUf5Onbbi1XOE?=
 =?us-ascii?Q?xBSXvACKfFuwFGMIrC4XRHN6pPrxr4oZzFtfgN8Igtvw1i7jOfBzM20YfRM7?=
 =?us-ascii?Q?R/fEqlOMw3YVhKq5xrz1v3gfVSaeYtJpmXUA5HR1YLH/NZPTN2W6v8p+15Py?=
 =?us-ascii?Q?0ywFm3XWjHL+1a2h8YVYEIV94001J4SX/Plda8A1aTpqlgFpHWLdIMaaTBMh?=
 =?us-ascii?Q?Mxv+XS0iI3rQMwbrs1Kr5jB34r0AaE1WeG/1//FYYSWYm7MQt2tP3zFsPmA+?=
 =?us-ascii?Q?yD2nIaIhliWv+vYVDM4NdU9jsljjTofM84UiEtXyY3dgUn5xeJqLj+8/xZ8h?=
 =?us-ascii?Q?iM+jhG8lYak+ps4hGvEhKG2pSsbZBnUAFyEh8+b7I5NGmmSjTnpbAlbMLEZc?=
 =?us-ascii?Q?qclvFLmRsYiW7NWn3/IbxWEZGBdf8irLK90QFlQ/mBO7DqbDloK/dHyewPHo?=
 =?us-ascii?Q?fNPvhfJu6NRljlT30dZ43uYsfIRbGejOLz42qmpCvlzId3vUZVs0dChXltam?=
 =?us-ascii?Q?rHMhYbPeIzNhMXd6jSuCH6uNFepzQITlHJCdqdKlkmQ7dumznPfiyQvkovPm?=
 =?us-ascii?Q?Z5zUev7cChCPDQgOX4McBHFuVDDk1kARivSttGgFkAMLHXC0+8Dx5JTFMzhI?=
 =?us-ascii?Q?8X1j6nh/vwgGtkDA9AG6IAbmRekatr8hpCfe5YJyzIiaQceJIhASuiw2R23T?=
 =?us-ascii?Q?mBQcmBfRhc57/tVpCTUQcf5BLp7N7wDc7iN/JEPmzWW6YvzHu72BUvMtLJuK?=
 =?us-ascii?Q?wQeIqk9avBY6eY4qTAPiWZ4BjpM9b7Zj98N8EPXetFe0v3ckdbkYvE0PeSVx?=
 =?us-ascii?Q?V8ndMGqa2++VoruZZSrvhqa95Xq9Vv/z5wMLow4ye75Rt+RxF/Hj2yID8o1N?=
 =?us-ascii?Q?QBBSPHFna4tZJFpugcZkXZEU/Zz//k2JGIMmF+j14ZVspETXWAy0L2kDHnUg?=
 =?us-ascii?Q?71PtWDieYrLb8h8aNrNMyS9/EArHE4a6WwD9DKucSvf1tWUdSA0MS+39bY4u?=
 =?us-ascii?Q?bpvgPthwxKoAGQ/tqR/+FRQrICFsjQmWadn/vW57NVEgabefkIUvO4LhzVw3?=
 =?us-ascii?Q?0Uul4SIHg9+rGRyDS4rGxbCgKHq+WBLcgCDY1ajNYYI1m+k2GnD34O2pwqVJ?=
 =?us-ascii?Q?xoIkUYjpz3BfimGCk16XLMcqyf0qwIY6nC+xW6UNzwCwmXutfVyQT+xJqZTn?=
 =?us-ascii?Q?v1n5Ch/2elsSNjR3VEYbwdqUVG95tjtzA/O3hJyVMoIWHrwrA/aANEz46liG?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090ad7a3-906a-432b-f366-08db3a2ed12a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 01:48:15.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJLICpkjZe0G+ZU62a2vn0DHyNIZRT9+6uz/8DPrAQJ5TTWdRH+0MNNtfggS0JzC9qMnww3H0OW09jMQFEZjGPTDK8JnGe27um8rtFmtL9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3868
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Apr 10, 2023 at 07:56:01PM -0500, Dragan Stancevic wrote:
> Hi Gregory-
> 
> On 4/7/23 19:05, Gregory Price wrote:
> > 3. This is changing the semantics of migration from a virtual memory
> >     movement to a physical memory movement.  Typically you would expect
> >     the RDMA process for live migration to work something like...
> > 
> >     a) migration request arrives
> >     b) source host informs destination host of size requirements
> >     c) destination host allocations memory and passes a Virtual Address
> >        back to source host
> >     d) source host initates an RDMA from HostA-VA to HostB-VA
> >     e) CPU task is migrated
> > 
> >     Importantly, the allocation of memory by Host B handles the important
> >     step of creating HVA->HPA mappings, and the Extended/Nested Page
> >     Tables can simply be flushed and re-created after the VM is fully
> >     migrated.
> > 
> >     to long didn't read: live migration is a virtual address operation,
> >     and node-migration is a PHYSICAL address operation, the virtual
> >     addresses remain the same.
> > 
> >     This is problematic, as it's changing the underlying semantics of the
> >     migration operation.
> 
> Those are all valid points, but what if you don't need to recreate HVA->HPA
> mappings? If I am understanding the CXL 3.0 spec correctly, then both
> virtual addresses and physical addresses wouldn't have to change. Because
> the fabric "virtualizes" host physical addresses and the translation is done
> by the G-FAM/GFD that has the capability to translate multi-host HPAs to
> it's internal DPAs. So if you have two hypervisors seeing device physical
> address as the same physical address, that might work?
> 
> 

Hm.  I hadn't considered the device side translation (decoders), though
that's obviously a tool in the toolbox.  You still have to know how to
slide ranges of data (which you mention below).

> 
> > The reference in this case is... the page tables.  You need to know how
> > to interpret the data in the CXL memory region on the remote host, and
> > that's a "relative page table translation" (to coin a phrase? I'm not
> > sure how to best describe it).
> 
> right, coining phrases... I have been thinking of a "super-page" (for the
> lack of a better word) a metadata region sitting on the switched CXL.mem
> device that would allow hypervisors to synchronize on various aspects, such
> as "relative page table translation", host is up, host is down, list of
> peers, who owns what etc... In a perfect scenario, I would love to see the
> hypervisors cooperating on switched CXL.mem device the same way cpus on
> different numa nodes cooperate on memory in a single hypervisor. If either
> host can allocate and schedule from this space then "NIL" aspect of
> migration is "free".
> 
> 

The core of the problem is still that each of the hosts has to agree on
the location (physically) of this region of memory, which could be
problematic unless you have very strong BIOS and/or kernel driver
controls to ensure certain devices are guaranteed to be mapped into
certain spots in the CFMW.

After that it's a matter of treating this memory as incoherent shared
memory and handling ownership in a safe way.  If the memory is only used
for migrations, then you don't have to worry about performance.

So I agree, as long as shared memory mapped into the same CFMW area is
used, this mechanism is totally sound.

My main concerns are that I don't know of a mechanism to ensure that.  I
suppose for those interested, and with special BIOS/EFI, you could do
that - but I think that's going to be a tall ask in a heterogenous cloud
environment.

> > That's... complicated to say the least.
> > 
> > <... snip ...>
> > 
> > An Option:  Make pages physically contiguous on migration to CXL
> > 
> > In this case, you don't necessarily care about the Host Virtual
> > Addresses, what you actually care about are the structure of the pages
> > in memory (are they physically contiguous? or do you need to
> > reconstruct the contiguity by inspecting the page tables?).
> > 
> > If a migration API were capable of reserving large swaths of contiguous
> > CXL memory, you could discard individual page information and instead
> > send page range information, reconstructing the virtual-physical
> > mappings this way.
> 
> yeah, good points, but this is all tricky though... it seems this would
> require quiescing the VM and that is something I would like to avoid if
> possible. I'd like to see the VM still executing while all of it's pages are
> migrated onto CXL NUMA on the source hypervisor. And I would like to see the
> VM executing on the destination hypervisor while migrate_pages is moving
> pages off of CXL. Of course, what you are describing above would still be a
> very fast VM migration, but would require quiescing.
> 
>

Possibly.  If you're going to quiesce you're probably better off just
snapshotting to shared memory and migrating the snapshot.

Maybe that's the better option for a first-pass migration mechanism.  I
don't know.

Anyway, would love to attend this session.

~Gregory
