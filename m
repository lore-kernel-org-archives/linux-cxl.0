Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83831C4743C
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Jun 2021 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA3D61414
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Jun 2021 17:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFDR7p (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:59:45 -0400
Received: from foss.arm.com ([217.140.110.172]:44986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhFDR7p (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 4 Jun 2021 13:59:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72C542B;
        Fri,  4 Jun 2021 10:57:58 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CDA23F73D;
        Fri,  4 Jun 2021 10:57:57 -0700 (PDT)
Subject: Re: [RFC PATCH] Documentation/arm64: describe the kernel's
 expectations of 'memory'
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-cxl@vger.kernel.org
References: <20210517103319.5356-1-james.morse@arm.com>
 <20210517122701.00005e19@Huawei.com>
 <CAMj1kXHvQ1v7W8jdTaEmp9q-Vj+S9dz0P-Q4YZd5iNnqaBSf+A@mail.gmail.com>
 <20210517131725.00002068@Huawei.com>
 <CAMj1kXHg9bOWuKmiPLgAz44ezDrVoZrWBBepgqG3M8uB+kco7A@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <283cdb6c-1a47-21bc-6462-32ec8c94020c@arm.com>
Date:   Fri, 4 Jun 2021 18:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHg9bOWuKmiPLgAz44ezDrVoZrWBBepgqG3M8uB+kco7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan, Ard,

On 17/05/2021 13:25, Ard Biesheuvel wrote:
> On Mon, 17 May 2021 at 14:19, Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>> On Mon, 17 May 2021 13:55:16 +0200 Ard Biesheuvel <ardb@kernel.org> wrote:
>>> On Mon, 17 May 2021 at 13:30, Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>>>> On Mon, 17 May 2021 11:33:19 +0100 James Morse <james.morse@arm.com> wrote:>>>>> Document linux's expectations around the behaviour of memory as the

>>>>> +On arm64, the kernel does not rewrite the UEFI memory map when memory is added
>>>>> +or removed. On device memory that is present at boot, but must be removed later
>>>>
>>>> Might be worth giving an example of why memory 'must be removed'?  I'm not sure
>>>> what you are getting at there.

[...]

>> Two separate issues here. The 'broken' one where _SP or indeed
>> hotplug flag is no use, and the one where it is 'must be removed later'
>> and we just don't want to put unmovable allocations in it.

> I am not sure I follow the 'must be removed' thing. Why is that needed?

This phrase was to cover people who want to remove memory that was present at boot... but
they didn't want it to be. I think dedicating it to VMs is the popular use case, (and, er,
bypassing all the OSes memory management...).

If its in the UEFI memory map, the kernel expects it can't be removed. It might be in use
by something, and even if its not - we don't want to rewrite the UEFI
tables/tree/lists/maps to remove it, and we certainly can't do that in a future proof manner.

It might not be relevant to CXL, but its one of the pain points of hotplug memory.

I'm not sure I can come up with a terse example:
| e.g. a memory carve-out that must be also be respected by a future OS loaded via kexec()
?


Thanks,

James
