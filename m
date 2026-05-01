Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE440DFBB
	for <linux-cxl@vger.kernel.org>; Fri,  1 May 2026 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777600821; cv=none; b=jZ7OVzaqHA0KPTMnCY31e3AGq+Cp42pkDrr2nHMcPleDcucB5i+F7rfu7eG3sf26IlosVRF85y0PINwoChzwKBGgmmjn2d+cuI9LmtzcGJyIyXwus6mhZRJVmV9TtiyCNLMzB25f8Sc04W15tprDg/aP5Ez6oieWRFtuhyOIMG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777600821; c=relaxed/simple;
	bh=O2VM7hB7aWltnRsWYaPLFumoyCg8YyRVMbYY/SU68bc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=F5VpLTug7HZFJIbRWEasHkanzTsqDqf1CJH/WKQDNatgkNku3WXmZpki3ETW8y5Xg4CSC1XObVdj5XzwHCr05WIgQDm2SHsIsjhEH3DNER3nkLFM+oxinr9L3jCEwELq5pbccbkiRnSRfkEGM0JBFv8yC7Jhkoh65aFeWLp2ajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR6MrdvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR6MrdvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4DEC2BCB9;
	Fri,  1 May 2026 02:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777600821;
	bh=O2VM7hB7aWltnRsWYaPLFumoyCg8YyRVMbYY/SU68bc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CR6MrdvJiDVo6svSAuyLepJz2byqu4+Cv7vSWMnm1nM5JiNMVIIEWKGkND3XDnP3P
	 MC5Tmn/JxZ+HQdveMzpVmhd2VOFkRg+qSw8yK5x124CUrUP75fAMDTdaqHRukZpLsf
	 csDv+A2RJPuo8GsXfuYeGjHe9Ca9jOvpiTuRoE6NFz0UhKhfkxQictlgZHDqBDXXR4
	 SqyPcjfmuCZ8nwZz7nPRz0wukc0FB0ucE+BMLERelk95Egf1BXtCzOiCenXZBk8zTj
	 mlcv8EG7KSwdsTNxRaM90fGROlWK2HP8XFmniWVz4ZjaqB+wWQcGLlREONtGdNaCi9
	 zubUrGvCZHF5A==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 17ECAF4007A;
	Thu, 30 Apr 2026 22:00:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 22:00:20 -0400
X-ME-Sender: <xms:NAn0aU0fh_s-RL9VDO47-19PTqzzFFR5zG8CyzbqKBcgrMQN5L-JjA>
    <xme:NAn0abpob5ftWURrO5WgKmyQ3j18e24qs1HPv3VqCWWwCkU94hMLD5GhDCXGVDiEl
    1kD3U_thgRfSXDgypq_sGHqDc-_rRAPH04Jakziwzym9RGWUMP7kZs>
X-ME-Received: <xmr:NAn0aRXspN10byJZI0TIuCbv2AeOafPv691BI8q6LHGUaR6AdOy6Lb8EoT3zQrvwXcKermHLYcDdvcWBugxQgeRl4pNzFExaaUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevkfgjfhfugggtgfesthejredttd
    dtjeenucfhrhhomhepfdffrghnucghihhllhhirghmshculdhnvhhiughirgdmfdcuoegu
    jhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeigfeihfehueejtd
    efiedvvdeujeejtdekjeeivdehheeiheeiudegheehudetgfenucffohhmrghinheptgig
    lhgurdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddujeejvdef
    tdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvghlrdhorhhgsehfrghsth
    hmrghilhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrlhgvjhgrnhgurhhordhluhgtvghrohdqphgrlhgruhesrghmugdrtg
    homhdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugifrg
    hrugdrtghrvggvsegrmhgurdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvg
    hlrdgtohhm
X-ME-Proxy: <xmx:NAn0aUpkJJWuMvlQE2Dr2dSDLVO7FGvK-kIO3rUbVHOsQ4KuLcNqmw>
    <xmx:NAn0aYAH7y7a2Fg3v-edc-24NZB5kC3dZfL75ETDGEF1bM0bYMgkIw>
    <xmx:NAn0aQiphX9rpH2sYFJ8xUuOkUHHoqimIqjSoa3CfSkk1GNFZFT43g>
    <xmx:NAn0aWaR5rigyZYJXKJTdKtT-0zBZZZ7WUQV2CdpRg4Z7Yj4zKt3hQ>
    <xmx:NAn0aRmdRyHs6npi9Du-YMHBRWSlFqnDDfDBt7egz-h--ZZVJgZostGu>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 22:00:19 -0400 (EDT)
Date: Thu, 30 Apr 2026 19:00:18 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 djbw@kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
Message-ID: <69f409325f7c0_3291a910046@djbw-dev.notmuch>
In-Reply-To: <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v26 6/8] cxl: attach region to an accelerator/type2 memdev
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Support an accelerator driver to safely work with an autodiscovered
> region from a committed HDM decoder through:
> 
>         1) an accelerator driver cxl_attach_region struct with attach
>            and detach callbacks.
> 
>         2) a specific function, cxl_memdev_attach_region() keeping the
>            required locks for finding a region linked to the memdev
>            endpoint, and
> 
>         3) invoking attach callback while keeping the locking allowing to
>            work (ioremap and other internal stuff) with the related physical
>            range by the accelerator driver, and
> 
>         4) linking a detach callback to the endpoint device removal where
>            the accelerator driver can stop using the region range.
> 
> This covers the cases of a potential removal of cxl_acpi module or a
> accelerator memdev unbinding from cxl_mem driver through sysfs.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c          | 118 ++++++++++++++++++++++++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c |  37 +++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h |   2 +
>  include/cxl/cxl.h                  |  17 +++++
>  4 files changed, 171 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..68f5a1fd1b1c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2711,9 +2711,16 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> -	if (rc)
> -		return ERR_PTR(rc);
> +	/*
> +	 * For accelerators/type2, region release linked to endpoint device.
> +	 * See handling of cxl_endpoint_region_autoremove() below by
> +	 * cxl_memdev_attach_region().
> +	 */
> +	if (type == CXL_DECODER_HOSTONLYMEM) {
> +		rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}

A couple problems here.

1/ Nothing stops a CXL class device from implementing a decoder with
   CXL_DECODER_DEVMEM (HDM-DB).

2/ This breaks the automatic cleanup of autoassembly failures in
   construct_region().

We simply need to support multiple independent sources of
unregister_region(). Stay tuned for a scheme for that.

>  
>  	dev_dbg(port->uport_dev, "%s: created %s\n",
>  		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
> @@ -4043,6 +4050,111 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +static int first_mapped_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (cxled->cxld.region)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * As this is running in endpoint port remove context it does not race cxl_root
> + * destruction since port topologies are always removed depth first.
> + */
> +static void cxl_endpoint_region_autoremove(void *_cxlr)
> +{
> +	unregister_region(_cxlr);
> +}
> +
> +/**
> + * cxl_memdev_attach_region - bind region to accelerator memdev
> + *
> + * @cxlmd: a pointer to cxl_memdev to use
> + * @attach: a pointer to region attach struct with callbacks for
> + * 	    safely working with a region range by the caller
> + *
> + * Returns 0 or error.
> + */
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
> +			     struct cxl_attach_region *attach)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	/* hold endpoint lock to setup autoremove of the region */
> +	guard(device)(&endpoint->dev);

This does not handle the case when ->endpoint is an ERR_PTR() because
the memdev never attached in the first instance.

> +/* Called at driver exit or when user space triggers cxl region removal. */
> +static void efx_cxl_unmap_region(void *data) {
> +	struct efx_probe_data *probe_data = data;
> +
> +	probe_data->cxl_pio_initialised = false;
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +}

I do not see how an async event can safely zap that ctpio_cxl space with
zero coordination with the driver, and I do not think you want to burden
the fast path with new locks to coordinate this.

Can we please stick with the violent but simple "unload driver" approach
for now? Someone removing cxl_acpi, disabling port drivers, or disabling
the cxl_mem driver gets to keep all the pieces. Just like force
unloading your storage driver underneath your root filesystem. Do not do
it unless you want to see the fireworks or test various hotplug flows.

This graceful handling of something that should never happen, outside of a
test suite exercising CXL core object lifetimes, is not a near term need.
