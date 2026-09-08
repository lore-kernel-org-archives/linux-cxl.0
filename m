Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6B568FC9
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882410; cv=none; b=r4K4TQA9bjFSxHZYtbOCq0EiD5+uT0VZS59Gh36qgl+Ycf8E+oXCo5EGaRJUOGyonh+BRk+aq3M5SVJdqI9hsLALldy1bi1p0AXmFEOoabEawW8Ohoav6wcZZFYjnSX8v3YhQJLMy/YE1GimCRQVVjulc2cPHTNF1Ydw9je6BKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882410; c=relaxed/simple;
	bh=THg8c/lmmOXpjSROzMDkbZIesx4LuDCrSQEuGg65+YE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Cu7QQ/LNUvOSEcUBjGBKjrqY4nUMoQLb4sI7uxmjs4PnBz9PUdiT3Fbdkxc7Iuo4mt3KE6IN6bu5vfRuaZ1NQ46hGhyy7ayPRgSZ5/Yet5t0lzqYcgPoSpq9PJ+YRg2kELB6rjAzZswMZI95taMX3rTP55XNhUWSZcV8wSyTeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bKF3Wns5; arc=none smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bKF3Wns5"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4F16E62394;
	Tue, 08 Sep 2026 15:39:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.96.117.16])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F117860C8C;
	Tue, 08 Sep 2026 15:39:15 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Sponge: 6a802c8f1816a3c2_1788881956154_4018612535
X-MC-Loop-Signature: 1788881956154:1875415968
X-MC-Ingress-Time: 1788881956154
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.117.16 (trex/8.0.2);
	Tue, 08 Sep 2026 15:39:16 +0000
Received: from pdx1-roundcube53 (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4hfSm35B4hz104g;
	Tue,  8 Sep 2026 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788881955;
	bh=bNv4WjMFyf6lWt7vF5s199b0aYlxKGsv2llwjta4K0c=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=bKF3Wns5RsJB26XW1f5/B/47nxIQns6qx6cWYpbEnXFXzhVMKiVDxJiL2vZN9ibE4
	 qLM51EPV9440f5kS1o28L464ygfPdtI4jTeRouP91cEClO6tF37+gUd9ZWiXh7lTHm
	 SLMfwHqhdcxLu8XKZ0pLjYI8gh9e4rAIbwUALYWqR5HdzKVMmJAf0dU3gRLBTfKImC
	 csMYGQzowVaFXrwN2qa7ln9T2lwmvzHvjrHh5q3B1JHJFrvziJWsuyFr+B9iYFUokc
	 q3yzcJhfPpSZ9l0esQj/QKUtQMwDaKvs9j/rs+4fOghlmtAH/x1cXdkhox1zCJfKVx
	 iyvdVtBMFXVsg==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Sep 2026 08:39:15 -0700
From: dave@stgolabs.net
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, jic23@kernel.org,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
 Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, Wonjae Lee
 <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
 <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 1/8] cxl/mbox: Flag support for Dynamic
 Capacity Devices (DCD)
In-Reply-To: <20260908102124.2231730-3-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-3-anisa.su@samsung.com>
Message-ID: <e0643b7d483cd09fcb03b74ea5eea7c4@stgolabs.net>
X-Sender: dave@stgolabs.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-08 03:15, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Per the CXL 4.0 specification software must check the Command Effects
> Log (CEL) for dynamic capacity command support.
> 
> Detect support for the DCD commands while reading the CEL, including:
> 
> 	Get DC Config
> 	Get DC Extent List
> 	Add DC Response
> 	Release DC
> 
> Leave mds->dcd_supported false. Dynamic capacity is only usable once
> the driver can handle Add and Release Capacity events. Detect and log
> the capability here and let the commit which adds DCD event handling 
> set
> the flag.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
