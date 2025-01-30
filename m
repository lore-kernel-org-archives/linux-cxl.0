Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65779D2;
	Thu, 30 Jan 2025 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196769; cv=pass; b=O/Vph63mEE2JLDGb3S+1FqwS3wNaMmDGx96wpbGXTZkyrBmDhDqCJ0v7ey1fLTDdBOEvBc7ALtuFUG28FFMgvwydx6OzUjZRdCh+keDeOajlzkSa2ND2nTkDDjkpZEMU1Yo2CogDmIq0AecppRlpo5ZCsmqUNTqfbYJOuMGGGyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196769; c=relaxed/simple;
	bh=zyL1FXZ3ilKcMxDzvA88yimgZ4vmF7NZRW1Luv4cv50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxT1vCXO0fkz1sN9EwBVC94mqI4jL3AqTHRJweRKpVd0MyKt4jD9bAlEby1v7Iy3ACqFZl8x9uyA0yRRaclieCFZ0AG3AwJM3DEwURi1RyFVVzFGpmYbvc0tnUZeUqE20y8T5kfZaKCwJnsPosqgFVn5aUCWdpUqf28X8pkqQwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=P+BSPGx7; arc=pass smtp.client-ip=23.83.218.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="P+BSPGx7"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 742AB24299;
	Thu, 30 Jan 2025 00:15:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (100-116-64-196.trex-nlb.outbound.svc.cluster.local [100.116.64.196])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5A1F6241DD;
	Thu, 30 Jan 2025 00:15:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738196153; a=rsa-sha256;
	cv=none;
	b=Rezd8LutXudnLtUe9UG/b+XNzfJeZ7aGVwosT8IfQCzaTkQTMhCVgtZfphILR8/7AeEGUN
	zof4gUf14aClR0JBq3YEQYioQp12UbIxbruGldZ1TR2V8xIWskHze5/LVTdxX0jkbx706s
	D51ISgf4mVxgAPCkO+1KT0jrZBYasp/pWOggrwTWl7Pif782MarfDCzeoAi1daRhWbeXQf
	tEnrDL3qlroEcpZcKjWI7W4MmVhXMPJFJRi4qvPEH5MrlxZV8GGvsQmX7L3PPWaS/ZKF50
	Yj+kmUywmBgfNVUNNd9Mco4HoM6dVZQSNFJnPiqkPYiYeDQU8EmunTcW+a/sFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738196153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tjE/2zHsO+ejHCnERSc8q97eewLtwPYiDgRw3pVgUTI=;
	b=s5G7q8nGhgQM78KvJQDiQehz6/gNJ0qbWa1tlcUU79Emv8br2dGEk4sM0R3EKFuJh++jj3
	/Ff2b7jIrgsJviElfx3MX5R63ZNqfEQTssQ1dXbc+k7ORtbyebAJVyDasdrhPz7UKfkvG+
	Ap6kr0+JVzjZH4XCLOjXt9ShSKYb9/5UbpKleai09ZC+SpQtrXTXEsCOLGzUmc5sXZiDLQ
	Hz8/ne3Ypwnn7DNOv1xP4NTMaExP4lA6PDCCx2xNUw4G4DvU/rm74Tnfg1B0dA1FPGiL6H
	FyT8LFvj9gxQF6sSKFM96Tm/QMIGt0/bGNFCW0284qT81teTzQb/hWK9VwVQ3Q==
ARC-Authentication-Results: i=1;
	rspamd-8586946c78-gbxbr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-Abortive: 1db234a2242799b2_1738196153649_911084047
X-MC-Loop-Signature: 1738196153649:1408816590
X-MC-Ingress-Time: 1738196153649
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.64.196 (trex/7.0.2);
	Thu, 30 Jan 2025 00:15:53 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4Yk0144j9hz2G;
	Wed, 29 Jan 2025 16:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738196153;
	bh=tjE/2zHsO+ejHCnERSc8q97eewLtwPYiDgRw3pVgUTI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=P+BSPGx72xgPia4aR7934FrNQ8eHxvsyUh0os+ohy2jFz5EXUcelNphHVRlIZT6qo
	 epfD4EmprdGX5xQePhUXuX/xLXwEsH3+cangS0FnfK57w0DlvPAkxy0IbD5Dlt763k
	 oBvRsT4D7FpbCbvpafLcYkKrztp7Qt0ldjfa6i8mUvoEjJ6Bea7uFeretFJOTsIrcK
	 +281NIegqaTFfyerHxpHWO4DLCteYagqEnDTCi/86ZNn5Gss3/q8j3fkh2TAg7FOVm
	 oSdGAJb0OADBkUBRt15vPZRW5iS9LgHsMxNVnwwJG8K/VOjd+Tw2yCVJjKp25XJrv1
	 hmY/wMs4gq6Dw==
Date: Wed, 29 Jan 2025 16:15:49 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Message-ID: <20250130001549.xtvbvgzma43sn6dj@offworld>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 28 Jan 2025, Ira Weiny wrote:

>As was mentioned by Dan[1] cxl_memdev_state stores values which are only
>used during device probe.  This clutters the data structure and is a
>hindrance on code maintenance.  Those values are best handled with
>temporary variables.
>
>Adjust the query of memory devices to read byte sizes in one call which
>takes partition information into account.  Use the values to create
>partitions for device state initialization.  Take care to separate the
>mailbox queries from the initialization of device state to steer the
>mbox code toward taking mailbox objects rather than memdev states.
>Update spec references while changing these calls.
>
>Link: https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/ [1]
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
