Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459470;
	b=kKYkwPGShr9vuPkl47v8Wgd7hWa3a+3u+qtPHehAws6Yi7fXMVmwUHSjSC6kmvif6A39
	 Rzsw4LFrh4sf8F3CfMCXPAOTskf6Wp17J+S4CJaJv9ocx+kshaAnfbSPizGAL0LRYeRLD
	 ybp5Z3H9As1VmzrSKov401VRwOTmOg4alWp97oeJJ/gSGXjcPd3+7ZtOemnW+XCHCT0Q/
	 H4P2Jx9Z04VNmHOo0dWimHX63M73sJaGc5yVgPSAGBl9N4E9ZngK/oacOsIfw0hs70FpW
	 TWmiUpT9QpTw6z191gHMNTyUw3bjaDgceRy/mvDMMAuAEdfmdvU/aE94tgjt3VKgmVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459470;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AXlwVJHzsiR5G8vRua5S5Kpq7hsC6dfgMA6ZgiFTrzI=;
	b=glVZHDbG3L0s50oP5K40ak+t58j05OrnsLkG27Cpokar1AndsYhkOK56ZxSq9mUjjF2G
	 R3jvEqdaD0QGJVYu3vrJvNH9Q5wSLwEZGYdeHwDQbFQCBI+2C3sg2/vU74pRH9YGUdKJO
	 wTWH4NtosC4SHyE261JDOESsGpY1pbR+REXYHHXc8MEU9aOGNXMefXLRi0Os+lOv9nVIA
	 WXiSerdIIHqehsWK6cxgaLA5XMCWOisfY2iRPJNi0Lg7YIlvGw/vFhf6HDbWriMZju2gM
	 7B0dyFyuvpAfioGB2AfkJ9+UOXCemnBJiyr5qhGjwqE5zN0T1TFDraT9W6s+6/HtYIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muYlG5ru;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CA606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muYlG5ru
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83CD1F000C4;
	Tue, 20 Oct 2026 01:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459470;
	bh=AXlwVJHzsiR5G8vRua5S5Kpq7hsC6dfgMA6ZgiFTrzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=muYlG5ruaxzQhCUq+C1V8VljAz+sN7m3orGnx8snmzpRPGNpXCNSC3Wr5Wtxfj3cG
	 bHZfzhx3nH/vcgyjT1d/dkhO/zGf3QpEptNDj//8eC/IMtqprugPH+0ydhb9UmvD4J
	 C4/IIt+fQ+Yh80LRVqtfrv1vr000B6QX/DX9xfPgolKHu+8b6HQ2Yak8flvwi1kXF3
	 N6nyZgG8sPHZoxN0pYY6ehKNBmrqS5OYTLcoOdOFmz49M15Znj/494iY59mFMeGnYm
	 Ox2zhnIWqn9Nwqp6Tnu/tV9l87fbHT0PNzeiVRSKaiPxgfFRK0hdKibdEl2I1RPZHV
	 DPsIT0Ss/6usA==
Date: Tue, 20 Oct 2026 02:24:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 4/9] cxl/region: Calculate peer distance only for
 reused targets
Message-ID: <20261020022423.2d5ffeb5@jic23-hlaptop>
In-Reply-To: <6ac7f8fae75f7cd29b5d530a552aec2b6c6169b5.1792263750.git.alison.schofield@intel.com>
References: <cover.1792263750.git.alison.schofield@intel.com>
	<6ac7f8fae75f7cd29b5d530a552aec2b6c6169b5.1792263750.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 12:19:49 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> From: Richard Cheng <icheng@nvidia.com>
> 
> cxl_switch_port_setup_targets() calculates peer distance before
> searching the existing targets. When the endpoint needs a new target,
> the calculated distance is never used.
> 
> Move cxl_port_peer_distance() into the matching-target branch,
> immediately before check_last_peer(). This avoids unnecessary ancestor
> walks and per-port region lookups when adding distinct targets.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
I'm assuming the commit message change Alison just posted or
something along those lines.

> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4ab5a1d025a9..8bfebe3e1025 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1485,10 +1485,10 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
>  	}
>  
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

