Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649904;
	b=JD599ss4DBT902O9mJglL+4BZtXqonGUCbPIkG2uJgSdnS4s0x24xCS8PppUP1stwq+N
	 pU6WTCdUHt31TRrAxVUceJofVLUgwy0A00DXmDDNB1PV9Woiicy/Gy4DJNrA5pumYTAHL
	 e6USNrJDTKh8bwHEAlOlpb3fTWN8blYFOBAxxZ9oQcsyyy/n6ki+KVdse/iC8SR8IJT4l
	 zTKI1Xz7wV70x2p2B7Wf3L1ghCnxiaZZEWLKyUpqpIsohFnGCXevFvWMvTVGTTmIwGobe
	 IdkF4Q/ZxmT+WLN3gC2xg55vFLQF74Jsnm0Vhl9QI6Wmq4qkfTAYZ0JjyWDt4Q64xog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649904;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Glossy-Well-Made:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=yn1mE6uxhL1gkPEJipoOpcuVRIiAHeoRK6ltnkiGt7M=;
	b=EfVWrERWmY1nf9YmCFyDvx85Q6t+F6nO+vneEjspQcIevTTnBjZvO4TKLLPjHVG/p+Bn
	 ZEVIMOrZP/9Lko1AHwILGfCAKL86BOKnTtZjPLmzFsg06BLrELriYsSAI5OSW2Dmejf3h
	 48Ou9vdWgtXbPDpDwgVvszDVoEyOHyIKlJqyY1YYHjSI0yOJkU+vL62SR5v5t75gW4iNs
	 +IBmMqjxNxGCAIpkoBXXDvF6ZSB2QUaol0x5s1YHkHTwuCzx6O8gJ5VNSChhPt7aU1ArQ
	 y3W7lsjzfsLlXGyvazW/d768pEvvtEvJbhTsCbXVG09yv1I+CSsECOtCR5C1nkpIXcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="kk/lXLa2";
	arc=none smtp.remote-ip=23.83.223.169
Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DBE606A324
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21DBE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=kk/lXLa2
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5DDE28018EE;
	Mon, 02 Nov 2026 20:04:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.99.192.246])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D9B94801985;
	Mon, 02 Nov 2026 20:04:55 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Well-Made: 305bec7c08e5c877_1793649895980_3108639294
X-MC-Loop-Signature: 1793649895980:2284964918
X-MC-Ingress-Time: 1793649895979
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.192.246 (trex/8.0.2);
	Mon, 02 Nov 2026 20:04:55 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4jJN390Y7Qz105b;
	Mon,  2 Nov 2026 12:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793649895;
	bh=yn1mE6uxhL1gkPEJipoOpcuVRIiAHeoRK6ltnkiGt7M=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kk/lXLa2sV628vGMsdRUwvZdzQ9d9T+4IadWSVSVPwu/eKHNwIlByBKxNN5HR360m
	 ICG/zwEmb6qpBrM7kIsr7MLIpXYsJcTGSQTCdytHh6l7VJBAOcyPwtoqlmSwkyhB5V
	 jp3fBXZVu2abwxKnt+CkZ1i8oqKJIWsHigCcNLIP3K8mYZXzBQz8FwX1B9UVwcTTu7
	 ve1p/JmZdQjM74DPdPCZSt2rBJlMoIEfJcWJjw6hyB35l2HqKxiTge5WK+35JySIWg
	 ewBd5wvGxvbzY632OGdfvhTlFnxlluvHaV0HvpXb576icIW5jxv9xxArf3cmQeWbF6
	 HLtBeBYx2aqRw==
Date: Mon, 2 Nov 2026 12:04:49 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	icheng@nvidia.com, benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v10 08/10] cxl: Handle auto-committed BI hdm decoders
Message-ID: <20261102200449.y7jx3guifolmlent@offworld>
References: <cover.1793567979.git.dave@stgolabs.net>
 <db0f7cc38da1300596a7b8653bd2fba010e20e52.1793567979.git.dave@stgolabs.net>
 <dfe70cf5-f6ef-4b28-9c51-49e7fbd8b9c8@zohomail.com>
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
In-Reply-To: <dfe70cf5-f6ef-4b28-9c51-49e7fbd8b9c8@zohomail.com>
User-Agent: NeoMutt/20220429

On Mon, 02 Nov 2026, Li Ming wrote:

>>@@ -907,6 +907,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>  	int id = cxld->id, rc;
>>+	u32 ctrl;
>>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>>  		return 0;
>>@@ -950,6 +951,10 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>  	port->commit_end++;
>>  	cxld->flags |= CXL_DECODER_F_ENABLE;
>>+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>>+	if (ctrl & CXL_HDM_DECODER0_CTRL_BI)
>>+		cxld->flags |= CXL_DECODER_F_BI;
>>+
>
>IIUC, this part is unrelated auto-committed BI HDM decoder handling, 
>because above "if (cxld->flags & CXL_DECODER_F_ENABLE)" will return 
>directly for auto-committed BI HDM decoder, I guess this part should 
>move to patch #4?

That's fair. Since Alison's comment for caching this read was in this patch,
I just went ahead and did it all here for the endpoint. Patch 4 introduces
the flag for the root decoder, and this patch extends its use for BI
endpoints (much like how we do it for the LOCK equivalent).

I'll move the non strictly auto-commit CXL_DECODER_F_BI users out of
this patch and into patch 4 - which is basically this and the reset.

Thanks,
Davidlohr
