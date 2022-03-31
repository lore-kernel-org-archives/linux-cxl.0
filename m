Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A0EC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 22:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiCaWPT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbiCaWPS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Mar 2022 18:15:18 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711283DA65
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 15:13:26 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220331221322usoutp01a14509ffc090c21c4d00259da00060f3~hlto0Vkqi1937519375usoutp01L;
        Thu, 31 Mar 2022 22:13:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220331221322usoutp01a14509ffc090c21c4d00259da00060f3~hlto0Vkqi1937519375usoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648764802;
        bh=hsWSQWg+wAbaqd2WAztnXts+NOjgjJppurSBdYGtWTk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=t/wpl/41adjodUWgjzQyiw6pERENnlqM7BGLgYztuXf8FKI0Ii0AXuUNnJrc3bZ6L
         ahz7eQ4Jp6546b0iR1LCEPiKZ4NVdZtaifkJl/NpMijepKmGivEhox4cPDakbOoAxh
         7KLC5WHl9wMhx7K4qck0eckAGfn+Tl+sW1iK1yY0=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220331221322uscas1p13b7cfa82833a3f8484b092d38244be0b~hltoqcJ0o1534615346uscas1p1a;
        Thu, 31 Mar 2022 22:13:22 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id F4.18.09749.28726426; Thu,
        31 Mar 2022 18:13:22 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220331221321uscas1p24a636d9c951ec81b7bb518b00a0031f4~hltn4Z03P3240332403uscas1p29;
        Thu, 31 Mar 2022 22:13:21 +0000 (GMT)
X-AuditID: cbfec370-a6bff70000002615-31-62462782dec7
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 38.4A.09665.18726426; Thu,
        31 Mar 2022 18:13:21 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 31 Mar 2022 15:13:20 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Thu, 31 Mar 2022 15:13:20 -0700
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
        Jongmin Gim <gim.jongmin@samsung.com>
Subject: Re: [PATCH v8 04/46] hw/cxl/device: Introduce a CXL device (8.2.8)
Thread-Topic: [PATCH v8 04/46] hw/cxl/device: Introduce a CXL device (8.2.8)
Thread-Index: AQHYQ5jDAh0o55BFMkO81MsYMsoB9azYqvgAgAHcPIA=
Date:   Thu, 31 Mar 2022 22:13:20 +0000
Message-ID: <20220331221319.GA2411@bgt-140510-bm01>
In-Reply-To: <20220330184848.000027f7@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9792EF63E541BE4DBFD659FAB9D4FD8B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGOffe3n6EZpfq5CDBje5Dg9rBNOagyPbHZu6UGTVb3EekVryW
        ItSmtdN9OWAIFGEtSGUWNgQ27GyJUAi6pROsOqC4UFE67JywrDKwqVBFYAzZoLcm/e958j7P
        Ob/z5vBwUQO5nKdQHmbUSlm2mBQQ7b887lubv3LLvsRh5zOoeDgXoNqmIQKVjOhxdKKvGaAq
        owsgy20rQI/Pz+Ko23YZR73XinF0rs5Noj6Tk0BXWq5jSHdNz0G5PUr03+x9Dupon+egmuvD
        BGrrmOKirrKLBHLdsBCo7O4cgS4M5HNQS7uRfD2a7hyt49KukwYObdX5MLp6YhKjC676OfS9
        P77k0lXfzOF0g30Mo++47STtdbdi9PilAZI2Vn9BP7Kt2CH8QJCyn8lWfMSoX0ndK8hsHfHi
        qoGso8enmFzwF10C+DxIrYcVQzNYCRDwRNQPAOaP2ULmOAYbHQ3k01RR4w3ADpoAnDGXEqwJ
        ANjvqAuZTgAtFie+WCGpRPhvV0tQL6VehQ8GK4J1nLLx4c+lN4PnLqG2wZMPazlsKA26r06G
        Chthz+kOsKgJ6iU4rb8XzAupdXD8zMNghk8lweJT/mAXUMvgtNOKLWqcioYeby3GckfB+mo7
        zuplcP6nP0PviYdD02NcNi+Bg8ZKktWp0DXZibN6NWys8+HsvVELPF6C7cbAy+bBkM4XwL7y
        t0sAb0G/AZu+Dy01FlZZbwaXAqkiACcMlzisMQB4x/9PCGITnNe5uQbwoimM2xTGZApjMoUx
        mcKYzgDOORCt1Why5IxmnZI5ItHIcjRapVyScSjHBhb+ce/8FdVF4PEEJA6A8YADQB4uXioc
        2PPmPpFwv+zjTxj1Ialam81oHCCWR4ijhY2KZpmIkssOMwcZRsWon04xHn95Lmaw6mM/o0eT
        pBnPro/RRqQpbqXvPHbM+LknJTmwpmnjt7GTYv2D3dTvF/wf/lqw4eyJvF3l+gQBV57eurmb
        WtMx4gPyl+/2tqXvnunnWfvNJF/y2pbkltElul31/qzntkrjDtwP9NMv1DiJTQWbv86KHE+V
        asf3mp+feq/LMvfd3DvpO0ylqt8yRIV/T2xzpeQ9yRuL9Llns+LKV+kjo2a6tUeLCxzJ24H0
        0ZPu09N7rJX1RZZTMVUrPT0q+wHZ6re2V8cfMScE2t7f6rG9K1/rnKjc4Nv5lR+mneVmCESF
        eHzmwdihnB534YpmBTF868dPI1aVVYxQpO584m17hLcmTkxoMmVJCbhaI/sfylORZzYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWS2cA0UbdR3S3J4PNiIYuOBw2MFvPX3mex
        6HrWz2zRfX4Do8X0qRcYLVbfXMNo8XX9L2aLE5sOMlucPtrBbLFq4TU2i/OzTrFYHN54hsmi
        82g/q0XDyTyL/79esVrs3/aP1WLOmQcsFlv2f2O3ON67g8XiwsXVLBa99/6wWGy/2sRqsXHb
        VDYHcY8DLxaye1yYPIHVY03nayaP2R++MHm0HHnL6vH0bjO7x/S5f5g9Fu95yeRx59oeNo8n
        1zYzebzfd5XNY+rseo/Pm+QCeKO4bFJSczLLUov07RK4MjY/e8JccDWrovVbagPjY48uRk4O
        CQETifZlFxm7GLk4hARWM0rcnXCOBcL5yCixtmESO4RzgFHi+IHtzCAtbAIGEr+PbwSzRQSM
        JN7dmATWziywiVNib89lNpCEsIC3xORP81khinwkrh35AtVgJXFy5n5GEJtFQFXie/9TsHpe
        AWOJ9ws+MUNsm80ksf/YRLAGTgFDiY5pb8EGMQqISXw/tYYJxGYWEJe49WQ+E8QTAhJL9pxn
        hrBFJV4+/scKYStK3P/+kh2iXk/ixtQpbBC2ncSFLweYIWxtiWULXzNDHCEIdNwTFoheSYmD
        K26wTGCUmIVk3Swko2YhGTULyahZSEYtYGRdxSheWlycm15RbJyXWq5XnJhbXJqXrpecn7uJ
        EZjKTv87HLOD8d6tj3qHGJk4GA8xSnAwK4nwXo11TRLiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        6xE7MV5IID2xJDU7NbUgtQgmy8TBKdXAlLxl4UlmxrTDvxlWxnoKezz5JvZhSaE0xx0WA5tF
        sV/WrdxxLeX1dpZD3dz5ycWsxissT1s43fBzl7Likzrz/5FN/337N0k3HvzoSjzXwZWyUW41
        /3+P/o4nl0tmNy97zfnbVq1kXZRY4hLWpycPsk4+tf5HaBq/ZrXPO8bN+WuPz6r4K5TMt+fm
        tGNnH05KYL7P+//71ZWeS14dUHBq9r7naNbZHxvsJnwheX2KX3bFtYX9LitSlu5deVZqAsNG
        71b1uzFp9y7VzXX6vCQ/e2PO+sDuOeVnL8g/vM64t7X35s4vbvV8Mx8eav3PHGDGIrwr+247
        07y5aqFTpDXsVfpYqucf1nZo4ObLzTu8W4mlOCPRUIu5qDgRANEjIX7UAwAA
X-CMS-MailID: 20220331221321uscas1p24a636d9c951ec81b7bb518b00a0031f4
CMS-TYPE: 301P
X-CMS-RootMailID: 20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-5-Jonathan.Cameron@huawei.com>
        <CGME20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd@uscas1p2.samsung.com>
        <20220329181353.GA59203@bgt-140510-bm01>
        <20220330184848.000027f7@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 30, 2022 at 06:48:48PM +0100, Jonathan Cameron wrote:
> On Tue, 29 Mar 2022 18:13:59 +0000
> Adam Manzanares <a.manzanares@samsung.com> wrote:
>=20
> > On Fri, Mar 18, 2022 at 03:05:53PM +0000, Jonathan Cameron wrote:
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > >=20
> > > A CXL device is a type of CXL component. Conceptually, a CXL device
> > > would be a leaf node in a CXL topology. From an emulation perspective=
,
> > > CXL devices are the most complex and so the actual implementation is
> > > reserved for discrete commits.
> > >=20
> > > This new device type is specifically catered towards the eventual
> > > implementation of a Type3 CXL.mem device, 8.2.8.5 in the CXL 2.0
> > > specification.
> > >=20
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ...
>=20
> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.=
h
> > > new file mode 100644
> > > index 0000000000..b2416e45bf
> > > --- /dev/null
> > > +++ b/include/hw/cxl/cxl_device.h
> > > @@ -0,0 +1,165 @@
> > > +/*
> > > + * QEMU CXL Devices
> > > + *
> > > + * Copyright (c) 2020 Intel
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2. =
See the
> > > + * COPYING file in the top-level directory.
> > > + */
> > > +
> > > +#ifndef CXL_DEVICE_H
> > > +#define CXL_DEVICE_H
> > > +
> > > +#include "hw/register.h"
> > > +
> > > +/*
> > > + * The following is how a CXL device's MMIO space is laid out. The o=
nly
> > > + * requirement from the spec is that the capabilities array and the =
capability
> > > + * headers start at offset 0 and are contiguously packed. The header=
s themselves
> > > + * provide offsets to the register fields. For this emulation, regis=
ters will
> > > + * start at offset 0x80 (m =3D=3D 0x80). No secondary mailbox is imp=
lemented which
> > > + * means that n =3D m + sizeof(mailbox registers) + sizeof(device re=
gisters). =20
> >=20
> > What is n here, the start offset of the mailbox registers, this questio=
n is=20
> > based on the figure below?
>=20
> I'll expand on this to say
>=20
> means that the offset of the start of the mailbox payload (n) is given by
> n =3D m + sizeof....
>=20
> Which means the diagram below is wrong as should align with top
> of mailbox registers.
>=20
> >=20
> > > + *
> > > + * This is roughly described in 8.2.8 Figure 138 of the CXL 2.0 spec
> I'm going drop this comment as that figure appears unrelated to me.
>=20
> > > + *
> > > + *                       +---------------------------------+
> > > + *                       |                                 |
> > > + *                       |    Memory Device Registers      |
> > > + *                       |                                 |
> > > + * n + PAYLOAD_SIZE_MAX  -----------------------------------
> > > + *                  ^    |                                 |
> > > + *                  |    |                                 |
> > > + *                  |    |                                 |
> > > + *                  |    |                                 |
> > > + *                  |    |                                 |
> > > + *                  |    |         Mailbox Payload         |
> > > + *                  |    |                                 |
> > > + *                  |    |                                 |
> > > + *                  |    |                                 |
> > > + *                  |    -----------------------------------
> > > + *                  |    |       Mailbox Registers         |
> > > + *                  |    |                                 |
> > > + *                  n    -----------------------------------
> > > + *                  ^    |                                 |
> > > + *                  |    |        Device Registers         |
> > > + *                  |    |                                 |
> > > + *                  m    ---------------------------------->
> > > + *                  ^    |  Memory Device Capability Header|
> > > + *                  |    -----------------------------------
> > > + *                  |    |     Mailbox Capability Header   |
> > > + *                  |    -------------- --------------------
> > > + *                  |    |     Device Capability Header    |
> > > + *                  |    -----------------------------------
> > > + *                  |    |                                 |
> > > + *                  |    |                                 |
> > > + *                  |    |      Device Cap Array[0..n]     |
> > > + *                  |    |                                 |
> > > + *                  |    |                                 |
> > > + *                       |                                 |
> > > + *                  0    +---------------------------------+ =20
> >=20
> > Would it make sense to add CXL cap header register to the diagram?
>=20
> Too many similar names in the CXL spec. I'm not sure which one you mean,
> could you let me have a reference?  If you mean the one that is
> at the start of the CXL.cache and CXL.mem registers that whole region
> isn't covered by this diagram and might be in a different BAR.
> Here we are only dealing with the Memory Device Registers.  I'll
> add statement to the initial comment block to make that clear
> as it definitely isn't currently!


I was thinking 0 in your figure is the device capabilities array register,=
=20
which tells us how many capabilites that are in the array. This would be=20
8.2.8.1. After that comes 8.2.8.2 with n capability header registers which=
=20
point to the device registers.

>=20
> > n also=20
> > seems to be the size of the cap array, but it is also an offset so that=
 could
> > be clarified.
>=20
> Ah. Letter reuse. good point. Looking more closely it isn't an array anyw=
ay
> in the diagram (the array would have to include the Device Capability Hea=
der
> and Mailbox Capability headers.  Renamed as simply Device Cap Array Regis=
ter
>=20
> >=20
> > > + *
> > > + */
> > > +
> > > +#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
> > > +#define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
> > > +#define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
> > > +
> > > +#define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */ =20
> >=20
> > Is this to plan for future capabilities? If we have CAPS MAX doesn't th=
is=20
> > allow us to remove the slack space.=20
> >=20
> > > +#define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */ =20
> >=20
> > Should we add status to the name here, or would it get too long?
> >=20
> > > +
> > > +#define CXL_MAILBOX_REGISTERS_OFFSET \
> > > +    (CXL_DEVICE_REGISTERS_OFFSET + CXL_DEVICE_REGISTERS_LENGTH)
> > > +#define CXL_MAILBOX_REGISTERS_SIZE 0x20 /* 8.2.8.4, Figure 139 */
> > > +#define CXL_MAILBOX_PAYLOAD_SHIFT 11 =20
> >=20
> > I see 20 in the spec.
>=20
> It's an implementation choice between 8 and 20. For now, this code goes
> with 11 for no particularly strong reason.

Got it.

>=20
> >=20
> > > +#define CXL_MAILBOX_MAX_PAYLOAD_SIZE (1 << CXL_MAILBOX_PAYLOAD_SHIFT=
)
> > > +#define CXL_MAILBOX_REGISTERS_LENGTH \
> > > +    (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
> > > +
> > > +typedef struct cxl_device_state {
> > > +    MemoryRegion device_registers;
> > > +
> > > +    /* mmio for device capabilities array - 8.2.8.2 */
> > > +    MemoryRegion device;
> > > +    MemoryRegion caps;
> > > +
> > > +    /* mmio for the mailbox registers 8.2.8.4 */
> > > +    MemoryRegion mailbox;
> > > +
> > > +    /* memory region for persistent memory, HDM */
> > > +    uint64_t pmem_size; =20
> >=20
> > Can we switch this to mem_size and drop the persistent comment? It is m=
y=20
> > understanding that HDM is independent of persistence.
>=20
> Discussed in the other branch of this thread.  Short answer is we don't
> support non persistent yet but it's on the todo list.  What exactly
> that looks like is to be determined.  One aspect of that is there
> isn't currently a software stack to test volatile memory.

If you can elaborate more here on what is needed to test the volatile memor=
y=20
stack we may be able to help out.

>=20
> >=20
> > > +} CXLDeviceState;
> > > +
> > > +/* Initialize the register block for a device */
> > > +void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev=
);
> > > +
> > > +/* Set up default values for the register block */
> > > +void cxl_device_register_init_common(CXLDeviceState *dev);
> > > +
> > > +/*
> > > + * CXL 2.0 - 8.2.8.1 including errata F4
> > > + * Documented as a 128 bit register, but 64 bit accesses and the sec=
ond
> > > + * 64 bits are currently reserved.
> > > + */
> > > +REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64=
 byte accesses */
> > > +    FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
> > > +    FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
> > > +    FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
> > > +
> > > +/*
> > > + * Helper macro to initialize capability headers for CXL devices.
> > > + *
> > > + * In the 8.2.8.2, this is listed as a 128b register, but in 8.2.8, =
it says:
> > > + * > No registers defined in Section 8.2.8 are larger than 64-bits w=
ide so that
> > > + * > is the maximum access size allowed for these registers. If this=
 rule is not
> > > + * > followed, the behavior is undefined
> > > + *
> > > + * CXL 2.0 Errata F4 states futher that the layouts in the specifica=
tion are
> > > + * shown as greater than 128 bits, but implementations are expected =
to
> > > + * use any size of access up to 64 bits.
> > > + *
> > > + * Here we've chosen to make it 4 dwords. The spec allows any pow2 m=
ultiple
> > > + * access to be used for a register up to 64 bits.
> > > + */
> > > +#define CXL_DEVICE_CAPABILITY_HEADER_REGISTER(n, offset)  \
> > > +    REG32(CXL_DEV_##n##_CAP_HDR0, offset)                 \
> > > +        FIELD(CXL_DEV_##n##_CAP_HDR0, CAP_ID, 0, 16)      \
> > > +        FIELD(CXL_DEV_##n##_CAP_HDR0, CAP_VERSION, 16, 8) \
> > > +    REG32(CXL_DEV_##n##_CAP_HDR1, offset + 4)             \
> > > +        FIELD(CXL_DEV_##n##_CAP_HDR1, CAP_OFFSET, 0, 32)  \
> > > +    REG32(CXL_DEV_##n##_CAP_HDR2, offset + 8)             \
> > > +        FIELD(CXL_DEV_##n##_CAP_HDR2, CAP_LENGTH, 0, 32)
> > > +
> > > +CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OF=
FSET)
> > > +CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_O=
FFSET + \
> > > +                                               CXL_DEVICE_CAP_REG_SI=
ZE)
> > > + =20
> >=20
> > Fig139 for the following registers.
> Added ref
>=20
> >=20
> > 8.2.8.4.3
> Good idea. Added all these references.
>=20
> > > +REG32(CXL_DEV_MAILBOX_CAP, 0)
> > > +    FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
> > > +    FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
> > > +    FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
> > > +    FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
> > > + =20
> >=20
> > 8.2.8.4.4=20
> > > +REG32(CXL_DEV_MAILBOX_CTRL, 4)
> > > +    FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
> > > +    FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
> > > +    FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
> > > + =20
> >=20
> > 8.2.8.4.5 + 8.2.9
> > > +REG64(CXL_DEV_MAILBOX_CMD, 8)
> > > +    FIELD(CXL_DEV_MAILBOX_CMD, COMMAND, 0, 8)
> > > +    FIELD(CXL_DEV_MAILBOX_CMD, COMMAND_SET, 8, 8)
> > > +    FIELD(CXL_DEV_MAILBOX_CMD, LENGTH, 16, 20)
> > > + =20
> >=20
> > 8.2.8.4.6
> > > +REG64(CXL_DEV_MAILBOX_STS, 0x10)
> > > +    FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
> > > +    FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
> > > +    FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
> > > + =20
> >=20
> > 8.2.8.4.7
> > > +REG64(CXL_DEV_BG_CMD_STS, 0x18)
> > > +    FIELD(CXL_DEV_BG_CMD_STS, BG, 0, 16) =20
> >=20
> > Should we call this OP since it is implied that we are BG given the reg=
ister?
> Sure. It's a better name than BG.
> >=20
> > > +    FIELD(CXL_DEV_BG_CMD_STS, DONE, 16, 7) =20
> >=20
> > NUM_DONE? since this is a percentage.
> Let's be verbose as NUM_DONE still seems confusing to me.
> PERCENTAGE_COMP

Even better.

>=20
> I hadn't really noticed these names as I don't think any of
> them are used yet.
>=20
> >=20
> > > +    FIELD(CXL_DEV_BG_CMD_STS, ERRNO, 32, 16) =20
> >=20
> > Isn't this a RET_CODE since it is only valid if previous field is 100%
>=20
> Changed
>=20
> >=20
> > > +    FIELD(CXL_DEV_BG_CMD_STS, VENDOR_ERRNO, 48, 16) =20
> >=20
> > VENDOR_RET_CODE since the same rule for the previous field applies here=
.
> Changed
> >=20
> > > +
> > > +REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
> > > +
> > > +#endif
> > > --=20
> > > 2.32.0
> > >=20
> > >  =20
> >=20
> > +cc Dave, Klaus, Tong
> > Other than the minor issues raised.
> >=20
> > Looks good.
> >=20
> > Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
>=20
> Btw I haven't accepted all changes, but have been picking up
> your RB.  Shout if that's not fine with you.

Definitely fine with me and was my intention. Let us know how we can help m=
ove
the work forward. I am kick starting reviewing and will try to bring others=
 in.=20

>=20
> Thanks.
>=20
> Jonathan
> =
