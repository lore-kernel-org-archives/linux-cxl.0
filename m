Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F621324D
	for <linux-cxl@vger.kernel.org>; Tue,  1 Apr 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532026; cv=none; b=mvxwicgv8j4uWGI1ixJnj4J5zp5+u/+lMZ+a/GH1ItzK9WXaTXvITb2mg4lo8aUbUEb59XkiZLGIxTfTQ54Im8gXukI+ie/fjsBqBrvAMImYeVYhARcVy0F/VPMlAaOwbBvQidLGyaaF3w2vjWZdi5Ef+gHtB/N11vS/XdJts1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532026; c=relaxed/simple;
	bh=VmOW25Uu18kqJ/Q/c2B326aYuZrol3Vn7zIK9xewLxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVwW2X9UqldD0YCHJ1z/3NdqqCkqCafLApXV7yibiLLfM6jYA8oAaguKEVxmf8KK/46/smFbR8+5CySxCj+jHEKFMHnkNihldP/Fx97SfK+mJpsxXIxAaNTK94tvMeHv6B6vH36lJoNQyWX6NBormd5a0kWI/FkGn6chUJLbWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UtTp4c5G; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UtTp4c5G"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5568355ffso509276685a.0
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743532023; x=1744136823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4nLQiuuG0BM5akZJEC7W4RuhjTkTJm6pS8m+94wOjs=;
        b=UtTp4c5Gs09ZmKoZkUbZqjunORUlq8JaZqnGGkVxIvSxAB8OC8421Wn1EiTa4WWLL7
         HdPFAEy4Sh3Em8R3BSKAxqd6+i2wFUZ028F6JvmfuBTSR3AdqQuzaWWiQ+S6HU3hmTCX
         KD9pLRExYC6CEqyGrXq39s9R9YqWUkKIC1s6XAuD302V46GuOalaMCqhyVeVYZyex8KP
         rOX+kysvGXTvoOaU1a+waCEz9L/3d7gFLVD+riOTfwYYQsvvfpkjCyP3GstnCZuCeD1T
         YutXPWoD8s3smOZ5pK/ol5j8/rdxVFxee3yzjR/GSXG50/jhwYq6atDR5VIPoQE4f7gt
         QUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743532023; x=1744136823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4nLQiuuG0BM5akZJEC7W4RuhjTkTJm6pS8m+94wOjs=;
        b=b/M9OWQTt8aAyd0ycYhKG8r4/vra1HNTNlnnxVYtuwIvz8aC/tqF5yDcLxlI8oB/LN
         nLEfto173ymraZqVPI/yIgrvko1uGxWUW5WvL1GqFMhP+3kFclU71IgQ4p2ptqZe3IHy
         AmrUym4L9W/eka8TA6r4A6Ke73vdC/cLEzZnGGkPG1DgIm99DnG+7K9JUOO9P+cKeThJ
         Y96AIdSPnhID3YuRVw+1dgiDNH2H/Gc+Mg8TSegKIf3kZ4+5ASS9kgqfUVxP8SiaRYh/
         D/vjMEISdocZIi2GT1l7Bcg+KMtwIZycyW0XBnTzOucupuA3e98KIZCMC7Q658G/YxVy
         whOA==
X-Forwarded-Encrypted: i=1; AJvYcCUZB2K39jHL35ippBg0cp48gPUp8Vtdz7QlFFvD4m3pKPyRoVh1lb674eIawg4v+98HwVPJHZxaD1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4pw/kBMTve2/W2hO7TXUSgQEi01aWLxla0r2bqf+G+9RBTLkc
	VyygT4GKQYBGibCnV01X0uqSTVvFOOV4OTff4zzbHSYXRPGb1gAZ3/4S/Kdyfz0=
X-Gm-Gg: ASbGnctSEsIVZcei4UeoJ6GinaSbmBYvilvtQKpwWfaj7hvDZ1LxZg0JSyehaS20afs
	RfFR/1yeQhDIj17yc7hA4lqIxEv1ugaILUxR2J0shb5qGExffqeyvNwjCrQFK8fvKc4bcFSdVLC
	9Kr9fFTFUJ/ZFiidGXUKI0c8sePEOy3N42PK4z7taoQ7kQSh6hsV/PaUQ2TWE254rXgWi4AzSTf
	rUt06SsV0DV/Li4Cku3QJo9qoE7YY+DsgdFim0ot8lNRXx7hvfIJXb9Y2NYelsV5Xu0+TkTmEao
	r0UnlfKvWpf6yd55/Y9cxHrO3R5ZdNeurmhCctIhVpPSPVZqfXtz719vKmXgkZD7oXNopJ6CGhb
	XcI9sVkVgsnXFk11xpsKLdoJki3leWq+W9pZ4/Q==
X-Google-Smtp-Source: AGHT+IE//7WmRy4WvbmmnLPRDvsXu2U7k4fZcFYB5c3Vi7xo2dtuIJzgM4INTs+uuefr8FqjZv2loQ==
X-Received: by 2002:a05:620a:4507:b0:7c5:5206:5823 with SMTP id af79cd13be357-7c75bbde5c9mr527101585a.29.1743532023000;
        Tue, 01 Apr 2025 11:27:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f765f94fsm687963385a.20.2025.04.01.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 11:27:02 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:27:00 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com
Subject: Re: [PATCH] DAX: warn when kmem regions are truncated for memory
 block alignment.
Message-ID: <Z-wv9NQr2pE1U8w5@gourry-fedora-PF4VCD3F>
References: <20250321180731.568460-1-gourry@gourry.net>
 <88bce46e-a703-4935-b10e-638e33ea91b3@redhat.com>
 <67ec269dc51da_1d47294c8@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ec269dc51da_1d47294c8@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Apr 01, 2025 at 10:47:09AM -0700, Dan Williams wrote:
> David Hildenbrand wrote:
> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > index e97d47f42ee2e..23a68ff809cdf 100644
> > --- a/drivers/dax/kmem.c
> > +++ b/drivers/dax/kmem.c
> > @@ -67,8 +67,8 @@ static void kmem_put_memory_types(void)
> >   
> >   static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> >   {
> > +       unsigned long total_len = 0, orig_len = 0;
> >          struct device *dev = &dev_dax->dev;
> > -       unsigned long total_len = 0;
> >          struct dax_kmem_data *data;
> >          struct memory_dev_type *mtype;
> >          int i, rc, mapped = 0;
> > @@ -97,6 +97,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> >          for (i = 0; i < dev_dax->nr_range; i++) {
> >                  struct range range;
> >   
> > +               orig_len += range_len(&dev_dax->ranges[i].range);
> >                  rc = dax_kmem_range(dev_dax, i, &range);
> >                  if (rc) {
> >                          dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
> > @@ -109,6 +110,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> >          if (!total_len) {
> >                  dev_warn(dev, "rejecting DAX region without any memory after alignment\n");
> >                  return -EINVAL;
> > +       } else if (total_len != orig_len) {
> > +               dev_warn(dev, "DAX region truncated by %lu bytes due to alignment\n",
> > +                        orig_len - total_len);
> 
> This looks good, I agree with it being a warn because the user has lost
> usable capacity and maybe this eventually pressures platform BIOS to
> avoid causing Linux warnings.
> 
> In terms of making that loss easier for people to report / understand
> how about use string_get_size() to convert raw bytes to power of 10 and
> power of 2 values? I.e.
> 
> "DAX region truncated by X.XX GiB (Y.YY GB) due to alignment."

Will pick this up in v2.
