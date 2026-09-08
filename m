Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146465632B1
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905826; cv=none; b=Wf2bODng0FYCJ95x0IRKxPDvboxysg1qVBiV6ol8yqZqW48lyxkj8lH9IBJOu5cMYZO1hMp5H+yO5/0VdR3pGZKl+9M2rWXtAAcJmJ1O4FllOV90/odN9g79fcy9jYng2KuoLBBExVEMl9yJ0/Ctf+uNjHqetq7mBhDTPs/7V28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905826; c=relaxed/simple;
	bh=epxmNVGc5edqewabNJdQiUw0BBLPLp/bV+nqoVkbvSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIci8qUcj9Z+mfnI7M8vKpUHGczaoAUlfPsfhjLVyc0NNjOAdxYAB7OuUk19ajjNcgnrpzoeaoJCX633Fftk/cScTEw8Z1XEtbSKNyou+ZjTczEV1XR2+mc2BZJeTMuOQiI8dmWonz8FelpwfLkgEynlLiUMeHJEoLLQo++fzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC5gKs0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC5gKs0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F1D1F00A3A;
	Tue,  8 Sep 2026 22:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788905824;
	bh=BfO12Lo/0cuc10b5yVpRw0YPgNgnXd0Yqv5/ENZBI+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TC5gKs0CMdrsF1WOP0z05pe/FbN3ny5uwuaPp+ejwQRCHFStJvkN/7AR+MTJh5v2E
	 PABpTLAbJAT6oSAROYfRKYbydwooRz3ah50wtYVVdaf0q2g1lTDZcV2gpLTgcpqQK9
	 /52JC17k1r2XMtwK2eSBK9R5f9jNBPbKq1IimdW8RE2mwZ/2D/1AODvuSnX9SdNtCZ
	 ornYe3/Ruam5bxroxe+lmYL5YCI12Hl9LOXVxOEUnjqO+FliQShYUmC9h0tSVzv1iW
	 eTbOr4lB0TtUeVHYbCQvErTINXGv26pZo/KDGxs70wq8rve1DP71z78o9yi+J7OK6k
	 7KbZhSHNsz+aA==
Date: Tue, 8 Sep 2026 23:17:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 benjamin.cheatham@amd.com, Anisa Su <anisa.su@samsung.com>
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA
 partition layout and ordering rules
Message-ID: <20260908231700.1a8d53ec@jic23-huawei>
In-Reply-To: <20260908102124.2231730-10-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
	<20260908102124.2231730-10-anisa.su@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 03:15:12 -0700
Anisa Su <anisa.su887@gmail.com> wrote:

> DC Partitions complicate DPA ordering. Add a DPA Partitions section to
> cxl-driver.rst describing spec-mandated and Linux requirements for the
> layout.
> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
A couple of minor potential tweaks.  Otherwise LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> ---
> New patch in v13.
> ---
>  .../driver-api/cxl/linux/cxl-driver.rst       | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index dd6dd17dc536..f0742d6c86c3 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -181,6 +181,44 @@ A Memory Device is a discrete base object that is not a port.  While the
>  physical device it belongs to may also host an `endpoint`, the relationship
>  between an `endpoint` and a `memdev` is not captured in sysfs.
>  
> +DPA Partitions
> +~~~~~~~~~~~~~~
> +A memory device presents its capacity as one flat `Device Physical Address`
> +(DPA) space divided into `partitions`, which Linux lays out in a fixed
> +order::
> +
> +  DPA 0                                                     end
> +  +---------------+---------------+---------------------------+
> +  |      ram      |     pmem      |       dynamic_ram_1       |
> +  +---------------+---------------+---------------------------+
> +  part[0]         part[1]         part[2]
> +
> +Part of that order is required by the CXL specification and part of it is a
> +Linux choice.
> +
> +The `ram` and `pmem` order is mandated.  CXL r4.0 section 8.2.10.9.2.1 "Get
> +Partition Info" (4100h), Table 8-310, mandates that volatile capacity starts
> +at DPA 0 and pmem starts at the DPA immediately following it.
> +
> +Dynamic Capacity partitions only need to be 256MB aligned according to
> +CXL r4.0 section 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
> +(opcode 4800h), Table 8-347. So a device could leave a gap between ram/pmem
> +(static) capacity and its first DC partition, or between one DC partition
> +and the next.
> +
> +Linux follows the static precedent anyway for the partition it maps: the

Maybe "Linux chooses to only support...

> +first DC partition must begin at the DPA immediately following static
> +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
> +a device with no static capacity at all.
> +
> +Currently, only one dynamic partition is supported. A device may report up
> +to eight (CXL r4.0 Table 8-346); Linux configures the first and exposes it as
> +`dynamic_ram_1`.
> +
> +Support for additional dynamic partitions may be added if devices appear
> +that need it, which is what the `dynamic_ram_1` name leaves room for.  Until
> +then a device offering more than one is still usable, just not in full.
I'd drop this last paragraph. Predicting the future is tricky, even with a may.
Hopefully anyone realises that if something is needed Linux doesn't support
they should propose patches to add it!

Jonathan

> +
>  Port Relationships
>  ~~~~~~~~~~~~~~~~~~
>  In our example described above, there are four host bridges attached to the

