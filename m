Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BA20DD6E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070329; cv=none; b=f6n0x+Lig00rpkmiNJQ22drh4MCiMFpiByd2eTLXq3MowodiRqEQ4zmJFE+34sztZB2SPzf1pKXwLOYWmxRCODWxiwS0nTFz7+Azl+wMyZnFh5upxmUZfFc4YcKDgVWCHDIkFr9ZhfW67Q/SfcOZ3UGFEtU9KS6hyJW4s4JsWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070329; c=relaxed/simple;
	bh=tYdheaOLJdJc0aJkjKr0mWLYAbDjup5u9/8ud0zYRzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJpQseEWKN16LMUMiNDcgZKnOQmERBRI69SEos7xJAOuQh8pyNK3SEsLbQBf42rFE3kWgy+Xxwlw3gRhbLXrPMZZ8kP9PfbHW3fZh+L4nBaXuLYhd07hEMscn8+YraZIG3yW3pIKAK6O2GAqQRWEVNs8vcVaj5DtYDs8VoG2KqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r63gGWT/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r63gGWT/"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be8efa231aso117417285a.2
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740070327; x=1740675127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkopH+knUrz+qRGQu25YwgeMxQonV40WdBmq0oHoa/M=;
        b=r63gGWT/SFOpTCY0gppD4s1+CTNUf/uM5IWZvstpJewST70YQ/L3ezSpWUo9GudEQV
         noT8vNyG+m8GrqPRRAANIPATBcclm3U6NY1L7P3N1ruLhELfPzVdo/aNhJxjOQbhto+4
         ecGw5nhE/ExC1jcOVeSIhqaJ6s24r3n3rrFcHFGnnpMMlslVuO1h65tBPcrRWtmh7tXQ
         zwJLtsX3QsafJlJbxJVux1NtBoIT83q8sP23U4VDTgjk3sr4qr3wA8J+WrosPJXxFzKi
         yI/yPdmGl36jbjOMZGBAG33OW85U/HQ6BjMmI6htiLwvrPdWRI+vIFm0s3Ff0gHL5aK8
         GWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070327; x=1740675127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkopH+knUrz+qRGQu25YwgeMxQonV40WdBmq0oHoa/M=;
        b=kxoujlvJVVF2Yhv3wLtOTXI3rk7syqVJ3MlOKAn7ELp+5r48RNhpA810VKpRUhCK3v
         b/duwMPbFdT2dng87HKigizRPoBiDEYLsv32QWru9yXlJmaQGDRqBgzbfsf9+Vj1TWis
         1IKQSE8qC92axy0vAdlDUrA4vG96k5JgNXym4/+4bILNndWz+DekGDOVuvUMCmBZxaYL
         K2ZL/ReTTT7zmUN03r2oGLbLrTWy7Wymlw144/HGWwo3agYfF3h1ZIyFqu7wbIu5mHAq
         vIVngtVQlnDr8CrzkAA6CU9tWjAir0YlYYAQhqTsMzWcVLX5PfbGEWRZdF3YEMlUYknt
         uepA==
X-Forwarded-Encrypted: i=1; AJvYcCVPQW7EPaQfh163TvGeWMLZPhEIjdCft5kXZ56Y9ebduazD8N+3/mZAj2Bs0JWuLqrRnUOMdd1cGAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwOfqAG2OqneutmickcChuUYMEywN8QKJ8FT+v+O9ToxGwpuq
	d49cCkqdPtMGlaDbVrBOh0gGmpm11isb02F+S6rUiHqVYIC/6uQzo+2j1VJOZNA=
X-Gm-Gg: ASbGncsj83tp7YPjZTAdKn+4qv8BMxTwsWJJ7FHhWWF9BMqJL4A4n1GjZXvpmlacD4/
	y+RWxMCcLYVV616q96F3eIGzImehWzIFA3fCkyuxI0gNyWP554BFflcaq2ZWLkOcsmLedk5yklK
	sOgDW7bEEHqa4pBos6E8HcOuXs2WhL6HvsYesrNd3Bg+VvM3lWuZ9U2uOnJxnE6X9o63lMh41TV
	zizbmR4N/IO0rJT9hwvZCdo7zUFEt+d1dzNT7Jw+bsXXKjCkLb2zTeLIORZegnDCEpoYEjvBSV3
	N9VzBA+/pQEeYmCzgXy3Eq052l7IHK3wEBQJ18AygUtp/Q4hY6YKGN1LvI1i6rATur14DBCzuQ=
	=
X-Google-Smtp-Source: AGHT+IGrbP+VpZmpnhWBu0RWPNsSrk995l/NeBFAzZWBe3mWGjHaZI5IiPF3bd9fa2T2Eki2fBv33Q==
X-Received: by 2002:a05:620a:4054:b0:7c0:b220:34f9 with SMTP id af79cd13be357-7c0b2203898mr1475385785a.36.1740070327005;
        Thu, 20 Feb 2025 08:52:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09619fbfesm542181485a.18.2025.02.20.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:52:06 -0800 (PST)
Date: Thu, 20 Feb 2025 11:52:05 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z7ddtZBHx28_HIPR@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
 <20250220163043.000000cd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220163043.000000cd@huawei.com>

On Thu, Feb 20, 2025 at 04:30:43PM +0000, Jonathan Cameron wrote:
> 
> > 
> > Example CEDT Entries (truncated) 
> >          Subtable Type : 00 [CXL Host Bridge Structure]
> >               Reserved : 00
> >                 Length : 0020
> > Associated host bridge : 00000005
> > 
> >          Subtable Type : 01 [CXL Fixed Memory Window Structure]
> >               Reserved : 00
> >                 Length : 002C
> >               Reserved : 00000000
> >    Window base address : 000000C050000000
> >            Window size : 0000003CA0000000
> > 
> > If this memory is NOT marked "Special Purpose" by BIOS (next section),
> 
> Specific purpose.  You don't want to know how long that term took to
> agree on...
>

Oh man how'd i muck that up.  Thanks for the correction.

I suppose I can/should re-issue all of these with corrections
accordingly.  Maybe even convert this into a documentation somewhere

:sweat:

> > you should find a matching entry EFI Memory Map and /proc/iomem
> > 
> > BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] usable
> 
> Trivial but that's not the EFI memory map, that's the e820.
> On some architectures this really will be coming from the EFI memory map.
> 

You're right, though on my system they're equivalent, just plucked the
wrong thing out of dmesg.  Will correct.

~Gregory
