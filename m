Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F3FC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 20:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiJZUNd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiJZUNa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 16:13:30 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71A2144080
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:13:28 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20221026201326usoutp01523d4d9b798a7d1b425484f42ff98c1f~ht5lxJ9TH2755327553usoutp01L;
        Wed, 26 Oct 2022 20:13:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20221026201326usoutp01523d4d9b798a7d1b425484f42ff98c1f~ht5lxJ9TH2755327553usoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666815206;
        bh=EIo72XlFYpPfvIWTJWWuo8u6hvTQ+fbbae5tP36EaQk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=V1DUYTfVwHltKKRUR/VKj61HrDfU7SGL+Il1hZP4ufvDuWWGkaGHoLCaWcpdfdl1z
         OWs+Qxt6yqq+zD+51NDlz3kx4EfTEIH0PU1KcYEIIYPrGqMc4Nw9Y6xzKB05wHiQ7t
         IQN4dgiFos5N86fsZubmlO5Bku0F7QqE8ueyq4TU=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221026201326uscas1p2c388d250a919f2875df353f4c40a85dd~ht5lYbbXC1255912559uscas1p2M;
        Wed, 26 Oct 2022 20:13:26 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 89.DA.18126.6E499536; Wed,
        26 Oct 2022 16:13:26 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221026201325uscas1p239cee34590a13bc52310e320019914dc~ht5k4KfQh1268812688uscas1p2Y;
        Wed, 26 Oct 2022 20:13:25 +0000 (GMT)
X-AuditID: cbfec36f-fe1ff700000146ce-ae-635994e6efd6
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id C6.E0.36264.5E499536; Wed,
        26 Oct 2022 16:13:25 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 26 Oct 2022 13:13:24 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        26 Oct 2022 13:13:24 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "ani@anisinha.ca" <ani@anisinha.ca>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for CXL
 Type-3 Devices
Thread-Topic: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for
        CXL Type-3 Devices
Thread-Index: AQHY6NSuNZ2oFYZywUOITvc1nl0Cqa4hknmA
Date:   Wed, 26 Oct 2022 20:13:24 +0000
Message-ID: <20221026201318.GA308524@bgt-140510-bm01>
In-Reply-To: <20221026004737.3646-1-gregory.price@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E17196ADAEFADD4E97FC2A2A4AAFB863@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG851rObFy6Ax8wpxZh9MhAjMYj3HTxbnt/GmyZF6m3U7qSUXu
        LejcphBlssp0JWoYBzOpFWbLZdC6po6mZFTKbFWQxQLlorgiFyfITdyAMsrRpP/9njzP+73P
        m3wSVPYCj5akZOTw6gwuTU5QmNU1fXfD4wt7lUn9N5YzvX+3EYztbh/CnDpvAExRax1gqrqq
        ATM0N4gw+ScfYUxBwxjCeJq/R5nGgUGMMem9BNMquDFmuPBPlFn4bwRnWs7asA/C2Zkfx0i2
        7bwOZw35H7E3hF6SLbj5dFHZhxHWbNISbP34Asn6vRaEHXPcJ9iLZXnspPmNXcv2Ue8d5NNS
        jvDqxG1fUofq2ixkVuvbX9UKI2g+GFh1BoRJIJ0Mux7eQ4Iso40ADulVZwC1yN8h8JyrFX8V
        6rt+ExGNGgBHG57gopgAcO7ZD0AUlQA+tzSC4AhBJ8HZlno0yCvoDdCmdRLBEEp7cXjJU4UF
        jdfoA/CfjuuYGFJAz5SOFHkj9NV4lnZj9BoY6L5HBFlKb4Ils76lR8Po7VCocCwxoCPhjLt6
        6QiUjoI+/2VE7B0Br5TZUZEjYeD3fkLkN+GDmWFSzMfD8oYJQuRtsLhiHhN5PazUP0HFvRHw
        VqkfE2dXwj+udWLBYyDdGAZP+y++NHbCAUMXEDkGzvdWImKoEMBnOgcuCh2APU//fVljKwxo
        vaQOxAohzYWQVkJIKyGklRDSqhzgJhCVq9Gkq3jNxgz+aIKGS9fkZqgSlJnpZrD4OT0BZ6YN
        dPjGE5oAIgFNAEpQ+Qrpnc7dSpn0IHfsa16d+YU6N43XNIEYCSaPku77KU4po1VcDp/K81m8
        +pWLSMKi85HX45I8LlK/Lps+bg/nTMXLd2Vyt3Ip42a3fuSa8sLu+rMTls7sUqDfv5IqO+Uq
        nq5aE11yGfmsu32mfe1hQ/y8TU+l2H0lk3fKD8x++tyUSmYpej6pco9ate3J9vWOz8tO1A1s
        mZrcswozProkazaeXt1s/qYbB6M1tZOKdxwK58eRdZHV5Yaiq5aeuAX1L9PG+jzir7dib0cc
        nWsecnm3JJai2rzwnavP7ZgyTKUaduytcJtT2IhkSmrVUi3xtl9/Hty/brairajgZA6tsD6M
        3SSAD61On/R44vvbU+en76t+8zs38xMvigOFHf21/r49cHh82bfZXdxaeYxZjmkOce/GoWoN
        9z+KRPEACwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWS2cA0UffplMhkg+X9qhZ3H19gs9hx7h6T
        RfPkxYwW3ec3MFqsvrmG0eLFn+dMFg1Nj1gsWna/Z7I4fbSD2WL/0+csFqsWXmOzOD/rFIvF
        y/YTzBb/f71itTjeu4PFgd/je/97do8LkyeweixucPXYOesuu0fLkbdA3p6XTB6bVnWyeWz8
        +J/d48m1zUwe7/ddZfOYOrve4/MmuQCeKC6blNSczLLUIn27BK6MDRc2sxecV6tYN+sVcwPj
        U9kuRk4OCQETiXtbjjB1MXJxCAmsZpTYtvIvC4TziVHixbXnUJlljBIbOk6zgLSwCRhI/D6+
        kRnEFhHQldjReZgNpIhZ4BqrxK83V9hAEsICsRJvrm9hgSiKk+h7dp8VwjaSuLX2NJjNIqAq
        8e/2RbB6XgFTiem/bzFDbJsEtPrtJ7AEp4C9xKyl+8C2MQqISXw/tYYJxGYWEJe49WQ+E8QT
        AhJL9pxnhrBFJV4+/scKYStK3P/+kh2iXkdiwW6ImcwCdhITl/5lgbC1JZYtfM0McYSgxMmZ
        T1ggeiUlDq64wTKBUWIWknWzkIyahWTULCSjZiEZtYCRdRWjeGlxcW56RbFRXmq5XnFibnFp
        Xrpecn7uJkZgyjn973D0Dsbbtz7qHWJk4mA8xCjBwawkwnv2RniyEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd6XURPjhQTSE0tSs1NTC1KLYLJMHJxSDUwivkrl7x8U5cVtXXJM4cP2mAdS0k/Y
        z9lFqa+74s3I9OW0anir8t87jMziaYf2Bwirf8r+ZPNaUO/QnXKHVEn94LwTfmdTjjGf4DMp
        kbZYecBAwc7gtYgzR5t7X+DyA0F7Tmd8Nlgt/9GtMqukZ+oyzWbJwrxtFUyaCltsegTjivRF
        kr/FfaiuCfm0w2etmGpeY5u1YtnxoJY/7/juG3hekFutPEO7+90kn9fnp/Td5Jku3W+y6Mp7
        99Q/m5g47Ioaj0Rmz3a1SnQunjq5R/Bi4Ve1vmSt9LlJbwU7bjV8b7Jcu9zGR2v+B68ztXfe
        tSbyrJp6isVeekVMs//TZE5ly2+X9zJv9ZFYxP5OiaU4I9FQi7moOBEAfAW4lagDAAA=
X-CMS-MailID: 20221026201325uscas1p239cee34590a13bc52310e320019914dc
CMS-TYPE: 301P
X-CMS-RootMailID: 20221026004835uscas1p1d37255ba8daaba8fc7e16e5129cb94b5
References: <CGME20221026004835uscas1p1d37255ba8daaba8fc7e16e5129cb94b5@uscas1p1.samsung.com>
        <20221026004737.3646-1-gregory.price@memverge.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 25, 2022 at 08:47:33PM -0400, Gregory Price wrote:
> Submitted as an extention to the multi-feature branch maintained
> by Jonathan Cameron at:
> https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-2022=
-10-24__;!!EwVzqGoTKBqv-0DWAJBm!RyiGL5B1XmQnVFwgxikKJeosPMKtoO1cTr61gIq8fwq=
fju8l4cbGZGwAEkKXIJB-Dbkfi_LNN2rGCbzMISz65cTxpAxI9pQ$  =20
>=20
>=20
> Summary of Changes:
> 1) E820 CFMW Bug fix. =20
> 2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
> 3) Multi-Region and Volatile Memory support for CXL Type-3 Devices
> 4) CXL Type-3 SRAT Generation when NUMA node is attached to memdev
>=20
>=20
> Regarding the E820 fix
>   * This bugfix is required for memory regions to work on x86
>   * input from Dan Williams and others suggest that E820 entry for
>     the CFMW should not exist, as it is expected to be dynamically
>     assigned at runtime.  If this entry exists, it instead blocks
>     region creation by nature of the memory region being marked as
>     reserved.

For CXL 2.0 it is my understanding that volatile capacity present at boot w=
ill
be advertised by the firmware. In the absence of EFI I would assume this wo=
uld
be provided in the e820 map.=20

Is the region driver meant to cover volatile capacity present at boot? I wa=
s
under the impression that it would be used for hot added volatile memory. I=
t
would be good to cover all of these assumptions for the e820 fix.=20

Lastly it is my understanding that the region driver does not have support =
for
volatile memory. It would be great to add that functionality if we make thi=
s
change in QEMU.

>=20
> Regarding Multi-Region and Volatile Memory
>   * Developed with input from Jonathan Cameron and Davidlohr Bueso.
>=20
> Regarding SRAT Generation for Type-3 Devices
>   * Co-Developed by Davidlohr Bueso.  Built from his base patch and
>     extended to work with both volatile and persistent regions.
>   * This can be used to demonstrate static type-3 device mapping and
>     testing numa-access to type-3 device memory regions.
>=20
>=20
> This series brings 3 features to CXL Type-3 Devices:
>     1) Volatile Memory Region support
>     2) Multi-Region support (1 Volatile, 1 Persistent)
>     3) (optional) SRAT Entry generation for type-3 device regions
>=20
> In this series we implement multi-region and volatile region support
> through 7 major changes to CXL devices
>     1) The HostMemoryBackend [hostmem] has been replaced by two
>        [hostvmem] and [hostpmem] to store volatile and persistent
>        memory respectively
>     2) The single AddressSpace has been replaced by two AddressSpaces
>        [hostvmem_as] and [hostpmem_as] to map respective memdevs.
>     3) Each memory region size and total region are stored separately
>     4) The CDAT and DVSEC memory map entries have been updated:
>        a) if vmem is present, vmem is mapped at DPA(0)
>        b) if pmem is present
>           i)  and vmem is present, pmem is mapped at DPA(vmem->size)
>           ii) else, pmem is mapped at DPA(0)
>        c) partitioning of pmem is not supported in this patch set but
>           has been discussed and this design should suffice.
>     5) Read/Write functions have been updated to access AddressSpaces
>        according to the mapping described in #4
>     6) cxl-mailbox has been updated to report the respective size of
>        volatile and persistent memory regions
>     7) SRAT entries may optionally be generated by manually assigning
>        memdevs to a cpuless numa node
>=20
> To support the Device Physical Address (DPA) Mapping decisions, see
> CXL Spec (3.0) Section 8.2.9.8.2.0 - Get Partition Info:
>   Active Volatile Memory
>     The device shall provide this volatile capacity starting at DPA 0
>   Active Persistent Memory
>     The device shall provide this persistent capacity starting at the
>     DPA immediately following the volatile capacity
>=20
> Partitioning of Persistent Memory regions may be supported on
> following patch sets.
>=20
>=20
> Gregory Price (4):
>   hw/i386/pc.c: CXL Fixed Memory Window should not reserve e820 in bios
>   hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
>   hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)
>   hw/acpi/cxl.c: Fill in SRAT for vmem/pmem if NUMA node is assigned
>=20
>  docs/system/devices/cxl.rst |  74 ++++++++--
>  hw/acpi/cxl.c               |  67 +++++++++
>  hw/cxl/cxl-mailbox-utils.c  |  23 +--
>  hw/i386/acpi-build.c        |   4 +
>  hw/i386/pc.c                |   2 -
>  hw/mem/cxl_type3.c          | 274 +++++++++++++++++++++++++++---------
>  include/hw/acpi/cxl.h       |   1 +
>  include/hw/cxl/cxl_device.h |  11 +-
>  tests/qtest/cxl-test.c      | 111 +++++++++++----
>  9 files changed, 443 insertions(+), 124 deletions(-)
>=20
> --=20
> 2.37.3
> =
