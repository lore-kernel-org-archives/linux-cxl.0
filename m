Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84027C54E94
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 15:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjAYPEV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 10:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjAYPEV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 10:04:21 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1240F4
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 07:04:19 -0800 (PST)
Message-ID: <d733b3a4-757a-624f-18a4-ad27b1ef1f77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674659057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=065lIp5QoklAmpCqSepFXIoQ+hUmkGd7Jl709G0y4O4=;
        b=CNpiEokPXOmbOYFb7mtzpMyIILFNQ+z/SxG+AVOAYqGi0OKyFunsWRjLPKsnEqX/ICaexg
        QIlEfqJdQtMKw3qHh+Ht1RboAHSLTV7Pq9UVnuLlmEKS9JCwxKUWei+8IO7t8Gplzm7fVw
        fde5R0qgeb0uOE5GMvCEhwoAze8DLbc=
Date:   Wed, 25 Jan 2023 23:04:00 +0800
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
To:     Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jerome Glisse <jglisse@google.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <CAHbLzkpJa=HYH7OAdFO6WGYXtX1Yzhv9sFE+MGfyZrd3KvUv=A@mail.gmail.com>
 <CAAPL-u9w2K6q4nF6+VKxafZYNr1WqsROYCQc6gqVS0BVXt0-Bg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAAPL-u9w2K6q4nF6+VKxafZYNr1WqsROYCQc6gqVS0BVXt0-Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

在 2023/1/24 8:57, Wei Xu 写道:
> On Mon, Jan 23, 2023 at 4:22 PM Yang Shi <shy828301@gmail.com> wrote:
>>
>> On Sun, Jan 22, 2023 at 9:51 PM David Rientjes <rientjes@google.com> wrote:
>>>
>>> On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
>>>
>>>> CC: LSF/MM/BPF mailing list. Sorry, missed the list.
>>>>
>>>>> On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko <viacheslav.dubeyko@bytedance.com> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> I believe CXL memory is hot topic now. I believe we have multiple topics
>>>>> for discussion. I personally would like to discuss CXL Fabric Manager
>>>>> and vision of FM architecture implementation. I am going to share the topic
>>>>> in separate email. I would like to suggest a special session for CXL memory
>>>>> related topics.
>>>>>
>>>>> How everybody feels about it?
>>>>>
>>>
>>> I think this makes a lot of sense, thanks for suggesting it.
>>>
>>> Should this be a BoF or just a normal topic proposal?  I assume that there
>>> could be several different topics of interest all related to CXL.mem.
>>>
>>> Specifically interesting would be the division of work between the kernel
>>> and userspace to manage memory placement on systems with locally attached
>>> CXL.  And, further, what APIs userspace would have at its disposal for
>>> explicit optimization of this placement that would exist beyond what is
>>> available for NUMA.
>>
>> Yeah, in addition, how CXL hierarchy interacts with memory tiering may
>> be an interesting topic too.
>>
>>>
>>> I assume we might also want to chat about CXL 2.0 extensions that would be
>>> useful, especially for cloud providers.
>>>
>>> I'd be happy to join in any of the proposals for these topics, just let me
>>> know!
>>
>> +1 for me.
>>
> 
> I am also interested in these discussions.

+1， I am interested in this.

> 

