Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBFA1369B4
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199095; cv=none; b=utS8W3Vvae/hUnez8QEZuGzlhllplxJ4TduksFfjvozoHq6aifdd2hDpoRLdHl2r7eaRJe59zmNu1ZfVeI+CQfoTWZl4/ED+ByJ2o8vxfWBq7TE9kCYiLRl0B99lfMP5HRxYq5/i9vsOv+q5fc4lAHD15BGt7iWcH/spbK0pAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199095; c=relaxed/simple;
	bh=m1hoQwFKVZP7RgcYrHC1tVHYQpIu5uaXakPcxtp7zSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+lCe+XbhxFlLq6puM+2QDbEaPjFgNE2ogPCxio6A3kQhwvPQsQ9svPcDwlpWmB5BWqT21iTnAgFmBiIKRqSgntyKdkgB02sjNXnz1kMjS2AdJ/EgkoVolLWt02nOmGa2XMv4V3q5HBPdGLlMpjqp5BUMpaUEb89hN0qFPOiz3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XonArbGk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XonArbGk"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4608e389407so10309481cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 06:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732199092; x=1732803892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXhLVbl4qQpLa0iW3juzrX62f3Q2NQ3mbmEindnM0Eg=;
        b=XonArbGksyewvJLnRzG9/31sBWkxhrXHaemksJrlGwpmEpqU1+fIMGqwTaO/tGwd5g
         tO+GieIVDYP7+v+w6VC+9It5hY1+FxFBd2VsytxSb1y/kkUY9nysNoFB/1iTOEJA1M/b
         Dd0imxashCd8F9/Qt9nuJIMzELcTQsLBIj/Oz/E0cCQMBrMiS/dtLSsKBZG1Aptxzj1F
         OABkq6UsKFKhDKffAqFwH9yz9uQAwW/jtvQV7BeeKp2YDYJtS+r7bNb7IelVQDjlXqpU
         gF3vDw/tzsmqyiD4WrPA+1E5BpIxbQnQZiEUlmbmgiggF5bXv2eXuy/jX1IIaRFVQ+OY
         QGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732199092; x=1732803892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXhLVbl4qQpLa0iW3juzrX62f3Q2NQ3mbmEindnM0Eg=;
        b=cIhdoFzKSVCpX1SJ7TvZ7BtnNG6RGco9UGYeowPyyhPjWLXcK83NthzFA9YRVD1QYB
         UuCJVmFhO6KmaO1tHnq+P5lvF8MhuFgPpoK3TQVrJU6I5XpRaK5M8eNPzEVaJhr3g+0f
         o1qWEKqKwKkXoXR4cA506p+Uk7JrAaQQ4tpmfne1pnXKTRFsnBjSFrYSiJS23me6n/Sl
         UtvisURY+gH4wiQmaj+FBToGl0sDaVI+zE9F1nXGya1W5wmoymD426rXzbErZb5LZvG5
         D8qn5vKb8vLC9OjrVtDbBqL/nmgWWeuxloQos6jKwQpH+zuJzbSgn4dkRwy0ntsvN7SK
         yVvQ==
X-Gm-Message-State: AOJu0Yzhj71r5S2VzQSKU2WsZqZOddrV2FuXGdcs6FUv8zsOLjhMzpOE
	C1M0+VnKDyL3PSx2oCH1PNaP/VfcBxOe9VYmLnV81jLv9RVI0JbPWct7vjkhrpE=
X-Gm-Gg: ASbGncuxSWhu3TioVIOF3PC6qgKs8++Z7XriyEqtYUc3WWSS8g5D8F9WXYaHR5js4wV
	Fb9Y4nIL8PauDJK5oBC1QFbMcpcEbVuIV+drGQdVNHILBsTlPqL0MdUtmdgnhxgQSXsvX5CaI4z
	ye1CwuWncYQ0GGfVrZP6vaemt9kSRderJHphibiqLv82RInaJuJl6POWsFku24c2m5q/8EBG9PH
	nBixQceyRt9uo2Wd8w1KVBbkSP0fxxUnsadWSz1zFzXZgwV/9UF1GooJsL7bpUiknuZyLeGz2Af
	DVusoNdnWjtPweX4s+leKMWpzBw5266Igck=
X-Google-Smtp-Source: AGHT+IHRE8aJtExvgniPZRQd10YOsYz8M+WHKPcQyReVFHmfTMTy/svK7inl9phFxt9maInO03X2sw==
X-Received: by 2002:a05:622a:1b06:b0:463:4bb6:bfe2 with SMTP id d75a77b69052e-46479e23879mr95866461cf.50.1732199092344;
        Thu, 21 Nov 2024 06:24:52 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-464685cee50sm22755671cf.30.2024.11.21.06.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:24:51 -0800 (PST)
Date: Thu, 21 Nov 2024 09:24:43 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, tongtiangen@huawei.com,
	Yicong Yang <yangyicong@huawei.com>,
	Niyas Sait <niyas.sait@huawei.com>, ajayjoshi@micron.com,
	Vandana Salve <vsalve@micron.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf driver
Message-ID: <Zz9Cq4CPStYGZyt7@PC2K9PVX.TheFacebook.com>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>

On Thu, Nov 21, 2024 at 10:18:41AM +0000, Jonathan Cameron wrote:
> The CXL specification release 3.2 is now available under a click through at
> https://computeexpresslink.org/cxl-specification/ and it brings new
> shiny toys.
> 
> RFC reason
> - Whilst trace capture with a particular configuration is potentially useful
>   the intent is that CXL HMU units will be used to drive various forms of
>   hotpage migration for memory tiering setups. This driver doesn't do this
>   (yet), but rather provides data capture etc for experimentation and
>   for working out how to mostly put the allocations in the right place to
>   start with by tuning applications.
> 
> CXL r3.2 introduces a CXL Hotness Monitoring Unit definition. The intent
> of this is to provide a way to establish which units of memory (typically
> pages or larger) in CXL attached memory are hot. The implementation details
> and algorithm are all implementation defined. The specification simply
> describes the 'interface' which takes the form of ring buffer of hotness
> records in a PCI BAR and defined capability, configuration and status
> registers.
> 
> The hardware may have constraints on what it can track, granularity etc
> and on how accurately it tracks (e.g. counter exhaustion, inaccurate
> trackers). Some of these constraints are discoverable from the hardware
> registers, others such as loss of accuracy have no universally accepted
> measures as they are typically access pattern dependent. Sadly it is
> very unlikely any hardware will implement a truly precise tracker given
> the large resource requirements for tracking at a useful granularity.
> 
> There are two fundamental operation modes:
> 
> * Epoch based. Counters are checked after a period of time (Epoch) and
>   if over a threshold added to the hotlist.
> * Always on. Counters run until a threshold is reached, after that the
>   hot unit is added to the hotlist and the counter released.
> 
> Counting can be filtered on:
> 
> * Region of CXL DPA space (256MiB per bit in a bitmap).
> * Type of access - Trusted and non trusted or non trusted only, R/W/RW
> 
> Sampling can be modified by:
> 
> * Downsampling including potentially randomized downsampling.
> 
> The driver presented here is intended to be useful in its own right but
> also to act as the first step of a possible path towards hotness monitoring
> based hot page migration. Those steps might look like.
> 
> 1. Gather data - drivers provide telemetry like solutions to get that
>    data. May be enhanced, for example in this driver by providing the
>    HPA address rather than DPA Unit Address. Userspace can access enough
>    information to do this so maybe not.
> 2. Userspace algorithm development, possibly combined with userspace
>    triggered migration by PA. Working out how to use different levels
>    of constrained hardware resources will be challenging.

FWIW this is what i was thinking about for this extension:

https://lore.kernel.org/all/20240319172609.332900-1-gregory.price@memverge.com/

At least for testing CHMU stuff. So if anyone is poking at testing such
things, they can feel free to use that for prototyping. However, I think
there is general discomfort around userspace handling HPA/DPA.

So it might look more like

echo nr_pages > /sys/.../tiering/nodeN/promote_pages

rather than handling the raw data from the CHMU to make decisions.


> 3. Move those algorithms in kernel. Will require generalization across
>    different hotpage trackers etc.
> 

In a longer discussion with Dan, we considered something a little more
abstract - like a system that monitors bandwidth and memory access stalls
and decide to promote X pages from Y device.  This carries a pretty tall
generalization cost, but it's pretty exciting to say the least.

Definitely worth a discussion for later.

>
> So far this driver just gives access to the raw data. I will probably kick
> of a longer discussion on how to do adaptive sampling needed to actually
> use these units for tiering etc, sometime soon (if no one one else beats
> me too it).  There is a follow up topic of how to virtualize this stuff
> for memory stranding cases (VM gets a fixed mixture of fast and slow
> memory and should do it's own tiering).
>

Without having looked at the patches yet, I would presume this interface
is at least gated to admin/root? (raw data is physical address info)

~Gregory
