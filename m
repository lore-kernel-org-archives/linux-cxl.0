Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8362E413
	for <linux-cxl@vger.kernel.org>; Sat,  2 May 2026 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777762432; cv=none; b=B7EQtYQ3HnRteV0mJoh1pz2cB5cIcepm7bN4OKLjfxD6GknP6iTYjFqPTqHZ/cESbjLNGY6lEKyNdwVR6ZG4bfNazY+rWv6ixHU2hoV8y/6iH5yOM5kuYYZpGSHyy4xInO+5wcBu+nz9Oc1KCGgazmzSwWPfjr/BabQw3E42obY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777762432; c=relaxed/simple;
	bh=cgsxqzBrl2z6jsAEFqE6leMtWdGB5FbCbFRUn4/JQSQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zy91TONVI0AzLgzDsjfMmPNxkzrTqQfxBQ0GnbqTfbDpGmmB6RPa/8aZmKMGi1Hm6AmlEiv8+VP7UAxGM5f3a2FgMZ3kFNX/R1D7Ig80SWmQZQVw44N1zhnROSEoL4m/eTBVPSpslyUQlvZ2+POXPdksMbeR0g5mmHAlqx9vMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+L5ZKLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+L5ZKLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92101C4AF09;
	Sat,  2 May 2026 22:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777762431;
	bh=cgsxqzBrl2z6jsAEFqE6leMtWdGB5FbCbFRUn4/JQSQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=f+L5ZKLPLnA4HBkW5hOaklJeEkTXkbbj9gFeAmLoGXi2qCengwM0wEIhoeOi6B8zu
	 uWhOEI1na33hFC4FHFdYpc09KJgRQaM9487GZnWBoeFY81d7LIPatRF4OKlj/umvAq
	 z+Ve4TxiLy82zSjIHer05v1RRVZ1Xu2R6y5co3CjZxLVGEUpjr6wkrarT14WQ9S8C9
	 In9su/n8DJTd98NfZKZ2hnBssJmSWl66YEVYiWZnkpbyNFP+pCxT9PAQP79HXjA2y3
	 4XpjazcqW5nbf95qFq63IfaUzxHHtkngkFmYVArDjlGtQIF3XNpEfA2wGf5EsbHvwK
	 h6PJxJA8O9caQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F1CEF40080;
	Sat,  2 May 2026 18:53:50 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Sat, 02 May 2026 18:53:50 -0400
X-ME-Sender: <xms:foD2aRoT2Ylm1ASq_5nIjvqAQpds2HVY-n_Onv0KmNCrtvUNgac80g>
    <xme:foD2aedRHbyNBmhYXhNoR-e-FLYGa31ymM0M617Kp_gCpakupdjkmmBSnFPoH1rHs
    k3pvIf60XMrWHEIDNjS88GTk9P6spTjVX2bu6KLG3unN5gxR8YFEGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelgeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdffrghnucgh
    ihhllhhirghmshdfuceoughjsgifsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepgeekudeukefgudegveelfffhveekhfduuedtteffvdfhteeftefhkeehleefudet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughjsg
    ifodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddujeejvdeftdegheehqdef
    feefleegtdegjedqughjsgifpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtg
    homhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpdhrtghpthhtohepug
    grvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepihhrrgdrfigvihhn
    hiesihhnthgvlhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrnhhishgrrdhsuhesshgrmhhsuhhnghdrtghomhdprhgtphhtthho
    peguohhnghhjohhordhsvghoudesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegurg
    hvvgesshhtghholhgrsghsrdhnvghtpdhrtghpthhtoheplhhinhhugidqtgiglhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:foD2aV8kltv7Vfk1R8WvM2UydX9Z9kgXbcx8km3UOB6gJ8TgRXv04w>
    <xmx:foD2aTv0F8Igm22ZZzBa6vrR8PFE5MPAplsIWjbs3ZDel-Sz8g8mQA>
    <xmx:foD2aZqNQqKUvr3EpOLIoakIsYjrtCSxteOCKZVaLB7SfjI1x0S47w>
    <xmx:foD2aXqkPtgauJfN5wu8gUbQGOHiW3YitGPHnNlY2Qm184cbqGMggg>
    <xmx:foD2aYb0rEmngAXwPBMzxVzw0XhkfgbKsCbVeAVBF9Ym77YAG2KWeO4b>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 657122CC0083; Sat,  2 May 2026 18:53:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 02 May 2026 15:53:30 -0700
From: "Dan Williams" <djbw@kernel.org>
To: "Davidlohr Bueso" <dave@stgolabs.net>, "Dave Jiang" <dave.jiang@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,
 "Alison Schofield" <alison.schofield@intel.com>, ira.weiny@intel.com,
 dongjoo.seo1@samsung.com, anisa.su@samsung.com, linux-cxl@vger.kernel.org
Message-Id: <9f73073f-09f0-4e08-b1d8-746be33fd674@app.fastmail.com>
In-Reply-To: <20260502193429.hztbijgv3bjwit5k@offworld>
References: <20260428200410.705675-1-dave@stgolabs.net>
 <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
 <20260502193429.hztbijgv3bjwit5k@offworld>
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

K

On Sat, May 2, 2026, at 12:34 PM, Davidlohr Bueso wrote:
> On Tue, 28 Apr 2026, Dave Jiang wrote:
>>> +What:		/sys/bus/cxl/devices/memX/security/zero
>>> +Date:		April, 2026
>>> +KernelVersion:	v7.2
>>> +Contact:	linux-cxl@vger.kernel.org
>>> +Description:
>>> +		(WO) Write a DPA range as 'start length' in bytes to this
>>
>>Same comment about multiple input in a single attribute. Maybe introduce these:
>>
>>security/zero_start_dpa
>>security/zero_len
>>security/zero
>
> I had missed this feedback - this suggested interface is horrible. While the
> sysfs documentation mentions the one rule per file, this is not strict and
> (as Jonathan also agreed previously) we can do <start> <len> inputs. There
> are plenty of examples that do not follow this rule when it makes sense.
>
> So my follow up patches will do
>
> echo <start_dpa> <len> > /sys/bus/cxl/devices/mem0/security/sanitize_range
> echo <start_dpa> <len> > /sys/bus/cxl/devices/mem0/security/zero_range
>

Isn't a "start:len" tuple ABI a solved problem? It would be nice to share the same parsing as memmap=. For example, then you get features like "echo 1G:1G ..." to specify a range.

However does userspace really need to pick ranges? Would it be sufficient to start with a "sanitize / zero all unmapped" semantic to walk all not mapped DPA. Or perhaps a "sanitize / zero on unmap" flag to the decoder to make it similar to a storage "trim on delete" semantic. The nice thing about that, you can defer freeing the DPA until it's clean to avoid reallocation races. You actually know what you're zapping because it had some recent prior association.

Otherwise I do not trust the security properties of policy wanting to clean a DPA range but an unsuspecting thread can race to allocate between lock drops. Looks like a footgun.

What use case is missed with a per decoder automatic cleaning on unmap setting? Zero before map policy might be nice too...
