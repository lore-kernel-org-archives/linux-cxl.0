Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E10155747
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084875; cv=none; b=rhZkFVUrvo9HKJiZ+byYZNHWAH4ShtOG42m2k5V1WuzbiWHU9vXlHMTuIpCpx33TQaRSwFVo8cyq424v3EtCcZwulUuMtnOdq67SQ3rxayDY17I9CekVo/I3Zf9TMjes+p4Mu4TDGx5F7+K6Pthns7yWxR3sydJ/HiZEvlWy1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084875; c=relaxed/simple;
	bh=peu0t9Xw53G/T5JH7prMwuBSuRj/MQDMixoDJdQ8bNU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIN01vOirsMtu0d2b1BQsufGjQsRslr3z43G9lVLEtQw+9votqKJvIELe4VXZoOWkhth84Qixf84kDyVkVxVqzgaSFoh6W0E5wPTLSJcvWC21nEjWkUJ+vLXUDu8TOYMY4iJl6FugPm2BCB+fWFBAhZnoE/p/cd8JXrE/soH2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbwW9WEy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbwW9WEy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8534d507f59so369721b3a.0
        for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084873; x=1789689673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EkytwwKCZNAAeY6/LS+mjdyKcFuqGfXmQXk+fjhpBhY=;
        b=cbwW9WEyGShKEV6vb+R28wdOonnHHOgnE7yLWd+QnVJEeP87NXpq3buPEfP+R6Ia2l
         pBV2saKqphH8pv7CIOvlMivR7badHlAwXKCWIEpRxlF7WoX87XAI9YtMI8w5tHKItdhE
         xTTkQ3yUAkapMa5zMDQS+prvjcQGmxACYfBWPdW8g/SMqDkBVQwgputer0unTDw9jCvf
         J8VDi109koxHpHMkD1L3nNMxOhR52OSfVQ/yiZM+eZ+zOUpP3M90ps30oh/9irbePNwd
         G1tXrSchllSuPsBvwYipEOtxQcmVD/0rPLUopv5q+W3dJ3Fh4mOcLAX9z05NVZgFNUUW
         F+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084873; x=1789689673;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EkytwwKCZNAAeY6/LS+mjdyKcFuqGfXmQXk+fjhpBhY=;
        b=CmUQBOvW6tBxK9JSHWPmVSZJtmTIbfLX5FeFMe/zMH4ZUXrgcNuJ5BucsbKQeq0rgB
         pgbOY/8rQ6Fm6Y3E/ICSopfxkgsCpb992ACKz9fKAdU+GHPApVAVKQf/YY79/OS6jqj8
         zpMlz9mvi3v+/vAaCN0XlqfvERw0lWtL2s+HPiiPgpboFkmdsSXHLkpEgpxh4qpZO6Vw
         AHliwUKJdi+EjUJkmFqdfhfqm1/AZRGrez+oqUA9GJBdz2SYL5xeX5W0KQP9RV2MBwtb
         YUeKG2qhpgDjmDIAsN6wbbYfQpPLgy/m7MnN2+E/HeRin2sFQFqD4REMldul3f1Ny6Rt
         e6Ig==
X-Forwarded-Encrypted: i=1; AKwUvBxkpUXsxhxj4ALo4UI3FvcnMEDY/yxsF4l7SKLW+xkuqu7pyhs3Aw1EFiglbKRqXO+zP87I7guSBTM=@vger.kernel.org
X-Gm-Message-State: AFuF++mfGqjFHfWwdqwuSZS7+N+KbTG66oV3DmW/V39UXAspMqYBp3LC
	N6/UTADInWqhT/8c3ccU97GWoKwAwCz1OmNx/gCo8igpsXFK/e1jWm8C
X-Gm-Gg: AYBFou1iE+HrW6Qpvjj/Erouuq4B/pMtNAyodVEYmWo2mLIp1asQhkx2RxKYH/P9wIv
	auAkUoI8uPFG9q2uuTvVMAXlNYmEaJi3ndgg5TVceId2yUFqlbqHRzoDdPX4HoWZyMvZUZJGsot
	xV31MQVDFJcPbw8zwfx9XxP4U4ESWFm0SZ1oAnpLRHTRpXasa4dHkOEOQY/7fRpG+YtgqMHSfY8
	tMuQhn62gyPHlapsuFj51zm5nKhkKg23Jb3cjw5tiGMuS1v6VKtsGXzVFn6qSMwnW8zw8EWPbDJ
	tL6EZ+HP4XBychmRZ57wfWMBJxhHfV/bFVdoop7xYjg+VZKADfhFDIlFofm11dyzBzbiYWGq+HK
	IkqKHCz5w6qizEYu1jAD66jGoigHij7Qeqr2pYEjMRhlz8t1lrjMaHXzuTA5vm2c8vRu/mrIebc
	ZZAuonE3+JYpKFN/1rNSHsmaa5JtVekg2glyPstspsS7QfE4XXfH1porKC36wbSKqvf7bblkSxt
	YFWvZVFPQeGdkHJVsQzutf5Wg==
X-Received: by 2002:a05:6a00:a244:b0:857:7337:5db6 with SMTP id d2e1a72fcca58-86b31201f84mr2307427b3a.20.1789084868497;
        Thu, 10 Sep 2026 17:01:08 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a2b5c72sm224410b3a.52.2026.09.10.17.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 17:01:08 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 11 Sep 2026 09:02:25 +0900
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, dave.jiang@intel.com, gourry@gourry.net,
	icheng@nvidia.com, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 3/8] cxl/cdat: Gather DSMAS data for DCD
 partitions
Message-ID: <aqNFEUWNMmTvJmh_@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-5-anisa.su@samsung.com>
 <20260908215200.6f825aa1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908215200.6f825aa1@jic23-huawei>

On Tue, Sep 08, 2026 at 09:52:00PM +0100, Jonathan Cameron wrote:
> On Tue,  8 Sep 2026 03:15:07 -0700
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Additional DCD partition (AKA region) information is contained in the
> > DSMAS CDAT tables, including performance and shareable attributes.
> > 
> > Match DCD partitions with DSMAS tables and store the meta data.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > 
> Minor thing inline. I think we can take a bit of refactoring
> you did a little further and end up with simpler code.
> 
> > ---
> >  drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
> >  drivers/cxl/core/hdm.c    |  1 +
> >  drivers/cxl/core/mbox.c   |  9 +++++++++
> >  drivers/cxl/core/memdev.c | 17 ++++++++++-------
> >  drivers/cxl/cxlmem.h      |  2 ++
> >  include/cxl/cxl.h         |  4 ++++
> >  6 files changed, 51 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 5c9f07262513..05058d4520f2 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -17,6 +17,7 @@ struct dsmas_entry {
> >  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> >  	int entries;
> >  	int qos_class;
> > +	bool shareable;
> >  };
> >  
> >  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> >  		return -ENOMEM;
> >  
> >  	dent->handle = dsmas->dsmad_handle;
> > +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> > +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> >  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> >  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> >  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> > @@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> >  		bool found = false;
> >  
> >  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> > -			struct resource *res = &cxlds->part[i].res;
> > +			struct cxl_dpa_partition *part = &cxlds->part[i];
> >  			struct range range = {
> > -				.start = res->start,
> > -				.end = res->end,
> > +				.start = part->res.start,
> > +				.end = part->res.end,
> >  			};
> >  
> > -			if (range_contains(&range, &dent->dpa_range)) {
> > -				update_perf_entry(dev, dent,
> > -						  &cxlds->part[i].perf);
> > -				found = true;
> > +			if (!range_contains(&range, &dent->dpa_range))
> > +				continue;
> > +
> > +			found = true;
> > +			/*
> > +			 * part->handle is from Get DC Config, dent->handle
> > +			 * from the CDAT DSMAS entry.
> > +			 */
> > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> > +			    dent->handle != part->handle) {
> > +				dev_warn(dev,
> > +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> > +					 &range, part->handle,
> > +					 &dent->dpa_range, dent->handle);
> >  				break;
> 
> For the error path I'd just return here. Maybe there is more after this loop
> in future patches that make it useful to break instead?
> 
> >  			}
> > +
> > +			update_perf_entry(dev, dent, &part->perf);
> > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> > +				part->shareable = dent->shareable;
> > +			break;
> 
> Come to think of it, can return in this path too.  Then you don't need the
> local variable found.
> 
Ah the break in both spots is so we print a debug message if no
partition is found matching the dsmas entry:

if (!found)
	dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
		&dent->dpa_range);

It got cut off in the diff.

> >  		}
> 
> >  
> >  		if (!found)
