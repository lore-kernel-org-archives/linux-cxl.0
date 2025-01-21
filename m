Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2B1B808;
	Tue, 21 Jan 2025 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491768; cv=none; b=TB07lFnvoHOcBjr6mepYiZhovdM+PjqingPOVQB/HKgE9GzX6rfWQt60w74H/fLRLB+krx6XNsZMl+DpQGQ1SS96emUrlaSht9U4RcjYoZsCTfICeFxV5bbzyLn1ubKES6MHhU5AU4/k4mb0vFuuaeO+oZVos/26HwFStfeEW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491768; c=relaxed/simple;
	bh=CYiktoIvRH/1Rf8lck9HtXa/tnswxedNLFxQ+ruqXoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF9tRCZpfK87q+FOJ5bqPS+XqON3b6gnK67IAjQRxxkrBwNf7fJ25tBuLT7fedevHl1UnvWvYBOuB89cqC0KAtNhEUKsn//iXGwZkTGGWrr5/ykXPXU85MfxPfmZcHyIBAhkRYJt0nL2XwTIqg0b7+c40p3r3nbsn7eWVerUdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akqzS7Od; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akqzS7Od"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737491766; x=1769027766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CYiktoIvRH/1Rf8lck9HtXa/tnswxedNLFxQ+ruqXoI=;
  b=akqzS7OdpQ0tXUZuBUQvisVxLmBN3MVVm7tBOx+AiSNwKE9kBZ+FbgvA
   MOcLJTIK3ErZByPGl2/qUnbZCc1pttNLxnAmOa+7ilYDNe3w5rENjxORO
   iw4aZzE52CxPP4c3V4YvqHnVXH2ni4IzKIqNrp8oktLdsvno4UyOLfhaa
   5fuMhMUfJGxrRGYtzOdDUnOT9ZiAjZsLEFNxoxJwJ81NVlNErTU/D5Z7T
   94TxtArjbQ2wYqVor1Isj8aRbRR3hNHu7kpnXUdTTMmaNFaZ/lRTzeI4b
   Ch2n4Junn1CvZw4nAmQtiHUFhxQkybm6H3g8AaOtXMXue8d1ClWJ88zt0
   g==;
X-CSE-ConnectionGUID: qL38fytIR8iffHHLVoNDCQ==
X-CSE-MsgGUID: hheek/plQieeHrcagWKaCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37801431"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="37801431"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:36:06 -0800
X-CSE-ConnectionGUID: KRCWtFxnQvuskk0IXtnnwQ==
X-CSE-MsgGUID: ex7/A1DOQIamG5W4GeB9/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="107458819"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.245.238])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:36:02 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 2/4 v2] cxl/core: Add helpers to detect Low memory Holes on x86
Date: Tue, 21 Jan 2025 21:35:57 +0100
Message-ID: <2871231.lGaqSPkdTl@fdefranc-mobl3>
In-Reply-To: <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
References:
 <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
 <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>
 <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, January 15, 2025 3:23:36=E2=80=AFAM GMT+1 Gregory Price wrote:
> On Tue, Jan 14, 2025 at 09:32:54PM +0100, Fabio M. De Francesco wrote:
> > +/*
> > + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA range=
s.
> > + *
> > + * On x86, CFMWS ranges never intersect memory holes while endpoint de=
coders
> > + * HPA range sizes are always guaranteed aligned to NIW * 256MB; there=
fore,
> > + * the given endpoint decoder HPA range size is always expected aligne=
d and
> > + * also larger than that of the matching root decoder. If there are LM=
H's,
> > + * the root decoder range end is always less than SZ_4G.
> > + */
>=20
> Is there any reason to limit this memory-hole handling to only low
> memory holes?=20
>
No I don't see any special reasons to limit this to only low memory holes.
It's just that I didn't know about others.
>
> I have observed systems where the following memory
> hole situation occurs:
>=20
> (example, not exact sizes)
> CFMW1:   [  0xc0000000 - 0xdfffffff  ] 512MB range
> Reserved [  0xe0000000 - 0xffffffff  ] 512MB range
> CFMW2:   [ 0x100000000 - 0x15fffffff ] 1.5GB range
>=20
> 2 CXL Memory Devices w/ 1GB capacity each (again, an example).
>=20
> Note that 1 device has its capacity split across the hole, but
> if the devices are interleaved then both devices have their capacity
> split across the hole.
>=20
> It seems with some mild modification, this patch set could be
> re-used to handle this memory hole scenario as well
> (w/ addr translation - Robert's patch set)
>=20
> Is there a reason not to handle more than just LMH's in this set?
>=20
> (I may try to hack this up on my test system and report back.)
>
I'd appreciate it if you want to report back.

Thank you,

=46abio
>=20
> ~Gregory
>=20




