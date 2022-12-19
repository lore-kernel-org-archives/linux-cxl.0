Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF8FC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 16:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiLSQMe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiLSQM2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 11:12:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBECEDF46
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 08:12:26 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbPlr51m3z6H7JK;
        Tue, 20 Dec 2022 00:09:12 +0800 (CST)
Received: from localhost (10.81.210.222) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 16:12:24 +0000
Date:   Mon, 19 Dec 2022 16:12:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rrichter@amd.com>,
        <terry.bowman@amd.com>
Subject: Re: [RFC PATCH 0/8] cxl: Introduce HDM decoder emulation from DVSEC
 range registers
Message-ID: <20221219161223.000077f3@Huawei.com>
In-Reply-To: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.222]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Nov 2022 16:12:15 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> This series provides the emulation of HDM decoders from the programmed range
> registers. From CXL 3.0 spec 8.1.3.8, there can be up to 2 ranges programmed.
> Some device may not implement HDM decoder registers and some may not be
> programmed by the BIOS. Under such scenarios, if one of more range registers
> are programmed, then we can create an emulated HDM decoder per active range
> indicated by the range registers. The emulated HDM decoders will show up as
> locked and cannot be reprogrammed.
> 
> Below is a table that indicates different scenarios the driver may encounter:
> 
> rr: Range registers not programmed
> hdm: HDM decoders not programmed
> RR: Range registers programmed by BIOS
> HDM: HDM decoders programmed by BIOS
> 
> emulate HDM: Create HDM decoder software structs and use values from range registers.
> keep HDM: Populate HDM decoder software structs with values in HDM decoder registers.
> 
> rr             RR             rr hdm	 rr HDM	     RR hdm        RR HDM
> unsupported    emulate HDM    keep HDM	 keep HDM    emulate HDM   keep HDM
> 
> This series is based on the current RCD work [1] that's going through upstream review.
> For convenience, the kernel branch can be retrieved here [2].

Just to check, why is this an RFC rather than a normal submission?
Because of the unstable dependency?

At least at top level, it looks like a sensible approach.

> 
> [1]: https://lore.kernel.org/linux-cxl/Y4ePZD776yXv2rG3@rric.localdomain/T/#t
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch
> 
> ---
> 
> Dave Jiang (8):
>       cxl: break out range register decoding from cxl_hdm_decode_init()
>       cxl: export cxl_dvsec_rr_decode() to cxl_port
>       cxl: refactor cxl_hdm_decode_init()
>       cxl: emulate HDM decoder from DVSEC range registers
>       cxl: create emulated cxl_hdm for devices that do not have HDM decoders
>       cxl: create emulated decoders for devices without HDM decoders
>       cxl: suppress component register discovery failure warning for RCD
>       cxl: remove locked check for dvsec_range_allowed()
> 
> 
>  drivers/cxl/core/hdm.c | 115 +++++++++++++++++++++++---
>  drivers/cxl/core/pci.c | 179 +++++++++++++++++------------------------
>  drivers/cxl/cxl.h      |  20 ++++-
>  drivers/cxl/cxlmem.h   |  13 +--
>  drivers/cxl/cxlpci.h   |   3 +-
>  drivers/cxl/pci.c      |   2 +-
>  drivers/cxl/port.c     |  19 +++--
>  7 files changed, 215 insertions(+), 136 deletions(-)
> 
> --
> 

