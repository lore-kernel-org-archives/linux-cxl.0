Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E5C7EE22
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 15:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbjEKPsH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbjEKPrr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 11:47:47 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941B7A84
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 08:47:21 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EE378262123;
        Thu, 11 May 2023 15:46:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a268.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 625AD261C80;
        Thu, 11 May 2023 15:46:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683819969; a=rsa-sha256;
        cv=none;
        b=OWpdNoLDH7l4otlm76m7mS2FVWjGBd+J7FwzR1gSoESIJJWlVP3/8ywW61qch+aNlUtilo
        NJB0c3lVd1n4YjsW4x6aq2lvRcOvjI21Zftm46e8iEDVJHA2ExInzpdSXcrzrBN+Pv5BGP
        BYTEKJVR4fCioKAtC5XNOYcrh++MHpO3PJgvxWLlJhtNl9rp5JeauUHgNx0ffnZsr60mu9
        GdyjOYoOm+Plrffez91Jts2eNz0U4p5bxZXX2wfntUxIBr/zv1qXEQ7eAMOZbYbtQD8J0c
        KMQc9Pl+tRtUFRowPjC00dRZwZ6/wGoilt8xx/3bAC5zHBcmMmZwHPxyysfVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683819969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=7nXbzv+XQKbqikGxcKn+BKiI///5OxjQ7+nHDcVAfvA=;
        b=5TyaYejThWG7eWgPyuZvumtjDCVG5vieP4qshgS+SjVyjL2shQzZwjjx85Yaptf7ikjetP
        YjyXVOwNaWcSyhRzJlwWA9H4aPkA5GYdFlmYGBHE2LmukYXq1mb0TzK0scQ6ufhX2eSfmq
        q4DDUOzJVBXDpCY5Sa0LaHirhNmkGs7PgOt7PO/zI6TwVmy58BsQrWyQvnMItfhVwHi6Zm
        2eKXdJBUj9NzstgqBHvJpeFg4hqI/9IKG7vRTU0ujhZf6oJQPWkFuNfgsSnxhlvFzdxuM8
        Zz+nVyTLvgdIkqJ2CcH0L0NZfrT7O0kMUSo22OqQOLaxltvs7kLHcxT6U2uDMg==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-zsblk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Lonely: 2e170f7b14768123_1683819969729_646337279
X-MC-Loop-Signature: 1683819969729:1334507724
X-MC-Ingress-Time: 1683819969729
Received: from pdx1-sub0-mail-a268.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.202 (trex/6.8.1);
        Thu, 11 May 2023 15:46:09 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a268.dreamhost.com (Postfix) with ESMTPSA id 4QHGTD4y2Qz5h;
        Thu, 11 May 2023 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683819969;
        bh=7nXbzv+XQKbqikGxcKn+BKiI///5OxjQ7+nHDcVAfvA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=OfZ5G8fx6U1wrvyZtSNCUr5cWxzskBSpbHr73qqPGmkva94rRu/voSDtxJZ68fUGi
         qRzMm3xOHBsh3cE0AXOkg8Q/6cCRXDJGyWngIKziymK11erVMG1jMrmur1sCZhvaI/
         R+1VRHRcEcmLcEuWrruRUvSXm1IwwlnQ3sbpky81xRipgl3n1U2x+WF2xAaPv7d5Il
         tJ61tX9UtkLQWYTi6l6EjGLg+R5kYNEtoEPY+LPfC9oyzrHdWRU+p3jWCSUmuwnFwj
         vpXGU3MdaktKNnS9MYALRPhXX9LUPThs6+IEe4VLX8xxhOCEfwDClEn8OBuFIvTnWP
         sSH1YEOiqqs4A==
Date:   Thu, 11 May 2023 08:13:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 5/7] cxl/test: Add Sanitize opcode support
Message-ID: <heuhlhxlhevs5iv47roqwzwiaz6ibzajocjvyeeiprs33nwtci@2hz2cxcjj6ly>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-6-dave@stgolabs.net>
 <20230511160913.00005937@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230511160913.00005937@Huawei.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023, Jonathan Cameron wrote:

>On Fri, 21 Apr 2023 02:23:19 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Add support to emulate the "Sanitize" operation, without
>> incurring in the background.
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  tools/testing/cxl/test/mem.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
>> index 9263b04d35f7..d4466cb27947 100644
>> --- a/tools/testing/cxl/test/mem.c
>> +++ b/tools/testing/cxl/test/mem.c
>> @@ -497,6 +497,28 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
>>	return 0;
>>  }
>>
>> +static int mock_sanitize(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>> +{
>> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
>> +
>> +	if (cmd->size_in != 0)
>> +		return -EINVAL;
>> +
>> +	if (cmd->size_out != 0)
>> +		return -EINVAL;
>> +
>> +	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
>> +		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
>> +		return -ENXIO;
>> +	}
>> +	if (mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED) {
>> +		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
>> +		return -ENXIO;
>> +	}
>> +
>> +	return 0; /* assume less than 2 secs, no bg */
>
>Boring ;)

Yes, but I made up for it in qemu :)

Thanks,
Davidlohr
