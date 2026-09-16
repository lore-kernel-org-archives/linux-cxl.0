Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA67377A8E;
	Wed, 16 Sep 2026 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519379; cv=none; b=hZS1Xa7/wUxCaB6LzlDtz8x+MVW86wukCXmxv4EpFSuTiqC1A7qG76DhZaqDDzshz6PPjBNGl/lG28fnWBDcNVrTBO+gq8F/MmN0tNOXEvQTFou5fhHTUj1FhC0ttphuGAbV0D/vQmY9/wLN4DG+hnFLgPmbQa9QgcCvIplpOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519379; c=relaxed/simple;
	bh=UXvRvtYs5SM7qqmMPXpR8IdB9uprW9cKhJW9oYN9nI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqWLqSMei4I/g8Rl5KoD7V9eRv117aRo8jgEZYWtcap656so0t+fU8ljKIpDlql93yn+KNlaDf3BHDGI2dfI2T0uP/1BjKC1Qb+ohGIjTt/aE+5+ckmPH1jqL4MATdtK0Y+0tt4v+NZ8QCSzgGFTNGYhWzFdUQCOVJO3veUXIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKPwrzEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKPwrzEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2CA1F00898;
	Wed, 16 Sep 2026 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519371;
	bh=5z6g9Duf+OkHU2UE3UiCryMND85Dnf4QyKBC0RtUTC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OKPwrzEtUvR3xys/mlgF9vgmLTLvnJ8KOPseqZR4bRHYrWveGJBARKCTEhJbJiqNS
	 LZs2nwFPnHZuqf7lEJbUJfAuC3Dm3Ov5ezqh04mj7Fn5ea5wCVCMpWbakDs5kCKhSG
	 QPpq7RyPFu1KiyuG+QHYIFZtGFmbhUpvbhS5LEJV65wfoM3+Dafiieqp0BLNo8jN7q
	 9LYlWmO6vVKWV+fneEr1ZS7EMbYYLllzjs5OyyQ+qp/Di7HhbHBKKSTJOKGDJv7jI5
	 xc0TNU1xrYC/x2/1wxXw0aoHJGMC5X6beyHbfFpwfFFyVdDKS00VIIXrJD1xZ7A9uD
	 REml73gGnjRDg==
Date: Wed, 16 Sep 2026 01:42:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gaobin Huang <huanggaobin23@semi.ac.cn>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/mbox: bound the Get Supported Logs entry count
 by the payload
Message-ID: <20260916014247.247c4333@jic23-hlaptop>
In-Reply-To: <20260914125701.1160136-3-huanggaobin23@semi.ac.cn>
References: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
	<20260914125701.1160136-3-huanggaobin23@semi.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 20:57:01 +0800
Gaobin Huang <huanggaobin23@semi.ac.cn> wrote:

> cxl_enumerate_cmds() iterates gsl->entries entries of gsl->entry[] using
> the count the device put in the Get Supported Logs response.  The response
> is only checked with .min_out = 2, so a device may report more entries
> than it delivered and the driver reads past the end of the buffer.  This
> is probe time, so it happens on every boot of a machine with such a
> device, without any host action.
> 
> cxl_get_gsl() can already tell the caller how much arrived, because
> __cxl_pci_mbox_send_cmd() records the copied byte count in
> mbox_cmd.size_out.  Derive the number of entries that fit from it and stop
> the loop there.
> Guard the subtraction too: min_out is smaller than the response header, so
> a two byte response would otherwise wrap the size_t arithmetic and leave
> the bound with nothing to do.
> 
> Seen with a QEMU Type-3 device that reports 0xffff entries while writing
> one, in a 2048 byte buffer:
> 
> 	BUG: KASAN: slab-out-of-bounds in cxl_enumerate_cmds+0x1e3/0x980
> 	Read of size 4 at addr ffff888003707810 by task kworker/u8:2/38
> 	cxl_enumerate_cmds+0x1e3/0x980
> 	cxl_pci_probe+0x84a/0x11e0
> 	 which belongs to the cache kmalloc-2k of size 2048
> 	The buggy address is located 16 bytes to the right of the
> 	 allocated region
> 
> The Read of size 4 is gsl->entry[i].size.  The buffer can hold 102
> entries, so claiming 102 is still inside it and 103 is not, which is what
> the sweep shows.  With the bound in place the same device logs
> 
> 	GSL: device claimed 65535 entries but the payload holds 1
> 
> and enumeration continues with the entries that are present.
> 
> This is the cross-check get_supported_features() already performs in
> drivers/cxl/core/features.c, where a device supplied count is compared
> against the retrieved length before the entries are used.
> 
> Fixes: 472b1ce6e9d6 ("cxl/mem: Enable commands via CEL")

Similar to previous.  So far we aren't treating buggy devices as
something we must harden against.  Where it is simple though we can
do so.

> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
> ---
>  drivers/cxl/core/mbox.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a8f51bf0f..c94439554 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -794,7 +794,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
>  }
>  
> -static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
> +static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds,
> +						       size_t *len)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_supported_logs *ret;
> @@ -818,7 +819,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
>  		return ERR_PTR(rc);
>  	}
>  
> -
> +	*len = mbox_cmd.size_out;	/* bytes actually received */

blank line here.

>  	return ret;
>  }
>  
> @@ -849,18 +850,39 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  	struct cxl_mbox_get_supported_logs *gsl;
>  	struct device *dev = mds->cxlds.dev;
>  	struct cxl_mem_command *cmd;
> +	size_t gsl_len, gsl_hdr, max_entries;
>  	int i, rc;
>  
> -	gsl = cxl_get_gsl(mds);
> +	gsl = cxl_get_gsl(mds, &gsl_len);
>  	if (IS_ERR(gsl))
>  		return PTR_ERR(gsl);
>  
> +	/*
> +	 * The device chooses the reported payload length and may return a
> +	 * response as short as the entry count field on its own (min_out is
> +	 * 2), so derive the entry count without underflowing.
> +	 */
> +	gsl_hdr = offsetof(struct cxl_mbox_get_supported_logs, entry);

	gsl_hdr_size = struct_offset(gsl, entry);

Note the size is to make it clear this isnt a pointer to the gsl header.

> +	max_entries = gsl_len > gsl_hdr ?
> +		      (gsl_len - gsl_hdr) / sizeof(gsl->entry[0]) : 0;

I'd error out first on it not being big enough for the header.
Nothing else useful is going to happen and we know it will return
an error anyway.

> +
>  	rc = -ENOENT;
>  	for (i = 0; i < le16_to_cpu(gsl->entries); i++) {
> -		u32 size = le32_to_cpu(gsl->entry[i].size);
> -		uuid_t uuid = gsl->entry[i].uuid;
> +		u32 size;
> +		uuid_t uuid;
>  		u8 *log;
>  
> +		if (i >= max_entries) {
> +			dev_warn_ratelimited(dev,
> +					     "GSL: device claimed %u entries but the payload holds %zu\n",
> +					     le16_to_cpu(gsl->entries),
> +					     max_entries);
> +			break;
> +		}
> +
> +		size = le32_to_cpu(gsl->entry[i].size);
> +		uuid = gsl->entry[i].uuid;
> +
>  		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
>  
>  		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))

