Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BCFC433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 18:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiCAS3X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiCAS3T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Mar 2022 13:29:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708966516A
        for <linux-cxl@vger.kernel.org>; Tue,  1 Mar 2022 10:28:27 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p15so33244654ejc.7
        for <linux-cxl@vger.kernel.org>; Tue, 01 Mar 2022 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qWn8f/zcEThACHHu7HzVrOzQdOqQBxED78bE6EUhDxE=;
        b=uyjWNcsW6mwFZ+AJ9vhsG4li0vju83daLrm05o/Dhis7pnHymq26RkKNv+rLIeCOzm
         bOTqZj+HQQBjTGh2DqhkO+3N4Jxl+y10jTQq6EcuUUEIpxFFG9Bb1YyDeLCBrlVrn7cm
         9BVXzPAAdsditQS3xSgdvyzqJvuhhKZz/4iJt+BuyMTEESONCpVmhIoEbsZZaS1q12/B
         fkNyN5y2/lO+ASUGAn2CQ8uWgDG1gkWC76A6Rsuy8sJgtRq0SI79WpFlBYgiwwmyeQ0G
         GvLUe2byeA84JAPip+49OgF55gwvGPnZ1P5Iu/ygD4s92k4DDi4wZmhutTjqzcETz/5E
         DMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qWn8f/zcEThACHHu7HzVrOzQdOqQBxED78bE6EUhDxE=;
        b=pH2Lq5Rp/kbDh+g+pfI7MjqmZ33KC57gSPedsi7K/SnaP/8CKophre3KMFJpBYxfvM
         J+qhbK2NB45F4ulT8JfbP4hpRP7I6dmKhHoQj1FHTeQ2aREZmaMU6MvF3xo87JGt2H6l
         exQPpvMBfEiePAcpYvEk/g7QNBCbdpXyvU/rTq8bvqkbCsn4nTULcorV/hstbz61dDt+
         FNI7Q72+X39WZYyHaWJwY7YPu9/jmP2bNTf5kNOod2jz4bjClcsuGvTKsN0U0GaGm5yx
         QIDrbeWYevzOM7IbhOmCXpPyEQorCk1crhqNZNhbImvzPIKu+CKTi3cyglFF0QTgXbAT
         Jh6g==
X-Gm-Message-State: AOAM530CyofIo97DKXd7zh+7Gn5Ynzv/N5YWpPdyBtV2TvLRMFBJZwms
        J9lHHJpjRccu1777NOPCmLsADw==
X-Google-Smtp-Source: ABdhPJwYK263NnIBiELmpbYksqmULeF1YL2l/SICdrtOZ6R5LGVyVPMFshHx7y980IKq5nQHJllq2w==
X-Received: by 2002:a17:906:a1a:b0:6cf:d2d9:410c with SMTP id w26-20020a1709060a1a00b006cfd2d9410cmr20199459ejf.713.1646159305949;
        Tue, 01 Mar 2022 10:28:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm7371133edz.29.2022.03.01.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:28:25 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 6F05E1FFB7;
        Tue,  1 Mar 2022 18:28:24 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-20-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.9; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 19/43] hw/cxl/device: Implement MMIO HDM decoding
 (8.2.5.12)
Date:   Tue, 01 Mar 2022 18:17:35 +0000
In-reply-to: <20220211120747.3074-20-Jonathan.Cameron@huawei.com>
Message-ID: <87a6e9le7r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> A device's volatile and persistent memory are known Host Defined Memory
> (HDM) regions. The mechanism by which the device is programmed to claim
> the addresses associated with those regions is through dedicated logic
> known as the HDM decoder. In order to allow the OS to properly program
> the HDMs, the HDM decoders must be modeled.
>
> There are two ways the HDM decoders can be implemented, the legacy
> mechanism is through the PCIe DVSEC programming from CXL 1.1 (8.1.3.8),
> and MMIO is found in 8.2.5.12 of the spec. For now, 8.1.3.8 is not
> implemented.
>
> Much of CXL device logic is implemented in cxl-utils. The HDM decoder
> however is implemented directly by the device implementation.
> Whilst the implementation currently does no validity checks on the
> encoder set up, future work will add sanity checking specific to
> the type of cxl component.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c4021d2434..da091157f2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -61,6 +61,56 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>                                 REG_LOC_DVSEC_REVID, dvsec);
>  }
>=20=20
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
> +static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> +                           unsigned size)
> +{
> +    CXLComponentState *cxl_cstate =3D opaque;
> +    ComponentRegisters *cregs =3D &cxl_cstate->crb;
> +    CXLType3Dev *ct3d =3D container_of(cxl_cstate, CXLType3Dev, cxl_csta=
te);
> +    uint32_t *cache_mem =3D cregs->cache_mem_registers;
> +    bool should_commit =3D false;
> +    int which_hdm =3D -1;
> +
> +    assert(size =3D=3D 4);

Maybe add:

      g_assert(offset <=3D (CXL2_COMPONENT_CM_REGION_SIZE >> 2));


> +
> +    switch (offset) {
> +    case A_CXL_HDM_DECODER0_CTRL:
> +        should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMI=
T);
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
> +static void ct3_finalize(Object *obj)
> +{
> +    CXLType3Dev *ct3d =3D CT3(obj);
> +    CXLComponentState *cxl_cstate =3D &ct3d->cxl_cstate;
> +    ComponentRegisters *regs =3D &cxl_cstate->crb;
> +
> +    g_free((void *)regs->special_ops);

nit: you don't need to cast her.

> +}
> +
>  static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      MemoryRegion *mr;
> @@ -103,6 +153,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **e=
rrp)
>      ct3d->cxl_cstate.pdev =3D pci_dev;
>      build_dvsecs(ct3d);
>=20=20
> +    regs->special_ops =3D g_new0(MemoryRegionOps, 1);
> +    regs->special_ops->write =3D ct3d_reg_write;
> +
>      cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
>                                        TYPE_CXL_TYPE3_DEV);
>=20=20
> @@ -155,6 +208,7 @@ static const TypeInfo ct3d_info =3D {
>      .parent =3D TYPE_PCI_DEVICE,
>      .class_init =3D ct3_class_init,
>      .instance_size =3D sizeof(CXLType3Dev),
> +    .instance_finalize =3D ct3_finalize,
>      .interfaces =3D (InterfaceInfo[]) {
>          { INTERFACE_CXL_DEVICE },
>          { INTERFACE_PCIE_DEVICE },

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
