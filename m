Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2BDC61DA4
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 14:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjBVOxq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjBVOxg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 09:53:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9243AB4
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 06:53:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PMJv15pxdz6J7N8;
        Wed, 22 Feb 2023 22:48:45 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 22 Feb
 2023 14:53:31 +0000
Date:   Wed, 22 Feb 2023 14:53:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Message-ID: <20230222145330.000021ef@huawei.com>
In-Reply-To: <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
        <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
        <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 21 Feb 2023 23:15:49 +0100
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> Hi Jonathan,
> 
> On 21/2/23 16:21, Jonathan Cameron wrote:
> > CXL uses PCI AER Internal errors to signal to the host that an error has
> > occurred. The host can then read more detailed status from the CXL RAS
> > capability.
> > 
> > For uncorrectable errors: support multiple injection in one operation
> > as this is needed to reliably test multiple header logging support in an
> > OS. The equivalent feature doesn't exist for correctable errors, so only
> > one error need be injected at a time.
> > 
> > Note:
> >   - Header content needs to be manually specified in a fashion that
> >     matches the specification for what can be in the header for each
> >     error type.
> > 
> > Injection via QMP:
> > { "execute": "qmp_capabilities" }
> > ...
> > { "execute": "cxl-inject-uncorrectable-errors",
> >    "arguments": {
> >      "path": "/machine/peripheral/cxl-pmem0",
> >      "errors": [
> >          {
> >              "type": "cache-address-parity",
> >              "header": [ 3, 4]
> >          },
> >          {
> >              "type": "cache-data-parity",
> >              "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
> >          },
> >          {
> >              "type": "internal",
> >              "header": [ 1, 2, 4]
> >          }
> >          ]
> >    }}
> > ...
> > { "execute": "cxl-inject-correctable-error",
> >      "arguments": {
> >          "path": "/machine/peripheral/cxl-pmem0",
> >          "type": "physical"
> >      } }
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi Philippe,

Thanks for your review.  One question inline.

> > +#
> > +# Type of uncorrectable CXL error to inject. These errors are reported via
> > +# an AER uncorrectable internal error with additional information logged at
> > +# the CXL device.
> > +#
> > +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
> > +# @cache-address-parity: Address parity or other errors associated with the
> > +#                        address field on CXL.cache
> > +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
> > +# @cache-data-ecc: ECC error on CXL.cache
> > +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
> > +# @mem-address-parity: Address parity or other errors associated with the
> > +#                      address field on CXL.mem
> > +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
> > +# @mem-data-ecc: Data ECC error on CXL.mem.
> > +# @reinit-threshold: REINIT threshold hit.
> > +# @rsvd-encoding: Received unrecognized encoding.
> > +# @poison-received: Received poison from the peer.
> > +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
> > +# @internal: Component specific error
> > +# @cxl-ide-tx: Integrity and data encryption tx error.
> > +# @cxl-ide-rx: Integrity and data encryption rx error.
> > +##
> > +
> > +{ 'enum': 'CxlUncorErrorType',  
> 
> Doesn't these need
> 
>       'if': 'CONFIG_CXL_MEM_DEVICE',
> 
> ?

If I make this change I get a bunch of

./qapi/qapi-types-cxl.h:18:13: error: attempt to use poisoned "CONFIG_CXL_MEM_DEVICE"
   18 | #if defined(CONFIG_CXL_MEM_DEVICE)

It's a target specific define (I think) as built alongside PCI_EXPRESS
Only CXL_ACPI is specifically included by x86 and arm64 (out of tree)

To be honest though I don't fully understand the QEMU build system so the reason
for the error might be wrong.

> 
> > +  'data': ['cache-data-parity',
> > +           'cache-address-parity',
> > +           'cache-be-parity',
> > +           'cache-data-ecc',
> > +           'mem-data-parity',
> > +           'mem-address-parity',
> > +           'mem-be-parity',
> > +           'mem-data-ecc',
> > +           'reinit-threshold',
> > +           'rsvd-encoding',
> > +           'poison-received',
> > +           'receiver-overflow',
> > +           'internal',
> > +           'cxl-ide-tx',
> > +           'cxl-ide-rx'
> > +           ]
> > + }
