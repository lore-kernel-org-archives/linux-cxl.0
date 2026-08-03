Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A4331203
	for <linux-cxl@vger.kernel.org>; Mon,  3 Aug 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771851; cv=none; b=mKSwfB26kTrUVSZc2B1CqDm0umMe9fMLeT/DQNq80docDA1hZh5DUU/6QBQYnS24GekqNRkIVv/e647isV57K9E8JdGanod8kq/yufEcUKsRhXwcn9g/FqhB2tBSrMS5iJa0hAhnUQ+jydd+HGpZuc/o8P7/MmlsQRAHPTrutXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771851; c=relaxed/simple;
	bh=U6WCpFIaj9Ldkepqa8ZWS4P81gu0qFQU3JuhIKF7jU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaSi38WoNOU80sQ/ujjY6eTwMdFM2h7tWKIloZsEyVEgMhJ2++AXGLscnSoVkAJPPkUDvu+rJ2OEW1QKBU3W4GJ+S/CExdaGZoKyhoUC/DJyhyaZ9BfupAAkmjbuzA76ieQMtaqsArOF6vpxpdoTWZFCRWfSj41s7+29GDkYkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgIcnbm0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgIcnbm0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3318467a91.0
        for <linux-cxl@vger.kernel.org>; Mon, 03 Aug 2026 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785771850; x=1786376650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SrhAm/6//YgJz8cqJEcdVdktRz2BVD+nvXX5seWQO+U=;
        b=WgIcnbm0MGEqZhNqD+lDGMpFkxsflnV+REYcClgHgUhsW2sh6tdLC8pN1ONPd9Quv3
         svUyldSCHIFSCWJyO7PPmCgIr64e5FI5npwhDj2WtgYkZpbX89pzilA6nqNFbhFxDoKE
         pRYB5DEXrrKy+Hz0JTkNGpFkCBktdJy8rIvDUI5WcfvkXLt9UiYwi1ROgV02IaUKp3vY
         NDqlNXrWdLf9ii2DCJFS1dco54Dova1L31TAZL4gqSlpx+9S5IWu+vfXJ5TnG/vvF1nY
         H4TBkdUlBkxRsg/5FQ5EcNbv6nQGihAqxbMWRckQHN6xadSecX9HGyR5Xxyy/Hmm3cq+
         khJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785771850; x=1786376650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrhAm/6//YgJz8cqJEcdVdktRz2BVD+nvXX5seWQO+U=;
        b=KNItoBviFLvxJRrhB/G9JepWUAyMGRvjYd96novOWtN3/FitKUPVK+DHifIRWpnuU3
         VhPZXomQ1akmNPaqnZAjYRlFqcXJ4fuH9RrNydZLCVZLZLKpKB9gGP0l8vIM2mka8s7b
         tHoAMo6soshAk6dI9iLeYGolCp6RA3zg2hySvxskUAOhrdG4bMxwoLs1Fp635MAEbxJ/
         vH191Z8KJm+ArsXaZ8tUeTCWwLnfAPIfdErZQ97rv11CVjsuUktZscP1cjupnddiFWf0
         /aGw1F3ue9vKOfPlNUhejH3IqAqxxwMS5JRNGsx0ffvTKqvt2yWIcpbtHy9I1nF58wj/
         +BRg==
X-Forwarded-Encrypted: i=1; AHgh+RrftQrbdT9BapldSA0/XCsFA3ukqGWP6h6wlKWj0Hj4pYMuPf7ocZDHKZRbebpemtOJ3NgregrdNOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7T/nz34ZcHfJZ5uYnC68ebGrcL+9odejEbvW/qAjppsCP63Qf
	5DWeuVNq9i6RSOu+bOHpJ8qf7pBgEAeFYhbHEoxA6ADTTFD8vaDfoRUm
X-Gm-Gg: AR+sD12Ns2hVeft0j48jE7cnaN2gJHCoiIfVGAOh8V0X0ienSP/yEqj8djx0bO+71wX
	yUKvosXOeXgkxsmhTOGIgga1d3mtxEwsb/4gtHxGrkQprU/ccELAk9ppC9PUb7l5MwreGKP2TIs
	Ijy6GjLzixJ+inkVaYXrMEopAeui8ZlS/zA5p7XrLgOXXKsDd5DTeY5zW/MmaApz+8RqqH9sjvO
	anN8+Ei3ZBpgPpx3I5QzS+8fiscV6i1xIRyWdcrrkSZbrUpyR9PSKLUXwIx3ARdFEA2GZ0mujFy
	MLcHo7JbAE1SJcl3La1oj1JniJOnoC3p2sRQg6VexTTnqldVlkvBlurHjWR/OLnJjkx7VtyIBAd
	fUs/CTiOUd4nFN08h9r7VfK9kAZsVVrJlyNIK4MJSN2LumE8ublVt21L1VQmbkWWka83/R/C4RV
	Js+m0w/gGUgeRZlXYROGQ+i5zKahf/sQexzG51NNtD7Hiv9ykUet2sc62BOtJAPcc=
X-Received: by 2002:a17:90b:4d8e:b0:38e:a74:dfe4 with SMTP id 98e67ed59e1d1-38fbc534570mr9945161a91.25.1785771849528;
        Mon, 03 Aug 2026 08:44:09 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bae2efsm4191757a91.11.2026.08.03.08.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:44:08 -0700 (PDT)
Date: Mon, 3 Aug 2026 21:14:06 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: use %pe to print error pointers
Message-ID: <anC3RiB8bJP0w9ws@acer-nitro-anv15-41>
References: <20260801101217.12778-1-shaikhkamal2012@gmail.com>
 <am4pLLTXXZLMaHw3@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <am4pLLTXXZLMaHw3@aschofie-mobl2.lan>

On Sat, Aug 01, 2026 at 10:13:16AM -0700, Alison Schofield wrote:
> On Sat, Aug 01, 2026 at 03:42:17PM +0530, Shaikh Kamaluddin wrote:
> > Make the code printing pointer error values simpler and address the
> > coccinelle warnings:
> > 
> >   drivers/cxl/core/port.c:939:3-10: WARNING: Consider using %pe to print PTR_ERR()
> >   drivers/cxl/core/port.c:1275:25-32: WARNING: Consider using %pe to print PTR_ERR()
> >   drivers/cxl/core/port.c:1309:25-32: WARNING: Consider using %pe to print PTR_ERR()
> >   drivers/cxl/core/region.c:686:3-10: WARNING: Consider using %pe to print PTR_ERR()
> >   drivers/cxl/core/region.c:3778:13-20: WARNING: Consider using %pe to print PTR_ERR()
> > 
> > The %pe specifier prints the error symbolically, so a failed dport
> > addition reports -EBUSY rather than -16, which is easier to follow
> > when tracing port and region setup with dynamic debug enabled.
> > 
> > The PTR_ERR() uses in return statements are left unchanged.
> > 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > ---
> > Tested with cxl config build in x86 Architecture
> ^  Should this say "Compile tested only with cxl ..."
> 
> 
> Hi Shaikh,
> 
> Thanks for the patch. The code changes look perfect.
> 
> I'd like you to spin a v2 of this for the commit message and log
> only. No code changes.
> 
> Commit message: follow CXL subject line format, start w uppercase.
> ie: "cxl: Use %pe to print error pointers"
> 
> Commit log: Can this be reordered so that the code improvement is
> the reason for the patch and coccinelle is only the tool that found
> the sites?  We don't change code to address coccinelle warnings, we
> use coccinelle to find code worth improving.
> 
> Please take a look at and follow the model in this commit for your v2:
> c69ca4e992e3 ("mm/zswap: use %pe to print error pointers")
> 
> It would also be useful for the commit log to note that drivers/cxl
> was completely scanned and that these are the only conversion candidates.
> That documents the cleanup as complete and saves the next person from
> wondering whether additional sites remain.
> 
> -- Alison
>
Hi Alison,

Thanks for the review and the helpful suggestions. I've incorporated them into v2.
v2 link: https://lore.kernel.org/all/20260802112029.28767-1-shaikhkamal2012@gmail.com/

Thanks,
Shaikh
> snip
