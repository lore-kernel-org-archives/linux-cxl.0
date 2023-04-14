Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570A8C77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 03:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDNDeG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Apr 2023 23:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDNDdg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Apr 2023 23:33:36 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 20:33:31 PDT
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763D448B
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 20:33:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id ECEF4541D0F;
        Fri, 14 Apr 2023 03:33:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6DC375419D3;
        Fri, 14 Apr 2023 03:33:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681443206; a=rsa-sha256;
        cv=none;
        b=ZGlsTIKsDSEnWtNiMCkYDWt5DD0mVP/iNV8SdU3KyRknBI/1oMcGB69H+F+H+dWWkhwH51
        H1dns40vajKz2WjLeEtkTDsSDPM5/K9IAAdD/MVpI5Yzr+i0cwMTozXpfTNOGmQ3m956DQ
        WJH/aIR+OI6FiruQ8RN/dlmGiKpv3xajLxCWtsz5uvtsVDbcjxN8izYwgq2QzcBbmDG82P
        SYRvVJr50wAdlMjQ7Q4f7CFhQGyOaHjceLvPaSrbJNJc0a5rlHBccb7A2YekGbTgYiIFME
        SqfriZwvw06MOOqFG9+a3/BP26HtbtLwGnWnDP43I2ek8oYXMS21RwUkNU3kEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681443206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=7JtTfcQBMAcxQrCiZjcisUJbs5xxsDDTkmB8dGemUsw=;
        b=WSjvN4lhvkyyVU0Ysfz5+cBzBmGQhM9lBhTamPn1MauaX68HogrS4aIo6/ej2t1WX30z7F
        5witx8Xj6w8oyPWKdir9+1Nwbc2bBfBcnykYSeJ4kohy76U2JCyq6fZ0t8R7DFm1PHuE1r
        WrOdv7Of+lo/qZalpjG3/zVxl102NWvCQPngyeRsu86Mn6hdsWbrQFOyNBMT5ABObtrak4
        0GUlMxPf8VTG5DS8I5HLGEAlyqZ+9CXyTHbMLsQKA69tYYLBym9FN2ulCUgP2K3gyJXCCm
        NMRBa/+HiliEHh6mux0tvWk6JNwMMZpSNZYvHSTjSfmgaIhphhO9iGpqMLXetw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-gmsjp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Callous: 34f136452915a007_1681443206743_857392299
X-MC-Loop-Signature: 1681443206743:3335622857
X-MC-Ingress-Time: 1681443206743
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.224 (trex/6.7.2);
        Fri, 14 Apr 2023 03:33:26 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4PyMVF4lZ8z29;
        Thu, 13 Apr 2023 20:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1681443206;
        bh=7JtTfcQBMAcxQrCiZjcisUJbs5xxsDDTkmB8dGemUsw=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=c7DNT7Mc/UBLtUooDiAclmeyBFqiq8N31rRNv5vjdI5TBuKk/DbRt+lbIk5oJnjIW
         EM9A/9pQ1ExlnVMOv98jv47Uw1okRMdWt58CB52thrvciE/nCcaAY5QOsa3sGJiLvK
         7T1jEAKqsOKBx2d7ik8pbVDdWwP0m9jQiWKis45kL5mfunAud6+lnNts1DZjU8PmXU
         l0bgIZBw5UC05sXREjAk9c40eXmI9BLA+FVciVJnj+pWAEchMzKQeuO6punyri9o5X
         I+DLErtG2nINVN0E4t7d+KwnQYWqP64WxKOgh+l8mgfKqAG59A/gKxb3sNg93WtBa6
         +SIwvvTYUWspg==
Message-ID: <4a1e74f5-284f-7bfe-6a79-42b44909ca23@stancevic.com>
Date:   Thu, 13 Apr 2023 22:33:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Gregory Price <gregory.price@memverge.com>
Cc:     lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/11/23 01:37, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> [snip]
> 
>> 2. During the migration process, the memory needs to be forced not to be
>>     migrated to another node by other means (tiering software, swap,
>>     etc).  The obvious way of doing this would be to migrate and
>>     temporarily pin the page... but going back to problem #1 we see that
>>     ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>>     troublesome.
> 
> Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
> avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
> but I think it is fixable.


Hmmm, I don't know about cpusets. For mbind, are you thinking something 
along the lines of MPOL_MF_MOVE_ALL? I guess it does have that 
deterministic placement, but this would have to be called from the 
process itself. Unlike migrate_pages which takes a pid.

Same for set_mempolicy, right?

I mean I guess, if some of this needs to be added into qemu it's not the 
end of the word...


> Best Regards,
> Huang, Ying
> 
> [snip]
> 

-- 
--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

