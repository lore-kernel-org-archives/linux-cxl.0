Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880524;
	b=FBljgUmBhIMbuYXm+bOc/T03hbEkDATLrtjYx1WjrM0U3V202Xg2PmQs90fJxH1MHqoS
	 phOM516y+ozL7l8EXo3sR9e1Foj0x+16hi5EDJGjon4fMDvkfuUs22R2grr6hgHXgl/jw
	 9pSWhmuRlZ9c1L903O7nfEZL+CMqqxQ0iijQfY24U/Iku82D0aPJIwQpw64KjFuI4cyXd
	 zqVz2c0g+b+qcmRA4MvcMoxZ/jy+S7YA9vA9s+/l7hYNpBepivjdMY3ASFbaVt4XoIOfu
	 UX0ei5zg2S5rUrMacUVt2iYX+s8JlFLFK+BpkPrAbtpx81Q1XWmINjmRgjmMmpwI1Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880524;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cqteSZnPKmFbwXSprXLdQzeiUvJZKDmX3fZDGom9yzk=;
	b=m+YvwiuwYQqbCqeHx9bbpi6FzKevPbrvBnubU6WGL8BvFZmMfltVvvDXO3CxWGjdd2QY
	 pwhotWUdUTw8V9eLiQFnfVBlNw6TwCHW8xY4cF1xsT5JKkeUrvmyhGd98O3sl+4rIyA2k
	 g3sMhmYS2fPrMjhiOLT7aj6xX161rz9Zu/GVWUWbWYeflBEEVwO1kuF/W9hS5vjWtQLlK
	 QNgWosT/RnxZH1FSFaTR45y4Fq9CA0Cnfwoj17AIO+H46SztqiuAX/fYSvddyjUyqJ+yO
	 cH7W32y2XHNtKgDKIQUREWIPDfCfU2IkZ/7c0hnor0DzZMVaimVpLH3b5XNgxdI7B2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SRpPq/fr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F43606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRpPq/fr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BF71F000C4;
	Tue, 17 Nov 2026 01:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794880523;
	bh=cqteSZnPKmFbwXSprXLdQzeiUvJZKDmX3fZDGom9yzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SRpPq/frjZT63jPEDaTse2aUY6o94fJh3bqR0lU118EtccieeGaPlt/hIIzuEw3+q
	 ktC9zxSMkpoRZ0BaJY33rXXzaxf81bf3kAWf0YrHu8xMRfkUKnkpYmtEy45atBZORm
	 Lmtj3fC1rNP2ell47mhrt0wkI3mwUJbD77wSTG0JgHzmjuXzFVPZRx8QyR6FIeX+NG
	 tfAcpyofMGGDUhjgxR4GdicLwZ8JabNjOEbB756SZssoDQLt2l4RgbXLtL+4mTUMt1
	 bSHCEyJBtZadAuwsnVBAJqMF53rDAePt8QUpI60CI6btY40xQuRWe7S6oWMgD0v4AR
	 QSKgxDAvDDsGw==
Date: Tue, 17 Nov 2026 01:55:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl/test: Program a don't-care granularity into the
 passthrough host bridge
Message-ID: <20261117015515.5c5e7d7d@jic23-hlaptop>
In-Reply-To: <8724399275232657490080a526e202e797ef7962.1794010889.git.alison.schofield@intel.com>
References: <cover.1794010889.git.alison.schofield@intel.com>
	<8724399275232657490080a526e202e797ef7962.1794010889.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 16:35:02 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> The auto region mock gives the passthrough host bridge decoder the same
> 4K granularity as the switch decoder below it. Hardware ignores
> granularity at 1-way, so matching values leave propagation of a firmware
> don't-care value untested.
> 
> Set the host bridge decoder's granularity to 256 bytes. Auto region
> assembly then fails unless target setup carries the effective interleave
> state through the passthrough decoder.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
