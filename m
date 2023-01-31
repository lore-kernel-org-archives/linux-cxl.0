Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F7C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 23:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAaXuW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaXuW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 18:50:22 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E319F06
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 15:50:16 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230131235013usoutp026bf0dc6bdf6c7f896b39bbbe1f106e0a~-ibjahxnb1119111191usoutp020;
        Tue, 31 Jan 2023 23:50:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230131235013usoutp026bf0dc6bdf6c7f896b39bbbe1f106e0a~-ibjahxnb1119111191usoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675209013;
        bh=gY0qsT1bVmxL4tUUj7m/HH7pQx9AIsqZYYtmoVr66S0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Q6LRA8oVOr8mBPptPHQ2Z4tdP7IPDYdKKUpA8XylePXcx2nsj/jVaCPFiZk2LMY1z
         gegxiOfQrj6jHzmD30mB/9BgMeiAAt+9eGxSeQOLrvnnP9PRt1do0m7SwETSETaC1K
         8CmsNNdcVTQqxtNiA18/P0WCrGtmggHvrROkJLeQ=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230131235013uscas1p2323045fb6ff8ecaa67fade12eb857e5e~-ibjLejG43165331653uscas1p2S;
        Tue, 31 Jan 2023 23:50:13 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 13.22.49129.539A9D36; Tue,
        31 Jan 2023 18:50:13 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab~-ibi_A8Qq0192701927uscas1p17;
        Tue, 31 Jan 2023 23:50:12 +0000 (GMT)
X-AuditID: cbfec36f-eddff7000001bfe9-9a-63d9a935bf5d
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 97.2A.11346.439A9D36; Tue,
        31 Jan 2023 18:50:12 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 31 Jan 2023 15:50:11 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        31 Jan 2023 15:50:11 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Thread-Topic: [GIT preview] for-6.3/cxl-ram-region
Thread-Index: AQHZNc7Bg2d/IwcCiESkFdXhpiCjqw==
Date:   Tue, 31 Jan 2023 23:50:11 +0000
Message-ID: <20230131235003.GA336751@bgt-140510-bm03>
In-Reply-To: <Y9mhe2xPGRE1/7cC@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <37D597EAAA49EB47B85DA8AC82D256D8@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djX87qmK28mG6xrYreYPvUCo8Xqm2sY
        LRqaHrFYrFp4jc3i/KxTLBa3JhxjcmDzaDnyltVj8Z6XTB4bP/5n95g6u97j8ya5ANYoLpuU
        1JzMstQifbsEroyOm3NZCqbFVhz/sZqtgXGDdxcjJ4eEgInE74/vWLsYuTiEBFYySrw/swjK
        aWWSWHTmHQtM1dVb/9khEmsZJa7d74ByPjFKPGqbwQjhLGOUeDl1BVgLm4CixL6u7WxdjBwc
        IgJ6Eh//e4LUMAtsZJK4MekDG0iNsIChxJbGq8wgtoiAkcTL/88ZYeoP/k8HCbMIqEo0bF7L
        CGLzCphKtFzfBVbOKaAjsXrbTLBVjAJiEt9PrWECsZkFxCVuPZnPBHG1oMSi2XuYIWwxiX+7
        HrJB2IoS97+/ZIeo15O4MXUKG4RtJ9G7dAojhK0tsWzha2aIvYISJ2c+gYaEpMTBFTdYQH6R
        ELjCIXF70XWooS4S69ZtgSqSlpi+5jILyC8SAskSqz5yQYRzJOYvgSmxllj4Zz3TBEaVWUjO
        noXkpFlITpqF5KRZSE5awMi6ilG8tLg4Nz212CgvtVyvODG3uDQvXS85P3cTIzAlnf53OH8H
        4/VbH/UOMTJxMB5ilOBgVhLhVeS6mSzEm5JYWZValB9fVJqTWnyIUZqDRUmc19D2ZLKQQHpi
        SWp2ampBahFMlomDU6qBqZ3DfduLNe9fnvXyOL+mInzT9JO6nBo768sEn8Xf7OyT7Or++37i
        rPkLcu8FmPWmCnewWvzbqeZ6d9b7iKLeRd1sDjz1aZ6BN86EiXip379RFCy3NXUB270djm9O
        mTxTsRB4rTN/6zqmheZro1vc8vzTL//8uUo8pmIz1yetz30KoeH6VRofu/7rhVzX//57Tojh
        CimvwvmaIf/2FFWePcctGXDsEndQQ5r72XhG7cP7A2u2TOr3s1c8PjVCRuVVwm6HJtEpCyRE
        PTM5LkWXikxmZIsSeTo5LSr5R2Gf66/ol6tvnVtn/2ux6k47Ie5zjAyT9rW6PyibarSBge/z
        c+NnMjMfK686cvpib98EJZbijERDLeai4kQAMtBNCLgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWS2cA0Sddk5c1kgwOrTSymT73AaLH65hpG
        i4amRywWqxZeY7M4P+sUi8WtCceYHNg8Wo68ZfVYvOclk8fGj//ZPabOrvf4vEkugDWKyyYl
        NSezLLVI3y6BK6Pj5lyWgmmxFcd/rGZrYNzg3cXIySEhYCJx9dZ/9i5GLg4hgdWMEvvuX2eB
        cD4xSqxZ+ZANwlnGKNF09g4bSAubgKLEvq7tQDYHh4iAnsTH/54gNcwCG5kkbkz6AFYjLGAo
        saXxKjOILSJgJPHy/3NGmPqD/9NBwiwCqhINm9cygti8AqYSLdd3MUPsesYs8bT9GFgvp4CO
        xOptM1lAbEYBMYnvp9YwgdjMAuISt57MZ4J4QUBiyZ7zzBC2qMTLx/9YIWxFifvfX7JD1OtJ
        3Jg6hQ3CtpPoXTqFEcLWlli28DUzxBGCEidnPmGB6JWUOLjiBssERolZSNbNQjJqFpJRs5CM
        moVk1AJG1lWM4qXFxbnpFcXGeanlesWJucWleel6yfm5mxiBEX363+GYHYz3bn3UO8TIxMF4
        iFGCg1lJhFeR62ayEG9KYmVValF+fFFpTmrxIUZpDhYlcV6P2InxQgLpiSWp2ampBalFMFkm
        Dk6pBqZEM+a9ZZWKjx9li6y+/kNpk4x818PHWx5pfzFfuLAmKmrWJiXlsCf2xX7vVh+u2MjY
        PSVDVWK/5tyFhR+rH7yKuGszo6l8vn/RvguCU910rK88iQzq2ml7upy5unll5qnt6VtV05sl
        5Fb+KH8p7ff8psXzC1pZPy8JsLe1V984b/ko7za7o5LpFg6u8IC/j5UULoso/DOWenZ57Zcl
        2+60VXE21Mq2bi/eVZDYIhzy45fSm32vP6zekViV9n2N/fUyX0vlHS0BIaVPBWpiZV7M97D6
        7fRwXdZcd9ObswUOfv3gtmGv39ROQ+Fru971nuR0/jH1gq2G+BuuewdfR7GetHMLDQzMzo35
        OOtN6F4lluKMREMt5qLiRADMm0IBVwMAAA==
X-CMS-MailID: 20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab
CMS-TYPE: 301P
X-CMS-RootMailID: 20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab
References: <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
        <Y9gva49IPFOXYlkH@memverge.com>
        <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
        <Y9h2VhGuraZfEJfD@memverge.com>
        <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
        <Y9ll5S3Y4BZkakNn@memverge.com>
        <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
        <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
        <Y9meWfDiCGbca4nP@memverge.com> <Y9mhe2xPGRE1/7cC@memverge.com>
        <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 31, 2023 at 06:17:15PM -0500, Gregory Price wrote:
> On Tue, Jan 31, 2023 at 06:03:53PM -0500, Gregory Price wrote:
> > On Tue, Jan 31, 2023 at 08:24:19PM +0000, Verma, Vishal L wrote:
> > > On Tue, 2023-01-31 at 19:46 +0000, Verma, Vishal L wrote:
> > > > On Tue, 2023-01-31 at 14:03 -0500, Gregory Price wrote:
> > > > >=20
> > > > >=20
> > > > > Right now I believe this is failing due to the interleave and siz=
e not
> > > > > having default values
> > > > >=20
> > > > > ./cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
> > > > > cxl region: create_region: create_region: unable to determine reg=
ion size
> > > > > cxl region: cmd_create_region: created 0 regions
> > > > >=20
> > > > >=20
> > > > > appears to be due to this code
> > > > > static int create_region(struct cxl_ctx *ctx, int *count,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct parsed_params *p)
> > > > > {
> > > > > // ... snip ...
> > > > > =A0=A0=A0 rc =3D create_region_validate_config(ctx, p);
> > > > > =A0=A0=A0 if (rc)
> > > > > =A0=A0=A0=A0=A0=A0=A0 return rc;
> > > > >=20
> > > > > =A0=A0=A0 if (p->size) {
> > > > > =A0=A0=A0=A0=A0=A0=A0 size =3D p->size;
> > > > > =A0=A0=A0=A0=A0=A0=A0 default_size =3D false;
> > > > > =A0=A0=A0 } else if (p->ep_min_size) {
> > > > > =A0=A0=A0=A0=A0=A0=A0 size =3D p->ep_min_size * p->ways;
> > > > > **=A0=A0=A0 } else {
> > > > > **=A0=A0=A0=A0=A0=A0=A0 log_err(&rl, "%s: unable to determine reg=
ion size\n", __func__);
> > > > > **=A0=A0=A0=A0=A0=A0=A0 return -ENXIO;
> > > > > **=A0=A0=A0 }
> > > > >=20
> > > > > So both size and ep_min_size are 0 here
> > > > >=20
> > > > > echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
> > > > > cat /sys/bus/cxl/devices/region0/interleave_ways
> > > > > 0
> > > > > cat /sys/bus/cxl/devices/region0/interleave_granularity
> > > > > 0
> > > > > cat /sys/bus/cxl/devices/region0/size
> > > > > 0
> > > >=20
> > > > Ah - this revealed an actual bug in these commits - the size and
> > > > ep_min_size don't refer to the region's size, it is the capacity of=
 the
> > > > component memdevs. Right after create_ram_region, the region size i=
s
> > > > expected to be zero.
> > > >=20
> > > > However the bug here was a pmem assumption I had missed. When
> > > > determining sizes, we only look at pmem capacity, which is wrong. I=
t
> > > > happened to work in my testing because the memdevs I used had both =
pmem
> > > > and ram capacity. I'll update with a fix shortly. Thanks for trying=
 it
> > > > out and reporting this!
> > >=20
> > > I've updated the branch now with a fix for this.
> >=20
> > Progress! But now i've found a kernel segfault :D
> > (sorry about the jumble here, looks like multiple issues))
> >=20
> > [root@fedora cxl]# ./cxl create-region -m -t ram -d decoder0.0 -w 1 -g =
4096 mem0
> > [  170.675334] cxl_region region0: Failed to synchronize CPU cache stat=
e
> > libcxl: [c x l1_7r0e.68249g6i] BUG: kernel NULL pointer dereference, ad=
dress: 0000000000000000
> > [  170.691163] #PF: supervisor instruction fetch in kernel mode
> > [o n 1_70.70e3n9a1b6l]e :# rPeF: error_code(0gixo0010) - not-present pa=
ge
> > n0[:  fai led1 7to 0e.7n19709] PGD 800000004d25d067 P4D 800000004d25d06=
7 PUD 4cdf3067 PMD 0
> > [  170.725436] Oops: 0010 [#1] PREEMPT SMP PTI
> > 1b[l e
> > 7c0x.l734 510r]e giConPU: 0 PID: 717 Comm: cxl Not tainted 6.2.0-rc2+ #=
19
> > [  170.739750] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> > :[  170.747119] R IP: 0c0r1e0:at0ex_0r
> > egi[o n: 170.751110] Code: Unable to access opcode bytes at 0xfffffffff=
fffffd6.
> > [  170.757699] RSP: 0018:ffffb9a3c0e97c60 EFLAGS: 00010296
> > [   17r0e.g7ion0:6 f6a0i9l1e]d RAX: 0000000000000000 RBX: ffff9c38e459d=
e60 RCX: 0000000000000000
> > [  170.772499] RDX: 0000000000000000 RSI: ffff9c38e42ecdb0 RDI: ffff9c3=
90f11d400
> >  [  t170o.77 8e3nab0l0e] RBP: fff:f 9Nco3 8seed38000 R08: 0000000000000=
001 R09: ffffb9a3c0e97b38
> > [  170.783787] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c3=
93d8c8c00
> > uch d[ev i 1ce7 0o.7r8 800a9]d R13: ffff9c390f141c00 R14: ffff9c38eed38=
340 R15: ffff9c38c1a01400
> > dr[e  s1s7
> > 0.795938] FS:  00007ff89ca037c0(0000) GS:ffff9c393dc00000(0000) knlGS:0=
000000000000000
> > [  170.802891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  170.806705] CR2: ffffffffffffffd6 CR3: 0000000024c8e000 CR4: 0000000=
0000006f0
> > [  170.817025] Call Trace:
> > [  170.818831]  <TASK>
> > [  170.820589]  cxl_region_decode_reset+0xb8/0x110
> > [  170.823893]  cxl_region_detach+0xda/0x1e0
> > [  170.829457]  detach_target.part.0+0x29/0x80
> > [  170.833503]  unregister_region+0x42/0x90
> > [  170.836813]  devm_release_action+0x3d/0x70
> > [  170.840128]  ? __pfx_unregister_region+0x10/0x10
> > [  170.843899]  delete_region_store+0x69/0x80
> > [  170.847680]  kernfs_fop_write_iter+0x11e/0x200
> > [  170.851217]  vfs_write+0x222/0x3e0
> > [  170.854141]  ksys_write+0x5b/0xd0
> > [  170.856695]  do_syscall_64+0x5b/0x80
> > [  170.859678]  ? kmem_cache_free+0x15/0x3b0
> > [  170.862234]  ? do_sys_openat2+0x77/0x150
> > [  170.865560]  ? syscall_exit_to_user_mode+0x17/0x40
> > [  170.870920]  ? do_syscall_64+0x67/0x80
> > [  170.874726]  ? syscall_exit_to_user_mode+0x17/0x40
> > [  170.879464]  ? do_syscall_64+0x67/0x80
> > [  170.881634]  ? __irq_exit_rcu+0x3d/0x140
> > [  170.884720]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [  170.888810] RIP: 0033:0x7ff89c901c37
> > [  170.891435] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f=
 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 4[=
  170.905803] RSP: 002b:00007fff0e843a68 EFLAGS: 00000246 ORIG_RAX: 0000000=
000000001
> > [  170.913373] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff=
89c901c37
> > [  170.920868] RDX: 0000000000000008 RSI: 0000000001290ee6 RDI: 0000000=
000000003
> > [  170.931402] RBP: 00007fff0e843aa0 R08: 000000000000fee0 R09: 0000000=
000000073
> > [  170.936639] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
000000000
> > [  170.942484] R13: 00007fff0e844000 R14: 000000000041fdc8 R15: 00007ff=
89cbdf000
> > [  170.954794]  </TASK>
> > [  170.957649] Modules linked in: rfkill vfat fat snd_pcm iTCO_wdt snd_=
timer intel_pmc_bxt ppdev iTCO_vendor_support snd cxl_pmem soundcore bochg[=
  170.980623] CR2: 0000000000000000
> > [  170.984137] ---[ end trace 0000000000000000 ]---
> > [  170.989062] RIP: 0010:0x0
> > [  170.991505] Code: Unable to access opcode bytes at 0xffffffffffffffd=
6.
> > [  170.996401] RSP: 0018:ffffb9a3c0e97c60 EFLAGS: 00010296
> > [  170.999716] RAX: 0000000000000000 RBX: ffff9c38e459de60 RCX: 0000000=
000000000
> > [  171.006146] RDX: 0000000000000000 RSI: ffff9c38e42ecdb0 RDI: ffff9c3=
90f11d400
> > [  171.018226] RBP: ffff9c38eed38000 R08: 0000000000000001 R09: ffffb9a=
3c0e97b38
> > [  171.024812] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c3=
93d8c8c00
> > [  171.036512] R13: ffff9c390f141c00 R14: ffff9c38eed38340 R15: ffff9c3=
8c1a01400
> > [  171.042400] FS:  00007ff89ca037c0(0000) GS:ffff9c393dc00000(0000) kn=
lGS:0000000000000000
> > [  171.050182] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  171.055740] CR2: ffffffffffffffd6 CR3: 0000000024c8e000 CR4: 0000000=
0000006f0
> > Killed
>=20
>=20
> Looks like some error is still occuring, this happens when attempting to
> delete a region after it has been configured
>=20
> [root@fedora ~]# echo region0 > /sys/bus/cxl/devices/decoder0.0/delete_re=
gion
> [   97.186328] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [   97.190754] #PF: supervisor instruction fetch in kernel mode
> [   97.196754] #PF: error_code(0x0010) - not-present page
> [   97.201108] PGD 0 P4D 0
> [   97.202585] Oops: 0010 [#1] PREEMPT SMP PTI
> [   97.206085] CPU: 1 PID: 688 Comm: bash Not tainted 6.2.0-rc2+ #19
> [   97.215215] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> [   97.224247] RIP: 0010:0x0
> [   97.228516] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   97.233852] RSP: 0018:ffffa30000d23d20 EFLAGS: 00010292
> [   97.236704] RAX: 0000000000000000 RBX: ffff8a2fe44fb120 RCX: 000000000=
0000000
> [   97.242904] RDX: 0000000000000000 RSI: ffff8a2fc2c5f6c0 RDI: ffff8a2fc=
1f29000
> [   97.250537] RBP: ffff8a2fc3395c00 R08: 0000000000000001 R09: ffffa3000=
0d23bf8
> [   97.260478] R10: ffff8a2fc35adc00 R11: 0000000000000000 R12: ffff8a2fc=
1272000
> [   97.276617] R13: ffff8a2fc3329c00 R14: ffff8a2fc3395f40 R15: ffff8a2fc=
1f29800
> [   97.285277] FS:  00007f195be24740(0000) GS:ffff8a303dc80000(0000) knlG=
S:0000000000000000
> [   97.295175] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   97.300566] CR2: ffffffffffffffd6 CR3: 00000000249e6000 CR4: 000000000=
00006e0
> [   97.308856] Call Trace:
> [   97.312137]  <TASK>
> [   97.314095]  cxl_region_decode_reset+0xb8/0x110
> [   97.317937]  cxl_region_detach+0xda/0x1e0
> [   97.320694]  detach_target.part.0+0x29/0x80
> [   97.326437]  unregister_region+0x42/0x90
> [   97.331169]  devm_release_action+0x3d/0x70
> [   97.334957]  ? __pfx_unregister_region+0x10/0x10
> [   97.338434]  delete_region_store+0x69/0x80
> [   97.343526]  kernfs_fop_write_iter+0x11e/0x200
> [   97.348950]  vfs_write+0x222/0x3e0
> [   97.352273]  ksys_write+0x5b/0xd0
> [   97.354592]  do_syscall_64+0x5b/0x80
> [   97.358291]  ? exc_page_fault+0x70/0x170
> [   97.362739]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   97.367268] RIP: 0033:0x7f195bd01c37
> [   97.369719] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1=
f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 4
> [   97.386808] RSP: 002b:00007fff8a2320d8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
> [   97.394208] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f195=
bd01c37
> [   97.401547] RDX: 0000000000000008 RSI: 0000555fd741b550 RDI: 000000000=
0000001
> [   97.409231] RBP: 0000555fd741b550 R08: 0000000000001000 R09: 000000000=
0000000
> [   97.416149] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000008
> [   97.420784] R13: 00007f195bdf9780 R14: 0000000000000008 R15: 00007f195=
bdf49e0
> [   97.429142]  </TASK>
> [   97.431741] Modules linked in: rfkill vfat fat snd_pcm snd_timer iTCO_=
wdt snd intel_pmc_bxt iTCO_vendor_support ppdev cxl_pmem soundcore libng
> [   97.456189] CR2: 0000000000000000
> [   97.461271] ---[ end trace 0000000000000000 ]---
> [   97.466464] RIP: 0010:0x0
> [   97.468599] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   97.476231] RSP: 0018:ffffa30000d23d20 EFLAGS: 00010292
> [   97.482910] RAX: 0000000000000000 RBX: ffff8a2fe44fb120 RCX: 000000000=
0000000
> [   97.488445] RDX: 0000000000000000 RSI: ffff8a2fc2c5f6c0 RDI: ffff8a2fc=
1f29000
> [   97.496227] RBP: ffff8a2fc3395c00 R08: 0000000000000001 R09: ffffa3000=
0d23bf8
> [   97.502543] R10: ffff8a2fc35adc00 R11: 0000000000000000 R12: ffff8a2fc=
1272000
> [   97.512213] R13: ffff8a2fc3329c00 R14: ffff8a2fc3395f40 R15: ffff8a2fc=
1f29800
> [   97.518303] FS:  00007f195be24740(0000) GS:ffff8a303dc80000(0000) knlG=
S:0000000000000000
> [   97.526884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   97.533142] CR2: ffffffffffffffd6 CR3: 00000000249e6000 CR4: 000000000=
00006e0
>=20
Are you using single root port configuration? If yes, the following
patch should have fixed the issue,
https://lore.kernel.org/linux-cxl/20221215170909.2650271-1-fan.ni@samsung.c=
om/

> [   97.476231] RSP: 0018:ffffa30000d23d20 EFLAGS: 00010292               =
     =
