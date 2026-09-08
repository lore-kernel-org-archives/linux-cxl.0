Received: from duck.ash.relay.mailchannels.net (duck.ash.relay.mailchannels.net [23.83.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D94572683
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884685; cv=none; b=MY1NkaItP1ChyjfLMsPUVsnh+DrcWQV91dKnkj5TJzhGtZDhBll8HUoeB9KJwaEHvTnGCVi6Pt21QmqHJp4LLTTtwehz0OBZpDJLNbhr4fMmZ9c5V5UAmEDsggx5JeEumJmOxUhAfpVG0Cx7Yo53bD2WxVKgbYMmAyq9Q/HeLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884685; c=relaxed/simple;
	bh=SK0a2l/yQynZqWw+Q06KhjiC7DXDKBaYOl8grMfW560=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GUEjtB9pmd1lDz8lklejXMCGqP3DWFW1n2/8q6RRu+7cB7z2zHsWsOKk6HmtrOpjw5yb1KgopogSuorl7/Iv3rIpP4T5jlL5QNC9J2U7C9rVlUJ/4iTglNRo1bhybgcP0m4e/qRloeQjVV7z5lMOchoxu+mQTRVfDBCQIhw0yPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=RPnMjMvT; arc=none smtp.client-ip=23.83.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="RPnMjMvT"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6D7227E247D;
	Tue, 08 Sep 2026 15:59:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.96.169.19])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 187DF7E23B2;
	Tue, 08 Sep 2026 15:59:44 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Tangy: 55b6d0445f41d7c1_1788883184238_2828016756
X-MC-Loop-Signature: 1788883184238:2825143927
X-MC-Ingress-Time: 1788883184237
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.169.19 (trex/8.0.2);
	Tue, 08 Sep 2026 15:59:44 +0000
Received: from pdx1-roundcube52 (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4hfTCg63W4zymb;
	Tue,  8 Sep 2026 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788883183;
	bh=x6gT7Yccobhszk1vAigkl/EeB11SNKz/Fv5T+PytT/s=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=RPnMjMvTZMaQHGpJcsqm/66sTA2Ke0/4MApaaNHQNLoeUuSWM2s2xjroCNxMrmpD7
	 BN1gTYmuPaaMctcHJUQ/BnZBldNYzOxKj6r6fqMrveFHLRzDMfguKAug4yCzUs7icD
	 ES0zu2HZCEDGshrDVOgUEdcjKqgFvz5W+dMKu07/yIkfpkM4n7ji2ZQE15/xzoGh+t
	 57BLssps30xRGBICq7SZFYilBVJ38cWcqv892GvMeABR3d3QCRc3JMLwRUmeOKJvNd
	 0kmURPs27uSdjvckB2qZ/8pwJhPrHyYY4BfVlEd8WlDfqeSCXjApZn7K1Q3s8+fiaw
	 6e7Wsm/XCmaYw==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Sep 2026 08:59:43 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, jic23@kernel.org,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
 Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, Wonjae Lee
 <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
 <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
In-Reply-To: <20260908102124.2231730-4-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-4-anisa.su@samsung.com>
Message-ID: <9377f4f5e3c5a0330fe2cdba04c6091d@stgolabs.net>
X-Sender: dave@stgolabs.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-08 03:15, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Devices which support Dynamic Capacity (DC) are configured
> via mailbox commands. CXL r4.0 section 9.13.3 requires the host to 
> issue
> the Get DC Configuration command in order to properly configure DCDs.
> 
> Implement the DC mailbox commands as specified in CXL 4.0 section
> 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information. Disable DCD if an invalid configuration is found.
> 
> Linux has no support for more than one dynamic capacity partition. Read
> all the partitions the device reports but validate only the first, and
> configure it as 'dynamic ram 1'.
> 
> The specification requires that volatile capacity starts at DPA 0 and 
> pmem
> starts at the DPA immediately following it, but DC partitions only need
> to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 
> 8-347.
> So a device could leave a gap between ram/pmem (static) capacity and 
> its first
> DC partition, or between one DC partition and the next.
> 
> However, Linux follows the precedent set by PMEM/RAM partitions and 
> requires the
> first DC partition to begin at the DPA immediately following static
> capacity.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
