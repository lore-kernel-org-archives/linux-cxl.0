Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD5278161
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787350086; cv=none; b=PhE9ph6TnOotfbdktutZnP2ifCCPpJGZUaHqRzKAvxX0ulEKvHeHB1jUYPPQlqXQlaeEdskyno32+Z15uY5wuIyPLj1+/k8Sj7GTZeNHMEtJ54I5FMHFaSlL3+Q3kyUgNhZYHJsHjeOnvkvm4eMo2pEG2oyPnZx0stOJMbSk3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787350086; c=relaxed/simple;
	bh=7DvbP5lxCBODztNBwDIyHogHkmpEyieMqJykmxyjtxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjT6hXdUrdFOIwgsRiWJtdX9KU9mgCCGJf4Fh4sdXx9hqdzYKNPiTG+BxMl86BfxikHgme35Fz3hMZhsVqZ8SbFodLu5gWtHgJ910FGe/dkkmbKQW7FWiQ0X3Rt9/Ula8or44SybOUIqklUQKfRZQ14y8+ATjE6RBPUEr+7ao9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX/bnCne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX/bnCne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938171F000E9;
	Fri, 21 Aug 2026 22:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787350085;
	bh=hc1Lwjqy7522yq8n2nFWJ02AxhFrhdIv5XnDAeepMF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VX/bnCne+PBB50WyPKWtEZihnnNW9oMqpYyZLI5OcvtWmXC0Mi1+qigGynn9RyQgl
	 OKE3g6gxsB0MdlkNRn5qnFqGRbq9wBT5G6xIni+v3pWpeB4MyhKZTU5jwj0XzNeNC7
	 LK4XnZKZx7gF3WjrxCFqi0YsX4ZCY3vkIAzpwprE6kFUYIZL/XS4TG1Pl7xV3mN+Dh
	 Y11YUcOLrnpiZhRWAFuChP4jKCRcSwOGLV6Ems0T0achSxpPV0Rr0gX77s+WgjWXzx
	 SxmcVpkerL5TiGvsWGCPMOl8vm5qmpuc6RBvXF+WvshGeS71me97SVZWhJNRrTA1wO
	 uADWrRlYCTw5g==
Date: Fri, 21 Aug 2026 23:07:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 5/6] cxl/test: Add a topology to test
 mixed-granularity regions
Message-ID: <20260821230759.209cd190@jic23-huawei>
In-Reply-To: <dcba06f559a891950910348418b415aa614f399f.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
	<dcba06f559a891950910348418b415aa614f399f.1787255388.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 16:31:23 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Add a cxl_test topology for mixed-granularity region testing.
> 
> modprobe cxl_test mixed_gran_regions=1 creates three host bridges,
> each with a passthrough host-bridge port above two switch levels
> and four endpoints, for twelve endpoints total.

Why the pass through HB? 
I queried the 2 levels of switches in the docs patch - maybe
you already answered that (I haven't checked just yet)

The spec examples that do multi level interleave are all cross-HB, HB and
then switch.

> 
> Two CFMWS windows are added:
> 1) A 2-way window at 4K gran over two host bridges, that hosts 8-way
> regions at 1K.
> 2) A 3-way window at 512 gran over three host bridges, that hosts
> 6-way regions at 256.
> 
> Both windows also host the same-granularity regions their ways allow.
> 
> Register every mock device through cxl_mock_platform_device_add() so
> the mock array is populated before platform_device_add(), matching the
> ordering the rest of cxl_test relies on to avoid the endpoint-probe
> race in commit d90f236f8b9e ("cxl/test: Update mock dev array before
> calling platform_device_add()").
> 
> NULL-check the legacy topology arrays, which are left empty when
> mixed_gran_regions=1 selects the new topology.
> 
> The default and existing special module params are unaffected.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
