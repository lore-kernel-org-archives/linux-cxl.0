Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04A53A394;
	Tue, 22 Sep 2026 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113222; cv=none; b=GP+H5CCYKQzfwvs7m/H+UM1MjtdY/n3HY4PV12NAZDwPUk7HU579OiXqUChKd8MKHX3j0E73jS4BzNoMxYPBmVnPQiHqtOvLH2cEsM0WNX8btsRsvBMf6Q/pr/PBCAeu16Gfla60gElDmEW8kAYR605w9yHWyQaEWH03yucQY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113222; c=relaxed/simple;
	bh=b52fxys5+JskWFAf5yl+wkNYs/t6huZQ1B0sIT8adqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7In8X5Ns+OFrikadI0kJc/4d7q1ahuRHox3vEiZ3KoESjhJmS0iqxta9F53rufy+3S4BDofH6NWXrACCYmlJ9hzOsZ78Izbl3dyTDNB+i/VThJ3fd+/Yi8hoAvdCYtiXvWXWWoi03EeZDJrx5iv7irymefSV5raX1lF3HkYgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XcygRiyS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XcygRiyS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E37EE4E41030;
	Tue, 22 Sep 2026 21:40:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9AF5C60580;
	Tue, 22 Sep 2026 21:40:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D16651032939F;
	Tue, 22 Sep 2026 23:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790113202; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6tyfnpYZ0mMFqiLM6eDkPIcq+fEPA8V61d4wvOUJZYA=;
	b=XcygRiySRCugVGdntLKKaLPhq08hFKAfBSGE+g7IkrLEAKLJW+Vs0F1HaGs3TxQrZN9Fh7
	SFtyqqM3FgrkkrWaIVC2FDC/Tj6oQMX+bnw3HFSw5VlVD7C29+dkyETL0IvYLMHVV071ps
	q4mFMpmT9QkgE14HfyMHfCXX44MIBK0rvr0mPigzwrNTw87OmAxio/ctkJcyabtwIfgY6B
	T8j1UUEBHmiQs3fZtmmPwQgbZUKYX2UIp2jmlbUu8E6VnG6bOWjPyuwqnvnbwEK7YV7L5g
	bc3HAFk46RhS3ftb+bqHgmx7LIfZupl7CYLVXwBTql+PybRIw4fNIEk/evshZg==
Message-ID: <2055ead9-201f-4878-aa09-07d7fc3ab3c2@bootlin.com>
Date: Tue, 22 Sep 2026 23:39:57 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] driver core: Rely on supplier driver binding at
 link creation
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-2-alucerop@amd.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260921191239.4249-2-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/21/26 21:12, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate between driver binding from PM dependency when a device
> link is created. Rely on the device being bound to a driver for validating
> the supplier as some device drivers could not support PM.
> 
> Check for supplier's PM state only if consumer specifies PM_RUNTIME flag.

Hmmm this patch seems to have broken pretty much all the boards I'm running that
boot with DT. I'm getting logs such as :

platform 16100000.serial: Failed to create device link (0x124) with supplier
  16000400.clock-controller

Some are just hanging at "Starting kernel..." from u-boot.

Then boards go silent as the uart dies, and I'm using that uart to access the
device's console :(

Found with a WIP stmmac runner for netdev CI.

Unfortunately I don't have much logs to share, as this just prevents the boards
from booting :( With this patch reverted, all boards boot fine

Maxime

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/base/core.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4c0c373998a1..eb6d87e35d76 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -834,15 +834,26 @@ struct device_link *device_link_add(struct device *consumer,
>  	device_pm_lock();
>  
>  	/*
> -	 * If the supplier has not been fully registered yet or there is a
> -	 * reverse (non-SYNC_STATE_ONLY) dependency between the consumer and
> -	 * the supplier already in the graph, return NULL. If the link is a
> -	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
> -	 * because it only affects sync_state() callbacks.
> +	 * If the supplier has not been fully registered yet with a driver
> +	 * return NULL.
>  	 */
> -	if (!device_pm_initialized(supplier)
> -	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
> -		  device_is_dependent(consumer, supplier))) {
> +	scoped_guard(device, supplier) {
> +		if (!device_is_bound(supplier)) {
> +			link = NULL;
> +			goto out;
> +		}
> +	}
> +	/*
> +	 * If consumer asks for PM to use the link and the supplier has not
> +	 * PM initialized, or if there is a reverse (non-SYNC_STATE_ONLY)
> +	 * dependency between the consumer and the supplier already in the
> +	 * graph, return NULL. If the link is a SYNC_STATE_ONLY link, we
> +	 * don't check for reverse dependencies because it only affects
> +	 * sync_state() callbacks.
> +	 */
> +	if (((flags & DL_FLAG_PM_RUNTIME) && !device_pm_initialized(supplier)) ||
> +	    (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
> +	     device_is_dependent(consumer, supplier))) {
>  		link = NULL;
>  		goto out;
>  	}

