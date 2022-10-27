Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CBCFA3740
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Oct 2022 18:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiJ0SKg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiJ0SKd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Oct 2022 14:10:33 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A4D2CC
        for <linux-cxl@vger.kernel.org>; Thu, 27 Oct 2022 11:10:28 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221027181024usoutp02cce04495bbfba2e17cbcbf286c15c77c~h-3dAoqHb2200222002usoutp02C;
        Thu, 27 Oct 2022 18:10:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221027181024usoutp02cce04495bbfba2e17cbcbf286c15c77c~h-3dAoqHb2200222002usoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666894224;
        bh=4cEBsY7P/n7f7rqafPlpfb6vFTUeosTvgkB/Fs62bDM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qUSKnXrwXMQ3GBozfA187HpUplo85+jfZffedTQQ6TwjkJzcHPQJkccswEcsbxd+Y
         q0YRI2mm//M2PO5MG2N2169BMe2Mu03ifUURjfeak37/+e+SWJgdXgAqh8W6hSt4nd
         i7O/z6EyZYxv/VZIxDtcUqHXpZTn5Wn5Vt62Kzt4=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221027181024uscas1p1a24f43734521ff9f237b1bb2617343d1~h-3crzXw92972729727uscas1p1a;
        Thu, 27 Oct 2022 18:10:24 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id D6.A5.65516.099CA536; Thu,
        27 Oct 2022 14:10:24 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221027181023uscas1p1216cd5d4492751caa92c1bf8f8f7a95d~h-3cPXw7t2970929709uscas1p1y;
        Thu, 27 Oct 2022 18:10:23 +0000 (GMT)
X-AuditID: cbfec36d-59dff7000000ffec-9f-635ac990712f
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id D9.A1.32876.F89CA536; Thu,
        27 Oct 2022 14:10:23 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 27 Oct 2022 11:10:23 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Thu,
        27 Oct 2022 11:10:23 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for CXL
 Type-3 Devices
Thread-Topic: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for
        CXL Type-3 Devices
Thread-Index: AQHY6NSuNZ2oFYZywUOITvc1nl0Cqa4hknmAgAAJfACAAO3vAIAAeImA
Date:   Thu, 27 Oct 2022 18:10:23 +0000
Message-ID: <20221027181014.GA317461@bgt-140510-bm01>
In-Reply-To: <20221027115854.00001f76@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2C312128442F74D97A7E362CE5FCC5A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7djXc7oTTkYlG/yeI2Jx9/EFNosd5+4x
        WTRPXsxo0X1+A6PF9KkXGC1W31zDaPHiz3Mmi4amRywWLbvfM1mcPtrBbLH/6XMWi1ULr7FZ
        nJ91isXiZfsJZov/v16xWhzv3cHiIODxvf89u8eFyRNYPRY3uHrsnHWX3aPlyFsgb89LJo9N
        qzrZPDZ+/M/u8eTaZiaP9/uusnlMnV3v8XmTXABPFJdNSmpOZllqkb5dAlfGtqarrAUrXCsO
        T73N1MC4xqyLkZNDQsBEYveMjYxdjFwcQgIrGSV2z7sD5bQySZyf85AdpurT+kesEIm1jBLH
        /vVAOZ8YJT6/uM4O4SxjlFh9dD8zSAubgIHE7+MbwWwRASOJdzcmMYLYzAKPWCVuPCwGsYUF
        YiXeXN/CAlETJ3H6ywR2CNtN4sKXaWD1LAKqEpd6toHV8AqYShw5MgHM5hQwlLg1YyqYzSgg
        JvH91BomiPniEreezGeCOFtQYtHsPcwQtpjEv10P2SBsRYn731+yQ9TrSCzY/YkNwraT2H4P
        Jq4tsWzha2aIvYISJ2c+YYHolZQ4uOIGC8jDEgKnOCU+dj9hhUi4SPy5dwVqgbTE9DWXoYra
        GSU+TNjHCuFMYJS48/YnVJW1xL/Oa+wTGFVmIbl8FpKrZiG5ahaSq2YhuWoBI+sqRvHS4uLc
        9NRiw7zUcr3ixNzi0rx0veT83E2MwBR6+t/h3B2MO2591DvEyMTBeIhRgoNZSYT37I3wZCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8UTO0koUE0hNLUrNTUwtSi2CyTBycUg1MO7ZI7C08YsMS
        eeuLwdQKJZM9GozOTMs9V93q6Qvetak4PXFCqONztU8F2cfsp2h6H3tYwFV3bnVE/173m/e7
        jk9/7mly8lPYLT3fFz3Xg+ZEhL+8Mlf7qoHQit13GttX8GvZH/wcWJFoduAE86Vtv1KkBd/N
        FOpdq9myLryhYtHKhmr+XJua+rkup8pY9DgZCvh7s2OjJNe7vFj4YvZLRaZFX52NoiTEbQtW
        rVBLqKvlmi9/2jfueLDrLSYjmSs8vzU77Oob2+oZL4uaT3j/ldHr8vr63eKbgh42L4hVuix7
        YJWD+aJ6C8UDH35V35KM/6D4v4BFhpnjx6cNFsWHUyYGTCqZeu2YuI0gv4oSS3FGoqEWc1Fx
        IgCMbjEwEAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWS2cA0Ubf/ZFSywZ2XBhZ3H19gs9hx7h6T
        RfPkxYwW3ec3MFpMn3qB0WL1zTWMFi/+PGeyaGh6xGLRsvs9k8Xpox3MFvufPmexWLXwGpvF
        +VmnWCxetp9gtvj/6xWrxfHeHSwOAh7f+9+ze1yYPIHVY3GDq8fOWXfZPVqOvAXy9rxk8ti0
        qpPNY+PH/+weT65tZvJ4v+8qm8fU2fUenzfJBfBEcdmkpOZklqUW6dslcGVsa7rKWrDCteLw
        1NtMDYxrzLoYOTkkBEwkPq1/xApiCwmsZpT40pvRxcgFZH9ilPi//CgbhLOMUWJS9zEWkCo2
        AQOJ38c3MoPYIgJGEu9uTGIEKWIWeMAqMXP+V7CEsECsxJvrW1ggiuIk+p7dZ4Ww3SQufJnG
        CGKzCKhKXOrZBlbDK2AqceTIBBaIba1MEq/fbwIr4hQwlLg1YypYEaOAmMT3U2uYQGxmAXGJ
        W0/mM0H8ICCxZM95ZghbVOLl43+sELaixP3vL9kh6nUkFuz+xAZh20lsvwcT15ZYtvA1M8QR
        ghInZz5hgeiVlDi44gbLBEaJWUjWzUIyahaSUbOQjJqFZNQCRtZVjOKlxcW56RXFxnmp5XrF
        ibnFpXnpesn5uZsYgann9L/DMTsY7936qHeIkYmD8RCjBAezkgjv2RvhyUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5PWInxgsJpCeWpGanphakFsFkmTg4pRqYAtxmRs/Trj+4y/Ok7vdktm0J
        YqEsxXl++z3fMaz56WdjrXNmgd0uy6KUi+oSypMXPNBLWVTw0Pj3C/eNHuHHV0X2FW+Ypvdj
        1s/LwTXTmdm6SpNE30uqsrkqvV0pd+mYQ1XLizWbp4Rp7VqS46b+/P5al6iqjhkTF5UJm62c
        KtEutfDwk90vtmcETjfdKnuyMPorW8093aYzJw2Ufy5NlDaUumD6qe1u8ZlWx+39NXEy7KyT
        uSd9uqGns5vvlHuQl6Tuv7T9M+s7OXevbBfWqXHZpLJw2iyho9cbXxxPv7c3ZV9Mr9Wf/LXd
        5/QtjoUf+ufgv/rv9GjBXL5FlgeiZbf9n824/I6tfo9fUt81JZbijERDLeai4kQAZklQv6wD
        AAA=
X-CMS-MailID: 20221027181023uscas1p1216cd5d4492751caa92c1bf8f8f7a95d
CMS-TYPE: 301P
X-CMS-RootMailID: 20221026004835uscas1p1d37255ba8daaba8fc7e16e5129cb94b5
References: <CGME20221026004835uscas1p1d37255ba8daaba8fc7e16e5129cb94b5@uscas1p1.samsung.com>
        <20221026004737.3646-1-gregory.price@memverge.com>
        <20221026201318.GA308524@bgt-140510-bm01> <Y1mc1mvxsGS+7JBp@memverge.com>
        <20221027115854.00001f76@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 27, 2022 at 11:58:54AM +0100, Jonathan Cameron wrote:
> On Wed, 26 Oct 2022 16:47:18 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
>=20
> > On Wed, Oct 26, 2022 at 08:13:24PM +0000, Adam Manzanares wrote:
> > > On Tue, Oct 25, 2022 at 08:47:33PM -0400, Gregory Price wrote: =20
> > > > Submitted as an extention to the multi-feature branch maintained
> > > > by Jonathan Cameron at:
> > > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cx=
l-2022-10-24__;!!EwVzqGoTKBqv-0DWAJBm!RyiGL5B1XmQnVFwgxikKJeosPMKtoO1cTr61g=
Iq8fwqfju8l4cbGZGwAEkKXIJB-Dbkfi_LNN2rGCbzMISz65cTxpAxI9pQ$  =20
> > > >=20
> > > >=20
> > > > Summary of Changes:
> > > > 1) E820 CFMW Bug fix. =20
> > > > 2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
> > > > 3) Multi-Region and Volatile Memory support for CXL Type-3 Devices
> > > > 4) CXL Type-3 SRAT Generation when NUMA node is attached to memdev
>=20
> +CC Dan for a question on status of Generic Ports ACPI code first ECN.
> Given that was done on the mailing list I can find any public tracking
> of whether it was accepted or not - hence whether we can get on with
> implementation.  There hasn't been a release ACPI spec since before
> that was proposed so we need that confirmation of the code first proposal
> being accepted to get things moving.
>=20
> > > >=20
> > > >=20
> > > > Regarding the E820 fix
> > > >   * This bugfix is required for memory regions to work on x86
> > > >   * input from Dan Williams and others suggest that E820 entry for
> > > >     the CFMW should not exist, as it is expected to be dynamically
> > > >     assigned at runtime.  If this entry exists, it instead blocks
> > > >     region creation by nature of the memory region being marked as
> > > >     reserved. =20
> > >=20
> > > For CXL 2.0 it is my understanding that volatile capacity present at =
boot will
> > > be advertised by the firmware. In the absence of EFI I would assume t=
his would
> > > be provided in the e820 map.  =20
>=20
> Whilst this is one option, it is certainly not the case that all CXL 2.0
> platforms will decide to do any setup of CXL memory (volatile or not) in =
the
> firmware.  They can leave it entirely to the OS, so a cold plug flow.
> Early platforms will do the setup in BIOS to support unware OSes, once
> that's not a problem any more the only reason you'd want to do this is if
> you don't have other RAM to boot the system, or for some reason you want
> your host kernel etc in the CXL attached memory.
>=20
> I'd expect to see BIOS having OS managed configuration as an option in th=
e
> intermediate period where some OSes are aware, others not.
> OS knows more about usecase / policy so can make better choices on interl=
eaving
> etc of volatile CXL type 3 memory (let alone the fun corner of devices
> where you can dynamically change the mix of volatile and non volatile
> memory).
>=20
>=20
> >=20
> > The issue in this case is very explicitly that a double-mapping occurs
> > for the same region.  An E820 mapping for RESERVED is set *and* the
> > region driver allocates a CXL CFMW mapping.  As a result the region
> > drive straight up fails to allocate regions.
> >=20
> > So in either case - at least from my view - the entry added as RESERVED
> > is just wrong.
> >=20
> > This is separate from type-3 device SRAT entries and default mappings
> > for volatile regions.  For this situation, if you explicitly assign the
> > memdev backing a type-3 device to a numa node, then an SRAT area is
> > generated and an explicit e820 entry is generated and marked usable -
> > though I think there are likely issues with this kind of
> > double-referencing.
>=20
> SRAT setup for CXL type 3 devices is to my mind is a job for a full BIOS,
> not QEMU level of faking a few things. That BIOS should also
> be doing the full configuration (HDM Decoders and all the rest).  ARM has
> a prototype for one of the fixed virtual platforms that does this (talk
> at Plumbers Uconf), we should look to do the same if we want to test
> those flows using QEMU via appropriate changes in EDK2 to walk topology
> and configure everything.  Until the devices are configured there is no
> way to configure the SLIT, HMAT entries that align with the SRAT ones
> (in theory those can be updated at runtime via _SLI, _HMA but in=20
> practice, I'm fairly sure Linux doesn't support doing that.)
>=20
>=20
> >=20
> > >=20
> > > Is the region driver meant to cover volatile capacity present at boot=
? I was
> > > under the impression that it would be used for hot added volatile mem=
ory. It
> > > would be good to cover all of these assumptions for the e820 fix. =20
> >=20
> > This region appears to cover hotplug memory behind the CFMW.  The
> > problem is that this e820 RESERVED mapping blocks the CFMW region from
> > being used at all.
> >=20
> > Without this, you can't use a type-3 persistent region, even with
> > support, let alone a volatile region.  In attempting to use a persisten=
t
> > region as volatile via ndctl and friends, I'm seeing further issues (it
> > cannot be assigned to a numa node successfully), but that's a separate
> > issue.
> For the Numa node bit...
>=20
> So far, the CDAT table isn't used in Linux (read out for debug purposes
> is supported only).  That all needs to be added yet to get the NUMA node
> allocations to work correctly.  It shouldn't have anything to do with SRA=
T
> unless the BIOS has done the full full configuration (same way CXL will w=
ork
> with a legacy OS).  Come to think of it, that should definitely be on the
> priority list for kernel support (don't think it was on the list on Tuesd=
ay?)
>=20
> >=20
> > >=20
> > > Lastly it is my understanding that the region driver does not have su=
pport for
> > > volatile memory. It would be great to add that functionality if we ma=
ke this
> > > change in QEMU.
> > >  =20
> >=20
> > Right now this is true, but it seems a bit of a chicken/egg scenario.
> > Nothing to test against vs no support.  Nudging this along such that we
> > can at least report an (unusable) hot-add volatile memory region would
> > provide someone working with the region driver something to poke and
> > prod at.
>=20
> Agreed. This is same place as Ben's original CXL QEMU work on non volatil=
e.
> Need something to develop against so we'll at least have QEMU patches
> available whilst the kernel side is in development (hopefully this cycle)
> >=20
> > > > Regarding SRAT Generation for Type-3 Devices
> > > >   * Co-Developed by Davidlohr Bueso.  Built from his base patch and
> > > >     extended to work with both volatile and persistent regions.
> > > >   * This can be used to demonstrate static type-3 device mapping an=
d
> > > >     testing numa-access to type-3 device memory regions. =20
> >=20
> > Regarding "volatile memory present at boot" - there is still two ways
> > for that memory to be onlined: Statically (entered as an explicit e820
> > region after reading the SRAT), or Dynamically (hot-add by the region
> > driver).
> >=20
> > This patch would at least allow an SRAT to be generated if you
> > explicitly add a NUMA node mapping to it.  Although I concede that I'm
> > not entirely sure what is "correct" here.
>=20
> For hotplug, needs to be the region driver, not here (or BIOS if you
> are doing a BIOS driven flow - in which case the whole topology is
> discovered and mostly configured by the BIOS before the OS reaches it
> - including filling in SRAT, SLIT, HMAT etCc).
> >=20
> > What this ends up looking like is mapping a memdev to both a numa node
> > and to a type-3 device.  Though that seems wrong.
> >=20
> > After further testing it seems like creating a CPU-less, Memory-less
> > NUMA node with the intent of mapping volatile memory regions to it is
> > not supported (yet?).
>=20
> Yup, and I doubt it ever will be for reasons above.=20
>=20
> BIOS does it all, or OS does it all.  Mixing and matching is a mess
> (there is an exception - Generic Port entries in SRAT - those we do
> need for the OS driven flow and possibly also the BIOS flow
> - patches welcome! I'd forgotten that on my list of QEMU stuff that
> needs doing.)

Based on the discussions is it safe to say we have settled on an OS driven =
flow
for the current QEMU CXL emulation.=20

>=20
> https://urldefense.com/v3/__https://lore.kernel.org/all/e1a52da9aec90766d=
a5de51b1b839fd95d63a5af.camel@intel.com/__;!!EwVzqGoTKBqv-0DWAJBm!XLqjPd1aX=
t3i5NXrZhakQlGdgJ5o4tcfV_5iUEp8vwBLv8T1Ft1OVHPI0p7KpYSFDYzhAGj_ulMz1LfZVmJg=
rOvrO-_v7udl$ =20
>=20
> If anyone is implementing that, also good to do Generic Initiators
> as they are very similar.
>=20
> Jonathan
> =20
> =
