Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B72C636D6
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjBVQt6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBVQtw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 11:49:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C02BEFD
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 08:49:50 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PMMT972QGz67x9N;
        Thu, 23 Feb 2023 00:45:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 22 Feb
 2023 16:49:47 +0000
Date:   Wed, 22 Feb 2023 16:49:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Message-ID: <20230222164947.0000554f@Huawei.com>
In-Reply-To: <c2fb77b0-0734-3be5-1b54-7c797b3daa15@linaro.org>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
        <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
        <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
        <20230222145330.000021ef@huawei.com>
        <c2fb77b0-0734-3be5-1b54-7c797b3daa15@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


...

> >>> +# Type of uncorrectable CXL error to inject. These errors are reported via
> >>> +# an AER uncorrectable internal error with additional information logged at
> >>> +# the CXL device.
> >>> +#
> >>> +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
> >>> +# @cache-address-parity: Address parity or other errors associated with the
> >>> +#                        address field on CXL.cache
> >>> +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
> >>> +# @cache-data-ecc: ECC error on CXL.cache
> >>> +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
> >>> +# @mem-address-parity: Address parity or other errors associated with the
> >>> +#                      address field on CXL.mem
> >>> +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
> >>> +# @mem-data-ecc: Data ECC error on CXL.mem.
> >>> +# @reinit-threshold: REINIT threshold hit.
> >>> +# @rsvd-encoding: Received unrecognized encoding.
> >>> +# @poison-received: Received poison from the peer.
> >>> +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
> >>> +# @internal: Component specific error
> >>> +# @cxl-ide-tx: Integrity and data encryption tx error.
> >>> +# @cxl-ide-rx: Integrity and data encryption rx error.
> >>> +##
> >>> +
> >>> +{ 'enum': 'CxlUncorErrorType',  
> >>
> >> Doesn't these need
> >>
> >>        'if': 'CONFIG_CXL_MEM_DEVICE',
> >>
> >> ?  
> > 
> > If I make this change I get a bunch of
> > 
> > ./qapi/qapi-types-cxl.h:18:13: error: attempt to use poisoned "CONFIG_CXL_MEM_DEVICE"
> >     18 | #if defined(CONFIG_CXL_MEM_DEVICE)  
> 
> Err, I meant the generic CONFIG_CXL, not CONFIG_CXL_MEM_DEVICE.
> 
> > It's a target specific define (I think) as built alongside PCI_EXPRESS
> > Only CXL_ACPI is specifically included by x86 and arm64 (out of tree)
> > 
> > To be honest though I don't fully understand the QEMU build system so the reason
> > for the error might be wrong.  
> 
> You need to restrict to system emulation (the 'have_system' check):

This doesn't help - still have 
attempt to used poisoned "CONFIG_CXL"


> 
> -- >8 --  
> diff --git a/qapi/meson.build b/qapi/meson.build
> index fbdb442fdf..643c76d61c 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -31,6 +31,7 @@ qapi_all_modules = [
>     'compat',
>     'control',
>     'crypto',
> -  'cxl',
>     'dump',
>     'error',
>     'introspect',
> @@ -58,6 +59,7 @@ if have_system
>       'audio',
>       'qdev',
>       'pci',
> +    'cxl',
>       'rdma',
>       'rocker',
>       'tpm',
> ---
> 

