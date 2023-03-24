Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC4C76195
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Mar 2023 09:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCXJbZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Mar 2023 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCXJbY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Mar 2023 05:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279691ACF4
        for <linux-cxl@vger.kernel.org>; Fri, 24 Mar 2023 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679650243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21j5HZHNaqnqYk/qMb/3bvONholuvmzFTx+bQH+Yn+o=;
        b=h4LU+l3zYuS6MYCtSl+weDUAmxL4XBHHhstguV+0y0Oo0IhQ5W19UkS+ERe196dqWbAKAx
        7iL7k/UEoVaLEg8AqeLLKamISxpSrLENaCFGzPJpXpJBEaJ8IG0wwtd27/SUQ1LimaPn/k
        5+JkJqik2sFOrhdl29O30BjWjS7YGzI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-cWdaXyzfMFalnbgLRIuhDA-1; Fri, 24 Mar 2023 05:30:42 -0400
X-MC-Unique: cWdaXyzfMFalnbgLRIuhDA-1
Received: by mail-wm1-f70.google.com with SMTP id m7-20020a05600c4f4700b003ee7e120bdfso755644wmq.6
        for <linux-cxl@vger.kernel.org>; Fri, 24 Mar 2023 02:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650241;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21j5HZHNaqnqYk/qMb/3bvONholuvmzFTx+bQH+Yn+o=;
        b=LoayCPNB4F3QA5jCKrky8c2kpoFgKqQkkF1GicrCgYxROxdPh8v7JOWZJH4N59zpyr
         7MM8kkkpCJq5L5rKDGN5cXwKEE/t+g1VoClGir0ZapzFyhR12fLxdR5oNLNQUNwhHgTj
         eYJMqjWVw5vOf788O5iCb2Y10F0oV4H4GkU52Wq9MczLr4nwmeAjg6e7RS3wbXKwKROH
         BR4Q4B2WlYbE9txAXF5RMhKt0+R/pXS8ljxB7Pc8EdDTwJvD+bf3OfT0HnUdF3peXBAG
         wfheKG64PTSAUOZrbAHszVqExSu5UhLaTzv2AnNuercDGO2ePi49dCbgYT+KgeLmluwe
         R+Ew==
X-Gm-Message-State: AO0yUKX4mNM7j4SvOOHuPjFVOoJQyt13ka6VvAmAtIJBc2jYqtK+Qg+2
        BZ9sBC3VQm0zl3N7jQP2JkW1kBtTqoIgPgdwSOnDfuI8iezaykEIzArXhgNPwFhhV1Xn09J/OJA
        ywEAA9lggHXF3Tf2M9BM2
X-Received: by 2002:a05:600c:2289:b0:3df:e468:17dc with SMTP id 9-20020a05600c228900b003dfe46817dcmr1727269wmf.40.1679650240909;
        Fri, 24 Mar 2023 02:30:40 -0700 (PDT)
X-Google-Smtp-Source: AK7set/IiMAnVG44QY0lj4W/8T78wkjWb5uNZDBeaBMhsRJC8+SM5VO0asITh0DvQ+GzWK5qGo9Tvg==
X-Received: by 2002:a05:600c:2289:b0:3df:e468:17dc with SMTP id 9-20020a05600c228900b003dfe46817dcmr1727251wmf.40.1679650240530;
        Fri, 24 Mar 2023 02:30:40 -0700 (PDT)
Received: from [10.105.158.254] ([88.128.92.189])
        by smtp.gmail.com with ESMTPSA id ay6-20020a05600c1e0600b003ee443bf0c7sm1318153wmb.16.2023.03.24.02.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:30:39 -0700 (PDT)
Message-ID: <91d02705-1c3f-5f55-158a-1a68120df2f4@redhat.com>
Date:   Fri, 24 Mar 2023 10:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com
References: <5536d792-867d-6390-81e2-b1ef135d347d@redhat.com>
 <CGME20230324092731epcas2p315c348bd76ef9fc84bffdb158e4c1aa4@epcas2p3.samsung.com>
 <20230324092731.148023-1-ks0204.kim@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230324092731.148023-1-ks0204.kim@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 24.03.23 10:27, Kyungsan Kim wrote:
>> On 24.03.23 10:09, Kyungsan Kim wrote:
>>> Thank you David Hinderbrand for your interest on this topic.
>>>
>>>>>
>>>>>> Kyungsan Kim wrote:
>>>>>> [..]
>>>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>>>
>>>>>>> We also don't think a new zone is needed for every single memory
>>>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>>>> manage multiple volatile memory devices due to the increased device
>>>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>>>> represent extended volatile memories that have different HW
>>>>>>> characteristics.
>>>>>>
>>>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>>>> volatile memories that have different HW characteristics". It needs to
>>>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>>>> dimension" starts to dominate.
>>>>>
>>>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>
>>>> That sounds like a bad hack :) .
>>> I consent you.
>>>
>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>
>>>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>>>> similar to what you have in mind here. In general, adding new zones is
>>>> frowned upon.
>>>
>>> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
>>> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
>>> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
>>>
>>> We think ZONE_EXMEM also helps less fragmentation.
>>> Because it is a separated zone and handles a page allocation as movable by default.
>>
>> So how is it different that it would justify a different (more confusing
>> IMHO) name? :) Of course, names don't matter that much, but I'd be
>> interested in which other aspect that zone would be "special".
> 
> FYI for the first time I named it as ZONE_CXLMEM, but we thought it would be needed to cover other extended memory types as well.
> So I changed it as ZONE_EXMEM.
> We also would like to point out a "special" zone aspeact, which is different from ZONE_NORMAL for tranditional DDR DRAM.
> Of course, a symbol naming is important more or less to represent it very nicely, though.
> Do you prefer ZONE_SPECIAL? :)

I called it ZONE_PREFER_MOVABLE. If you studied that approach there must 
be a good reason to name it differently?

-- 
Thanks,

David / dhildenb

