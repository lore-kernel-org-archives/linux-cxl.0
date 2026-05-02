Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AA40DFA0
	for <linux-cxl@vger.kernel.org>; Sat,  2 May 2026 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777682795; cv=none; b=L9nebjxJoK0bglKZqt2jMEaJZe5sLjRVispUGlqp9qvtSrpX5uBILN1Dy56l+HktBkGl+EZPIcInRsxDUloFsmCNozsl1WGMft1o+0DFQhEikUyNc8KUfgc/EiEU4pcr/QA9yFBn6huk28iaZ8eYTog2GwPTzlKYMQLx/JrCtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777682795; c=relaxed/simple;
	bh=XTGflNX+Q2aPS2DfKrLc/p0uoaXIOkmiEjOTKw1RbaI=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oWb69YrAtmzVlxeWnrdnsTG306D0ZCUVv0J8kzWIVesjpmLuGxDr+EdZAPaATUH3twiBPdQmYc5d5lL0Sxa4Lhf+0Xgd+w6W/87gZNA5ykjdO7z0krJrKUd7StK4Q6SjcHyV5Y4ICgIikFuL/hEe1p0GQAyfpkvxGsnYI5Zv1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7JXXict; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7JXXict"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F21C2BCB4;
	Sat,  2 May 2026 00:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777682794;
	bh=XTGflNX+Q2aPS2DfKrLc/p0uoaXIOkmiEjOTKw1RbaI=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=Q7JXXictQBhxCWn158/ZJdF1UOn89unsN0/BHywntWXydVS3LOtCELX1bbVSdq3Bh
	 6c5/p8/oocDL4o9fNS2VEwf04mIkVpAaI+GOXW+9g1vtm2yGIn1/Le5wVrnAC1E4wN
	 FEupvycxSKwCgEoR0ihf6/Ydn988m3pZxiE1ox7asUfgCIVTml9E1PDVh7yg2r7Wnz
	 N4gzRpa4N8W7NoVchIk9K85qW0D0Pn1QngB5J7Z0eywg1anxi3KoM/Pcwh0/U9W9Ii
	 +3fQU7pFLl3F3o6w4+Nru8xRUu9jQSipQT9zlXN4Ux/chkDuWekmLMBlVkNz6qy4LZ
	 6ud38w1lsOaYQ==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8AC79F40082;
	Fri,  1 May 2026 20:46:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 01 May 2026 20:46:33 -0400
X-ME-Sender: <xms:aUn1aVodcBeuR_3lLktGs8JYNteG5oKApuDjkUH83dhEExUM-eXc4w>
    <xme:aUn1aUNC30evn5_-rt5WH0nDIxtg7ZkpQeZRAmMkjE5JQH7R1PFJ2iAqAmo8qdEPQ
    VKxbcPYcZU6G3CvYqODM1oCUIruHdKk8NeEKlWpbzPwGbVoWOlxbxeh>
X-ME-Received: <xmr:aUn1aWqhAdMTZU1Xtj6c-iZGfEqkhPfgYN5JaV6i0v4upcBP92X_6t6VwCwOsA3PAJRVSsMJ6vqNuzxbZqSPeCV1rrWYrwxvn90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeludeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffkjghfufggtgfgsehtjeertddttd
    ejnecuhfhrohhmpedfffgrnhcuhghilhhlihgrmhhsucdlnhhvihguihgrmddfuceoughj
    sgifsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepjedvleeuffffvdehvd
    egledttdetfeeugfdvuedugedugeefiedvvdduleefhefhnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughjsgifodhmvghsmhhtphgruhhthh
    hpvghrshhonhgrlhhithihqddujeejvdeftdegheehqdeffeefleegtdegjedqughjsgif
    peepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhutggvrhhophesrghm
    ugdrtghomhdprhgtphhtthhopegujhgsfieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghlvghjrghnughrohdrlhhutggvrhhoqdhprghlrghusegrmhgurdgtohhmpdhrtghp
    thhtoheplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegvugifrghrugdrtghrvggvsegrmhgurdgtohhmpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:aUn1aXv34zjBtltrwxwwZPzuxbOVefSYZ3Wtab8_MEp6s7sUVxX4zw>
    <xmx:aUn1aV256jRWSmRnrdBYVigFvYJQfEtAIHT1BCljpJhsKzQcyjlI6A>
    <xmx:aUn1aSHyOMtiKWBlqMnOJjWoy5ZEDHwaPVUJ3KVgsKo1sfAP02eTJA>
    <xmx:aUn1aQsn9Rjbs2vh7SgFsOvETX2VrUZoLfyzNWA29k8odyuHXfQ7YQ>
    <xmx:aUn1aVqSCyxL1e9atDIRoStuKoEIrhjOTFx0zbehHhemyYoVCEeeXiff>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 20:46:33 -0400 (EDT)
Date: Fri, 01 May 2026 17:46:31 -0700
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
Message-ID: <69f54967edd72_3291a9100c3@djbw-dev.notmuch>
In-Reply-To: <b5110c3e-c5ee-4305-b307-704837fe4f9c@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
 <69f409325f7c0_3291a910046@djbw-dev.notmuch>
 <b5110c3e-c5ee-4305-b307-704837fe4f9c@amd.com>
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
[..]
> >> +	}
> > A couple problems here.
> >
> > 1/ Nothing stops a CXL class device from implementing a decoder with
> >     CXL_DECODER_DEVMEM (HDM-DB).
> 
> Uhmmm...

Consider a helpful expander that does not require the host OS to use
cpu_cache_invalidate_memregion() whenever DPA space is changed. I
imagine that would be useful for DCD where there could be a higher
frequency of extent changes.

> >> +	/* hold endpoint lock to setup autoremove of the region */
> >> +	guard(device)(&endpoint->dev);
> > This does not handle the case when ->endpoint is an ERR_PTR() because
> > the memdev never attached in the first instance.
> 
> Not sure about this but, is it not the success of devm_cxl_add_memdev() 
> ensuring this can not happen?

That is only ensured by using the "attach" mechanism.
devm_cxl_add_memdev(..., NULL) is only for the generic memory expander
case. Where the entire usage model is governed by memdev ABIs.

> Note I decouple region attach from memdev creation. No memdev, no call 
> to this function.

Which leads to this problem.

> >> +/* Called at driver exit or when user space triggers cxl region removal. */
> >> +static void efx_cxl_unmap_region(void *data) {
> >> +	struct efx_probe_data *probe_data = data;
> >> +
> >> +	probe_data->cxl_pio_initialised = false;
> >> +	iounmap(probe_data->cxl->ctpio_cxl);
> >> +}
> > I do not see how an async event can safely zap that ctpio_cxl space with
> > zero coordination with the driver, and I do not think you want to burden
> > the fast path with new locks to coordinate this.
> 
> You should look patch 8 where your concern is hopefully tackled. I need 
> to test this further, but there is no need of additional locks.

Please do not structure patches with bugs in the middle of the series.
It burns reviewer resources.

> > Can we please stick with the violent but simple "unload driver" approach
> > for now? Someone removing cxl_acpi, disabling port drivers, or disabling
> > the cxl_mem driver gets to keep all the pieces. Just like force
> > unloading your storage driver underneath your root filesystem. Do not do
> > it unless you want to see the fireworks or test various hotplug flows.
> 
> 
> I have to disagree. The use of CXL is only part of the datapath. The 
> driver can keep going without CXL. The related buffers can be used until 
> the sync between the efx_ef10_disable_piobufs() added in patch 8 and the 
> CXL CTPIO datapath.
> 
> 
> Although the option of unloading the driver is possible, I do not think 
> CXL should decide what to do here when there exists another option.

The concern is creeping complexity. There is no such concept in existing
Linux drivers where an MMIO mapping disappears out from underneath a
running driver. It may start returning all 0xff and fire an error
interrupt, but the driver does not need to worry about responding to
async unmap.

All drivers must already be prepared to be unloaded. So we start with
the simple semantic first to get this functionality landed and then
think about adding sophistication like live fallback to PCI operation.
