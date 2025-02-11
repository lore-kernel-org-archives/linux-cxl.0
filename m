Received: from dog.ash.relay.mailchannels.net (dog.ash.relay.mailchannels.net [23.83.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F02F5E
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739249966; cv=pass; b=sjANLv+97HaQMK9LICGFCdvSjTdXccJpxpRZZNP0ZvgC1E47IFMsNlndovHbDJnnL82p0dLHenEmucdt8m4GSGsw9bDvvpOxp/jWT1Fvg1+sWkodmuwe6q3PHE0T/Xt3CSzMv5+ItqPNpgJqXOCeuKvPsMI2r5P8ULd+C+yEI5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739249966; c=relaxed/simple;
	bh=icToHv6DyuP+tt5Rdj0vB9clUwfS3b9Da/w2RN9LWTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpMGbuTvLy51/R0xOE4Yqp9a4CoSAriALqsVNe50R41qHACDOMxWyJJRSppNfPMbAUrKcQ24zS4ChpQWDzjENdHnz2A7eJUjBpVkdT1YbofOJSMHxJYtDDNkd+AWHwFqJWYDVZPWttdArVuBc2ecBR1/XzNXBJA+QhfpFZb1nfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=AAbdbCfN; arc=pass smtp.client-ip=23.83.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="AAbdbCfN"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 22C982C31B0;
	Tue, 11 Feb 2025 04:50:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a260.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.96.47.154])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AF41A2C2201;
	Tue, 11 Feb 2025 04:50:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739249420; a=rsa-sha256;
	cv=none;
	b=F90BDzuw7dIA64OCV3bvpiisT3wFFR+YjliJkZTGAt5cbJZnEgsGh5fLlGmkwQwgc0r89g
	WvrqMaTw2ZOtUnv6a193ZdA3ZvYQXkuyzsJckZgs4LKAbIiiLZIaEKYiG0xlIdP0oMKEFH
	mxI9jKyO1LLT2239q+/ATtyFqsEExWlUztkemj+Gz81OoxB4o1BJgA/i4mRIfIi/RNwRyK
	tkpxAVjumv5osLeBOTTB5fA88w/5FJS54L7TSI6NbEFquNSuLp7oNOfO5K8XoLVfzqw35G
	Tncxq/8dpMLeT+3w2yT4Dem67gM3+q2k/4h40W8UR4DYJVHmSSgjs7dx11BYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739249420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ouSUyKmRDBIQmcePaaKToy2HuUWehiXKWZmXlFkQSzQ=;
	b=qlgRFnP6PNgicvrVevXbGfrbnvHQTtqQQSqI93qZuopE3P1+h+Rg8GCe7Dh4zJbaD5IwDE
	JBqf8F8heZOtQ6y2oQXh0d1/oMzJbCU2TSj8irGOOiwbkK1AoFWqFoNOgpxIoS0vLtoGIi
	jT62pSlPexD1qpHEar36BRGjE6rvNqVZOr8HCyFb1+kFqWtkDEnfsVrlz3IjBY8lc+o890
	4go8uFqx3zSHAkg2fPOgdMnKdVH/mF5IdTVnYQEPdBzPprFqgxAe1OknbZSvq2JQ8hpjIk
	a4txDeideVm7DMLK4Nw0xq5Fm0Lrp57Gj5EM1iopM7+uZ2JvwWnyVUddVcm5Bw==
ARC-Authentication-Results: i=1;
	rspamd-68c88d6cff-k76r7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Inform-Occur: 05cd7e570b5d2a47_1739249420996_1351363772
X-MC-Loop-Signature: 1739249420996:1532375133
X-MC-Ingress-Time: 1739249420996
Received: from pdx1-sub0-mail-a260.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.47.154 (trex/7.0.2);
	Tue, 11 Feb 2025 04:50:20 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a260.dreamhost.com (Postfix) with ESMTPSA id 4YsTXC6Pxyz2C;
	Mon, 10 Feb 2025 20:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739249420;
	bh=ouSUyKmRDBIQmcePaaKToy2HuUWehiXKWZmXlFkQSzQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=AAbdbCfNpynvNi2W3hWuVqH8clYoUnO/dHNBXQMch3vle7fpQ7/+olFhP5gfXPTLu
	 ZyDgJF2YD3VG8b0XFyr26Q4IivCpXKJGy+Wrk7pjWFjrv+tVX3kgtCv2GswCxVpBib
	 H2BM0FWk/JW4eEhyIVeWZ+7pKpEJYI5sfc4LFNBJKfXx4ax/p1Of5iaj185LOjpy2i
	 pE8JWRELfbclHftb0gKmBrzwaUGlONvcSRiasK6oDh61OBXk/qQg9sN7wCcKWzL2JG
	 IAG18obO0cODElX3fwH6hLAhQGrtl3fI9XwZ8gAFIDjeK4zNd0fG0FL5NTTRUQzIFl
	 wUIQejTuyN/NA==
Date: Mon, 10 Feb 2025 20:50:16 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
	a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/pmem: Export dirty shutdown count via sysfs
Message-ID: <20250211045016.d4erlklhps5rud2b@offworld>
References: <20250205040842.1253616-1-dave@stgolabs.net>
 <20250205040842.1253616-2-dave@stgolabs.net>
 <49bf1136-c4b5-4c25-8b3f-2b9f68e23983@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <49bf1136-c4b5-4c25-8b3f-2b9f68e23983@intel.com>
User-Agent: NeoMutt/20220429

On Mon, 10 Feb 2025, Dave Jiang wrote:

>On 2/4/25 9:08 PM, Davidlohr Bueso wrote:
>> @@ -542,6 +542,7 @@ struct cxl_nvdimm {
>>	struct device dev;
>>	struct cxl_memdev *cxlmd;
>>	u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
>> +	long dirty_shutdown;
>
>Maybe consider using u64 and call it 'dirty_shutdowns'?

Imo signed type having -1 is more natural - are there any benefits in
it being u64?

Thanks,
Davidlohr
