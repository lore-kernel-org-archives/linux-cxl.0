Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C2190692;
	Sun,  6 Apr 2025 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743966849; cv=pass; b=dAm4kMB9Pu6JfhALQ0VKpalVUC2T6hAUVEOmIZOMUsSOUOru6SS+1DFl0MNtEt6tZn2BuFccMPA5cp1oBHIcmFOaXsi/AyR1ZucJQkkTjPY2rG0CVh45cVIMFjVunDaWHLBu3MAkygnn5gI/HZmwdjEqo0pYMzwcvU08v2NM45o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743966849; c=relaxed/simple;
	bh=Y2GbXLOwe5a/rqQp/6gOCQwxx+OAJlbXTpNlktEBJHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTh3phIg1A6hhxiBRkIKlU/eqk8XN1MNxQcI8M3YfqLhkCw//ZUJ8RKs9/+8kj0AtleJodZrRcdrQARBOj04DDmUs+2eyyG+zsZEZQQQOX9SVMyF0bcp6X4C13DBZmyGJrBlNHiWKdDZT1PSDs7zEbpp5zXrr/vjpVpM1bU7zfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SIgatG//; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SIgatG//"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0BCC74E4835;
	Sun,  6 Apr 2025 18:38:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.102.53.226])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7AF6A4E2EF0;
	Sun,  6 Apr 2025 18:38:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743964688; a=rsa-sha256;
	cv=none;
	b=Jk1xitNFDhVgluAjw9ZFa7KfE/Q1jedhlCB/K2VXp6lBfqm3dBnMb1kUEkJi6Gdt13OWnm
	ewMBg9Qd2lWvfu48noEwKacqbyFFaoadIbQhTQvuvmnu/xhcNHN4kHwydEi5luaZ1wem5Q
	5wscbzxEKkFEao0QPf2XV+HFrL77nrT3msoCgnRb1a0/09b9aJR5LPvrB2VhFoodE5I8KA
	YocCW77bYJaSL9ndoU+pGhLJPYPz4in/756OpJI1KB0OekimCtmyD8H2XbE2E6v9GmI36q
	IeK3KrbwsQtWIQw7KAgkluquM245BJZLP17+A/XgBJ3+ZLkeRFqkWo7G5N06XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743964688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ORCy7vWxAqIbjJeErXKRRHh0IsWN6J/Vj6qq04Os5xo=;
	b=7U7/2JRciV9iEu8iNHe3oKWAssCkYHKHyt+/mOGQojcZBUxY2KXy/GqYinQGkmh1WmgkKT
	yL7cQMDAdxbnKixaalcrnW1/zVjeD99fZSPisHQlt25PLGMLwmysyQJS0In0gtwmsj2sVy
	Vc0nGs+hUriGJoO6eQubby16Ua+L0Wi/JDTmSK2PCoKy2bGJsw3s7ZM8Uvuot/xUL3uXuT
	DxrNXxh9OgZCQGbLcWbGZbAHv0OYZrsDQ3qBN14pnd8GNWcfb368L7YTmuSGMkglBFu18T
	3giuQxnZssJYmykoX1J/UoejXLugqIQvFag8xCufZzaTCjn7tw6Yx1Rn9B6SlA==
ARC-Authentication-Results: i=1;
	rspamd-7dd6dcd7db-2wrq9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Attack: 31d28f8211fe24be_1743964688791_3570648381
X-MC-Loop-Signature: 1743964688791:2003078220
X-MC-Ingress-Time: 1743964688791
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.53.226 (trex/7.0.3);
	Sun, 06 Apr 2025 18:38:08 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4ZW1LR6F9nz8t;
	Sun,  6 Apr 2025 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1743964688;
	bh=ORCy7vWxAqIbjJeErXKRRHh0IsWN6J/Vj6qq04Os5xo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=SIgatG//bcSoHEk4WuW+ZcZJlyK6jNd18V7y8uNPcmLMpR1qufWDWYHg17YfJHSS+
	 oUGEDYwAQZK+hvdCcfJy92ewjl+rxaBUKZrY6bjKBYT7vujvhGdRayEOL5NI3sstRK
	 3FBXORtlh9SqesyHIaZJ9e72jM36N2Qbe/UO66F4RRBe6VlcoAE+730X8IlekdUaKe
	 v6Mj5LCf6+XWP5KYQKH46GdwLv9keil0aTTQSJZUhvjwkuaijhZiTkQDT0LQoEwc7P
	 o9zvrT+X7n0T6MdJXS8YIch+twsmWyojOYojR8To4v7EsSAYbyDMe8hbTGbyXHV/yr
	 qFAghiLHTqj5g==
Date: Sun, 6 Apr 2025 11:38:04 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Message-ID: <20250406183804.wvrnuahoszefhgj5@offworld>
References: <20250402232552.999634-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250402232552.999634-1-gourry@gourry.net>
User-Agent: NeoMutt/20220429

On Wed, 02 Apr 2025, Gregory Price wrote:

>When validating decoder IW/IG when setting up regions, the granularity
>is irrelevant when iw=1 - all accesses will always route to the only
>target anyway - so all ig values are "correct". Loosen the requirement
>that `ig = (parent_iw * parent_ig)` when iw=1.
>
>On some Zen5 platforms, the platform BIOS specifies a 256-byte
>interleave granularity window for host bridges when there is only
>one target downstream.  This leads to Linux rejecting the configuration
>of a region with a x2 root with two x1 hostbridges.
>
>Decoder Programming:
>   root - iw:2 ig:256
>   hb1  - iw:1 ig:256  (Linux expects 512)
>   hb2  - iw:1 ig:256  (Linux expects 512)
>   ep1  - iw:2 ig:256
>   ep2  - iw:2 ig:256
>
>This change allows all decoders downstream of a passthrough decoder to
>also be configured as passthrough (iw:1 ig:X), but still disallows
>downstream decoders from applying subsequent interleaves.
>
>e.g. in the above example if there was another decoder south of hb1
>attempting to interleave 2 endpoints - Linux would enforce hb1.ig=512
>because the southern decoder would have iw:2 and require ig=pig*piw.
>
>Signed-off-by: Gregory Price <gourry@gourry.net>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
