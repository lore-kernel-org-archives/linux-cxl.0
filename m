Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E78384CD6
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772346; cv=none; b=gEqfSfLzFvkBPUBVDCt/2T4V7eXu8DREnf/K4gQFbo19hEO1hwuC4Vcmlvq9nQ7oqZqmjor/UMkUkTz0XJnL1q8o5VBZYfk9JBsB8OjBv1+WZkUWDgWRb7B/KklTBIRZ8EO+CMVgGBLQZVlQqAGSYzFe56rtPhLKZgPqNju5/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772346; c=relaxed/simple;
	bh=G/Y8boK2DU4xEhD6ed9UxEeD7zKg4QbYoDi+BwDtBu4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR8bdDU6XF+HT14VGJelDctjelyYVBOr8VyU9AxNu2z8Pvy/1p4p3/k0JgdgfbSCWfFcp/hrlOEEUEhc07uK3PjyIiXY3IUaGIvN8PTKvoGDDMFACvMmg3IfRzlBHqY4wYjA/5FYL5yXdMxKOmJvqPmkGRDudT7J6UQ/urrijm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY2y/X0D; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY2y/X0D"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895eaf306cfso11197447b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789772343; x=1790377143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7+JE5sqbMswNstG0Mf2Li3BgMognV5IketQmgnwosM=;
        b=YY2y/X0DzSk/Vje+J/91yaK5/sFcfKB2SmNxbKv7H/Qj9Fw5fKhYdEqqlEvypNbAL6
         Q8+QaBwWeebLjVAxXjfRNNYzp9mkn5OWvsP6zaQCE8rox2FVBrKvAWKszWs5YTRNo0xb
         vmoRewiPzYwiH9tN2TryCBSYtvzvT+5h7y17jfd9dwrcXYe1GVoLgdf2C8hxGhcZheKn
         bx+W3gPtuxqPT0bdFxUMxLWOHfYa4UxvSDjcI4OqB1+cTBFEOjrdtyF5Ds8YninZ6P/1
         93fJIhehSIiHfMJqBvw3955rKOF2hj28kyhI6d3HmQmtDKCEmFzMESsfDnFs7EHOGI+w
         fE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789772343; x=1790377143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z7+JE5sqbMswNstG0Mf2Li3BgMognV5IketQmgnwosM=;
        b=EZ7kMfw91cF9x95KdIQFsNYt7zbs0Y/2QUd0OlUaZWM128HhDf23XGEAyvJoeeBsW/
         XdkAe/5+5RJJII7bicmTamcYeOBFaMO0UqqHhHmaMRi3LfVuGnFVd6lcYt+PoMXzr5fj
         V2FpKGxJqqmiNvtw3OSorCG6c0ts2zUzWeeqHadDXENY7aEyrd5nwSbS6M/+ZWCcK33s
         Iy1oX6Wb1fIO0I3zDCVhg2kKg4rR2I1UDCSZ5GYcWvjjxfA+Z/VunYjXbdHc/O+qk898
         QemcwCANazpZOhNCsFqN2MRNlvFugm9JxMuvC7MqdoOf1g+qA6TidQD41039REpYpEOs
         w+LQ==
X-Forwarded-Encrypted: i=1; AKwUvByj4YjMPxsRK8TYKQw+BZ/RA8Wh7iscOFYaRp9zSQkqIQ7j1rKFnKODFcAm7cyr7s8YceUo+hVVhGc=@vger.kernel.org
X-Gm-Message-State: AFuF++mHC9PiKC5OW36hWruN05RTted/ukrC6eSiUIrWhsOVBo6kPG+B
	/ngW9qPFex5sceE+J9QFgFvnfaDBRBzeKARRPyJsLaftUJOv53xiELp7
X-Gm-Gg: AYBFou1GBLqnUTVL7SEBxs+z9zxM64i74s27EdKPVJniC4kphFlUnGXWzbnbo0lvxqR
	s5ntz0KScwd2cz+j/1eMUsJB1O9KKvp4pWQ2Lk1h3vzgjYQe6GlsOsgeJ3D2jnXRbmb74dcOH/l
	WThLKMj+H2IlQ/dwzCB0Y/lvxZzRshekTIh7HTvmKHvttVeSURTwDUFkj7F1jIE1YUaDNm1T9ZE
	c8ll8h4N6ryDmpuSPPsVVletW7Ds0lWY9mNOAisjCZlk2AAhyETSbBYvs6PzQfYYqQ07XW3ic/b
	yY3fHoJhsKX/VvJWntlyMDM6QElBGKcyZHxJSktylhdDTzSryJgmYyy68aG14nODR8vV5ac1vjF
	CJizbTAGJxJ2EXe+c4r7QhNPfLlQgAeW8XwBVzikvFnBQzpyevhvb2ULarYeuKnrKDHMMZoJtv3
	NNBD0WDNrVNMqXRi5MvopcB7UQZi6Q9xh0NrLH0rLZxFkFzqap5WzrPQmVGPEep1R+RAbNOch8v
	rUMfuBg6mhtHHWbGpuupg4OluCI6U/Y6PCAvmQt1Df8b7kK7g==
X-Received: by 2002:a05:690c:c4f1:b0:87c:62fb:9833 with SMTP id 00721157ae682-89730420b52mr15265477b3.6.1789772343583;
        Fri, 18 Sep 2026 15:59:03 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a4761747asm4285417b3.30.2026.09.18.15.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 15:59:03 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 18 Sep 2026 15:59:01 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v14 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <aq3CNTPThN2Q2Gga@4470NRD-ASU.ssi.samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-3-anisa.su@samsung.com>
 <20260918204428.E2C4D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918204428.E2C4D1F000FF@smtp.kernel.org>

On Fri, Sep 18, 2026 at 08:44:28PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] cxl/mem: cxl_configure_dcd() incorrectly treats Total Capacity as static capacity boundary

False Positive
> --
> 
> commit 72ce11842054ad85a9e98674e8c97e80cf0a2d21
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/mem: Read dynamic capacity configuration from the device
> 
> This commit implements the Dynamic Capacity (DC) mailbox commands to read 
> and store CXL DCD configuration information. It validates the first 
> partition and ensures there are no gaps or overlaps before configuring it.
> 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index b3419df586b9c..15df8db314d90 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -643,6 +643,54 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> 
> [ ... ]
> 
> > +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> > +{
> > +	struct cxl_dc_partition_info dc_info = { };
> > +	struct device *dev = mds->cxlds.dev;
> > +	u64 total;
> > +	int rc;
> > +
> > +	if (!mds->cxlds.media_ready)
> > +		return 0;
> > +
> > +	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> > +	if (rc) {
> > +		dev_warn(dev,
> > +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	if (dc_info.start < info->size) {
> > +		dev_err(dev,
> > +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> > +			dc_info.start, info->size);
> > +		return -EINVAL;
> > +	}
> 
> [Severity: High]
> Does info->size here represent the total capacity (volatile + persistent +
> dynamic) rather than just the static capacity?
> 
No. The info returned by Identify Memory Device does not include dynamic
capacity.

That's why we need to send Get Dynamic Capacity Configuration to find DC
partitions and their sizes.
> Since cxl_mem_dpa_fetch() initializes info->size to mds->total_bytes 
> (which is the total capacity), comparing the dynamic partition's base 
> against this will evaluate to true for spec-compliant devices, 
> unconditionally rejecting them as overlaps.
> 
> > +
> > +	/* A gap between static capacity and the DC partition is not supported */
> > +	if (dc_info.start > info->size) {
> > +		dev_warn(dev,
> > +			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
> > +			 dc_info.start, info->size);
> > +		return -EOPNOTSUPP;
> > +	}
> 
> [Severity: High]
> If info->size includes dynamic capacity, would enforcing that the DCD 
> partition starts exactly at info->size be physically impossible without 
> overlapping the unprovisioned space at the end of the DPA?
> 
info->size does not include dynamic capacity.

> > +
> > +	if (check_add_overflow(info->size, dc_info.size, &total)) {
> > +		dev_err(dev,
> > +			"DC partition 0 size %#llx overflows DPA space ending at %#llx\n",
> > +			dc_info.size, info->size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	info->size = total;
> 
> [Severity: High]
> Could this lead to double-counting the dynamic capacity?
> 
> Since info->size already includes the dynamic capacity per the CXL spec, 
> adding dc_info.size here would inflate the value. 
> 
info->size does not include dynamic capacity -__-

> If a non-compliant device bypassed the overlap checks, this inflated size 
> could also cause the strict contiguity check in cxl_dpa_setup() to fail 
> later during device probe:
> 
> drivers/cxl/core/hdm.c:cxl_dpa_setup() {
>     ...
>     /* Require ordered + contiguous partitions */
>     if (i) {
>         const struct cxl_dpa_part_info *prev = &info->part[i - 1];
> 
>         if (prev->range.end + 1 != part->range.start)
>             return -EINVAL;
>     }
>     ...
> }
> 
> > +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> > +		dc_info.start, dc_info.size);
> > +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> > +
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260918203049.7273-1-anisa.su@samsung.com?part=2
