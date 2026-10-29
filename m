Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.248
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316344;
	b=ZCosUzziynu9MmJrfSgBS+7bRzRUjRd92B5FPDf9SmDHCn3uZtIgYY21T4QDWa2mEAGn
	 LMn98IEbgJRBKkLjizQucK0VP30qYSxzmAotdIB2Hf0zeHR7uJZQpc/FjaVp0PO2aHphX
	 JkPQ3kyt3GRAAJgW0U9UcDG6UpmK0rFELsEZhdaYeQvxOzNfPqwwJjUCEG5NARnzq1g0W
	 12jn9OFua/AcyalKf/AufFFCiTXryJApoQcOxw5QFjVEm07xD95D6ueKgvJkmlkaq1v/c
	 2tNG06tPkkUypoCRIxMOf1Vhn+lqrrn5vLVDn2vzr0kACNacMQQimtSaR+/2w9BDDqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316344;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Thoughtful-Arch:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=gUhi95tHATKdLOlDBWXHMhyTcJgO61Ly6UA5MujeC8Q=;
	b=F7pVESMHYJeZbBTn7vxSS4PeohFgJ8UwzBT/MIl2hAgcTwXq3e3Ohgt8A4PIjnNzsE78
	 lh7YDw8V5jcrtpmLngK36cYJIxGK1YFpIGvYumW7/bzH0rH2BFpIRlxHsIfsIfeyvYCww
	 FpM2zfTRqmZjT1ivLB0ElkvVNJEFGNUMSti7NCNMGv/Nqr4O1JCE8K4476PCMr+EVsr3U
	 uYQk3HKAKl9/d3S1+p7jKMXCwpDRtTNrwq16DCoQgbJmfblTKDjMek3mwY6+7RfJBXlEl
	 DYn93Jr0U6Wq5xfE5XApF7hzWP2Mvfd1ePWkQdcJSuA5Rhck9rzG4XjNQFiMkhTuE0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=dUN5erDM;
	arc=none smtp.remote-ip=23.83.218.248
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F854606A333
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 23:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F854606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=dUN5erDM
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AE39A46147A;
	Thu, 29 Oct 2026 23:25:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (100-96-2-151.trex-nlb.outbound.svc.cluster.local [100.96.2.151])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 43BAF460BDE;
	Thu, 29 Oct 2026 23:25:34 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Arch: 621e041105710783_1793316338553_677256058
X-MC-Loop-Signature: 1793316338553:4001395389
X-MC-Ingress-Time: 1793316338553
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.2.151 (trex/8.0.2);
	Thu, 29 Oct 2026 23:25:38 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4jG0hY5MVjz3K;
	Thu, 29 Oct 2026 16:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793316334;
	bh=gUhi95tHATKdLOlDBWXHMhyTcJgO61Ly6UA5MujeC8Q=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=dUN5erDMeXlKhErhUEvhUa9IffX2zZnoXQxmh2sKCKNwf6LfSZlKz4lj8ZNsJbdzY
	 OsTxmZya36Ya13SJ9Bex2WsSt8bq3C1d5JoaDawEXzgDS50HnzEobcc1yP0sPPhRVE
	 2F1cUDCCv8ReZTRrRXdc3pcMfnFK66Zd0yRBQ/lbR9TKHe23COPyy7SKLb2NAb5O0l
	 ab6PtBiti1VMVLGrx/7ZBIqBwQNOwIVLLO5WwjIeHoV3SUnp+z17v4lcShTza4ISu3
	 9uAC7N6wpeYglWKtdQZIrd+1HlclvFngxsUa12pUxr4F7JfPbTDmkusHhSbe4p3XD+
	 MpnH6II/n33RQ==
Date: Thu, 29 Oct 2026 16:25:30 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: jic23@kernel.org, alison.schofield@intel.com, ming.li@zohomail.com,
	icheng@nvidia.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/hdm: Account for locked decoders regardless of
 commit state
Message-ID: <20261029232530.5obimin3kbkaido5@offworld>
References: <20261029201327.1119231-1-dave@stgolabs.net>
 <197c7286-6961-4934-80f7-896cf8a37ef6@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <197c7286-6961-4934-80f7-896cf8a37ef6@intel.com>
User-Agent: NeoMutt/20220429

On Thu, 29 Oct 2026, Dave Jiang wrote:

>
>
>On 10/29/26 1:13 PM, Davidlohr Bueso wrote:
>> Firmware may arm a locked decoder it leaves uncommitted, a corner
>> case albeit a valid one. Enumeration only records the bit for committed
>> decoders, yet setup_hw_decoder() carries it through and the driver's
>> own commit triggers it read-only.
>>
>> A later region teardown then writes a reset the hardware ignores and
>> clears CXL_DECODER_F_ENABLE anyway, so the decoder looks free while it
>> still decodes and releases its DPA.
>>
>> Record the bit regardless of the commit state, such that the decoder
>> then reads locked from probe, and a region built on it is locked at
>> attach.
>>
>> Tested on qemu modified to enforce locked, arming the bit on an
>> uncommitted endpoint decoder before the endpoint probes, then
>> committing and deleting a 256M region on it and creating a 512M one.
>> Before, the decoder and region read unlocked, the DPA is freed and the
>> second region reports committed while the hardware still decodes the
>> first; after, both read locked from attach, decommit fails with
>> -EPERM, the DPA release with -EBUSY, and the second region cannot
>> allocate DPA.
>>
>> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>Can you commit the decoder in locked state? Or are you just stuck in this weird state?

I would think so, the bit is locked *on* commit, so the decoder is not
locked yet.

>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks,
Davidlohr
