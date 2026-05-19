Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136364A138F
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190904; cv=none; b=tgV9a3VqBg96p3xtMwMWG8L1hPfB3QkhpkzqdyOtqW9d3A7UKKZcvSDAW1FFWXYREXASiahujZb7nFEURETOCz5dqXz0CG7C1vxyJOESIXWX1wTJZM6OSRtPVIowo5y2nm7MiZA4T2g8A/DX+FSf5Zb+ZT3j1CNX3ztvm/VXfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190904; c=relaxed/simple;
	bh=r6TRHI7QGDIZULFYxTQmWSUe2xBfipM8S7JpVimwiJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYaHj+6TiAHYltMUIn4ru9bjA+ExymIacC0WYvfWdM514zFA47RYl12lms7BBn1flhEp3wPhyzVhAQPKa1lLUgQeNR4sd6cuRbDDea7vK6BuJzL+/+Jn0JVW3irwRHuGboHSLdN61AZMn6wwijPoSHqhiEsqq2lBnil9Z/0EryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKu/7V8C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKu/7V8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3272FC2BCC7;
	Tue, 19 May 2026 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779190903;
	bh=r6TRHI7QGDIZULFYxTQmWSUe2xBfipM8S7JpVimwiJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GKu/7V8ChrTCftl21HGiZ6nVjt3RLq8K6hSwGJqOD+hisdqSYmpSVgirppOe0OSqu
	 c74r3rwtmxFqQa5rHKnTyYK1N5vP41f5OQ+AtRE7fM41ydY9o5ODrXipwKRzcgfSv+
	 OQRiMmUAnPHE2h4RBFQcyZsa09M1kykQPMLTENocTNt4+TWqDjVQhyqjkvuHg1pzLr
	 AtOhbZoudRrHZbiMN17ey2k4GBuMpJ6X2pYKXZb8Tvdp6Dx70iNkjvqxyJ6gz/8xDg
	 wEXKLP3r3Txu2SR+VzbeDoXFcVm78GSbW+3Xo2LPbgJPROmzzxlcxeK0W4O0u2F2Lz
	 w/KieEHQURYZw==
Date: Tue, 19 May 2026 12:41:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, alison.schofield@intel.com,
 ira.weiny@intel.com, gourry@gourry.net, dongjoo.seo1@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/5] cxl: Support Back-Invalidate
Message-ID: <20260519124133.1f2bd813@jic23-huawei>
In-Reply-To: <6a0bc26656f_128d711001f@djbw-dev.notmuch>
References: <20260516022037.1761453-1-dave@stgolabs.net>
	<6a0bc26656f_128d711001f@djbw-dev.notmuch>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 18:52:38 -0700
"Dan Williams (nvidia)" <djbw@kernel.org> wrote:

> Davidlohr Bueso wrote:
> > Hello,  
> 
> Hi Davidlohr,
> 
> > The idea is for Type 3 memdevs and future Type 2 devices to make use
> > of cxlds->bi when committing HDM decoders, such that different device
> > coherence models can be differentiated as:  
> [..]
> > o Patch 4 adds ABI (sysfs) for HDM-DB region creation.  
> 
> I am skeptical about needing new region creation uapi for this. A
> question from the example below:
> 
> [..]
> > Testing has been done with the qemu HDM-DB Type 3 counterpart (now
> > merged).  
> [..]
> > 2. On a Type 3 HDM-DB volatile device, create one BI and one regular region.
> > ---------------------------------------------------------------------------  
> [..]
> > # echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_bi_region  
> [..]
> > # echo region1 > /sys/bus/cxl/devices/decoder0.0/create_ram_region  
> 
> ...how can a single root decoder support mixed operation?
> 
> The root decoder restrictions specify the endpoint decoder requirements.
> There is no flexibility to entertain beyond picking the root decoder
> resource, right? Linux can avoid all the configuration corner cases by
> making the endpoint decoder inherit settings by topology configuration.
> 
Hi Dan,

Assuming I understand the question correctly...

No idea if anyone has done it but as far as I can tell you 'could' easily
enough have a single fixed memory window that supports both BI and non BI,
the host implementation would just have to use the programming of the
decoders in the host bridges to figure out what it needs to support.

I'm not aware of anything in the spec that says you can't implement that.
Now maybe it's a non thing but if it turns up later we need to be careful
not to wall ourselves into a corner from ABI point of view.

Usual reasoning of HPA space being a fairly costly / limited resource
would be the reason to build this more complex hardware.

Jonathan


