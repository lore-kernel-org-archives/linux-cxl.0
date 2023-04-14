Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6C1C77B73
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 03:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDND1B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Apr 2023 23:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDND06 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Apr 2023 23:26:58 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76798526E
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 20:26:36 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 94A5D141D6D;
        Fri, 14 Apr 2023 03:26:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1BBA2141B11;
        Fri, 14 Apr 2023 03:26:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681442795; a=rsa-sha256;
        cv=none;
        b=6KNglir6T0ES+Uvqhj2N2Ef/4WS+LQFOc/zQwhs2MsT/UXEj5kxf2FiILBydsO92wO6ZF/
        Qx9PGMxALvthvLk4CjWzcwX4U/QPgFRVnIJIdgQpfTVF9GY/WqReWoyrB561a/yjzau3x+
        FbLbXzh+Av9wvBKPTPaXJFy5Zq9JVAY0rSeWXgm0TA7sOK7QzIJ4OVYWVXZOBvyFwXymqI
        9TmrZYuP2TtZ/eca+GpvC6ffT+0RqsMT4DXMIdBgDOIqzK17asiXBdgvIGDSEfYnrk+b/w
        O64vY7VjdT76KqlRx2b7VVItGShjPeYCWEZcqFIlGshpp+Cbys6Kz04omzGb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681442795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=N/lTarvnkB+0LFxZohuEdHLcN5PE+7h/ShEQ5wITcGY=;
        b=py4TEPo0cYZoIcRJj4bVfP7Lm/lNoItGYJLxgG1LnJ+QxxRdfFOSynTVgkxl8NiIW1m0+E
        O7O6Id3P2q+oMcK77Voi5Rpl0b18fcaJ7ofCGKqWtPiOlwec7Je/NmwLjplT/lGlJ3xRmG
        7xuaIg4zKYrq0Pw2SSGHjyOLvmCiU7jemId9Yze+P2UYAYaGRkOOQ99zHtHJHFmuc5fYpn
        cuzQR+vp74ER2GfFycf3no1QKGMYoEN6UL0h8o07cMW3d49vDuzk9hxZq1vTReu14ctdAo
        ar6MJ826W4C1CXxV2Payjup7OXw5i7MI2n/ShacaSmJq90+uyTgq/OGOYK6SUw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-gmsjp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Share-Descriptive: 0b3fb7156a1d06a0_1681442795401_3572895650
X-MC-Loop-Signature: 1681442795401:783723915
X-MC-Ingress-Time: 1681442795400
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.224 (trex/6.7.2);
        Fri, 14 Apr 2023 03:26:35 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4PyMLL2wvyz62;
        Thu, 13 Apr 2023 20:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1681442794;
        bh=N/lTarvnkB+0LFxZohuEdHLcN5PE+7h/ShEQ5wITcGY=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=bAG70ljFyHiPKYjjlayy845llPtgrHPKz9/Mail6QfphBfZyLdVLk9z2Xnb+ldojf
         BT3iXbPXyCX38rasKSOMzV5xdlhwtXMwx436uQPDvKjjqEYba+Tbb9U3FonmrbX32v
         1aGnoDz/lg61ZhVdlUZu4tNzvc9InxdIvd0b2mX/BfQYw/F9DGlVWxjNJmIt+/S3c2
         wZegi8IXochwoqraIJIUMDtHPz9cqF/ZLDYXJL4kPnXQ5CI+OEVuGxUHch24lCVVnB
         SrhRy2/HGmLvMCHP45j3VB5Gmgw67y8uvJ4eFb7R+5eq2sCV1rVLHc0JjNbZ5IPsBp
         MG3GQPNP+bZLQ==
Message-ID: <9e61e5ef-339e-b3d8-b3b2-884d79b31b98@stancevic.com>
Date:   Thu, 13 Apr 2023 22:26:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
Content-Language: en-US
To:     Shreyas Shah <shreyas.shah@elastics.cloud>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Cc:     "nil-migration@lists.linux.dev" <nil-migration@lists.linux.dev>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <IA1PR12MB623638228AD6EE30F336CDCDE8949@IA1PR12MB6236.namprd12.prod.outlook.com>
 <2fb46081-b9d1-47af-b2e7-a0eb68797386@stancevic.com>
 <IA1PR12MB623666337403D0D7B4B9D47DE89A9@IA1PR12MB6236.namprd12.prod.outlook.com>
 <2ae1bdc2-60bf-e6a2-722a-ad42295a4929@stancevic.com>
 <IA1PR12MB62363D430C430431DEBFD7C8E89A9@IA1PR12MB6236.namprd12.prod.outlook.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <IA1PR12MB62363D430C430431DEBFD7C8E89A9@IA1PR12MB6236.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/10/23 23:33, Shreyas Shah wrote:
> Hi Dragon,
> 
> Do you all meet on Zoom or Teams weekly call?
> 
> Maybe next time I can present if you have a slot.

Hi Shreyas-

no, sorry there is no zoom call cadence at the time.



> Regards,
> Shreyas
> -----Original Message-----
> From: Dragan Stancevic <dragan@stancevic.com>
> Sent: Monday, April 10, 2023 6:33 PM
> To: Shreyas Shah <shreyas.shah@elastics.cloud>; lsf-pc@lists.linux-foundation.org
> Cc: nil-migration@lists.linux.dev; linux-cxl@vger.kernel.org; linux-mm@kvack.org
> Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory​
> 
> Hi Shreyas-
> 
> speaking strictly for myself, sounds interesting
> 
> 
> On 4/10/23 20:17, Shreyas Shah wrote:
>> Thank you, Dragon.
>>
>> Btw, we can demonstrate the VM live migration with our FPGA based CXL memory and our demonstration today. We are not application expert, looked at the last diagram in your link and we are confident we can achieve it.
>>
>> Will there be any interest from the group? I can present for 15 mins and Q&A.
>>
>> Regards,
>> Shreyas
>>
>>
>>
>> -----Original Message-----
>> From: Dragan Stancevic <dragan@stancevic.com>
>> Sent: Monday, April 10, 2023 6:09 PM
>> To: Shreyas Shah <shreyas.shah@elastics.cloud>;
>> lsf-pc@lists.linux-foundation.org
>> Cc: nil-migration@lists.linux.dev; linux-cxl@vger.kernel.org;
>> linux-mm@kvack.org
>> Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory​
>>
>> Hi Shreyas-
>>
>> On 4/9/23 12:40, Shreyas Shah wrote:
>>> Hi Dragon,
>>>
>>> The concept is great to time share the CXL attached memory across two NUMA nodes for live migration and create a cluster of VMs to increase the compute capacity.
>>>
>>> When and where is the BoF?
>>
>> It's a proposal sent under (CFP), it has not been accepted yet. The agenda is selected by the program committee based on interest. The current proposal is for LSF/MM/BPF summit[1] running May 8 - May 10th, but it's not happening if not approved by committee.
>>
>>
>> [1]. https://events.linuxfoundation.org/lsfmm/
>>
>>
>>>
>>>
>>> Regards,
>>> Shreyas
>>>     
>>>
>>> -----Original Message-----
>>> From: Dragan Stancevic <dragan@stancevic.com>
>>> Sent: Friday, April 7, 2023 2:06 PM
>>> To: lsf-pc@lists.linux-foundation.org
>>> Cc: nil-migration@lists.linux.dev; linux-cxl@vger.kernel.org;
>>> linux-mm@kvack.org
>>> Subject: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory​
>>>
>>> Hi folks-
>>>
>>> if it's not too late for the schedule...
>>>
>>> I am starting to tackle VM live migration and hypervisor clustering over switched CXL memory[1][2], intended for cloud virtualization types of loads.
>>>
>>> I'd be interested in doing a small BoF session with some slides and get into a discussion/brainstorming with other people that deal with VM/LM cloud loads. Among other things to discuss would be page migrations over switched CXL memory, shared in-memory ABI to allow VM hand-off between hypervisors, etc...
>>>
>>> A few of us discussed some of this under the ZONE_XMEM thread, but I figured it might be better to start a separate thread.
>>>
>>> If there is interested, thank you.
>>>
>>>
>>> [1]. High-level overview available at http://nil-migration.org/ [2].
>>> Based on CXL spec 3.0
>>>
>>> --
>>> Peace can only come as a natural consequence of universal
>>> enlightenment -Dr. Nikola Tesla
>>
>> --
>> --
>> Peace can only come as a natural consequence of universal
>> enlightenment -Dr. Nikola Tesla
>>
> 
> --
> --
> Peace can only come as a natural consequence of universal enlightenment -Dr. Nikola Tesla
> 

-- 
--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

