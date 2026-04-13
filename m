Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424633342C
	for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099628; cv=none; b=jgNTJbSNyiZefA/X/60ugEXdXGdOUtSm8lcmrx2v3C6N/MVAfDdNz6SKppUmD7Z1zn/YmXxP8+lU+2IQQ5KonyKmukNuca5ZT1C1auNWkmZoEI2Dqouu04mBhcZiZFR2JTawMyvqLrr4pcdRSyJotFz1u/XrRN6o+6USv6H4Ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099628; c=relaxed/simple;
	bh=V4hEnAZxKuwaJ9PqkLbciWhg+3ROm1u+rxRk6nQwDM0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOMZFzpBzzq179TPfwz3RnHylGAbtE6g1/sinZcB6OsjKq5e1VKMkhU6I+McurKU89n8iHtxTUHT+6KtnrRvO6JKevXLRRuk7oSYlXv22uxB+b0BoQwkvF9USEOW7JxIrSYCXbgcrMm06vPiFIko/pe6FicFPi835SblsyFtEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ9QF2B9; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ9QF2B9"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79827d28fc4so45436117b3.1
        for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776099626; x=1776704426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJy7PSduVhxOM1c0SH6x68qEGth43CdR2XSjKO4qMv8=;
        b=YQ9QF2B9whE9aX95MnHBtE0Bfcfci7yKQNCALXR/kl6HQVaVv1qpYGB3oXtXpsVYNT
         neKSTF3gO9JT8K+VCV7QVQbDEBv9PO22d9+gfl2clLKXY5BZvh3pi+67IAQJjxQsHkdo
         f/RW7ah59GI5SgpIIsnF25WWaNCWrsMOnhCmJL2fUpkA7Ilv/pA7fLIFq4RNiNArd3OY
         dHO4j5voxpvR53XqkjOLzd7pUUMNxZWEgDa6M3iqEwNzONpJrp8CCMyE3awYDV4F6WnW
         0l+fAJjgrg3/E9TYsWNs/ZCe0or4Obg+Sy8jxVQLU1ECmIvS8FhGITOhQOIUFxQVXTJQ
         2Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776099626; x=1776704426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJy7PSduVhxOM1c0SH6x68qEGth43CdR2XSjKO4qMv8=;
        b=h/r/BqXj51KHr6iuuTDkOroQZkeiNwT1h9pRlb1qddnmkuSa2/XH6NZ7bZbvshm8PL
         AERKCji6AY65H9stTrpIIEYBfsPpSe2WIHIddA+T8+73IxxY9jEd94BloFrWPhYIWFJj
         JteohpIWqJ4mIwZzd/lPorG1LbJ1iT9NvR6oLxX/c3qpE+9PwqlohORm5Hy131nZPCJq
         AC7Jk7/4v1yB8bHxdEzssSre/JxjlVu+vwf9J6VSH/QJAuR2REEDlq1T+HgcK+1sOhdE
         Xulkuz4W09rKGtdTrCfHk7pw+l2iujIyMKgyv7L8TnR23Pk/uJQMtcQosDnjyBaOObmh
         XvLA==
X-Forwarded-Encrypted: i=1; AFNElJ+j7MgQkSLqRCLC2kVFk5OYQanFA70VxbyjmSTte/ElahvhCzPZnqshp7cV3BuCGW0LrN8XPFEItFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLvWRpz/5GqSR8cdpZlkwmuNBJkVArDwHjGH/R7KewXIQ21Ty
	UImqDlGN9fA7wASP01ZP3i0MZjoiN5MminiGnW2lV9EZWZcfFf1dtcii
X-Gm-Gg: AeBDievxvam6eUNS172zR1sUy9jvKOmt61p7F4BpgzYDeN4nggtiqzn56bC3lP6BYzI
	5Z+s+ishX7ZYb5txddx64Nx/YgkKbeKB9k93gocFh8wBGoqyr7pZHQTgnwqeMNHSW5/GlsMlH9D
	Q3VMSbIRtUcTDfbg0BBsDGS4gIzvNVJDg/922h3PqhjrUFFugw8mjQVSeHUBRrozC6dLjH3ixnJ
	IbwzlMqalMmvYDX4drQCmJQpHry2Grs2uwBf0XZMLrr4oGcUMf2skKgUkf7pjjXgCL5qewjvVGs
	rk7G+5BWJ2l6NPWWDyBWibwroBxvNJGN8i/z0si2SbTvtUDKxR8ULW8FkxdbAjpKE1T43MlUH09
	mQq2lEBddt5qDZDq1fp0eAgxgIKFv1zXx4urv21DEv0iKEUD8hWblWzfzxC4hes+2nnrFGa45Yj
	xOi4xf469nwkazbXCN/eaA2FrqUE6rUSPm4YYA3MssgQ==
X-Received: by 2002:a05:690c:34c9:b0:7b2:1bf1:800d with SMTP id 00721157ae682-7b21bf1837emr70090157b3.4.1776099625963;
        Mon, 13 Apr 2026 10:00:25 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3d5b0a42sm55740357b3.21.2026.04.13.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:00:25 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 13 Apr 2026 10:00:23 -0700
To: Gregory Price <gourry@gourry.net>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v5 2/3] cxl/core/region: move dax region device logic
 into region_dax.c
Message-ID: <ad0hJ1q5Lp5mckt1@4470NRD-ASU.ssi.samsung.com>
References: <20260327020203.876122-1-gourry@gourry.net>
 <20260327020203.876122-3-gourry@gourry.net>
 <admPeJv7mjDZPhJv@4470NRD-ASU.ssi.samsung.com>
 <adnXeR7rOEByIg6n@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adnXeR7rOEByIg6n@gourry-fedora-PF4VCD3F>

On Sat, Apr 11, 2026 at 01:09:13AM -0400, Gregory Price wrote:
> On Fri, Apr 10, 2026 at 05:02:00PM -0700, Anisa Su wrote:
> > > +
> > > +	cxlr_dax->hpa_range.start = p->res->start;
> > > +	cxlr_dax->hpa_range.end = p->res->end;
> > > +
> > > +	dev = &cxlr_dax->dev;
> > > +	cxlr_dax->cxlr = cxlr;
> > 	cxlr->cxlr_dax = cxlr_dax;
> > 
> > Running into segfaults without this ^
> 
> This should have been a purely non-functional change (the code is just
> moving from A to B without changes).
> 
> That would mean the original code should run into this too unless I
> mucked up the move.
> 
> ~Gregory

Wait no sorry I was wrong... I got confused by the merge conflict when I was
rebasing the dcd series

Pls ignore

- Anisa
