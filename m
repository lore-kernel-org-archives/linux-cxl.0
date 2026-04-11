Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1F1C84DC
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775946836; cv=none; b=kHIbDwlz2X+ZuJ5IwVHAkgImhSD2O2bVUevCJAnoGrM/pxhHMXXxyY5lRUgdUl7/eUG1Qj/ro9ZIBOCgMXlQ9UKFg9UOJt5bhIsAGPIr3qYqoD4iW0thqSTLDBfjiizfyij0Y9+LLfZ1OwUXd11XTXR2OtYtBQr2T8FFkOzAtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775946836; c=relaxed/simple;
	bh=vAVeGs8nvltZU6Vk6ej67qlUgFppGD+rakQigGow/Pw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fFV2J8h51hvPoiOZocQeLqMpJ6KZ0V86f0WUgMAWt8QgdMXscT0OJNW+quIEM+r8WH96QMfkjPoCD77wjd4dwNKFe0lNnTaAQIEiDSrkqG92hpLKIhnLn1MR+9MNdzCjflcr7/kPkwt3ikzygxInED62YtwcaKmRSc9axxIDY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSEoO2xE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSEoO2xE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A48C116C6;
	Sat, 11 Apr 2026 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775946835;
	bh=vAVeGs8nvltZU6Vk6ej67qlUgFppGD+rakQigGow/Pw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fSEoO2xEyJADCpoIfW8o15qW6Inhis5lzE1rNFiYlAKZEbNKXWwTZLKtkGoUJyHHP
	 cEppmuz58o4HaKx+WfJMEVia7uHnny1EMC9cTm40WwfvEyMAlv+nmiyMe6gjZJGONX
	 UKuRPlslSQKbWy/0u891axjUGgnNnLTywvtwSVhGUSmkVlqX95NLNG9Sb53Ny6LefN
	 wiweZrknvIWYeE2j1vDr5XkjivUTaMrYNoOf6I7jBlIxaROmuCtBuL72Ks8yaEmJ4y
	 +0umeN0hfZMfVbYzOS+oHa42YEyyppatOY0WAcqQHacjeR0qYWHlU4scTID4ZiH0BK
	 QsCTYSbN9snhg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7D4B5F4006B;
	Sat, 11 Apr 2026 18:33:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 18:33:54 -0400
X-ME-Sender: <xms:UszaabTAjGt6H-GfEt7I8tiDAHXZktXK2--0XqHDeBF0EbORBg4C2g>
    <xme:UszaaeTuoIOdAexk4G7a_VRkYcxQGDmPQCcdrZ4un65bmK1GlQsKkYI-r3zdVPnyz
    SZMlxcHFLOenCPcVUG3kKmujb8b1Tq0Q1DiWKxxxr85Vq5K9D_q3Ec>
X-ME-Received: <xmr:UszaaQ5MbMl6tj0o6IKIf159KulMtclmkTIcG2hAKb3bvoV6hskjZtmwePa-ZfmHy_GJZWoJAk5qDEmpfZQWbeAErAszd3nVngY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghn
    jhgrmhhinhdrtghhvggrthhhrghmsegrmhgurdgtohhmpdhrtghpthhtohepuggrvhgvrd
    hjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqtgiglhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvjhgrnhgurhhordhluhgt
    vghrohdqphgrlhgruhesrghmugdrtghomh
X-ME-Proxy: <xmx:Uszaaa1PVVQU38qFCtX0dSVu-67ZPcSSR8d0GIaHQrxgIaiqR3Pg-g>
    <xmx:UszaabCinV0MOA1cU27xHhNneIiThvKbQ7HWBK8y22nsE2LYTVHuOg>
    <xmx:UszaaVOm-Q3Um0ghLrh7AkANS2kRtu7gWmBWaPe8KiivA7Gg0VpbvQ>
    <xmx:UszaaQa-Ada_q8dNoC6FbM-aaBI1zaSaBX7Vj_kHl4HeWJlvXaRwvQ>
    <xmx:UszaaUu87PScImuRDzTdciMud71eUUezHkT0SMsVhetf96dPpnN0xSCm>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 18:33:53 -0400 (EDT)
Date: Sat, 11 Apr 2026 15:33:52 -0700
From: Dan Williams <djbw@kernel.org>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, 
 dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 alejandro.lucero-palau@amd.com
Message-ID: <69dacc50b1a31_fdcb410046@djbw-dev.notmuch>
In-Reply-To: <6fa575fa-a421-40ca-bdb7-af5728d6fb1c@amd.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-2-dan.j.williams@intel.com>
 <6fa575fa-a421-40ca-bdb7-af5728d6fb1c@amd.com>
Subject: Re: [RFC PATCH 1/4] cxl/mem: Add support to cleanly continue after
 attach
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Cheatham, Benjamin wrote:
> On 4/3/2026 4:00 PM, Dan Williams wrote:
> > For drivers that want to fallback to PCI-only operation, immediately
> > cleanup on attach failure. Otherwise vestigial topology objects are left
> > until driver unload.
> > 
> 
> The usage of "attach" here is somewhat ambiguous. Does this mean the attach callback,
> or cxl_mem attach?

Fair point.

> Also, I know that providing the attach callback is probably what
> indicates a driver wants to fallback to PCIe operation, but it's not
> evident based on the description or contents of the patch.

I rushed this... it was a hectic week when I sent this.

> 2) Isn't the memdev already cleaned up if cxl_mem probe fails and
> attach is provided? What's the extra cleanup happening here?

Exactly right. cxl_mem_probe() failure does the job.

Sorry for the noise.
