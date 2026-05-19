Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABC346AFD
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224917; cv=none; b=rYDo03u4Pr2Dz/6NYqpnPpSIENHfuKX920MrPOga+oLNSIi7QsogITKiZM/k3i8YQiqWVpxTjW/MUr5likubTQ5EMIZJ918X0NE/tr0fV13VJPgfkH+ABLAEcn/TRj25QKW0fEuXPtCy8u7+kVsr5YDnTjSOs+DpItLbWOHQ7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224917; c=relaxed/simple;
	bh=YryeR5+L/LeaRnl87LJxqvht365aK+p4n61m5kFCEKg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d5i/t0Hy2rTW91HElTU90Lhj9Wq+3stGTb/UvTBr6z9JduytnkVSfCGYocPLXoylJ9fUCbzl916K1IOSnBZpRk01mMpwJWd+Z2zfd5QXDgBruyPb0aYQ/FWR+Hv5oxvxkBXz027YNAWVSE8dziwz3L3jXFOW4s3/CgduRDP9muY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jURyxAjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jURyxAjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31C31F000E9;
	Tue, 19 May 2026 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779224916;
	bh=JS1yyKmqnk5Unq24VeZ3/2R9CA2t4l0FygZRt/eQOoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jURyxAjICAw+O6bXQeTFnit8oi3xSXozTg6BCrySYVh2AqIh8wiej8qRBEzJHnOky
	 nPwsy7Li5/Pk3jr3FgbINEvo06oasgpgVbznHfwcoIedWyZhAdkHs3bSbDcPP0Aa8F
	 FGCVPMyqBeUksPS1S3m91+b2d8QFIN6q4xZwilNY=
Date: Tue, 19 May 2026 14:08:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: Georgi Djakov <georgi.djakov@oss.qualcomm.com>, david@kernel.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, Mike Rapoport
 <rppt@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2] drivers/base/memory: set mem->altmap after
 successful device registration
Message-Id: <20260519140835.0eb262de8c8e37b9fd307c74@linux-foundation.org>
In-Reply-To: <90c0af4b-f608-42e5-9f61-222d943bcebc@kernel.org>
References: <20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com>
	<20260519132522.421c018b39328ebc4767dd8e@linux-foundation.org>
	<90c0af4b-f608-42e5-9f61-222d943bcebc@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 23:57:52 +0300 Georgi Djakov <djakov@kernel.org> wrote:

> On 5/19/26 11:25 PM, Andrew Morton wrote:
> > On Thu, 14 May 2026 02:26:57 -0700 Georgi Djakov <georgi.djakov@oss.qualcomm.com> wrote:
> > 
> >> If __add_memory_block() fails at xa_store() (under memory pressure
> >> for example), device_unregister() is called, which eventually
> >> triggers memory_block_release() with mem->altmap still set, causing
> >> a WARN_ON(mem->altmap).
> > 
> > That isn't good.
> > 
> >> This was triggered by modifying virtio-mem
> >> driver.
> >>
> >> Fix this by delaying the assignment of mem->altmap until after
> >> __add_memory_block() has succeeded.
> >>
> >> Fixes: 1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
> > 
> > Patch is nice and simple so I'll add a cc:stable to this, even though
> > the issue seems rather minor.
> > 
> > btw, AI review had no issue with your change but might have found a bug
> > in create_altmaps_and_memory_blocks():
> > 
> > 	https://sashiko.dev/#/patchset/20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com
> 
> Yes, i have hit exactly this bug actually (shortly after this WARN_ON, we crash)
> and was going to send a fix, but noticed that someone already did:
> https://lore.kernel.org/lkml/20260428081855.1249045-3-songmuchun@bytedance.com/
> 
> I can respond with my RB on that one if you haven't applied it yet.

I have indeed applied it, but a R-b isn't a problem and would be
welcomed.  One of the many reasons why I retain patches in quilt form
for a few weeks before gitifying them.
