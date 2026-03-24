Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7B19343E
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378763; cv=pass; b=L7VVEuWR48MaXZEqttCkts5IlaoxakEz7FnUB+GsGVTPcKLlVoL2odWv7ZI5714bzBJm31YQR9aw4akFv04ZWIdem8qDLUXylreTOa9NFAyfDsJqBnlHNPPf6rDcFHnVWiFI5MUuHFA3MDE82ZRkc0vTlLEscRWi27ffMjCLL2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378763; c=relaxed/simple;
	bh=BxR3G8s4K7CLzE/cYyRcaDPDryD8XdPCmj/vbxOeRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqIiVwPCwB2sLWqKkW3fY+cdJ+lYje7CU5fNfnbjt/Th+DsmaulylLeHxqkyeMvx4BOrYibweabhXikjr982auCjCtILc8m9FgwJXrPnF8HtP4DzmS+vV9dpZJp9WOs5pq1Tl8e5/vBGDQOPSyvZ3sAdCzwak4rVu3zUuimdGAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=XPAYxhOa; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="XPAYxhOa"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ABBDD581F63;
	Tue, 24 Mar 2026 18:40:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.121.5.127])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4919B581DCC;
	Tue, 24 Mar 2026 18:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1774377623;
	b=7j0lLIoJKR+Y4HQYKs10IzTZZAGweEB7Km4U8ZD+jRc4fcErQhJxJVt6SHczJx7VK/NtXe
	Ppl80D0fLDd6slSl6hFabpsog1NTt/cLt7asW5NGbaTwkfdB97mVfx2M7aCRtaONaQyMQP
	ZCH6AfLIFaENaN8XQ1Af2fveTiJSIAqoEPUUqyun9QLpXHT395lmoQJRrVQVVT3lHQyKr1
	Dq0fWUn5hY8DZSdZ7bzraPtfvGID/FWlk6dbU8zYRT/uZGDNmAJZb/G4doz9So4eMf9mxO
	oj1h0ICQmpZtg0UQR3S8n+NtwdpDIPNMqYRloQby0xWzcm/t3qnVwcgh3n8h5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1774377623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JHFA10TK5RiY5mTofH3mf+WUe9fBHOKJKJJ6iEsiV70=;
	b=t2V1aJHuI1i81/7EnwaiHGRXtG6oGyG4klOwtE2Cbu9HiCw+0DyRPeIP6za41qDeNvNAYm
	0zQCg+wpnccGvXTKflK+xbk3iiUDvtvdeKlftk+zke0TjtHfSguENKgIAMnA4NtM2iYTbg
	WB4p7vBUUXNT0+4B/YHXY8mPPqdaZrZnbpfxt48kR26UJ6/nfZkxIhbOKfiv4ObOA63NAz
	SUXvYTTIh9rm8PEQDXS3feKz3+6QXW5Z8+X6GgbfiPOvALxyJdbtJbBJ4jrSOKCzkSnJ0F
	9zmxrtVChdvbofUiCNtKHpBhtIN/0od+A3AO6kJ7iA6QQYq8trMayS2nSeGXzA==
ARC-Authentication-Results: i=1;
	rspamd-6d4cb6745-lttx7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Occur: 5841f878167c0ec4_1774377623563_3925734241
X-MC-Loop-Signature: 1774377623563:338959626
X-MC-Ingress-Time: 1774377623562
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.5.127 (trex/7.1.5);
	Tue, 24 Mar 2026 18:40:23 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4fgJkZ4wJ7z103y;
	Tue, 24 Mar 2026 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1774377623;
	bh=JHFA10TK5RiY5mTofH3mf+WUe9fBHOKJKJJ6iEsiV70=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XPAYxhOaqnTfGjrehTEvCEzcNFYADg9MuMt1CgAsNoNVZUy2TVCTz4tSUGSQ7q2vY
	 JKO6sxzLXfCo5DTQviVSr2Qi+62EAG7J7U5CT/g6s5eie7xmBW7l6h0ho2jmGJeApE
	 NCeW6z36KNnDhpCyJQvZXbJujOIHgtcijCv56hNxEZqoCor1ulVuK6sNNsrMQgqg28
	 ciBmWCaoXkH7MWJLanQIXCNSdm8hm//Seh3clbiCVVyzBUdVlByiShFChlRdsR9pHp
	 xSJVxPU3Qmw+YP9C+XfMpRXNNs8FzD4YXBoQUmVu9RWzyQqfjr8qioAKJysdaDqCnv
	 el+loyio4Osig==
Date: Tue, 24 Mar 2026 11:40:19 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, dongjoo.seo1@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/mbox: Support Media Operation
Message-ID: <20260324184019.5fyobyide6ubtcxf@offworld>
References: <20260323204013.4010634-1-dave@stgolabs.net>
 <20260323204013.4010634-2-dave@stgolabs.net>
 <20260324161832.000043f4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260324161832.000043f4@huawei.com>
User-Agent: NeoMutt/20220429

On Tue, 24 Mar 2026, Jonathan Cameron wrote:

>On Mon, 23 Mar 2026 13:40:13 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>> +What:		/sys/bus/cxl/devices/memX/security/zero
>> +Date:		March, 2026
>> +KernelVersion:	v7.1
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(WO) Write a DPA range as 'start length' in bytes to this
>> +		attribute to zero a specific region of device media via the
>> +		Media Operation command. After completion, reads from the
>> +		specified range will return zero.
>
>This is only true if we've flushed any caches on the CPU Side of the link.
>Will happen anyway I think as part of making the memory available.

Correct, same as for current sanitize/secure erase, described in the sysfs doc.

>Perhaps not worth mentioning that complexity here.

Still important, I will mention this in the changelog.

>
>> The start address and
>> +		length must be aligned to the device's media operation
>> +		granularity. If this file is not present, then the device
>> +		does not support the Media Operation zero command.
>> +
>> +
>>  What:		/sys/bus/cxl/devices/memX/firmware/
>>  Date:		April, 2023
>>  KernelVersion:	v6.5
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index aaa5c6277ebf..b7047cb9abed 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>
>>
>> +/**
>> + * cxl_media_op_discover() - Discover supported media operation
>> + * @mds: The device data for the operation
>> + *
>> + * Discover any available Media Operations.
>> + *
>> + * Return: 0 on success or if Media Operation is not supported,
>> + * negative error code on failure.
>> + */
>> +#define CXL_MEDIA_OP_MAX_OPS 2
>> +
>> +int cxl_media_op_discover(struct cxl_memdev_state *mds)
>> +{
>> +	size_t out_size, in_size;
>> +	void *payload_in;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>> +	struct cxl_mbox_media_op_input *payload;
>> +	struct cxl_mbox_media_op_discovery_args *args;
>
>Ah. I'd forgotten this spec oddity of two different types
>of trailing member, or technically a flex array in the middle
>but one that is defined to be zero length if the structure
>after it is present.   Maybe cleanest option is
>a separate cxl_mbox_media_op_discover_input structure?  Probably
>with a comment to say there is a zero length array in the middle.

Yeah this is a pita.

...

>> +	mbox_cmd = (struct cxl_mbox_cmd) {
>> +		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
>> +		.payload_in = payload_in,
>> +		.size_in = in_size,
>> +		.payload_out = disc_out,
>> +		.size_out = out_size,
>> +		.min_out = sizeof(*disc_out),
>> +		.poll_count = 1,
>> +		.poll_interval_ms = 1000,
>> +	};
>> +
>> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>> +	if (rc < 0) {
>> +		dev_dbg(cxl_mbox->host,
>> +			"Media Operation Discovery failed: %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	mds->media_op.granularity = le64_to_cpu(disc_out->granularity);
>> +	num_returned = min_t(u16, le16_to_cpu(disc_out->num_returned),
>> +			     CXL_MEDIA_OP_MAX_OPS);
>
>If it claims to have returned more than we asked for, why not error out?
>I might be missing something.

Made sense at the time, reconsidering I tend to agree.

...

>> +static int __cxl_mem_media_op(struct cxl_memdev_state *mds, u8 class,
>> +			      u8 subclass, u64 dpa_start, u64 dpa_length)
>> +{
>> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>> +	struct cxl_mbox_media_op_input *payload;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	u64 granularity;
>> +	size_t size;
>> +	int rc;
>> +
>> +	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
>> +		      mds->security.enabled_cmds))
>> +		return -EOPNOTSUPP;
>> +
>> +	/* ensure the specific operation was reported by Discovery */
>> +	if (class == CXL_MEDIA_OP_CLASS_SANITIZE &&
>> +	    subclass == CXL_MEDIA_OP_SUBCLASS_SANITIZE &&
>> +	    !mds->media_op.sanitize_supported)
>> +		return -EOPNOTSUPP;
>> +	if (class == CXL_MEDIA_OP_CLASS_SANITIZE &&
>> +	    subclass == CXL_MEDIA_OP_SUBCLASS_ZERO &&
>> +	    !mds->media_op.zero_supported)
>> +		return -EOPNOTSUPP;
>
>Maybe nest multiple ifs.
>	if (class == CXL_MEDIA_OP_CLASS_SANITIZE) {
>		if (subclass == CXL_MEDIA_OP_SUBCLASS_SANITIZE &&
>		    !mds->media_op.sanitize_supported)
>`			return -EOPNOTSUPP;
>		if (subclass = CXL_MEDIA_OP_SUBCLASS_ZERO &&
>		    !mds->media_op.zero_supported)
>			return -EOPNOTSUPP;
>	}
>Doesn't matter much whilst we have only two, but if we get lots it
>may make them easier to find in the code.

I will use a switch.

... and ack to the rest of the feedback.

Thanks,
Davidlohr
