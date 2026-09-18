Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376513CF209;
	Fri, 18 Sep 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760157; cv=none; b=jnejDTSWwUnmWeh0+n+kYAFcu+ytWxzmhJWAB3jwBU4R30ViYlKtevGVYeUCmw+TELrcS0tBfg1usWPZaS/btQzUtFjpjRsEX6CO9Q/IPauVzGDEuvG1DUKnn1P8VmqdmwM8K1tmdum244Y25iyt8XQ8rYgAjjMZHxY1n7C89AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760157; c=relaxed/simple;
	bh=+fKPcxLXju5lZu5zZhxP1QAODeIgkYcDYvhPOaNeTYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1WtQrc9guC883L9PMzElkPupxyooI5d9/DzBMcwwD92GIzjS8EJqmoI4mduDqWkvm3Vkx0mQEzW/UxjK6TiGigtV0cFBgSusXwTCa+QltEYOWnqrXIiAIPobo+izjbjDsXbCKYIuPW1zYrJqr7N9eziQ3WDfns9Jl52sPB9ybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhHnvh8i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhHnvh8i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11631F000FF;
	Fri, 18 Sep 2026 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760154;
	bh=1ajIuw4DcZ5aRzTfYwrSY5jagf7KcXQsMJC4bn5QUio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LhHnvh8iGSdg4AZkKj3hpr4pYqdEXzg3gTEECRQ2vUjYxC8AVmDJDfnkJYrmRPJkL
	 Reyi+cQxs3deCqd7zOK2sx2S+fQk5N15LNQFsXg6nT1o/iaC9LV24UAzk/qYNMiCB+
	 GggSA5Mz7wQI6sJ5/NfWitndhBJSpm/0QB2pN/CYOQuZp4S4TAzSqxs3RivizKYTuk
	 Nn3iR1YOwB4ZaJlWos8nsokjITaV2vmrJb+t1rUhSVjNtGh5LgDN9IN5msAbOlB/bB
	 pqgRs4h7tbqJ0vvlZxvLLcujT9U4+iFq5b2dHQL6Gq63JnSAxqcMidagdysRTWT/ok
	 y+Ey6ghEbulpQ==
Date: Fri, 18 Sep 2026 20:35:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gaobin Huang <huanggaobin23@semi.ac.cn>
Cc: Ira Weiny <iweiny@kernel.org>, linux-cxl@vger.kernel.org, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Li Ming
 <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-kernel@vger.kernel.org, Anisa Su <anisa.su887@gmail.com>
Subject: Re: [PATCH RESEND] cxl/mbox: validate the DCD extent list counts
 against the payload
Message-ID: <20260918203551.4bf64538@jic23-hlaptop>
In-Reply-To: <20260917104656.2658591-1-huanggaobin23@semi.ac.cn>
References: <20260917104656.2658591-1-huanggaobin23@semi.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 18:46:56 +0800
Gaobin Huang <huanggaobin23@semi.ac.cn> wrote:

> __cxl_process_extent_list() trusts two counts from the Get DC Extent List
> response: returned_extent_count bounds the loop over the flexible
> extents->extent[] array, and total_extent_count decides when the enclosing
> do/while is finished.  Neither is compared against what the device
> actually returned, and the command is only issued with .min_out = 1.
> 
> A device that reports more extents than it delivered walks the loop past
> the end of the mailbox buffer.  A device that reports a large total while
> returning nothing makes the loop spin forever, because total_read never
> reaches total_expected; a stable generation number and total also keep the
> existing -EAGAIN check from firing.  The caller cannot recover from that
> one: __cxl_process_extent_list() never returns, so the retry loop around
> it never runs.
> 
> Derive the bound from mbox_cmd.size_out, clamp the claim to it, and fail
> with -EIO when the device stops making progress.  min_out is smaller than
> the response header, so the subtraction needs the same underflow guard.
> 
> Seen with QEMU emulating a device that lies.  The response header is 16
> bytes and an extent is 40, so a 2048 byte mailbox buffer holds 50:
> 
> 	BUG: KASAN: slab-out-of-bounds in cxl_validate_extent+0xca/0x310
> 	Read of size 2 at addr ffff888005758800 by task sh/1
> 	 cxl_validate_extent+0xca/0x310
> 	 cxl_process_extent_list+0x2c1/0x430
> 	 cxl_region_probe+0xb2b/0xc40
> 	 which belongs to the cache kmalloc-2k of size 2048
> 
> The Read of size 2 is extent->shared_extn_seq.  extent[50] starts at
> 16 + 50 * 40 = 2016 and the field is 32 bytes into the record, so that
> read is the first byte outside the buffer; a claimed count of 50 stays
> inside and 51 does not, as the sweep shows.  Reporting
> total_extent_count = 100000 with returned_extent_count = 0 instead spins
> region bring-up until the guest stops answering console commands; with the
> fix it logs "Extent list: no progress after 0/100000" and fails.
> 
> This is in the dynamic capacity device series under review (branch
> dcd-v6-2025-04-13 of weiny2/linux-kernel, based on 6.15-rc2), so the fix
> belongs in that series before it is merged.
> 
> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
I'd probably just have sent a reply to Anisa's series with a snippet of what
needed changing.  Anyhow, as it is a patch, the above needs cutting down a lot.
The first part about reading too far or looping forever is sufficent without
the details.

Otherwise, similar to Alison's feedback on the other patch. If it's
wrong just error out the moment you know that. No reason to carry on
or clamp value etc.  Broken hardware should fail in a nice obvious fashion
so people notice!

Jonathan

> ---
> Resend note: the patch is byte-for-byte unchanged.  v1 went to
> ira.weiny@intel.com, which no longer exists, so the author it is addressed to
> never received it.  The v2 revision of the linux-cxl patch (drop the Fixes:
> tag, struct_offset(), fail on a response too short for the header) does not
> apply to this one: this code is not in mainline, so there is no commit to point
> a Fixes: at, and the bound here already guards the subtraction against wrap.
> 
>  drivers/cxl/core/mbox.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0b51a5d..c12ff86 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1764,6 +1764,7 @@ static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev = mds->cxlds.dev;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	u32 max_extent_count;
> +	size_t extents_hdr, max_returned;
>  	int latched_rc = 0;
>  	bool first = true;
>  
> @@ -1808,7 +1809,24 @@ static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
>  			first = false;
>  		}
>  
> +		/*
> +		 * The returned count is device-supplied: never index
> +		 * extent[] past the payload the device actually returned.
> +		 * The device also chooses the reported length and may return a
> +		 * response shorter than the header (min_out is 1), so derive the
> +		 * bound without underflowing.
> +		 */
> +		extents_hdr = offsetof(struct cxl_mbox_get_extent_out, extent);
> +		max_returned = mbox_cmd.size_out > extents_hdr ?
> +			       (mbox_cmd.size_out - extents_hdr) /
> +			       sizeof(struct cxl_extent) : 0;
>  		nr_returned = le32_to_cpu(extents->returned_extent_count);
> +		if (nr_returned > max_returned) {
> +			dev_warn_ratelimited(dev,
> +					     "Extent list: device claimed %u extents but the payload holds %zu\n",
> +					     nr_returned, max_returned);
> +			nr_returned = max_returned;
> +		}
>  		total_read += nr_returned;
>  		current_total = le32_to_cpu(extents->total_extent_count);
>  		current_gen_num = le32_to_cpu(extents->generation_num);
> @@ -1823,6 +1841,18 @@ static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
>  			return -EAGAIN;
>  		}
>  
> +		/*
> +		 * A device that keeps claiming more extents without ever
> +		 * delivering any would otherwise spin this loop forever
> +		 * (the outer retry cannot help: this call never returns).
> +		 */
> +		if (!nr_returned && total_expected > total_read) {
> +			dev_warn_ratelimited(dev,
> +					     "Extent list: no progress after %u/%u extents; aborting\n",
> +					     total_read, total_expected);
> +			return -EIO;
> +		}
> +
>  		for (int i = 0; i < nr_returned ; i++) {
>  			struct cxl_extent *extent = &extents->extent[i];
>  

