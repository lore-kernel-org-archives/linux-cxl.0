Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87652C77B6C
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Apr 2023 18:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjDGSgD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Apr 2023 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDGSgB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Apr 2023 14:36:01 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5547093C8
        for <linux-cxl@vger.kernel.org>; Fri,  7 Apr 2023 11:36:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7A27641F03;
        Fri,  7 Apr 2023 18:35:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0052441F93;
        Fri,  7 Apr 2023 18:35:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680892559; a=rsa-sha256;
        cv=none;
        b=lF7pr9YioLZzX9vs8BDzg7Y2xDNHKp4fhtlN1nxJhQX7Y2adMHQ+w2xNmOK6GURMsv1SOo
        pfHNkr1YWx7ej0A16NDdVEv1Z7UoHbv+ndytFIciZOwYheWaZoK83VdTyhtYkQuFrcMLoQ
        8lx44yi9aColcNrz+FYXcLeqindXiDFAv2XNOsbIUUxpcItAUiKpNBd/5APPUhV8a4Aul7
        jDaX4QxfL74gc+biiX+OUrAptv2kHg8VqA13Axf/hUQxlorvx2dH+gAC9tRg3Ws3Z4RpVF
        ELtaD0NFYuWUkEw7JWnxJcIVrdHbKFQ6PKBmdos2MII6c8vH2r3OW5/T/oomTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680892559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=VInOktCAFiJTJPvhpLL+4xT0ClHqfI1TA/cQf1cNgTk=;
        b=nxWEKogdQxQY262w+FIshpeg3MH47lo4lm0/jr2S+T99apzwEDrjeFkO3NfnBnTlWyy0nf
        Wdr9U5o+o4z+6po0XneBwEyarg+MnoXQgKtTVFF0Qj86b8Na+AfmjpBEwdcUpUNU4BhIo+
        V0YRM4BmeaNdvpcMYG0cpAJmEO4NkZTXMAl93X1kM4yrI80+pekqhVIBvwiksF+VzUIkzs
        IXmmhi/0x+I5nwZo1XxYXZ8ggzfxXhqTM636JIuZ37DULofEsx2u5wCNO4VGPyLHeJyIDa
        Ft0hdT0DAlojbu8f9jQFsfl1h5e1SrjGDvYIbYvXgh6OsVUQtqyx+S6O/rYMEQ==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-7kf64;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Drop-Print: 6833f11b78cf1d95_1680892559296_4247349223
X-MC-Loop-Signature: 1680892559296:1046145912
X-MC-Ingress-Time: 1680892559295
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.127 (trex/6.7.2);
        Fri, 07 Apr 2023 18:35:59 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4PtRrt2M12zFJ;
        Fri,  7 Apr 2023 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1680892558;
        bh=VInOktCAFiJTJPvhpLL+4xT0ClHqfI1TA/cQf1cNgTk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HUXzeRCFdl2593FC3PPXwK35MTnTMYfoHsV4Aqo/7mPVZQb5yveXcQ7I89uU3b9mL
         AcLS7/gOr370u++qNDPSkbHMTmwb6Pn9ZKe6+YIjsytVmqJErZJ1g2/gDM1yXG0W6C
         CGtEDD8GBNXg2s733gDVnBmo0ot9IVTpK2uJmaJfARyVZNoEufzC9Q9KCZURBUus1P
         BJg8+XvirEoaoYORPkb4qMSf9q65gFYbkGVSlSi0n/IUl9MU5PIc2Qsqs9TXzRQCSD
         Z9Sz5ByfZmN7olY2HlrMzsxEH4oRoAeAT3a0FvWMbjFRm15zNboX0Y0B85oObVwqaX
         bUeatVzC1J2dQ==
Date:   Fri, 7 Apr 2023 11:05:12 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/mbox: Add support for background operations
Message-ID: <20230407180512.pj2lznudcidb7f7l@offworld>
References: <20230224194443.1990440-1-dave@stgolabs.net>
 <20230224194443.1990440-2-dave@stgolabs.net>
 <20230403174730.00003920@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230403174730.00003920@Huawei.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 03 Apr 2023, Jonathan Cameron wrote:

>> @@ -350,7 +350,14 @@ static CXLRetCode cmd_infostat_bg_op_sts(struct cxl_cmd *cmd,
>>
>>      bg_op_status = (void *)cmd->payload;
>>      memset(bg_op_status, 0, sizeof(*bg_op_status));
>> -    /* No support yet for background operations so status all 0 */
>> +    bg_op_status->status = ARRAY_FIELD_EX64(cxl_dstate->mbox_reg_state64,
>> +                                            CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP) << 1;
>
>Ah. I'd forgotten I bodged this one in for the switch.

General question, do you know the reasoning behind why this command is only listed
for switches (while the overall vocabulary is very generic to all bg-capable commands)?

Thanks,
Davidlohr
