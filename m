Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5323EAB4
	for <linux-cxl@vger.kernel.org>; Mon,  9 Feb 2026 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663542; cv=pass; b=NdszgQmIGKxT+3BH5MafLXIJBdpSEHdqzV3IwzhN9Q6elI9EKLPxClEFbpafTeUYVRVv2mLOyzI2yBD7lyLOiLxP1Z/U2sYCI0t5cBMJWQNb8/lLwjiypr4acI+EjCs9kpIR3n3DAmhfR9IJGfmzJJTjaZdeoq+QeLIL6EoMySM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663542; c=relaxed/simple;
	bh=7yqe+6rUGG/+7YqPjfm2qSiTq20o4X05IN/5OCY2nDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0tUbWSUw7izKzwhZ9k3BgmR8E9P8X41d1iuvzguoUqgWNxIZzggwYosWaimlATSEojfu5sLDfhW43iiZX2SOf2BmR+Ym6BvFW12dvV9RZuGcR+c+06QhUHmssBbmsTslngGmJn3BFg11aQl7l6YgyhiMeWhMQ10EvUyzGeiWZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ofpoQugR; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ofpoQugR"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 106E17E1070;
	Mon, 09 Feb 2026 18:59:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.123.73.68])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8BD137E239A;
	Mon, 09 Feb 2026 18:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770663540;
	b=48p8y0wOpA/Q/C1c25g1+nC1mJINy2aIyNy3wqWp4Ro4yx7ga4Ov4khuZGE1aGnFGwJDCT
	uVdC8E2d/sJWMTNJBuTWBHIo5dpzyVy9oSj03CYy/N2BASPssXD2LIRJQ/6HuhbnO/WyJY
	PWRcZq7zvGgtcXp2Yx1Lv8OYp46mvvglnLre7E2UCyGkS8/250fzLLJU0aHVdfKzsqxVv8
	cMdnHKbT3uTT3ldlwz5t+R6UPaD30sbf7A1GNTKpdGZ6YGMhjE5paxO1A1SuItrdIfA3zM
	MYKjtX7pq69qY+N6GGos6/5glwgTBz1zVEDI8W0ltiD7dHZLMkC0m4ZfQQvisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770663540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JsX+m3XvOXkiSPu5/uTMj5v2Q2vkOl5XoIn1c7hccwo=;
	b=fZOwk5ZTg7zf/RkhvfMwFyer0pkdcizkFKx/u8EmtDQjOTdIPj3In/9/r1ZNg/h99k0gmM
	jwZ7SEqapkNWxA9qaIELp/TnZRpx23svq81OYH/MJ/NugWAHSDcPJhLEEPGYr3CFqXYfQf
	MLM0JRHxcfTS2PqQzPqGYaQrCuJioY6bUjGI8uSGG8l+wKkdf3VoKehaQUrii4uAtCqOZW
	kajHj2+Uq5Yw2NkH2V+bvyKNGrUUHmX5zp971lS5T8cSy+ilxZ48QE795QMIXwMNQlFf69
	LyscbAsPTh1bcsTNW/8yveM9tYF6jNZGa6j8Izn/PEFXh1/rJT4kO4S5TpnD0w==
ARC-Authentication-Results: i=1;
	rspamd-79bdc9947c-fcvhn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Exultant: 3547b2d724871b49_1770663540868_1040426884
X-MC-Loop-Signature: 1770663540868:3074538697
X-MC-Ingress-Time: 1770663540868
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.73.68 (trex/7.1.3);
	Mon, 09 Feb 2026 18:59:00 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4f8v9v4rvHzSM;
	Mon,  9 Feb 2026 10:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1770663540;
	bh=JsX+m3XvOXkiSPu5/uTMj5v2Q2vkOl5XoIn1c7hccwo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ofpoQugRDTdf4/NQYk2bZ99gcXtwGh9Y+xM1Y7OrI23kGuujHcaBebjDxRT6Iyn7P
	 WXOqbV99tc5Dglx3ONqQi+fIdJGbMQYzD9P1phXK6+gjbaK6kF4kDximOoySrDTgNm
	 T7k+ukphWLdstgIjk84nkr3167m0qe+Y99hCdO0ChL2M7kd86Ukgtj5icHD78F5+d0
	 X6TKZDvrfi9BdDvEYryY+4vx0922nHuvyylNiCeS7GwxQiyvl3M66/n4LgvBVJMKj6
	 zBhvAhAAbZbdXDlPC7piYwvSCDF2Os9xlabkmt1DOfRhfAmUQQRF4jQTIkkeY45+Lt
	 /Bv5Mx51a9SPQ==
Date: Mon, 9 Feb 2026 10:58:41 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jonathan.cameron@huawei.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix leakage in __construct_region()
Message-ID: <20260209185841.qewzgboej5ynlbzl@offworld>
References: <20260202191330.245608-1-dave@stgolabs.net>
 <aYEegA8hNKF0NxuE@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aYEegA8hNKF0NxuE@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Mon, 02 Feb 2026, Alison Schofield wrote:

>On Mon, Feb 02, 2026 at 11:13:30AM -0800, Davidlohr Bueso wrote:
>> Failing the first sysfs_update_group() needs to explicitly
>> kfree the resource as it is too early for cxl_region_iomem_release()
>> to do so.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  drivers/cxl/core/region.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 96888d87a8df..28d70497283d 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3795,8 +3795,10 @@ static int __construct_region(struct cxl_region *cxlr,
>>	}
>>
>>	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
>> -	if (rc)
>> +	if (rc) {
>> +		kfree(res);
>>		return rc;
>> +	}
>
>
>Can sysfs_update_group()  be done earlier in __construct_region,
>before resource is allocated?

I don't think so, extended_linear_cache_size is part of cxl_region_attrs.

Thanks,
Davidlohr
