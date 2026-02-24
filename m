Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9942343BE
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896301; cv=none; b=S85IigonIHqH1UHDjFGIHKG4QPSVX7RU3NyRsbEXF/1Xl3cE+wBr8Bq8nU3CDHCsDr40IaM9ZEAtMo6pXwuXbcagGkgzVis+CjbuLgVQ7mMU0k+1ZNzaO9lhpjaz+qhpoJi9nPPatzr/dOUhjJtgSLpueCoWSnM2f08IkoevhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896301; c=relaxed/simple;
	bh=0z2rfSg4pMG/AuE2/ek/uTRDR2bwaJaDIuelXJM++V8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNxuh0Rr1PVA0J2atfqfOeWDCB1oV/5VejDkwMGyMJbzl17BeCG5/Fxws0TRG7OAXmiiLzroKxu8beOsSkWuRV51FNtlcule3jfZd8HiaCkgXHlKA8ClVzFf+cQO0AYTK1clNz6qSjA6saxGNmJrNPbYHriBeodDAjIU2fR5zgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePB/pD0+; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePB/pD0+"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79430ef54c3so43930287b3.2
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 17:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896299; x=1772501099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQGPzu5YPQ91NVYpBm+9/Kt5TZXA4lsSJTx1at22zpE=;
        b=ePB/pD0+c+qpTefxyModop/xiR7ZOU5/fEdRpUUvz6IKw53PmW8y3FOld9J0U/RgL+
         3ZSYm8+kZzkjGds9qPjsfUfmawxkywMMdclIaW7mBv2VkyWHlYy9Hcg7qkiKdr+oT1g4
         VoouV0zNd5RZWl3qjmf5PGptTili0tj4GMWQfM+3zyfny6L0joDoHk/C8gQfITz3AKhn
         7vCR+LT4vn0SVfbf2ZLrcwS8bS+lUGALiv1VtpfgOca+T+JZ5Yc1vPpw+jALgkaoxaNG
         9noVGCLZJrO1W4/0J/TL8JvBV4VhKIpvZGtqBsuMeA1p+xELSYuw/1E8ZIuAk+NwFwia
         7Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896299; x=1772501099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQGPzu5YPQ91NVYpBm+9/Kt5TZXA4lsSJTx1at22zpE=;
        b=Uru2R3HU/6/Lkuhz03JZQOfPsFtVj6P9+F/BIDH+ImGRo5jDh3GtKhNBzYhrvhX02g
         zU3casdN2EFk9jVrey0J+eCZRNZi2nuLVs41FNAHXkSE6+YzsTGPgWAn0FFxp+H5nX+v
         9yWG03wpr21rQNzkv7yCoBjt5tybb3hsNt+KuFeG5EW+tL/a1DYkFa4UMtVw8tn8NRVd
         IgQCt9ArbnVdv9jQdO7MNbx92b2uzjz2Fr9pOm1X421fNnDmVOzofD5X0tFeIBv1zVXE
         KPTvhYzJgAAWtgMDgdK42VI8NqslunT2IOrTZzBOSFG/dNMA7c5vFN+BGgzcADNBeJh9
         PNKA==
X-Forwarded-Encrypted: i=1; AJvYcCX9vG/pOl0Vm7LN2KUw9HClla0yVXU6TTwGMnf8ffjtStpB9LJBCbomSa/8EbFP33515aBRsk/LOVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WAILhGKCh5/WaQQNlBpGotOhG6fjNoZLDQUg68TdPdG1kNIl
	SgkXX4qQzS6Zh261t+7yPnTnvDGRAkik8glLpekE3uZziF55sdbVYqNF
X-Gm-Gg: ATEYQzy35QWz5FgdwDqLVD5Wcz7HHY1dUoynHJ+AAsyqGv+B9ALY8LSndItGjcPKPO5
	n1lGlBkoJDLGTqycQdizd/udWYix/mfi99jJ/jvFP8ZYBmAMYxqEM6RTiSMKVLMs3orLJYmQLHh
	WvyQpu519N8EHvOcdnOSf1S84c33w86AYqM8coO318LG7o581jVLqSOYow/HOXDOZQFtbstfKmL
	DEJpqc3VWhMOW1mqbHrWuG1EJOSS5apKZF+ybxxEr0n0FinRqF88Ry8wbXA/4joNsoHGV2RgxrN
	uriN/FCPVjdBqUvEmH9kejDrbatdykf3yKe0IYV06O63s8EruyZotfkeEOlhJbLWVTIyVysVrre
	T0IdwRhFNFOXNBNClIpl1R9I0SsTe1hyK33ZWW9yF10DrhWKu4XHlA/jlukspeJSbSlqB7Bou8+
	LDAA8VyXnAiica8kSGZgm22bLXJSHU2MtXR153XRgF2e79wcqiaNAo
X-Received: by 2002:a05:690c:6086:b0:794:a7d:6bc4 with SMTP id 00721157ae682-7982916dec3mr98603277b3.58.1771896298694;
        Mon, 23 Feb 2026 17:24:58 -0800 (PST)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd84394sm38813677b3.30.2026.02.23.17.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:24:58 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 23 Feb 2026 17:24:55 -0800
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v9 12/19] cxl/extent: Process dynamic partition events
 and realize region extents
Message-ID: <aZz9qi1b1DsOETa_@4470NRD-ASU.ssi.samsung.com>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
 <20250413-dcd-type2-upstream-v9-12-1d4911a0b365@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413-dcd-type2-upstream-v9-12-1d4911a0b365@intel.com>

On Sun, Apr 13, 2025 at 05:52:20PM -0500, Ira Weiny wrote:i
A few notes while going through and removing sparse dax semantics and plumbing
for fs-dax mode:
> A dynamic capacity device (DCD) sends events to signal the host for
> changes in the availability of Dynamic Capacity (DC) memory.  These
> events contain extents describing a DPA range and meta data for memory
> to be added or removed.  Events may be sent from the device at any time.
> 
> Three types of events can be signaled, Add, Release, and Force Release.
> 
> On add, the host may accept or reject the memory being offered.  If no
> region exists, or the extent is invalid, the extent should be rejected.
> Add extent events may be grouped by a 'more' bit which indicates those
> extents should be processed as a group.
> 
> On remove, the host can delay the response until the host is safely not
> using the memory.  If no region exists the release can be sent
> immediately.  The host may also release extents (or partial extents) at
> any time.
Partial release is no longer valid for tagged release iirc from the calls

> Thus the 'more' bit grouping of release events is of less
> value and can be ignored in favor of sending multiple release capacity
> responses for groups of release events.
> 
[snip]
> +
> +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> +				struct xarray *extent_array, int cnt)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_dc_response *p;
> +	struct cxl_extent *extent;
> +	unsigned long index;
> +	u32 pl_index;
> +
> +	size_t pl_size = struct_size(p, extent_list, cnt);
> +	u32 max_extents = cnt;
> +
> +	/* May have to use more bit on response. */
> +	if (pl_size > cxl_mbox->payload_size) {
> +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
> +			      sizeof(struct updated_extent_list);
> +		pl_size = struct_size(p, extent_list, max_extents);
> +	}
> +
> +	struct cxl_mbox_dc_response *response __free(kfree) =
> +						kzalloc(pl_size, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	if (cnt == 0)
> +		return send_one_response(cxl_mbox, response, opcode, 0, 0);
> +
> +	pl_index = 0;
I was wondering why xarray is used here instead of a list? I didn't see anywhere
that we need to look up a specific index to benefit from the log complexity and
afaict, simply used to iterate over all elements.

> +	xa_for_each(extent_array, index, extent) {
> +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> +		response->extent_list[pl_index].length = extent->length;
> +		pl_index++;
> +
> +		if (pl_index == max_extents) {
> +			u8 flags = 0;
> +			int rc;
> +
> +			if (pl_index < cnt)
> +				flags |= CXL_DCD_EVENT_MORE;
> +			rc = send_one_response(cxl_mbox, response, opcode,
> +					       pl_index, flags);
> +			if (rc)
> +				return rc;
> +			cnt -= pl_index;
> +			pl_index = 0;
> +		}
> +	}
> +
> +	if (!pl_index) /* nothing more to do */
> +		return 0;
> +	return send_one_response(cxl_mbox, response, opcode, pl_index, 0);
> +}
> +
> +void memdev_release_extent(struct cxl_memdev_state *mds, struct range *range)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	struct xarray extent_list;
> +
> +	struct cxl_extent extent = {
> +		.start_dpa = cpu_to_le64(range->start),
> +		.length = cpu_to_le64(range_len(range)),
> +	};
> +
> +	dev_dbg(dev, "Release response dpa %pra\n", &range);
> +
> +	xa_init(&extent_list);
> +	if (xa_insert(&extent_list, 0, &extent, GFP_KERNEL)) {
> +		dev_dbg(dev, "Failed to release %pra\n", &range);
> +		goto destroy;
> +	}
> +
> +	if (cxl_send_dc_response(mds, CXL_MBOX_OP_RELEASE_DC, &extent_list, 1))
> +		dev_dbg(dev, "Failed to release %pra\n", &range);
> +
> +destroy:
> +	xa_destroy(&extent_list);
> +}
> +
> +static int validate_add_extent(struct cxl_memdev_state *mds,
> +			       struct cxl_extent *extent)
> +{
> +	int rc;
> +
> +	rc = cxl_validate_extent(mds, extent);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_add_extent(mds, extent);
> +}
> +
> +static int cxl_add_pending(struct cxl_memdev_state *mds)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_extent *extent;
> +	unsigned long cnt = 0;
> +	unsigned long index;
> +	int rc;
> +
Also according to the spec:
"In response to an Add Capacity Event Record, or multiple Add Capacity Event 
records grouped via the More flag (see Table 8-229), the host is expected to 
respond with exactly one Add Dynamic Capacity Response acknowledgment, 
corresponding to the order of the Add Capacity Events received. If the order 
does not match, the device shall return Invalid Input. The Add Dynamic Capacity
Response acknowledgment must be sent in the same order as the Add Capacity 
Event Records."

Using xarray does not preserve the order of the extents, which requires a fifo
queue.

> +	xa_for_each(&mds->pending_extents, index, extent) {
> +		if (validate_add_extent(mds, extent)) {
> +			/*
> +			 * Any extents which are to be rejected are omitted from
> +			 * the response.  An empty response means all are
> +			 * rejected.
> +			 */
> +			dev_dbg(dev, "unconsumed DC extent DPA:%#llx LEN:%#llx\n",
> +				le64_to_cpu(extent->start_dpa),
> +				le64_to_cpu(extent->length));
> +			xa_erase(&mds->pending_extents, index);
> +			kfree(extent);
> +			continue;
> +		}
> +		cnt++;
> +	}
> +	rc = cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
> +				  &mds->pending_extents, cnt);
> +	xa_for_each(&mds->pending_extents, index, extent) {
> +		xa_erase(&mds->pending_extents, index);
> +		kfree(extent);
> +	}
> +	return rc;
> +}
> +
[snip]  
Thanks,
Anisa 
