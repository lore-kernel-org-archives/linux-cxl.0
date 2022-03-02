Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E127BC433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 10:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiCBKJe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiCBKJe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 05:09:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D31DFF5
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 02:08:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so1854528wrg.11
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 02:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BmU1Cm68ARI4+Jb/RYpxJtQVrn5VLXdD9Ez9K9XLa1c=;
        b=o/1QB1clQoqj1I+aOQujXjKtsG1nFEug0DpSJ719ZJo8lfFPPiap/fP1Lb1Q3L83p+
         WDAEv77AMUv0QgGXzzGkQlxwtu51W5W/Kkk92k0WKavCCuwlb/80kruTPVUlcKODVkKa
         FLw8mmCCGNzRX7/X1MTd4+tfXXnwSnVT8RK8onCZ/37jwqv+EUwsnPQUXpfR2kxdLIvZ
         8l0+9w0my9626O5JN3trpx1+Gce7zUQ2eMSsLv1sAbbaQe014H6xkFZ5bpRVJ4ufn0W6
         3SVqdmKdFguNdovQk6QXwpkupawD1mGQmUz1kTCGfACtEqCP4XD/7DMRZhuypggFPdM1
         Xdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BmU1Cm68ARI4+Jb/RYpxJtQVrn5VLXdD9Ez9K9XLa1c=;
        b=taPajEKV/CDVTJ0i85qhbjXRoiKgw1y6IDITcvFptzczYINBAC1GYnVkN8z7XeaBpY
         PPS1zFjUIofOdQWKDi4uzVEXzOSR/wKyWHxp1fpNFR8A7pXLdhkaBbZBrTwJhERIx9gV
         8iSC//JciLGMYAyQ4N0refbUBStylleCGOqnz2kY0pTZ72JlxBPpsd1JgYS6kgnjy/dw
         mmbiy93YUX/EG1zf3IG2/mcJqDvv0L47GWJg6avu8aa7KIie5WQ1w+4+/NtfZWtDNnHw
         B5gEugZibDQ6bwCRTMsFgPEjhpy0hUd8dbcM6Nx/1gOG/N2Ifk2ozJ1a3yVYpp+hCleY
         WxDw==
X-Gm-Message-State: AOAM53008WfZ3fK7zVkrNvd78lPDFLKtWg/NvNg5yP+EZcHypuWLQGom
        SrYthqE+0DNTkZpI1bn8Oo9WUA==
X-Google-Smtp-Source: ABdhPJxrbOqoHGlW2XaQPKaIP2lmjMQsu/hiYMPvJ39LggA5+JpenT2XyrUqoldwg3Jjy2j1PqxoQA==
X-Received: by 2002:adf:fcd0:0:b0:1ef:31fe:d08e with SMTP id f16-20020adffcd0000000b001ef31fed08emr20505654wrs.667.1646215727318;
        Wed, 02 Mar 2022 02:08:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b001f0256761b9sm3121267wrt.45.2022.03.02.02.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 02:08:46 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 710C81FFB7;
        Wed,  2 Mar 2022 10:08:45 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-23-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 22/43] hw/cxl/device: Implement get/set Label Storage
 Area (LSA)
Date:   Wed, 02 Mar 2022 10:03:34 +0000
In-reply-to: <20220211120747.3074-23-Jonathan.Cameron@huawei.com>
Message-ID: <87wnhck6oi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> Implement get and set handlers for the Label Storage Area
> used to hold data describing persistent memory configuration
> so that it can be ensured it is seen in the same configuration
> after reboot.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 57 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 56 +++++++++++++++++++++++++++++++++++-
>  include/hw/cxl/cxl_device.h |  5 ++++
>  3 files changed, 117 insertions(+), 1 deletion(-)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ccf9c3d794..f4a309ddbf 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -56,6 +56,8 @@ enum {
>          #define MEMORY_DEVICE 0x0
>      CCLS        =3D 0x41,
>          #define GET_PARTITION_INFO     0x0
> +        #define GET_LSA       0x2
> +        #define SET_LSA       0x3
>  };
>=20=20
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -327,7 +329,59 @@ static ret_code cmd_ccls_get_partition_info(struct c=
xl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>=20=20
> +static ret_code cmd_ccls_get_lsa(struct cxl_cmd *cmd,
> +                                 CXLDeviceState *cxl_dstate,
> +                                 uint16_t *len)
> +{
> +    struct {
> +        uint32_t offset;
> +        uint32_t length;
> +    } __attribute__((packed, __aligned__(8))) *get_lsa;
> +    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
> +    CXLType3Class *cvc =3D CXL_TYPE3_DEV_GET_CLASS(ct3d);
> +    uint32_t offset, length;
> +
> +    get_lsa =3D (void *)cmd->payload;
> +    offset =3D get_lsa->offset;
> +    length =3D get_lsa->length;
> +
> +    *len =3D 0;

This can drop into the failure leg.

> +    if (offset + length > cvc->get_lsa_size(ct3d)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    *len =3D cvc->get_lsa(ct3d, get_lsa, length, offset);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static ret_code cmd_ccls_set_lsa(struct cxl_cmd *cmd,
> +                                 CXLDeviceState *cxl_dstate,
> +                                 uint16_t *len)
> +{
> +    struct {
> +        uint32_t offset;
> +        uint32_t rsvd;
> +    } __attribute__((packed, __aligned__(8))) *set_lsa =3D (void *)cmd->=
payload;
> +    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
> +    CXLType3Class *cvc =3D CXL_TYPE3_DEV_GET_CLASS(ct3d);
> +    uint16_t plen =3D *len;
> +
> +    *len =3D 0;
> +    if (!plen) {
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    if (set_lsa->offset + plen > cvc->get_lsa_size(ct3d) + sizeof(*set_l=
sa)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    cvc->set_lsa(ct3d, (void *)set_lsa + sizeof(*set_lsa),
> +                 plen - sizeof(*set_lsa), set_lsa->offset);

All these sizeof's make me wonder if these structures should be public
with a #define? Failing that having

  const size_t lsa_len =3D sizeof(*set_lsa);

and use that might make the flow a bit easier to scan. That said why
isn't set_lsa taking a type of *set_lsa instead of having void casts?

> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> +#define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
>  #define IMMEDIATE_LOG_CHANGE (1 << 4)
>=20=20
> @@ -350,6 +404,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
>          cmd_identify_memory_device, 0, 0 },
>      [CCLS][GET_PARTITION_INFO] =3D { "CCLS_GET_PARTITION_INFO",
>          cmd_ccls_get_partition_info, 0, 0 },
> +    [CCLS][GET_LSA] =3D { "CCLS_GET_LSA", cmd_ccls_get_lsa, 0, 0 },
> +    [CCLS][SET_LSA] =3D { "CCLS_SET_LSA", cmd_ccls_set_lsa,
> +        ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
>  };
>=20=20
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b16262d3cc..b1ba4bf0de 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -8,6 +8,7 @@
>  #include "qapi/error.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "qemu/pmem.h"
>  #include "qemu/range.h"
>  #include "qemu/rcu.h"
>  #include "sysemu/hostmem.h"
> @@ -114,6 +115,11 @@ static void cxl_setup_memory(CXLType3Dev *ct3d, Erro=
r **errp)
>      memory_region_set_enabled(mr, true);
>      host_memory_backend_set_mapped(ct3d->hostmem, true);
>      ct3d->cxl_dstate.pmem_size =3D ct3d->hostmem->size;
> +
> +    if (!ct3d->lsa) {
> +        error_setg(errp, "lsa property must be set");
> +        return;
> +    }
>  }
>=20=20
>=20=20
> @@ -168,12 +174,58 @@ static Property ct3_props[] =3D {
>      DEFINE_PROP_SIZE("size", CXLType3Dev, size, -1),
>      DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
>                       HostMemoryBackend *),
> +    DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
> +                     HostMemoryBackend *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20=20
>  static uint64_t get_lsa_size(CXLType3Dev *ct3d)
>  {
> -    return 0;
> +    MemoryRegion *mr;
> +
> +    mr =3D host_memory_backend_get_memory(ct3d->lsa);
> +    return memory_region_size(mr);
> +}
> +
> +static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
> +                                uint64_t offset)
> +{
> +    assert(offset + size <=3D memory_region_size(mr));
> +    assert(offset + size > offset);
> +}
> +
> +static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
> +                    uint64_t offset)
> +{
> +    MemoryRegion *mr;
> +    void *lsa;
> +
> +    mr =3D host_memory_backend_get_memory(ct3d->lsa);
> +    validate_lsa_access(mr, size, offset);
> +
> +    lsa =3D memory_region_get_ram_ptr(mr) + offset;
> +    memcpy(buf, lsa, size);
> +
> +    return size;
> +}
> +
> +static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> +                    uint64_t offset)
> +{
> +    MemoryRegion *mr;
> +    void *lsa;
> +
> +    mr =3D host_memory_backend_get_memory(ct3d->lsa);
> +    validate_lsa_access(mr, size, offset);
> +
> +    lsa =3D memory_region_get_ram_ptr(mr) + offset;
> +    memcpy(lsa, buf, size);
> +    memory_region_set_dirty(mr, offset, size);
> +
> +    /*
> +     * Just like the PMEM, if the guest is not allowed to exit gracefull=
y, label
> +     * updates will get lost.
> +     */
>  }
>=20=20
>  static void ct3_class_init(ObjectClass *oc, void *data)
> @@ -194,6 +246,8 @@ static void ct3_class_init(ObjectClass *oc, void *dat=
a)
>      device_class_set_props(dc, ct3_props);
>=20=20
>      cvc->get_lsa_size =3D get_lsa_size;
> +    cvc->get_lsa =3D get_lsa;
> +    cvc->set_lsa =3D set_lsa;
>  }
>=20=20
>  static const TypeInfo ct3d_info =3D {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ebb391153a..43908f161b 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -257,6 +257,11 @@ struct CXLType3Class {
>=20=20
>      /* public */
>      uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
> +
> +    uint64_t (*get_lsa)(CXLType3Dev *ct3d, void *buf, uint64_t size,
> +                        uint64_t offset);
> +    void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> +                    uint64_t offset);
>  };
>=20=20
>  #endif


--=20
Alex Benn=C3=A9e
