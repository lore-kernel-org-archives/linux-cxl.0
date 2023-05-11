Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1774CC77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbjEKR6J (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjEKR5t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 13:57:49 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5CFD048
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 10:57:21 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 60FDF5C1064;
        Thu, 11 May 2023 17:56:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a268.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D0FE45C110A;
        Thu, 11 May 2023 17:56:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683827776; a=rsa-sha256;
        cv=none;
        b=XBOWtXUJPAGZvxxRgv9tGwhllUfbUbVZJIOAOqldU70g7z+QvKCZKNaUmT0SlRj27yTea2
        jrF3vXt7wB6p+CT1h+JRuZybHUciDdOvun4IrpzUIQZ3t51j5/p/wlPcnvIFhqotKr2bht
        uF6ZCrRRJSYTb9812LD4Cg/oVNGvG+xWeRDWjrfMHvwOiS8QPeSESKRp4MJLSxNpDNqH9X
        7Dmgtm5XIyHbdQeOE9p9VGmrtEB9nnuP375R4wyXQF8sXAHZdLwgFTScg8farEhEh3EMnR
        bl6zzOIqPfxrmwp7bGCTMvB18SDs0E37M4M13a6m418n6Sj50E6Tw1r+DGiV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683827776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LucIdtj9Dpjy6EY8swbA5Lo+XBebD8CDds9qILuoSDc=;
        b=d1F8VEpg30Dd9BcxkDVSyZc/+trSNHnQ5OKBdICAycFKgg4ElNf23F5kOop6ceZdCAlyQr
        z+8VyQDNGdel8jsydp4RcMJ8rQ+1gf876jsFhnBFvyiM6tGA1PvVlMaWkgLahPjjiuiM2Y
        Ngm1WE6eS2OF4RU5zLlO0LQ/QEZjFC14cIe5JANYOa5TC+1TUnAm3T/6KsRQY+Rr8W1OKD
        jHtItOwtVJfuTKN6Ct0/Lqnre09pi+qhgh6RasHB/YLTWAzBeNEu5OmzT6/k++BLx55k5g
        t7SJ6zDe27POu9JKYWQnlwiauvWIjyG0OV52AhF9CvU6Bzw/OEAeKZwoscXJCw==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-qfmcz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Wipe: 08050dc3233e1d37_1683827777157_4116574945
X-MC-Loop-Signature: 1683827777157:545323579
X-MC-Ingress-Time: 1683827777156
Received: from pdx1-sub0-mail-a268.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.48 (trex/6.8.1);
        Thu, 11 May 2023 17:56:17 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a268.dreamhost.com (Postfix) with ESMTPSA id 4QHKMN0gGbz5h;
        Thu, 11 May 2023 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683827776;
        bh=LucIdtj9Dpjy6EY8swbA5Lo+XBebD8CDds9qILuoSDc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XwnEcclvbFm3qdkBKdj/yqqIO1x+8V37WzN2J9fmEmHnbmue1BC7gyNyY6Zp7b+3Y
         Jzqa8lR6POZKMo4hWh+8/oMO6zBSFsUD/PuV6FAFVjlAnCMRYWkrNG21OIXWhp/wXV
         T3/W67JQynYheh7ufQJsFlqDX9H/Vl9kraePKyWP2r2RDBgUQa9xGLb+ZapCJWzuJV
         CASFErtGTCoQh6B/ObGILQmNmpR06+/6stPNybXjL7BBGH0Dpd3FYf1QOSKPiwkcn/
         fAFYgnKN0ihVuowN0/XgSEvCkEwIl8PeZ0IR2iTatCrcI5tWRo++eGhLW++rs0FnWi
         KjxgRA+9D70/g==
Date:   Thu, 11 May 2023 10:23:31 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/7] cxl/mem: Wire up Sanitation support
Message-ID: <qnulxxlnw224b4sjdmdv2vqe4weal4ljes2bgtq3e7ksjdez5x@3gyjww5z66w7>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-5-dave@stgolabs.net>
 <20230511160741.00004531@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230511160741.00004531@Huawei.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023, Jonathan Cameron wrote:

>> +What:           /sys/bus/cxl/devices/memX/security/sanitize
>> +Date:           May, 2023
>> +KernelVersion:  v6.5
>> +Contact:        linux-cxl@vger.kernel.org
>> +Description:
>> +		(RW) Write a boolean 'true' string value to this attribute to
>> +		sanitize the device to securely re-purpose or decommission it.
>> +		This is done by ensuring that all user data and meta-data,
>> +		whether it resides in persistent capacity, volatile capacity,
>> +		or the LSA, is made permanently unavailable by whatever means
>> +		is appropriate for the media type. This functionality requires
>> +		the device to be not be actively decoding any HPA ranges.
>> +
>> +		Reading this file shows either "disabled" when not running, or
>> +		"sanitize" during the duration of the sanitize operation. This
>> +		sysfs entry is select/poll capable from userspace to notify upon
>> +		completion.
>
>A sysfs attribute that reads different from what is written is not very intuitive.
>The one file one thing rule suggests to me that you should have a separate
>santize_status or similar.  Or just have this read true when in progress making
>it a self resetting toggle that returns -EBUSY if anyone tries to unset it.

So the plan is to also to have the (cached) pmem security status (read-only):
     /sys/bus/cxl/devices/memX/security/status

sanitize could nicely be incorporated there and just read/poll that file for all
things security. So security/sanitize file goes to being write-only, just like
its secure erase counter part.

>> +
>> +
>>  What:		/sys/bus/cxl/devices/*/devtype
>>  Date:		June, 2021
>>  KernelVersion:	v5.14
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index cde7270c6037..28daf7dcdec4 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1021,6 +1021,62 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>>
>> +/**
>> + * cxl_mem_sanitize() - Send a sanitation command to the device.
>> + * @cxlds: The device data for the operation
>> + * @cmd: The specific sanitation command opcode
>> + *
>> + * Return: 0 if the command was executed successfully, regardless of
>> + * whether or not the actual security operation is done in the background,
>> + * such as for the Sanitize case.
>> + * Error return values can be the result of the mailbox command, -EINVAL
>> + * when security requirements are not met or invalid contexts, or -EBUSY
>> + * if the device is not offline.
>
>What does offline mean for the device?  Perhaps a tighter definition needed.

I can expand. But overall, with Alison's poison work being picked up, now we
can add a cxl_memdev_active() helper to ensure no regions are mapped to this
memdev.

Thanks,
Davidlohr
