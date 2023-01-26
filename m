Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC0C52D11
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 17:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjAZRgE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 12:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjAZRf6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 12:35:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB66C100
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 09:35:43 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2npB3fV4z67bS0;
        Fri, 27 Jan 2023 01:32:18 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 17:35:41 +0000
Date:   Thu, 26 Jan 2023 17:35:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <alison.schofield@intel.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH v2 7/7] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support
Message-ID: <20230126173539.00005cfd@huawei.com>
In-Reply-To: <20230120142450.16089-8-Jonathan.Cameron@huawei.com>
References: <20230120142450.16089-1-Jonathan.Cameron@huawei.com>
        <20230120142450.16089-8-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 20 Jan 2023 14:24:50 +0000
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

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

Correctable errors don't have header logging (I misread the spec a long time
back and somehow didn't notice this was still here) I'll fix this up for v3
along with cleaning up the messy endian handling that was pointed out off list.
I don't intent (at this point) to deal with big endian support in general,
but it would be good not to make the situation worse than it already is
even if no one is shouting for big endian yet.

Thanks,

Jonathan
