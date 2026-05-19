Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492530DEB2
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230740; cv=none; b=d8RpLqsFko04Dl3BsUGpDwURAFubGsMookcZ8Q8P2UUWDRvTarY5b1sev4SGZqZhVyqD6R+GqpVY/sVQk2qi9BnHbVRfCxGw0a/rAIM4BqruT4lcn5XQnzZEqiOOoKkGeHNpXxOQvla+5CTa4V87XZG1ROaxWMCy5ei2Q6Ji65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230740; c=relaxed/simple;
	bh=qoULMmlrESw2r2y9m6nXqcdyrsIJeYAqiusBScmIq3M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P7Ii7qVE580/Yi4ORArFtpBcgVIFJ/GpY7h17cAjdKvmsQuc3xiDzU5OUldx1IUaWKy+QSnVt2iXx7StGH8sAi2bi93m7YSSWW/CzAY1LdZ6xdNmA2HOBTbx7zPAYKC1pNZjAOz9FO5/qVe5juhYfeuomSnPY6SS0lUT4BxzADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP/GMjvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP/GMjvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BC11F000E9;
	Tue, 19 May 2026 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779230739;
	bh=CcSH4J7EJK0K5QpnFVIpzlbYC1GIgCm3+wHCxQb3zy4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=aP/GMjvVbpkJI/OoTQ5Jnui2rrRpo08X40IsAGXaSTmLIXNn2SLPaFkM/6rHnuccw
	 KRDTyhv7rtRQ0VomnS4dgPx1mfD1nZqtUY4aKCK5QrM5p3xeFoMPU+ugboNOWcWbHe
	 n89czUSqcmrKPbjFIBCbFQJzhcW3ibn64LJgy52m6PvZf6RlfcFDcrRAUHY7qx2zOZ
	 VzliMPAQdzDG+wVGYKcaJdBqLEgn/dqiCqq0D5lKLM8tsK83ouwdIXl2/UGHuewr0H
	 fkl7OoC/s0ZvlxsCPV3ThdhEyct4YRFCstdPi6AfCZ4SRTbpvaOFL7/OC/WV5225j9
	 rLVBoYA3N1qEg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1CC0DF40077;
	Tue, 19 May 2026 18:45:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 18:45:38 -0400
X-ME-Sender: <xms:EugMaosJYwAigp86VvhPY_r02z_cTe5Mf6xxQkTVcQ3R86UqBdA1Qw>
    <xme:EugMahRdEzh0Zm2kaQLmwUlpX4zgxHctlDg_BgaxpeCIn8KM1NZ2ywxZaGFr4MXQ9
    cYYN_zctLIrBNh-_i_b9K-T8ULozwBfXd-nTuvQCauewu-_P8UGwaIL>
X-ME-Received: <xmr:EugMavLSnzTj0fHMLIzouI52Vzk4pqgRbdxHUc82begm5R9RXfgumRyNCwVkWqmcKvsQTZlEbASjk4NGDmfH-r2JqxCukakTjPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefkjghfufggtgfgsehtjeertd
    dttdejnecuhfhrohhmpedfffgrnhcuhghilhhlihgrmhhsucdlnhhvihguihgrmddfuceo
    ughjsgifsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepvdegheeikeetle
    euffeuheefjeejvdejvdevteefgfffveehvdeuvdffveffvdehnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughjsgifodhmvghsmhhtphgruh
    hthhhpvghrshhonhgrlhhithihqddujeejvdeftdegheehqdeffeefleegtdegjedqughj
    sgifpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjihgtvdefsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegujhgsfieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggrvhgvsehsthhgohhlrggsshdrnhgvthdprhgtphhtthhopegurghvvgdrjhhi
    rghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegsvghnjhgrmhhinhdrtghhvggrth
    hhrghmsegrmhgurdgtohhmpdhrtghpthhtoheprghluhgtvghrohhpsegrmhgurdgtohhm
    pdhrtghpthhtoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpd
    hrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopehg
    ohhurhhrhiesghhouhhrrhihrdhnvght
X-ME-Proxy: <xmx:EugMakt6WIXGdG40GB9MI3OxtCSZ6zwbgpsSXVlUaQmnxUk23ndHzQ>
    <xmx:EugMam8KOlK2EWntKd6Wnh0yAKWtCDtoydcwU7WrOMm-p8lHAfvqsQ>
    <xmx:EugMau38aDO3pM42JRqtZLHY6eGkUD6umAzcnhiSb5UbgcZNLTC4Gg>
    <xmx:EugMarisBbEU7LgxjDNxYoIPpxdFzW6ahUuLn-Kg4ZHN7rvCuWMjrw>
    <xmx:EugMauZYopSFDQbW13FbfPLo43a7L1AveVQGmqjXq1gqxPcHi3dpthPq>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 18:45:37 -0400 (EDT)
Date: Tue, 19 May 2026 15:45:36 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
 dave.jiang@intel.com, 
 benjamin.cheatham@amd.com, 
 alucerop@amd.com, 
 alison.schofield@intel.com, 
 ira.weiny@intel.com, 
 gourry@gourry.net, 
 dongjoo.seo1@samsung.com, 
 anisa.su@samsung.com, 
 linux-cxl@vger.kernel.org
Message-ID: <6a0ce81082439_16dbc610018@djbw-dev.notmuch>
In-Reply-To: <20260519124133.1f2bd813@jic23-huawei>
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <6a0bc26656f_128d711001f@djbw-dev.notmuch>
 <20260519124133.1f2bd813@jic23-huawei>
Subject: Re: [PATCH v2 0/5] cxl: Support Back-Invalidate
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
[..]
> > The root decoder restrictions specify the endpoint decoder requirements.
> > There is no flexibility to entertain beyond picking the root decoder
> > resource, right? Linux can avoid all the configuration corner cases by
> > making the endpoint decoder inherit settings by topology configuration.
> > 
> Hi Dan,
> 
> Assuming I understand the question correctly...
> 
> No idea if anyone has done it but as far as I can tell you 'could' easily
> enough have a single fixed memory window that supports both BI and non BI,
> the host implementation would just have to use the programming of the
> decoders in the host bridges to figure out what it needs to support.
> 
> I'm not aware of anything in the spec that says you can't implement that.
> Now maybe it's a non thing but if it turns up later we need to be careful
> not to wall ourselves into a corner from ABI point of view.
> 
> Usual reasoning of HPA space being a fairly costly / limited resource
> would be the reason to build this more complex hardware.

The BI bit in the CFMWS, unlike volatile and PMEM restrictions, has
additional references by bit0 and bit1:

Bit[0]: ...(HDM-D if bit[5]=0; HDM-DB if bit[5]=1).
Bit[1]: ...If an HDM decoder that is mapped to this windows has the BI
        bit set (bit[5]=1), it will result in undefined behavior.

The Bit[0] wording does not appear to leave room for optionality.

The Bit[1] wording needs fixing, but to my eyes says "host-only ==
host-only, do not enable BI operation in any decoder that maps this
window and expect it to work".
