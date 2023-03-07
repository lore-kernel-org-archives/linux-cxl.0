Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72086C6FD1A
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 17:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCGR2b (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCGR2H (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 12:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D456085346
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678209753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s0fMvlwYeZ9VJzz1nUbXpu55BrZLMxXWkSj/nRItKw4=;
        b=PfQx1uhLJQSanR36D9AiNdrRBXtiIYMt64nRRxuonV9JhTHoElfv8E3Tw7IzNzmuO7u7+2
        Gkb1bovL4Gy6cumtOmNypaUmK7SyAoer8Z+l1yO/Ds9QmlzpjRbQ5fmTXlWSN0NvihwSe+
        phWiPPOAYTkAYi0/3PQWDjKplyoIVTE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-oHGftSuKOZO2qg2go-p9iw-1; Tue, 07 Mar 2023 12:22:32 -0500
X-MC-Unique: oHGftSuKOZO2qg2go-p9iw-1
Received: by mail-wm1-f71.google.com with SMTP id j32-20020a05600c1c2000b003e9bdf02c9fso8531842wms.6
        for <linux-cxl@vger.kernel.org>; Tue, 07 Mar 2023 09:22:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0fMvlwYeZ9VJzz1nUbXpu55BrZLMxXWkSj/nRItKw4=;
        b=dUK6Pj4pcmF/bHpccJqXks8uCzyEjPqVw8/CCbhcNfnmKdNxcC3RgAfc2PkeQ9KNbW
         3/r/3Y43SaJhlxYv+f+YOWNSjAJ3XuZ3OzU21xCPq4+zogUhavu+9HXcjxWs3b7yVkxg
         VPC8Ci9USBB5uGk2tNydcNqQsco4YUFs0OGABnnJwwOjryNbE9Eu0HjjXTKiD81J3d2P
         FHvlStMvUQ78MWByJQzHNjmMpPetSTTHp/3aB04DIH+R0pDN4mgdFylOdeQaI88y9/dn
         mZFXzHOXCEJ6P9mxo06GWRIPRyR77lk2AE4HriIqcAXWTe+Pis6A4FjjZeEb1UVjvU+V
         mOeg==
X-Gm-Message-State: AO0yUKVYFUIDndc8RaT5MkD1S4eLjd+H5xorV0DukMxTAj9xQOLRBllJ
        3V48Gi8pPjgAfTTxPPxREe+SGF0u2BGUrPAyyihUDZso/Oy72fTQpqHPuzfhh40X+MUQ8McmZO9
        Mh2/tbYQYravwqOcHPLf9
X-Received: by 2002:a05:600c:3591:b0:3eb:3998:8c05 with SMTP id p17-20020a05600c359100b003eb39988c05mr10692925wmq.6.1678209750823;
        Tue, 07 Mar 2023 09:22:30 -0800 (PST)
X-Google-Smtp-Source: AK7set8RnMF/LpiIhVHUBNK0GRyyQ7r9K2NkTT5SrkqtTpYqLQaARox3ifCoyzkgq0QDmia8ZJ8k5Q==
X-Received: by 2002:a05:600c:3591:b0:3eb:3998:8c05 with SMTP id p17-20020a05600c359100b003eb39988c05mr10692895wmq.6.1678209750392;
        Tue, 07 Mar 2023 09:22:30 -0800 (PST)
Received: from redhat.com ([2.52.138.216])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003e1fee8baacsm18324475wmo.25.2023.03.07.09.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:22:29 -0800 (PST)
Date:   Tue, 7 Mar 2023 12:22:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 8/8] hw/mem/cxl_type3: Add CXL RAS Error
 Injection Support.
Message-ID: <20230307122202-mutt-send-email-mst@kernel.org>
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
 <20230302133709.30373-9-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230302133709.30373-9-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 02, 2023 at 01:37:09PM +0000, Jonathan Cameron wrote:
> CXL uses PCI AER Internal errors to signal to the host that an error has
> occurred. The host can then read more detailed status from the CXL RAS
> capability.
> 
> For uncorrectable errors: support multiple injection in one operation
> as this is needed to reliably test multiple header logging support in an
> OS. The equivalent feature doesn't exist for correctable errors, so only
> one error need be injected at a time.
> 
> Note:
>  - Header content needs to be manually specified in a fashion that
>    matches the specification for what can be in the header for each
>    error type.
> 
> Injection via QMP:
> { "execute": "qmp_capabilities" }
> ...
> { "execute": "cxl-inject-uncorrectable-errors",
>   "arguments": {
>     "path": "/machine/peripheral/cxl-pmem0",
>     "errors": [
>         {
>             "type": "cache-address-parity",
>             "header": [ 3, 4]
>         },
>         {
>             "type": "cache-data-parity",
>             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>         },
>         {
>             "type": "internal",
>             "header": [ 1, 2, 4]
>         }
>         ]
>   }}
> ...
> { "execute": "cxl-inject-correctable-error",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-pmem0",
>         "type": "physical"
>     } }
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I will assume the silence of QAPI maintainers implies acceptance.

> ---
> v6: (Thanks to Philippe Mathieu-Daudé)
> - Add Since entries in cxl.json
> - Add error prints in the stub functions so that if they are called without
>   CONFIG_CXL_MEM_DEVICE then we get a useful print rather than just silently
>   eating them.
> 
> ---
>  hw/cxl/cxl-component-utils.c   |   4 +-
>  hw/mem/cxl_type3.c             | 281 +++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c       |  17 ++
>  hw/mem/meson.build             |   2 +
>  include/hw/cxl/cxl_component.h |  26 +++
>  include/hw/cxl/cxl_device.h    |  11 ++
>  qapi/cxl.json                  | 128 +++++++++++++++
>  qapi/meson.build               |   1 +
>  qapi/qapi-schema.json          |   1 +
>  9 files changed, 470 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 737b4764b9..b665d4f565 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -142,16 +142,18 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
>       * be handled as RO.
>       */
>      stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, 0);
> +    stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_STATUS, 0x1cfff);
>      /* Bits 12-13 and 17-31 reserved in CXL 2.0 */
>      stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
>      stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
>      stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
>      stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
>      stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, 0);
> +    stl_le_p(write_msk + R_CXL_RAS_COR_ERR_STATUS, 0x7f);
>      stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0x7f);
>      stl_le_p(write_msk + R_CXL_RAS_COR_ERR_MASK, 0x7f);
>      /* CXL switches and devices must set */
> -    stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x00);
> +    stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x200);
>  }
>  
>  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6cdd988d1d..abe60b362c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1,6 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-commands-cxl.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/pci/pci.h"
> @@ -323,6 +324,66 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
>      ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
>  }
>  
> +static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
> +{
> +    switch (qmp_err) {
> +    case CXL_UNCOR_ERROR_TYPE_CACHE_DATA_PARITY:
> +        return CXL_RAS_UNC_ERR_CACHE_DATA_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_CACHE_ADDRESS_PARITY:
> +        return CXL_RAS_UNC_ERR_CACHE_ADDRESS_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_CACHE_BE_PARITY:
> +        return CXL_RAS_UNC_ERR_CACHE_BE_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_CACHE_DATA_ECC:
> +        return CXL_RAS_UNC_ERR_CACHE_DATA_ECC;
> +    case CXL_UNCOR_ERROR_TYPE_MEM_DATA_PARITY:
> +        return CXL_RAS_UNC_ERR_MEM_DATA_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_MEM_ADDRESS_PARITY:
> +        return CXL_RAS_UNC_ERR_MEM_ADDRESS_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_MEM_BE_PARITY:
> +        return CXL_RAS_UNC_ERR_MEM_BE_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_MEM_DATA_ECC:
> +        return CXL_RAS_UNC_ERR_MEM_DATA_ECC;
> +    case CXL_UNCOR_ERROR_TYPE_REINIT_THRESHOLD:
> +        return CXL_RAS_UNC_ERR_REINIT_THRESHOLD;
> +    case CXL_UNCOR_ERROR_TYPE_RSVD_ENCODING:
> +        return CXL_RAS_UNC_ERR_RSVD_ENCODING;
> +    case CXL_UNCOR_ERROR_TYPE_POISON_RECEIVED:
> +        return CXL_RAS_UNC_ERR_POISON_RECEIVED;
> +    case CXL_UNCOR_ERROR_TYPE_RECEIVER_OVERFLOW:
> +        return CXL_RAS_UNC_ERR_RECEIVER_OVERFLOW;
> +    case CXL_UNCOR_ERROR_TYPE_INTERNAL:
> +        return CXL_RAS_UNC_ERR_INTERNAL;
> +    case CXL_UNCOR_ERROR_TYPE_CXL_IDE_TX:
> +        return CXL_RAS_UNC_ERR_CXL_IDE_TX;
> +    case CXL_UNCOR_ERROR_TYPE_CXL_IDE_RX:
> +        return CXL_RAS_UNC_ERR_CXL_IDE_RX;
> +    default:
> +        return -EINVAL;
> +    }
> +}
> +
> +static int ct3d_qmp_cor_err_to_cxl(CxlCorErrorType qmp_err)
> +{
> +    switch (qmp_err) {
> +    case CXL_COR_ERROR_TYPE_CACHE_DATA_ECC:
> +        return CXL_RAS_COR_ERR_CACHE_DATA_ECC;
> +    case CXL_COR_ERROR_TYPE_MEM_DATA_ECC:
> +        return CXL_RAS_COR_ERR_MEM_DATA_ECC;
> +    case CXL_COR_ERROR_TYPE_CRC_THRESHOLD:
> +        return CXL_RAS_COR_ERR_CRC_THRESHOLD;
> +    case CXL_COR_ERROR_TYPE_RETRY_THRESHOLD:
> +        return CXL_RAS_COR_ERR_RETRY_THRESHOLD;
> +    case CXL_COR_ERROR_TYPE_CACHE_POISON_RECEIVED:
> +        return CXL_RAS_COR_ERR_CACHE_POISON_RECEIVED;
> +    case CXL_COR_ERROR_TYPE_MEM_POISON_RECEIVED:
> +        return CXL_RAS_COR_ERR_MEM_POISON_RECEIVED;
> +    case CXL_COR_ERROR_TYPE_PHYSICAL:
> +        return CXL_RAS_COR_ERR_PHYSICAL;
> +    default:
> +        return -EINVAL;
> +    }
> +}
> +
>  static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>                             unsigned size)
>  {
> @@ -341,6 +402,83 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>          should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
>          which_hdm = 0;
>          break;
> +    case A_CXL_RAS_UNC_ERR_STATUS:
> +    {
> +        uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
> +        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER);
> +        CXLError *cxl_err;
> +        uint32_t unc_err;
> +
> +        /*
> +         * If single bit written that corresponds to the first error
> +         * pointer being cleared, update the status and header log.
> +         */
> +        if (!QTAILQ_EMPTY(&ct3d->error_list)) {
> +            if ((1 << fe) ^ value) {
> +                CXLError *cxl_next;
> +                /*
> +                 * Software is using wrong flow for multiple header recording
> +                 * Following behavior in PCIe r6.0 and assuming multiple
> +                 * header support. Implementation defined choice to clear all
> +                 * matching records if more than one bit set - which corresponds
> +                 * closest to behavior of hardware not capable of multiple
> +                 * header recording.
> +                 */
> +                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node, cxl_next) {
> +                    if ((1 << cxl_err->type) & value) {
> +                        QTAILQ_REMOVE(&ct3d->error_list, cxl_err, node);
> +                        g_free(cxl_err);
> +                    }
> +                }
> +            } else {
> +                /* Done with previous FE, so drop from list */
> +                cxl_err = QTAILQ_FIRST(&ct3d->error_list);
> +                QTAILQ_REMOVE(&ct3d->error_list, cxl_err, node);
> +                g_free(cxl_err);
> +            }
> +
> +            /*
> +             * If there is another FE, then put that in place and update
> +             * the header log
> +             */
> +            if (!QTAILQ_EMPTY(&ct3d->error_list)) {
> +                uint32_t *header_log = &cache_mem[R_CXL_RAS_ERR_HEADER0];
> +                int i;
> +
> +                cxl_err = QTAILQ_FIRST(&ct3d->error_list);
> +                for (i = 0; i < CXL_RAS_ERR_HEADER_NUM; i++) {
> +                    stl_le_p(header_log + i, cxl_err->header[i]);
> +                }
> +                capctrl = FIELD_DP32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                                     FIRST_ERROR_POINTER, cxl_err->type);
> +            } else {
> +                /*
> +                 * If no more errors, then follow recomendation of PCI spec
> +                 * r6.0 6.2.4.2 to set the first error pointer to a status
> +                 * bit that will never be used.
> +                 */
> +                capctrl = FIELD_DP32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                                     FIRST_ERROR_POINTER,
> +                                     CXL_RAS_UNC_ERR_CXL_UNUSED);
> +            }
> +            stl_le_p((uint8_t *)cache_mem + A_CXL_RAS_ERR_CAP_CTRL, capctrl);
> +        }
> +        unc_err = 0;
> +        QTAILQ_FOREACH(cxl_err, &ct3d->error_list, node) {
> +            unc_err |= 1 << cxl_err->type;
> +        }
> +        stl_le_p((uint8_t *)cache_mem + offset, unc_err);
> +
> +        return;
> +    }
> +    case A_CXL_RAS_COR_ERR_STATUS:
> +    {
> +        uint32_t rw1c = value;
> +        uint32_t temp = ldl_le_p((uint8_t *)cache_mem + offset);
> +        temp &= ~rw1c;
> +        stl_le_p((uint8_t *)cache_mem + offset, temp);
> +        return;
> +    }
>      default:
>          break;
>      }
> @@ -404,6 +542,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      unsigned short msix_num = 1;
>      int i, rc;
>  
> +    QTAILQ_INIT(&ct3d->error_list);
> +
>      if (!cxl_setup_memory(ct3d, errp)) {
>          return;
>      }
> @@ -631,6 +771,147 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +/* For uncorrectable errors include support for multiple header recording */
> +void qmp_cxl_inject_uncorrectable_errors(const char *path,
> +                                         CXLUncorErrorRecordList *errors,
> +                                         Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    static PCIEAERErr err = {};
> +    CXLType3Dev *ct3d;
> +    CXLError *cxl_err;
> +    uint32_t *reg_state;
> +    uint32_t unc_err;
> +    bool first;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +
> +    err.status = PCI_ERR_UNC_INTN;
> +    err.source_id = pci_requester_id(PCI_DEVICE(obj));
> +    err.flags = 0;
> +
> +    ct3d = CXL_TYPE3(obj);
> +
> +    first = QTAILQ_EMPTY(&ct3d->error_list);
> +    reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
> +    while (errors) {
> +        uint32List *header = errors->value->header;
> +        uint8_t header_count = 0;
> +        int cxl_err_code;
> +
> +        cxl_err_code = ct3d_qmp_uncor_err_to_cxl(errors->value->type);
> +        if (cxl_err_code < 0) {
> +            error_setg(errp, "Unknown error code");
> +            return;
> +        }
> +
> +        /* If the error is masked, nothing to do here */
> +        if (!((1 << cxl_err_code) &
> +              ~ldl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK))) {
> +            errors = errors->next;
> +            continue;
> +        }
> +
> +        cxl_err = g_malloc0(sizeof(*cxl_err));
> +        if (!cxl_err) {
> +            return;
> +        }
> +
> +        cxl_err->type = cxl_err_code;
> +        while (header && header_count < 32) {
> +            cxl_err->header[header_count++] = header->value;
> +            header = header->next;
> +        }
> +        if (header_count > 32) {
> +            error_setg(errp, "Header must be 32 DWORD or less");
> +            return;
> +        }
> +        QTAILQ_INSERT_TAIL(&ct3d->error_list, cxl_err, node);
> +
> +        errors = errors->next;
> +    }
> +
> +    if (first && !QTAILQ_EMPTY(&ct3d->error_list)) {
> +        uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> +        uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
> +        uint32_t *header_log = &cache_mem[R_CXL_RAS_ERR_HEADER0];
> +        int i;
> +
> +        cxl_err = QTAILQ_FIRST(&ct3d->error_list);
> +        for (i = 0; i < CXL_RAS_ERR_HEADER_NUM; i++) {
> +            stl_le_p(header_log + i, cxl_err->header[i]);
> +        }
> +
> +        capctrl = FIELD_DP32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                             FIRST_ERROR_POINTER, cxl_err->type);
> +        stl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL, capctrl);
> +    }
> +
> +    unc_err = 0;
> +    QTAILQ_FOREACH(cxl_err, &ct3d->error_list, node) {
> +        unc_err |= (1 << cxl_err->type);
> +    }
> +    if (!unc_err) {
> +        return;
> +    }
> +
> +    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, unc_err);
> +    pcie_aer_inject_error(PCI_DEVICE(obj), &err);
> +
> +    return;
> +}
> +
> +void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
> +                                      Error **errp)
> +{
> +    static PCIEAERErr err = {};
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLType3Dev *ct3d;
> +    uint32_t *reg_state;
> +    uint32_t cor_err;
> +    int cxl_err_type;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +
> +    err.status = PCI_ERR_COR_INTERNAL;
> +    err.source_id = pci_requester_id(PCI_DEVICE(obj));
> +    err.flags = PCIE_AER_ERR_IS_CORRECTABLE;
> +
> +    ct3d = CXL_TYPE3(obj);
> +    reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
> +    cor_err = ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS);
> +
> +    cxl_err_type = ct3d_qmp_cor_err_to_cxl(type);
> +    if (cxl_err_type < 0) {
> +        error_setg(errp, "Invalid COR error");
> +        return;
> +    }
> +    /* If the error is masked, nothting to do here */
> +    if (!((1 << cxl_err_type) & ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK))) {
> +        return;
> +    }
> +
> +    cor_err |= (1 << cxl_err_type);
> +    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, cor_err);
> +
> +    pcie_aer_inject_error(PCI_DEVICE(obj), &err);
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> new file mode 100644
> index 0000000000..d574c58f9a
> --- /dev/null
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -0,0 +1,17 @@
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-cxl.h"
> +
> +void qmp_cxl_inject_uncorrectable_errors(const char *path,
> +                                         CXLUncorErrorRecordList *errors,
> +                                         Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> +
> +void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
> +                                      Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> index 609b2b36fc..56c2618b84 100644
> --- a/hw/mem/meson.build
> +++ b/hw/mem/meson.build
> @@ -4,6 +4,8 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
>  mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
>  mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
>  mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
> +softmmu_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
> +softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))
>  
>  softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
>  
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 692d7a5507..ec4203b83f 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -65,11 +65,37 @@ CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
>  #define CXL_RAS_REGISTERS_OFFSET 0x80
>  #define CXL_RAS_REGISTERS_SIZE   0x58
>  REG32(CXL_RAS_UNC_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET)
> +#define CXL_RAS_UNC_ERR_CACHE_DATA_PARITY 0
> +#define CXL_RAS_UNC_ERR_CACHE_ADDRESS_PARITY 1
> +#define CXL_RAS_UNC_ERR_CACHE_BE_PARITY 2
> +#define CXL_RAS_UNC_ERR_CACHE_DATA_ECC 3
> +#define CXL_RAS_UNC_ERR_MEM_DATA_PARITY 4
> +#define CXL_RAS_UNC_ERR_MEM_ADDRESS_PARITY 5
> +#define CXL_RAS_UNC_ERR_MEM_BE_PARITY 6
> +#define CXL_RAS_UNC_ERR_MEM_DATA_ECC 7
> +#define CXL_RAS_UNC_ERR_REINIT_THRESHOLD 8
> +#define CXL_RAS_UNC_ERR_RSVD_ENCODING 9
> +#define CXL_RAS_UNC_ERR_POISON_RECEIVED 10
> +#define CXL_RAS_UNC_ERR_RECEIVER_OVERFLOW 11
> +#define CXL_RAS_UNC_ERR_INTERNAL 14
> +#define CXL_RAS_UNC_ERR_CXL_IDE_TX 15
> +#define CXL_RAS_UNC_ERR_CXL_IDE_RX 16
> +#define CXL_RAS_UNC_ERR_CXL_UNUSED 63 /* Magic value */
>  REG32(CXL_RAS_UNC_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x4)
>  REG32(CXL_RAS_UNC_ERR_SEVERITY, CXL_RAS_REGISTERS_OFFSET + 0x8)
>  REG32(CXL_RAS_COR_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET + 0xc)
> +#define CXL_RAS_COR_ERR_CACHE_DATA_ECC 0
> +#define CXL_RAS_COR_ERR_MEM_DATA_ECC 1
> +#define CXL_RAS_COR_ERR_CRC_THRESHOLD 2
> +#define CXL_RAS_COR_ERR_RETRY_THRESHOLD 3
> +#define CXL_RAS_COR_ERR_CACHE_POISON_RECEIVED 4
> +#define CXL_RAS_COR_ERR_MEM_POISON_RECEIVED 5
> +#define CXL_RAS_COR_ERR_PHYSICAL 6
>  REG32(CXL_RAS_COR_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x10)
>  REG32(CXL_RAS_ERR_CAP_CTRL, CXL_RAS_REGISTERS_OFFSET + 0x14)
> +    FIELD(CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER, 0, 6)
> +REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
> +#define CXL_RAS_ERR_HEADER_NUM 32
>  /* Offset 0x18 - 0x58 reserved for RAS logs */
>  
>  /* 8.2.5.10 - CXL Security Capability Structure */
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 7e5ad65c1d..d589f78202 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -232,6 +232,14 @@ REG64(CXL_MEM_DEV_STS, 0)
>      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
>  
> +typedef struct CXLError {
> +    QTAILQ_ENTRY(CXLError) node;
> +    int type; /* Error code as per FE definition */
> +    uint32_t header[32];
> +} CXLError;
> +
> +typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -248,6 +256,9 @@ struct CXLType3Dev {
>  
>      /* DOE */
>      DOECap doe_cdat;
> +
> +    /* Error injection */
> +    CXLErrorList error_list;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> new file mode 100644
> index 0000000000..4be7d46041
> --- /dev/null
> +++ b/qapi/cxl.json
> @@ -0,0 +1,128 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = CXL devices
> +##
> +
> +##
> +# @CxlUncorErrorType:
> +#
> +# Type of uncorrectable CXL error to inject. These errors are reported via
> +# an AER uncorrectable internal error with additional information logged at
> +# the CXL device.
> +#
> +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
> +# @cache-address-parity: Address parity or other errors associated with the
> +#                        address field on CXL.cache
> +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
> +# @cache-data-ecc: ECC error on CXL.cache
> +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
> +# @mem-address-parity: Address parity or other errors associated with the
> +#                      address field on CXL.mem
> +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
> +# @mem-data-ecc: Data ECC error on CXL.mem.
> +# @reinit-threshold: REINIT threshold hit.
> +# @rsvd-encoding: Received unrecognized encoding.
> +# @poison-received: Received poison from the peer.
> +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
> +# @internal: Component specific error
> +# @cxl-ide-tx: Integrity and data encryption tx error.
> +# @cxl-ide-rx: Integrity and data encryption rx error.
> +#
> +# Since: 8.0
> +##
> +
> +{ 'enum': 'CxlUncorErrorType',
> +  'data': ['cache-data-parity',
> +           'cache-address-parity',
> +           'cache-be-parity',
> +           'cache-data-ecc',
> +           'mem-data-parity',
> +           'mem-address-parity',
> +           'mem-be-parity',
> +           'mem-data-ecc',
> +           'reinit-threshold',
> +           'rsvd-encoding',
> +           'poison-received',
> +           'receiver-overflow',
> +           'internal',
> +           'cxl-ide-tx',
> +           'cxl-ide-rx'
> +           ]
> + }
> +
> +##
> +# @CXLUncorErrorRecord:
> +#
> +# Record of a single error including header log.
> +#
> +# @type: Type of error
> +# @header: 16 DWORD of header.
> +#
> +# Since: 8.0
> +##
> +{ 'struct': 'CXLUncorErrorRecord',
> +  'data': {
> +      'type': 'CxlUncorErrorType',
> +      'header': [ 'uint32' ]
> +  }
> +}
> +
> +##
> +# @cxl-inject-uncorrectable-errors:
> +#
> +# Command to allow injection of multiple errors in one go. This allows testing
> +# of multiple header log handling in the OS.
> +#
> +# @path: CXL Type 3 device canonical QOM path
> +# @errors: Errors to inject
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-inject-uncorrectable-errors',
> +  'data': { 'path': 'str',
> +             'errors': [ 'CXLUncorErrorRecord' ] }}
> +
> +##
> +# @CxlCorErrorType:
> +#
> +# Type of CXL correctable error to inject
> +#
> +# @cache-data-ecc: Data ECC error on CXL.cache
> +# @mem-data-ecc: Data ECC error on CXL.mem
> +# @crc-threshold: Component specific and applicable to 68 byte Flit mode only.
> +# @cache-poison-received: Received poison from a peer on CXL.cache.
> +# @mem-poison-received: Received poison from a peer on CXL.mem
> +# @physical: Received error indication from the physical layer.
> +#
> +# Since: 8.0
> +##
> +{ 'enum': 'CxlCorErrorType',
> +  'data': ['cache-data-ecc',
> +           'mem-data-ecc',
> +           'crc-threshold',
> +           'retry-threshold',
> +           'cache-poison-received',
> +           'mem-poison-received',
> +           'physical']
> +}
> +
> +##
> +# @cxl-inject-correctable-error:
> +#
> +# Command to inject a single correctable error.  Multiple error injection
> +# of this error type is not interesting as there is no associated header log.
> +# These errors are reported via AER as a correctable internal error, with
> +# additional detail available from the CXL device.
> +#
> +# @path: CXL Type 3 device canonical QOM path
> +# @type: Type of error.
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-inject-correctable-error',
> +  'data': { 'path': 'str',
> +            'type': 'CxlCorErrorType'
> +  }
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index fbdb442fdf..73c3c8c31a 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -31,6 +31,7 @@ qapi_all_modules = [
>    'compat',
>    'control',
>    'crypto',
> +  'cxl',
>    'dump',
>    'error',
>    'introspect',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index f000b90744..079f2a402a 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -95,3 +95,4 @@
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }
> +{ 'include': 'cxl.json' }
> -- 
> 2.37.2

