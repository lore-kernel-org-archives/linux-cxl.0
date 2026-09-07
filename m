Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5F3ACA77
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788824534; cv=none; b=oy1ukt5AL0bWtc62u3oRXUigHHTCLPgJFTWr2EbeC+HSy9Yti7Uygvemv7T18C+o+Wsb0Tnf+y/eBzl6M2Jj+vtTE0fTtXgepBoW0MykMfDcQ+Z8q5MdfBhzfVOdU1LkKh21SGcrlbrjKRH0FiR6kqEWrdrFc7rwP/NSVvRWAoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788824534; c=relaxed/simple;
	bh=7/ahrJJWTjEL8tLNoSZE+U9rWW4voU46DQMu7DpI/EY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDJMDCXW8Db6k+NDVuv4Z8PkJOB7Kg2rUQhZG0WFvyiroQ1dpcKI4sWs0B3iJ4Kck0vAWEdjbliCpbV5/ZeExIyxGMbm+eJ2Q10b3mbJ4yG79i7Kt7iqYX7y0o5XWOYfLqZsQje9WYwYKUqTMFt3s8YB0impUSelvvC/yp6Yo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3sX1eYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3sX1eYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BC11F00A3A;
	Mon,  7 Sep 2026 23:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788824532;
	bh=wJdnE0AxT9jzDJtYvcNFvcynKyuIuG2bbrvkwiYjGxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C3sX1eYfQYzQnwy4kmLYGogf4CYpBPV4uAuhQ4SDnXTvzmFl3OIRy3hE0VvZ/EjVS
	 OMSRm+WKdp4b94x9aB2beHkCshh9MZF1t2W6+ZrA4gBQfT4ad3M3pM7l3mCh8JZJhy
	 fDt9jXktGcgv/rDP+WNQaeRC8x+BoWf3SMlsNMkPbkwFc1oN1uxQJxRK5g0xp/c1tM
	 KALiYRAW8GEb+ybgXcm1qI+Wmi+Cx0RhOh75jR0BzVSZ4xnkRMPW7CHq8XHITAeM+O
	 VbgkVktym/+q0Ui7DRpqmPYDQQVZCzj537+RJsdh3HOl22aQfqA/hmm170ntFZzpvL
	 Z4a9LbxclABDg==
Date: Tue, 8 Sep 2026 00:42:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 3/7] cxl/region: Generalize endpoint position mapping
Message-ID: <20260908004207.5875e800@jic23-huawei>
In-Reply-To: <16d749d4eef2f6f142bbf6c48e4210e0587e466c.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
	<16d749d4eef2f6f142bbf6c48e4210e0587e466c.1788475206.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 16:23:45 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Endpoint position calculation currently relies on the requirement that an
> interleaving root have the same granularity as the region. Auto region
> creation builds the position by multiplying by the parent decoders' ways,
> while user region creation selects the root target with 'pos % ways'. Those
> calculations are sufficient under the current granularity restriction.
> 
> In order to support mixed-granularity regions, that granularity restriction
> will need to be removed so decoder granularity can change between levels of
> the interleave hierarchy. The position calculation needs to account for
> those changes to produce the correct endpoint ordering.
> 
> Change the position calculation so each decoder's contribution is weighted
> by its granularity relative to the region granularity:
> 
>     position += target_pos *
>                 (decoder_granularity / region_granularity)

In the code target_pos becomes parent_pos. The parent_pos naming
seems more logical to me but maybe I'm missing something! (more
that likely given it is interleave maths!)

> 
> Use the same relationship to select the root target during user region
> creation.
> 
> Weight each level by the region granularity, passed in by the caller,
> rather than by the granularity programmed in the endpoint decoder. The two
> are equal for most configurations, but not when Normalized Addressing
> leaves the endpoint decoder programmed passthrough while the region
> interleaves.
> 
> For currently supported regions, the new weighted calculation reduces to
> the existing position calculation and produces identical endpoint
> positions. The exception is a region wider than a same-granularity Mod3
> root, where address bit routing programs the level below the root at the
> region granularity, so the ratio derives a weight of one rather than three.
> A later patch in this series rejects that layout.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
I'll assume you'll clarify the naming thing.  Otherwise this LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/region.c | 69 ++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6a698f36aa6d..506b1cba1a92 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

> @@ -1951,24 +1959,29 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * cxl_calc_interleave_pos() - calculate an endpoint position in a region
>   * @cxled: endpoint decoder member of given region
>   * @hpa_range: translated HPA range of the endpoint
> + * @region_gran: interleave granularity of the region
>   *
> - * The endpoint position is calculated by traversing the topology from
> - * the endpoint to the root decoder and iteratively applying this
> - * calculation:
> + * A region position is the index of a region-granularity chunk within one full
> + * pass of the region interleave. The position is calculated by traversing the
> + * topology from the endpoint to the root decoder and accumulating the
> + * contribution of each decoder level:
>   *
> - *    position = position * parent_ways + parent_pos;
> + *    position += parent_pos * (parent_granularity / region_gran);

Here is the naming difference from the patch description.

>   *
> - * ...where @position is inferred from switch and root decoder target lists.
> + * ...where @parent_pos is inferred from switch and root decoder target lists.
> + * The multiplier is the weight of that level: how many region positions pass
> + * between successive advances of the level's target index. A level that selects
> + * a single target contributes nothing.
>   *
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
>  static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> -				   struct range *hpa_range)
> +				   struct range *hpa_range, int region_gran)
>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	int parent_ways = 0, parent_pos = 0, pos = 0;
> +	int parent_gran = 0, parent_pos = 0, pos = 0;
>  	int rc;
>  
