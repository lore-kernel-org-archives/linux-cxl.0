Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DB610F2
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826221; cv=none; b=GeGFpcvoofUlwFMmEAe5s/7/ZfKNjJppzUw5iNylFCH8j1dsu+CYjfUQL8E9K9be0xRypnHC/YMufMS4izWWd4B9og7mAXZuR1omzqgY17bJAKXkRtE6q3t0jkKUmEP/107k8hdJ6wup3kaptQ7RB00O5elzLMmXYgU2rV3rhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826221; c=relaxed/simple;
	bh=/5dM9LJwR03B8z24SaeWepXAH2s29XunJQ2CTvpL2Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iy3TswMupXZzCOJD4jsKKt0CsM/z6FsLMV+aZohH+SBdZK785H0TNWAMBEonrijOdeKB5decImbLlQi+gLqYuuubd8mRn9a04nCbnRPJoMvIlfteQX78eXe+XZlzaNa1piNNVzITJ8k7bgnUhgk+za8sKDmM+FSIib2C5zCne6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJCxbS9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJCxbS9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C0F1F00A3A;
	Tue,  8 Sep 2026 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788826220;
	bh=8gNwrcpAezl0yvrZcUsBaV3qyUpm9GWs+XX9Mo9OVTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HJCxbS9iGTrSFac3PmDZDRF/RjgMrsb4Em8J7UJNxzE+pj8MG6drHgquM3MUS2CZ8
	 d/6Ssj2TxnpC3ItnVhaHU8qyTacozGnzoupVvi8K8bHaxadncpvXqa5DSe1BASz/P5
	 fNl40mtJUdVEGYLaLSX85c0QJp9rM675u84OTsu5+HkXrCrKB/Tl3fL6l9GaJ6ggkh
	 x/YjpE0Ya49xYf67UroNYzWUHHcdT8d0MmBYWGDOi+meocy5Uk9Yqn8MJk7uBk1UCm
	 b3OadNnsSiiftzWEygXxu9kBMQRCTXsL+YGimzm1FiUhjLHGCiqKP6+ODdsoqvMtx9
	 2rzVjaBZom2ZQ==
Date: Tue, 8 Sep 2026 01:10:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 7/7] cxl/test: Add a topology to test
 mixed-granularity regions
Message-ID: <20260908011015.235b7a24@jic23-huawei>
In-Reply-To: <762061594706e626bf41c2cbae773f49e34d1a29.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
	<762061594706e626bf41c2cbae773f49e34d1a29.1788475206.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 16:23:49 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Add a cxl_test topology for mixed-granularity region testing.
> 
> modprobe cxl_test mixed_gran_regions=1 creates three host bridges, two
> root ports per host bridge, one switch per root port, and two endpoints
> per switch, for twelve endpoints total.
> 
> Two root ports per host bridge is what makes the interleaving levels
> selectable. A region built from one endpoint per root port interleaves
> at the host bridge and passes through the switch; a region built from
> both endpoints below a single root port passes through the host bridge
> and interleaves at the switch; a region using every endpoint
> interleaves at both. The CXL Specification lists those as distinct
> legal configurations, so the choice of member endpoints, rather than a
> second topology, selects which one is under test.
> 
> Three CFMWS windows are added:
> 
> 1) A 2-way window at 4K over two host bridges, hosting an 8-way region
> at 1K and a 4-way region at 2K.
> 
> 2) A 3-way window at 512 over three host bridges, hosting a 6-way
> region at 256: CXL 4.0 Table 9-7 rows 2 and 3.
> 
> 3) A 3-way window at 1K over three host bridges, hosting a 12-way
> region at 256: CXL 4.0 Table 9-6 row 7. That row is the composition
> the documentation contrasts with the unsupported row 6, and reaching it
> needs a root granularity four times the region granularity.
> 
> Each window also hosts a same-granularity region at its own ways and
> granularity. The 2-way window at 4K hosts 4-way and 8-way regions at 4K as
> well; the span identity allows the 3-way windows only their own width.
> 
> Register every mock device through cxl_mock_platform_device_add() so
> the mock array is populated before platform_device_add(), matching the
> ordering the rest of cxl_test relies on to avoid the endpoint-probe
> race in commit d90f236f8b9e ("cxl/test: Update mock dev array before
> calling platform_device_add()").
> 
> NULL-check the legacy topology arrays in the mock device and mock port
> lookups, which are left empty when mixed_gran_regions=1 selects the new
> topology.
> 
> The default and existing special module params are unaffected.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Hi Alison,

Sorry, no tag for this, but just because I can't remember enough about
how the tests work (if I ever really understood!) and don't want to
spend the rest of today working it out again :(  
FWIW, I didn't spot anything wrong from a quick look but I'm not feeling
confident to review this.

Jonathan
