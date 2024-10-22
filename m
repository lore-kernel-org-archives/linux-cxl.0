Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9A19E96A
	for <linux-cxl@vger.kernel.org>; Tue, 22 Oct 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606320; cv=none; b=ODkbtOlkzgyUvj6ie6baC9f3yyP9Uaza7O440wRkH7F7rHo385Hd/ArNK414GjL8gutOF1phKC/Vkzkffku6U3WrP5wT10/2Rl0vgTjtj1mRclZb4y6JGHlHiY1vT9UFxB16MOGSIApHnuGX9wLg+4UpJpf+Oev7Ss2CiRNKahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606320; c=relaxed/simple;
	bh=BFTMl93wn0yvR1WfKRCvWyDSqDubERJmJh1AZ0eZ+zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A32bQNjTN3B4vouHQH9RTkGnoFQM34+Cg710jdwo991a80GmyUKz7TJr9etjk0I/a+KEeSE4eDtMgaWXKYQKUTQdEkfusbiy/IpTHDSQTOHZNjOOwdgfWuLX7/89ZEBBu+SPZuKFiFGMjMpGiW7e4BSSOXzWB4rp6lyD6qQcyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aWhp5l2A; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aWhp5l2A"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb97afcec9so38149946d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 22 Oct 2024 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729606317; x=1730211117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qhll7IfNOfUrslv0JS+DDYY0+c54jassaWQ2ezcVZM=;
        b=aWhp5l2ABHwKl3fpb/KlZB9XATAe1Yn3TBCtAyozFp6/H6OxOodN2Zk7QogFZbRLZ1
         KIS7XPkeYhiXtL2bMOt/Ei5MVFn/lpJcCVQVKkey2Ze3VLVHU4vd2TxY+dl2vWdb4Rmu
         VzARJXJSa+TTWM2ppLAdNB8wJDYUTSFbt+ht/pfOEjxRTzj+qPUXuwkcqFmx68+F2cgA
         uvdx0r8eujWFkV8Xel/cC7rA7BxGWVDs2GuenkbfldW5h677CmIqZFoSvfSUC/mhLsHE
         Nfh+3w/9MPjCKlo9xMlMAI7uEGit81y8kc12iK3QW48bp7DsUc11VrhgQkqzeFWV5bS1
         9RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606317; x=1730211117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qhll7IfNOfUrslv0JS+DDYY0+c54jassaWQ2ezcVZM=;
        b=w6BiNd5EXIl+GdAiC/ERjnHKSN2Yes3OFFmEtDSdS/fIt03IbHlEMskQ4EKQkEXYy5
         ZpwfLs0rVBo1cHT7lLONRn5G+wFg0Oj7XqmafoEhqI3pxz2dw6XaMccwe/1DZYNpdnft
         5xUfe0sAgvBh2c6b0r03m7UmG9y7ap0JVT7IF1XCsvnx71bQJ5NqaoTKVagAJhaSXoLU
         YBfnegT1VS9dCmqDbNMgMXIwLBWhBPybPYJAW0JPKkHBcU5D34iBD8PWVZDzY0Z+h+iz
         74xWkaEO/UaKyhu/qw2uNpP1rEpgjM0hCev1Iui5UCht+mDUp+1eh8mFKjYzcOojVW30
         gfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKHICUvfKjGOn1eBx02hJ2uRPBqaqnXCNuN7SI9kCDfsHGu07AoxM5DmtBpuyRZHDrjkN8IpLCuzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1f9ELajwN5LCqQXCX6TE1CvM5f0EEFkMKrnYWmmKZvym8H9Z6
	dRdynfXNx/6QfLYpgdyDlMIg09i4Gho0fJ/nRW0kefnvuDpBO+fm2SW0pWsqhpQ=
X-Google-Smtp-Source: AGHT+IHbw1D8MQDNK0PT64hixmIdaE3j5oH9Y2hxuMJ4+N0WrOEaNeUQS0eLymZXwzrOWOPN26VX2Q==
X-Received: by 2002:a05:6214:440b:b0:6cc:2cc0:ccda with SMTP id 6a1803df08f44-6cde11459a2mr205071776d6.0.1729606317290;
        Tue, 22 Oct 2024 07:11:57 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e4470sm29298036d6.125.2024.10.22.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:11:56 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:11:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: John Groves <John@groves.net>, David Hildenbrand <david@redhat.com>,
	linux-mm <linux-mm@kvack.org>,
	linux-cxl <linux-cxl@vger.kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	virtualization <virtualization@lists.linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	qemu-devel <qemu-devel@nongnu.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Linuxarm <linuxarm@huawei.com>,
	"Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
	John Groves <jgroves@micron.com>, Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	=?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <ZxeyrvjaN3peNXhr@PC2K9PVX.TheFacebook.com>
References: <20240815172223.00001ca7@Huawei.com>
 <sjz2xzwkgkq6bun5lssqbsimbggczarotpjdhcsq3itoq5h7jc@x5ormqciwofo>
 <20240819164024.00005a0a@Huawei.com>
 <A4E80580-437F-46D8-A58B-D2F3851D67BD>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4E80580-437F-46D8-A58B-D2F3851D67BD>

On Tue, Sep 17, 2024 at 07:37:21PM +0000, Jonathan Cameron wrote:
> > * Said mechanism should not be explicitly CXL-specific.
> 
> Somewhat agreed, but I don't want to invent a new spec just to avoid explicit
> ties to CXL. I'm not against using CXL to present HBM / ACPI Specific Purpose
> memory for example to a VM. It will trivially work if that is what a user
> wants to do and also illustrates that this stuff doesn't necessarily just
> apply to capacity on a memory pool - it might just be 'weird' memory on the host.
> 

I suspect if you took all the DCD components of the current CXL device
and repackaged it into a device called "DefinitelyNotACXLDCDDevice", that
the CXL device inherited, this whole discussion goes away.

Patches welcome? :]

> > * Finding a tagged capacity devdax device in a VM should work the same as it
> >   does running on bare metal.
> 
> Absolutely - that's a requirement.
> 
> > * The file-backed (and devdax-backed) devdax abstraction is needed in qemu.
> 
> Maybe. I'm not convinced the abstraction is needed at that particular level.
> 
> > * Beyond that, I'm not yet sure what the lookup mechanism should be. Extra
> >   points for being easy to implement in both physical and virtual systems.
> 
> For physical systems we aren't going to get agreement :(  For the systems
> I have visibility of there will be some diversity in hardware, but the
> presentation to userspace and up consistency should be doable.
> 
> Jonathan
> 
> >
> > Thanks for teeing this up!
> > John
> >
> >
> > [1] https://github.com/cxl-micron-reskit/famfs/blob/master/README.md
> >
> 
> 
