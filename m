Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FBFC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Mar 2022 08:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiCRIQi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiCRIQh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 04:16:37 -0400
Received: from mail.default.ilande.bv.iomart.io (mail.ilande.co.uk [IPv6:2001:41c9:1:41f::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C52AD5E0
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 01:15:18 -0700 (PDT)
Received: from [2a00:23c4:8ba2:c800:3cf5:fb4b:b388:106c]
        by mail.default.ilande.bv.iomart.io with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <mark.cave-ayland@ilande.co.uk>)
        id 1nV7ka-0007Qx-02; Fri, 18 Mar 2022 08:14:20 +0000
Message-ID: <d710c6e1-a9b7-ed0d-ca23-c4315355268c@ilande.co.uk>
Date:   Fri, 18 Mar 2022 08:14:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Samarth Saxena <samarths@cadence.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Markus Armbruster <armbru@redhat.com>,
        Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
        linuxarm@huawei.com, linux-cxl@vger.kernel.org,
        Igor Mammedov <imammedo@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
 <20220306163119-mutt-send-email-mst@kernel.org>
 <20220307093918.00002f20@Huawei.com> <YihiHNxVjDFI0Z8r@xz-m1.local>
 <20220309112827.00002c73@Huawei.com> <Yimwjtd8SsVLOU5e@xz-m1.local>
 <20220316165034.000037e7@Huawei.com>
 <1efbfeeb-2598-57c5-2e2d-4f5fa2538aa7@ilande.co.uk>
 <20220316175846.00007463@Huawei.com> <20220316182618.00003ce5@Huawei.com>
 <31f383e6-01bb-cf9a-6af8-d0f1821b3fd1@ilande.co.uk>
 <20220317164723.00001c14@huawei.com>
From:   Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20220317164723.00001c14@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8ba2:c800:3cf5:fb4b:b388:106c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v7 00/46] CXl 2.0 emulation Support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.bv.iomart.io)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 17/03/2022 16:47, Jonathan Cameron via wrote:

>> Ah great! As you've already noticed my particular case was performing partial
>> decoding on a memory region, but there are no issues if you need to dispatch to
>> another existing address space such as PCI/IOMMU. Creating a separate address space
>> per device shouldn't be an issue either, as that's effectively how the PCI bus master
>> requests are handled.
>>
>> The address spaces are visible in "info mtree" so if you haven't already, I would
>> recommend generating a dynamic name for the address space based upon the device
>> name/address to make it easier for development and debugging.
> info mtree already provides the following with a static name
> address-space: cxl-type3-dpa-space
>    0000000000000000-000000000fffffff (prio 0, nv-ram): cxl-mem2
> 
> So the device association is there anyway.  Hence I'm not sure a dynamic name adds
> a lot on this occasion and code is simpler without making it dynamic.

Is this using a single address space for multiple memory devices, or one per device 
as you were suggesting in the thread? If it is one per device and cxl-mem2 is the 
value of the -device id parameter, I still think it is worth adding the same device 
id into the address space name for the sake of a g_strdup_printf() and corresponding 
g_free().

Alas I don't currently have the time (and enough knowledge of CXL!) to do a more 
comprehensive review of the patches, but a quick skim of the series suggests it seems 
quite mature. The only thing that I noticed was that there doesn't seem to be any 
trace-events added, which I think may be useful to aid driver developers if they need 
to debug some of the memory access routing.

Finally I should point out that there are a number of more experienced PCI developers 
on the CC list than me, and they should have the final say on patch review. So please 
consider these comments as recommendations based upon my development work on QEMU, 
and not as a NAK for proceeding with the series :)


ATB,

Mark.
