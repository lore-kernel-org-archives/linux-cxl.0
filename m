Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E551F03DE
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777506342; cv=none; b=ONVfKwYvC/pPviTVGVIfcUcGdTqzQ7V8iHx9IATl981LZKCIRMnkuZltdA/Qxo4GZ1zGbPYWEVlCBeAe2HQF434SLxYC8YG/cP8miC2LIyvIDgoBxQgsvbsME64OeEuxeHtYsYBZihYUYoEOFGkOCimjCaekQzPyLMB7Mk7Ht/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777506342; c=relaxed/simple;
	bh=Sbk71sEyIQiXTQclerL+M2o+iu83Frk1dKu6usx+Wkw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CA1Jq4ovz8AhxapAt01OoLiZC5rLZuPJqexhwt9+oflCm7QVHP4g/DKBVEkfGHc9hlCYZvgmITdZ89EG/Fy0gzglVUTIdwjKSn1EmxnrVKGe5YVAj/RezUWxUkfYqa5qZKNZL4rVKrL7us+7qLuNnoGRjhGShDrISyoJxIvgF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLsqPMR+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLsqPMR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9543FC2BCB3;
	Wed, 29 Apr 2026 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777506341;
	bh=Sbk71sEyIQiXTQclerL+M2o+iu83Frk1dKu6usx+Wkw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uLsqPMR+hApj1Y13jG5zacKU5SEWBd01Usgjjgu4oF0Ue33VK1eMRE55Kfn+g8VEE
	 7O3CM4M7OOIgJ8CfYj+HOajUnVJyxlzKxQrSfGiTRiLu6H1xoJUaQ5+7qOWtlQxdGA
	 P6rBu+OPA2jmUzZAN1RywNktJW8F7qf7arqc/5LgPQXy3lw1UOxz64P2fxRVXc1GXP
	 sDMvKGy5ZW84dnFbGgjtjriXSo+61r3Pr2dfCmHolvfWbVkjsit9pcmW0LTL2iKiIh
	 3B5GqUv/kXi0/TeS1mInJ+IHtdbmGf+XI1cSFWe9pW52gLk2/Q1fCf0drJU1VSrqWM
	 pe6bITLaRj/xA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id AF3C1F4006A;
	Wed, 29 Apr 2026 19:45:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 29 Apr 2026 19:45:40 -0400
X-ME-Sender: <xms:JJjyaUwgrlRRrteUgP-JVtaNsMR2xkfy-nfInRS-7p8WgYjYhwLDww>
    <xme:JJjyaXUDobvoQm_HBENRBtsAXYlOhSF0II6JYLNMk9R1y-pBdhOUjpLQ6ivqfD6Xa
    FJo2KUGPHKlver89uZsRQI0Fhb1rVEE6yOpIZ7w3YO010JQyz4D>
X-ME-Received: <xmr:JJjyachUEsYMYFRc0XIrCyKWr9n_atdQZgYEKaMJRaE4LKjTC1Vf3eD_n1uOXDajTzoI2Z7RQ6GFtlKjSk1SOTOvECVLRe89EnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekheejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpedfffgrnhcuhghi
    lhhlihgrmhhsucdlnhhvihguihgrmddfuceoughjsgifsehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepvdegheeikeetleeuffeuheefjeejvdejvdevteefgfffveeh
    vdeuvdffveffvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddujeej
    vdeftdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvghlrdhorhhgsehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegu
    rghvvgesshhtghholhgrsghsrdhnvghtpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghl
    rdgtohhmpdhrtghpthhtohepvhhishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthho
    pegujhgsfieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JJjyafDmQtu8w7VP10SmIKM9ymUuSZXA4BJn8PAJenvHVT7GW7nClA>
    <xmx:JJjyaauCdqS7MP0QgzGhXS0Y2CWy1p0E4UlUCZGXuwSgGJ0JT6KiVA>
    <xmx:JJjyabdCNyBVGH-xqGs5QbhOJhUWYNSfqK15h1WPLbKaqmLFYeu8tg>
    <xmx:JJjyaX8i7xLz1_3EjkMYrYsubHVFN-cj6lZK2Vvs93HlpAn1mm2pOQ>
    <xmx:JJjyaWSqlwpffIn7CgP4FEPgkCe1mJdVHWBTfZehh5ZUrDc7tQ70Oq6I>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 19:45:40 -0400 (EDT)
Date: Wed, 29 Apr 2026 16:45:38 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, 
 jic23@kernel.org, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 ira.weiny@intel.com, 
 djbw@kernel.org
Message-ID: <69f29822f26c2_3291a9100e6@djbw-dev.notmuch>
In-Reply-To: <20260422230237.2599333-8-dave.jiang@intel.com>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-8-dave.jiang@intel.com>
Subject: Re: [PATCH 7/7] cxl: Fix double unregistration of CXL regions for
 type2 devices
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dave Jiang wrote:
> For a type2 device cxl_memdev_attach_region() is provided as the callback
> to devm_cxl_add_memdev() call. In cxl_memdev_attach_region() a devm
> action cxl_endpoint_region_autoremove() is registered to remove the
> region when the device is removed. And this action calls
> unregister_region() on trigger.
> 
> When the endpoint port driver is probed, discover_region() is called
> to register a region. The call tree becomes discover_region() ->
> cxl_add_to_region() -> construct_region() -> __create_region() ->
> devm_cxl_add_region(). In devm_cxl_add_region(), unregister_region()
> is also added as a devm action.
> 
> When removing the cxl_test module, the platform devices are removed
> and that triggers the endpoint driver removal and calling of
> unregister_region(). And then when the mock type2 device driver is being
> removed, the devm action of unregister_region() is called again, which
> causes a kernel warning about double unregistration of the same region.
> Add a check to see if the devm action is already removed before calling
> unregister_region() for cxl_endpoint_region_autoremove().
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> - Need to add a fixes tag when the patch commit that introduces
>   cxl_endpoint_region_autoremove() is stable.
> ---
>  drivers/cxl/core/region.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 61a3efdbf3c9..1a7c0895bb88 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4296,7 +4296,8 @@ static void cxl_endpoint_region_autoremove(void *_cxlr)
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +	if (!devm_remove_action_nowarn(port->uport_dev, unregister_region, cxlr))
> +		unregister_region(cxlr);

Good find, but no, it's always a mistake to use
devm_remove_action_nowarn() outside of Rust.

I am drafting a replacement fix for the issue Sungwoo reported as the
approach there would also apply here. The main observation is that we
need to separate the remove action lifetime from the region lifetime.
