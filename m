Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8DC433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358590AbiDDPRN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377437AbiDDPRM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:17:12 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4212393EA
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:15:14 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220404151509usoutp0285f31da2a76de63b04ae5d04e2e5c378~iulobO8DU0255202552usoutp02Q;
        Mon,  4 Apr 2022 15:15:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220404151509usoutp0285f31da2a76de63b04ae5d04e2e5c378~iulobO8DU0255202552usoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649085309;
        bh=IouOsEKHsrgMH//hGbHdU/g6NNyq+QJno3ZCm/HVXAI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=agoG2/XrKNJa5/yfszwUJlR3F1kcx4g29iDP/g/dteZzbgmOi97xCXl00b26sFRo7
         6J5vsUB4WQ+6Xizz1MHRVp6c2TiNSoZx78KT+4Qp8JiM2cFkk0HKPsxDCpi3oWJmpL
         8hP4t1Kde338l9CDYQiveDvUMU6WGUFO4gBaFcVw=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220404151509uscas1p2b58163b3c73718c7083ebec1902971b8~iuloKtIIa0641206412uscas1p2w;
        Mon,  4 Apr 2022 15:15:09 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 86.49.09760.D7B0B426; Mon, 
        4 Apr 2022 11:15:09 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220404151508uscas1p296f58fbbc9c4f080c477f365bff25316~iulnr6YNJ0641206412uscas1p2t;
        Mon,  4 Apr 2022 15:15:08 +0000 (GMT)
X-AuditID: cbfec36d-51bff70000002620-ea-624b0b7db788
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 41.3A.09665.C7B0B426; Mon, 
        4 Apr 2022 11:15:08 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Mon, 4 Apr 2022 08:15:07 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Mon, 4 Apr 2022 08:15:07 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Tong Zhang <t.zhang2@samsung.com>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>,
        Heekwon Park <heekwon.p@samsung.com>,
        Jaemin Jung <j.jaemin@samsung.com>,
        Jongmin Gim <gim.jongmin@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v8 04/46] hw/cxl/device: Introduce a CXL device (8.2.8)
Thread-Topic: [PATCH v8 04/46] hw/cxl/device: Introduce a CXL device (8.2.8)
Thread-Index: AQHYQ5jDAh0o55BFMkO81MsYMsoB9azYqvgAgAHcPICAAQBHAIAE1DCA
Date:   Mon, 4 Apr 2022 15:15:07 +0000
Message-ID: <20220404151500.GA57759@bgt-140510-bm01>
In-Reply-To: <20220401143034.0000015f@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D8CFA87CF72D724F9CBC8D0C0BC67D9C@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/s8z5790NEDCHzBOy4WWBGSaF3fjqTOUB+jPzy9fpy7Dic8
        h9MxaBOD6McuW8A6c4K72Tbkh7UUBwLONQUZMJbxw1gRcxEI1MhoZ5IpnIgjxjMv/nt/Pp/3
        +/t5fe6+PDyiiYzjSeWHGIVcIhORAsL23b3B9R+uytq3ofJiFCqfUAFU0zhOIM0fx3D0+WAz
        QHqdG6Bzv1gAund+Hkfft3bhqN9VjqOGOg+JBg19BHK2DGCownWMg1S9cuTVTgG0OP8XBzls
        AQ4yDUwQyOqY5aKrR+0Ecv94jkBHbywQ6NvhTzioxaYjX4F05591XNpdpeXQlgo/Rhtn7mL0
        pz23OPTU2BEura9ewOnT7dMY3dpQQdKjnnaS9nkuYPTtjmGS1hk/pv9tjd8ZtkfwUi4jkx5m
        FM9m7BXsv6I6ThbeLipedAQwFbi/UwP4PEg9B7U/LGIaIOBFUGcBNNdOc9lCjcF6dxv5yOU9
        +YBkB40ANjnbQpEZAHtHr+Ns4QCw67MaEIyQ1Ab44GoLHtRrqI3wb28lCJpwaowP3WVfE8FB
        JJUFq+7UcFjT69DTczcU2AZHrGXLuwkqEVY97Fx+VLjE0V+9sJzlU2lQ/9Nv3KAGVDSc67Ng
        QY1TMXDEV4Ox3OGw3tiOszoaBi5Phu5JgONz01zWnwq9uhNLfd6SzoDq5kS2/Qw01/lxdm04
        7P3SR7DRWNh1xksEb4FUtQC6ujo57CAT9g1ZQ6a1UG8ZCpnKAJzRdnDYQgvg6K37IYp0GKjw
        cLUg0bAC3LACyvA/lGEFlGEFVC3gNICYIqUyP49RpsmZ91KVknxlkTwvNacgvxUsfen+gDPf
        Duwj/6R2A4wHugHk4aI1QtmuHfsihLmSkvcZRUG2okjGKLvBWh4hihGapc2SCCpPcog5yDCF
        jOLRFOPx41SYuLL+Da9izibe9nJh9avhnrdmb251XlJvf405rj9gGZiMvHEgIe+Lxowr/toR
        X/OLaodqSpySa62bfD4sKeepy0dAR35x8hbD4THZwikbPR7pN6JyWn4h7AlpmFzgO7gny6yO
        m1mvnj17Iv3JeeMgX5R2JmezSLrr6cDPek3CC7g/6dftA6bYpuGG2MfE/Ay9bPWELtu9107N
        Z65Oyjy5KcplAuL2qJLHL6Z/UFxYesl+h6vd4Sxt0ZnflZhupstM0Zrz3as0m7fEQ4ev59pG
        1Tv2it2nxq+PlmS9uWnA9FG4/Fp8inCkdOir6L63d/+e3ZZibVy31eb65qGzIDnebxQRyv2S
        tGRcoZT8By9LxJBBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWS2cA0UbeG2zvJ4M9UHYuOBw2MFvPX3mex
        6HrWz2zRfX4Do8X0qRcYLVbfXMNo8XX9L2aLE5sOMlucPtrBbLFq4TU2i/OzTrFYHN54hsmi
        82g/q0XDyTyLGxOeMlr8//WK1WL/tn+sFnPOPGCx2LL/G7vF8d4dLBYXLq5msei994fFYvvV
        JlaLjdumsjlIeBx4sZDd48LkCaweazpfM3nM/vCFyaPlyFtWj6d3m9k9ps/9w+yxeM9LJo9N
        qzrZPO5c28Pm8eTaZiaP9/uusnlMnV3v8XmTXABfFJdNSmpOZllqkb5dAlfG3oaJbAXvSyv+
        7//H1MD4M6CLkZNDQsBE4saM32xdjFwcQgKrGSUWbL3BDOF8YJTYcOA2E4Szn1Fix6bZ7CAt
        bAIGEr+Pb2QGsUUEjCTe3ZjECFLELHCXU+JC+1IWkISwgLfE5E/zWSGKfCSuHfkC1eAmcWtL
        OxuIzSKgIjH57wFGEJsX6I7Tc/+wQGx7xSTx6MMRsG2cAoYS0y89ArMZBcQkvp9awwRiMwuI
        S9x6Mp8J4gkBiSV7zjND2KISLx//Y4WwFSXuf3/JDlGvJ3Fj6hSgxRxAtp1E6wYViLC2xLKF
        r5khbhCUODnzCQtEq6TEwRU3WCYwSsxCsm0WkkmzECbNQjJpFpJJCxhZVzGKlxYX56ZXFBvn
        pZbrFSfmFpfmpesl5+duYgQmt9P/DsfsYLx366PeIUYmDsZDjBIczEoivDlBnklCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeT1iJ8YLCaQnlqRmp6YWpBbBZJk4OKUamPZ9Tf5g8kZryWozj1rW
        dy/8JRQnyF9u8so5frhRJ23LGinPiQv2iXrGrt14yO1/DmPyntlZwQGT90pyhbhOn7+yvOgk
        077vzkIKa+YqxK8+vyc35nEPw4HgVYeWCVuyaEy2mzhpuZnJ8bgvG/se+PRbytyUvXi542+Z
        qHRXn9HRg0salj8WYcg7vMlf32+e8EFpydwTfpbPVWQtfh6+kM5StOnT5PQ3pqr3nn1nmfdk
        ot+udw8Tc0O2LDy9d82D390SV+uqUrtnHs1uvHnlhEza5WceB0WWmMjzOMT55R9f6/v53Uf3
        Y/45Gw3zlWWaGdbcr1v0yv6CvuHaup/nNvZLzNvlFe2xg7ewNHJ3ZIMSS3FGoqEWc1FxIgCz
        ytSy3QMAAA==
X-CMS-MailID: 20220404151508uscas1p296f58fbbc9c4f080c477f365bff25316
CMS-TYPE: 301P
X-CMS-RootMailID: 20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-5-Jonathan.Cameron@huawei.com>
        <CGME20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd@uscas1p2.samsung.com>
        <20220329181353.GA59203@bgt-140510-bm01>
        <20220330184848.000027f7@huawei.com> <20220331221319.GA2411@bgt-140510-bm01>
        <20220401143034.0000015f@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 01, 2022 at 02:30:34PM +0100, Jonathan Cameron wrote:
> On Thu, 31 Mar 2022 22:13:20 +0000
> Adam Manzanares <a.manzanares@samsung.com> wrote:
>=20
> > On Wed, Mar 30, 2022 at 06:48:48PM +0100, Jonathan Cameron wrote:
> > > On Tue, 29 Mar 2022 18:13:59 +0000
> > > Adam Manzanares <a.manzanares@samsung.com> wrote:
> > >  =20
> > > > On Fri, Mar 18, 2022 at 03:05:53PM +0000, Jonathan Cameron wrote: =
=20
> > > > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > > >=20
> > > > > A CXL device is a type of CXL component. Conceptually, a CXL devi=
ce
> > > > > would be a leaf node in a CXL topology. From an emulation perspec=
tive,
> > > > > CXL devices are the most complex and so the actual implementation=
 is
> > > > > reserved for discrete commits.
> > > > >=20
> > > > > This new device type is specifically catered towards the eventual
> > > > > implementation of a Type3 CXL.mem device, 8.2.8.5 in the CXL 2.0
> > > > > specification.
> > > > >=20
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org> =20
> > >=20
> > > ...
> > >  =20
> > > > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_dev=
ice.h
> > > > > new file mode 100644
> > > > > index 0000000000..b2416e45bf
> > > > > --- /dev/null
> > > > > +++ b/include/hw/cxl/cxl_device.h
> > > > > @@ -0,0 +1,165 @@
> > > > > +/*
> > > > > + * QEMU CXL Devices
> > > > > + *
> > > > > + * Copyright (c) 2020 Intel
> > > > > + *
> > > > > + * This work is licensed under the terms of the GNU GPL, version=
 2. See the
> > > > > + * COPYING file in the top-level directory.
> > > > > + */
> > > > > +
> > > > > +#ifndef CXL_DEVICE_H
> > > > > +#define CXL_DEVICE_H
> > > > > +
> > > > > +#include "hw/register.h"
> > > > > +
> > > > > +/*
> > > > > + * The following is how a CXL device's MMIO space is laid out. T=
he only
> > > > > + * requirement from the spec is that the capabilities array and =
the capability
> > > > > + * headers start at offset 0 and are contiguously packed. The he=
aders themselves
> > > > > + * provide offsets to the register fields. For this emulation, r=
egisters will
> > > > > + * start at offset 0x80 (m =3D=3D 0x80). No secondary mailbox is=
 implemented which
> > > > > + * means that n =3D m + sizeof(mailbox registers) + sizeof(devic=
e registers).   =20
> > > >=20
> > > > What is n here, the start offset of the mailbox registers, this que=
stion is=20
> > > > based on the figure below? =20
> > >=20
> > > I'll expand on this to say
> > >=20
> > > means that the offset of the start of the mailbox payload (n) is give=
n by
> > > n =3D m + sizeof....
> > >=20
> > > Which means the diagram below is wrong as should align with top
> > > of mailbox registers.
> > >  =20
> > > >  =20
> > > > > + *
> > > > > + * This is roughly described in 8.2.8 Figure 138 of the CXL 2.0 =
spec =20
> > > I'm going drop this comment as that figure appears unrelated to me.
> > >  =20
> > > > > + *
> > > > > + *                       +---------------------------------+
> > > > > + *                       |                                 |
> > > > > + *                       |    Memory Device Registers      |
> > > > > + *                       |                                 |
> > > > > + * n + PAYLOAD_SIZE_MAX  -----------------------------------
> > > > > + *                  ^    |                                 |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |         Mailbox Payload         |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    -----------------------------------
> > > > > + *                  |    |       Mailbox Registers         |
> > > > > + *                  |    |                                 |
> > > > > + *                  n    -----------------------------------
> > > > > + *                  ^    |                                 |
> > > > > + *                  |    |        Device Registers         |
> > > > > + *                  |    |                                 |
> > > > > + *                  m    ---------------------------------->
> > > > > + *                  ^    |  Memory Device Capability Header|
> > > > > + *                  |    -----------------------------------
> > > > > + *                  |    |     Mailbox Capability Header   |
> > > > > + *                  |    -------------- --------------------
> > > > > + *                  |    |     Device Capability Header    |
> > > > > + *                  |    -----------------------------------
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |      Device Cap Array[0..n]     |
> > > > > + *                  |    |                                 |
> > > > > + *                  |    |                                 |
> > > > > + *                       |                                 |
> > > > > + *                  0    +---------------------------------+   =
=20
> > > >=20
> > > > Would it make sense to add CXL cap header register to the diagram? =
=20
> > >=20
> > > Too many similar names in the CXL spec. I'm not sure which one you me=
an,
> > > could you let me have a reference?  If you mean the one that is
> > > at the start of the CXL.cache and CXL.mem registers that whole region
> > > isn't covered by this diagram and might be in a different BAR.
> > > Here we are only dealing with the Memory Device Registers.  I'll
> > > add statement to the initial comment block to make that clear
> > > as it definitely isn't currently! =20
> >=20
> >=20
> > I was thinking 0 in your figure is the device capabilities array regist=
er,=20
> > which tells us how many capabilites that are in the array. This would b=
e=20
> > 8.2.8.1. After that comes 8.2.8.2 with n capability header registers wh=
ich=20
> > point to the device registers.
>=20
> Got it.  See below.
>=20
> >=20
> > >  =20
> > > > n also=20
> > > > seems to be the size of the cap array, but it is also an offset so =
that could
> > > > be clarified. =20
> > >=20
> > > Ah. Letter reuse. good point. Looking more closely it isn't an array =
anyway
> > > in the diagram (the array would have to include the Device Capability=
 Header
> > > and Mailbox Capability headers.  Renamed as simply Device Cap Array R=
egister
>=20
> As mentioned here, the array is misleading anyway because we have the
> actual entries listed directly above it rather than 'inside' the array.
> Hence the change described above.
>=20
> > >  =20
> > > >  =20
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
> > > > > +#define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
> > > > > +#define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
> > > > > +
> > > > > +#define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above *=
/   =20
> > > >=20
> > > > Is this to plan for future capabilities? If we have CAPS MAX doesn'=
t this=20
> > > > allow us to remove the slack space.=20
> I missed replying to this before.
>=20
> So far CAPS MAX covers everything in the spec. (room for secondary mailbo=
x
> + the 3 we have implemented).=20
> We don't support migration etc yet (and I'm not sure we ever will)
> anyway so I'm not hugely bothered about backwards compatibility.
> Hence we can just move things if needed later.
>=20
> > > >  =20
> > > > > +#define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */   =20
> > > >=20
> > > > Should we add status to the name here, or would it get too long?
> > > >  =20
> > > > > +
> > > > > +#define CXL_MAILBOX_REGISTERS_OFFSET \
> > > > > +    (CXL_DEVICE_REGISTERS_OFFSET + CXL_DEVICE_REGISTERS_LENGTH)
> > > > > +#define CXL_MAILBOX_REGISTERS_SIZE 0x20 /* 8.2.8.4, Figure 139 *=
/
> > > > > +#define CXL_MAILBOX_PAYLOAD_SHIFT 11   =20
> > > >=20
> > > > I see 20 in the spec. =20
> > >=20
> > > It's an implementation choice between 8 and 20. For now, this code go=
es
> > > with 11 for no particularly strong reason. =20
> >=20
> > Got it.
> >=20
> > >  =20
> > > >  =20
> > > > > +#define CXL_MAILBOX_MAX_PAYLOAD_SIZE (1 << CXL_MAILBOX_PAYLOAD_S=
HIFT)
> > > > > +#define CXL_MAILBOX_REGISTERS_LENGTH \
> > > > > +    (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
> > > > > +
> > > > > +typedef struct cxl_device_state {
> > > > > +    MemoryRegion device_registers;
> > > > > +
> > > > > +    /* mmio for device capabilities array - 8.2.8.2 */
> > > > > +    MemoryRegion device;
> > > > > +    MemoryRegion caps;
> > > > > +
> > > > > +    /* mmio for the mailbox registers 8.2.8.4 */
> > > > > +    MemoryRegion mailbox;
> > > > > +
> > > > > +    /* memory region for persistent memory, HDM */
> > > > > +    uint64_t pmem_size;   =20
> > > >=20
> > > > Can we switch this to mem_size and drop the persistent comment? It =
is my=20
> > > > understanding that HDM is independent of persistence. =20
> > >=20
> > > Discussed in the other branch of this thread.  Short answer is we don=
't
> > > support non persistent yet but it's on the todo list.  What exactly
> > > that looks like is to be determined.  One aspect of that is there
> > > isn't currently a software stack to test volatile memory. =20
> >=20
> > If you can elaborate more here on what is needed to test the volatile m=
emory=20
> > stack we may be able to help out.
>=20
> There are a bunch of different ways this could be done - ultimate we prob=
ably
> want to do all of them.
>=20
> https://urldefense.com/v3/__https://cdrdv2.intel.com/v1/dl/getContent/643=
805?wapkw=3DCXL*20memory*20device*20sw*20guide__;JSUlJQ!!EwVzqGoTKBqv-0DWAJ=
Bm!HzD_Dh_I9m9MydppOSSyhuzvwTawlg7LE77bEYiZ1i3AMgxV_YOI56VeZgkg-KuX7XMA$=20
> has some suggestions (though no one is obliged to follow them!) See 2.4
>=20
> First assumption is that for volatile devices, a common approach will be =
to do
> all the setup in firmware before the OS boots and just present normal SRA=
T, HMAT
> and memory tables as if it were any other memory.  If we want to go that =
way
> for testing purposes then we'd need an open source firmware to implement
> setup similar to that done in Linux - probably EDK2.
>=20
> Of course, volatile memory might be hot added, in which case the OS may b=
e involved.
> In that case I think the main missing part would be actually doing the fi=
nal memory
> hotplug event to expose it to the OS + the necessary dynamic updating of =
the
> OS numa description etc. There is work on going to get the information ne=
eded
> but I think we are still some way off actually tying everything together.
>=20
> Dan / Ben and team may be able to share more status information.

Great, thanks for all of the information. We will start planning out our ne=
xt
steps. I'll add Luis on cc since he has chatted with me about setting up a=
=20
test framework for the CXL kernel code that will rely on QEMU.

>=20
> >=20
> > >  =20
> > > >  =20
> > > > > +} CXLDeviceState;
> > > > > +
> > > > > +/* Initialize the register block for a device */
> > > > > +void cxl_device_register_block_init(Object *obj, CXLDeviceState =
*dev);
>=20
> ...
>=20
> > > > +cc Dave, Klaus, Tong
> > > > Other than the minor issues raised.
> > > >=20
> > > > Looks good.
> > > >=20
> > > > Reviewed by: Adam Manzanares <a.manzanares@samsung.com> =20
> > >=20
> > > Btw I haven't accepted all changes, but have been picking up
> > > your RB.  Shout if that's not fine with you. =20
> >=20
> > Definitely fine with me and was my intention. Let us know how we can he=
lp move
> > the work forward. I am kick starting reviewing and will try to bring ot=
hers in.
>=20
> Great.  For various reasons I'll not bother mention here (see my employer=
 ;)
> I need to keep any discussions on mailing list or in a 'published' form.
> So discussion on mailing list + at conferences works best for me but we c=
an
> organize some suitably hosted public calls if needed to align plans.
> There is a plan for uconf at Plumbers this year which will hopefully let

We would also prefer to keep discussions in the public domain. We have plan=
s to
attend Plumbers this year, so we look forward to discussing in person.=20

> us do any longer term planning.  Shorter term my aims around QEMU side of=
 things
> are:
>=20
> 1) Get the initial support upstream as I'm getting bored of rebasing :)
>    I think we are in a fairly good state for doing that once qemu 7.0 is
>    out.
> 2) Improved tests so it doesn't break when no one is paying attention.

Luis may have some thoughts here.=20

> 3) Expand out the feature set to keep up with what is going on Linux kern=
el
>    wise (personally no other OS of interest, but it would be great if any=
one
>    wanted to help deal with other operating systems that care).
>   * RAS
>   * CDAT for switches etc, host table updates for generic port definition
>    - What ever else I've missed recently.  When the region code finalizes
>      I suspect we'll want to add a load more tests to stress various corn=
ers
>      of that.
>   * Alison may help with partitioning support.
> 4) Expand features where we have currently taken a short cut such as enab=
ling
>    multiple HDM decoders.
> 5) Use it as a path for testing spec features before publication (obvious=
ly can't
>    talk about that on list but I've open in appropriate venue about that)=
.
>=20
> Happy to have help on any of the above, but 'features' that are reasonabl=
y separate
> such as RAS support might be a good place for contributions that won't be
> greatly affected by any other refactoring going on.
>=20
> I've pushed all but SPDM support and stuff for which the spec isn't publi=
c yet up on
> https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/commits/cxl-v=
9-draft-1__;!!EwVzqGoTKBqv-0DWAJBm!HzD_Dh_I9m9MydppOSSyhuzvwTawlg7LE77bEYiZ=
1i3AMgxV_YOI56VeZgkg-EMwmPTV$=20
> (as you can see CI found a segfault today so I'll push the fix out for th=
at
>  shortly - that also highlighted a build breakage mid series that I've fi=
xed up.).
>=20

Once again thanks for all of the pointers.=20

> Jonathan
>=20
> =20
> >=20
> > >=20
> > > Thanks.
> > >=20
> > > Jonathan
> > > =20
> =
