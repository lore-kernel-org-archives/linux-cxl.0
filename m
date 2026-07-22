Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF523183C
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784682475; cv=none; b=aIg8+TxHvsPoBAObeFnPL21zlCL5qz0XyzOs3nb5+tqdysQFDolI9wWNrt3K/+314i8srIqLEwN1KXzsHrKaUuq7L9uFGsycpWHQRnIBokAjXeOgSDGoiNwO1Pdr2jEmS3XvSJYk+u3sxWvx5MSS//u5z7kxuT7Uv3sJ4tEgYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784682475; c=relaxed/simple;
	bh=iV/5GjEgaYKNU6sbqUC5QsRQxdSz0sDuhSDRnjX4aRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWZyeTdtbo4DmOVyES0Mb4nJ+tDRUqE+1JDfN3rMHVfRuj0ZKvLr+mE9XikE/0Y8hnHazsJA8ZcQ8xx1JC37Y0WwCvqQMGRr7KnQQxc0FDPJPhJz34pWIMfo0oxDVnPwvgndldqE2PxOHILoK0g+lHb7u3eC63cbzQWW7DQv/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkLAalUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkLAalUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2662E1F000E9;
	Wed, 22 Jul 2026 01:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784682474;
	bh=VAx4wqaKI1zYYnc2DMGog4ueTt9L7yCc+fNjOGeaJ7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OkLAalUvtXNkHXuhGFPysClqFqP87MwTFNtt/VOOE3dh1d68Yq+dFCLPQe7wXoqLu
	 yX0atLHPdkRwzXx378bhL1E2F3lDshHOC/4dab9SBY4kSaolPzPBpl2loZMcdBw0RY
	 w3kw/U0s4fR0GL+/itKshiOdKnrungncqI91+rjvjSBbyE/jiQlCKzg4CklMGYSiIJ
	 8RFpoFO4hKiYhFwR/LiJ/8iQLIpZMAMvK7QqC8/s2E4F3d1LXa+Nu1mHEqYopitDtK
	 OVOC3tra89BCoGJYR0Qcx0uFREiHVp2mhdHNxF976392n62BtOE4QPB3P7nNFPC5nO
	 JzU1dCnHPr7rQ==
Date: Wed, 22 Jul 2026 02:07:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Richard Cheng <icheng@nvidia.com>
Subject: Re: [PATCH v4 3/4] cxl/hdm: Make switch decoder target parsing
 endian-safe
Message-ID: <20260722020749.1826e787@jic23-huawei>
In-Reply-To: <f98abc5edccc4fed9250d29df76ac677e3e51702.1784595445.git.alison.schofield@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
	<f98abc5edccc4fed9250d29df76ac677e3e51702.1784595445.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 18:59:39 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Switch decoder target IDs are stored one per byte, starting with
> target 0 in the least significant byte. The current code accesses
> those bytes in memory order, which only matches register order on
> little-endian hosts.
> 
> On big-endian hosts, the target IDs are reversed and the decoder is
> associated with the wrong downstream ports.
> 
> Extract each target ID from the register value with an explicit shift
> and mask so the target mapping is independent of host endianness.
> 
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Suggestion for explicitly handling the endian issue inline.
I'm also fine if you stick with what you have here.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/hdm.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1f995191baf5..077aface1a2a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -976,14 +976,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
> +	u64 target_list;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl;

Maybe alternative approach along the lines of:

> -	union {
> -		u64 value;
		struct {
			__le32 lo;
			__le32 hi;
		};
> -		unsigned char target_id[8];
> -	} target_list;
>  
>  	if (should_emulate_decoders(info))
>  		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> @@ -1122,9 +1119,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));

		target_list.lo = cpu_to_le32(readl());
		target_list.hi = cpu_to_le32(readl());

or just have a byte array and

		put_unaligned_le32(&target_id[0], readl());
		put_unaligned_le32(&target_id[4], readl());

> -		target_list.value = (hi << 32) + lo;
> +		target_list = (hi << 32) + lo;
>  		for (i = 0; i < cxld->interleave_ways; i++)
> -			cxld->target_map[i] = target_list.target_id[i];
> +			cxld->target_map[i] = (target_list >> (i * 8)) & 0xff;
>  
>  		return 0;
>  	}

