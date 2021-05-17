Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543D4C433ED
	for <linux-cxl@archiver.kernel.org>; Mon, 17 May 2021 11:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A99D610CB
	for <linux-cxl@archiver.kernel.org>; Mon, 17 May 2021 11:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbhEQLaI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 May 2021 07:30:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2954 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbhEQLaH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 May 2021 07:30:07 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkGzH5LMXzCsdT;
        Mon, 17 May 2021 19:26:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 19:28:48 +0800
Received: from localhost (10.52.123.135) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 12:28:46 +0100
Date:   Mon, 17 May 2021 12:27:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH] Documentation/arm64: describe the kernel's
 expectations of 'memory'
Message-ID: <20210517122701.00005e19@Huawei.com>
In-Reply-To: <20210517103319.5356-1-james.morse@arm.com>
References: <20210517103319.5356-1-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.135]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 17 May 2021 11:33:19 +0100
James Morse <james.morse@arm.com> wrote:

> Standards such as CXL allow memory on PCIe devices to be made
> available to the operating system for use as regular memory.
> 
> Document linux's expectations around the behaviour of memory as the
> implementations of these new standards may need special treatment in
> the OS, firmware or bootloader.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Hi James,

+CC linux-cxl to pick up a few more interesting people who might loose
this in the wash of linux-arm-kernel

Good to see this description as there has been some confusion on this
point. This basically looks like what I'd expect to see. Just a few
comments around firmware description towards the end.

> ---
>  Documentation/arm64/memory.rst | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
> index 901cd094f4ec..951802aee55f 100644
> --- a/Documentation/arm64/memory.rst
> +++ b/Documentation/arm64/memory.rst
> @@ -167,3 +167,34 @@ from a 52-bit space by enabling the following kernel config options:
>  
>  Note that this option is only intended for debugging applications
>  and should not be used in production.
> +
> +On device memory used as regular memory
> +---------------------------------------
> +Standards such as CXL allow memory on PCIe device to be made
> +available to the operating system for use as regular memory.
> +
> +If memory is added to the UEFI memory map or DT, or discovered via ACPI's SRAT,
> +linux expects it to function in the same way as the bulk DRAM. This section

Linux

> +terms this 'regular memory'.
> +
> +The kernel may use any attributes to map this memory, e.g. Device-nGnRnE or
> +Normal Writeback-Cacheable. The kernel may not be in control of the attributes
> +used, e.g. if the memory is used by a KVM guest.
> +The kernel will perform cache maintenance to resolve mismatched attributes,
> +e.g. invalidating clean stale lines after writing new data when the MMU is
> +disabled.
> +
> +The memory may be used by any instruction supported by the CPUs.
> +e.g. Even when the v8.1 LSE atomic instructions are supported, the v8.0
> +exclusives are still used for the futex code, and conditional waits, and still
> +used by existing user-space binaries. When the CPUs support features such as
> +MTE, all regular memory must support MTE tags.
> +
> +On device memory that does not function in the same way as regular memory must
> +not be added to the UEFI memory map or DT, or be discovered via ACPI's SRAT.
> +
> +On arm64, the kernel does not rewrite the UEFI memory map when memory is added
> +or removed. On device memory that is present at boot, but must be removed later

Might be worth giving an example of why memory 'must be removed'?  I'm not sure
what you are getting at there.  Specific purpose memory?

> +should be discovered via ACPI's SRAT to ensure it is not used for non-movable
> +structures.

Not sure I follow this part.  It could be of type EFI_MEMORY_SP.
It should be in SRAT as well, but the EFI type should be sufficient to avoid
problems. 
"The SPM attribute serves as a hint to the OS to avoid allocating this memory
 for core OS data or code that can not be relocated."

Now I'm not sure the kernel is handling EFI_MEMORY_SP fully yet...  If
we need to exclude this approach for now, then this text should perhaps
call it out explicitly.

> +e.g. the kernel text, page tables or the GIC ITS Pending Table.

