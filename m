Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9399305675
	for <linux-cxl@vger.kernel.org>; Sun, 17 May 2026 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779048412; cv=none; b=M4yFc9IRcTQMC78Rq9LQkRXXaZZa3OmWp/uI5FQapqO02kuCBK9aZv8MEC0mF6yV44Ou/rCLCSrz9tr4NBu33NofMhf1/laA/WgMLMz2PB3aJWz86lXRPEhhQ0g21k9/Ztf/9MIIm6EeGs2jgqCbMN8TRcBDguFOyxYYNdC77Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779048412; c=relaxed/simple;
	bh=1jR4VX0JH89Q5myxphrlJ1We7QqP2GmhqIm9qlScids=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCJJrg1iREiD0yTtO9hpMdJ/xHWWhOr49DN90txTWvcv5JxUsZdptHO8DBFnLs5ssx8MRB/V7Kwq0znmx8D9nAORkmspCQgcfpdsGUjGepsCykzxXxOcBgX4nQThcWXCTZEuBtysqEFBX48f1PaEujVAiDh0IYjuwoz9dY3BcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLsN1KPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLsN1KPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B7AC2BCB0;
	Sun, 17 May 2026 20:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779048411;
	bh=1jR4VX0JH89Q5myxphrlJ1We7QqP2GmhqIm9qlScids=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLsN1KPyLk8DdyXryMn4yzh4aQAsjdgC+8dX7efJ36TBpLZMTeTyVl3hR5NMxjRuo
	 Qpo2CDWraGCLYVgHP+39Jvhi8QNHNXTWk9Q4lhwD0ohmDKHBzvJ4GxBkjd+5WSlU+K
	 uys/Y1AoA7KX9GAn319kuuxkVY7OSFN2aL7IgiWw6jvVltdGHFoe3mHyJAQdP9LgBK
	 08/QGZ3jQUARoKrxskI4eWS8lNC4hyvmRA/ui8UtxqUAsMK8Mf/w/BRrt6QjpeqJrG
	 LCQ5RV8vP26luMXvup77gPJaCgZdK4nWzkYdH0ZM6IlmrH1558CBFnJKrzIO9mIhyD
	 NtQjGd7QibKZg==
Date: Sun, 17 May 2026 22:06:43 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, djakov@kernel.org
Subject: Re: [PATCH v2] drivers/base/memory: set mem->altmap after successful
 device registration
Message-ID: <agof08pql5svngb-@localhost.localdomain>
References: <20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com>

On Thu, May 14, 2026 at 02:26:57AM -0700, Georgi Djakov wrote:
> If __add_memory_block() fails at xa_store() (under memory pressure
> for example), device_unregister() is called, which eventually
> triggers memory_block_release() with mem->altmap still set, causing
> a WARN_ON(mem->altmap). This was triggered by modifying virtio-mem
> driver.
> 
> Fix this by delaying the assignment of mem->altmap until after
> __add_memory_block() has succeeded.
> 
> Fixes: 1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>



-- 
Oscar Salvador
SUSE Labs
