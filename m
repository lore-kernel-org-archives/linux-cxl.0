Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.214.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433013;
	b=Nkv6ZK965xtRFt8yDzT8yVxHedo5C0EglRM7OlTqnPPsjr0NMcaG6veeT9rCdAjLK/Pa
	 shyGsDzHT5mZHocZGnuP6SlKCx8mSDNHyKR8PchyvQy/KRtUkFallsc1YhQyQyN2sAXrT
	 waD6JAmQOGI0NjQjPl3hQxzmprqADgXJHlEPuEFOIRE7bvNwIn/oXWZfI2YZSAiL9MqEC
	 UVGeFeY0QIpF+VY0fSo0HjiJiCDYuxbxuQxuBMfN7IyucH3qECoJ6grKWahbd46k2IaTN
	 thnzyjh46e2YNGWbW//rtaKFUAeM3Ypg9quIePa/XnoblUjV6FS8lcj27VN7HlF0fBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433013;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Eyes-Industry:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=rfDTVoqcBahdpJ1i6HeW6/p5px1CORX9EAZQSr85SZg=;
	b=RNamquiMOtRT7d6Xt8vSN+0R/TE8hVxWTPDBPQeSLUckju7/dIFQXB9QpTyoOgKuVz65
	 diXiEma9GuBrg0GnG5aHVfcaq8DUpaMEdV+xc3par/R3Dbrh1cE5vVJGgk+KY3LrBlyPx
	 5cSehgxdOTKlDR8MvLFuJicipvKqygX2C0LRxQmWs6NMKjfYycStekc7+gGUGbfngCBMh
	 gN0GjzESLeQrA9/PWo4/DJb6sSPy+pIZwO/mKq8G0ujlxDEMzM2pw20M65AZUKds3quCU
	 CrOPatIv5iLbOQJNZRBML5oMLM0FOFJNBV5Q5Cq5u1IwsAapZlJuBcfjyxoghDUu2DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=gqY3+XaH;
	arc=none smtp.remote-ip=23.83.214.25
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3192606A31A
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 18:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3192606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=gqY3+XaH
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F15D2941259;
	Mon, 19 Oct 2026 18:03:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (100-96-2-229.trex-nlb.outbound.svc.cluster.local [100.96.2.229])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7252F940FD2;
	Mon, 19 Oct 2026 18:03:25 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Industry: 053815120f5df938_1792433005786_2111544738
X-MC-Loop-Signature: 1792433005786:3712961159
X-MC-Ingress-Time: 1792433005785
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.2.229 (trex/8.0.2);
	Mon, 19 Oct 2026 18:03:25 +0000
Received: from offworld (wsip-174-64-239-211.sd.sd.cox.net [174.64.239.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4j7k1R74rXzR3;
	Mon, 19 Oct 2026 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1792433005;
	bh=rfDTVoqcBahdpJ1i6HeW6/p5px1CORX9EAZQSr85SZg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=gqY3+XaHYizoVeKiccq5qICWvchTBQWsDWVooDYsUe3FLaq8mNbRAlmP9tzUCrzih
	 /5e2FsZJlQ8onA+HK8TlLArr3B/a+A2SrUt41QPUPw8WaHxZ8FCY49VA488wQYafdw
	 fsxifH/C1K2I1Cb8gf4KAMkex4yCb8PWnnj4mnZL/Ah9jbfiS3gwdhHAgn5oBQOKRr
	 X6HluOvcqzIv1H8kFX4dQwncs0FdV/LtjzqbvEqby2+pcQQB+PQIaKvIWkCT9/kf34
	 9FsNV6p48enL4+HNqpiCrmFicp0v8OcAYi3YQa4bd7kvPlBNdxkBF4A8yFT+oEyZ5A
	 Lv+l0jz8TzQ4Q==
Date: Mon, 19 Oct 2026 11:03:21 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v9 02/10] cxl/pci: Add BI topology enable/disable
Message-ID: <20261019180321.4ev2bgsx3c3wpiev@offworld>
References: <cover.1790103847.git.dave@stgolabs.net>
 <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
 <art5JoFbkTv7PT39@MWDK4CY14F>
 <20261013143417.ukmry7evjoef3jji@offworld>
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
In-Reply-To: <20261013143417.ukmry7evjoef3jji@offworld>
User-Agent: NeoMutt/20220429

On Tue, 13 Oct 2026, Davidlohr Bueso wrote:

>On Tue, 29 Sep 2026, Richard Cheng wrote:
>
>>On Tue, Sep 22, 2026 at 04:38:39PM +0800, Davidlohr Bueso wrote:
>>>+/*
>>>+ * devm teardown on endpoint port destruction. Registered before the
>>>+ * decoders, so devres runs it after them: regions are detached and
>>>+ * decoders unregistered by the time BI comes down.
>>>+ */
>>>+static void cxl_bi_dealloc(void *data)
>>>+{
>>>+	struct cxl_port *endpoint = data;
>>>+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>>>+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>>+	struct cxl_dport *dport_iter;
>>>+	struct cxl_port *port_iter;
>>>+
>>>+	cxl_bi_ctrl_endpoint_disable(cxlds);
>>>+	cxlds->bi = false;
>>>+
>>
>>
>>Is it safe to disable BI unconditionally ?
>>
>>For a FW-configured HDM-DB region with locked decoders, resetting decoders can
>>leave the HW mapping active. If that memory is boot System RAM, it can remain
>>in use after driver unbind, while the cleanup here disable BI.
>>
>>I think one of the scenario is when decoders are boot-programmed and locked.
>>FW could configure such a range with BI enabled and expose it
>>
>>Should we preserve BI when those locked mapping remain active ?
>
>The HDM decoder BI bit is RWL, while the BI Decoder/RT are not locked; which
>makes this a policy decision, afaict.
>
>So your example scenario makes sense not to disable the endpoint, but the same
>applies to the dports, essentially making cxl_bi_dealloc() a nop for the locked
>BI enabled HDM decoder. In terms of BI-ID this seems ok as the device is actually
>not dissapearing.
>
>Is this something we want? Should the spec pronounce itself in the cases of
>locked decoders?
>
>Thoughts?

fyi, I have added these BI auto-commit locked semantics to the testing infrastructure:

https://github.com/davidlohr/cxl-bi-tests/blob/main/topos/t24-adopt.sh

(direct+switch topologies: fw-locked and fw-switch-locked)

Thanks,
Davidlohr
