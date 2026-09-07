Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C838F64E
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823424; cv=none; b=CJWOrF071W37r1zOTHEFR0wTxwl4eRnObu42GeCyi49nSXWigxXD9QKnDDcwiVaWrkvzvSfGxpAl0koIlwlf2pAXwiAHrYVB0ERFuLLUyTZ5rHEcyBTV30mLluaQqw+SWRl3U7I2ZPSRURq83zShCAxHLnhLQnG2DSZk0yQ/bHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823424; c=relaxed/simple;
	bh=Rr+onZVmPsSN8H/hLZZEfyXCyU8Ww/jdgvrGRBcxQAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVT+THB5ITXwjN88Q6Fb9OTrVSrmQR5nFlyKRPJSkq6J7rfJj45hVrcbJMOvzrxX7SKcwC+ww2MDN6N65gjJha1AlcqOZUaGoJe65mi4iaMYLduxXPjTTaVg/qy+PjxwgndQJH4mZwPnhRq/6wCRhuff/vL7+75C+2rVgTySM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFLCwoD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFLCwoD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99011F00A3A;
	Mon,  7 Sep 2026 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788823422;
	bh=Rn0DypIIKTyytamW7NiV1Oronfyrhfwri1tE3Bz7GBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mFLCwoD9D6/OC87geIV7W0nVJwZRBhW+ClkIaCV4KZtbLoCn+3aaiSryoruKWlauv
	 1OXhXGIowKoSeVUImNSeLMb4aMigybLwqMg597BSHOK7p+ADUiBHt5Y1IGIrIJjICS
	 bdMb3MEu2GJ+OaH4hd9KMQDmnBmdqi1orWVzztfyidDR/HwBuqwsa1ioyW0lEUz8sS
	 RBgjH7CBvUImTCNlde1igT56Op3oq1jCnLViWUm/emg4On6zDGeCGUfGysel5FcuAs
	 siPLOA1g9zfjcX2KQLQHCnyMAyMcwsb27/o1Em6nYv3dN+qHKzZyI3QVKs1rvV6h28
	 8INcNUFZiPyhA==
Date: Tue, 8 Sep 2026 00:23:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 1/7] Documentation/cxl: Describe mixed-granularity
 regions
Message-ID: <20260908002338.466c8ed3@jic23-huawei>
In-Reply-To: <5da4008cde30c04284f5780aadac49e91ae511c1.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
	<5da4008cde30c04284f5780aadac49e91ae511c1.1788475206.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 16:23:43 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Linux has required that a region's interleave granularity equal the
> interleave granularity of its interleaving root decoder. A mixed-
> granularity region lifts that restriction: the region granularity may be
> finer than the root's, so the interleave refines from the root toward the
> endpoints.
> 
> Mixed-granularity region support introduces interleave relationships that
> are not obvious from the existing CXL documentation. This is particularly
> true for the 3-, 6-, and 12-way configurations and for understanding which
> configurations permitted by the CXL Specification are supported by Linux.
> 
> Document the mixed-granularity model and Linux's coarse-to-fine
> restriction. Include the relevant configurations from CXL 4.0 Section
> 9.13.1.1 and annotate their Linux support status.
> 
> This intentionally repeats information from the CXL Specification. The
> specification remains authoritative, but showing the Linux support policy
> alongside the legal configurations ensures readers do not mistake an
> unsupported Linux setup for a configuration unsupported by the CXL
> Specification.
> 
> Assisted-by: Claude:Opus-5
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
