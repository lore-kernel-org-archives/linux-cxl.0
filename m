Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1A25A341
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005686; cv=pass; b=UGN8Gz+wTzvsGr6Cn2GGXrq30ZCfpew14wyx7Ol288iXXWYNNe4VtuCEVUyYgNkZk69gmu5NIW6ELaMF6p6VJo8dH/vbnHQg2oGVK0JFay3ixaMRKRJAcd4szvpwAZGcb99JY5pif5T/AnXwdsUhoOSmfFrewn2fE35CTQSnl1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005686; c=relaxed/simple;
	bh=yqjsIRiHkwyCVm8b+TmA+rrF1NYQc5HFI0Os5vTb/ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLK1KFd4yDQeF7HNN0Wf09qfQPYmqJMbFygckhGO1To1ewND18DmdgFCXLRQPaPSPvTOxf2FX+y0cbmre174991yOQdkz/QjX2zjCb2pRfb3UYYckLwMI4LY7a16Z9wvTvzP2wpYtY3MHgDXj1pdx69Cd0fesG45Y1HcmFXXZTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=IEbiZRLd; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="IEbiZRLd"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9851D231B9;
	Wed, 19 Feb 2025 22:54:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a277.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.105.230.78])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 24AA12288E;
	Wed, 19 Feb 2025 22:54:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740005683; a=rsa-sha256;
	cv=none;
	b=yyIiqlfxo9ayi4GLyixi2/NKi4oZ2dQmo6oZ6PXcCKTitw0aZA2maEMIdGpzA2sNR9PAky
	sSyVVJ6HHZJaLWxy2/BT+/SZfFZ8Tv7UB2FdnkmrdZV7xJjB62x9x6fWTrJqB8BlD4WITf
	M8So8raMMcL/bA20ySSPSv5un/hyOsV5pqEaFBox/YGQdJ8ffYbzrMG9OvFVXsPt17NWF6
	vmIA9X7y2e8SOIQkNk30wceQWnLyyavXlYtfGEVCc7NiKhM469zMdsLabTKuEce0B/41cq
	7UBz1//nhalgTmYdYCAMDNL2gxkgvPmq9Ci8qvWRPybtoiWWZoMma2fCtI1W7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740005683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4J5q641sBAPXQyyQQ8ggPPgYSwh1QELGlNVLAn/LYM0=;
	b=TJcsyIpsAr7B/J9dX/xzWMQN+QbXVp3q4GPYo4kBWM0VvVO1D3Fxy1JSlDE5HNQqFWg0KN
	+1XHSAboRQy8h05N2bgTF/SbcT0D3QVlo+MCxM3gTD955C/nqwnJpwGyKrP0v4NZscnGCt
	bPNTDjp2ySI5RICeNTXaSLxrWEOeNkIesahXtNUMPZeczV/MOieT9I09ikz3YnCfwoiPgz
	R20vN5FRIfx4xO9FycXk/DtUfXDvCoyH9NV/NHMG1D13LuuzpwWIyTstrxxFn7EXHbhOgv
	qKwnOg4/+42JAu6Kct/R8m8bjoN7DPYhJJxUC15/hYpT0oMbTEag8Is171xHbg==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-hp8s9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Versed: 5c818d816b2cf3bd_1740005683434_1657288459
X-MC-Loop-Signature: 1740005683434:1096892101
X-MC-Ingress-Time: 1740005683434
Received: from pdx1-sub0-mail-a277.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.230.78 (trex/7.0.2);
	Wed, 19 Feb 2025 22:54:43 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a277.dreamhost.com (Postfix) with ESMTPSA id 4YysCk2h6Kz27;
	Wed, 19 Feb 2025 14:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740005683;
	bh=4J5q641sBAPXQyyQQ8ggPPgYSwh1QELGlNVLAn/LYM0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=IEbiZRLdmHHmbaSLAYIHpMU15Sm6Yw9QfL/mdXooiHC9TNwbcXgGg+BWoNQa4seIg
	 gAUhZ5Oexu4CDtOOhoeBTiWHsjMgglqeFHkwOLPFxTi7IxNAr7iDW3ZG/SSIAH58TR
	 sg7gSgMvVRr5xdoUjM96B6jjOkcJPkXvJslKf7TT7byZ1EO7UidouNv29HxLS9xTbA
	 9goHh20iUWsCtuJb1yfs0wW3TTPxOltqjOW6TTIjS+tA42aQxscn68+KiYp6iQjqrQ
	 bR7LzpoHFUpfjQlHLlPVNmJ7N57pcwV6hBWYB5Fbs6/G2ofnplqsrV/yxIqf0hPfYH
	 tSAz2Is0pWchQ==
Date: Wed, 19 Feb 2025 14:54:39 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
	a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
Message-ID: <20250219225439.4zyxfl6clvgzabnx@offworld>
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-2-dave@stgolabs.net>
 <0c2f9ba2-19f7-4014-9290-cdf9dc271934@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0c2f9ba2-19f7-4014-9290-cdf9dc271934@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 19 Feb 2025, Dave Jiang wrote:

>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index a5c65f79db18..2226cca3382d 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1072,6 +1072,27 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>  #define GPF_TIMEOUT_BASE_MAX 2
>>  #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
>>
>> +int cxl_gpf_get_dvsec(struct device *dev, bool port)
>
>Maybe consider enum instead of bool. That would make it more readable. if not, maybe rename the bool to is_port
>
>> +{
>> +	struct pci_dev *pdev;
>> +	int dvsec;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return -EINVAL;
>
>Since this function is mostly a wrapper for pci_find_dvsec_capability(), why not have it return type to be u16 and just return 0 here? That way when you check you only need to verify if it's 0 (failed).

I kind of wanted to not have a u16 return just because it was ugly for cxl general
calls, but yeah it is better to follow the pci call itself, given the name of this
cxl helper is *dvsec*.
