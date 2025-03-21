Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312F208A7;
	Fri, 21 Mar 2025 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524462; cv=pass; b=UgNgbGufOK+nmUvb6/4ywGW5XBc47/3+NCcYbdi5u+z/PHy/AJq+xrOGqhU1QHVM3NiEzS6I/SK96myvTowWGREtPxIJd/y9GSDD3BAD/KVlslN8Ssv0kLos0L4KiqSA4/1wHksnRcE6Ssum+vzGk1bmAqS5ZO/hvSpcT16Hq7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524462; c=relaxed/simple;
	bh=hZXi0UZd5qs65yJy2Fr/zycLpmzQdjI05wB+uU6qyjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX20fM91WnC6eMYm2vKWfgTN9YwTMboeFbjXK7/IoDTTclSa/HbSum6ZxV26M4URAdlw3HUULB49pPwLurvk2GqSeilewnydyIYE8L0UR+ULNTvZZxvCr3x9e1dOt9NwAPgx2/pO4HwpIqrxnK0+D75mWQddtWzWcKZe52PyXbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lW9RqoA8; arc=pass smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lW9RqoA8"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EF9933222C9;
	Fri, 21 Mar 2025 02:14:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (100-114-54-169.trex-nlb.outbound.svc.cluster.local [100.114.54.169])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 657AD322033;
	Fri, 21 Mar 2025 02:14:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742523285; a=rsa-sha256;
	cv=none;
	b=HujqnApNF73sKMFZX3jMarr0MjXmn9Jh7L5AsqLLBw9D4DDbW2m2a/mJPScR/kH28Vx8mt
	jN/UY5oAnQoRZS+rmFfydigSyE0pFuK0NBwKdZiEHrEwOinIK6kAivo7cUTPgDkOF5CP3i
	Oa4IT/WAH0NqaYC5/EAFAgEeI/WjSuaIK4nvtw4GDkkChAJhX8ahJ+5dSMOO0aVVsxSqpN
	69ung1i0EYprZcR4Uz7jX8cKg36/9NVE5xMWVj66yT2pFd7IUwdxw3jDScuZDQut5LgfAw
	tgdyIksYgH/c5qZIqGTVA3c2ntpAhIFTFM4DQESForElKfRJxBNffGPh4eQfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742523285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hZXi0UZd5qs65yJy2Fr/zycLpmzQdjI05wB+uU6qyjE=;
	b=HbBCpAuBlZKgmKDSAOxvVO9LEwGdBHJnTqzjLr2Xr9MU0rFDofiIw+74t9dzbGcVa0i64d
	yBbx1Ns1T7onSti4Aq1NtYxPz3TjKGqQ4mgqkiAJ3TLsdYb2pUJwmntRErQBpLAFbxeS61
	yJrdsr8rb3n0eWku3ZWN7zy9lbvE1vsmr4s9fv/ALEhTpKixh3k7H93sw+Xe0xoypy913h
	jraHDP3EVttyo/5jgpNLWyUK6A8bHOB6hP3k50XM04nxyp1pPwHJFr1Uijf6i7Yi6rKST3
	k9PPNlIopZOlbPnIHMHwG5dRjbeYXqJHtBtpzxGgXXdGEvFKSAzprhSG7JAVqQ==
ARC-Authentication-Results: i=1;
	rspamd-74d566c845-rqlrf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Trade: 400a8b9548a43eda_1742523285763_2357163051
X-MC-Loop-Signature: 1742523285763:3385229739
X-MC-Ingress-Time: 1742523285763
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.54.169 (trex/7.0.2);
	Fri, 21 Mar 2025 02:14:45 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4ZJmH85SQ3zcs;
	Thu, 20 Mar 2025 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1742523285;
	bh=hZXi0UZd5qs65yJy2Fr/zycLpmzQdjI05wB+uU6qyjE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lW9RqoA8PJJFhdE+iy/wd5GPM6H2tpcI6J1gVtaxfIzkYLbb29RwrtV9YmRvpfvsJ
	 evVgXMoFuiRjMj9ofHo+BbgQ2m8G3t9PCIVzoop+p3PKC1xMBQgAOkkTYXzok1i2AU
	 gMvyjg6cMP0BhlhCAG4G99SxZyLucgKt7lhf9xZAGbkPH0Ix5ngiMKVZ1tcaX1OQ6Q
	 dWB5yWwhOKkQJSI6Cr6cAupnEN0rqQPx5RRlZKE9rM3z50bH1g8rh4rZqD4gP2goXk
	 k/QsHRrXJoE14o3onkSs1bc0LUIOd4lpXE+e0ysNkrevqiG7465FXjNWt6cjnJPgJk
	 DGJFw838tiznA==
Date: Thu, 20 Mar 2025 19:14:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch v1 0/3] Fix using wrong GPF DVSEC location issue
Message-ID: <20250321021441.vdmo5txhvb6kya3a@offworld>
References: <20250319035516.222054-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319035516.222054-1-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Wed, 19 Mar 2025, Li Ming wrote:

>But I am not sure if all dports under a same port will have same
>configuration space layout, if yes, that will not be a problem. If I am
>wrong, please let me know, thanks.

Yes, when caching the dvsec was suggested, it was my assumption that the
config space would be the same.

Thanks,
Davidlohr
