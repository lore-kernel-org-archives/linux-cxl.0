Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A41BC4320A
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2E361100
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 15:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhHBPOZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:14:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3553 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbhHBPOZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Aug 2021 11:14:25 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdhNt65mDz6FFsJ;
        Mon,  2 Aug 2021 23:14:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 2 Aug 2021 17:14:14 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 16:14:13 +0100
Date:   Mon, 2 Aug 2021 16:13:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v3 0/6] CXL core reorganization
Message-ID: <20210802161345.00003f8f@Huawei.com>
In-Reply-To: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 30 Jul 2021 13:06:55 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Changes since v2 [1]:
> - Rebase on top of the Makefile changes
> - Split register and pmem moving into 2 independent patches
> - Drop inclusion of mem.h and cxl.h from core.h. I.e. require all
>   compilation units to directly include only the headers they need.
> - Squash / rewrite "cxl/mem: Move character device region creation" to
>   move the char-dev infrastructure to drivers/cxl/core/memdev.c
> - Rewrite the justification in some of the changelogs
> - Rewrite "cxl: Pass fops and shutdown to memdev creation" to introduce
>   cdevm_file_operations.
> 
> [1]: https://lore.kernel.org/linux-cxl/20210720180742.89992-1-ben.widawsky@intel.com/
> 
> ---
> 
> Given Ben is out for a bit I have folded my review comments into the set
> directly.
> 
> Original Cover from Ben:
> 
> The main motivation of the patch series is to establish the cxl_core driver in
> its own directory and modularize it. Specifically, the patch series aims to
> achieve three things:
> 1. Move existing core functionality to a new directory.
> 2. Split existing core functionality into multiple files.
> 3. Migrate memdev functionality into core.
> 
> #1 is trivially accomplished with git mv. The file itself is renamed back to
> bus.c since the goal is to break up core functionality into multiple files, and
> so the name core.c doesn't make sense in that context.
> 
> #2 is also trivially accomplished via cut/paste.
> 
> #3 is slightly invasive in that it has certain functional changes to improve the
> existing interfaces and make them more generic. The rest of the change is
> cut/paste. This is also the only part of the series which has runtime functional
> change in that some interfaces are removed from cxl_pci, moved into cxl_core,
> and exported for other drivers to use.

FWIW all looks good to me and new break up of files seems sensible.
Seems a bit excessive for this set, but we don't have a sanity-checked-by tag.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> 
> Ben Widawsky (3):
>       cxl: Move cxl_core to new directory
>       cxl/core: Improve CXL core kernel docs
>       cxl/core: Move memdev management to core
> 
> Dan Williams (3):
>       cxl/core: Move pmem functionality
>       cxl/core: Move register mapping infrastructure
>       cxl/pci: Introduce cdevm_file_operations
> 
> 
>  Documentation/driver-api/cxl/memory-devices.rst |    8 
>  drivers/cxl/Makefile                            |    4 
>  drivers/cxl/core/Makefile                       |    8 
>  drivers/cxl/core/bus.c                          |  463 +----------------------
>  drivers/cxl/core/core.h                         |   20 +
>  drivers/cxl/core/memdev.c                       |  245 ++++++++++++
>  drivers/cxl/core/pmem.c                         |  204 ++++++++++
>  drivers/cxl/core/regs.c                         |  235 ++++++++++++
>  drivers/cxl/mem.h                               |   26 +
>  drivers/cxl/pci.c                               |  257 +------------
>  10 files changed, 791 insertions(+), 679 deletions(-)
>  create mode 100644 drivers/cxl/core/Makefile
>  rename drivers/cxl/{core.c => core/bus.c} (58%)
>  create mode 100644 drivers/cxl/core/core.h
>  create mode 100644 drivers/cxl/core/memdev.c
>  create mode 100644 drivers/cxl/core/pmem.c
>  create mode 100644 drivers/cxl/core/regs.c
> 
> base-commit: ff1176468d368232b684f75e82563369208bc371

