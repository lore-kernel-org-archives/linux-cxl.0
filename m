Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699331ED8B;
	Fri, 11 Sep 2026 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166705; cv=none; b=ey9qjuG5Z3/v6L6SbB2MKOkyRHpAN0fcAS6iS8NPOWQ6rA1oQxYo8bjnzyv3AaaBlwPeHYifMAwTnD53PkSEzGLziDtc9uLxN+RhULrNs/wpewnZI8OQFEWqMA79w0R+U2Q18As3kzG6NwQ9dwrZFlWGPRS87qGnr54y/1I99B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166705; c=relaxed/simple;
	bh=eaEw9dAfOe9GRme2vp8jsXJRAd+TRBXiaVXdpjfCq4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgkhIIALi20606o/dbyK53zYNT9iE43E1RrcIlogPHzWfTb7oSyQTNZsMfsyLM76HLjRp96lJhigf4zFLXJyhKXaKM0fs1ly5M/AT1RS5iB24zUdowfwmV1S/pZXL8UNOY0LLPzuJU6V7UM2r09E7U0wE6HzfMzuv84Z1o5VG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH9juhI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH9juhI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A981F000FF;
	Fri, 11 Sep 2026 22:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789166703;
	bh=AB8gY/fLreiNq9lPrYKI4/EiUBUIrloOiUftuT2w1sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GH9juhI86QjUvU1pm4IZF1sbFKaLbdxRZdfWMaKcy5mJ6OQIRLtRFzxThSWFClk44
	 XMPJVXSe3oVu7cp/oqOVpf95+amQRwevfgk0eF0ZC9roNN1ywxsSUZ/+h3CG+8iJhN
	 16qq+dJ+mQOY8rgBFaY5/gmz9BKsw1DVliUWSWb04bsrHYUDsSEQNaEYUSEoGx/IWW
	 jryCLsXWOrYB+ZyqybtnhkHf21qzybhXBEFpnpvmL71TccRXTT8KMhKDy8i93VdDqz
	 +jVOtws3IrsQDRQ8pRKgqcbBSS71EV4XbIztoVjKt1pNCoxRyTs4eKw6FcCQF82IKB
	 kFkM2VGUM3V9w==
Date: Fri, 11 Sep 2026 23:44:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH] cxl/features: Ensure that count is set before
 access to end[] __counted_by()
Message-ID: <20260911234457.7be8f66d@jic23-hlaptop>
In-Reply-To: <6a5c975c-764f-4af7-8aa3-9dea94ad603f@intel.com>
References: <20260911215304.1816467-1-ashok.raj@oss.qualcomm.com>
	<6a5c975c-764f-4af7-8aa3-9dea94ad603f@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 14:58:29 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

Typo in patch title end/ent[]

(might be mine given I suggested a title to Ashok during internal review!)

Hopefully Dave won't mind fixing that whilst picking it up.

> On 9/11/26 2:53 PM, Ashok Raj wrote:
> > get_supported_features() assigns entries->num_features only after the
> > memcpy() loop that fills entries->ent[] has already run. Since ent[]
> > is __counted_by(num_features), the compiler's bounds instrumentation
> > sees a 0-length array during that loop and FORTIFY_SOURCE trips on
> > the memcpy. Set @num_features right after allocation, before any
> > write into ent[], so the bound is correct for the whole lifetime of
> > the array.
> > 
> > This was found via a fortify panic:
> > 
> >  memcpy: detected buffer overflow: 384 byte write of buffer size 0
> >  WARNING: lib/string_helpers.c:1035 at __fortify_report+0x54/0xa0
> >  kernel BUG at lib/string_helpers.c:1043!
> >  Call trace:
> >   __fortify_panic+0x10/0x18
> >   get_supported_features.isra.0+0x4a0/0x4d0 [cxl_core]
> >   devm_cxl_setup_features+0x84/0x120 [cxl_core]
> >   cxl_pci_probe+0x254/0x5e0 [cxl_pci]
> > 
> > Same class of bug, same fix shape as commit 6c9d2e87df40
> > ("cxl/fwctl: Fix __fortify_panic"), which fixed the analogous issue
> > in cxlctl_get_supported_features() but missed this one.
> > 
> > Fixes: f0e6a2329bf9 ("cxl: Add Get Supported Features command for kernel usage")
> > Signed-off-by: Ashok Raj <ashok.raj@oss.qualcomm.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
