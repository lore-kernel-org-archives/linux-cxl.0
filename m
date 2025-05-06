Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED0286896;
	Tue,  6 May 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557657; cv=none; b=SwTQ4RImUYvPSiee5Shjw3T+eqgnDAe+BRrtlFAFgIYykmRP4m/uFf/AhD+pcclPkQW6wG64sIxT0ZCaL61tGpAk3Nu+rOPqMEeZbaNTgET780eqCAsLJRAAMVPLI/CNWyAbBRgrFQ+VP8hpiNecP36YWiTIgUw6Kszobf92Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557657; c=relaxed/simple;
	bh=krSZxOEBsKnQoZD6P2CO+gfuZcVazW5JuHpb8tO5oMM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guIGl3m08CJOd/+ishrICGiRJ4Q1hc5LN1A+mmjy/SKcdE0FPtd/SbYtvfB74qk3fi5Zj3V4Krgnsgk6e2WjovKwtf8Dsmiu0xTRfHQ1wSiQGfhme+oebvHrFs+4PQ59JRo+UIB9JpH5QtIAsVjyVbEA6dlN9ehczCtRCX7mchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fz50dAaF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz50dAaF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22401f4d35aso72913915ad.2;
        Tue, 06 May 2025 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746557655; x=1747162455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVDFVo10DieBySNMFa20wV7jaXb2Ld88NcW0kNaRhiE=;
        b=fz50dAaFnKzln3sbhuunXYCfIeloQsZLUyEcWbJsFpi9ux+e8+P1K9fbSxmYnvOdN3
         ru9V//jY1Q1aq4Jsa22gFA97vVese3Zo5TvKgF0KfsWnwOSCnfh9Cs+wLWlLi3N+E2nw
         +WpKLw5VxK0cLZ5Cp8qbW0fvqTp7ThdIt9ZuUoBujYWkS03Cizzks7wSHl4vkX7PaCSs
         nLrDJcouiu7Iulv4/0iNTZx2WnfPEmfflHin13Vy+GVaqucWwilRtyS5j1bqgFoEsWBr
         cgAro7V6SqwfZaCAoLL0NjUKFRKjrpRfx9CR3k47hrOmd/KtMiZ3EUr24H8cB8bR2TdN
         uZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746557655; x=1747162455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVDFVo10DieBySNMFa20wV7jaXb2Ld88NcW0kNaRhiE=;
        b=tTAvNZbfOeEeSOFpTwOLGh73VjimBHweqIQ5PTPIgQuGvh55lGc5vz43t6KBZMkRLo
         L7AfS6IKIlgepgQpHiruplubwWo4UQbWo3j9/+noNcsW1WVQy2TNAj8JDlx1GuLMaPCt
         ZnmWbs6//U6C6FjlMJQMFjD5Xcy5I4yNGJta+vfQjobLdvDoEWrTh4j9JrT6zUOZT7cy
         Wt8HJPolzUEhd1mlpvgV1tnEbqTylad2BMBTUd1c0vu7SjhCqvTV+RgUJeHExvjjYnsc
         HQkourgUIC2Q/o3+Dl09pdt04a6fpYGBBsmNXuf2z6GLMt2N4TT1FK5Z1ks4BoMyWMqF
         27+A==
X-Forwarded-Encrypted: i=1; AJvYcCU5Skb6KcFGRgY5UiOp1EcgR4VY7NniY0gEK1T/PqtsJFm5Qv9FD7F1H8US0LorbrnTBPTLSm84ZA0y8oTp@vger.kernel.org, AJvYcCVMglWquqQMG1Q2p04KkvUwuziruuMlQEWxmNQw6JR+q+tqrD1hLFnMi7+WxVVWFoRhNSrKKE5B1VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDqamDKutljd3nOSrpCNVgsBc48xRQzSV1oWgzrRaEQlWRXTh
	mn4L9cGklWVZnmx/8pwTqNMEqDCS/RLCM0J6ayM8pL8OKx5wGu5k
X-Gm-Gg: ASbGncsJuLTz/YhlXJBDypqLt91i9AqS2DcuFLQ/btcsdQhgPq0YJC9wCwMSbxv6nNd
	+d1hZoCXbV+R2kcoKasokUpGFH8q0UggLtb0DDPzzoJG+1tro7xle+cpxD/7eJxVy+hJ+qD6Zvb
	CvSqO/OuZ0vyDMZvpI2kxJ1gMNBBKw43fjUlW6zWA1ETDbuuFg9+k72uOe2I8Oqhy0oR6RD/aXF
	/wSJIZJmsqy9ZcR9cgckMSbw5W4tVXQ3bvNftTCIVqzBtuPCfPkVZiV6Hsy1BYGSs78jUGhoFTw
	UYwu3zBFwrcw9HmLzCC5TTiHN15GqtJb1Xpq5YNKYw==
X-Google-Smtp-Source: AGHT+IGWjABk1DDFWWAd1ymYZVKdl75uEg9L8d6T3EYsxsTx9WQhwvX0ioT5EgFyzos2Mk6ae2PfMw==
X-Received: by 2002:a17:902:ce8f:b0:22d:e57a:279b with SMTP id d9443c01a7336-22e5ea6e606mr5700095ad.24.1746557654712;
        Tue, 06 May 2025 11:54:14 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:3afe:d39d:8565:ed44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150eb368sm77710245ad.36.2025.05.06.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 11:54:14 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 6 May 2025 11:54:11 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Fan Ni <nifan.cxl@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 01/19] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <aBpa02RH0CnRv6Jl@lg>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
 <20250413-dcd-type2-upstream-v9-1-1d4911a0b365@intel.com>
 <20250414151950.00001823@huawei.com>
 <aBkn813skYvTv7QC@lg>
 <681a34255194d_2b95d1294af@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681a34255194d_2b95d1294af@iweiny-mobl.notmuch>

On Tue, May 06, 2025 at 11:09:09AM -0500, Ira Weiny wrote:
> Fan Ni wrote:
> > On Mon, Apr 14, 2025 at 03:19:50PM +0100, Jonathan Cameron wrote:
> > > On Sun, 13 Apr 2025 17:52:09 -0500
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> 
> [snip]
> 
> > > 
> > > > +
> > > > +static bool cxl_verify_dcd_cmds(struct cxl_memdev_state *mds, unsigned long *cmds_seen)
> > > 
> > > It's not immediately obvious to me what the right behavior
> > > from something called cxl_verify_dcd_cmds() is.  A comment might help with that.
> > > 
> > > I think all it does right now is check if any bits are set. In my head
> > > it was going to check that all bits needed for a useful implementation were
> > > set. I did have to go check what a 'logical and' of a bitmap was defined as
> > > because that bit of the bitmap_and() return value wasn't obvious to me either!
> > 
> > The code only checks if any DCD command (48xx) is supported, if any is
> > set, it will set "dcd_supported".
> > As you mentioned, it seems we should check all the related commands are
> > supported, otherwise it is not valid implementation.
> > 
> > Fan
> > > 
> > > 
> > > > +{
> > > > +	DECLARE_BITMAP(all_cmds, CXL_DCD_ENABLED_MAX);
> > > > +	DECLARE_BITMAP(dst, CXL_DCD_ENABLED_MAX);
> > > > +
> > > > +	bitmap_fill(all_cmds, CXL_DCD_ENABLED_MAX);
> > > > +	return bitmap_and(dst, cmds_seen, all_cmds, CXL_DCD_ENABLED_MAX);
> 
> Yea... so this should read:
> 
> ...
> 	bitmap_and(dst, cmds_seen, all_cmds, CXL_DCD_ENABLED_MAX);
> 	return bitmap_equal(dst, all_cmds, CXL_DCD_ENABLED_MAX);
Maybe only 
    return bitmap_equal(cmds_seen, all_cmds, CXL_DCD_ENABLED_MAX)?

Fan
> ...
> 
> Of course if a device has set any of these commands true it better have
> set them all.  Otherwise the device is broken and it will fail in bad
> ways.
> 
> But I agree with both of you that this is much better and explicit that
> something went wrong.  A dev_dbg() might be in order to debug such an
> issue.
> 
> Ira
> 
> [snip]

-- 
Fan Ni
