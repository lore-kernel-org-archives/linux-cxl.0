Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970C2E62B4
	for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982661; cv=none; b=DHYsckJ9rFtn8+taUe1lGJtgrZd18PYNj13D2DLhi0CSD3MiFV9H3dtXiE8W/3/aC3gzb9sYhvFltg7KfCLfOl0nyi+TdCnVJ3OjUanG6CFLopl+j1siZZUnRwKZCi+9qmnRoFthyCS+ANrAFfVBNTSk7lIhGOVIL7+zDdjudT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982661; c=relaxed/simple;
	bh=qpxKQwj1NtWt2avroM2YiKQEVpeTglqmLprek0br27c=;
	h=Message-Id:Mime-Version:References:Subject:Date:Content-Type:Cc:
	 From:In-Reply-To:To; b=IYr8dfHmcwjjMYKMJZiTqf3pA894s+UgD3Jz2FqpuUidSFMGtc42awJzagNLNor4k1IBpuD+dwngBCw2h41DkObqoTlfg8dbMmTuOViRHR7crsycCYqcaEl1XNBty7Nz2Q9GbVXvJu8bI8/pNoZk52/d6nN2ZjiwAUyk91aLrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=qEpyZWS4; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="qEpyZWS4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1768982652; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=0PWmmDBVohTXWkCnlTUXIXQ/PjrEDMfnhQhp/O6etgA=;
 b=qEpyZWS4/r1zPQmiX3Uz1fpnIj0U8uebFpC+zeU81bmWXkTAaN1nobHjk0YAutVikC6sR9
 GTMBwp8/qPx019aybJLYt2+8pAKjodGGgkpi/QBGXd2tXS/vt/B+2QXX/KbWx13xBnDyaG
 HbPM11wP1XCn41oTUWuuBlFSyzROw+7wXlCTmdm9hhzuO47N4yeKYWB7LmSRpSF09EY7F7
 +Z0WqW9Qa/8SmhMkKzBZlV1A8ZVGlIhOgVPLDpOP7YMizfatPNl4ZVn9zO6yvUIdyJndH2
 ijpG5NWdYPFDWCQwZxUG8uNkeoH4z5qvtWhEUBuy+olHxcw2F9roVxa/cF8JSA==
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26970887a+1367a6+vger.kernel.org+lizhe.67@bytedance.com>
Message-Id: <20260121080348.36253-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aW_G66HeWLbyiPHs@gourry-fedora-PF4VCD3F>
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
Date: Wed, 21 Jan 2026 16:03:48 +0800
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <akpm@linux-foundation.org>, <ankur.a.arora@oracle.com>, 
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, 
	<david.laight.linux@gmail.com>, <david@kernel.org>, <fvdl@google.com>, 
	<joao.m.martins@oracle.com>, <jonathan.cameron@huawei.com>, 
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mhocko@suse.com>, 
	<mjguzik@gmail.com>, <muchun.song@linux.dev>, <osalvador@suse.de>, 
	<raghavendra.kt@amd.com>, <wangzhou1@hisilicon.com>, 
	<zhanjie9@hisilicon.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
In-Reply-To: <aW_G66HeWLbyiPHs@gourry-fedora-PF4VCD3F>
To: <gourry@gourry.net>

On Tue, 20 Jan 2026 13:18:19 -0500, gourry@gourry.net wrote:

> On Tue, Jan 20, 2026 at 06:39:48PM +0800, Li Zhe wrote:
> > On Tue, 20 Jan 2026 09:47:44 +0000, david.laight.linux@gmail.com wrote:
> > 
> > > On Tue, 20 Jan 2026 14:27:06 +0800
> > > "Li Zhe" <lizhe.67@bytedance.com> wrote:
> > > 
> > > > In light of the preceding discussion, we appear to have reached the
> > > > following understanding:
> > > > 
> > > > (1) At present we prefer to mitigate slow application startup (e.g.,
> > > > VM creation) by zeroing huge pages at the moment they are freed
> > > > (init_on_free). The principal benefit is that user space gains the
> > > > performance improvement without deploying any additional user space
> > > > daemon.
> > > 
> > > Am I missing something?
> > > If userspace does:
> > > $ program_a; program_b
> > > and pages used by program_a are zeroed when it exits you get the delay
> > > for zeroing all the pages it used before program_b starts.
> > > OTOH if the zeroing is deferred program_b only needs to zero the pages
> > > it needs to start (and there may be some lurking).
> > 
> > Under the init_on-free approach, improving the speed of zeroing may
> > indeed prove necessary.
> > 
> > However, I believe we should first reach consensus on adopting
> > "init_on_free" as the solution to slow application startup before
> > turning to performance tuning.
> > 
> 
> His point was init_on_free may not actually reduce any delays on serial
> applications, and can actually introduce additional delays.
> 
> Example
> -------
> program_a:  alloc_hugepages(10);
>             exit();
> 
> program b:  alloc_hugepages(5);
> 	    exit();
> 
> /* Run programs in serial */
> sh:  program_a && program_b
> 
> in zero_on_alloc():
> 	program_a eats zero(10) cost on startup
> 	program_b eats zero(5) cost on startup
> 	Overall zero(15) cost to start program_b
> 
> in zero_on_free()
> 	program_a eats zero(10) cost on startup
> 	program_a eats zero(10) cost on exit
> 	program_b eats zero(0) cost on startup
> 	Overall zero(20) cost to start program_b
> 
> zero_on_free is worse by zero(5)
> -------
> 
> This is a trivial example, but it's unclear zero_on_free actually
> provides a benefit.  You have to know ahead of time what the runtime
> behavior, pre-zeroed count, and allocation pattern (0->10->5->...) would
> be to determine whether there's an actual reduction in startup time.
> 
> But just trivially, starting from the base case of no pages being
> zeroed, you're just injecting an additional zero(X) cost if program_a()
> consumes more hugepages than program_b().
> 
> Long way of saying the shift from alloc to free seems heuristic-y and
> you need stronger analysis / better data to show this change is actually
> beneficial in the general case.

I understand your concern. At some point some process must pay the
cost of zeroing, and the optimal strategy is inevitably
workload-dependent.

Our "zero-on-free for huge pages" draws on the existing kernel
init_on_free mechanism. Of course, it may prove sub-optimal in certain
scenarios.

Consistent with "provide tools, not policy", perhaps the decision is
better left to user space. And that is exactly what this patchset
does. Requiring a userspace daemon to decide when to zero pages
certainly adds complexity, but it also gives administrators a single,
flexible knob that can be tuned for any workload.

Thanks,
Zhe
