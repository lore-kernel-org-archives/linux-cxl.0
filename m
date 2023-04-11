Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF379C76196
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 01:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDKBIr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Apr 2023 21:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjDKBIq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Apr 2023 21:08:46 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935C1A7
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 18:08:44 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 229E064193E;
        Tue, 11 Apr 2023 01:08:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AA3F064192D;
        Tue, 11 Apr 2023 01:08:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681175322; a=rsa-sha256;
        cv=none;
        b=VNHE2dEQnWcwC140C0VVSB57MhBbDqwixUzK8Wz9jv9mYLGsjTD5FzxooeVbq19IQAjtDV
        8xS0n5pH3wuz+gTO7/K28fcPr9xmEzl8c/XVUygx8ck0vP5bayuFY68K+YyVGuFBHono+0
        x90vOWBR+T7TFAu4Cnsmi7W/BF21kBSfyEoZCcAqgKO/txZpVRMcKjEqwkrhG7Tvp1ZN/z
        KzF3zZEkT2UzUWPkCAbWyJhvv0tRFteUbRlEuqhzLinXT/0qkVma4oeLa4jGo/MDAj+7qy
        VGNCb7Pri+jEEv77WTcXU4W7rjBdEfyluW84/zn0JR/wsNmOf4CgrGCNqf/lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681175322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=0Fw1B4D/BbvYDWg6xOFzwMOjAjs3bO3FcSRLomGS5Zc=;
        b=VE3lVRMsJeN8Y6C6sevvGteGUjTZe8xfDZ7cs81VcIf0lc+3z351/7k9Wjzh52vcqvbX/c
        VG48RMf+7DkaEJHe1CT+OO7nDvuGjmflDH8XREfqoMeZ8g5LdByeR+P/DaN5eL8a9Pt/am
        LL4xkOfEk7ITN6c3sq9yT+tqzLBgKYq1IyaIKatGoeuXKD340sOssOl47LRQ3iOGBrAhMo
        Z8q12kjuCWOcWDtrGEKQsMoh1/pfftXp+7x6jhi9sfwyNAht/KFFuwNq1TO5ieSGWimkvP
        x/EnegQrYAnjB7h9V2Ov/9qVxdjUGd8VnOHRkB34v+IecB2Q9LTuNYk74uIVkQ==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-prz7s;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Cure-Reaction: 496267f7032060f5_1681175323892_137246472
X-MC-Loop-Signature: 1681175323892:3195370664
X-MC-Ingress-Time: 1681175323892
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.43 (trex/6.7.2);
        Tue, 11 Apr 2023 01:08:43 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4PwSQd70wYzBD;
        Mon, 10 Apr 2023 18:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1681175322;
        bh=0Fw1B4D/BbvYDWg6xOFzwMOjAjs3bO3FcSRLomGS5Zc=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=H7gDW/6lk4Lr1aPKrzYAY95rPvlBHBzDY81DFUZ0AC8k+5h4HIjziDxSo3/9Otfqa
         HC1YfCSNQfxjTQtENouC67a8flS0DqczefkMKb3vX9vU+7rHSJlKzg/mq4bgVcsEVx
         e7iIPlXcdZaoD4l40Tuq0WwcNK9n+Zfa/284WWoI2zJSHxJ4fcq558hs6hUSuWXEgQ
         Pg9+0xj5orjZNFkbIQCApfOyV7n0DJLEAUYU0pEc1kYrbIF5FhCKMmVmxjJqd/3/lC
         ZsiBt4KPTwAzCZHXCFFuXPn5Lxh0r/yuntvEEY6BU8GY82Fsm6qzMewVMuLw01UDoj
         hH0rsQKfQ0QcA==
Message-ID: <2fb46081-b9d1-47af-b2e7-a0eb68797386@stancevic.com>
Date:   Mon, 10 Apr 2023 20:08:41 -0500
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
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <IA1PR12MB623638228AD6EE30F336CDCDE8949@IA1PR12MB6236.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Shreyas-

On 4/9/23 12:40, Shreyas Shah wrote:
> Hi Dragon,
> 
> The concept is great to time share the CXL attached memory across two NUMA nodes for live migration and create a cluster of VMs to increase the compute capacity.
> 
> When and where is the BoF?

It's a proposal sent under (CFP), it has not been accepted yet. The 
agenda is selected by the program committee based on interest. The 
current proposal is for LSF/MM/BPF summit[1] running May 8 - May 10th, 
but it's not happening if not approved by committee.


[1]. https://events.linuxfoundation.org/lsfmm/


> 
> 
> Regards,
> Shreyas
>   
> 
> -----Original Message-----
> From: Dragan Stancevic <dragan@stancevic.com>
> Sent: Friday, April 7, 2023 2:06 PM
> To: lsf-pc@lists.linux-foundation.org
> Cc: nil-migration@lists.linux.dev; linux-cxl@vger.kernel.org; linux-mm@kvack.org
> Subject: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory​
> 
> Hi folks-
> 
> if it's not too late for the schedule...
> 
> I am starting to tackle VM live migration and hypervisor clustering over switched CXL memory[1][2], intended for cloud virtualization types of loads.
> 
> I'd be interested in doing a small BoF session with some slides and get into a discussion/brainstorming with other people that deal with VM/LM cloud loads. Among other things to discuss would be page migrations over switched CXL memory, shared in-memory ABI to allow VM hand-off between hypervisors, etc...
> 
> A few of us discussed some of this under the ZONE_XMEM thread, but I figured it might be better to start a separate thread.
> 
> If there is interested, thank you.
> 
> 
> [1]. High-level overview available at http://nil-migration.org/ [2]. Based on CXL spec 3.0
> 
> --
> Peace can only come as a natural consequence of universal enlightenment -Dr. Nikola Tesla

-- 
--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

