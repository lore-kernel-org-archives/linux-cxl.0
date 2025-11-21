Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071B258EFC;
	Fri, 21 Nov 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735377; cv=none; b=kDpS2z0SXfZ9iEPuS2GlhgpWEpPtzSA1FhcIaDuFRltn4+eExg7SvOPHy1Mo+CGEZULb61kJcfgrI7rU1mf9NayUjJueKMZyw6b6tDrP4jdH0oSOmGuxgLCQow67ctbhYdjr+ihUsbX2ER9MyQsGkqeEhbJOiVOLXlW6VNdU8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735377; c=relaxed/simple;
	bh=3OfGfA5k0SQMQLK6yZf111RZj4PIXK+J58sl3lls4EU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DpGNthVEGpom4UG9gl9uaHD3CAFD6cJ/5yG2YCB4MtbL5pNErzhaG84dbmhqjcuNHNKZZQEs8jOAU6e2dmXWWMxkvqkSUR+MxU6YsjEAeRhOdSzPKTTA728b8Tw1nwd85AC2AVtnDEYq0Mkp02ClpwVE6h4d2ZQWrSJXk4G6lBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZVr3j6Kf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZVr3j6Kf"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 561A340AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1763735374; bh=0sHB+wk48o30LKecOCZ9wjYB8AJN1ipBS1/r5bsYqy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZVr3j6KfxJTt7P+K3IiAZyZ+dDDgMc6sC9r160j4KSrHL3Xh7iXJqwn/GY/b90dQs
	 i4VjCLw6ofKNdGYyfcwtoV2BvBEtFybeU9DWMfRTYjbTtj1zdK1w1G815JImARUeFN
	 /uBd428VTEDuYCSZxo3hrs3/9B982BFSyq0MZwZb0TPI+lBEjKewYUtlVESL4xbDW5
	 g5bev33RrT3Urh/Go6CWX2z3RK5QZJaOVbfMdbK2EpBKcX6yux3XDWYjU7H5kaHgVn
	 WoFWayH5Ua2huoZb+RPNYPoWWpEwy6bd4kBxe8UAfPtWWr3SO09KOhQ6axKDfx9TDE
	 ltNbXPoQdmYkg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 561A340AED;
	Fri, 21 Nov 2025 14:29:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory Price
 <gourry@gourry.net>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
 <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Robert
 Richter <rrichter@amd.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 1/2] cxl, doc: Moving conventions in separate files
In-Reply-To: <20251121121655.338491-1-rrichter@amd.com>
References: <20251121121655.338491-1-rrichter@amd.com>
Date: Fri, 21 Nov 2025 07:29:33 -0700
Message-ID: <875xb3v4qa.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Robert Richter <rrichter@amd.com> writes:

A nit, but it's something that bugs me...

[...]

> new file mode 100644
> index 000000000000..3049c1f58f7d
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions/cxl-lmh.rst
> @@ -0,0 +1,136 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>

This include has been cargo-culted around the docs...the only real use
of it is to write |copy| rather than =C2=A9, but these docs don't even do
that.  It can be taken out.

Thanks,

jon
