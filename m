Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F338495031
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679080; cv=none; b=mGuPimRVD2cK6tjNM3Qy0plWWnDvIwu8mQ8QuGgvPrPvaIdGc2xVtT4z6TSkdAMmzj/8b79+8mu10CRXhWqzE0Zd/vNuiIIRk+cqWtlOnep58civVQYc92tv9B5BDxIX52HIlT1vhSuZx8P77rrNru4t1tTHhzOly7MsPbra0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679080; c=relaxed/simple;
	bh=AbbDClQJbQYrrRS/diJ9KbuRGcrymcYDWWBUOxpXKTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SV88pqApcf6W3mnpRGrHWjDU4un/lvLPL+dPz/DZEFQ7h6hUvUWARgtnTcNiwvdFUC8oHGLqkmsGDbAJRicWTPYVERRZJROB3q0ivFicgb65u8kahFNtqxHStL7wkj8exkKoazYBgbwbKdi8Y9+6lfgLJ6rvvb93gOb3OHimsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwNxviXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwNxviXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5056A1F000FF;
	Thu, 17 Sep 2026 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679078;
	bh=6OshrG9EC3rLRuZd6dVVhm7+7tA+mnJBXrE3rLMnd74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NwNxviXunoyeovA83wbdWS7bEtElmNKU35oSXZwbpvZnC1tFPBveDxdOkx67NU8Hu
	 aPGs+ys8xfBkQs+WsnreOeCOwP6IznHgJ9j45tEOKO0J71X3NT8Gla2Ty+btmhlAtj
	 n++3i1ZnewCreXY8B8L8L8uDuYrr4myMz9gLDZxS1l/dMGpREPWjzoFrjhgGTmh4XU
	 HGpTHofBS9luzpmm915yPSYiCTTrkYxwHH2dLyi8rOX4W5OUEoXJllLUKtk9AW2imZ
	 gEWsMeEutqA+tN7N6E0hZ6T5itiIFhI0ykaV1Ff45JleK/4xnnrCrZl6B+jNqg+U+Z
	 V9KrueHHoLpdg==
Date: Thu, 17 Sep 2026 22:04:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan
 Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
 <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Create node access attributes for
 CFMWS-only NUMA nodes
Message-ID: <20260917220432.44c703a1@jic23-hlaptop>
In-Reply-To: <aqrYws_qG92cdXHQ@gourry-fedora-PF4VCD3F>
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
	<aqrYws_qG92cdXHQ@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 13:59:48 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Wed, Sep 16, 2026 at 08:03:38PM +0800, Guixin Liu wrote:
> > Tested on a QEMU CXL topology with a CFMWS window whose memory is not
> > described by SRAT or HMAT  
> 
> Sigh.  This keeps coming up.  (Not your issue Guixin Liu)

I won't reply in depth again.  If a platform supports non trivial hotplug
(i.e. more than one device spec) then the bios has to be clairvoyant
to create those tables in a fashion that is useful. Generic Ports were
added to put the missing piece in to solve the problem so there
is no longer a need to pre bake. 

> 
> It would be nice to actually fix this in QEMU rather than make QEMU
> specific fixes in linux.
> 
> On any other platform we would call this a firmware bug.

You are going to see more 'buggy' platforms as the ones that don't
have to comply with the ancient history aren't going to add these fake
SRAT entrees.

Personally I'd take the more radical view that if a platform gives
us Generic Ports, right answer is throw away any fictional / approximate
SRAT entrees, do the discovery ourselves and build representative
NUMA nodes for what is actually there.

This is going to be more fun when we have more complex devices showing
up and need to create a NUMA node per device (i.e. those nice compression
devices of yours). At that point you aren't using SRAT memory proximity
nodes anyway - unless they are all there at boot and you are spinning a PXM
for each one.  How do you do if a mix of different sized (or at least
sizes you didn't know at boot) devices get hotplugged later?

Jonathan

> 
> ~Gregory

