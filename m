Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D7C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Jul 2022 13:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiGTNQ1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGTNQ0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 20 Jul 2022 09:16:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4698642AEE
        for <linux-cxl@vger.kernel.org>; Wed, 20 Jul 2022 06:16:25 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lnx2c4GcYz67TNp;
        Wed, 20 Jul 2022 21:12:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 15:16:22 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 14:16:21 +0100
Date:   Wed, 20 Jul 2022 14:16:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH v2 10/12] cxl/memdev: Add {reserve,free}-dpa
 commands
Message-ID: <20220720141618.00004116@Huawei.com>
In-Reply-To: <165781816425.1555691.17958897857798325111.stgit@dwillia2-xfh.jf.intel.com>
References: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
        <165781816425.1555691.17958897857798325111.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.121]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 14 Jul 2022 10:02:44 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Add helper commands for managing allocations of DPA (device physical
> address) capacity on a set of CXL memory devices.
> 
> The main convenience this command affords is automatically picking the next
> decoder to allocate per-memdev.
> 
> For example, to allocate 256MiB from all endpoints that are covered by a
> given root decoder, and collect those resulting endpoint-decoders into an
> array:
> 
>   readarray -t mem < <(cxl list -M -d $decoder | jq -r ".[].memdev")
>   readarray -t endpoint < <(cxl reserve-dpa -t pmem ${mem[*]} -s $((256<<20)) |
>                             jq -r ".[] | .decoder.decoder")
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Not a proper review as don't have time to dive into this today. But whilst glancing at it, noticed a typo below.

> diff --git a/Documentation/cxl/cxl-reserve-dpa.txt b/Documentation/cxl/cxl-reserve-dpa.txt
> new file mode 100644
> index 000000000000..560daf0cb277
> --- /dev/null
> +++ b/Documentation/cxl/cxl-reserve-dpa.txt
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +cxl-reserve-dpa(1)
> +==================
> +
> +NAME
> +----
> +cxl-reserve-dpa - allocate device-physical address space
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'cxl reserve-dpa' <mem0> [<mem1>..<memN>] [<options>]
> +
> +The CXL region provisioning process proceeds in multiple steps. One of
> +the steps is identifying and reserving the DPA span that each member of
> +the interleave-set (region) contributes in advance of attaching that
> +allocation to a region. For development, test, and debug purposes this
> +command is a helper to find the next available decoder on endpoint
> +(memdev) and mark a span of DPA as busy.
> +
> +OPTIONS
> +-------
> +<memory device(s)>::
> +include::memdev-option.txt[]
> +
> +-d::
> +--decoder::
> +	Specify the decoder to attempt the allocation. The CXL specification
> +	mandates that allocations must be ordered by DPA and decoder instance.
> +	I.e. the lowest DPA allocation on the device is covered by deocder0, and

decoder0

> +	the last / highest DPA allocation is covered by the last decoder. This
> +	ordering is enforced by the kernel. By default the tool picks the 'next
> +	available' decoder.

