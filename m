Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396948DB24;
	Fri, 16 Oct 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174992; cv=none; b=Lp+Q4HXCG8zIRw7mfBT8iTulQgU8on2PSurTd/SwdfGT+35G+HiXkGc+2FsSiKJFwt7lT9z7ICrsGYjX9cjPjudoQWAgqyjDbKOY/F4WSV7RAKvKcimlpAS+RW7EdUmYxmRMzluj4I71uOzG4OLws0rgMvuKldTEl5Zpy6T9WBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174992; c=relaxed/simple;
	bh=V4kTvb8KxENuXTDXUZnUppPHUtA6VPzAYLoRLYt4mM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2mzWBj4vWtKKGSrsln3W3yPCifxnCIq5XtwxDiTP9owDVzcTfC+8jARwbJLrUf+41TPgxlkmvbRyoojTDgTcFcyh/HGVXDbUw0CuQfkvg0pu6KdYFs2PZOFNZU6SZimAJhY9nkJqJeXMyyVbV3cfbdoWoj3HGVoymP0s83YgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtWh3LLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtWh3LLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A1C1F000C4;
	Fri, 16 Oct 2026 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174991;
	bh=NCuBVyLGp46SfyUfhIc5HTTXXjg7uyN/3+5PL1A1ACs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TtWh3LLtDhjYZYa6x+9WtVqe+rptuZYVD85fcIZYMvBxttK+w1LZ42vd/G9wgp1sC
	 M+mhBYc3ZqZF3xL9bZG4Hp1GhK9EZR8kUIm3M28z1aEOqZtahimCI89+tXRH44gC1r
	 X4kyer4h9BJ43D+FhnAuRjQg+oiT1T8h5AsKAf6CS+0EUCOGJIMDwOhmut4eMV3Xl9
	 O6I0xsCHP/MmAaZ4tmOZ9JeJ1anpaa8GfQ02TZRD/yX4ZyMVQjOQo6gkJ1R2Ydt9mY
	 mDx620hiWHCAa/aZV5nXLbJp+Ns8Wpyh64BMsQQUQOBDfNx5dEMSoky9zpEhm66DcM
	 4J8wulQU664dQ==
Date: Fri, 16 Oct 2026 19:23:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
 gourry@gourry.net, rrichter@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cxl/region: Calculate peer distance only for reused
 targets
Message-ID: <20261016192305.1d1e01c5@jic23-hlaptop>
In-Reply-To: <20261015094059.46818-1-icheng@nvidia.com>
References: <20261015094059.46818-1-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 17:40:59 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> This patch depends on Alison Schofield's v3 "cxl/region: Refactor
> cxl_port_setup_targets()" series [1], this is inspired from that serie

series is a an odd word in English. Singular and plural are the same.

> as well, since her serie contains no functional change, I pull this one
> out as a standalone patch.
> 
> cxl_switch_port_setup_targets() calculates peer distance before
> searching the existing targets. When the endpoint needs a new target,
> the calculated distance is never used.
> 
> Move cxl_port_peer_distance() into the matching-target branch,
> immediately before check_last_peer(). This avoids unnecessary ancestor
> walks and per-port region lookups when adding distinct targets.
> 
> [1]:
> https://lore.kernel.org/linux-cxl/cover.1791860305.git.alison.schofield@intel.com/

Use a link tag.

> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> I don't have available HW for multi-way interleaving setup, so I can't
> exercise the case optimized here. I would appreciate if someone is
> williing to validate the actual benefit of this.

Maybe give it a spin on qemu.  But it looks like it's just a code reorder
effectively so It would be very odd if it is a problem.

I'd just put this as a comment on Alison's series as I don't think
that has merged yet.

Seems like a nice little optimization.


> 
> Best regards,
> Richard Cheng.
> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 50f4830c225d..efd173c57dad 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1666,10 +1666,10 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	if (cxl_rr->nr_targets_set) {
> -		int distance = cxl_port_peer_distance(port, cxlr);
> -
>  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
> +				int distance = cxl_port_peer_distance(port, cxlr);
> +
>  				rc = check_last_peer(cxled, ep, cxl_rr,
>  						     distance);
>  				if (rc)

