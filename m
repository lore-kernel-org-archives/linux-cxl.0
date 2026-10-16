Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1413B3884;
	Sat, 17 Oct 2026 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263093; cv=none; b=tpzPp49j1Ga3eMNb6MDbYOgmqvT/IFHrSfthBd6izqkxztY9oMVXdLnDzAEIiC8dCuwwUIoYFzymNfXeN5+kMr5vMudqIaqrHAU08TmbE9zVBrwechyxxhAaXHtOL9UeQjaRwuBr+3Xy4MdndPIK/FsSsHqA0Pts4ctn887rpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263093; c=relaxed/simple;
	bh=L7PD3v8+SgPTWkYrVWTjrzPmX7JzY5jEkdoEBrZ9vD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNv5HkmIiV9vPAcrzTPmqwde6GTXiDKd/Lfc85FdVjIJ+pN20CuB/bE4Bri0Ki9kUPYFQPeFUXbUJD6jMQ33VtLCMdaf/VrbLLi+Rf7q8C0fAbo0cYxmet8UrXEXGOFpvJ/rKP9ap3PKyQ4pZazqjORdCI7ciib5chv8BhHAtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm+M18Hk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm+M18Hk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD12E1F000C4;
	Sat, 17 Oct 2026 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263092;
	bh=7p2v8cd8Piqf2r8JBIYxKwNid9G5UEqcxbvv8thHaUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jm+M18HkZppQqg/RREcrWCrGXHylE+GKhzJrKgu4eSkw+4c31hXYZ2PhX+qwGC8xc
	 eqm2gtYAO8klRIZE95rlvV4LHqITWTVKQFF2hP/Uv5XHKIe5OyQf1Ia3KVA0Kh5hwb
	 Hhp6QGzws/nXpRj2gMUj2yEseWibGecmuURxzTyTV0UU+TFroIQDwwZivTcpcrnAeR
	 5+CpOfbPN1RJ+CIZg1O9ffWRS1dRCImzvmeoIe6nNeDLTnDDfqq1GHbgwBfNe+Ir5p
	 rqWGQIEPfXlgMciqlPdovRGsyLC8NoXW0fWwli9l3JPhBrzl2hg/pzcFamxmP5LXUg
	 DEtpYO7DKUb2Q==
Date: Fri, 16 Oct 2026 23:18:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Breno Leitao <leitao@debian.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand
 <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, Kiryl Shutsemau
 <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 1/5] cxl/mbox: Add Get Poison List snapshot support
Message-ID: <20261016231827.074e0326@jic23-hlaptop>
In-Reply-To: <20261010162017.62506-2-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
	<20261010162017.62506-2-shaikhkamal2012@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 21:50:09 +0530
Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:

> cxl_mem_get_poison() uses a device-owned output buffer for each Get
> Poison List response. It traces the records before issuing the next
> command, which overwrites that buffer when the device sets the More
> Media Error Records flag. A caller therefore cannot inspect the complete
> set of collected records after the function returns.
> 
> Add a caller-owned snapshot and copy each validated mailbox response
> into it. Preserve device overflow and scan-in-progress status, and
> indicate when the host stops collection before retrieving all available
> records.
> 
> Keep cxl_mem_get_poison() as the existing trace-only wrapper so its
> current callers, including trigger_poison_list, retain their behavior.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---
>  drivers/cxl/core/mbox.c | 137 ++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxlmem.h    |  25 ++++++++
>  2 files changed, 156 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01..2752b46ffee2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1376,14 +1376,91 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, "CXL");
>  
> -int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> -		       struct cxl_region *cxlr)
> +int cxl_poison_snapshot_init(struct cxl_memdev *cxlmd,
> +			     struct cxl_poison_snapshot *snapshot)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	u32 capacity = mds->poison.max_errors;
> +
> +	if (!snapshot)

That seems like a buggy use of the interface, so not sure we need
that defence.

> +		return -EINVAL;
> +	memset(snapshot, 0, sizeof(*snapshot));
> +
> +	if (!test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
> +		return -EOPNOTSUPP;
> +
> +	if (!capacity)
> +		return -EPROTO;
> +
> +	snapshot->records = kvmalloc_array(mds->poison.max_errors,
> +					   sizeof(*snapshot->records),
> +					   GFP_KERNEL);

kvmalloc_objs()?

> +	if (!snapshot->records)
> +		return -ENOMEM;
> +
> +	snapshot->capacity = capacity;
> +
> +	return 0;
> +}
> +
> +void cxl_poison_snapshot_destroy(struct cxl_poison_snapshot *snapshot)
> +{
> +	if (!snapshot)
> +		return;
> +
> +	kvfree(snapshot->records);
> +	memset(snapshot, 0, sizeof(*snapshot));
> +}
> +
> +static int cxl_poison_snapshot_append(struct cxl_poison_snapshot *snapshot,
> +				      struct cxl_poison_record *records,
> +				      u32 count)
> +{
> +	u32 available;
> +
> +	/*
> +	 * Existing cxl_mem_get_poison() callers request tracing only and
> +	 * pass no snapshot.
> +	 */
> +
> +	if (!snapshot)
> +		return 0;
> +
> +	if (!snapshot->records)
> +		return -EINVAL;
> +
> +	if (snapshot->nr_records > snapshot->capacity)
> +		return -EOVERFLOW;
> +
> +	if (!count)
> +		return 0;
> +
> +	if (!records)
> +		return -EINVAL;
> +
> +	available = snapshot->capacity - snapshot->nr_records;
> +	if (count > available) {
> +		snapshot->truncated = true;
> +		return -ENOSPC;
> +	}
> +
> +	memcpy(&snapshot->records[snapshot->nr_records], records,
> +	       count * sizeof(*records));
> +	snapshot->nr_records += count;
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_get_poison_common(struct cxl_memdev *cxlmd, u64 offset,
> +				     u64 len, struct cxl_region *cxlr,
> +				     struct cxl_poison_snapshot *snapshot)
>  {
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_poison_out *po;
>  	struct cxl_mbox_poison_in pi;
> -	int nr_records = 0;
> +	u32 nr_records = 0;
> +	u32 count;
>  	int rc;
>  
>  	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
> @@ -1408,29 +1485,77 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		if (rc)
>  			break;
>  
> -		if (!le16_to_cpu(po->count)) {
> +		count = le16_to_cpu(po->count);
> +		if (!count) {
>  			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
> +
> +			if (po->flags & CXL_POISON_FLAG_MORE) {
> +				if (snapshot)
> +					snapshot->truncated = true;

Count of zero and yet more? How would that happen? This smells like
a hardware bug.  Maybe we defend against it, but that's a separate
question from the rest of this patch.

> +				rc = -EPROTO;
> +			}
> +
> +			break;
> +		}
> +
> +		if (struct_size(po, record, count) > mbox_cmd.size_out) {
> +			dev_err(&cxlmd->dev,
> +				"invalid poison record count: %u\n", count);

Also looks like broken hardware. I don't necessarily mind that sort
of defense, but not in a patch doing anything else.

> +			rc = -EPROTO;
>  			break;
>  		}
>  
> -		for (int i = 0; i < le16_to_cpu(po->count); i++)
> +		for (u32 i = 0; i < count; i++)
>  			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
>  					 po->flags, po->overflow_ts,
>  					 CXL_POISON_TRACE_LIST);
>  
> +		if (snapshot && (po->flags & CXL_POISON_FLAG_OVERFLOW)) {
> +			snapshot->device_flags |= CXL_POISON_FLAG_OVERFLOW;
> +			snapshot->overflow_ts = le64_to_cpu(po->overflow_ts);
> +		}

I'm curious. What use is the overflow_ts in your scheme?  Lets keep things
minimal unless there is a reason to add data to the snapshot.

> +
> +		if (snapshot && (po->flags & CXL_POISON_FLAG_SCANNING))
> +			snapshot->device_flags |= CXL_POISON_FLAG_SCANNING;
> +
> +		rc = cxl_poison_snapshot_append(snapshot, po->record, count);
> +		if (rc)
> +			break;
> +
>  		/* Protect against an uncleared _FLAG_MORE */
> -		nr_records = nr_records + le16_to_cpu(po->count);
> +		nr_records += count;
>  		if (nr_records >= mds->poison.max_errors) {
>  			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
>  				nr_records);
> +			if (snapshot && (po->flags & CXL_POISON_FLAG_MORE))
> +				snapshot->truncated = true;
> +
>  			break;
>  		}
>  	} while (po->flags & CXL_POISON_FLAG_MORE);
>  
>  	return rc;
>  }
> +
> +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +		       struct cxl_region *cxlr)
> +{
> +	return cxl_mem_get_poison_common(cxlmd, offset, len, cxlr, NULL);
> +}
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
>  
> +int cxl_mem_get_poison_snapshot(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +				struct cxl_region *cxlr,
> +				struct cxl_poison_snapshot *snapshot)
> +{
> +	if (!snapshot || !snapshot->records || !snapshot->capacity)
> +		return -EINVAL;
> +
> +	if (snapshot->nr_records > snapshot->capacity)
> +		return -EOVERFLOW;
> +
> +	return cxl_mem_get_poison_common(cxlmd, offset, len, cxlr, snapshot);
> +}

Blank line here

>  static void free_poison_buf(void *buf)
>  {
>  	kvfree(buf);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..1d6f8d958bd2 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -812,6 +812,31 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
> +
> +/**
> + * struct cxl_poison_snapshot - Aggregate Get Poison List result
> + * @records: Copied Media Error Records from all mailbox responses
> + * @nr_records: Number of valid records stored in @records
> + * @capacity: Maximum number of records that @records can hold
> + * @overflow_ts: Timestamp associated with a reported device overflow
> + * @device_flags: Persistent device status observed during collection
> + * @truncated: Host stopped before collecting all available records
> + */
> +struct cxl_poison_snapshot {
> +	struct cxl_poison_record *records;

__counted_by_ptr() seems likely to apply here.
 
> +	u32 nr_records;
> +	u32 capacity;
> +	u64 overflow_ts;

As above. I'd like to ensure this only stashes what we actually need.

> +	u8 device_flags;
> +	bool truncated;
> +};
> +
> +int cxl_poison_snapshot_init(struct cxl_memdev *cxlmd,
> +			     struct cxl_poison_snapshot *snapshot);
> +void cxl_poison_snapshot_destroy(struct cxl_poison_snapshot *snapshot);
> +int cxl_mem_get_poison_snapshot(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +				struct cxl_region *cxlr,
> +				struct cxl_poison_snapshot *snapshot);
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);

