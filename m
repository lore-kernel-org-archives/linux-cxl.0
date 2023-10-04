Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10DE8FDDB
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 09:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbjJDJF0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 05:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjJDJFY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 05:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73EC98
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696410278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T81o7u6roDikZ5081lQAPabhuuZXQf4PW3FoSRj/fyI=;
        b=ELIDcboESJjYbdF0FRAJUkOnXUH24SbgpSog5TDuVu5n9Qru2d9YWPumabAwJcsmEegSe0
        Rr7P9Iqr/Y4Sik97Q1+ge5xY+GAYntIpPOwsPBs+Z2YXTxpr9zRGPVJ+LzUzt/RdtClRqo
        T7CpA2kWgcL9T1Z2X0scfMrDJqesNrs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-p8nRCIsnMgqR0HKhwWoIbw-1; Wed, 04 Oct 2023 05:04:37 -0400
X-MC-Unique: p8nRCIsnMgqR0HKhwWoIbw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3231fceb811so1435065f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Oct 2023 02:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696410276; x=1697015076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T81o7u6roDikZ5081lQAPabhuuZXQf4PW3FoSRj/fyI=;
        b=huCl40N63cK0it54+5cVx8uejXklRYhKa+LmERjH/A23Gxj9SHdb2BeXWJJhSk9v5K
         1BZ9GssL+jxBICdxJwQaZW9svDeMbbvSke6xruVZITTGITHJczeHln1SaXPPhJHqjeTE
         U9rBC5ta7RbV32pvc1Jkuc2GayLc4pswK+CvFh3JdXfRTaG0QzW6sazR2L0IdmFVk4De
         hmaHYMnMYXLkXX3vGiZFrZkHpXaXET1uaKHqbk6cNPCAmXUMWlsTMgZ5/4HCAt/xonO5
         oHaKrdFiGJT7WD3KSw4MjCsX6gc56wA7ZA0fNym6LsQITe+i7aVVIGv/34cWYACGp/o3
         1XyA==
X-Gm-Message-State: AOJu0YxZLqcxnd5h2ibjCv3nZHd+ttHOmTNjzyhHorD6QtAmSA7BcZku
        bPigxNIiu56uETxthuiG7Q5jkvESdZF+sUit/JM+4I0Wf/JOAq8WN84D4zoWkLSqkpRuFI8/3BN
        1Df/UoZSnuy3jSEVdcTdj
X-Received: by 2002:adf:fd46:0:b0:326:d915:d1c0 with SMTP id h6-20020adffd46000000b00326d915d1c0mr1523498wrs.56.1696410276544;
        Wed, 04 Oct 2023 02:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXDHzAFvi4HF4IACUBVzNE77xngOMGptwBEIPi9Uz6ff3bomvgHzMKZB1NiJClodmZiva4XQ==
X-Received: by 2002:adf:fd46:0:b0:326:d915:d1c0 with SMTP id h6-20020adffd46000000b00326d915d1c0mr1523474wrs.56.1696410276115;
        Wed, 04 Oct 2023 02:04:36 -0700 (PDT)
Received: from redhat.com ([2.52.137.96])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d4d48000000b00324ae863ac1sm3473195wru.35.2023.10.04.02.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:04:35 -0700 (PDT)
Date:   Wed, 4 Oct 2023 05:04:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 2/3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231004045943-mutt-send-email-mst@kernel.org>
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
 <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 04, 2023 at 05:18:46PM +0100, Jonathan Cameron wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> from the OS.
> 
> Following edited for readbility only
> 
> Device (CXLM)
> {
>     Name (_HID, "ACPI0017")  // _HID: Hardware ID
> ...
>     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>     {
>         If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
>         {
>             If ((Arg2 == Zero))
>             {
>                 Return (Buffer (One) { 0x01 })
>             }
> 
>             If ((Arg2 == One))
>             {
>                 Return (Package (0x02)
>                 {
>                     Buffer (0x02)
>                     { 0x01, 0x00 },
>                     Package (0x01)
>                     {
>                         Buffer (0x02)
>                         { 0x00, 0x00 }
>                     }
>                 })
>             }
>         }
>     }
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> v2: Minor edit to drop reference to switches in patch description.
> ---

>  include/hw/acpi/cxl.h |  1 +
>  hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c  |  1 +
>  3 files changed, 59 insertions(+)


This is not the right way to format it. The correct way is:

---
v2: Minor edit to drop reference to switches in patch description.

 include/hw/acpi/cxl.h |  1 +
 hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |  1 +
 3 files changed, 59 insertions(+)

The way you do it breaks b4 and a bunch of other tools.  signatures must
come last before ---, then versioning info (which generally does not
need to be in git because readers of git have no access to older
versions, though there could be exceptions. If there's anything relevant
in this versioning history, such as some design directions which were
tried and discarded, then put it above ---). Then the diff.


> 
> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> index acf4418886..8f22c71530 100644
> --- a/include/hw/acpi/cxl.h
> +++ b/include/hw/acpi/cxl.h
> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
>                      BIOSLinker *linker, const char *oem_id,
>                      const char *oem_table_id, CXLState *cxl_state);
>  void build_cxl_osc_method(Aml *dev);
> +void build_cxl_dsm_method(Aml *dev);
>  
>  #endif
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index 92b46bc932..5e9039785a 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -30,6 +30,63 @@
>  #include "qapi/error.h"
>  #include "qemu/uuid.h"
>  
> +void build_cxl_dsm_method(Aml *dev)
> +{
> +    Aml *method, *ifctx, *ifctx2;
> +
> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> +    {
> +        Aml *function, *uuid;
> +
> +        uuid = aml_arg(0);
> +        function = aml_arg(2);
> +        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
> +        ifctx = aml_if(aml_equal(
> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> +
> +        /* Function 0, standard DSM query function */
> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> +        {
> +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
> +
> +            aml_append(ifctx2,
> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> +        }
> +        aml_append(ifctx, ifctx2);
> +
> +        /*
> +         * Function 1
> +         * A return value of {1, {0}} inciate that
> +         * max supported QTG ID of 1 and recommended QTG is 0.
> +         * The values here are faked to simplify emulation.
> +         */
> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> +        {
> +            uint16_t word_list[1] = { 0x01 };
> +            uint16_t word_list2[1] = { 0 };
> +            uint8_t *byte_list = (uint8_t *)word_list;
> +            uint8_t *byte_list2 = (uint8_t *)word_list2;
> +            Aml *pak, *pak1;
> +
> +            /*
> +             * The return package is a package of a WORD and another package.
> +             * The embedded package contains 0 or more WORDs for the
> +             * recommended QTG IDs.
> +             */
> +            pak1 = aml_package(1);
> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
> +            pak = aml_package(2);
> +            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
> +            aml_append(pak, pak1);
> +
> +            aml_append(ifctx2, aml_return(pak));
> +        }
> +        aml_append(ifctx, ifctx2);
> +    }
> +    aml_append(method, ifctx);
> +    aml_append(dev, method);
> +}
> +
>  static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
>  {
>      PXBDev *pxb = PXB_DEV(cxl);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index bb12b0ad43..d3bc5875eb 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
>      method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>      aml_append(method, aml_return(aml_int(0x01)));
>      aml_append(dev, method);
> +    build_cxl_dsm_method(dev);
>  
>      aml_append(scope, dev);
>      aml_append(table, scope);
> -- 
> 2.39.2

