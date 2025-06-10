Received: from dormouse.ash.relay.mailchannels.net (dormouse.ash.relay.mailchannels.net [23.83.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791B256C6A;
	Tue, 10 Jun 2025 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588060; cv=pass; b=MbSKuMImeZcPcd3lhxBjQrdcOVdNFqIZGf5KzhYdEj0Ejr48jw4utl4XNWwhf0sKugl74/KCAaAuDcqT1yLjRFdDyCi+heb35ZXB+a2wd/abbbXYf6hcE8lcmjiTnuxRmjmFalfhTKNcpmmnanqDW5C/RElm8AIqwlEyUkrdK0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588060; c=relaxed/simple;
	bh=o9t7FqLzFvxHHpOha7UUMZZqiLDQPigEcRB2/MGyrxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1jMx338hs9YMxPjylN9C63zMe1R2ayokR1ygD0bw9xe3OkiUVncqQwZLed+syjvo8D9udrbQNSZ9iZN8bOYHUOKG070aXtvsKF1RXWjVoFvt95ldQA1DRQP8FFtI+PqxSMkequAyiywkrOtTsMxCSijfBB/JGaxHnepLdDiGuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LtOseHEc; arc=pass smtp.client-ip=23.83.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LtOseHEc"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4A4D14364F;
	Tue, 10 Jun 2025 16:13:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.96.51.16])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B0ACF468CB;
	Tue, 10 Jun 2025 16:13:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1749572021; a=rsa-sha256;
	cv=none;
	b=XvZ5pMoQicka++te5lm4x8vBqrSJTERiScsocvvCGT2Fx9WIJAJ6/b4jUrFu2OjO9TR0qi
	fD8nsejgI3qg9nOKY2re/KDkDIOiTgkVVPx44pWq/bkp5uZMSEoaix7qLLFum1jSfMVnrk
	pTHyz2P4qMxwxOauOp0TrTZYanO9yU6zO62gGZHeXAO0ctc5K0sRNgH4chk3s6JDtwFAwc
	K+cZq/qfreQx3Unj/DQnsCW1xQZrNbdPSLb2dau7mK30lgfgwgvHLniXnJsJxSerj7heBl
	A8gF3DrwseW7oLpP4H1Cdk3+xzLCgpAw0G4hKOER5UYsBHv4gGG49Iu+EbTalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1749572021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=o9t7FqLzFvxHHpOha7UUMZZqiLDQPigEcRB2/MGyrxk=;
	b=OAUdg6AhIno0ww+HxdI+IRAzKQR/zhQdG6qz7+EWz23yhYxY2q2tjHzf2KHUItCvvejf/2
	m4cTCPKe03QpwT96HL+cfsqd5iPGwK5EVarTfQ7O6Kq9PzyA5r/O2OzykYN0amTQUkZZ+j
	EzIiv886U8JmW1d2xsySkFFP7JQ8lMmDCMh9m8ehlKED52U0CwZ7kdmutsWeTRNe4/3Qos
	XeYhQR9S/iQ3GwC+lRdYuUjMcN9v6KxDlvWCN54H8nfR/Iebe2oJb0hgD6oMdEBwnjazDz
	xSRK73t1WZLKOCWo6g6yA18uJ1SF79+67SJQxjcs7KU8wxlQ/e6v7XnQDqXmSg==
ARC-Authentication-Results: i=1;
	rspamd-95f6fbf49-p8844;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Drop-Skirt: 67fb536c4809e9a5_1749572022122_4266410149
X-MC-Loop-Signature: 1749572022122:968453729
X-MC-Ingress-Time: 1749572022122
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.51.16 (trex/7.0.3);
	Tue, 10 Jun 2025 16:13:42 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4bGv3n0QVVz58;
	Tue, 10 Jun 2025 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1749572021;
	bh=o9t7FqLzFvxHHpOha7UUMZZqiLDQPigEcRB2/MGyrxk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LtOseHEcT/kUOoniFAQN1+8X+GzZ2PjZ2LvqCmSaIYUc51jw/uGYhzOJA17OxG3qI
	 Q8PIIIqCV47BMUmgLaJGWK2aJFM55Ydy9x0aYm9rAmAi/3xe6V0FEjwsyB1eXh5YBE
	 0dBGWdEfuaAq6riWaQ54NHWFiP5QB1LQdZTOtRrHZO2zM5fgHkBPYCL5et1xaEzQpq
	 Ae7YHt+GMXEs51lGVBzdcqE3ulLb5o/g+sc1eRj4zPZVid4OY54vDOSSn8oIRSqyfY
	 gF0GNlQYMllcKatv6i9Yx9dfhirgtlBktw+Plw5QHPpTibNtjY9sMtDyQm1o16LG3O
	 U+qfI5aERBF1Q==
Date: Tue, 10 Jun 2025 09:13:38 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Message-ID: <20250610161338.lft3ekqnk4u6dxls@offworld>
References: <20250603104314.25569-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250603104314.25569-1-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Tue, 03 Jun 2025, Li Ming wrote:

>When trying to update the scrub_cycle value of a cxl region, which means
>updating the scrub_cycle value of each memdev under a cxl region. cxl
>driver needs to guarantee the new scrub_cycle value is greater than the
>min_scrub_cycle value of a memdev, otherwise the updating operation will
>fail(Per Table 8-223 in CXL r3.2 section 8.2.10.9.11.1).
>
>Current implementation logic of getting the min_scrub_cycle value of a
>cxl region is that getting the min_scrub_cycle value of each memdevs
>under the cxl region, then using the minimum min_scrub_cycle value as
>the region's min_scrub_cycle. Checking if the new scrub_cycle value is
>greater than this value. If yes, updating the new scrub_cycle value to
>each memdevs. The issue is that the new scrub_cycle value is possibly
>greater than the minimum min_scrub_cycle value of all memdevs but less
>than the maximum min_scrub_cycle value of all memdevs if memdevs have
>a different min_scrub_cycle value. The updating operation will always
>fail on these memdevs which have a greater min_scrub_cycle than the new
>scrub_cycle.
>
>The correct implementation logic is to get the maximum value of these
>memdevs' min_scrub_cycle, check if the new scrub_cycle value is greater
>than the value. If yes, the new scrub_cycle value is fit for the region.
>
>The change also impacts the result of
>cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
>minimum min_scrub_cycle value among all memdevs under the region before
>the change. The interface will return the maximum min_scrub_cycle value
>among all memdevs under the region with the change.
>
>Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
