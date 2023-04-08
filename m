Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E6AC76196
	for <linux-cxl@archiver.kernel.org>; Sat,  8 Apr 2023 00:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjDHAGE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Apr 2023 20:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHAGD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Apr 2023 20:06:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C22FF36
        for <linux-cxl@vger.kernel.org>; Fri,  7 Apr 2023 17:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNT2jXGXORctLw6yRTWGZfUWMy/kFPGbgVDwBSCd81N3krQKnkmXlvg+WR+QgHsmblDGe1I0lRgzvdx+FnBD5exGNdKyqqxHxQCILxd7pHrBf9D8NvZF/9nCsCQuoFZy2xmh31XDR60SBgk+5J5rXyYXN8a1wLyBiRTum+HRd8bYa98Wq8aKlEXY37OKaXfpor9NcRM8HCQRIXWFW4puxeHIKCL7XMreO0rZf8lFXKkYNa3oXdrNf1Y5P97r/sJG4qFBtnhj9XAcVO3cmEygHS8SiKXtryhdbvj2VTnqBIzPjMZ9NtEYGHWcOEeY94G5Yg9cY8TWt5n6qAGT9SHM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV5CAgIT3mhFsSzoDCXq0rmmi8GFZB26RMwqIzT+u8M=;
 b=H9YB8Ox42Ik8y6GWEBQlQlw0hf3/QCW0mnBTq/dUIZGdIfzLWF3UT/Ygx84ldRm5wulf08C12jQySBZ88jyOqI364kSDnpRY5glEutsBPkB67HcZBb8qXePTSp6JAVYO94n4dAJE6ti1xcP9Etf6EhRnbH/wGCGGQsQQV1bhZ4l+Y9bWzPS6H+u7WhesLcoOdlXDHMHFyznNRxX5xcCRj6brh4SIbXPGIDH1BWxN0CHKgzHNeMJFChTD1zAYocaxYfWRmmIT/LjxWRXeLoe2PBaBfF7Vvyiqv/5Z0oPjWrhtn3eAPTgyIydY4bsJPd01hzQ/ICzlqV4cvDjqTsJzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV5CAgIT3mhFsSzoDCXq0rmmi8GFZB26RMwqIzT+u8M=;
 b=okA1iuDlj6aqXD9pl7LVsDC7R4DdxqYmsBcQqMVR0oxqKr9GHX9r4RuMBOgc7hMqD/+P38Z/vY44NMY+e4O8uB1PYgs0/ydfae+qWYfuz6zOIv8JHF31zhPh7qnpOJ2tIsYZT4QoWdrUDUicsNC97SMKziEeDAJToSlrMQBxSdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4554.namprd17.prod.outlook.com (2603:10b6:303:bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Sat, 8 Apr
 2023 00:05:58 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%6]) with mapi id 15.20.6277.033; Sat, 8 Apr 2023
 00:05:58 +0000
Date:   Fri, 7 Apr 2023 20:05:50 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dragan Stancevic <dragan@stancevic.com>
Cc:     lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM =?utf-8?Q?li?=
 =?utf-8?Q?ve_migration_over_CXL_memory=E2=80=8B?=
Message-ID: <ZDCv3lxLbquITy8M@memverge.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 28509d80-363e-4d31-8738-08db37c5078e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3D0HH84icCy+McITcfkHHZnfrLPxTC/WlfIaYXRUAxFK9Z0DThCCXoXFmAeOOli7Pz+nF8sqDkRm5CeFsIoWForFdgQQ2FG+Us2q9NPT9fQGjKZCL084Ahq7kv7J0IFR4n3skCWTC7p3SShEVd7qfDdHezJ+rs891gNA1BnuBXt2Qk4koM3RTjQMI926lklxpkKHN5X/cf21b0RHF8tdo55K3vx6A6ivW8Q0qEIZpXlfSh7kN1/Eoh8PcDTV4S/9GLIACNZF+7mtf/xR9uQx4knd6XWmk5Oq/YZlwUwdM6mfkSre+1louXbaErt1TryDzrtnE/XUlRq3D5wxMnn1m2MdL/WxVPJQHXJx87ezuxlQ0vkNL1K77elC8aVKDVvHDlWiFzT8WmVdqsTh7691H/RcPA+HLlSnXtEJ0Y0xB1lDblLa2Hp3U+kOxmijzQdE6qQ6cqQCnavO0Ghw7d87K/SwdvRTYgko2dcPLz0sKM2FDNffn88LlRLjdh0gtNu5E/zWUGq6BU/FyfLCrvUpW4lGk0oAc1fm0Sd1kaW7vHPT9uNHyyRIHCl7/RtIGbYGgjQYr9oH4d4rAmctfmAto/xMmP2BNV3YAAq60HUnUT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39830400003)(136003)(396003)(451199021)(66899021)(36756003)(38100700002)(66946007)(5660300002)(2906002)(44832011)(6916009)(4326008)(66476007)(86362001)(66556008)(41300700001)(8936002)(6486002)(966005)(83380400001)(2616005)(6666004)(186003)(26005)(6506007)(6512007)(478600001)(316002)(518554002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmtkEVUVTPT73/NtAYFDNamPTRejSGZykNB5TrxtyH2i5Mlyd7YtTkE1Z5EW?=
 =?us-ascii?Q?d7ysSPc0h6j4C+2P2TN2xjvJ5iH3dPW2XTeSwR6tUW1+LzC1tNnKG7iUSq2l?=
 =?us-ascii?Q?rTu04wx8NFI4p9WqykbHypA9SzF1plR55WuJK+GIetNE3hbjRPNEDRlMvIjx?=
 =?us-ascii?Q?lcQKOSK3+ZJrCIigjoyig7YvDnJM3jiGSyQvr8nNRe5/0o8SS+qf7yCc08sV?=
 =?us-ascii?Q?yH9HoKRwNlRg3OyfAPdqilYZx4V5I2rKbRvitcO9A93qcM0WKAKt1YnihDX0?=
 =?us-ascii?Q?ERXCGkkxPs3ZtrFST2e7p/UrHWUhicGUPVTKF1AHgf3cKcYo+4ctvKoyL8/0?=
 =?us-ascii?Q?m1k0NLPuA+bmreqRyoaWlgKR6A+s+nPAK5syHTvFWCbKk873WvpOer5Ylw8W?=
 =?us-ascii?Q?eQ0dEJVPkuYdlUIRJZQdCy6ybyquSG/iN9jZItgg88yIETIZxaixIoGEvEr5?=
 =?us-ascii?Q?3RWpvAFCFDobNdJZcb+EScU3h8f3qK9eJC6QoaUeSk6cUOBVUjlwspEXJ6PA?=
 =?us-ascii?Q?eLfrL0l0tt9UT7wRxnp+rkOCqZww+fYQs2kQmjVe6qlMthpAC/P0vb8XkEl5?=
 =?us-ascii?Q?zWiD+GKmj65UHNAqHqZiSkAvHsLeCt4s1eGxXuRNj/41niV7xADZhE4lzUy6?=
 =?us-ascii?Q?LICpWPf6H28rzhxFrg9b1NWBQ9FvYnRflDhfZY7DJGC96gGllQVLj/D1ROYZ?=
 =?us-ascii?Q?CwS1p/0yPiPZJRLuwGm1cU4Xc+sW0AbnYvxgZwgBSZz/p71dH+8qwNJvazjR?=
 =?us-ascii?Q?Kail285TKe8RaIXIUSjlx3Y8EBmBTyiKCq8jrOHcVg5RCbEZRZu+lXUoialD?=
 =?us-ascii?Q?r7905hr7zbTCLwF9Psj+Q4E3qANrGzpwwmdblC/NLCFFAf117HK/3bFTVDN0?=
 =?us-ascii?Q?ByGq8Rr0HXBYP1bvgQla7cEGE2L4IE7/DjV1maqr2IYAViXhB7+hqfqVVuvV?=
 =?us-ascii?Q?HYCRWvsmcBF5d8fvpe9oHoRGvgf2Cdome95QskjcGNlaTkwCPqyLYT8FMkMF?=
 =?us-ascii?Q?ziOjzl5JS2yfsmtz6pi3XvS3b4/u0PEP/DfmqERVssJxsLKG29opm8uus+K7?=
 =?us-ascii?Q?KWx206P3llI9+l4U5uDLDFVtkVME10OqSzSwlkY45KFXdnUP1PGKuZvvFoYo?=
 =?us-ascii?Q?2El4KVzqEI2iDjBRaGH0Fiu2VtzMUd4b6YRlaK4uABn0F7e3fmHrI6Qa7a5M?=
 =?us-ascii?Q?L5gRn7TaZuN6LraTgyvYiso+fYqyr1O6+hhrXyZSdOWsoZNuYbexaYl5SAb/?=
 =?us-ascii?Q?uYnjGiW517k363Bwx3Ut20ht2F5ZZuj91ZfRWi+z0nq5/FO2ZhveLmoTtJeZ?=
 =?us-ascii?Q?cTarB0/PoYJhijUy6tB1hBLOM86UbJxTFTAfFwlUxAYeG6Vm9yr0q/Ax67v/?=
 =?us-ascii?Q?npp2NbnPuQES1tFVoaThDyeEeCoTbfzY0EFxXvqCr4JUpjGE6bcsJFDNq/Dx?=
 =?us-ascii?Q?yw0mkjKAp8S5Jn+Z+9R4RBzNuLJoKsR9Rl1H/09SD0I+3n0+TaG/qrzuh3d2?=
 =?us-ascii?Q?/Xzq9DkXt8Y4JWemP1lEfLDB95hWGnwK0Sfgpn/SdFlQbIxkpgb5dO2XPnRA?=
 =?us-ascii?Q?VRCgh6pNj2ruKLzukG0j3dJO1VCW7CnVgZ5phq90RNXfEQjFxFrW8k35mNEj?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28509d80-363e-4d31-8738-08db37c5078e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 00:05:58.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKOyCHu8UiwyzkIJgIDkpcPUHJOk5PwjITlsEeT5AxHtjqtqXX4lhN7XUN6p1ucXjXZ2OoAQaKmbnYdxAMBoJePuIZksabw/8gFLy4eKm6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4554
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 07, 2023 at 04:05:31PM -0500, Dragan Stancevic wrote:
> Hi folks-
> 
> if it's not too late for the schedule...
> 
> I am starting to tackle VM live migration and hypervisor clustering over
> switched CXL memory[1][2], intended for cloud virtualization types of loads.
> 
> I'd be interested in doing a small BoF session with some slides and get into
> a discussion/brainstorming with other people that deal with VM/LM cloud
> loads. Among other things to discuss would be page migrations over switched
> CXL memory, shared in-memory ABI to allow VM hand-off between hypervisors,
> etc...
> 
> A few of us discussed some of this under the ZONE_XMEM thread, but I figured
> it might be better to start a separate thread.
> 
> If there is interested, thank you.
> 
> 
> [1]. High-level overview available at http://nil-migration.org/
> [2]. Based on CXL spec 3.0
> 
> --
> Peace can only come as a natural consequence
> of universal enlightenment -Dr. Nikola Tesla

I've been chatting about this with folks offline, figure i'll toss my
thoughts on the issue here.


Some things to consider:


1. If secure-compute is being used, then this mechanism won't work as
   pages will be pinned, and therefore not movable and excluded from
   using cxl memory at all.

   This issue does not exist with traditional live migration, because
   typically some kind of copy is used from one virtual space to another
   (i.e. RMDA), so pages aren't really migrated in the kernel memory
   block/numa node sense.


2. During the migration process, the memory needs to be forced not to be
   migrated to another node by other means (tiering software, swap,
   etc).  The obvious way of doing this would be to migrate and
   temporarily pin the page... but going back to problem #1 we see that
   ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
   troublesome.


3. This is changing the semantics of migration from a virtual memory
   movement to a physical memory movement.  Typically you would expect
   the RDMA process for live migration to work something like...

   a) migration request arrives
   b) source host informs destination host of size requirements
   c) destination host allocations memory and passes a Virtual Address
      back to source host
   d) source host initates an RDMA from HostA-VA to HostB-VA
   e) CPU task is migrated

   Importantly, the allocation of memory by Host B handles the important
   step of creating HVA->HPA mappings, and the Extended/Nested Page
   Tables can simply be flushed and re-created after the VM is fully
   migrated.

   to long didn't read: live migration is a virtual address operation,
   and node-migration is a PHYSICAL address operation, the virtual
   addresses remain the same.

   This is problematic, as it's changing the underlying semantics of the
   migration operation.



Problem #1 and #2 are head-scratchers, but maybe solvable.

Problem #3 is the meat and potatos of the issue in my opinion. So lets
consider that a little more closely.

Generically: NIL Migration is basically a pass by reference operation.

The reference in this case is... the page tables.  You need to know how
to interpret the data in the CXL memory region on the remote host, and
that's a "relative page table translation" (to coin a phrase? I'm not
sure how to best describe it).

That's... complicated to say the least.
1) Pages on the physical hardware do not need to be contiguous
2) The CFMW on source and target host do not need to be mapped at the
   same place
3) There's not pre-allocation in these charts, and migration isn't
   targeted, so having the source-host "expertly place" the data isn't
   possible (right now, i suppose you could make kernel extensions).
4) Similar to problem #2 above, even with a pre-allocate added in, you
   would need to ensure those mappings were pinned during migration,
   lest the target host end up swapping a page or something.



An Option:  Make pages physically contiguous on migration to CXL

In this case, you don't necessarily care about the Host Virtual
Addresses, what you actually care about are the structure of the pages
in memory (are they physically contiguous? or do you need to
reconstruct the contiguity by inspecting the page tables?).

If a migration API were capable of reserving large swaths of contiguous
CXL memory, you could discard individual page information and instead
send page range information, reconstructing the virtual-physical
mappings this way.



That's about as far as I've thought about it so far.  Feel free to rip
it apart! :]

~Gregory
