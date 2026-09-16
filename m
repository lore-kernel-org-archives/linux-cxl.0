Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34BC3368B7
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789520783; cv=none; b=WedgArNvL2icpXD1P58JJyVwQbATaKNcRHg32ypZP0cdsd4BhTOI5BK1ZWIOaXrPBEZJnEddCucax5fK6VEaq6cJOktk0tfA06DSkl5JxWqzqmpP91wD3fq08PBfIc9uYye8wbmZTlErqXrzBoXFgO2R9i8nPCYWMb2R3sxrrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789520783; c=relaxed/simple;
	bh=GlXl0JCX4Grrg1EFDpstrOV3wEpYR5ADNnABA3tOodw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+MY7lm/S2sPICckVxGqc4B4JtkdpyAgV702KHWMfkqnXfL9ra7HL8sbPfjfBhMYPQtWfwtJs3skF5+9f/lCT1ZhjZAwyQbp7KsymWUE0+9shS3XD2X+Ak8m0ylBd7JM/p6iKpgr7vGAXmGlV1L34QA88RRmDMSBM+vZQLjwnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Z5n32p; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Z5n32p"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c6920so360423a91.1
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 18:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789520781; x=1790125581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jg84qR2yEECyE04AJ+NWmAbBGI2YaC6QlF11IxaOmWY=;
        b=J2Z5n32pSoVrZhyIMId+pfgxgsk9nu3dJJ4GtSVcqZDSNcNtHbGLJ6JabevKvoOfUJ
         2aw/6rIJXMg0H4u5dI1Q5+/rAoP+tSyRl109U6j2sM5L1jxOkfhoBQLck/60CZeWaxZk
         eT0EnXJlirKg2nNS2AzYbuYWa3Ck7B5+SJmZKniDvniS2La3Q4Tawqr3k/TSOFBw14LY
         4oqFW9q1P+DLC3mrKdjaiGnVUKsUwQeJeshrLvViUvL1V4my9PEfwTDAQAQGcDRaR5p2
         s1if8YJiA7kjwEf+I3BZwBZmfn8/CEy1ViFiDbYIpIa666PUnHSoUrLML/JWJKpCzPpK
         qGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789520781; x=1790125581;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jg84qR2yEECyE04AJ+NWmAbBGI2YaC6QlF11IxaOmWY=;
        b=H39hd4Zeh4JyL2XDOpJZKxn8yWkuwmumHZitlK/wRWRS+nfTRa3bn8YyW6wdE/0h4V
         +1DH3PRRMB0bTOS5rL0DZwnsriUBwAzKJl96CpomNQvnlKTChTsBpV03nfwiL1o0xel2
         edI75GP+JApoHyynr8813KsvZ827uirXOw/F0RKyT6CEaRC1oqLXI1PY6xIpsksD9c8b
         aC/eDanbBEaslYfKbqyq6heYTvwtCcsoBkNywchQ36fP+XUPInUiRj+SPolWiv2opSSu
         8HS/ocKX3/ctKXTHohv70ap+q6IrdE7nFRuJBz8XkoJu4g1iyyRLyteAj1Qj73i+OTZ7
         5P0Q==
X-Gm-Message-State: AFuF++kxjKFO0hqhzPK/KYDLsqHfuCKExSInrCJ2XXE0AfT+ZYFq1VOy
	bXaPWRcACL/TnOCqtFrq704tK55V0FXGbnWkNDmcIbyiNtGnLCagNSIP
X-Gm-Gg: AYBFou0ymzxf/VM1pDXcQ//vlP7LYVNM/e8VIFgbRBTsiaM6ZtBg8nWqd3scg09VQcx
	ROaHuWI7/knJJ5qEiwXgSoVW/ax8r/I/+bfVK2iyVqXpdwCXkiRaCv+9wszhm72yBBl+ZrWtuas
	pquDX8yARua4Mv26El/sQ2whtz7ht9NIWdnTwWngsC6WQyDauNB/BDkXkkinoGrlhHF55xw6NP0
	a70eBAyjrhFF645JgOseOVlachbmJRqzi4b03wMse23667jwpvimaDyGn/sfdgMZvQpZuB5Wjha
	RwsU0fSDv2Cv9MKXoqa2trWn7aju58u0EdWONsfMJGONx2OCNGIJ426e5ab+XMeXscKMkBk5Ljw
	aXVeP+XnXdv05h1M9ptghcn6bYLd+iFLubAKitWzBC4ybp7o0TE2hpZdoOA3e2vFLygO5CKxpne
	eDEHCHmG+sPaA+I8J7wtsdOHb3PCdUcGlmLwN6Z9ZxTAR0Lbxh/e9Fri9VDVtmLFeF6r0/uwzPj
	EYevUvWI7t8+v07Z9/OUDWtEw==
X-Received: by 2002:a17:90a:d644:b0:39e:288:80c9 with SMTP id 98e67ed59e1d1-39e1e4d3fd1mr1453690a91.19.1789520781023;
        Tue, 15 Sep 2026 18:06:21 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b706089sm1404518a91.8.2026.09.15.18.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 18:06:20 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Sep 2026 10:07:31 +0900
To: Gaobin Huang <huanggaobin23@semi.ac.cn>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/mbox: clamp the event record count to the
 received payload
Message-ID: <aqnr04OgqRuKg1xo@cxlqual>
References: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
 <20260914125701.1160136-2-huanggaobin23@semi.ac.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914125701.1160136-2-huanggaobin23@semi.ac.cn>

On Mon, Sep 14, 2026 at 08:57:00PM +0800, Gaobin Huang wrote:
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
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
Hi Gaobin,

I sent a similar patch a part of a series while ago and received the general
feedback that the driver does not need special handling for a buggy device:
https://lore.kernel.org/linux-cxl/20260901002912.958-1-anisa.su@samsung.com/T/#m38ed8d6482902f857bceef314133a67937cc012f

However I see from Jonathan's reply that this patch should move forward
with the "Fixes" tag dropped.
If so, I would recommend shortening the commit message to something like
this:
==================
cxl_mem_get_records_log() takes the record count straight out of the Get
Event Records payload and uses it to read from payload->records[].
An oversized count reads past that buffer. Both
__cxl_event_trace_record() and cxl_clear_event_record() use the record
count to iterate oer payload->records[].

Bound the count by mbox_cmd.size_out which is already sanitized by
 __cxl_pci_mbox_send_cmd(). Report a bad record count as an error rather than a
drained log, so a device repeating the bad count does not keep the event
thread re-reading it.

==================
And could you CC me on v2? There are some minor conflicts with the DCD
prep patch I'm working on, so I will need to rebase those.

Thanks,
Anisa
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
> -- 
> 2.34.1
> 
