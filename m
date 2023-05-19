Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFAEC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjESP55 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 11:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjESP5x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 11:57:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7689183
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 08:57:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso21568575e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684511854; x=1687103854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRnUqNHlL4vvXFFu38W8sO7cIUqDAJNRsqtDH6OXVSk=;
        b=mnS3NKNYTA797Z/NaHfJ37SOs33DHAayAOpozBl2931iV7igxiGH9ENyDGZR0HYfOB
         lNluQLQndIpOFgQ2SfARYU12Ja7WtK7HuIc1nN24iiSN0G+2eyomlONwhaPWxAvUrFVi
         d9imQWRdnvutzaSwXbBLuB3Qx1m3N249IPoPcCI0Hpn1AqfsWje/u78Pv0iDViz6Z2Kb
         1KBrZQr8/k3kxlMuHizTj2TIT3Pg937gSI+jiPkU0flPyLZgY6L4dYu1gByGgE+SPFlG
         E6CBcU12sIMd+VVqYiCL/CmNnSSWIcdarFOIyBaj++1RABfjgFgV/FvVrkQ7uv83Gny/
         RgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684511854; x=1687103854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRnUqNHlL4vvXFFu38W8sO7cIUqDAJNRsqtDH6OXVSk=;
        b=ZrJzTryfc1vB1Paof5DfqVl79B4dE3SGJBsvC/gqnXLCoYPrgBmafZF7RCg89RF6/3
         3U09lHQa46kOTmppls7SNqrWigy+u3ADy2Vl5Sq0SXyyG4e/JO7MzR6B2i36utp3vFfd
         ZXcCekqfQ3IB2M+FpjekNrPugrKOcyv2b3H9XT49SmNNSXxpLMfgBdLly6IImS4biQik
         8jJKLUiVLxQwNsmGv6ycqwpGJ5bZ6OAELoZ3rdxDw1obTV8Gl2WzCzDXryu6ODYqjqRu
         zrQ1Pz9TN53FGb20E3TwpaR8jybaXwnxMibCqzQ749y1Q2Bs3amPWWojX5u08EbIFNFG
         oxQw==
X-Gm-Message-State: AC+VfDzDynL73n/n7gmOs+rX/RzDpwJNIqxH9TntKv2gRdD2GoiVXogb
        07u1/x9vWDmDUrJS904GRh1PdA==
X-Google-Smtp-Source: ACHHUZ6SfcrcFIc1c4107FDZSSyO6Pk4nbjMhkTLabkvZ9fjDDJ+tdQk0VxKLnTPyrG+iON399vaOA==
X-Received: by 2002:a05:600c:2285:b0:3f1:662a:93d0 with SMTP id 5-20020a05600c228500b003f1662a93d0mr1884634wmf.15.1684511854209;
        Fri, 19 May 2023 08:57:34 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bca4d000000b003f4dde07956sm2769753wml.42.2023.05.19.08.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 08:57:33 -0700 (PDT)
Message-ID: <b06ee1dc-6ddb-327d-1180-d139862f9173@linaro.org>
Date:   Fri, 19 May 2023 17:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v6 6/7] hw/cxl/events: Add injection of DRAM events
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
References: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
 <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
 <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
 <20230519164533.0000436d@Huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519164533.0000436d@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 19/5/23 17:45, Jonathan Cameron wrote:
> On Fri, 19 May 2023 17:34:20 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Hi Jonathan,
>>
>> On 19/5/23 16:30, Jonathan Cameron wrote:
>>> Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
>>> provides information related to DRAM devices.
>>>
>>> Example injection command in QMP:
>>>
>>> { "execute": "cxl-inject-dram-event",
>>>       "arguments": {
>>>           "path": "/machine/peripheral/cxl-mem0",
>>>           "log": "informational",
>>>           "flags": 1,
>>>           "physaddr": 1000,
>>>           "descriptor": 3,
>>>           "type": 3,
>>>           "transaction-type": 192,
>>>           "channel": 3,
>>>           "rank": 17,
>>>           "nibble-mask": 37421234,
>>>           "bank-group": 7,
>>>           "bank": 11,
>>>           "row": 2,
>>>           "column": 77,
>>>           "correction-mask": [33, 44, 55,66]
>>>       }}
>>>
>>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>    hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
>>>    hw/mem/cxl_type3_stubs.c    |  13 ++++
>>>    include/hw/cxl/cxl_events.h |  23 +++++++
>>>    qapi/cxl.json               |  35 +++++++++++
>>>    4 files changed, 187 insertions(+)
>>
>>
>>> diff --git a/qapi/cxl.json b/qapi/cxl.json
>>> index 7e1e6257ce..5e82097e76 100644
>>> --- a/qapi/cxl.json
>>> +++ b/qapi/cxl.json
>>> @@ -55,6 +55,41 @@
>>>                '*device': 'uint32', '*component-id': 'str'
>>>                }}
>>>    
>>> +##
>>> +# @cxl-inject-dram-event:
>>> +#
>>> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
>>> +# This event type is reported via one of the event logs specified via
>>> +# the log parameter.
>>> +#
>>> +# @path: CXL type 3 device canonical QOM path
>>> +# @log: Event Log to add the event to
>>> +# @flags: header flags
>>> +# @physaddr: Physical Address
>>
>> Could this be a clearer description?
>>
>> "Physical Address (relative to @path device)"
> 
> Makes sense.
> 
>>
>>> +# @descriptor: Descriptor
>>> +# @type: Type
>>> +# @transaction-type: Transaction Type
>>> +# @channel: Channel
>>> +# @rank: Rank
>>> +# @nibble-mask: Identify one or more nibbles that the error affects
>>
>>> +# @bank-group: Bank group
>>> +# @bank: Bank
>>> +# @row: Row
>>> +# @column: Column
>>
>> Why do we need bank/raw/col if we have physaddr?
> 
> Yes we need them. We don't know the device geometry / internal interleaving
> / address hashing applied to smooth out access patterns etc.
> 
> I really don't want to put that level of complexity into the command
> line for a device - so just left it to the test tools to squirt in
> something valid.
> 
>>
>> These are optional. Shouldn't we check they are valid
>> in qmp_cxl_inject_dram_event()? (No clue, just wondering
>> if there is some duplication here).
> 
> Validation is really hard for these as depends on the above
> device implementation complexity.  There is a note on trying to
> strike the balance in the cover letter. I'm not sure I have it
> right! They are optional in records coming from the device, so
> we set validity flags for them in the device record.
> 
> Aim here is to be able to inject whatever might be seen on a real device
> without having to have QEMU emulate a bunch of device internals
> such as mappings to particular DRAM FRU, chip, column, row etc.

I was expecting some check like:

   ROUND_DOWN(physaddr, 8) == bank * row * column * 8

But indeed this isn't really useful for your tests, since we want to
check sanity for values from the guest, not from human via QMP.
So FWIW overall LGTM.

> 
> 
>>
>>> +# @correction-mask: Bits within each nibble. Used in order of bits set
>>> +#                   in the nibble-mask.  Up to 4 nibbles may be covered.
>>> +#
>>> +# Since: 8.1
>>> +##
>>> +{ 'command': 'cxl-inject-dram-event',
>>> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
>>> +            'physaddr': 'uint64', 'descriptor': 'uint8',
>>> +            'type': 'uint8', 'transaction-type': 'uint8',
>>> +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
>>> +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
>>> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
>>> +           }}
>>> +
>>>    ##
>>>    # @cxl-inject-poison:
>>>    #
>>
> 

