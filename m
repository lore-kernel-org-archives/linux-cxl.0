Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E3C63797
	for <linux-cxl@archiver.kernel.org>; Sun, 15 Jan 2023 20:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjAOUGo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 15 Jan 2023 15:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjAOUGn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 15 Jan 2023 15:06:43 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CFBC64E
        for <linux-cxl@vger.kernel.org>; Sun, 15 Jan 2023 12:06:40 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4c131bede4bso356145297b3.5
        for <linux-cxl@vger.kernel.org>; Sun, 15 Jan 2023 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZajnMoDvg4YTWUq8GjVBEA9NsHi2KJZfJq/DxMbXQ80=;
        b=TJQf+8XFMNHYDPGmRoeJVa7BARBWmGUi3mJCTFm3RDyV21az+Ml/zWFEoyD1/XMn/9
         RVqloAVsMFKQaNme2p06gvMTRXChOHwISgh0LSq0fFKFvAwUSFtIe7nRycmUbtYVfybg
         03qNutXUmNmcRWQgpMOnmUs7TXBdtlBxC/Gm+jnOKyLWwQ5IXckt9TmcAyOm9b9L2Kv6
         Vm+DUD5ZDdf5FLmzVrhzTKgk+LCqsrUGGr9HfQh9ISewasrNsISlUxBI3vXG9ik35yUF
         vCf/c7pXm/sBIOJKWnRPhQao1Wqn738IL65F16M0eGLCq+CBcjFM0tTtQiOzTfDOxOfi
         uQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZajnMoDvg4YTWUq8GjVBEA9NsHi2KJZfJq/DxMbXQ80=;
        b=bwYADSxE/P42RWtAFhZQxAjRwE+CppgTCLqNb0/Pc0av29NJuHVoZKqYnowXJ5NqJY
         shTSJUeLe/MReSZ7jn99BgWb8bJ6WiLq/dDrpTvduGSccDGm8EUY47oWebJOPNQh0R28
         smwGqkVbEeL/hV6zz6y3dj+dm9TYOkPUcMR2lfzGxfL2AjRDsLb4y8FuFqrsOVGNmIFg
         3tQwOhfZZ0wMLSYVhjVxxL8xDKBs4p0rreHJ4F2Wz4q+JxjPsOydPj3vhLG/b9vc7ryF
         G8pT+lZJ1khFpBRpZ6Y4hj8PNRfvak5acFEv+mUMP0gDcGVGU+i14LpdyC4CgbV76oG/
         jMbg==
X-Gm-Message-State: AFqh2ko8LMMmRx7oNdotzvKzoHx3cpawBnGjD8CHV3Sv7beHgOueztT6
        vZWClk2i9sYWoBFMtneEsnfYz2oVPne8rnauwek=
X-Google-Smtp-Source: AMrXdXt92IlZUo/U9pz32RpNIkppMDda484VvFjnX2Y8ToxhsEsiFYQAljLUyufJGj5+3szwCJhVpe4umsCFmxN0DCE=
X-Received: by 2002:a81:8397:0:b0:4db:255a:6217 with SMTP id
 t145-20020a818397000000b004db255a6217mr1717375ywf.85.1673813199749; Sun, 15
 Jan 2023 12:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20230113161711.7885-1-Jonathan.Cameron@huawei.com> <20230113161711.7885-8-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230113161711.7885-8-Jonathan.Cameron@huawei.com>
From:   Mike Maslenkin <mike.maslenkin@gmail.com>
Date:   Sun, 15 Jan 2023 23:06:03 +0300
Message-ID: <CAL77WPBFT5Ty56bOQR4aQqxi=GZYbwZELiZhkWzB4F-Wn0pZGg@mail.gmail.com>
Subject: Re: [PATCH 7/7] hw/mem/cxl_type3: Add CXL RAS Error Injection Support.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        alison.schofield@intel.com, ira.weiny@intel.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 13, 2023 at 7:43 PM Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
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
>         "type": "physical",
>         "header": [ 3, 4]
>     } }
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-component-utils.c   |   4 +-
>  hw/mem/cxl_type3.c             | 290 +++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c       |  10 ++
>  hw/mem/meson.build             |   2 +
>  include/hw/cxl/cxl_component.h |  26 +++
>  include/hw/cxl/cxl_device.h    |  11 ++
>  qapi/cxl.json                  | 113 +++++++++++++
>  qapi/meson.build               |   1 +
>  qapi/qapi-schema.json          |   1 +
>  9 files changed, 457 insertions(+), 1 deletion(-)
>
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 3edd303a33..02fb6c17b9 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -142,16 +142,18 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
>       * be handled as RO.
>       */
>      reg_state[R_CXL_RAS_UNC_ERR_STATUS] = 0;
> +    write_msk[R_CXL_RAS_UNC_ERR_STATUS] = 0x1cfff;
>      /* Bits 12-13 and 17-31 reserved in CXL 2.0 */
>      reg_state[R_CXL_RAS_UNC_ERR_MASK] = 0x1cfff;
>      write_msk[R_CXL_RAS_UNC_ERR_MASK] = 0x1cfff;
>      reg_state[R_CXL_RAS_UNC_ERR_SEVERITY] = 0x1cfff;
>      write_msk[R_CXL_RAS_UNC_ERR_SEVERITY] = 0x1cfff;
>      reg_state[R_CXL_RAS_COR_ERR_STATUS] = 0;
> +    write_msk[R_CXL_RAS_COR_ERR_STATUS] = 0x7f;
>      reg_state[R_CXL_RAS_COR_ERR_MASK] = 0x7f;
>      write_msk[R_CXL_RAS_COR_ERR_MASK] = 0x7f;
>      /* CXL switches and devices must set */
> -    reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0x00;
> +    reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0x200;
>  }
>
>  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6cdd988d1d..ae8fd09e87 100644
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
> +static int ct3d_qmp_cor_err_to_cxl(CxlUncorErrorType qmp_err)

CxlCorErrorType type  is required.

Compiler warns here:
../hw/mem/cxl_type3.c:1263:44: error: implicit conversion from
enumeration type 'CxlCorErrorType' (aka 'enum CxlCorErrorType') to
different enumeration type 'CxlUncorErrorType' (aka 'enum
CxlUncorErrorType') [-Werror,-Wenum-conversion]

    cxl_err_type = ct3d_qmp_cor_err_to_cxl(type);

                   ~~~~~~~~~~~~~~~~~~~~~~~ ^~~~
1 error generated.

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
> @@ -341,6 +402,84 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
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
> +            CXLError *cxl_err = QTAILQ_FIRST(&ct3d->error_list);

Is it ok that "CXLError *cxl_err"  definition clobbers previous one above?
