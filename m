Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE6C61DA3
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 22:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBUWQA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBUWPz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 17:15:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C1A32CF2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 14:15:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o4-20020a05600c4fc400b003e1f5f2a29cso4797333wmq.4
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 14:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRgZuaa0vXJdPoob66/HKPmQifpcuWYDUWcuuHs414Y=;
        b=jk7Ihb/enxXw74fBYIr5jYy4B92cX63+ZqVMZPk4rIVtnlXh1XQqMWcXznwslsl0/i
         Dn11Ywyh/znNdxKQJdHQ8v355dFrjy2mtBkmwriEFOFSZg+sFdaDxO4npS4RgAHzLWKB
         JPKHtV8zlci0ZZkV13MDrG0UAFHnVpQJcpndUuMDXBUJGoejK2PPoZ6pXJvXG8Yy6tJe
         Y3mstwUETXUZ+TZ0/z7eV87xwON1N0tQzmvfk7ndxue8UpRF+0ovPY2tJCK7U/aufT/Y
         TXucutGdcKY+UZrEsYCtl1KtaE7+dSedEzaYU+ak0q7h9BJlKrNb9ixpTCRiwRv4f5Ys
         IxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRgZuaa0vXJdPoob66/HKPmQifpcuWYDUWcuuHs414Y=;
        b=El4lsypB2FYGM6kG0YMf72iywDRnmfx/g5cEYZzIpp4euxZ0E/co4p8QUxIH3Xwb/W
         SCvttgo2DHxOw9M9kLrkp35rE08qIUYuNCbhwg5ebBGW0RrxwHvWVvu+Xuo4obPz3eWQ
         SVoNtLgrEwq7RjX5mKr2z735o0+PW5NLgUw0NyHOVb7YQs0yv79HWpGDQxu/ytS/u9Tk
         CsqFqt0vUKJqFez7g9I7kRBxjO5AHATMc4ZqY+P/pZrJQngzm9gcL4ETBR5F7CK1ztm+
         JOAbofnd/bmuxXaSmI59kBItz4LAMnV9NN9BSNBXjVcXYm0m/KBoHXUGVC0/z0lhvfL/
         vPpA==
X-Gm-Message-State: AO0yUKWOY/UcwVkwFT3AAfHZQilNOaOyPK4TzRF8lV/WnnAOzZnEKfJU
        vOAUdgt/+nkvAoMAdmUUGa6nvA==
X-Google-Smtp-Source: AK7set9W0WsaJXl7EaRLxu1yfsdD2SdqVIDJ5e1ktAoPcPQerY4tOYNH/MMUtpAsepikxwV14B8SIQ==
X-Received: by 2002:a05:600c:130e:b0:3dc:5ab8:7d74 with SMTP id j14-20020a05600c130e00b003dc5ab87d74mr4539732wmf.3.1677017752104;
        Tue, 21 Feb 2023 14:15:52 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id bd9-20020a05600c1f0900b003e1202744f2sm14455810wmb.31.2023.02.21.14.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 14:15:51 -0800 (PST)
Message-ID: <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
Date:   Tue, 21 Feb 2023 23:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
 <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

On 21/2/23 16:21, Jonathan Cameron wrote:
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
>   - Header content needs to be manually specified in a fashion that
>     matches the specification for what can be in the header for each
>     error type.
> 
> Injection via QMP:
> { "execute": "qmp_capabilities" }
> ...
> { "execute": "cxl-inject-uncorrectable-errors",
>    "arguments": {
>      "path": "/machine/peripheral/cxl-pmem0",
>      "errors": [
>          {
>              "type": "cache-address-parity",
>              "header": [ 3, 4]
>          },
>          {
>              "type": "cache-data-parity",
>              "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>          },
>          {
>              "type": "internal",
>              "header": [ 1, 2, 4]
>          }
>          ]
>    }}
> ...
> { "execute": "cxl-inject-correctable-error",
>      "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "type": "physical"
>      } }
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v5: (Thanks to Dave Jiang for review)
> - Spell out Implementation Defined (previously typo as Imdef which did
>    not help)
> v4:
> - Improved QMP help text wth more detail (following request in review
>    of the Poison injection series)
> ---
>   hw/cxl/cxl-component-utils.c   |   4 +-
>   hw/mem/cxl_type3.c             | 281 +++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3_stubs.c       |  10 ++
>   hw/mem/meson.build             |   2 +
>   include/hw/cxl/cxl_component.h |  26 +++
>   include/hw/cxl/cxl_device.h    |  11 ++
>   qapi/cxl.json                  | 118 ++++++++++++++
>   qapi/meson.build               |   1 +
>   qapi/qapi-schema.json          |   1 +
>   9 files changed, 453 insertions(+), 1 deletion(-)


> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> new file mode 100644
> index 0000000000..b6b51ced54
> --- /dev/null
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -0,0 +1,10 @@
> +
> +#include "qemu/osdep.h"
> +#include "qapi/qapi-commands-cxl.h"
> +
> +void qmp_cxl_inject_uncorrectable_errors(const char *path,
> +                                         CXLUncorErrorRecordList *errors,
> +                                         Error **errp) {

What about:

     error_setg(errp, "CLX support is not compiled in");

}
> +
> +void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
> +                                      Error **errp) {}

Ditto.


> diff --git a/qapi/cxl.json b/qapi/cxl.json
> new file mode 100644
> index 0000000000..ac7e167fa2
> --- /dev/null
> +++ b/qapi/cxl.json
> @@ -0,0 +1,118 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = CXL devices
> +##
> +
> +##
> +# @CxlUncorErrorType:

Likely missing a "(since 8.0)" mention somewhere.

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
> +##
> +
> +{ 'enum': 'CxlUncorErrorType',

Doesn't these need

      'if': 'CONFIG_CXL_MEM_DEVICE',

?

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
> +##
> +{ 'command': 'cxl-inject-correctable-error',
> +  'data': { 'path': 'str',
> +            'type': 'CxlCorErrorType'
> +  }
> +}
