Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872747;
	b=yEWxoGUYHOvQZtVskiYSPBoV2A8/c6ls+2CDqP+HNV8F/Ct2k0uh8agvwuFHUWLR5SJq
	 7pvrOBNmZ2RvM8D/KFeJSnN5iYkK9I+uAuwO1vJWeqWbaI3b2F3oYHLg5s+EDZkzHzwcb
	 AD78jzOj8M9IeK22aFpLf1Tz7gJcKs+zZfPL9KJCL6PmfFQ7nQCtzSPTrov9TYPHIZ5jq
	 A/v5jkygIW4fUfg+UMfUygwvzrPVarM8TehICUiRZMMqCv2FrFFZiZ9t2VEt1gXL5PESg
	 LrvnVeiy7OvQIFfKop6yCgCFJJnj+I1kShe7nyQ7VRuHl6+zzs3j0yF58UL+vMtATRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8io0HU9dwDVPEIPqWjgCxaStVmef8ZQiuaFzcnNz1Oc=;
	b=J1V0mGHMbg5f2R9jJSvRsneedhQGrVVNXOa9t58HKjesK005JeEYgs/1vT4WucNUBGyI
	 RxQTkorEvYU9wIKz79X7ebLRfpUxGyFHATtekZuFngyjBjw7PclfSu49fk4Ye5sL+4+oP
	 723HZxJ2fz5lLoKdN+wZKzo/EQmUX3AtKfxaqZAOg1XYqEH0nEwxlHIMftLl4zZZpKIVd
	 uTk+OWBICTqWxcVXaixeDeAkzZ+h3HH8nOJArJML1njwFmpTjKOmJJLg1MH3X3bfQtoXw
	 NVW5Z8kAC1OghBvLT1rah6+0yKJDErRYqWpyz5ZGi3sDMO4JzEAJn66Xb+owmsCvcYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ip1z9ERb;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C759606A323
	for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 23:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C759606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ip1z9ERb
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so7696602eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 15:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794872745; x=1795477545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8io0HU9dwDVPEIPqWjgCxaStVmef8ZQiuaFzcnNz1Oc=;
        b=Ip1z9ERbiw445ZGeShkNE2OUQ1TNOHGfng7tNNn3ghEYmi35U1RI19iRZyjblfWPEb
         5bHFtiYcmTfwUYHlShMYbTVuPfBcmpMP6E4ICbCyl6GBrrxp+TTWNKFnWlrit22K+Wq+
         DksmUHal7X2TpA2EVyh9uiQShDyJvr0XmM3rTgiYm4lV3oBY0tTnXunQHbU3dLXOQg8m
         FTOZKoRaOFmXJ4StDq/qYp9HPXitU1OZVYAzjnv9NJrBByIfJnDnDR0ehhoKzsKjhEeb
         YE08nV1+1yJd2Na50yzZq4Tu3UxmzZOQG4tf+q8oZuUEti9DeeDE73xVnzuwv0BMUOwv
         Lsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794872745; x=1795477545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8io0HU9dwDVPEIPqWjgCxaStVmef8ZQiuaFzcnNz1Oc=;
        b=MAuLu7tOCyuRfV1Kr8zpmkssBf8dDkhFSGGqY+7V+dPsP3puoT66f+j0yB5W1ETOK+
         b+9Zgr3w2vxDM7SX+hgG7vW5v4D61MGTbUWob87CZYpMYjJAXnAgcoyIGglkrENDHaKD
         hjM1HHZMCMALOuO+XG69aasWUNEs6/DSskY0DoK+u4Z6vkPY6Ci2WvOnaazlBIg/gzzU
         UoXUU4WG+GAha4jldyIq1RAFe4Y8OHS0XWk9cuavIJ2BQYcltuUQaS/aPa70tpAXSXse
         Yiqo+8xUY+dxf1RlDpe6u631qrhzjO/NHq++usEopc0ImughXX7bSOuNDYPtJmL9/E0u
         +bEA==
X-Forwarded-Encrypted: i=1; AL+hErH1VNQ2dtOl3weKQTUG7sU1pf6cLfnCoBToiGgaMwqKXPFqSeFrXiTY5NzKWmTVeQx3l9HKCUvJIfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wo1glr557VXiVSSOjQ2AIm5IYXI5Wbmy6vex61W+iJg2XnQRD
	603fxnfq6L4e1uURybbkDLJOEYCIzDu0jUaePr5N7TLAPzQovii/+IYq
X-Gm-Gg: AZFdTZcmnnmRbFkOaLJH3Bo5dJtsgwe7QFxz0uowrl00lwr4B+E3fDcsWp/W0Xf5E9o
	Rbu1WEafYLEiySmgkdBAzwv8eJNkfY1gDTMqwLdaAZ+InOKPWjt+TgnClpgBQRFhLVjLllZ4K/m
	9BaDrN5PioyvEXsX+2UVlB1a8pXVofc0acHIovBAxilUhcITA/BUCZGeuUnDAf4uJNDI9RpbOSw
	syDZWsXTSMI6Bho7gDSVOgJqH8mFoJFslgEDyOUIFstzQA+yMrlR4+bjRx5w8gdJadDTDDFOlxh
	S70ty2sgxLs9korzEEkYGvdD8DUf3RFwA79M+JC39vASkQPtptrwc5sicSMNJmov1eGdMlsFEOB
	fuaJOR5hBDh79wIIUTA9wA631b6eebS1mbN1EZhjmxs33hRqma9sWL8yNlbg0L0Xt/b+svkNYV9
	NBM0IIX+6ab3HVqefU9LWypRAIqtd6UhNCeO3i+B7fRuWK2Un4ncd7j52jR09/AkJTECXj+ONC1
	ehDNsbHRTf6wkV/LFLMMmFsSrMnpCJEg5AaUF4AhMX6Wid4WIQr+ge14f6p7RrE/MnZzZneOD/4
	whp0V8X50A/u0vMe1N+WYQsxJMuyGrWaYOciU18EbgxuSL4bAiDuYB4=
X-Received: by 2002:a05:693c:60d0:b0:36d:9900:bb92 with SMTP id 5a478bee46e88-37965ca8056mr12098927eec.10.1794872745408;
        Mon, 16 Nov 2026 15:45:45 -0800 (PST)
Received: from localhost ([115.99.200.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm36175581eec.22.2026.11.16.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:45:44 -0800 (PST)
Date: Tue, 17 Nov 2026 05:15:41 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 1/5] cxl/mbox: Add Get Poison List snapshot support
Message-ID: <avuVpZx_6dkch9c2@acer-nitro-anv15-41>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <20261010162017.62506-2-shaikhkamal2012@gmail.com>
 <20261016231827.074e0326@jic23-hlaptop>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016231827.074e0326@jic23-hlaptop>

On Fri, Oct 16, 2026 at 11:18:27PM +0100, Jonathan Cameron wrote:
> On Sat, 10 Oct 2026 21:50:09 +0530
> Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:
> 
> > cxl_mem_get_poison() uses a device-owned output buffer for each Get
> > Poison List response. It traces the records before issuing the next
> > command, which overwrites that buffer when the device sets the More
> > Media Error Records flag. A caller therefore cannot inspect the complete
> > set of collected records after the function returns.
> > 
> > Add a caller-owned snapshot and copy each validated mailbox response
> > into it. Preserve device overflow and scan-in-progress status, and
> > indicate when the host stops collection before retrieving all available
> > records.
> > 
> > Keep cxl_mem_get_poison() as the existing trace-only wrapper so its
> > current callers, including trigger_poison_list, retain their behavior.
> > 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > ---
> >  drivers/cxl/core/mbox.c | 137 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/cxl/cxlmem.h    |  25 ++++++++
> >  2 files changed, 156 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 55828a836c01..2752b46ffee2 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1376,14 +1376,91 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, "CXL");
> >  
> > -int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > -		       struct cxl_region *cxlr)
> > +int cxl_poison_snapshot_init(struct cxl_memdev *cxlmd,
> > +			     struct cxl_poison_snapshot *snapshot)
> > +{
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +	u32 capacity = mds->poison.max_errors;
> > +

Hi Jonathan,

Thanks for review, and sorry for the late reply.

> > +	if (!snapshot)
> 
> That seems like a buggy use of the interface, so not sure we need
> that defence.
> 

Agreed, I will drop it.

> > +		return -EINVAL;
> > +	memset(snapshot, 0, sizeof(*snapshot));
> > +
> > +	if (!test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!capacity)
> > +		return -EPROTO;
> > +
> > +	snapshot->records = kvmalloc_array(mds->poison.max_errors,
> > +					   sizeof(*snapshot->records),
> > +					   GFP_KERNEL);
> 
> kvmalloc_objs()?
>

Yes, will switch.

> > +	if (!snapshot->records)
> > +		return -ENOMEM;
> > +
> > +	snapshot->capacity = capacity;
> > +
> > +	return 0;
> > +}
> > +
> > +void cxl_poison_snapshot_destroy(struct cxl_poison_snapshot *snapshot)
> > +{
> > +	if (!snapshot)
> > +		return;
> > +
> > +	kvfree(snapshot->records);
> > +	memset(snapshot, 0, sizeof(*snapshot));
> > +}
> > +
> > +static int cxl_poison_snapshot_append(struct cxl_poison_snapshot *snapshot,
> > +				      struct cxl_poison_record *records,
> > +				      u32 count)
> > +{
> > +	u32 available;
> > +
> > +	/*
> > +	 * Existing cxl_mem_get_poison() callers request tracing only and
> > +	 * pass no snapshot.
> > +	 */
> > +
> > +	if (!snapshot)
> > +		return 0;
> > +
> > +	if (!snapshot->records)
> > +		return -EINVAL;
> > +
> > +	if (snapshot->nr_records > snapshot->capacity)
> > +		return -EOVERFLOW;
> > +
> > +	if (!count)
> > +		return 0;
> > +
> > +	if (!records)
> > +		return -EINVAL;
> > +
> > +	available = snapshot->capacity - snapshot->nr_records;
> > +	if (count > available) {
> > +		snapshot->truncated = true;
> > +		return -ENOSPC;
> > +	}
> > +
> > +	memcpy(&snapshot->records[snapshot->nr_records], records,
> > +	       count * sizeof(*records));
> > +	snapshot->nr_records += count;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_mem_get_poison_common(struct cxl_memdev *cxlmd, u64 offset,
> > +				     u64 len, struct cxl_region *cxlr,
> > +				     struct cxl_poison_snapshot *snapshot)
> >  {
> >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> >  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> >  	struct cxl_mbox_poison_out *po;
> >  	struct cxl_mbox_poison_in pi;
> > -	int nr_records = 0;
> > +	u32 nr_records = 0;
> > +	u32 count;
> >  	int rc;
> >  
> >  	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
> > @@ -1408,29 +1485,77 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> >  		if (rc)
> >  			break;
> >  
> > -		if (!le16_to_cpu(po->count)) {
> > +		count = le16_to_cpu(po->count);
> > +		if (!count) {
> >  			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
> > +
> > +			if (po->flags & CXL_POISON_FLAG_MORE) {
> > +				if (snapshot)
> > +					snapshot->truncated = true;
> 
> Count of zero and yet more? How would that happen? This smells like
> a hardware bug.  Maybe we defend against it, but that's a separate
> question from the rest of this patch.
>

Agreed, it would be a device bug. I would still like to handle it: the
current code breaks out and returns 0 on an empty payload even with More
set, so the snapshot's caller can't tell the list was cut short, and
region probe would online the memory on the partial list.

I will take it out this series and send it as a separate patch, so this
only adds the snapshot.

> > +				rc = -EPROTO;
> > +			}
> > +
> > +			break;
> > +		}
> > +
> > +		if (struct_size(po, record, count) > mbox_cmd.size_out) {
> > +			dev_err(&cxlmd->dev,
> > +				"invalid poison record count: %u\n", count);
> 
> Also looks like broken hardware. I don't necessarily mind that sort
> of defense, but not in a patch doing anything else.
>

Same, it guards against a count larger than the returned payload, I will
move it into that patch as well.

> > +			rc = -EPROTO;
> >  			break;
> >  		}
> >  
> > -		for (int i = 0; i < le16_to_cpu(po->count); i++)
> > +		for (u32 i = 0; i < count; i++)
> >  			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
> >  					 po->flags, po->overflow_ts,
> >  					 CXL_POISON_TRACE_LIST);
> >  
> > +		if (snapshot && (po->flags & CXL_POISON_FLAG_OVERFLOW)) {
> > +			snapshot->device_flags |= CXL_POISON_FLAG_OVERFLOW;
> > +			snapshot->overflow_ts = le64_to_cpu(po->overflow_ts);
> > +		}
> 
> I'm curious. What use is the overflow_ts in your scheme?  Lets keep things
> minimal unless there is a reason to add data to the snapshot.
>

None, as it turns out. Only the overflow flag is used, to fail the probe
when the list is incomplete. I will drop overflow_ts.

> > +
> > +		if (snapshot && (po->flags & CXL_POISON_FLAG_SCANNING))
> > +			snapshot->device_flags |= CXL_POISON_FLAG_SCANNING;
> > +
> > +		rc = cxl_poison_snapshot_append(snapshot, po->record, count);
> > +		if (rc)
> > +			break;
> > +
> >  		/* Protect against an uncleared _FLAG_MORE */
> > -		nr_records = nr_records + le16_to_cpu(po->count);
> > +		nr_records += count;
> >  		if (nr_records >= mds->poison.max_errors) {
> >  			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
> >  				nr_records);
> > +			if (snapshot && (po->flags & CXL_POISON_FLAG_MORE))
> > +				snapshot->truncated = true;
> > +
> >  			break;
> >  		}
> >  	} while (po->flags & CXL_POISON_FLAG_MORE);
> >  
> >  	return rc;
> >  }
> > +
> > +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > +		       struct cxl_region *cxlr)
> > +{
> > +	return cxl_mem_get_poison_common(cxlmd, offset, len, cxlr, NULL);
> > +}
> >  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
> >  
> > +int cxl_mem_get_poison_snapshot(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > +				struct cxl_region *cxlr,
> > +				struct cxl_poison_snapshot *snapshot)
> > +{
> > +	if (!snapshot || !snapshot->records || !snapshot->capacity)
> > +		return -EINVAL;
> > +
> > +	if (snapshot->nr_records > snapshot->capacity)
> > +		return -EOVERFLOW;
> > +
> > +	return cxl_mem_get_poison_common(cxlmd, offset, len, cxlr, snapshot);
> > +}
> 
> Blank line here
>

Will fix.

> >  static void free_poison_buf(void *buf)
> >  {
> >  	kvfree(buf);
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index c401e3a1af06..1d6f8d958bd2 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -812,6 +812,31 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds);
> >  int cxl_poison_state_init(struct cxl_memdev_state *mds);
> >  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> >  		       struct cxl_region *cxlr);
> > +
> > +/**
> > + * struct cxl_poison_snapshot - Aggregate Get Poison List result
> > + * @records: Copied Media Error Records from all mailbox responses
> > + * @nr_records: Number of valid records stored in @records
> > + * @capacity: Maximum number of records that @records can hold
> > + * @overflow_ts: Timestamp associated with a reported device overflow
> > + * @device_flags: Persistent device status observed during collection
> > + * @truncated: Host stopped before collecting all available records
> > + */
> > +struct cxl_poison_snapshot {
> > +	struct cxl_poison_record *records;
> 
> __counted_by_ptr() seems likely to apply here.
> 

Yes. I will use __counted_by_ptr(capacity), since capacity is allocated
size and nr_records only says how much of it is filled.

> > +	u32 nr_records;
> > +	u32 capacity;
> > +	u64 overflow_ts;
> 
> As above. I'd like to ensure this only stashes what we actually need.
>

Will drop, as above.


Thanks,
Shaikh Kamal

> > +	u8 device_flags;
> > +	bool truncated;
> > +};
> > +
> > +int cxl_poison_snapshot_init(struct cxl_memdev *cxlmd,
> > +			     struct cxl_poison_snapshot *snapshot);
> > +void cxl_poison_snapshot_destroy(struct cxl_poison_snapshot *snapshot);
> > +int cxl_mem_get_poison_snapshot(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > +				struct cxl_region *cxlr,
> > +				struct cxl_poison_snapshot *snapshot);
> >  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
> >  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
> >  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> 
