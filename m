Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF00C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 10:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiCBKDb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiCBKDa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 05:03:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB61A39F
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 02:02:46 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gb39so2602981ejc.1
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 02:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CEyFdGZ4NDGvlPW9W8Qw2obeZKrSwxw5+wQygpI24AU=;
        b=qhCTZs6n7Gt12TSqKvV52YSX9+FaG/NF3/OIB+ut4wvyhxrBSkX0958Ky41AElqq3B
         LzbgJ0oTXS7fajPDSbzBbPdEZfvtvXl9b7O4vjQ6v3nVDCX4C1H87081yr4CRrGojtY1
         KArfqm+aKh7+oQKHz9C95BvK+UgNe5J7hpP6Mmz5xvIAbp7crQcxi4AF3OJtnbqCzThc
         CojrWnC5O67LbOvi8EoGJgzqnTEx9fFrDYicSoLpe0VQelYyakyzZM44gKSxoivFlXrJ
         mG43fCqns/rfzKqRVhpxQCDmErj5pTJV4xkvWDlKuJQ/+aYLdbT9ogVTNLhQvFlOb495
         uzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CEyFdGZ4NDGvlPW9W8Qw2obeZKrSwxw5+wQygpI24AU=;
        b=B/XYvLkmnvPD9u4yVKMrktLfIEQSKYh1xRBIAXMKQ/eaG0POiRSXUtJMGQ7mjvbZbu
         bk6ux2hx60kqdRa6MSfOlc/9oYmCvoJcF1VRLM8iqhngf0mv7PninuySWqEtAHbn4yFu
         q3KrZ5KCOLlpXKbgIcotBjtXAbbKr1ReWq150fSFKWeq3Z/QBeA/9V7DWTKc5BkT5/fI
         RhBabOt34c6cIOrgBelzvOyVATcrjRzVQ+Yv52PmAtycQ8bZGGsOZCgFO/7IHU/8Qxyf
         ugfX5rIBZbUMSMCtrhxwvFW3hJdhLuIKat324HZE/L82AfcoHcnGHrt6njIxoiRJWGgA
         hQ1A==
X-Gm-Message-State: AOAM532zgq5GBicHx+C0CKjdsWEGW/OJmTixP1L9Ss6fphkpPMPNsbeB
        LEZhYtqqhEAYGx0Xb9af30ZInw==
X-Google-Smtp-Source: ABdhPJwTGSgcywkqr8NTeW2GoIzODYYijilJ1R1QbnEGEr12DgzIbDLkHICcD+MqTBmSbjW0qLrFTw==
X-Received: by 2002:a17:907:1c9a:b0:6d8:633c:be32 with SMTP id nb26-20020a1709071c9a00b006d8633cbe32mr2804272ejc.159.1646215364736;
        Wed, 02 Mar 2022 02:02:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id m22-20020a056402051600b00415a0cbd561sm1204294edv.74.2022.03.02.02.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 02:02:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 915881FFB7;
        Wed,  2 Mar 2022 10:02:42 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-22-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 21/43] hw/cxl/device: Plumb real Label Storage Area
 (LSA) sizing
Date:   Wed, 02 Mar 2022 10:01:48 +0000
In-reply-to: <20220211120747.3074-22-Jonathan.Cameron@huawei.com>
Message-ID: <871qzkllj1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> This should introduce no change. Subsequent work will make use of this
> new class member.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  3 +++
>  hw/mem/cxl_type3.c          | 24 +++++++++---------------
>  include/hw/cxl/cxl_device.h | 29 +++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 15 deletions(-)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d022711b2a..ccf9c3d794 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -278,6 +278,8 @@ static ret_code cmd_identify_memory_device(struct cxl=
_cmd *cmd,
>      } __attribute__((packed)) *id;
>      _Static_assert(sizeof(*id) =3D=3D 0x43, "Bad identify size");
>=20=20
> +    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
> +    CXLType3Class *cvc =3D CXL_TYPE3_DEV_GET_CLASS(ct3d);
>      uint64_t size =3D cxl_dstate->pmem_size;
>=20=20
>      if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> @@ -292,6 +294,7 @@ static ret_code cmd_identify_memory_device(struct cxl=
_cmd *cmd,
>=20=20
>      id->total_capacity =3D size / (256 << 20);
>      id->persistent_capacity =3D size / (256 << 20);
> +    id->lsa_size =3D cvc->get_lsa_size(ct3d);
>=20=20
>      *len =3D sizeof(*id);
>      return CXL_MBOX_SUCCESS;
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index da091157f2..b16262d3cc 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -13,21 +13,6 @@
>  #include "sysemu/hostmem.h"
>  #include "hw/cxl/cxl.h"
>=20=20
> -typedef struct cxl_type3_dev {
> -    /* Private */
> -    PCIDevice parent_obj;
> -
> -    /* Properties */
> -    uint64_t size;
> -    HostMemoryBackend *hostmem;
> -
> -    /* State */
> -    CXLComponentState cxl_cstate;
> -    CXLDeviceState cxl_dstate;
> -} CXLType3Dev;
> -
> -#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
> -

If the structure had been in the header to start with it would be easier
to see the changes added for this bit.


>  static void build_dvsecs(CXLType3Dev *ct3d)
>  {
>      CXLComponentState *cxl_cstate =3D &ct3d->cxl_cstate;
> @@ -186,10 +171,16 @@ static Property ct3_props[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20=20
> +static uint64_t get_lsa_size(CXLType3Dev *ct3d)
> +{
> +    return 0;
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
>      PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(oc);
> +    CXLType3Class *cvc =3D CXL_TYPE3_DEV_CLASS(oc);
>=20=20
>      pc->realize =3D ct3_realize;
>      pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
> @@ -201,11 +192,14 @@ static void ct3_class_init(ObjectClass *oc, void *d=
ata)
>      dc->desc =3D "CXL PMEM Device (Type 3)";
>      dc->reset =3D ct3d_reset;
>      device_class_set_props(dc, ct3_props);
> +
> +    cvc->get_lsa_size =3D get_lsa_size;
>  }
>=20=20
>  static const TypeInfo ct3d_info =3D {
>      .name =3D TYPE_CXL_TYPE3_DEV,
>      .parent =3D TYPE_PCI_DEVICE,
> +    .class_size =3D sizeof(struct CXLType3Class),
>      .class_init =3D ct3_class_init,
>      .instance_size =3D sizeof(CXLType3Dev),
>      .instance_finalize =3D ct3_finalize,
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 8102d2a813..ebb391153a 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -230,4 +230,33 @@ REG64(CXL_MEM_DEV_STS, 0)
>      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
>=20=20
> +typedef struct cxl_type3_dev {
> +    /* Private */
> +    PCIDevice parent_obj;
> +
> +    /* Properties */
> +    uint64_t size;
> +    HostMemoryBackend *hostmem;
> +    HostMemoryBackend *lsa;
> +
> +    /* State */
> +    CXLComponentState cxl_cstate;
> +    CXLDeviceState cxl_dstate;
> +} CXLType3Dev;
> +
> +#ifndef TYPE_CXL_TYPE3_DEV
> +#define TYPE_CXL_TYPE3_DEV "cxl-type3"
> +#endif
> +
> +#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
> +OBJECT_DECLARE_TYPE(CXLType3Device, CXLType3Class, CXL_TYPE3_DEV)
> +
> +struct CXLType3Class {
> +    /* Private */
> +    PCIDeviceClass parent_class;
> +
> +    /* public */
> +    uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
> +};
> +
>  #endif


--=20
Alex Benn=C3=A9e
