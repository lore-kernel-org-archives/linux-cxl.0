Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A1C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 10:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbiA1KZI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:25:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4540 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiA1KZH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 05:25:07 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlYQh4DJsz67xlM;
        Fri, 28 Jan 2022 18:21:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 11:25:05 +0100
Received: from localhost (10.47.76.156) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 10:25:05 +0000
Date:   Fri, 28 Jan 2022 10:24:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Li Qiang (Johnny Li)" <johnny.li@montage-tech.com>,
        John Groves <john@jagalactic.com>, <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        John Groves <JGroves@micron.com>
Subject: Re: Should bios always mark CXL DRAM as EFI_MEMORY_SP?
Message-ID: <20220128102458.00006063@Huawei.com>
In-Reply-To: <CAPcyv4hWcxoEw=umN=0xDe4Ychfxe6GysYOBcxK6oHLEDhz1iw@mail.gmail.com>
References: <07cedbe6-00ab-52fc-9475-c8d7120f5a95@jagalactic.com>
        <0100017e9c54d4e0-c1f1a7db-e2ab-4552-a7eb-8e4b56cd9528-000000@email.amazonses.com>
        <02c601d813fc$a8744c70$f95ce550$@montage-tech.com>
        <CAPcyv4hWcxoEw=umN=0xDe4Ychfxe6GysYOBcxK6oHLEDhz1iw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.76.156]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 27 Jan 2022 21:28:40 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Jan 27, 2022 at 8:12 PM Li Qiang (Johnny Li)
> <johnny.li@montage-tech.com> wrote:
> >
> > I think BIOS should follow CDAT spec v1.01 Device Scoped EFI Memory Type Structure (DSEMTS) structure
> >
> > In Table 8 Device Scoped EFI Memory Type Structure, field EFI Memory Type and Attribute has below definition
> >   0 – EfiConventionalMemory
> >   1 - EfiConventionalMemory Type with EFI_MEMORY_SP Attribute
> >   2 – EfiReservedMemoryType
> >   3-255 – Reserved encoding
> >   The memory attribute EFI_MEMORY_NV may be inferred from NonVolatile flag in DSMAS.
> >   Memory types other than EfiConventionalMemory and EfiReservedMemoryType are not permitted.  
> 
> Definitely BIOS should follow CDAT for the type, but it's not so clear
> to me the same can be said about the attribute. I think the bigger
> question is when should devices claim to be EFI_MEMORY_SP, and when
> should BIOS apply EFI_MEMORY_SP regardless of what the device
> advertises. EFI_MEMORY_SP is a claim about usage that the memory is
> either too high performance or too low performance to be added to the
> general memory pool by default. That's not a decision that a device
> necessarily knows how to make on its own. The platform BIOS might have
> a better chance to know intended application the system was built. The
> OS kernel is somewhat blind to usage but OS policy can do the last
> mile tuning of how much if any memory of a given performance class
> should be set aside for exclusive access.

I'd add another spin based on where EFI_MEMORY_SP originally came from,
though it's not relevant to memory only devices which I think is what
is being discussed here.

For some devices the memory will work fine as general purpose RAM, but
it was put there with an intended use.  Typically something like DDR
attached to a GPU or other accelerator.  Might be nice and quick for
general use, but it's even quicker if the GPU is using it :)

Again, how much to reserve for what usecase is an OS policy decision
hence the hint from the attribute.  Neither the device nor the
bios can know the answer as it depends on what is actually being run
in the OS.

Jonathan
