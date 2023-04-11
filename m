Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B7CC77B70
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 01:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDKBcv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Apr 2023 21:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDKBcv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Apr 2023 21:32:51 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941910F7
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 18:32:46 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1002F26100B;
        Tue, 11 Apr 2023 01:32:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4BC24260FEB;
        Tue, 11 Apr 2023 01:32:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681176765; a=rsa-sha256;
        cv=none;
        b=x3cNeLq8jtn5o6k6AUJKtq2qEBLK6UiCNSSpWbyWTvcVC0uQeYSvacQ9HAnq7C/BFlT6/a
        6QIDUBaWd4ViNBEfgRpD5JQRKB1q5LMPbAmy3wM/oObGS+sU4fon+nqCZOxSoV8rv6hHEN
        kU15V7Hu/Kb6VKVeBsUpYdtLUuwyMqJSYLnb7NEVGLFUTu33c2AKQLvOpPVdbOveQWVCX+
        ZwMr5SqJU98rOO2Cy94afMOcrEnvh/lSXh+wZk4LOa45pU8M91eQvdk1GWqnevrtfX98Cw
        94jyT73NdiRGAema7cUuypSG985RK26v+DQsDqzqZQQxzZkE0my2lBpzmvSA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681176765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=H+EGe3B8EarYB0Ro9gtU1VK0ElEVwnkWog6NSfY8jsU=;
        b=brjac4LsY0oLjjyv/CuS2kW6PZPH8uLI2LlgRfVrOWv5GAYncyE20fmtDPAi83ZM6rUAEc
        +f/T25RSStamNpz9bZluATCRHSrnTFctQh8DZqKCrOY0qqsOqYDzekDGfqVxIqOUgrJ2J0
        87HHP9gs3hkbHAO8ltf/YHvFgNPGjv3LACeg5F+QqbtDmBG4dP2RA6S56TrwaCRlRKIgWP
        Sn4H9ohoy2CgKQBEla29VxNn/qKTyi043AjUTrLv/gKEofupYsWXJcVEQXEqtJchg0r+jH
        rBscYjASs8xR+4OkHS+3jwu2+fbzcrNjP7C7Ottkf/FRm7g/dN1Rsp7qNehjfA==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-96dz6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Snatch: 28e5585d70906849_1681176765741_828212993
X-MC-Loop-Signature: 1681176765741:1824893421
X-MC-Ingress-Time: 1681176765741
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.200 (trex/6.7.2);
        Tue, 11 Apr 2023 01:32:45 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4PwSyN4dZ2z54;
        Mon, 10 Apr 2023 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1681176765;
        bh=H+EGe3B8EarYB0Ro9gtU1VK0ElEVwnkWog6NSfY8jsU=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=xH/lwV4ntQv999887PMq1r7wJyPirgWn8zleGM87ezhBsEXJwurodzvyOv2v4dT4s
         dkfe/dLn1XN6jBFVZJcUNTl4no1HVf7BZrhUn572OyDIjNg9S0cD3ba8ZMyuHk01Lo
         2p3k9rmEdqW7wQdgp3/TIKCHirl5r/Y5C8QDugxXZXHakM2AMcaHeAHhSPPZz5YTau
         VPLtg+r9DhlZGF7w3B/HyQ1D6IxNd/JAcaz8YQbCxc5X1fbswlqRoHoqb0NZyT5SkW
         CL2iUs8H1d3nf4Iiwj+js9MIimc+bNnNDTAe9RY6i5aKOg1/jPhel/2C9qEddlEzVN
         j9m5JV0Z59/XQ==
Message-ID: <2ae1bdc2-60bf-e6a2-722a-ad42295a4929@stancevic.com>
Date:   Mon, 10 Apr 2023 20:32:43 -0500
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
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <IA1PR12MB623666337403D0D7B4B9D47DE89A9@IA1PR12MB6236.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Shreyas-

speaking strictly for myself, sounds interesting


On 4/10/23 20:17, Shreyas Shah wrote:
> Thank you, Dragon.
> 
> Btw, we can demonstrate the VM live migration with our FPGA based CXL memory and our demonstration today. We are not application expert, looked at the last diagram in your link and we are confident we can achieve it.
> 
> Will there be any interest from the group? I can present for 15 mins and Q&A.
> 
> Regards,
> Shreyas
> 
> 
> 
> -----Original Message-----
> From: Dragan Stancevic <dragan@stancevic.com>
> Sent: Monday, April 10, 2023 6:09 PM
> To: Shreyas Shah <shreyas.shah@elastics.cloud>; lsf-pc@lists.linux-foundation.org
> Cc: nil-migration@lists.linux.dev; linux-cxl@vger.kernel.org; linux-mm@kvack.org
> Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory​
> 
> Hi Shreyas-
> 
> On 4/9/23 12:40, Shreyas Shah wrote:
>> Hi Dragon,
>>
>> The concept is great to time share the CXL attached memory across two NUMA nodes for live migration and create a cluster of VMs to increase the compute capacity.
>>
>> When and where is the BoF?
> 
> It's a proposal sent under (CFP), it has not been accepted yet. The agenda is selected by the program committee based on interest. The current proposal is for LSF/MM/BPF summit[1] running May 8 - May 10th, but it's not happening if not approved by committee.
> 
> 
> [1]. https://events.linuxfoundation.org/lsfmm/
> 
> 
>>
>>
>> Regards,
>> Shreyas
>>    
>>
>> -----Original Message-----
>> From: Dragan Stancevic <dragan@stancevic.com>
>> Sent: Friday, April 7, 2023 2:06 PM
>> To: lsf-pc@lists.linux-foundation.org
>> Cc: nil-migration@lists.linux.dev; linux-cxl@vger.kernel.org;
>> linux-mm@kvack.org
>> Subject: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory​
>>
>> Hi folks-
>>
>> if it's not too late for the schedule...
>>
>> I am starting to tackle VM live migration and hypervisor clustering over switched CXL memory[1][2], intended for cloud virtualization types of loads.
>>
>> I'd be interested in doing a small BoF session with some slides and get into a discussion/brainstorming with other people that deal with VM/LM cloud loads. Among other things to discuss would be page migrations over switched CXL memory, shared in-memory ABI to allow VM hand-off between hypervisors, etc...
>>
>> A few of us discussed some of this under the ZONE_XMEM thread, but I figured it might be better to start a separate thread.
>>
>> If there is interested, thank you.
>>
>>
>> [1]. High-level overview available at http://nil-migration.org/ [2].
>> Based on CXL spec 3.0
>>
>> --
>> Peace can only come as a natural consequence of universal
>> enlightenment -Dr. Nikola Tesla
> 
> --
> --
> Peace can only come as a natural consequence of universal enlightenment -Dr. Nikola Tesla
> 

-- 
--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

