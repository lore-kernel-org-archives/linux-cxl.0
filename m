Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0C0C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357162AbiDDVlH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380257AbiDDTVJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 15:21:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7F1B783
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 12:19:12 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t2so8588529qtw.9
        for <linux-cxl@vger.kernel.org>; Mon, 04 Apr 2022 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=95OywlD1CSIf3qwS0056RsX7eSrGjupy3ny6169oNc0=;
        b=O5FdBNrkMpZ9UAJ5rc5b1iUZJg1dJwPBOkN8tpWgvHEBRPFDsW37yOLDcg+t7oVn4x
         P2Rp5M71Gl2fKc/mIwZUHXg3nBbNE7iLDJcYXlnsYTCdmF7wKT4+ZT5SAYDkn4bxWQs/
         poiuqexoNn17/g9WCQLDFUpoeSy8klqH79rS1iRrMbQvfASQbjJRhfiLutTfVHPiVCOR
         65PDySI7vG50Wi7tlQ/TtcNRCQPf7YXKcThyA/UeIRluafuKxk1OmRj5XABa9J0+xh/h
         S8Gonr3Ll4iWJoMLVy2m/wvPb1N1FzlS41oWE+rHKKGPqPWuA7tSmKEmk1XkJhdGYBXL
         pkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=95OywlD1CSIf3qwS0056RsX7eSrGjupy3ny6169oNc0=;
        b=lCKdZvgrvaNInBK5ppFIaaEoVMmuXQRUdPkuoqTEhygWA3iTSwHo4OFBSPNDkQ/hUK
         2JpuXJM6scwHzpSiVujgm04el2AMz1ecEcM/RIZBN6bv/lpH9GiIXinsARa659RGORfq
         /c94Matp9LlC/qiwjvJZMus0kPKfujP0oPnUkGl03hKDapX4SjSPe7gjD6TENBrzB2Md
         CSYxxSR6R5yj9dahsElo12NUx2niV6DekLC55kmYWpEFydvIl8DWdYSusrH1F2qbc9kA
         X6oKyct6dpyvUY4Ci8gm6dGJNBS/Cu5MlrdcEbtijq4CL2So0P11TdzNT/wtW4oCctBZ
         O47Q==
X-Gm-Message-State: AOAM530TjpQuGXB0ncNPA+NPKuPPZhx5C7r/aoepjIkVZ176CNWbS9bV
        6arzc+y0HXbCHjraRHqrZN0=
X-Google-Smtp-Source: ABdhPJyE6ripkBu+Okix3ICyYspwQP+wSTguS2V2zDOH+6a7gqN9dzhF2QojrPHgDjWQal/qtFlaPg==
X-Received: by 2002:ac8:5784:0:b0:2e1:ed90:fc65 with SMTP id v4-20020ac85784000000b002e1ed90fc65mr1473205qta.232.1649099950985;
        Mon, 04 Apr 2022 12:19:10 -0700 (PDT)
Received: from smtpclient.apple (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.gmail.com with ESMTPSA id j20-20020a37a014000000b0067b3a0c7d89sm6614694qke.38.2022.04.04.12.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Apr 2022 12:19:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v9 18/45] hw/cxl/device: Implement MMIO HDM decoding
 (8.2.5.12)
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <20220404151445.10955-19-Jonathan.Cameron@huawei.com>
Date:   Mon, 4 Apr 2022 12:19:07 -0700
Cc:     linuxarm@huawei.com, qemu-devel@nongnu.org,
        =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, dave@stgolabs.net,
        Alison Schofield <alison.schofield@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC543734-8626-4F14-8449-E22969D18A7D@gmail.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
 <20220404151445.10955-19-Jonathan.Cameron@huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Apr 4, 2022, at 8:14 AM, Jonathan Cameron via =
<qemu-devel@nongnu.org> wrote:
>=20
> From: Ben Widawsky <ben.widawsky@intel.com>
>=20
> A device's volatile and persistent memory are known Host Defined =
Memory
> (HDM) regions. The mechanism by which the device is programmed to =
claim
> the addresses associated with those regions is through dedicated logic
> known as the HDM decoder. In order to allow the OS to properly program
> the HDMs, the HDM decoders must be modeled.
>=20
> There are two ways the HDM decoders can be implemented, the legacy
> mechanism is through the PCIe DVSEC programming from CXL 1.1 =
(8.1.3.8),
> and MMIO is found in 8.2.5.12 of the spec. For now, 8.1.3.8 is not
> implemented.
>=20
> Much of CXL device logic is implemented in cxl-utils. The HDM decoder
> however is implemented directly by the device implementation.
> Whilst the implementation currently does no validity checks on the
> encoder set up, future work will add sanity checking specific to
> the type of cxl component.
>=20
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
> hw/mem/cxl_type3.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 55 insertions(+)
>=20
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 329a6ea2a9..5c93fbbd9b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -50,6 +50,48 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>                                GPF_DEVICE_DVSEC_REVID, dvsec);
> }
>=20
> +static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
> +{
> +    ComponentRegisters *cregs =3D &ct3d->cxl_cstate.crb;
> +    uint32_t *cache_mem =3D cregs->cache_mem_registers;
> +
> +    assert(which =3D=3D 0);
> +
> +    /* TODO: Sanity checks that the decoder is possible */
> +    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
> +    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERR, 0);
> +
> +    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
> +}
> +
> +static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t =
value,
> +                           unsigned size)
> +{
> +    CXLComponentState *cxl_cstate =3D opaque;
> +    ComponentRegisters *cregs =3D &cxl_cstate->crb;
> +    CXLType3Dev *ct3d =3D container_of(cxl_cstate, CXLType3Dev, =
cxl_cstate);
> +    uint32_t *cache_mem =3D cregs->cache_mem_registers;
> +    bool should_commit =3D false;
> +    int which_hdm =3D -1;
> +
> +    assert(size =3D=3D 4);
> +    g_assert(offset <=3D CXL2_COMPONENT_CM_REGION_SIZE);
> +

Looks like this will allow offset =3D=3D CXL2_COMPONENT_CM_REGION_SIZE =
to pass the check, and cause a buffer overrun.
Shouldn=E2=80=99t this be g_assert(offset< =
CXL2_COMPONENT_CM_REGION_SIZE)?
We also need to make sure (offset + 4<=3D =
CXL2_COMPONENT_CM_REGION_SIZE).
Or maybe we just need offset +4 <=3D CXL2_COMPONENT_CM_REGION_SIZE here, =
if offset < CXL2_COMPONENT_CM_REGION_SIZE is already checked somewhere =
else.

> +    switch (offset) {
> +    case A_CXL_HDM_DECODER0_CTRL:
> +        should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, =
COMMIT);
> +        which_hdm =3D 0;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    stl_le_p((uint8_t *)cache_mem + offset, value);
> +    if (should_commit) {
> +        hdm_decoder_commit(ct3d, which_hdm);
> +    }
> +}
> +
> static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> {
>     MemoryRegion *mr;
> @@ -93,6 +135,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error =
**errp)
>     ct3d->cxl_cstate.pdev =3D pci_dev;
>     build_dvsecs(ct3d);
>=20
> +    regs->special_ops =3D g_new0(MemoryRegionOps, 1);
> +    regs->special_ops->write =3D ct3d_reg_write;
> +
>     cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
>                                       TYPE_CXL_TYPE3);
>=20
> @@ -107,6 +152,15 @@ static void ct3_realize(PCIDevice *pci_dev, Error =
**errp)
>                      &ct3d->cxl_dstate.device_registers);
> }
>=20
> +static void ct3_exit(PCIDevice *pci_dev)
> +{
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(pci_dev);
> +    CXLComponentState *cxl_cstate =3D &ct3d->cxl_cstate;
> +    ComponentRegisters *regs =3D &cxl_cstate->crb;
> +
> +    g_free(regs->special_ops);
> +}
> +
> static void ct3d_reset(DeviceState *dev)
> {
>     CXLType3Dev *ct3d =3D CXL_TYPE3(dev);
> @@ -128,6 +182,7 @@ static void ct3_class_init(ObjectClass *oc, void =
*data)
>     PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(oc);
>=20
>     pc->realize =3D ct3_realize;
> +    pc->exit =3D ct3_exit;
>     pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
>     pc->vendor_id =3D PCI_VENDOR_ID_INTEL;
>     pc->device_id =3D 0xd93; /* LVF for now */
> --=20
> 2.32.0
>=20
>=20
>=20

