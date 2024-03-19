Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF43BBC7
	for <linux-cxl@vger.kernel.org>; Tue, 19 Mar 2024 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881756; cv=pass; b=px6RJLKGMlgeawqGdFMJPLm2+MP2xI4BSaw4LV5IM/KwNdygs9vJlVKj8I5yM/TkTrSRQkuq3SfUun8t728/3nKmEiBhIZwrIrf5lQ8chuyppyWXQVpm9w4IS2lvTHlLrpxlL+xMEhMoLFTGAKfeR0HW4oKUBvmg5B3j8EWl1Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881756; c=relaxed/simple;
	bh=FCyRTh1+7WcMTI/ZjCdW4cntWia2RFoVcBJ0s9tHGLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRBZx8nFmPJE7beFYISvpQ9esRyZuA2HIJ09uSM5rDOMUZLaG3dEsiwagdAxhg01geLJXQE/gMWEnkI0x2dtjvz6brOP9LuZzISl+XVwv0pTrR1WEEsiKN9jXruH0+EDW6DimGP30Y0YEhWYpzBlWfzgR3evpfrlYyKFkslXBds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=G/WEFVzk; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="G/WEFVzk"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BEDF69419F1;
	Tue, 19 Mar 2024 20:48:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a266.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 37BF994297B;
	Tue, 19 Mar 2024 20:48:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1710881302; a=rsa-sha256;
	cv=none;
	b=sSo6GTCiwItr4DJNDMnEHqErT7ZBRA4lV8NJwm2hf4iyoBM+nVb4k1CA2RI/tv3oy6T4ZO
	Pl2N9ye/xK/cz68NaWrIZRlKPitWiLYiyhDM+jjF/6iZsTNnkn0Ro7qfZ2wL01vkPOynwj
	lla/t4dLnziijydcAf5zfJTXCsgFV5tqdT8840TfnJkdo+Ia1KnlMFL36KlwnLqv4n76mo
	YMAxO4HawtoNgaTah4I/sJtC3KREVinAVCi+1iEq4fmNDMiob3MclzoxcOo+QvG3q4cc+T
	Bxv8Vc5F+00agMlSGaAFRRoRHx54JzfGoEKeQ5yYHmzKIzMG0eyk4jj8vfCoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1710881302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HSveECX8qZ7Bqurpk9gsecvcZ2QFYGLDFYd2v1/qKmA=;
	b=yCQ+0gwNXTIcSTSRleSuMNLAh2LYwE0B+vAwYkAT09AIguThIdn3tA5Xl6nCWSzYbVqxk7
	tUw2WBGknb5s2YL/YBYVRUF+yBKqWrWambtO7W3N97OFvZxUGhoJW3bkLeF41G0TnG1pTF
	J4qv45mJ0k40mBrS7ddtaudumZjbuoaGWAtRJqPmWN31DBhcIXJ4VZR4ontx+AKcAIetYY
	kWCfpILVmL2akfo7AiW28KaSuv7Pw38nkX8A45o6a7tWXlJNnJGPzRLZ/bmZcQzwhdyZRp
	v43gUi3MMDoEDdOTxCV13zhXHSDCQX5A/IEkbk2zzExZZBrXaLeuJ9AXheUB6Q==
ARC-Authentication-Results: i=1;
	rspamd-b46fcdc5-szmst;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Grain: 77636f735cdbe22b_1710881302582_3903135445
X-MC-Loop-Signature: 1710881302582:840087406
X-MC-Ingress-Time: 1710881302582
Received: from pdx1-sub0-mail-a266.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.130.139 (trex/6.9.2);
	Tue, 19 Mar 2024 20:48:22 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a266.dreamhost.com (Postfix) with ESMTPSA id 4TzkMT4cdmz1q;
	Tue, 19 Mar 2024 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1710881302;
	bh=HSveECX8qZ7Bqurpk9gsecvcZ2QFYGLDFYd2v1/qKmA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=G/WEFVzkOwa35KKzeTo0iU11ouJVX3R7nHuUT3eBay7GVVRuQQ/cfCnyywbQQ4kQq
	 m93097sDTU5QXaudR5POk1BsryUvhK1kvlwUNtOIdaqIU9XYz21j8sW/o/FXL2C8xC
	 pQrUNZaDsw/NQoEnuO7w7BvsdLzy2LEYr+1SpUeUbOX715cKJjWjlr3uL0Rx0Be/zy
	 TXohRI6F7N2lQ5XUmoVvRyyIYWvlykXTifDNfH7SasIbG6p/kSIKLxsnpSbxJ1tHbo
	 LqPTZH+s39M4pSoOnMEmGu7rQLcrVXS75WUFUZ5LJHuA3XiSmPG5we5E+H8fyIlF8L
	 gvyp0qcsuk2Ig==
Date: Tue, 19 Mar 2024 13:48:18 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: fan <nifan.cxl@gmail.com>
Cc: jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
	fan.ni@samsung.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 -qemu] hw/cxl: Support firmware updates
Message-ID: <20240319204818.p6qbkyktgsadmkhi@offworld>
References: <20240205172942.13343-1-dave@stgolabs.net>
 <ZfnR1jTLG_e5KCIE@debian>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZfnR1jTLG_e5KCIE@debian>
User-Agent: NeoMutt/20220429

On Tue, 19 Mar 2024, fan wrote:

>> +/* CXL r3.1 section 8.2.9.3.2: Transfer FW (Opcode 0201h) */
>> +#define CXL_FW_XFER_ALIGNMENT   128
>> +
>> +#define CXL_FW_XFER_ACTION_FULL	    0x0
>> +#define CXL_FW_XFER_ACTION_INIT	    0x1
>> +#define CXL_FW_XFER_ACTION_CONTINUE 0x2
>> +#define CXL_FW_XFER_ACTION_END	    0x3
>> +#define CXL_FW_XFER_ACTION_ABORT    0x4
>
>The above definitions have "tab" used, cannot pass checkpatch check.

I was not aware of a checkpatch for qemu, will clean up.

>> +
>> +static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
>> +                                               uint8_t *payload_in,
>> +                                               size_t len,
>> +                                               uint8_t *payload_out,
>> +                                               size_t *len_out,
>> +                                               CXLCCI *cci)
>> +{
>> +    struct {
>> +        uint8_t action;
>> +        uint8_t slot;
>> +        uint8_t caps;
>
>Based on table 8-66, I cannot find the field "caps" and it is unused.

Hmm yep don't know how that snuck in, will get rid of it.

Thanks,
Davidlohr
