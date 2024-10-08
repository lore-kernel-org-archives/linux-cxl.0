Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157252139B6
	for <linux-cxl@vger.kernel.org>; Tue,  8 Oct 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416724; cv=none; b=aacOx3Gves6SD9xVpHP3jb6FOzcQ+Nt3l0p7kzy+07hid5Th6PYUVAmSd1GPQRTXmYCM9rh/YQgNWkUq+gMoFAqIywB+qba9Gkpnsh4m2gqOOPFwdylD1M0kPFHEfWj972CcqztPtOh05nfUAgJfnOcTEg46vuGXiql1MX+gns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416724; c=relaxed/simple;
	bh=ASdWfVJPzlxahRt/zRGst+ZQIgxfx9y3/wjpoGFPtyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DufTuuaVinvlFdWUm2KechUaDrHb0wk89hnUTNGvOYTMij+S/IwjXDYa6dCeX3eoHA7stXZpoRyAdV8znADPe1fsM5X/JjTrR2hh6A4lcYwCtZXYZE3Le5R0ZcwV6XJlnY4OiNpi+/eNiAgX8ys57Mhc4i6XZMH6NSEP8tcXcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tKWegZ3X; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tKWegZ3X"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9ab721058so14891485a.1
        for <linux-cxl@vger.kernel.org>; Tue, 08 Oct 2024 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728416722; x=1729021522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyOFo3K+fAZ65UEhLUHR8F6Og9mXsgjDoyxIBEdD5YY=;
        b=tKWegZ3XdENW6VtKxQUIdyNpGj22XPGIhYVMlr/i8bpB+zjWQAxkfm+VwdXLyUkzpV
         SHOxKzPC43Vo08dfjJeSVwv/1HhjND+GbrLBsQr3mi9AWbi7hxAEBaEM5+aw9Lxb8hY4
         LrypzevC+sqHFxCzQPAM5vvBgwPsD6++LQgnEsOlBD9yuw/8nAAtjKR7uEFWT+vWlzfB
         VKvdyZ4am8h3Z8keofW7Rt4XWH5wFL4yoCOT06roKQktGQcBUBRJ9Kc8pJEQcy8v59Ej
         amIQ6Qmy2k/Mgl85qTnVatMgv6WgbHkIaawyYMEoM2t+ww0kLPld8pb9VryZaslYslBi
         KPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416722; x=1729021522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyOFo3K+fAZ65UEhLUHR8F6Og9mXsgjDoyxIBEdD5YY=;
        b=s8KAMjvLp9zXNRMWoFMIqggSoEAUpmblR9mDml7FJElUpNRat+U6ZRN5ZyGiSF2NYJ
         2pvHEKyqklWGdmsU3yA9JxYcprfA4aW5ULqRo9JCVUMnCFShyBkuIg2z7o8zZaIvFiqQ
         qYf2lSmQZJ9/hbfP5s/xU1QeNJPjBwVncXyNKzqH3BJza9+K/yaWgV6deg/0c6PL+vKT
         dfMBE9yW0S9DzypHfJNS5Bc9to7TcgT0p9YyBmFF44uTDCAp0vDsO18qCvCX8Yk60djO
         mntLwNHJzF1vevHEoVGNIka3h0sNpWkQM56NazZtjZUzX/UuBRZoqij9HmbI1sagtAO6
         acSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOhTao8egWPlWHm5q+mq6M24MVFowmQ0E83Id2TEE1LtVINBPguJp/fStqHnOcw6WBNazwVBY28uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgR833/WKpLX9OZW5lHdn5UE109NEDeC2ZJeB0ZJ1qSxVZ8pAx
	H6tP/Pl/kdz7XnCFIBvwXOgc8Zj0MnTIXScR5DIshbaxQeSWvIW4pgRp12SEvok=
X-Google-Smtp-Source: AGHT+IH6XWnL5kwtHfTkxIDRb5j2x0rPOC89uj1NPmyIh5ioBCIwJgkV9Nl3E7AGtUXJH2g6+ElCWA==
X-Received: by 2002:a05:620a:2415:b0:7a9:9f44:3f8 with SMTP id af79cd13be357-7affaf938demr42461885a.5.1728416721987;
        Tue, 08 Oct 2024 12:45:21 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afcea7f657sm41246785a.0.2024.10.08.12.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 12:45:21 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:45:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-cxl@vger.kernel.org,
	x86@kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, terry.bowman@amd.com, lenb@kernel.org,
	dave.jiang@intel.com
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
Message-ID: <ZwWLyOkQ8kfAoZjg@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
 <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
 <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
 <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
 <670582254a5db_2e172294fe@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670582254a5db_2e172294fe@iweiny-mobl.notmuch>

On Tue, Oct 08, 2024 at 02:04:05PM -0500, Ira Weiny wrote:
> Gregory Price wrote:
> > On Tue, Oct 08, 2024 at 05:02:33PM +0200, David Hildenbrand wrote:
> > > On 08.10.24 16:51, Gregory Price wrote:
> > > > > > +int __weak set_memory_block_size_order(unsigned int order)
> > > > > > +{
> > > > > > +	return -ENODEV;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
> > > > > 
> > > > > I can understand what you are trying to achieve, but letting arbitrary
> > > > > modules mess with this sounds like a bad idea.
> > > > > 
> > > > 
> > > > I suppose the alternative is trying to scan the CEDT from inside each
> > > > machine, rather than the ACPI driver?  Seems less maintainable.
> > > > 
> > > > I don't entirely disagree with your comment.  I hummed and hawwed over
> > > > externing this - hence the warning in the x86 machine.
> > > > 
> > > > Open to better answers.
> > > 
> > > Maybe an interface to add more restrictions on the maximum size might be
> > > better (instead of setting the size/order, you would impose another upper
> > > limit).
> > 
> > That is effectively what set_memory_block_size_order is, though.  Once
> > blocks are exposed to the allocators, its no longer safe to change the
> > size (in part because it was built assuming it wouldn't change, but I
> > imagine there are other dragons waiting in the shadows to bite me).
> 
> Yea I think this is along the idea I had.  But much clearer.
> 
> Ira
> 

Dan seems to think I can just extern without EXPORT, so let me see if I can
get that working first.  Then I'll see if I can add a lock bit.

I'll see if i can make an arch_advise call that does away with some of the
ifdef spaghetti.

> > 
> > So this would basically amount to a lock-bit being set in the architecture,
> > beyond which block size can no longer be changed and a big ol' splat
> > can be generated that says "NO TOUCH".
> > 
> > > Just imagine having various users of such an interface ..
> > 
> > I don't wanna D:
> > 
> > > 
> > > -- 
> > > Cheers,
> > > 
> > > David / dhildenb
> > > 
> 
> 
