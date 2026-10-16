Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93D3D4137;
	Fri, 16 Oct 2026 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792183336; cv=none; b=PU1q21hk1wNfGzpiGk5QKVjaU+yHw2/2qUwUAruPoyPbs66S78fj0xHSRAyqdnW6vIiOXyCJSz12gXgZBOCJbHeCuhTQNvseIC1eZb1v6kzkUBKKkqf7/5USxrtejfX+5F/IwSzfcILsciAh7kWs8GFw2A3lgrifY3jS9+tyE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792183336; c=relaxed/simple;
	bh=kKluQQy48UllznoybQ7BfK+If4f+k8G0vhhkVzzpHw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKX7obWAI6BL28EbevhFpavFmgOsfN1ZJPpMgphpOxrvxAU5cGA1Fjp718IY9ugnULlawUewlRZhK/dm5k8p0hJwY38JSO8OKxmsXCh+dL48EY/7uaamosLXF4BaTvAW37BxGl/CqnqNq58mqtGfOf8GnBmdlcyqeXgjMilBh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhygUXGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhygUXGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C1C1F000C4;
	Fri, 16 Oct 2026 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792183334;
	bh=b9ItKggHrdTjoEiMSmWZ6gKU2fiPh6BVkzTuELhbA2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RhygUXGED6Rk+K4BdFKEzl2HSC8ahJGwA3Z4GIeY8VIio3eIyCs78m0pU1NDz5JwD
	 mLYiB1LesmLHU8oVr7ha6GLlaR4QPl9uJfgAal5eGbOMQXdEVEM3lIQbIrwjYPtr0W
	 7pKm/kGmrFXRA4seypLN27hUY5wRloD1L+cJzJWgyfPuKUwQfl3GK9ByxJ+aU83DOu
	 t5srCWUNEBh+NMFVz4Q/EVGWG9xOop7XpIjEVvcE7QQuB4gkzhQv+cFMcUCoxpM6pT
	 lANl1U//TGjv8C8Mcjpv8NoK428tT7d2mHvP762ve1ONp0gAnuTyfBzsn5m46bj7Ni
	 len/bpDRahSuA==
Date: Fri, 16 Oct 2026 21:42:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Breno Leitao <leitao@debian.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand
 <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, Kiryl Shutsemau
 <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 0/5] cxl, mm: Keep device-reported poison out of the
 page allocator
Message-ID: <20261016214206.1dc8484a@jic23-hlaptop>
In-Reply-To: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 21:50:08 +0530
Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:

> A CXL memory device keeps its own poison list: the DPAs it knows to be
> bad. The list lives on the device, so it survives a host reboot, a power
> cycle, and moving the device to another host.

That is a bit too general + needs backing with specific spec references.
I'm not sure for instance if there are any guarantees around poison
lists for volatile as some errors detected by local ECC will be intermittent
anyway.

I may have forgotten it but I don't recall the CXL spec talking at all
about any long term tracking of errors in volatile memory across power
cycles.  There are interfaces to test memory to detect stuck bits but
I don't think there is any requirement to run them at device boot (and
we haven't enabled them in linux yet as on demand things).


> 
> Linux reads that list only when user space writes trigger_poison_list.
> Nothing reads it when a region is assembled, so with a device that
> already has poison:
> 
>   1. the RAM region is assembled and dax/kmem onlines it;
>   2. every frame enters the buddy allocator, including the ones the
>      device would have named had anyone asked;
>   3. a task is handed one and reads it: machine check, memory_failure(),
>      SIGBUS.
> 
> This series reads the poison list at region probe, before the range is
> onlined, and keeps the frames it covers out of the allocator. Nothing is
> unmapped or signalled, and no runtime path changes: the frames never
> enter the allocator, so this is not forwarding latent poison to
> memory_failure().
> 
> Dependency
> ==========
> 
> This is built on Breno Leitao's hwpoison series [1], which keeps frames
> poisoned before a kexec out of the next kernel's allocator. The approach
> here, withholding frames as they are onlined rather than taking them
> back out later, follows [1]. [1] hooks __free_pages_core(), splits a
> block around its bad frames, and marks them with hwpoison_boot_page().
> Patch 4 adds a second source to that hook.
> 
> The two cover different cases. [1] records frames in a bitmap spanning
> the RAM the EFI memory map describes. Memory hot-added after boot sits
> outside it, and CXL region memory is hot-added after boot. [1] also
> carries its record across kexec only, while the device's list survives
> reboot and migration.

The CXL region - may be hot added after boot.  Whilst I like that model,
on many existing systems the CXL subsystem is just identifying what
was already there.

> 
> Applies on next-20260908 plus [1] v5. The num_poisoned_pages_inc()
> change agreed for v6 [2] does not touch these patches. Patches 1, 2 and
> 5 touch only drivers/cxl; patches 3 and 4 touch mm.
> 
> Design
> ======
> 
> Which records are withheld. A corrected error never reaches the poison
> list, so every record is uncorrectable. Only records with source
> Internal, a failure of the device's own media, are withheld. External
> poison was written by the host into healthy media and a rewrite recovers
> it; Injected poison comes from the Inject Poison test command. Withholding
> either would make a recoverable state permanent.

At best a detection of an ECC error in local media is a hint that it
might not be cleared by a suitable full cache line write.

> 
> No host-side storage. The device is the source of truth and is re-read
> on every probe. When a location is repaired (sPPR, sparing, hPPR) the

It might well be repaired just fine by a host write assuming the CPU
arch supports clearing poison that way. Ideally we'd poke it some to 
find out whether it is recoverable.

> device drops it from the list, and the next probe onlines the frame
> again. A record persisted by the host could not learn about the repair.
> 
> Volatile ranges. CXL r3.2 8.2.9.8.4.1:
> 
>   If the device does not support poison list for volatile ranges and any
>   location in the requested list maps to volatile, the device shall
>   return Invalid Physical Address.
> 
> A device that returns it, or that has no Get Poison List at all, is
> onlined as today with nothing withheld. This is also the reason for the
> RAM -EFAULT tolerance poison_by_decoder() has carried, without a comment,
> since f0832a586396 ("cxl/region: Provide region info to the cxl_poison
> trace event").
> 
> Incomplete lists. If the device reports overflow, the host stops at
> max_errors with more records pending, or a media scan is in progress,
> region probe fails rather than onlining on a partial list.

This bit needs shout more about as you just stopped region probe
on regions that previously probed (but would potentially return poison
on some memory).  I'd put a Note: Will stop regions probing if poison list
has overflowed. right at the top of this cover letter. 

I'm not necessarily against this. I need to think a bit more on the impacts.

Certainly an interesting patch set.

> prerequisite-patch-id: a23fe88ab4529b6a6669a991e15cf1631311391c
> prerequisite-patch-id: 111c69880ed0e148cdda285896c006e8d1fc98a8

