Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6509282F00
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943779; cv=none; b=iWMZ0803h6ZCjXkdM8onooTuWAn43CAfazfBPWgCI1vO5syCmgRBfMNElFF5EyNhaEY2m1/1fgAUFYP1W18RyHJi6VwRYzyQkqZ9Odj8d28HqCCqBuOxy7LFJVflbgKbO1ZJ9zS9oKZ7vfmbOsVGhkFR982/wm77qnF87QVz51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943779; c=relaxed/simple;
	bh=BwoKLYwPflHSzfJYtksWfLEs3N8OSAUTPFKGBOlCPt4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LYDcu+UYx6xxsfg0NTxhsPx+AiQ2NDXg74x9m4V+r1USbZ/Rh+nadt1oSLSXX6EPE+1Zcd8EgGMDRYcJUy3LUJxtRNAmc9H4Ze/o1gjVn0PK7f/dIRjAMwYz2eltaOB0HuI72lgUN/FW6iAN0PBzDdV97Dwlu4WKv/L8TGIgLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFJZaMu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFJZaMu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613B1C2BCAF;
	Sat, 11 Apr 2026 21:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775943778;
	bh=BwoKLYwPflHSzfJYtksWfLEs3N8OSAUTPFKGBOlCPt4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tFJZaMu75HyDtqp5vOK+nerKooJFmutQE2nmPxZPCXyV/r1eXZotE2kkgjw1xS1l3
	 XwKoGZhDj09+gxKMdVp4wo5ihwunEe36bj4jfQtq93YuS9LxBe7yvZJHDANqczl0MA
	 c4WqZk2iNavSQFw45yCe1hFYRjzqo9JqiTLJMrDHUit6CHOh+ZwlJVJtY/rvgUqlRD
	 pZYnhxwZkhMQoMD+O0DvVJnEFsoOb+YGLvbMIp9yzoVwD8yJNtDTKw3E57UypLTMNa
	 CaLlc41W+PsapvVo10KTg40q1k7ny4Kybm6b2IN9zCyzuUiVXfUiixs0trkDUn7t4V
	 2rSZBbpJxA4sQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8901DF40068;
	Sat, 11 Apr 2026 17:42:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 17:42:57 -0400
X-ME-Sender: <xms:YcDaaRPtTCs2OP4p02OLmvCf12w1jjnm65XwvXzgk_CgbujO6KGCvA>
    <xme:YcDaadRyMXjegQxQiEpKBq2PNx_YLZqUhpZksW5oSNvOxGUu2J98M7-rovOSvBJQL
    5IV94GiHyjPKTNSfBFw30Vl-UQC0zTRJTA5aYMX5wbYXJZ1zb0vaQnF>
X-ME-Received: <xmr:YcDaaXgrHrQUf-PqsI-weunmDE-f1Iki_XkMpIz6Dp1FCjiZoRZm8h3ueWsaIQObRuXXffyQfFna72UErW5dD0J7j110IffCAys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevkfgjfhfugggtgfesthejredttd
    dtjeenucfhrhhomhepffgrnhcuhghilhhlihgrmhhsuceoughjsgifsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhephfefgfelffeluedtudeftdetgedvkeeikeeutd
    duhfdvkeeiudfhjedvkeduvdeunecuffhomhgrihhnpehsrghshhhikhhordguvghvpdhk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudej
    jedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrlhhutggvrhhophesrghmugdrtghomhdprhgtphhtthhopegurg
    hnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdr
    jhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgtgihlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvghjrghnughrohdrlhhutg
    gvrhhoqdhprghlrghusegrmhgurdgtohhm
X-ME-Proxy: <xmx:YcDaae9wtn0SZMMtPPOs-iOAOW4ixxoXFmid6yq6-OCj4fgvoNq5Kg>
    <xmx:YcDaaWFGgdzTjJH0DCVfiY5CtQHZJ6CcKwbawp51P9W3XSfL1UvdPg>
    <xmx:YcDaaZkhgAY3AH8HR9xViMD9rqEqPrFrNOl86onA2kj4_htlJY_78g>
    <xmx:YcDaaSagDXWUx03Z2uQmxYx6ejUBbCGIbDGqXn-lwi5evvkntGBqpQ>
    <xmx:YcDaaWHCZjo2gvQ6sMWOEkS_lZQmBZfTmuuRFyO4f-gfMnHA9re8D4Ng>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 17:42:57 -0400 (EDT)
Date: Sat, 11 Apr 2026 14:42:55 -0700
From: Dan Williams <djbw@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 alejandro.lucero-palau@amd.com
Message-ID: <69dac05fd8b20_fdcb410011@djbw-dev.notmuch>
In-Reply-To: <1bb8bdd7-1083-4b08-8d9f-21d218e383ca@amd.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-5-dan.j.williams@intel.com>
 <1bb8bdd7-1083-4b08-8d9f-21d218e383ca@amd.com>
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
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
> On 4/3/26 22:00, Dan Williams wrote:
> > To date, platform firmware maps accelerator memory and accelerator drivers
> > simply want an address range that they can map themselves. This typically
> > results in a single region being auto-assembled upon registration of a
> > memory device.  Use the @attach mechanism of devm_cxl_add_memdev()
> > parameter to retrieve that region while also adhering to CXL subsystem
> > locking and lifetime rules.
> 
> 
> I doubt this approach is safer than the type2 v25 case. 

I believe it is safer, see evidence below...

> Apparently you are reducing the potential concurrency issue if someone
> removes cxl_acpi, but I think it is as strong as the v25 approach.
> With the rwsem lock, the region will exist or it will not. If the
> removal happens after the driver gets the region, the ioremap can
> race, with your approach and with the v25 one.

Yes, ioremap can race and in the attach case when the ioremap is
invalidated the sfc driver gets unloaded. In v25 it leads to
use-after-free issues.

> Also, you are keen to use your attach function for doing the same thing 
> I have, which needs to be justified.

No, you need to justify usage and export of cxl_core objects without
taking care of the current lifetime rules. Did you see these reports
from sashiko about v25? These issues are the motivation to pull
responsibility away from client drivers.

https://sashiko.dev/#/patchset/20260330143827.1278677-1-alejandro.lucero-palau%40amd.com?part=6
https://sashiko.dev/#/patchset/20260330143827.1278677-1-alejandro.lucero-palau%40amd.com?part=7

Now, I do not think the "attach" appraoch is the final end state. This
needs to get simpler still, but it can not get simpler with an
increasing attack surface.

> I can not see a reason for that attach functionality with the sfc
> case. You did not reply to that comment:
> 
> 
> https://lore.kernel.org/linux-cxl/20260330143827.1278677-1-alejandro.lucero-palau@amd.com/T/#m21968fd0ddf02df3641194d1450cb2bd392def26

Yes, did not have bandwidth to reply to that beyond sending out the
attach approach to better contain CXL core complexity.

> And although I have not tested it, I think this is buggy. Removal of 
> cxl_acpi will trigger unregister_region and a subsequent driver exit 
> will invoke, inside the autoremove call linked to the endpoint device, 
> devm_release_action on something not existing anymore.

If there is a bug here I would like to see that test case because as far
as I can see it would be shared with the generic expander case.

> It is the same problem with v25 type2 and potential cxl_acpi removal.
> Maybe we should avoid linking a type2-related region to the cxl root
> port ...
> 
> 
> And IMO, hiding what we are doing to the user/driver is not convenient. 
> Although current type2 is going to rely on a committed decoder, that 
> will not be the case if we look beyond impending needs.

Yes, start with the simple committed decoder case. Later, follow-on with
auto-create support. That would have no need to go back and teach
accelerator drivers how to create regions in the simple case the same
helper would "just work".

> A function with a name describing this situation can add clarity to
> the different possibilities to support as a follow up of this initial
> work. About naming, attaching a region to a memdev is confusing ... as
> it is already "attached" or linked, and the reason you give for having
> that explicit attachment not being clear from a safety point of view.

I would be happy if the only detail left to discuss was naming.

In this case "attach" means "attach to CXL the topology". A PCI driver
can create a cxl_memdev, but if that cxl_memdev finds no active CXL
topology then that "attachment" fails.
