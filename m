Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660A41A794
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311972; cv=none; b=TmE68+PrmPGitCAMOaXVzrbzNyiTB6EgSuTXWP5I/ChCfJD1ldfKuNp/zJbZL+qiI0OWLGulnCYftaCDYdCA3/kLCGqkeUm7noxyNF4porTJybcS+US72SREiC3/0Rl/7xFfGF25EquTyYOE0sb+liZLXKLJh2dGZoOB2SUO3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311972; c=relaxed/simple;
	bh=IvZkXKAaJ3qto63ByJqwB/Pqe8jV7U9Ac1mrfqxjOAI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNrZhQxTnhvvGnXNlQxJzg0ERLFjCVwdSDUXHWGYJbjkYCx8l3/qf/XJpqrckxJ/nh7hHsn3CqGI6mP3H5TpPZtemAMAU5xjivuXPyUHIpAZqdu39IdLxtmXHXwK7eij13s2SyLLChK0m29HxdFEqtwN4Ls5MfprhSi+APfekaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsCAc5fU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsCAc5fU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso612702b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311970; x=1785916770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+pt8D4B66zZRU8DzGcBGgfx1THqisEYsOCpc1gf1Dw=;
        b=CsCAc5fUUhlZeKiVS2OLeBDJONc5HCEiEFDA3aPjsWUBswbH926Izx++DkE3f+HeP1
         jDQGpyHe+duhmexCz5NZxQainuD6wG3POXHuTX/Uat2W6T1cXx6VKv7PHC70FW9AzzSm
         J68/QKT8YIKuhnVynzpKTGCDA4/6vS488XEGYOgoXgGzHvQjh/e8UEI/kbRyMY+OnsyG
         8XRjeoEfX69k3KBYEQVM44rrdG8U10zidK/WmPWCOLLzYmbjs30TK7aqqLSy+MScH+gD
         /kHr6lmeDjYfqbSPTv5Ck6+6fgdnzlUcbnaFFZzLsLaltF1kvWLW5YvmZoJhaR18tY6P
         5FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311970; x=1785916770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y+pt8D4B66zZRU8DzGcBGgfx1THqisEYsOCpc1gf1Dw=;
        b=ZOoyzHPA7qkiOZRk3qLmfsI5B7qurE2xrBwtZr1FsYreCp5QnP2crlZrqLP9ZteBkb
         6540XzA89r2RJBiA6VZMnaqobnvaTWkoKTOCec5hXsgyqh1aRZjBNZTrJW3XJrsP3mp1
         QkWRNxalY95Jjg1H1r/Vh/GWDSsBM0jrCGCJhXRxuuwXfxEmWHbClTsOPar57qXmNadI
         HTE2CWtsNVh1oklVKCcQkOIDI+roz+/bhQF4RezqXTEzfmuJOO6BSyFHtUnEZ0e0yx1+
         AowfONwAQ+2BYDYehd0zMsFbyKWddfs8/qA3zbvtWmQhl9qOyd4nPr/hd/nMvLvUtf46
         Bj5A==
X-Forwarded-Encrypted: i=1; AHgh+RprT+LFrzeYEKTgiIygsDvRyQ60LoEnRV0j8PiiF//Z92LHaUdj+rC9aEI5eqRk4bD3YMe5lKk1TIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2ZLpDjpwLFMFh4oHtZPqNIpImZYtJnE0/D5kg+w9gAoKqqx+
	aHMnHXbT37zFVdLTqI/ndM/ReCGWEKG5jcug9ocaXHR34TYTfvVboo6U
X-Gm-Gg: AR+sD138UYA3rxE1w6bEKfz1ws3x7sa/ahsnZRPMLs8CgzR2wDKEXnWzbqbMhtX9DIt
	tlGbSW1Bf34TeMa4QzODInjied3g4Y/4hr9LiZvJ+PRIJhPvb+kaFoFvcH/xg9C5mcIdIbKXHRu
	/bsiSkG/aSWND43pz39HnSPGJjCjd2zazfGSznpUZB5nHK3ktOBhVGRB6h6ZpFwBu1D0ykVfzdx
	wulqRTNHh05pRh383d/zmk/WXwy44MgjHpQYLWSUxRowj/MhHTn1hu4dDfSRjjimhaXW1ubCDSP
	8O5Poa4wtcTpDaqHm1M1ry2kUgX1iXtLPHgclhrZuUPdYII7viFej0IbgIZV7ILOz5W5PBuAK+4
	cw6Syfy3AQQSLzPXOV/NfhirPrnulLBSiiYrJazL+H9N+jSFCzq8nVV129WEjRQ4MZbDmyXJpRb
	2chXqaLldRX0XNvo7bGqn2+LYx4ICKBMie6m2UbOxIhjQJ5Dt2OXg+L7qGhFl6cCqRPHBJjZiAN
	VW3tgJEDtoih92yaZO0mg5VjNjC1Q7/VOXjghZ2Lt7U7j3aAdT7diM=
X-Received: by 2002:a05:6a00:4c0d:b0:84e:165:da6f with SMTP id d2e1a72fcca58-84ea794a80cmr1312522b3a.10.1785311970424;
        Wed, 29 Jul 2026 00:59:30 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb824d421sm526825a12.10.2026.07.29.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:59:30 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 29 Jul 2026 00:59:28 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v11 15/31] cxl/mem: Drop misaligned DCD extent groups
Message-ID: <ammy4JqjW3SB10Yz@AnisaLaptop.localdomain>
References: <20260625112638.550691-1-anisa.su@samsung.com>
 <20260625112638.550691-16-anisa.su@samsung.com>
 <20260625181945.41C431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625181945.41C431F000E9@smtp.kernel.org>

On Thu, Jun 25, 2026 at 06:19:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Un-ratelimited `dev_warn` on invalid CXL device input can lead to log flooding and Denial of Service.
I don't think that's very likely but fixed to prevent future complaints -__-

Including 2 other places in Patch 17 and 19 for consistency:

Patch 17:
        - mbox.c: cxl_check_group_seq() shared_extn_seq-density and
          cxl_check_group_partition() partition-span warnings.
Patch 19:
        - mbox.c: cross-More "tag already committed" warning.

> --
> 
> commit 2eb192d0644cd71e7046e47b82d5b1422081590e
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/mem: Drop misaligned DCD extent groups
> 
> This commit adds an alignment check to cxl_add_pending() to ensure that
> extents in a tag group are aligned to the dax region's mapping granularity.
> Misaligned extents now cause the entire group to be dropped.
> 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 08f51b8807c06..14ba263044f08 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> 
> [ ... ]
> 
> > @@ -1395,11 +1410,38 @@ static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
> >  	return group_cnt;
> >  }
> >  
> > +/*
> > + * Validate a tag @group before realizing it.  Returns 0 if the group may be
> > + * added, or a negative errno if it must be dropped.  Further gates layer in
> > + * here in later commits.
> > + */
> > +static int cxl_validate_group(struct cxl_memdev_state *mds, const uuid_t *tag,
> > +			      struct list_head *group)
> > +{
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_extent_list_node *pos;
> > +
> > +	/* Alignment gate — drop the group if any member fails */
> > +	list_for_each_entry(pos, group, list) {
> > +		if (!cxl_extent_dcd_aligned(pos->extent)) {
> > +			dev_warn(dev,
> > +				 "Tag %pUb: dropping group, extent DPA:%#llx LEN:%#llx not %#llx-aligned\n",
> > +				 tag,
> > +				 le64_to_cpu(pos->extent->start_dpa),
> > +				 le64_to_cpu(pos->extent->length),
> > +				 (u64)PMD_SIZE);
> 
> [Severity: Medium]
> Could this un-ratelimited dev_warn() lead to log flooding?
> 
> If a malfunctioning or compromised CXL device rapidly sends DCD_ADD_CAPACITY
> events with misaligned extents, it appears this could spam the kernel log
> and cause high CPU overhead.
> 
> Should this use dev_warn_ratelimited() instead, since it is driven by
> untrusted device input?
> 
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260625112638.550691-1-anisa.su@samsung.com?part=15
