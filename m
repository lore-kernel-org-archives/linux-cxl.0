Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9E2BCF7F
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695836; cv=pass; b=cugY5c+xV/7nQpqmvfiw4HmeJQUHS1yOcK91R1jarnIhGxGxYZ0nWrdJHn8qkpf9joIp0gtwL+8UIFPo3F5Ymo1B7at/EygKdIa6YzSn6rPX9vCSFN7NpE6fnBEk27n3CZmbL7aKI7NOVvNc5WZWR+2TklXN2jjhg4uY8HuxxH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695836; c=relaxed/simple;
	bh=9GRyQIlMOi2SpZluQiZsT6UxkI7EQNBAqooeYImtjpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m02RGdoIzH2NoZdEuwBdDGp92PHyrn8nTG7aBNYxC4QYgY9NzWXjOz9fGSug2gmypetqw6tMgAQpRA4AYpDC+RxDWKWo/2CvCpJFrxSrywoDuj40faJeSB/d+v38/nPC7Yq233RR7bpqmcHjpT+CWXQGlacvj3C3YIrMlhLPo38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=jowOR7cd; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="jowOR7cd"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B2C9C164EFA;
	Mon, 23 Jun 2025 16:23:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.108.88.219])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 409B31645C9;
	Mon, 23 Jun 2025 16:23:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750695833; a=rsa-sha256;
	cv=none;
	b=tzlBjYqWsOfZg2AjIrDcbSMJcUsLcNmdb1d+YL/bS98dEFDSwhBybgvhwlcya6fPdvb8Sw
	pEWmWEs+W6ILFzRW+hnfe5kSdu4jDheO75qeeyQtpA0BVMB7ZOX5RLosY5aiGQ1CBJ8US1
	S/oTksIDiXgsSf0ppXnRypn3EHONfwFS/nRSIW2Uax7ePy+tWko0AAJBVh8y+oFOoitj/N
	PAM318k8FaaZMDquKyS9WC7/EI5AcisJoAPyzTw7adItqGpW5IdWgyuixhvJk6vbJzZ6DP
	TDkFyg54alOQlkRsuCFyCkCQONx3atGGXexL276F12jZyHEflikT3FtRsIY75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750695833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=t5W8ONKKKLf0jew+m7GxsMvWNWb1Prto8MuI+EyMs0w=;
	b=IqQLdPSxqAwJcBre/qVG304LyPIw8Un0UHh088Cx6yiz6DuasWAq0wy8QGEO+/QencAa2R
	Z7jzbWRwbvfLsSnlfKjiTv/BshmoRG7Sc6NQJfvhv94Y660bKq1ZUY0XqNh5aYJqFVbW0O
	f2zuQvogLOkCmFq56vg3nHs9qtApYlOCGC/Rvmw7eCHfkbdqS0A96xOs+X6GAH1yqDB5aw
	HosyJuz1m1n2LKxKcvnCexuQEEcW/Z4JigQLT2aPoCsZUrO7DN3oRIQiikKQiCATtt+Jdm
	7yfLW4Jk2tYQvVK8mdCA4zwL+rGFSVgNetPP8+Z6A5LVHFvpLTShexJlDp3hlw==
ARC-Authentication-Results: i=1;
	rspamd-6597f9cdc7-s4knl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Language: 04822dd27daf3ceb_1750695833577_3327895371
X-MC-Loop-Signature: 1750695833577:2537051108
X-MC-Ingress-Time: 1750695833577
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.88.219 (trex/7.0.3);
	Mon, 23 Jun 2025 16:23:53 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4bQtgX32jpzGm;
	Mon, 23 Jun 2025 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750695833;
	bh=t5W8ONKKKLf0jew+m7GxsMvWNWb1Prto8MuI+EyMs0w=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=jowOR7cdXCI/XeRAjEPDZ3TCVBaEwgUxmy84ypVS/6auZ28/LoBDddzYdIKR8iQbu
	 MzYo+BmroVyl39ht9Ap2FdefsIfIRlCbRKH6SDhJa/fTh2C9nMGDv2wUTmWxiU7jBU
	 7YTdAMALf1SOL1rwJo4bbwbcasyG0aG6G1p/N3Rt7VzjSCPdvEt34d1a/JaDMwNoif
	 1H3+6tvULDEQqj8WAFhcyIXnbtpDnQqCJxdXRQUVToJWvp5zX1rshVkJzN027cW5py
	 wUti/4tAab1wR2rlyUCbqKpUC9JNT5d0Yurkl4bzPOzu84TpN0vss1O4t25zTn1j11
	 pkvMutzFNMjuw==
Date: Mon, 23 Jun 2025 09:23:49 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, jgroves@micron.com, ravis.opensrc@micron.com,
	fan.ni@samsung.com, anisa.su@samsung.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/7] cxl/pci: Lockless background synchronous polling
Message-ID: <20250623162349.hs23iinc5x2vgzhv@offworld>
References: <20250617193611.564668-1-dave@stgolabs.net>
 <20250617193611.564668-4-dave@stgolabs.net>
 <20250623152920.00005b6e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250623152920.00005b6e@huawei.com>
User-Agent: NeoMutt/20220429

On Mon, 23 Jun 2025, Jonathan Cameron wrote:

>On Tue, 17 Jun 2025 12:36:07 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:

>> @@ -411,11 +373,71 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>>			     struct cxl_mbox_cmd *cmd)
>>  {
>>	int rc;
>> +	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
>> +	struct device *dev = cxlds->dev;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>>
>>	mutex_lock(&cxl_mbox->mbox_mutex);
>Perhaps scoped_guard() appropriate here to avoid need to unlock explicitly
>in the error path.

I'm not too fond of these, but yeah, I will convert to the new wrappers as most
of the other lock calls in the cxl code base.
