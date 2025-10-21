Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A133B95F
	for <linux-cxl@vger.kernel.org>; Tue, 21 Oct 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055408; cv=none; b=kmWJ5+QF+SM5JwQt9Ig35LAkHAMFcJ2ODx7brDpuK5XMldlDJCjJALxUaHfXKALEMKR4UPnhJbGdt9M8FhqGgVnpn+HQ0tTs7rexvTE9kn/hkNWgePzfzON/Z59kQZMC7t08cuiHuuSjHn5v0rSUN4ZNI1U+XCij2/gvUD8jSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055408; c=relaxed/simple;
	bh=kZdmGDrH12a2NZe71q/RdHKraO/fpesXMJWU6nqEF3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siWXcGWYlxM3JxZjPmnfFUc6nzSScfpU4hPCIOrVh2uMIj0VcSSgnXDPyA8Qup4UtULft0uQ811UCIcwE2DLw2qGjBQIBoAC9BUWoTmFAKePtE/vaxyCcPXFJau2hckePUvEn7gdgA2oYRirr/ziPT19xsu4XEGa8EU321srXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lS5sJkQG; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lS5sJkQG"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78f30dac856so79869496d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Oct 2025 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761055405; x=1761660205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ydk0vuN1pviEYysaSWh5db6r1AHK7bIxN+bfh1ELr20=;
        b=lS5sJkQG7i2n3ZoBlUS+6MyD9ZeeFQHH8dxdVmRrzlIDlnDpOg6ebTIf5GKFxcHd6X
         k1YmSBulupMSSqLzJH0ERHp1gnyZAtSQXotUHBubuGEp/rWCr4H+HPNCsYsMHgCWybJz
         0hQkLNqT2cX9jVVHUckeWURtmSgykKAURbLx7T6ZJ1rCeApZY/itAZklZiOl5t7EfB87
         C2vhLlHGoLNzO5nJ0B7B7zcXzht9YYhZP1CUjDTzpBPV4eMkags2D/8vVq1bwh7wp6V5
         vA1uzjdNjd+MGPY5owxK/BknFD+ouXV1Q7348UGnPDRomFvLz8rJLjknhUQbTPH56sAm
         SRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055405; x=1761660205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydk0vuN1pviEYysaSWh5db6r1AHK7bIxN+bfh1ELr20=;
        b=REdydgKR3wGTjhr3ClcL1oH+M2RefunIW+4vcZB1x2VfaTNjNDbeFGZctK4Nhjfkvd
         dtYQrkImLpB0vIhOnLDLpiPbhskm2YaiQrYkMpOm8CarP1t8r3kgSttJEam7OVxz7Lz+
         yTvSHZ/Ez9gDYwa1GB7GJ5FwP1cSCALwzb4el9eqPzGzT5n4gSBobeUQw2O30xpCjndg
         VArCNN8vaJt62O7LJak3AgA2tVM6mIvI/+TvjL9keDxQBoeg3BK5Osm2J7LM005bx22O
         racWe7WQ2losYdZMBwWnElbea/g5mk7lly/GIIedTwAlJCZuFdYe19YCrppUj+Y7F68B
         TXXw==
X-Forwarded-Encrypted: i=1; AJvYcCVIMqcpth3iO57csi47Uph4oaEjvP+Egj9TcbFRmBTl8wFtNF2LwApQG5Cb6nzERO29/KAF68yylqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZzDHWzeJQ376gQyxBR0Tk0secV9pFeXfXXDHMqf5z5D3KlxPI
	V+eaMHr70L/RcpNT8UiCzqucKBVgY5OLiGDNETI19pN3RmyQLCVd4HTADFt6IjrQrYk=
X-Gm-Gg: ASbGncv+M78tGLwwS2eeRYVv1mFKhaNhp8Pg3ZYilavnXOaJMyJHKPA2aq6pOfamSRg
	M4soFJ9DWq7OvDsC/h84D+Npjz/tBcJvH0ItiFI3nd9VNZg+d/pSDTjwmysXVI/osSuYXVMDTm2
	VML0/jcxtwIwjEODVUyrC8iCbOsSRiZemVm7s66LalzeqBJdMhQJ/L6dRrh7f4y+S2jUkE5iIAS
	2ysRnPO0LlucOfYeSwZKt2C7/eIbj8Bk7T7r0fTWrNLjVbh0GS9EKAZ3WcA+gVgM7XkyGX3Azmm
	jy9PlmT525/d2egsjGLodcci1KL1fFWFt7chVZNODt814Z0pYatPOI68jc4swmWrV5tRh/5R4Ja
	NNHHega1OePzeVzHHa78F49LsqMrrUGkdZ6NSBU65CkpxPh8NAGbKdbatO1qbPxfvpJF+RLo2Wp
	zT0Gxbwr0bUyQyEZDvR5Fd1Gn5ZHhwIS8iitIc/kU0gR39WSAunHVAE+lOIjvi71Yts4zF3g==
X-Google-Smtp-Source: AGHT+IFuvXAl6TgoeI8SEbMMuK3HQIQ3jXEpVj4KF/jqZKlxNoovA4Y6fEZz3/6cxcExo+Slqui1+g==
X-Received: by 2002:a05:6214:2485:b0:7fd:2bc6:6cad with SMTP id 6a1803df08f44-87c20542e53mr243018526d6.10.1761055404384;
        Tue, 21 Oct 2025 07:03:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm69248486d6.49.2025.10.21.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:03:23 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:03:22 -0400
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Message-ID: <aPeSqjqU6BH9gvcw@gourry-fedora-PF4VCD3F>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
 <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
 <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
 <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>

On Mon, Oct 20, 2025 at 12:30:21PM -0700, Alison Schofield wrote:
> On Mon, Oct 20, 2025 at 10:19:09AM -0400, Gregory Price wrote:
> > On Mon, Oct 20, 2025 at 12:09:34AM -0700, Alison Schofield wrote:
> > > > This patch updates cxl_test to enable decoders 1 and 2
> > > > in the host-bridge 0 port, in a switch uport under hb0,
> > > > and the endpoints ports with size zero simulating
> > > > committed zero sized decoders.
> > > 
> > > Decoders 1 & 2 - those are after decoder 0, the autoregion.
> > > That's a problem ATM, when we try to teardown the autoregion we
> > > get out of order resets. Like I asked in the other patch, if there
> > > are rules about where these zero size decoders may appear, that
> > > may make the solution here simpler.
> > > 
> > 
> > I think this is going to require a quirk-doc like other deviations.
> 
> Really need to hear more about spec here. You mention quirk, but is it
> really a quirk or spec defined behavior?
>

Quoted below.  Small bit of ambiguity around base=[X] when size=0.

There's no requirement on base for a size=0 decoder, so it sort of implies
the base is ignored - except that the normal commit requires (base+size)
checks on decoder[m]/[m+1] without discussing size=0 decoders.

So while the spec doesn't say the base in a 0-size decoder base address
must be set, if you implement the logic here trivially you will always
fail if the zero-size decoder.base=0.

Note that 14.13.9 also doesn't say firmware must enforce commit-order,
so deviant software could go off and commit decoders out of order.

All the spec says is "If software intends to set Lock On Commit,
Software must configure the decoders in order".

~Gregory


------------------------------------------

Re commit order - Vishal said they do post-lock order
https://lore.kernel.org/linux-cxl/aOP3Kr3jHLWOydRp@gourry-fedora-PF4VCD3F/

Post-lock order
[programmable] [zero-lock] [zero-lock] ... [zero-lock]

Pre-lock order:
[zero-lock] [zero-lock] ... [zero-lock] [programmable]

My reading of the spec suggests that Post-lock ordering is *not legal*,
and would suggest the software has deviated from the spec - which does
not allow for size-zero decoders to ignore commit order.

------------------------------------------
8.2.4.20.12: Committing Decoder Programming

If Software intends to set Lock On Commit, Software must configure the
decoders in order. In other words, decoder m must be configured and
committed before decoder m+1 for all values of m.

Decoder m must cover an HPA range that is below decoder m+1.

...

It is legal for software to program Decoder Size to 0 and commit it. Such a decoder will
not participate in HDM decode.

------------------------------------------
14.13.10: CXL HDM Decoder Zero Size Commit

Test Steps:
  1. Program 0 in the Decoder[m].Size register.
  2. Set the Commit bit in the Decoder[m].Control register.

Pass Criteria:
  • Committed bit in the Decoder[m].Control register is set
  • Error Not Committed bit in the Decoder[].Control register is not set

Fail Conditions:
  • Committed bit in the Decoder[m].Control register is not set within 10 ms
  • Error Not Committed bit in the Decoder[m].Control register is set

------------------------------------------
14.13.9 CXL HDM Decoder Commit

Test Steps:
  1. Program an address range in the Decoder[m+1].Base and Decoder[m+1].Size
     registers such that:

     — Decoder[m+1].Base >= (Decoder[m].Base+Decoder[m].Size), and
     — Decoder[m+1].Base <= Decoder[m+1].Base+Decoder[m+1].Size
