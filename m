Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBAC14A
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489619; cv=pass; b=dJhK6frQotz5z2D8wNuS6F/gs7AqPMQmhHXrCF62GCNJAeU5OqBoXcv3gGxibVwbqYu5CgItPfaPXGIDJ5pvuKN/Pi4h7er0V1V4+eAmZU6yrW1Y3iNd90WDpfEcprHac1s/ch+HpnASsTZ9QE09feBozW+87lHWNvfTD6GUb3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489619; c=relaxed/simple;
	bh=PijfPErYNPaLfP5wF2klH0u8xmNYLKMHDSobXHoye4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBecbS6H1u/u4WbqXicHnSdm1nUTlZVGbPc0HXEmZRgLIU07rnOUVO6/l5rSXOba0eqwOxXf8NXeZ+6cjkijWnKyj4TH9d8wO4Y/NjkYWIMjGnrByPQQQJwD9RdI37mzg/cQoAILaYXaSAfup73MeJPAVYRCLHt7sYKrEOO13rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qaF40EN3; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qaF40EN3"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EB9994C0693;
	Wed, 29 Apr 2026 19:06:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (100-96-40-36.trex-nlb.outbound.svc.cluster.local [100.96.40.36])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 86A654C22DC;
	Wed, 29 Apr 2026 19:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777489617;
	b=BEcRIP1925jY2Uma6MYepRutNXCaUhJx4Wx212ziuuYS3fQQL9cJinv/czehNAl9CPWruN
	HGl+DMsABk0mlFGBsqfWVhleXnBjEtkfaaeXEmNreAFAmofcK7cUAggYgd/LQyZ7euRgeI
	4f3FEUV65frA63BnQoX+z8wqDH2Os3iGqD5BWn5Fd8NkYXAKkAi8Epz4Rgn+JGGoNRTIo/
	Wssk5RpROdPabllkRG4F3Z6UK84yJyZNMc4s+VfXAUrTeDDMN/tDs68KbRcCOrDpDXrVIr
	zLr90jX13VXgTLs2WUaTZKfobiIsoZoY44MT3p3oEjqdGBY0tqfqjRvKqp+zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777489617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=i7EehixxieRJmHFiMnAyoTJHTSRJhVAHF4vTPc8QUE8=;
	b=8ZDuNl+inJ9/+H8PMZ/ADpPm9x5ro6P3QVxckk9mZT7Y7zvgi+BxJ6f9NY5XnymAJM8SKF
	OUHiny7YBOydYyv8UftTSWxyC7tDhNM04F0o7pl318vVeHieZeXeNZvCRJ2OnhcyATzU/8
	E65dHAqvhTWeFU5y6SpxG9GT/5qqxTNtKyXF2W20SUlTwW8ahtlRey+bEGBcDeFEghCVkd
	ewpkz7G7QCpuc7r+26sQbYmY+4dC6sPo5zCAWNHapnvjPGbga+uoWlwdU6DAyHaLc0L4yg
	aUJZ53TWYkou63IyGRUyYVDE8fQpQdpfeaCon/KhXOrvcfpOM5KHWJYMaIySXQ==
ARC-Authentication-Results: i=1;
	rspamd-5bbb54c4f7-llrpx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Tangy: 3bbbffea68a7e3b7_1777489617806_1692366539
X-MC-Loop-Signature: 1777489617806:4283813500
X-MC-Ingress-Time: 1777489617806
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.40.36 (trex/7.1.5);
	Wed, 29 Apr 2026 19:06:57 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4g5Rcc7368z1dX;
	Wed, 29 Apr 2026 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1777489617;
	bh=i7EehixxieRJmHFiMnAyoTJHTSRJhVAHF4vTPc8QUE8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=qaF40EN3pUeKQMOc0hA7XzQBdOf/IJXUuY8aEnLSNKTc0fdiwdC9BkZtQA8PXyJbA
	 K/FwKcjH8aj14U9Fu4noQaxow8SbAolTemlWcPGgSFsc4lj8zFPc6PrMhnTVmJ+jMC
	 UZU/SBwXFEPEkE4bqEf23FvBWMvO9SR/01uYKrDf1c+/sDSE5mqAbZ3JjYGWj/br6i
	 rjea1lVSBWJaMA01K+QA03bp+p1dN42+zAlqyjCy9lj/t5fYb0Qv06JDwW/mybHZwj
	 T7loju/GBTcGg1N3kdsOgo6XG3pInY3bff+8htfHb/O+gO44tb1GicBlCe6NvNykby
	 PhxxXLIoUilpQ==
Date: Wed, 29 Apr 2026 12:06:54 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
	djbw@kernel.org, dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
Message-ID: <20260429190654.mhu6bh2ni2o5g7bp@offworld>
References: <20260428200410.705675-1-dave@stgolabs.net>
 <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 28 Apr 2026, Dave Jiang wrote:

>On 4/28/26 1:04 PM, Davidlohr Bueso wrote:
>> Add support for the Media Operation command (opcode 4402h) which
>> enables targeted sanitize and zero operations on specific DPA ranges,
>> as defined in CXL 4.0 Section 8.2.10.9.5.3.
>>
>> Operations are only allowed on DPA ranges that do not overlap any
>> hardware-committed endpoint decoder to ensure not corrupting active
>> mappings.
>>
>> Following the path that we currently impose for background cmds, where
>> users are left with the responsibility of breaking up work sanely, this
>> implementation imposes an arbitrary limit of 1Gb range to avoid hogging
>> locks (ie: region/dpa cannot change while media op is on going) and resource
>> monopolization such as mbox. As such, background commands are processed
>> synchronously, with a 30s timeout, and currently, per spec, there is no
>> optional abort it either, nor a way for the device to inform how long the
>> op could take, ala Scan Media. The observation is that this differs in
>> semantics regarding the sanitize case, which for whole-device continues
>> to be handled asynchronously, as a special case.
>>
>> Run Discovery during probe to get the device's DPA range granularity
>> and which operations are supported, and expose to sysfs accordingly:
>>
>>   o 'security/sanitize' is multiplexed to allow single ranged input.
>
>Maybe just introduce a new sysfs attrib instead of multiplexing?
>security/sanitize_range

I am torn between the two options - I do like just a single file.
But I also like that its own file eliminates that strange async/sync
handling, which might be a more important factor to consider. If we did
this, I would rename zero to zero_range as well, for consistency.

>
>>   o 'security/zero' is added, also with single ranged input.
>>   o 'security/range_limit' is added so users can see the max range supported.
>
>media_op_range_limit?

Ok
>
>Can you split this into 3 patches: discover, sanitize_range enabling, and sanitize_zero?

Ok
>
>Would be great to get some cxl_test coverage on the new added ops.

Right, so far I have used qemu's support to test, I will add cxl_test coverage
as a follow up to this work.

Thanks,
Davidlohr
