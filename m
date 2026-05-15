Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C52372683
	for <linux-cxl@vger.kernel.org>; Fri, 15 May 2026 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809355; cv=none; b=MQAS3Mtgr4/9909qbWSYDQ5yrbw1QCyrSlZxJgNon1pYgZyKwTGttYGBALErdqEFvlQPdrhAxv1rbnEsXtugJ9VX7B9xWBXJY4x2itZhnMKfKo3uQzvulQK7f50kqGoiXHCJcW0rrlz+FQ0OVRxctbkbRshxG/e3mL2HMmIcCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809355; c=relaxed/simple;
	bh=inmRgiGS8ZD1KYugC37BVH8SgBSK5g+KElu0rJmWPps=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PUwWSyE+MwFe5hdfn33B9kdTZ7QmPQjRyeN0FWs2WXHfZvHxOrqCgywaxuFerxuYNgJtukIJbe92VWwPgIUM/cHfsk3LtFcLiDFcDsZDpKAKiXBqpW3V+dMQC9TGl2c7Nhbhrl8brQ+/RTx8/Ye57MnZxW+gY+nHZDdz87lt1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYgvWavE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYgvWavE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4273C2BCB3;
	Fri, 15 May 2026 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809355;
	bh=inmRgiGS8ZD1KYugC37BVH8SgBSK5g+KElu0rJmWPps=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=PYgvWavE/x49TkVKOb6PGGCUA/s3IRgfChkBTsVD/TfvRgSjmz7Z+CGMCjGjoPeNi
	 6XzhWhhQ7WaVgvvi26mHef6QbVJwvSghEUBaU+9JJeQ0caGrepuxZ27sgeTwfmoO8B
	 Fy0EpJ+AHXULigPfqssQ9iyYXzGtMXtJv1LbpVCm/IEfc76nxfD1pNO1zPaYpCB03d
	 jJsNF9OITt9RFf0iynD9vKfsuomia+UtsUQ8y0GquCOlkcccPxHNpvir4KjlsgKkxa
	 yTa0IuecVXrhvLKA6sTmVen+b7xO72CTKeuejfQ7vNe358ux8aNP0vpblCNQJl87C1
	 0Gs5IzE4OGXMw==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 184E1F40068;
	Thu, 14 May 2026 21:42:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 14 May 2026 21:42:34 -0400
X-ME-Sender: <xms:CnoGakUALf9H6WuAC1zmwA6QUtzURrPv83W6iRqDuiwmwdsSRHIdxw>
    <xme:CnoGalICz6GM_B5TdhvkAmBY3kI3GQI9Aad3m9_TOiwHwhexHree4O3RjGhx0kOEO
    CG2MqCD8Hqw9yAut4gn7N4gEeb1uClUr1_L-2SCBbx3IlV-whR5LLdy>
X-ME-Received: <xmr:CnoGas3hd5QxXolTnzUUJ-YlhW5Xh3GLFf8RQIkJYuWvEMwCxlV31m5dzPmNZO0mOSV8-dHyEX7OBpSANmSJ7OwAxXB3zZZ6Uhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvkfgjfhfugggtgfesthejredttd
    dtjeenucfhrhhomhepfdffrghnucghihhllhhirghmshculdhnvhhiughirgdmfdcuoegu
    jhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeejvdelueffffdvhe
    dvgeeltddtteefuefgvdeuudegudegfeeivddvudelfeehhfenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhprghuth
    hhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqdgujhgs
    fieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghluhgtvghrohhpsegr
    mhgurdgtohhmpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrlhgvjhgrnhgurhhordhluhgtvghrohdqphgrlhgruhesrghmugdrtghomhdprhgt
    phhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvggufigrrhgurdgtrhgvvgesrghmugdrtghomhdprhgtphhtthhopegurghvvghm
    segurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:CnoGaqJTWgsr9tSskgtcvpoRTUDszXnZsfxHEICFCNAprwkpOLKwQg>
    <xmx:CnoGavj_Du6kdrHWeWEbBsPrru261UCvxqQ4zLUeohn-7_RMysRJaQ>
    <xmx:CnoGaiBE_rf7OL5jakrAseJvJRPakF2EpOtTULHt89JWrC0y9jjDYg>
    <xmx:CnoGap4quOn2EGWkHeFP3ysWd1JFFDjKAvimZ39ARQjrOW00XP0Iow>
    <xmx:CnoGavEpzgnSIz1yDWbBKHi__9eFkXbSFkYSbm_8CvAL4BOzFmZPxhTI>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 21:42:33 -0400 (EDT)
Date: Thu, 14 May 2026 18:42:32 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Message-ID: <6a067a087ed90_a617410062@djbw-dev.notmuch>
In-Reply-To: <9aaf07a6-ffc9-4474-835c-bbc6ddf84472@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
 <69f409325f7c0_3291a910046@djbw-dev.notmuch>
 <b5110c3e-c5ee-4305-b307-704837fe4f9c@amd.com>
 <69f54967edd72_3291a9100c3@djbw-dev.notmuch>
 <9aaf07a6-ffc9-4474-835c-bbc6ddf84472@amd.com>
Subject: Re: [PATCH v26 6/8] cxl: attach region to an accelerator/type2 memdev
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alejandro Lucero Palau wrote:
> 
> On 5/2/26 01:46, Dan Williams (nvidia) wrote:
> > Alejandro Lucero Palau wrote:
> > [..]
> >>>> +	}
> >>> A couple problems here.
> >>>
> >>> 1/ Nothing stops a CXL class device from implementing a decoder with
> >>>      CXL_DECODER_DEVMEM (HDM-DB).
> >> Uhmmm...
> > Consider a helpful expander that does not require the host OS to use
> > cpu_cache_invalidate_memregion() whenever DPA space is changed. I
> > imagine that would be useful for DCD where there could be a higher
> > frequency of extent changes.
> 
> 
> What do you want here then? We had a param for specifically asking for 
> creating a dax device for the region, but it was considered unnecessary, 
> and I think it was you then. Should I put it back?

This comment was referring to the proposal to change the way region's
are released based on their decoder type. My point is that the way
region's are released must not depend on details like that.

Now, it took me longer than I wanted but I have a generic solution now
in hand, will post, that allows regions to be safely deleted either by
an endpoint callback or the root. It also addresses the issue Sungwoo
posted. There is still a tiny theoretical race if you are able to time
region deletion with devres_release_all(), but the practical /
repeatable devm_release_action() warning and double unregister bug is
gone.

> >>>> +	/* hold endpoint lock to setup autoremove of the region */
> >>>> +	guard(device)(&endpoint->dev);
> >>> This does not handle the case when ->endpoint is an ERR_PTR() because
> >>> the memdev never attached in the first instance.
> >> Not sure about this but, is it not the success of devm_cxl_add_memdev()
> >> ensuring this can not happen?
> > That is only ensured by using the "attach" mechanism.
> > devm_cxl_add_memdev(..., NULL) is only for the generic memory expander
> > case. Where the entire usage model is governed by memdev ABIs.
> >
> 
> Is your concern that the memdev probe could not happen synchronously so 
> a further call like the one implemented here could fail due to the 
> endpoint not there yet?

The concern is dropping and retaking locks which exposes some lifetime
details. I have a patch that introduces a devm_cxl_probe_mem() call,
that hides all the attachment details. It is functionally equivalent to
a standalone helper. I like that part of your proposal.

[..snip detach discussion, my proposal is leave out custom detach
complication for now..]

> > All drivers must already be prepared to be unloaded. So we start with
> > the simple semantic first to get this functionality landed and then
> > think about adding sophistication like live fallback to PCI operation.
> 
> 
> Ok. Let's try this one. You want to trigger device_release_driver or 
> something similar on the pci_dev->dev linked to the memdev. Right?
> 
> Do we have this support now?

Yes, cxl_test tests it for a long time with the existing type3 device,
and I tested it now again with Dave's type2 cxl_test device and the
proposed devm_cxl_probe_mem(). Thanks, Dave!

> If we do not, have you evaluated the complexity required for ensuring
> no deadlocks if this is triggered while the sfc driver is still
> probing?

The cxl_core invokes device_release_driver() from its own workqueue
context.

> Maybe I'm overthinking this option, so if you have a clear idea about 
> how to do this, please tell me, assuming it is a matter of calling such 
> a pci_dev "unbinding" from its current driver.

I do not blame you, especially with all the details getting generic
region teardown working. However, it is working and minimizes the
exported complexity outside the core.
