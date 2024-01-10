Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B5433C0
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jan 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="UKIfPMar"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D0464903504;
	Wed, 10 Jan 2024 16:43:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 59A029034ED;
	Wed, 10 Jan 2024 16:43:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704904984; a=rsa-sha256;
	cv=none;
	b=bSpm64WqVrWrDiyZBserwCT0x5s/nIImqqQiPDrnHjy8Zjd77rfQ3wXwNeXpSHtp70yWB3
	HbDUOvwWeJQoJt1NhDGR33L8NRTNReJl7RiKq/NZMuvJiDYweMm8MGq8GiC6r9zuRBVyF9
	oMP55ZM7mKyRIGRJmq49bBge3As94GE+EKT2oF5T/xXPc95qmQxCQKTG+850ZaBoAIDD2f
	kVcaKIBERIAWkY+RFdxxuYgyhr/3hhTShgKlC+MKzLAiN+O4KJYMm2WAzv/UFS811U+uGj
	9psKmbZX5jAkaSNK4P4PG+JRmT0VdGuDAm69JXYnNeMLSGlix5FUIr4FnVK1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1704904984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=feSjPT6OTmawsjJJ0p1pHG4rFvgm2tnPPMDHDpLcVO4=;
	b=ZCmQ0+1g/3tvUf+Kd3MTIsBN56XSAR6H4cbWB8SK5X8abfB8BJbY3fzahpgzEkIM36Gthn
	0ntCwm5pA4qzTc7oRAcYyeZR0RjYCOBZCKLpyzIWqLqLxJyRX4FuYo+Dqw3yaSJb8QxZMY
	ONtzQO+MSDfPwOzj/Qcmo0VC9cE2wGfnk3h8gXiBQsa5znG8yGXYfe5WMX2gC+0TRUxpDi
	lniUAh37i1N6+3urTFyPR9toE5Kqz0WAgX38F12px+lim9eeAzlVBoy8xN36VXmNlagTRn
	2Vk2/QfcB/c7W/RvDUfYr3kA1xBihdusrsQzthXqZocegYMpNPrel3EqqZu4zA==
ARC-Authentication-Results: i=1;
	rspamd-568947cb6c-9947n;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Harmony: 5fe0795c2705576c_1704904984662_2483618423
X-MC-Loop-Signature: 1704904984662:3989522464
X-MC-Ingress-Time: 1704904984662
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.10.89 (trex/6.9.2);
	Wed, 10 Jan 2024 16:43:04 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4T9DBH5NJqzbP;
	Wed, 10 Jan 2024 08:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1704904984;
	bh=feSjPT6OTmawsjJJ0p1pHG4rFvgm2tnPPMDHDpLcVO4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=UKIfPMarlCAeMY8qOC9+jiY2UA0L9m3gS3by8dgECeY2qDLJE4b7S6ejg9o2KtoZc
	 L5bjZXUeBXCSfZpYrBUfW2YOjB07x4oSyfNmji7ytFa53Y9bFQecnFqfsh4GpToScZ
	 gHF5VB7rQP/oC4maEy4U0LUzSCzLz95WIc3OckJCa2oRG3ndLHtfvCYEh8GgSCDErC
	 N9Ysm/aw1tBGrOVEyWSncuz5C8jEaFGdedr6qPGso31MBOExtovB2PSD9CUHuTKTTn
	 ncLNtSnqAn46PtnoahQ0BHywgA4cZhSLxQoUNhygYcoDRifPtbK93s8fBd8z94KEJz
	 9mX32moREoofg==
Date: Wed, 10 Jan 2024 08:43:00 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: fan <nifan.cxl@gmail.com>
Cc: Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
	fan.ni@samsung.com, a.manzanares@samsung.com, mounika.k@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] hw/cxl: Add Transfer FW support
Message-ID: <20240110164300.tvukfnaf6v5quqdq@offworld>
References: <20240109070436.21253-1-dave@stgolabs.net>
 <20240109070436.21253-2-dave@stgolabs.net>
 <ZZ3KiceGpf5RUC5a@debian>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZZ3KiceGpf5RUC5a@debian>
User-Agent: NeoMutt/20220429

On Tue, 09 Jan 2024, fan wrote:

>> +    switch (fw_transfer->action) {
>> +    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
>> +    case CXL_FW_XFER_ACTION_END:
>> +        if (fw_transfer->slot == 0 ||
>> +            fw_transfer->slot == cci->fw.active_slot ||
>> +            fw_transfer->slot > CXL_FW_SLOTS) {
>Should here be >= instead of > ?

No because the input starts from slot 1.

>> +            return CXL_MBOX_FW_INVALID_SLOT;
>> +        }
>> +        /*
>> +         * Optimistically mark the slot used now (as opposed
>> +         * to at the end of the successful transfer). That
>> +         * way we don't need to keep command context.
>> +         */
>> +        cci->fw.slot[fw_transfer->slot - 1] = true;
>> +        break;
>> +    case CXL_FW_XFER_ACTION_INIT:
>> +        if (offset != 0) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        /* fallthrough */
>> +    case CXL_FW_XFER_ACTION_CONTINUE:
>> +        break;
>> +    case CXL_FW_XFER_ACTION_ABORT: /* nop */
>> +        return CXL_MBOX_SUCCESS;
>> +    default:
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    cci->fw.transfering = true;
>> +
>> +    cci->bg.runtime = 2 * 1000UL;
>
>How we get this? I see the spec mentioned the timeout between FW package ports
>is 30 seconds.

Well 30 secs would be the max, so that 2 seconds is just an arbitrary time
I came up with.

Thanks,
Davidlohr
