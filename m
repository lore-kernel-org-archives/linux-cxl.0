Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5815CC64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 21:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjB0Vp0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjB0VpZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 16:45:25 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5221C33F
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 13:45:01 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230227214458usoutp019efbc7ba87d3ae0888f947fdd7165f58~HzI6GLkpl3141931419usoutp01t;
        Mon, 27 Feb 2023 21:44:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230227214458usoutp019efbc7ba87d3ae0888f947fdd7165f58~HzI6GLkpl3141931419usoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677534298;
        bh=+y1JdfcbgAePPFJuhZ24K/7L2scuIK61T+CqculVAbI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qsDcrOuf4bVqve3ikqHwV+kIzbHlLUEGD/+pYj1LiweCzh7x/K9II81cH5P2eCPJe
         l1tUpR7ITVLYygpoCw24+vze5Bf661yy+cQH+SblIvrq/5bF9mtKngT8eV/x6pWAwY
         SpQvnwYprWQ8J+3PiGVbd8GO+D0BeZRZIPKj3avk=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230227214458uscas1p2926c3b3c7068c8aae84c25ffcbfd1617~HzI58-fgC1175311753uscas1p2I;
        Mon, 27 Feb 2023 21:44:58 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id C9.82.12196.A542DF36; Mon,
        27 Feb 2023 16:44:58 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230227214458uscas1p1f3493214ecf7563502f1f1ffbf540103~HzI5jks900761407614uscas1p1y;
        Mon, 27 Feb 2023 21:44:58 +0000 (GMT)
X-AuditID: cbfec370-83dfe70000012fa4-2a-63fd245ab65b
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id F1.F2.17110.9542DF36; Mon,
        27 Feb 2023 16:44:58 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 13:44:57 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 13:44:57 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
Thread-Topic: [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
Thread-Index: AQHZSsCUsUt4UVu11UmvUYmjkPdc367j2g0A
Date:   Mon, 27 Feb 2023 21:44:57 +0000
Message-ID: <20230227214449.GA1338620@bgt-140510-bm03>
In-Reply-To: <20230227153128.8164-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9A365481888CFD44B19914F80EA19999@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djXc7pRKn+TDSY/krJonryY0eLEzUY2
        i9U31zBavPjznMli/9PnLBarFl5jszg/6xSLxeGNZ5gsfq99zGTx/9crVos1K4QtjvfuYHHg
        8dg56y67R8uRt6wei/e8ZPLYtKqTzePOtT1sHk+ubWbyeL/vKpvH1Nn1Hp83yQVwRnHZpKTm
        ZJalFunbJXBlPD/5g7lgqUTFg+2nWBsY5wp3MXJySAiYSDw5/Iqxi5GLQ0hgJaPE8pMXmCGc
        ViaJXV+WsMJUXV/6HyqxllHiWF8XO4TziVHi96pNUP3LGCXO/mlmBGlhE1CU2Ne1nQ3EFhEw
        knh3YxJYEbPAfBaJQ39PM4MkhAVcJSZdnMAMUeQm8XrWF3aYhqszj4HZLAKqEqdXHQIbyitg
        JvGmfx2YzSngINH+swmshlFATOL7qTVMIDazgLjErSfzmSDuFpRYNHsPM4QtJvFv10M2CFtR
        4v73l+wQ9XoSN6ZOYYOw7SQ+Pl/BCmFrSyxb+JoZYq+gxMmZT1ggeiUlDq64wQLyjITAZE6J
        7a/uQiVcJHYdXga1QFri791lQEdwANnJEqs+ckGEcyTmL9kCVW4tsfDPeqYJjCqzkJw9C8lJ
        s5CcNAvJSbOQnLSAkXUVo3hpcXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYOI7/e9wwQ7GW7c+
        6h1iZOJgPMQowcGsJMK78PafZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8hrYnk4UE0hNLUrNT
        UwtSi2CyTBycUg1MRkcn97nea2J68VD3bHKSA1fN5bfxte0nih4V9LQv+ZQ43bXR1PuJeMay
        8nPCQnr54ty8mS+dGq9xR/M45HC+CtSryAvnE2eVa1OqkTs+4/7zWvM3s48kvQi12bxoA+ul
        VGHtaot1vtznIr46OKgmzGieMDtTr/BEViXDzZy25w9snLbIde2Z53eqXDHLIf1UVkB7dOs1
        gfvZNf8SEpZtPnTy/db0rxxr5ml2m0cw2OSpRq/zVEl7Jx14KGB97ILpOSzHJrdu6tiVor1x
        XUFd669Ow6yQ2qOrfkY5hH7afXJq1/9pxgWyc1lmCDS9ZDP+duXc5TdxN/77T73Cc2lJj+LV
        8yn7Nt0JeRpbsE+JpTgj0VCLuag4EQDTrBBK6wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c45O57NjONm+mlgOpRueCXiEOali50swhKiLLLhjk50XnY0
        LxSuexqRzRQ9ZWqW2FxJKzRDjGZUaiRetnQWLlSWqZVppWWa8xDsvx88z/s87wsvgYpnMA8i
        KTWTUaXKUqS4CEtSIxq/WJ+/8YEFFoQ6W1wDqNcDp3GqfkAHqE/zVoR6NmrFKG21Cae6uA6M
        anv4BqH+3B9GqMXfnwWUrk5CvbryBAtfQTdzHxzocy8mBXRNyxhC67UFOP3e1ILTI6ZHCP21
        1YjTJTfy6Wm9Z7QwVhQiZ1KSTjCqgNDjIoW1fRZNvwtzLE0dAjWokBQCIQHJTfDd3UW0EIgI
        MVkPoHpCh9oEMfkdwDnLDl6oBfCFvgOzCTjpDVsLm3Abu5DB8Eu/BtgYJSsx+Lwux8YScifU
        dBehvCcSjnMzDv/9xvKXy4yRvrBTa1iedSI3w4mrDwBfHAZLRweXu4RkOLw4d2bZD0hX+KtD
        h/BdbtA8UonwF5DwTksXyvMqODa8IODZGw79GnPg/f6wv+Q6znMonLLWCXjeCGurx1F+B2fY
        Xj6C8bPuS6f0Y0UAcnZ1nF0UZxfF2UVxdlFVQKAFblksq0zMYYNTmWx/VqZks1IT/ePTlHqw
        9BidC21HnoBB85S/ASAEMABIoFIXp+rB+Xixk1yWm8eo0uJUWSkMawCrCUzq5jQWey1OTCbK
        MplkhklnVP9VhBB6qBGi1Evqwt46OnzAUbA4WfYx6ofhS0ZvnvtMQHjItT1bUnbn7WpvEjZT
        ytII84HLrybIKm7+kmOJMcwnQa59+8GoH8q/jsyszTg88FrSek7DkttQRfLJgowCOYytrlwQ
        KWvPSiyKy/1zBrq4ewgG0L1q06UYk2vkrFtgbqN1317JN696S/qi71TNyYhZV+eEuebp8Mds
        iHzHhfjG4pjIbnfTQe29UKwvyO98cN0pxXSEZassLjdMcqwiKvF+X+WsdGVZpnC/xui+XdfT
        1vXNyzx5YWqidvp2zIPsyd1izzxB1NenGo+eslMO5qB7P/3WsIfyG8bX96672SZSNkTflmKs
        Qha0AVWxsn/i7Ax/hwMAAA==
X-CMS-MailID: 20230227214458uscas1p1f3493214ecf7563502f1f1ffbf540103
CMS-TYPE: 301P
X-CMS-RootMailID: 20230227214458uscas1p1f3493214ecf7563502f1f1ffbf540103
References: <20230227153128.8164-1-Jonathan.Cameron@huawei.com>
        <CGME20230227214458uscas1p1f3493214ecf7563502f1f1ffbf540103@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 27, 2023 at 03:31:26PM +0000, Jonathan Cameron wrote:

> v2:
> - Rebase and pick up tags.
> - State prereq patche sets more clearly.
>=20
> Mostly sending out again because some of the precursors have been updated
> and to fix a typo in a tag given on v1.
>=20
> Until now, testing using CXL has relied up always using two root ports
> below a host bridge, to work around a current assumption in the Linux
> kernel support that, in the single root port case, the implementation wil=
l
> use the allowed passthrough decoder implementation choice. If that choice
> is made all accesses are routed from the host bridge to the single
> root port that is present. Effectively we have a pass through decoder
> (it is called that in the kernel driver).
>=20
> This patch series implements that functionality and makes it the default
> See patch 2 for a discussion of why I think we can make this change
> without backwards compatibility issues (basically if it didn't work befor=
e
> who are we breaking by making it work?)
>=20
> Whilst this limitation has been known since the initial QEMU patch
> postings / kernel CXL region support, Fan Ni ran into it recently remindi=
ng
> me that we should solve it.
>=20
> Note that if you enable hdm_for_passthrough and use a configuration that
> would otherwise get a passthrough decoder, the linux kernel will currentl=
y
> fail to set it up correctly.  That's a bug / missing feature in Linux
> not an issue with the emulation.
>=20
> Based on series "[PATCH v4 00/10] hw/cxl: CXL emulation cleanups and mino=
r fixes for upstream"
> Based on series "[PATCH v6 0/8] hw/cxl: RAS error emulation and injection=
"
>=20
> Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
> Based on: Message-Id: 20230227112751.6101-1-Jonathan.Cameron@huawei.com
>=20
> Jonathan Cameron (2):
>   hw/pci: Add pcie_count_ds_port() and pcie_find_port_first() helpers
>   hw/pxb-cxl: Support passthrough HDM Decoders unless overridden
>=20
>  hw/cxl/cxl-host.c                   | 31 ++++++++++++--------
>  hw/pci-bridge/pci_expander_bridge.c | 44 +++++++++++++++++++++++++----
>  hw/pci/pcie_port.c                  | 38 +++++++++++++++++++++++++
>  include/hw/cxl/cxl.h                |  1 +
>  include/hw/cxl/cxl_component.h      |  1 +
>  include/hw/pci/pci_bridge.h         |  1 +
>  include/hw/pci/pcie_port.h          |  2 ++
>  7 files changed, 101 insertions(+), 17 deletions(-)
>=20
> --=20
> 2.37.2
>=20
>=20

The code looks good for me.

Applied the two patch series mentioned above before applying this patch
series on ToT, it is clean.
Tested to crete region, create namespace and convert to system RAM and
use it with simple command (numactl --membind=3D1 htop), no issue related
to the patch has been found.

Also tried with the latest volatile patch (Message-ID:
20230227163157.6621-1-Jonathan.Cameron@huawei.com), creating volatile
region and converting to system RAM (automatically) and online and test
it with the same command as for pmem above works fine.


Fan=
