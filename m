Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABE285CA4
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775929175; cv=none; b=mUF+ZWZ1htP4Gey2fg+N3YjMY1tXr0BBno2clm5gzWyIqcf9wQd9VMX2npESrQIeevw0brZDQaSb7SlZbLLcEIRKXDQrejdVgh/lItNT0lvipP2M0MBbVB64pwrBHJpqJOCPXYMfC7C7o8akvjKZhKZ9HYZGdeECuvtaS+BsFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775929175; c=relaxed/simple;
	bh=1Obsz5IeqIwbtrVfDCyn2N2B4nUcQpnOZSe85KEd3f0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LhNBTWnVvp53kfrfBesxBgwo0K1121IWVSNRciIQsAsQfmkuqNA1U/7HgcKpKW3q0uKeoCAYUiN+xvgqKqu6B+hGGvo9F0AFDv0Aap7/jeu1Y/jMgw0KqqSLhyg/Q3dYC/wfdUMeR+hq/iNGauR5FvZHWCSsDR2UJvDfFVU56oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj1JOaww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj1JOaww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0009C2BC87;
	Sat, 11 Apr 2026 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775929175;
	bh=1Obsz5IeqIwbtrVfDCyn2N2B4nUcQpnOZSe85KEd3f0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Tj1JOawwhDOCB6GaTdAuc2JX2mcvrFBrKhWXsObDKxgwNw2kgpN7MEE8LTsiwEkB6
	 43MmWAmrW5gTQJ6dWBUd9xhwIP8nKVO39lIAyy86AWfykFUrTY7m42tVvPEW/POpfh
	 fhqp1KYlXjwjvoEyM0NSVh1wJYc4tBp1Eg3AkLGy4If3qginCt5TUaNqbdAhSbU+0i
	 SryGF0ua2KYGxovX/A9mF/UyrYSbA/7a0EZnkiv6Ku0oXjmA0pQMzHOgCM7sOprAyJ
	 Vo1ZxIGoNiOY2m2lGm2ecoVSnoT0iRjYZSOuGlrQzD7NpwZ9ofwpwbwEg2T6hEs5Et
	 fwBQMQBMaOrQg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B9FECF4007A;
	Sat, 11 Apr 2026 13:39:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 13:39:33 -0400
X-ME-Sender: <xms:VYfaaV-vLSRC6NXlY1G15dIh88SH3gyhpRTezvCT1zA9uazsc169hA>
    <xme:VYfaacwGDLElDP0rctIq0pfjimKru9R8vbucM8i7cTfWl79JtMwnZpXVKn9_pH7VG
    D53wdZp0nDyZwzBk4jF6-jWfAS43ro174jsYGogISlNZiysdKD8m-o>
X-ME-Received: <xmr:VYfaadoEaLh5I8aDfg6pYTt7uaJtcrpyFI1_CYIlARN4p7MmYOCzsro5bDHizfvCV1_8rZ-QB9xBUjjSKfxsyq55iGHCgOwJJQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefvdelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevkfgjfhfugggtgfesthejredttd
    dtjeenucfhrhhomhepffgrnhcuhghilhhlihgrmhhsuceoughjsgifsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnheplefhiedugfdvieejtdelledtudeukeffjeejvd
    ejhfegveejfeeujeeltdelteejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqddujeejvdeftdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvghlrdho
    rhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgohhurhhrhiesghhouhhrrhihrdhnvghtpdhrtghp
    thhtoheplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopegurghvvg
    esshhtghholhgrsghsrdhnvghtpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghr
    ohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopegurghvvgdrjhhirghnghesihhnth
    gvlhdrtghomhdprhgtphhtthhopegrlhhishhonhdrshgthhhofhhivghlugesihhnthgv
    lhdrtghomhdprhgtphhtthhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtg
    homh
X-ME-Proxy: <xmx:VYfaaVpkoFZxfKQetXMNP6fKzW8H1BFhc_OPpZsYmiDQ2EndxXxaqQ>
    <xmx:VYfaaVD_Kx9pViySUHzpDi6PA3S-oSpJXHOIRvWzJKUOZJnbcZnoqw>
    <xmx:VYfaabulT01nMJiM7rx_WCqdaZ22csconBf6xbrNkyxhIdwWSEXteQ>
    <xmx:VYfaacJUrvVJm-ftWMLBFmLE8N_r9EQVW4pLO0RdgIjICdjs0ZccPA>
    <xmx:VYfaaabosPy-B5Q_rwTdQWg6GXjp_LTGs76XU6gMeAZVgnZzr35ROrdX>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 13:39:33 -0400 (EDT)
Date: Sat, 11 Apr 2026 10:39:32 -0700
From: Dan Williams <djbw@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, 
 dave@stgolabs.net, 
 jonathan.cameron@huawei.com, 
 dave.jiang@intel.com, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 ira.weiny@intel.com
Message-ID: <69da8754369b4_6c31a10069@djbw-dev.notmuch>
In-Reply-To: <adnXeR7rOEByIg6n@gourry-fedora-PF4VCD3F>
References: <20260327020203.876122-1-gourry@gourry.net>
 <20260327020203.876122-3-gourry@gourry.net>
 <admPeJv7mjDZPhJv@4470NRD-ASU.ssi.samsung.com>
 <adnXeR7rOEByIg6n@gourry-fedora-PF4VCD3F>
Subject: Re: [PATCH v5 2/3] cxl/core/region: move dax region device logic into
 region_dax.c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gregory Price wrote:
> On Fri, Apr 10, 2026 at 05:02:00PM -0700, Anisa Su wrote:
> > > +
> > > +	cxlr_dax->hpa_range.start = p->res->start;
> > > +	cxlr_dax->hpa_range.end = p->res->end;
> > > +
> > > +	dev = &cxlr_dax->dev;
> > > +	cxlr_dax->cxlr = cxlr;
> > 	cxlr->cxlr_dax = cxlr_dax;
> > 
> > Running into segfaults without this ^
> 
> This should have been a purely non-functional change (the code is just
> moving from A to B without changes).
> 
> That would mean the original code should run into this too unless I
> mucked up the move.

I do not think you mucked anything up ->cxlr_dax does not exist in mainline.
