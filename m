Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B9CC77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 17:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbjEKRVb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 13:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbjEKRV3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 13:21:29 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9E58A72
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 10:21:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 23F003C345E;
        Thu, 11 May 2023 17:21:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a268.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A1D403C33B4;
        Thu, 11 May 2023 17:21:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683825685; a=rsa-sha256;
        cv=none;
        b=d/7oTVRrwfE/EAQ7/ZrkbLhQWYausM3d581S3vLsXXv2eLNTfe7aJXPUeU5OmA7X4HnYmA
        gUqUrnnKxsRLA3yniM0d6W+rYwbpZi2bYwVe0g+vxmVPwUA0sSfpjkFipCxJsRM75HWnzt
        tMt6yOeXuk+Kp6mQmWq0IcunnWJSMjZ4eXZkDXfYwXmFMa3mSLjECzF3qmCjBnQ1OAl6m1
        zpRdP1FUKs0qXRZc1AHXwWXPRYTf0uyTzILZ/a+xVAVZxj7zpv/4CLQOcKNKlAAaxa7/II
        gJJMFMX+LCiEcA/jXc9yqm6KmvoKKx0fGBaEgOfE+0dyf1NKNDGAoP6odrhpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683825685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=jp94WC9VHJgTSaQmpAZw+T3DPA7FhCebS1d3G9BlBBg=;
        b=ECfzSjmXMPxxMlcR5TtQM5AwQ8sZ6cTR4C3Bpk64vTPXMceAlkuetwyGzhToP+kocurtOl
        TMU+Jkd74JxSlwAH4JsvZcncl3bNn9OuNUHczW3Ae/l2kZ2jcwCIg9QGBwC/90Nb0QN30j
        mhHjQZuUOb8KeVoqkSbGOvoB4lfpqI4SEpHIgmkQTNjZAtZruu9pAc1pT9mCg0sPdO9gU6
        AIBt/V9ED3lWmPNs/mpONnyVffGBacFNOF3FZSjEmSuOxp07Nx4tTLSXMRNGC1tkQtZW7M
        Qo1mxkoJWz7BwWSvVli5tfLNoX91n+LeqqY0+3tpQ57AnIhKUZjfoOiFJBRvEQ==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-hmrpw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Invention: 58dae0c928e61d44_1683825685965_3241351613
X-MC-Loop-Signature: 1683825685964:286489067
X-MC-Ingress-Time: 1683825685964
Received: from pdx1-sub0-mail-a268.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.246 (trex/6.8.1);
        Thu, 11 May 2023 17:21:25 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a268.dreamhost.com (Postfix) with ESMTPSA id 4QHJb86YHFz5h;
        Thu, 11 May 2023 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683825685;
        bh=jp94WC9VHJgTSaQmpAZw+T3DPA7FhCebS1d3G9BlBBg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=pTJ4iEwjbMLGaAP6PIynVRg9ejpITEKH8FbCah//okxbXsNBlHHgQGAURbf5xKWmL
         STwVJE2k6XcqKNro6GD9VPdj7pHxhnJKYw3v207YnO7In6ZZN0dQ2dVAzdR3FDLTxq
         Scx2dQu9cXt+ECjviNWsMHN7Hrg1+NlWfPx3iHu5uAKA6YlFjM4WfuReuTofEXAt5S
         DNEw9ZRWmJxh3yvt4Nnx3+juTAknTgg1PoypaHy4bNcBFxs/eRu2GDbpMYLmvsoOX8
         NCLxTzk5eH/jYj+cQp0bETA/uh1WPzScRH3m3W2i6TTFUClpxpBbP7TRRrJlvUlTnU
         7cUpiFujwIxaw==
Date:   Thu, 11 May 2023 09:48:40 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <z4fp6fcfhb4kfartdsqgqr7b5gvlywq4ihoucjpmhgiy536ea5@iwezgmbqwmue>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-4-dave@stgolabs.net>
 <20230511154530.00000801@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230511154530.00000801@Huawei.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023, Jonathan Cameron wrote:

>> +/*
>> + * Sanitation operation polling mode.
>> + */
>> +static void cxl_mbox_sanitize_work(struct work_struct *work)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = container_of(work, struct cxl_dev_state,
>> +			     sec.sanitize_dwork.work);
>> +
>> +	WARN_ON(cxlds->sec.sanitize_tmo == -1);
>
>Overly paranoid?

I don't see the harm, but regardless, it's racy - needs to be done
under the mbox_mutex.

>> +
>> +	mutex_lock(&cxlds->mbox_mutex);
>> +	if (cxl_mbox_background_complete(cxlds)) {
>> +		cxlds->sec.sanitize_tmo = 0;
>> +		put_device(cxlds->dev);
>> +
>> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
>> +	} else {
>> +		int tmo = cxlds->sec.sanitize_tmo + 10;
>
>Add some units to the naming of variables.

ok

>> +
>> +		cxlds->sec.sanitize_tmo = min(15 * 60, tmo);
>
>Why? That feels like it needs a comment to me.  Not that expensive
>to check this so I'm not sure the ramp up is that logical.

Right, this came from a comment from Dave:
https://lore.kernel.org/linux-cxl/bcbe1db2-cb8e-1889-2888-f4618d749bd4@intel.com/

>
>> +		queue_delayed_work(system_wq,
>> +				   &cxlds->sec.sanitize_dwork, tmo * HZ);
>> +	}
>> +	mutex_unlock(&cxlds->mbox_mutex);
>> +}
>> +
>>  /**
>>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>>   * @cxlds: The device state to communicate with.
>> @@ -173,6 +210,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>>		return -EBUSY;
>>	}
>>
>> +	/*
>> +	 * With sanitize polling, hardware might be done and the poller still
>> +	 * not be in sync. Ensure no new command comes in until so. Keep the
>> +	 * hardware semantics and only allow device health status.
>> +	 */
>> +	if (unlikely(cxlds->sec.sanitize_tmo > 0)) {
>> +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
>
>Doesn't this let the value of mbox_cmd->opcode change to HEALTH_INFO so that
>when we get here again we could carry on without other commands though still not in
>sync (if things are very weird).

I don't quite follow, mbox_cmd is local to each caller. Below I touch on this.

>> +			return -EBUSY;
>> +	}
>> +
>>	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
>>			     mbox_cmd->opcode);
>>	if (mbox_cmd->size_in) {
>> @@ -223,6 +270,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>>		u64 bg_status_reg;
>>		int i;
>>
>> +		/*
>> +		 * Sanitation is a special case which monopolizes the device
>> +		 * in an uninterruptible state and thus cannot be timesliced.
>> +		 * Return immediately instead and allow userspace to poll(2)
>> +		 * for completion.
>> +		 */
>> +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
>> +			if (cxlds->sec.sanitize_tmo != -1) {
>
>As below. Have a self explanatory variable called sec.polling or sec.interrupt
>
>> +				/* give first timeout a second */
>> +				cxlds->sec.sanitize_tmo = 1;
>
>If this was named santize_tmo_secs then comment not needed.
>
>> +				/* hold the device throughout */
>> +				get_device(cxlds->dev);
>> +				queue_delayed_work(system_wq,
>> +						   &cxlds->sec.sanitize_dwork,
>> +						   cxlds->sec.sanitize_tmo * HZ);
>> +			}
>> +
>> +			dev_dbg(dev, "Sanitation operation started\n");
>> +			return 0;
>> +		}
>> +
>>		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>>			mbox_cmd->opcode);
>>
>> @@ -366,6 +434,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>>		if (rc)
>>			goto mbox_poll;
>>
>> +		/* flag that irqs are enabled */
>> +		cxlds->sec.sanitize_tmo = -1;
>
>That's confusing.  I'd add a separate structure element for it instead with
>appropriate naming.

Agreed, can be nicer. Another alternative is doing away with it altogether and only
allow sanitation if interrupts are supported/enabled. Considering the potential runtimes,
it's not a crazy ask to the hw to at least give some notification mechanism instead
of having sw trying to stay up to date.

Thanks,
Davidlohr
