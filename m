Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310ADC6FD19
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Mar 2023 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCFRxf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCFRxe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Mar 2023 12:53:34 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148F34695
        for <linux-cxl@vger.kernel.org>; Mon,  6 Mar 2023 09:52:54 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230306175209usoutp021f23a974afd4ce2172a8178e64fdbc5c~J5eoWwmuB2344623446usoutp02u;
        Mon,  6 Mar 2023 17:52:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230306175209usoutp021f23a974afd4ce2172a8178e64fdbc5c~J5eoWwmuB2344623446usoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678125129;
        bh=i9BQsucezU4Rmlja/d6uo0vuBh2yIqUpp1n2tfrG1Ss=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=CHoStOExF9InI6j2MmoH0wSK4qmAKDN60byKFe3M1Lk9EYL7XGIO0rWl+ftdspefT
         zxc0HCSsR4Vv5gm5gRSaNbTm1xZf6bl3/1PQQQ9Bqodxp0LsGYm3vygjHLE8eOZEJH
         jK/gkKxdLUiFrQli6ITlTw1GyjwqDDbNHp+u55aM=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230306175209uscas1p1d9ea02a7f936857472aee93971be8ec0~J5eoNe8ej1902119021uscas1p1D;
        Mon,  6 Mar 2023 17:52:09 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 0D.0E.06976.94826046; Mon, 
        6 Mar 2023 12:52:09 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230306175209uscas1p2be7df0b3ca2b2002f1a47b2125e35c08~J5envra1W0489604896uscas1p2S;
        Mon,  6 Mar 2023 17:52:09 +0000 (GMT)
X-AuditID: cbfec36d-afdff70000011b40-88-64062849c673
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 63.45.11378.84826046; Mon, 
        6 Mar 2023 12:52:08 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 6 Mar 2023 09:52:08 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        6 Mar 2023 09:52:08 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 5/8] hw/mem/cxl-type3: Add AER extended
 capability
Thread-Topic: [RESEND PATCH v6 5/8] hw/mem/cxl-type3: Add AER extended
        capability
Thread-Index: AQHZTQx27w9dnzyqak6Y5Q3HlD9Ufq7ulL+A
Date:   Mon, 6 Mar 2023 17:52:08 +0000
Message-ID: <20230306175207.GE1489326@bgt-140510-bm03>
In-Reply-To: <20230302133709.30373-6-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5F107F0B8F992742B5D031A2CC2BED48@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djX87qeGmwpBq+7pC3uPr7AZjF/7X0W
        izdv1jBZnLjZyGYx8e16Vov9T5+zWKxaeI3N4vysUywWhzeeYbJY0NbOarHm/iFWi99rHzNZ
        /P/1CshdIWxxvHcHi8XKYzYOAh6tl/6yeeycdZfdo+XIW1aPxXteMnncubaHzePJtc1MHu/3
        XWXz+LxJLoAjissmJTUnsyy1SN8ugSvj/5MeloJ3/BVbe/YxNTBe5+li5OSQEDCRuPDnFmMX
        IxeHkMBKRonDXb/YIZxWJonezv1ADgdY1fGHyRDxtYwS/5fdYoFwPjJKNH37xQrhLAVq33qR
        FWQum4CixL6u7WwgtoiAkcS7G5PAdjAL7GGV+DhjPjtIQlggSGLWl05GiKJgidXPdzLCNLw8
        cRdsEIuAisSf8+/BBvEKmEl8OXMUzOYUcJTY/m8fWD2jgJjE91NrmEBsZgFxiVtP5jNBPCco
        sWj2HmYIW0zi366HbBC2osT97y/ZIer1JG5MncIGYdtJ/Hq3lQXC1pZYtvA1M8ReQYmTM5+w
        QPRKShxccQPKXs0pce4SHySIXCRmbSqDCEtLXL0+lRkinCyx6iMXRDhHYv6SLVCd1hIL/6xn
        msCoMgvJ0bOQHDQLyUGzkBw0C8lBCxhZVzGKlxYX56anFhvmpZbrFSfmFpfmpesl5+duYgQm
        xNP/DufuYNxx66PeIUYmDsZDjBIczEoivFW/WVOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xra
        nkwWEkhPLEnNTk0tSC2CyTJxcEo1MC0qn8SwVMQjPPsJv58al/Ve6bDtOpNqJLs1Nm5pM5lZ
        x7Nbu85xXfr7xrLZ8psZ7mQ9c2VMm3mMud7ji8Qabf30Ji3fU5Knm79zcvqz/WLj/C3BpCQ+
        X9/vRmH3ru3/9f+cjb+/Vk1s2RFNkU3CjXue3CgVPFF/nf/D7LcZM0tKrmvF12oubDeOMZ/9
        kidf+6v1v02Cn9s6dvq/j/6x6Xl3R0F2iJevyU/nmWGsz9TNt3xSlXC+8uFflZNdjPjjVM47
        pkHW6SXqyWV75Vu0ZkmHF10sudn1vzfZpaxjxaH9cyNMJuztPdcreXvpMo+Ukt/nxWrv7J6t
        /dom2T4x6kTXiXOF8y9+Wt+/pHiNEktxRqKhFnNRcSIAGagZcvcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LJbGCaqOuhwZZi0L7UyuLu4wtsFvPX3mex
        ePNmDZPFiZuNbBYT365ntdj/9DmLxaqF19gszs86xWJxeOMZJosFbe2sFmvuH2K1+L32MZPF
        /1+vgNwVwhbHe3ewWKw8ZuMg4NF66S+bx85Zd9k9Wo68ZfVYvOclk8eda3vYPJ5c28zk8X7f
        VTaPz5vkAjiiuGxSUnMyy1KL9O0SuDL+P+lhKXjHX7G1Zx9TA+N1ni5GDg4JAROJ4w+Tuxi5
        OIQEVjNK7Nrygh3C+cgoMW17L5SzlFFi65JHbF2MnBxsAooS+7q2g9kiAkYS725MYgQpYhbY
        xSrxeOlzdpCEsECQxKwvnYwQRcESDZcWMcE0vDxxlxXEZhFQkfhz/j3YIF4BM4kvZ46C2UIC
        5RL/Pm9mBrE5BRwltv/bBzaHUUBM4vupNWBzmAXEJW49mQ9mSwgISCzZc54ZwhaVePn4HyuE
        rShx//tLdoh6PYkbU6ewQdh2Er/ebWWBsLUlli18zQxxg6DEyZlPWCB6JSUOrrjBMoFRYhaS
        dbOQjJqFZNQsJKNmIRm1gJF1FaN4aXFxbnpFsWFearlecWJucWleul5yfu4mRmBCOf3vcOQO
        xqO3PuodYmTiYDzEKMHBrCTCW/WbNUWINyWxsiq1KD++qDQntfgQozQHi5I4r5DrxHghgfTE
        ktTs1NSC1CKYLBMHp1QD09S7D/p3Mv8+v+jzaX/exJO6yWes5lQ8kF51VjtjiVdH3MpDXP4X
        fHxfPSxt7YtvW2Xq8rVQLmS25bpltyNWfqrJnexySrVa8jKrnY5084Gutimn572ZeNDCKKsi
        ooKl9NDrv3p7pB1TV2wX/fOkU05zzi3fRJectrqbuVHfSnl4zX9sVpxx4Ydn1b3MSJnuBzVn
        kzY+kDld21yXeU9dpIlhx8FV7/lT77fO5ng/8cybJbFpOftWurx11d/u1zfn17YZfmz97DH+
        2d++c8Ut2JDNZOexeuf9WtsTpXuUvPxPNS5T2WP3tPxyKfuLtv0iW7jOBPZMC08+dufE603+
        lafv8jIX/JyWbbnHwsRwjhJLcUaioRZzUXEiACvz7oqXAwAA
X-CMS-MailID: 20230306175209uscas1p2be7df0b3ca2b2002f1a47b2125e35c08
CMS-TYPE: 301P
X-CMS-RootMailID: 20230306175209uscas1p2be7df0b3ca2b2002f1a47b2125e35c08
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
        <20230302133709.30373-6-Jonathan.Cameron@huawei.com>
        <CGME20230306175209uscas1p2be7df0b3ca2b2002f1a47b2125e35c08@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 02, 2023 at 01:37:06PM +0000, Jonathan Cameron wrote:
> This enables AER error injection to function as expected.
> It is intended as a building block in enabling CXL RAS error injection
> in the following patches.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/mem/cxl_type3.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 217a5e639b..6cdd988d1d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -250,6 +250,7 @@ static void ct3d_config_write(PCIDevice *pci_dev, uin=
t32_t addr, uint32_t val,
> =20
>      pcie_doe_write_config(&ct3d->doe_cdat, addr, val, size);
>      pci_default_write_config(pci_dev, addr, val, size);
> +    pcie_aer_write_config(pci_dev, addr, val, size);
>  }
> =20
>  /*
> @@ -452,8 +453,19 @@ static void ct3_realize(PCIDevice *pci_dev, Error **=
errp)
>      cxl_cstate->cdat.free_cdat_table =3D ct3_free_cdat_table;
>      cxl_cstate->cdat.private =3D ct3d;
>      cxl_doe_cdat_init(cxl_cstate, errp);
> +
> +    pcie_cap_deverr_init(pci_dev);
> +    /* Leave a bit of room for expansion */
> +    rc =3D pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NU=
LL);
> +    if (rc) {
> +        goto err_release_cdat;
> +    }
> +
>      return;
> =20
> +err_release_cdat:
> +    cxl_doe_cdat_release(cxl_cstate);
> +    g_free(regs->special_ops);
>  err_address_space_free:
>      address_space_destroy(&ct3d->hostmem_as);
>      return;
> @@ -465,6 +477,7 @@ static void ct3_exit(PCIDevice *pci_dev)
>      CXLComponentState *cxl_cstate =3D &ct3d->cxl_cstate;
>      ComponentRegisters *regs =3D &cxl_cstate->crb;
> =20
> +    pcie_aer_exit(pci_dev);
>      cxl_doe_cdat_release(cxl_cstate);
>      g_free(regs->special_ops);
>      address_space_destroy(&ct3d->hostmem_as);
> --=20
> 2.37.2
>=20
> =
