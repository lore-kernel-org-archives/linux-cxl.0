Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D0C77B70
	for <linux-cxl@archiver.kernel.org>; Sun, 16 Apr 2023 03:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjDPDDf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDPDDd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 15 Apr 2023 23:03:33 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF680270D
        for <linux-cxl@vger.kernel.org>; Sat, 15 Apr 2023 20:03:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 97A0F541892;
        Sun, 16 Apr 2023 03:03:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0922C5418A2;
        Sun, 16 Apr 2023 03:03:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681614209; a=rsa-sha256;
        cv=none;
        b=fY9345yIaAs42igKeUHEky8bKI/VcEdBD/EnwOqdP/Ky9m/2dceIah1oGmUTMqHpmdedCh
        8S7wfLB2aSKAtvrHDaR3G2v/n8vf2SGrqaVpbBpVzZu5yhj29z881hy1b5L9M3TP1dPB9u
        eUkGV0sTKSrCt7yIUYaNAxa+tmK0l30a0+ZzzPdY8+68/UfTsEVURoHDgje+YNDnDcJhUk
        im1jr8MrV2mwO+1z/9pu/cN7kA0BikvJCWDZuKJH29tcy2JSED0qwQk1rk8PshbB/6AwHr
        r4OC/YMNL4YWzSIY+uyuPbcveHqAVi1Qzof5V5adjZXZGJRAEdAx+NI4fWQSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681614209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=QXujTubmzZRP+Z92UDXqJSdu6nskPcz82beetFOuEP8=;
        b=mOpImbx2u5Bi4CSzUVwwPLFRg5aQ9YtHdYIixv11ZaQThxK9zEYnicmuKTloyzDc/g68Ri
        nqaCQFVvQHMWxPenF1NVtxjtvJfs7SyqUOmDwmpi2Xva3LmyTINabUZm9Wuajv3c6R1rGp
        21o/9ZYVhukSA5bH+D3X8yxTSTSY8fA3IKmhuUlLQs02r0yr2VOXdz3YO/vWQoZXqR1hSO
        PBq2Obcitev3iyTE5/F01e5sJpb9D8l7F+7W0Q3VPxvODvJpy6LjKHuqT+kKPtil9Me3nA
        Br8djuDV9SgBwK4LaMLTeJQkQspQ4rmE0pCuBmJ6RIXiNrRBRjaE99edw9zXVQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-n65jn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Slimy: 2fc7e2890125b6a2_1681614209347_2457400657
X-MC-Loop-Signature: 1681614209347:1155918152
X-MC-Ingress-Time: 1681614209346
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.57 (trex/6.7.2);
        Sun, 16 Apr 2023 03:03:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4PzZkm2L5Nz58;
        Sat, 15 Apr 2023 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681614208;
        bh=0SobpOMjhwB2ofZXh70G6E6d5SUGFYtZHQ5Sr7KGhHY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ckXA3wefXWRju55pC4j9tx6aIfr422e3rmpI1ewb0/DPk3nMSI14oKXuk9ipmvYzE
         /0LC2ORzm/m1YoewzlFjvvr2pI55eBJYuCw5KzxaH/yDvFybFN05OCWKL52k/7ed14
         52OHCUi4wGNYIyi96yY9tl6OKH1/AGlvK6S7sWZTkKYsB69sLLFLEiAOn23EuHqW8k
         DXt7Sm9/Q8nHMyC2HPo2Mkt1/G8ibAI1hBDgHFlkVFOh4KAUbqUmnZ5P0jxzuk3D8M
         CjQjhijnCdw/2OLz3ERPyBfJCWs59DsJvI5uV9vE1r+r0ijt5t1Azd2hOqVet2ZokG
         SdI0d9SvHPFQQ==
Date:   Sat, 15 Apr 2023 19:32:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl: Add support for device sanitation
Message-ID: <lg3ujhymf2h5jbkimgmdc4iz6qwnguanbvlc7cb2tak6zb6xhm@mrs6soct6i2r>
References: <20230224194443.1990440-1-dave@stgolabs.net>
 <20230224194443.1990440-4-dave@stgolabs.net>
 <20230414151534.00004c71@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230414151534.00004c71@Huawei.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 14 Apr 2023, Jonathan Cameron wrote:

>On Fri, 24 Feb 2023 11:44:43 -0800
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Make use of the background operations through the sanitize
>> command, per CXL 3.0 specs. Traditionally run times can be
>> rather long, depending on the size of the media.
>>
>> Estimate times based on:
>>	 https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>Various comments inline.  I haven't tested this yet so one
>or two are educated guesses.

Thanks for having a look at the series and all the feedback.

...

>> @@ -988,6 +989,10 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>>          return MEMTX_ERROR;
>>      }
>>
>> +    if (sanitize_running(&CXL_TYPE3(d)->cxl_dstate)) {
>> +        qemu_guest_getrandom_nofail(data, size);
>> +        return MEMTX_OK;
>> +    }
>
>Key here is that you are in media disable status.  I'd prefer checking
>that to whether sanitize is running. There may be other routes to disabling
>it in future.  Also makes me look at right bit of spec for what should be returned.

Yeah I agree, checking the media status seems more appropriate, but because
this media disabled behavior is described specifically under the Sanitation
section (more below), and the fact that no other cmd disables the media,
I went with sanitize check. Of course, I would be surprised if the read/write
semantics would ever vary if anything else also required it, so we could
generalize instead.


>Speaking of which, where does the spec say what should be returned on
>reads to disabled media?  Reference here (or a comment to say it's
>not explicitly stated if it isn't) would be good.

I found it in CXL 3.0 spec page 556:

"In this state, the Media Status field in the Memory Device Status
register will indicate 11b (Disabled), all memory writes to the device
will have no effect, and all memory reads will return random values"

fyi I ended up adding a new patch for media disable management.

Thanks,
Davidlohr
