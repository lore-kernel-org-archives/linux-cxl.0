Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F402628D;
	Sat,  4 Apr 2026 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775331417; cv=none; b=lkK9ccv1rYr8w78FbcIq6dIQE1e9z+lo0GCEWuBwO2Amf/Ih5kaCEk2tGvwnKiaB+vVrZgMwhrIFlu77WVSsG0h5aCyH9w940fI09g4wABYs5yqT7x+Br4A9YWY288hSH2JWb8+6G7UwzXJYA/c+xGY6zTSzFS/21w1FbqumNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775331417; c=relaxed/simple;
	bh=7D8uiw+X/9kr5mLCuGlYTyk+5HuqluWCri0cZXArQME=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qDsi1PppYEwOS/AksydxKd6N1DzhiYhYh+1kKocw4AhVU0I67IVXeOAmuxFo5/QxuNEnf/iO2MAaXu+b71fL2zNjK6isKx/SMb9VJ5TT1bTlv7jGLk+dFEhGdGMW0rXB9NT4GTQbaNu0rBF4X9+E74A8Djq0gHjJ57ojPs0YmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7WMijw7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7WMijw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35D7C19421;
	Sat,  4 Apr 2026 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775331416;
	bh=7D8uiw+X/9kr5mLCuGlYTyk+5HuqluWCri0cZXArQME=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=h7WMijw7hs5m2jIpFZnah7XpZID9cksm8+J4vMabf8H2X5dtOqTYeLqeNE0SOJdjI
	 71QjWih1EOvJk2T5NpwF31qPWgunVihwuJzq+j61yd44ST8eZ6kym1ouucPHAGe7Qq
	 SmrZg/qLD9RDzZNUzGTx7/A8fFm9qK/+0vJ6O1bHp5WLx58b5nWEEssLAEz3Agc7kZ
	 zNjkTR0jbOHcCz+/lVM7J7hqRnH8sEKUz0oqoM6O7/RvU63BhlFkEsNzN9otB6zQaa
	 6+X9Ao34GjNUXZzIEVtOC1besS4dG6U+/JApmclI5X5X8Yhe/r9vRB3b198eBA7K+T
	 uACi1L+LbtfZA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id CC267F4007C;
	Sat,  4 Apr 2026 15:36:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 04 Apr 2026 15:36:54 -0400
X-ME-Sender: <xms:VmjRacrPwKiJiuPjSNM0vr8UkmniMnbvqnnMU9yit36ZSJ0rU-DsFg>
    <xme:VmjRaewjoidua2WX3sBAShnyKRGJTyakOtjNIh5tpejZAf7M7FXH1V8_X78kpTyST
    gAhtLdLwMxvGF1BHb8vO4lkCl9kzkbHgryAoBJdr4nN6U7Q5_ttJ3M>
X-ME-Received: <xmr:VmjRadCfKXrnjwKQzPMuVQxCPK07bdwRIqReOmbvavlfC4Itbi4bAgIaWayy-snrH4_Th18YOtNqfxNSD0sIiEsfeBn7eRpRasE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevkfgjfhfugggtgfesthejredttd
    dtjeenucfhrhhomhepffgrnhcuhghilhhlihgrmhhsuceoughjsgifsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnheplefhiedugfdvieejtdelledtudeukeffjeejvd
    ejhfegveejfeeujeeltdelteejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqddujeejvdeftdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvghlrdho
    rhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvdehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopehm
    hhhonhgrphesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghlfihilhhlihgrmhhsoh
    hnsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhho
    nheshhhurgifvghirdgtohhmpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvg
    hlrdgtohhmpdhrtghpthhtoheprghlvghjrghnughrohdrlhhutggvrhhoqdhprghlrghu
    segrmhgurdgtohhmpdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdrnhgvthdprh
    gtphhtthhopegrlhhishhonhdrshgthhhofhhivghlugesihhnthgvlhdrtghomhdprhgt
    phhtthhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:VmjRadOGarB_YiyvQTrsz1fV5q00rbIdYK-yTfS0vndjAVdlACNo0A>
    <xmx:VmjRacCq_xOsAPVEK-H0gAgqrgAO2liGyb0G8N3jxC4I6qf0t5tgGg>
    <xmx:VmjRaXkps3msLbcRB6lOw4dqtAP2esqrTEk4jAu5qRjfO8mThpV2CA>
    <xmx:VmjRaYq7g_YnS6wlyLJHE7rIP9NCqCPq2vefwMTHeDKh1SFHH_oAHw>
    <xmx:VmjRaehUrwAkKEoYbD5uQSBfmWbityjMSA4jhEicF4zlu1jv9qr9p3oB>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Apr 2026 15:36:54 -0400 (EDT)
Date: Sat, 04 Apr 2026 12:36:53 -0700
From: Dan Williams <djbw@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: mhonap@nvidia.com, 
 alwilliamson@nvidia.com, 
 jonathan.cameron@huawei.com, 
 dave.jiang@intel.com, 
 alejandro.lucero-palau@amd.com, 
 dave@stgolabs.net, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 ira.weiny@intel.com, 
 dmatlack@google.com, 
 shuah@kernel.org, 
 yishaih@nvidia.com, 
 skolothumtho@nvidia.com, 
 kevin.tian@intel.com, 
 ankita@nvidia.com, 
 vsethi@nvidia.com, 
 cjia@nvidia.com, 
 targupta@nvidia.com, 
 zhiw@nvidia.com, 
 kjaju@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, 
 kvm@vger.kernel.org
Message-ID: <69d1685538f45_556821002f@djbw-dev.notmuch>
In-Reply-To: <20260404185330.GD2551565@ziepe.ca>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
 <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
 <20260404185330.GD2551565@ziepe.ca>
Subject: Re: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Gunthorpe wrote:
> On Fri, Apr 03, 2026 at 12:35:45PM -0700, Dan Williams wrote:
> > > +	/*
> > > +	 * CXL device memory is RAM, not MMIO.  Use memremap() rather than
> > 
> > Right, CXL.mem is RAM, not MMIO, so I question why is this not being
> > mapped via a RAM mechanism? Can you explain a bit more about why reusing
> > vfio MMIO mapping mechanisms is suitable here and what happens when we
> > get to questions like guest_memfd integration, page conversions, and
> > large page mapping support? 
> 
> None of that is applicable to VFIO. VFIO owns the entire address space
> and does not share it with the mm or anything else.

I was worried less about sharing and more about how the map eventually
gets used, but makes sense all of that is enabled through the VFIO VMA.
I have more reading to do in this space.

> > Maybe this is the start of the conversation for something simple, but I
> > would actually prefer uncached ioremap() if only to avoid all the
> > coherence management and suitability of MMIO mechanisms questions.
> 
> The entire thing needs to be mmapable in a cache coherent way since
> that is what the HW semantic is. If you try to do something else you
> will break KVM support since it follows the VMA.

Then I assume it matters that memremap() sometimes silently falls back
to the direct map. The "VFIO owns" expectation needs to guard against
some helpful platform firmware mapping accelerator memory as System RAM.

At a minimum having VFIO fail to map in that case helps with the
argument I have been making that "no, EFI_CONVENTIONAL_MEMORY type +
EFI_SPECIFIC_PURPOSE flag" is not suitable for accelerators with private
CXL memory. Those want to be enforcing "EFI_RESERVED".
