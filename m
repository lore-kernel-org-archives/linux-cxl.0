Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B63FE644
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181748; cv=none; b=cZ8tQYCpm6SNtLKZC/k9ixJ72WYWpcSlcfPOIWbi+SC4VyQDoWn71x1hVW7GcT2tm0NLm+yTsgp5X5eLMWtf6m4Nf0QA6KbMfb9VSem4LbBakq9j9U0mwoFH7V1dPnsmnCeRIf9/a+G5qPx1dAT1kaHQmezfHWDZGDF37CEvkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181748; c=relaxed/simple;
	bh=t8lsl2AM+D0NdTRJirKPh97Ti26onkws6Dag3k22wx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OU+gkL3aE/spqZjTiUci/tp/pWvztQ94wdGIL7Sg/gombX81kE5VOapso2Ch0vhGLAcpMf02VSjbaHg6j8gnDn3F8bc5HLIxrqIpTLpmnzk74f4wkozg1V8p2w6D6mRCsja2cYwTwWOZAjS+8XaIjPNc4+dUersM7ainxlc3/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjsZYviR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjsZYviR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172B21F000C5;
	Fri, 16 Oct 2026 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181746;
	bh=64Gc0sO5zDKPA7tKO/fXmPueXKcpLewx1CA+DeNvw4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EjsZYviRTN/9kaUVEmyF5MgXBsBREhUNMkWISSq8sernzBZU7h8LRMfLnEzmy0+O3
	 VT9v9zP/ubULVqjfRRj6tLqQneSCXqpXrat22PjCSqngctIjnjyxB4oTAFHnVLWjjv
	 sgc2okcdsuov+9FvNCT4ardhRahE8ACEA4iRjiNhGWZurgYPpqB5h9lJtqjlnqITEL
	 t58CIerrB+RH3DN1Xueil5mUTPZYxYpxHSGUxnq6TMNN/vkpwTfSlGca7GKPbJSjrl
	 2r7M0wQLdAH58pwEJIYlhjANxJtRWtDG4MIqDVWBH2xc5wolU7rG03eUkFZXb9/Y+G
	 3ohYFk8KJL+kA==
Date: Fri, 16 Oct 2026 21:15:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>, Richard
 Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 5/5] cxl/test: Add a topology for region granularity
 finer than the root
Message-ID: <20261016211540.7ab43276@jic23-hlaptop>
In-Reply-To: <5ff3cb8caf171be64d2451f8cda33fad23da0126.1791863201.git.alison.schofield@intel.com>
References: <cover.1791863201.git.alison.schofield@intel.com>
	<5ff3cb8caf171be64d2451f8cda33fad23da0126.1791863201.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 21:44:27 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Add a cxl_test topology for testing regions whose granularity is finer
> than the root granularity.
> 
> modprobe cxl_test finer_gran_regions=1 creates three host bridges, two
> root ports per host bridge, one switch per root port, and two endpoints
> per switch, for twelve endpoints total.
> 
> Selecting different endpoint combinations allows interleaving at the host
> bridge, at the switch, or at both, without requiring separate topologies.
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
> region at 256: CXL 4.0 Table 9-6 row 7.
> 
> NULL-check the legacy topology arrays in the mock device and mock port
> lookups, which are left empty when finer_gran_regions=1 selects the new
> topology.
> 
> The default and existing special module params are unaffected.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Seems fine to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


