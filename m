Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCC270EBF;
	Tue, 18 Feb 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901274; cv=pass; b=X5vnzcfcjaIi2JWFLQKptXmo2gkZUnR2SUQCu9pUCIPBvbvBrvDeo8OJXsWjt/3XPgS9U9UmFLllwnSCdIuv2dOjBmqtOQO0wwgutHJZpU9J5D+boT3gjNTTGontb0D0ix0/5RCMNbPoY7905G8jZwhbkR6re069WAxEn78F0eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901274; c=relaxed/simple;
	bh=EXlnmm98gVz4H22ygJFIiFPd9A+akx/jzNMXZ6VZSFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUpWPGCwvAamvJXZxwMTb+ZS7D2F+sN0OzYlKpHkdOT+w2o2ZCCoIBhs+9eLHbvL40PcZPDW4YZfEPCarCqs9XtJJqYbNxoTU285M94ACWqPC2trjVKLyzXh99ThId1Rr9ykXKCNemnHkIbhYFk7YvIaoHde5Cz5Zz13nSlFXSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=c1djtRmN; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="c1djtRmN"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B12FE21815;
	Tue, 18 Feb 2025 17:54:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.101.208.230])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 480D2232DE;
	Tue, 18 Feb 2025 17:54:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739901271; a=rsa-sha256;
	cv=none;
	b=i2g2u3kCQdFjZ4K7HtYNrVOzxUFDLbNP01R3JdM+zBKXu9GjTS311zQyYuAn4DHJvFLY4Q
	4VFdscz7daBh9CvgwuBFQ2wm0yY0RpzUZQIq/fBCj5oI9UXqkzNq2eENNVlISrzgPWVXT9
	rFa3gFPXp+eF+mHwclJ0nrjjuHCYpRCavII8jLa2xXJ77Icl+ChhdCD/Kpc9vlenfXP/E1
	qpNX9Qjp9xreOjg0bETILZl62VRGOZe0XlCEngU6EVLfKHPO6lTIdRvyzW4gnOIX8JPLIu
	4JlXAEzkl4pseNdQmgpWk75EQHMEQBOxVWiFwq71KCDe0LgTd+O3zIOjMB3Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739901271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EXlnmm98gVz4H22ygJFIiFPd9A+akx/jzNMXZ6VZSFc=;
	b=iL+v+xHUSMJkaXpBKKx/iFK+Ip9GEFs7Trsf2/rWelYo63Q8nd5ZJgMZdsxRIXstkHWKch
	RiBoRdS6zNxaXa0Onjh9ctnkE6mJIPhgAlkVI8k/e5aMU59bRSTtyPw5lx2UVoD+MOPsOQ
	bCfJH21qDl+6OqGg9W79UetFvScNh5WfaVF7tydRuCX0zHYP6aoWXBgln+6k6TtIZFnLUG
	Ez0r99h/W9AvtpBd4ZNqZMrgfzGg8OCvs8ffS50sepX3AsRDthmV4i7SHwltCLiXTYo+HI
	4nwOU7wHtcXf0mXryI5Sfaab4AvZNpCum4uWWeV0FA2B23dCgplEMWP0/dILcA==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-2km2b;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Occur: 3958d16b4ec81d63_1739901271571_2723353521
X-MC-Loop-Signature: 1739901271571:1401287282
X-MC-Ingress-Time: 1739901271571
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.208.230 (trex/7.0.2);
	Tue, 18 Feb 2025 17:54:31 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4Yy6bp3sjhzK5;
	Tue, 18 Feb 2025 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739901271;
	bh=EXlnmm98gVz4H22ygJFIiFPd9A+akx/jzNMXZ6VZSFc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=c1djtRmNEQWXB5gkXrAf7d+ir/R7ZAFaHwrNrOAqZb29xF2u+AVTYYp6Zs1GU9JVU
	 u07aviKr+2BVBo158K9xg8bFMNfL+OhDroB1z8qeBO1i+a1flUrSj/v2kCFhqPkkbU
	 t006bXCjLzEtNLc+oEx8zE+BuJy+6xMzPjFGRQl5Fp11nw86unbRdSF1PTUwL5F29k
	 h32aYNr0gue6efvKwrmr0wmuLvg5BQpZfY2KqIRfps0/PiTPUY/Z+9oIZNeA9Dvp4h
	 zJxQ5jLZDsLmwAC7RgiooPWqrttmyoRsZrkHqSDsv0gfKFvzJp7iyEKgXnVcF52TSX
	 wx8TIBXEYbGdA==
Date: Tue, 18 Feb 2025 09:54:27 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Use guard() instead of rwsem locking
Message-ID: <20250218175427.qlmunbgkjhrroc2r@offworld>
References: <20250217144828.30651-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-1-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Mon, 17 Feb 2025, Li Ming wrote:

>Use scoped resource management to replace open-coded locking operation
>is recommended. CXL subsystem still remains some down_read()/up_read()
>and down_write()/up_write() which can be replaced by guard() simply.
>
>This patchset includes simply using guard() instead of some
>down_read()/up_read() and down_write()/up_write() cases. Besides, it
>also includes some function code cleanup after using guard().

For the series, feel free to add my:

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
