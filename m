Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BFCC77B7D
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 17:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbjEORQF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 13:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbjEORPh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 13:15:37 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA38DD89
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 10:14:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 99C7641EFB;
        Mon, 15 May 2023 17:14:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a297.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 248C2426CB;
        Mon, 15 May 2023 17:14:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684170868; a=rsa-sha256;
        cv=none;
        b=oi+Z7DlyteLqtWaw5iKmH+F7BuqL1Ibvdqg9CHcAYPlXn0V+UBmgXa05OStLL5e/l8Bcgf
        9Lk+5j6bhP3Y/g6SDiEoD/8z0op/TiGVZkiwZebNJd9O7DQZqAWB0ICHCkEjk+OJE1UmDg
        h4wq7NpOI1qNZ/uYjqSmu5t3SXRG/s5Xx/Mhsyo4o8Z707YgMbEScStn3aNJv8BTjmv1RM
        56qzWrbJX8mhP9gVWYRokMKUyRIlI9NIjcn8ueAaslom+B5QNYExTil+CG5wLeFyHb7cUL
        k+4CMntg6QA93EMsawPS+i/d9uXAcVVKw3x8HVGx8GNtUKc/yYOpyGJWdfgv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684170868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=hBAkmNIyKzB7dRbOOdDPQfaV4g6BD4HFl0BRVkZBGiE=;
        b=GmA5s5ELgtOltDOY0pPlHtdWFj3OhQfhLe66SY50wxNY+tJp+khR5LMSy0x8qqh/zObPQz
        01lMoWvIEorfEsDe3dq4srO6FaJoN2bCc3py9XcaRwUc8N5xWtU2vKv/R5IZBOe4NGCS7l
        T3fzaDUYMXXQYutPiisC7/YFc4VxAW1qCs3BevFIHyTQOwXP3PwOpdMMFa7GK1m7zb8EfV
        fQ3qr/z1grz3W6Xw2AtwBC1nzxUN0hZhG0eIsT4x8TX3oGYzZe3qhB6exi1oH1fLlevRjC
        BRkJ6BSqCtelglMAFx9dtNEJt5H/8qqtgPEYNx9IsqdvEu5Ma5OSN5mXTYJZ4w==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-n4r5z;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Obese: 769880d05fb354d8_1684170868433_2453398409
X-MC-Loop-Signature: 1684170868433:3108910913
X-MC-Ingress-Time: 1684170868433
Received: from pdx1-sub0-mail-a297.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.217 (trex/6.8.1);
        Mon, 15 May 2023 17:14:28 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a297.dreamhost.com (Postfix) with ESMTPSA id 4QKmFH4K4cz76;
        Mon, 15 May 2023 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684170867;
        bh=hBAkmNIyKzB7dRbOOdDPQfaV4g6BD4HFl0BRVkZBGiE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=O+FPAYjUJtESN4bZInpybiFtPOFREgVpqRXtbEC7HDrnc2o4mxSolT8QBYnPk4teI
         ILPmx5Mtbo/IdsIDE38C7nGnSY33itg4RnflVujVBOf3ek95PPshGfZByqzkxtdMg/
         hBUjvypqLZZUt5AxvJ2hr/ywHcI0tH2Z16d0H0gP6T6Ragys8ugNrMT1J6IoBM2OZ/
         SmQK4vh/c7VQAti0NyMCapgS0UJ5fG1vFJEMwiS5V7IYauKTPf5KD214CbK+VyoXDF
         hIGSaVFVK10TYE4tu1bG66o4v6Zt4j5bnWaDkeAYqZBSO7ZgIipiUrQT3J/Elzu2Jl
         mVfpm2tn4mPWw==
Date:   Mon, 15 May 2023 09:41:29 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave.jiang@intel.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/5] cxl/device: Handle Media Disabled state
Message-ID: <6ydxwjc6dy4pbxblikfglab7txhul5fn3pvcosuwi2ys3j5gfs@y4vp2pfwnswg>
References: <20230418172337.19207-1-dave@stgolabs.net>
 <20230418172337.19207-4-dave@stgolabs.net>
 <20230515133936.00007bce@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230515133936.00007bce@Huawei.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 15 May 2023, Jonathan Cameron wrote:

>On Tue, 18 Apr 2023 10:23:35 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Ensure that both memory device read/writes and mailbox commands
>> can deal with the device media being disabled - per CXL 3.0 specs
>> 8.2.9.8.5.1 - Sanitize. Disabled semantics here are strictly 11b,
>> however noting that if the media is not in the ready state (01b),
>> user data is not accessible.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 15 +++++++++++++++
>>  hw/mem/cxl_type3.c          | 10 ++++++++++
>>  include/hw/cxl/cxl_device.h | 33 +++++++++++++++++++++++++++++++++
>>  3 files changed, 58 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 224bfdb4bfca..e0e20bc3a2bb 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -891,6 +891,21 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>>          if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
>>              cxl_cmd->payload = cxl_dstate->mbox_reg_state +
>>                  A_CXL_DEV_CMD_PAYLOAD;
>> +
>> +            if (cxl_dev_media_disabled(cxl_dstate)) {
>> +                if (h == cmd_events_get_records ||
>> +                    h == cmd_logs_get_log ||
>> +                    h == cmd_ccls_get_partition_info ||
>> +                    h == cmd_ccls_get_lsa ||
>> +                    h == cmd_ccls_set_lsa ||
>> +                    h == cmd_media_get_poison_list ||
>> +                    h == cmd_media_inject_poison ||
>> +                    h == cmd_media_clear_poison) {
>> +                        ret = CXL_MBOX_MEDIA_DISABLED;
>> +                        goto done;
>> +                }
>> +            }
>> +
>>              /* Only one bg command at a time */
>>              if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
>>                  cxl_dstate->bg.runtime > 0) {
>> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>> index 801f72c5fcae..707bdc263f03 100644
>> --- a/hw/mem/cxl_type3.c
>> +++ b/hw/mem/cxl_type3.c
>> @@ -12,6 +12,7 @@
>>  #include "qemu/pmem.h"
>>  #include "qemu/range.h"
>>  #include "qemu/rcu.h"
>> +#include "qemu/guest-random.h"
>>  #include "sysemu/hostmem.h"
>>  #include "sysemu/numa.h"
>>  #include "hw/cxl/cxl.h"
>> @@ -989,6 +990,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>>      if (res) {
>>          return MEMTX_ERROR;
>>      }
>> +    /* all memory reads will return random values */
>
>Reference for this would be good.  Random is expensive if we can get
>away with a constant value.

Oh I threw out any performance expectations for qemu out the window, otherwise
I'd cry. Unless it's problem (this is media disabled, so bleh), I would
prefer keeping it as is.

>> +    if (cxl_dev_media_disabled(&CXL_TYPE3(d)->cxl_dstate)) {
>> +        qemu_guest_getrandom_nofail(data, size);
>> +        return MEMTX_OK;
>> +    }
>>
>>      return address_space_read(as, dpa_offset, attrs, data, size);
>>  }
>> @@ -1005,6 +1011,10 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>>      if (res) {
>>          return MEMTX_ERROR;
>>      }
>> +    /* memory writes to the device will have no effect */
>> +    if (cxl_dev_media_disabled(&CXL_TYPE3(d)->cxl_dstate)) {
>> +        return MEMTX_OK;
>> +    }
>>
>>      return address_space_write(as, dpa_offset, attrs, &data, size);
>>  }
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index f986651b6ead..3ef7a7cded95 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -346,6 +346,39 @@ REG64(CXL_MEM_DEV_STS, 0)
>>      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>>      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
>>
>> +static inline void cxl_dev_media_toggle(CXLDeviceState *cxl_dstate, int val)
>> +{
>> +    uint64_t reg;
>> +
>> +    reg = ldq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS);
>> +    if (FIELD_EX64(reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == val) {
>> +        return;
>> +    }
>> +
>> +    reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
>> +    reg = FIELD_DP64(reg, CXL_MEM_DEV_STS, MBOX_READY, 0x1);
>> +
>> +    stq_le_p(&cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS, reg);
>
>Why & ?

braino

Thanks,
Davidlohr
