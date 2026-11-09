Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215621;
	b=qjjsYDi9n9NH80O/cfiXU/j56hQh9BdjzWphwvb2Cbn/dxLVpdcadL88vutmBPnVxbxx
	 uVFWYeNY2OB/N10dCCvNDW1LXQ8OIz1mkMiI5RDU+BXIWipwlsYkUArnJcogN5MAn4RA9
	 5Wla/jqWQEKcyt/ruGe/e96hVPy3+tqfqx4QyaqjJaQ0PjN1zrfJI6fhE2kyv7FvNkC5R
	 2iBJBauIs2BPsl7XvXjn1BIeUh5/1GInW6YvXTk+Z26b932HJOOrPSWBWaoPdPON2/Qxc
	 KqjcuAQIDY6CEB1hgwlNIS5mSWksed1Y2s/9jLvt3PO5qdnptkmptWR/mrJhCX4+Nag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215621;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WewbPdXloQFzq7PxEEzYBZGym0dDSEfWIKjsTFPTFGk=;
	b=h/4UT2Z0lVho1doHBJjasxXQ4y6aZ2jZ6skrLnomGxSrk+wvMeebh+/TSZZEYKgdAl3+
	 qH2GK+IbIw1gjw53zlRkI39CIYrWA1eWC3XBEq6Y9ZKKHo9YMh/jN4qLmHNcfikTX7lBz
	 NLc5LIextzTgckreAos2Z4FXftp2IeiFSh88it1rwa5BAuYHG0GfcwfGgkx/9Qpzym6GM
	 MdwSSi52YCLhRENi0vxANXXsSB1N1CKU4Z4wcRrB5Zd2WVzYv3KuKWZb1skv5RUnc2UWr
	 GmT983sQsLmVx1qY9SFAGMsrHZpqzEvZH+EHIvHzJqRZzQEcj91FT317qyLW6X9KeRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOZ0F7Sz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E4606A31C;
	Mon,  9 Nov 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOZ0F7Sz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4C11F0089F;
	Mon,  9 Nov 2026 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215621;
	bh=WewbPdXloQFzq7PxEEzYBZGym0dDSEfWIKjsTFPTFGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NOZ0F7SzJk9PfMsNlARgiXEIR4TN3eLHPymrOqc17Hg6gYCSHgCMTY/siLKpUXLwG
	 PtGySWokir2nJ9/OVyTHpDcO+k9ORd0fyT3OIqzPu0euhsC2ZQ2J9CtU6gSLMhSmtR
	 hw+Qc3i2ZwYGwqb8FVZVjff2b+oppBMgQCCCTp4diDqXgm2arWMlEMKtnVVoyZf2Us
	 JXTUMKaDfCaVQ4WDEz93/9xvApuY2WP3EwoI/fGfzyiuljc09UCPzcPb07u2eHAIU2
	 fv6kzYaUAXJ5Bz0wagLvKx9UU2UWRNL+lN1x6988/PDE51tdD4eG9pRfxsXpHteHL7
	 dxAdg6g89FK4g==
Date: Mon, 9 Nov 2026 10:13:33 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] x86/mm: Tear down the direct map when memory hot add
 fails
Message-ID: <avGOvSHAJtzeUr3A@localhost.localdomain>
References: <au_l5MRyDbYfsUVe@chrisdown.name>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au_l5MRyDbYfsUVe@chrisdown.name>

On Sat, Nov 07, 2026 at 07:00:52PM -0800, Chris Down wrote:
> arch_add_memory() sets up the direct map before calling add_pages().
> If add_pages() fails, the range stays mapped and any page tables
> allocated for it are leaked. A later hot add can reuse the stale
> mapping.
> 
> Remove the direct mapping on failure.
> 
> Fixes: 45e0b78b0532 ("[PATCH] hot-add-mem x86_64: use CONFIG_MEMORY_HOTPLUG_RESERVE")
> Signed-off-by: Chris Down <chris@chrisdown.name>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>


-- 
Oscar Salvador
SUSE Labs
