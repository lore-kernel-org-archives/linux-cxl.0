Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014FC26461F;
	Wed, 16 Sep 2026 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518992; cv=none; b=D5SwIMxQBWrjnQF0LltKVtjxs9btlmtI7tIDeeJQFccFhgXO9VPAkcRK2W4IKfAVnkJhkLVUGMndEyLHpsgpMV1KE5saQ09IG8Yrk7uekkl47Mpy1fePZhGXWCXFVBIO5awNFAcdhko+bS71mvDOo/0XtlJgPj5+ZatM8X28hNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518992; c=relaxed/simple;
	bh=V9OfcwnkKuSyu9WM5ZJEER3Ur0K4JuvgGxL7xemGeB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSwWWVST13A6+sHTU5qI5QEu16I/fx+FmBWPIYnLYOuboUnzRmbLAE1d69mlxfOWM1A6p1XKNtgKoJbYs92ppYTXkoSn3qkRf7wJGadhKuKheXBf90J8RB9LOIIR3nnJXYdp8NnyGfqTseZo6ALaAdckyj95IK867WL35quEJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1jbUJCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1jbUJCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2FA1F000FF;
	Wed, 16 Sep 2026 00:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789518988;
	bh=/6KgZINJrE03r3WPd5MSyCRDeriFotlwF2mOdoYvY7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N1jbUJCaofgduHG9g67Srd0Ds/5TV9Yg6HBbwZeBzTey9MApJ/lcdDr6dP9qwIJx8
	 qnBzd8q4vGG5AI66r9VlKM3EKRx8VS12eXUYRKFkDTVd1GCn50oCROVv3Me3J38/NM
	 LMjX4VOZJen7ZPLOcbKwN/ylWbN6k8O+prsyQuMVy+qgHhDRxcimg0179kKqh1efwH
	 I83i7VloxAg/xHr10VKXsi+x/wNa78PzsoLmsdORKJL/LQyaCEKmjQMfBCxWGs1m91
	 ga+5NNCv1BPvWkNvsvLHuT+0IW5J51tO56c68TUizmuR+tcrjxLViaXS5Nm5YagU0/
	 aA6NCraoKQqvw==
Date: Wed, 16 Sep 2026 01:36:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gaobin Huang <huanggaobin23@semi.ac.cn>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/mbox: clamp the event record count to the
 received payload
Message-ID: <20260916013623.66609e47@jic23-hlaptop>
In-Reply-To: <20260914125701.1160136-2-huanggaobin23@semi.ac.cn>
References: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
	<20260914125701.1160136-2-huanggaobin23@semi.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 20:57:00 +0800
Gaobin Huang <huanggaobin23@semi.ac.cn> wrote:

> cxl_mem_get_records_log() walks payload->records[] using the record_count
> the device wrote into that same payload, and cxl_clear_event_record()
> repeats the walk with the same unvalidated value, reading record handles
> past the end of the mailbox buffer.  The handle it reads is then handed
> back to the device in the Clear Event Records payload.
> 
> The command is issued with .size_out = cxl_mbox->payload_size and only
> 
> 	.min_out = struct_size(payload, records, 0)
> 
> enforced, so the count is never compared against what the device actually
> returned.  __cxl_pci_mbox_send_cmd() already knows that number: it stores
> the bytes it copied into the driver buffer in mbox_cmd.size_out.  Derive
> the record bound from it, and pass the validated count to
> cxl_clear_event_record() instead of letting it re-read the raw field.
> 
> Seen with a QEMU Type-3 device that returns one record in a 2048 byte
> buffer while claiming more, so records[16] is the first access outside it:
> 
> 	BUG: KASAN: slab-out-of-bounds in cxl_clear_event_record+0x1ad/0x2e0
> 	Read of size 2 at addr ffff888003306834 by task irq/27-0000:35:/58
> 	 which belongs to the cache kmalloc-2k of size 2048
> 	The buggy address is located 52 bytes to the right of
> 	 allocated 2048-byte region
> 
> A sweep of the claimed count agrees: 16 stays inside the allocation and 17
> does not.  With the clamp in place the same device logs
> 
> 	Event log '4': device claimed 4096 records but the payload holds 1
> 
> and the log is drained normally.
> 

Hi Gaobin Huang,

> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")

If I follow the above correctly this hardening against a buggy device?
If that's the case drop the fixes tag.  I'm happy to see this sort
of change go as long as we make it clear what it is.

> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>

Minor suggestion inline.

Jonathan

> ---
>  drivers/cxl/core/mbox.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836..a8f51bf0f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -992,11 +992,13 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  				  enum cxl_event_log_type log,
> -				  struct cxl_get_event_payload *get_pl)
> +				  struct cxl_get_event_payload *get_pl,
> +				  u16 nr_rec)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_clear_event_payload *payload;
> -	u16 total = le16_to_cpu(get_pl->record_count);
> +	/* count validated by cxl_mem_get_records_log(), not re-read here */
> +	u16 total = nr_rec;
>  	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
>  	size_t pl_size = struct_size(payload, handles, max_handles);
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -1070,6 +1072,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  	struct cxl_get_event_payload *payload;
>  	u8 log_type = type;
>  	u16 nr_rec;
> +	size_t max_recs;
>  
>  	mutex_lock(&mds->event.log_lock);
>  	payload = mds->event.buf;
> @@ -1093,7 +1096,20 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			break;
>  		}
>  
> +		/*
> +		 * The record count is device-supplied.  Never walk records[]
> +		 * past the payload the device actually returned.
> +		 */
> +		max_recs = (mbox_cmd.size_out -
> +			    offsetof(struct cxl_get_event_payload, records)) /
> +			   sizeof(struct cxl_event_record_raw);

Feels a bit like there should be a function to reverse struct_size() but sadly not.
We do have struct_offset() however so given we are using this access into
payloads, I think we can write this as:

		max_rec = (mbox_cmd.size_out - struct_offset(payload, records) /
			   sizeof(*payload->records);

>  		nr_rec = le16_to_cpu(payload->record_count);
> +		if (nr_rec > max_recs) {
> +			dev_warn_ratelimited(dev,
> +					     "Event log '%d': device claimed %u records but the payload holds %zu\n",
> +					     type, nr_rec, max_recs);
> +			nr_rec = max_recs;
> +		}
>  		if (!nr_rec)
>  			break;
>  
> @@ -1104,7 +1120,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
>  
> -		rc = cxl_clear_event_record(mds, type, payload);
> +		rc = cxl_clear_event_record(mds, type, payload, nr_rec);
>  		if (rc) {
>  			dev_err_ratelimited(dev,
>  				"Event log '%d': Failed to clear events : %d",

