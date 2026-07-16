Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2D38229A
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jul 2026 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784174899; cv=none; b=UoXO13kCV40bR9XHN+NIiOdi/dt1veGDu2ApOPYP6Vw6Y409WMuOYHvPUz8q2tc2ltsMS76dYJsEu2/i7PkKQnwnbSMdkAXGmat/XzHEKm3N14kzVY6aJyZII5CP5nqzapHpFlxugzw1Pe21E1EROZqOLKqAm+6j8KD3yEmb+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784174899; c=relaxed/simple;
	bh=R9xKCPWUV4jE/Y73zK46+N8T9xEUacgdX7igmryS87o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubPxoLsI3QwarbmpJEIUPBZ0kU4URQhXDtzgOpQkzA0ZBex9/MKsRaz+Ff18fr1Z8s+tt+MRXQtJaCzL+RFdVEQW/UPKFKFHCgadG7ORs8frcjCBLY6BYrc4njW/xkXTiRAavCSbr7BQYmOTpVku3F+jDaPHbYEEM3iaFCy41rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSF+tJi9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSF+tJi9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3811f512167so6726724a91.3
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 21:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784174897; x=1784779697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f9V0pZbsyulMpnH6R6OfoQOZz9JXss18PvQ1c2eqK3s=;
        b=hSF+tJi9sHaTyjGHe7o8/mx4qbfHsGGL9P7VbepRKLj2hba0+/ZMxp5uApB9zLpIqz
         HXo/dQQ1CmF9+7nhYGEKnFF5L9tIrMbPXHOE8J0rEwVSmcLlhMcq1bp0My5cFM41cDLU
         ESC6iwzS93TtirSRYhO8rwFMMm0hDBiXzQMeLj/EZhWgZtzPs99R8Z6e9zRg7Wo/xlU5
         Jpr5UI8CeSdQ6ejYaiWibZFU3Cbnj1z5j93HnGzIkY3fHRaQGLZTc+ry1aL09zcS0MkZ
         lI7DmWqeDUw6ykzpza4a/SgWw0Aw5lklPW2CSJBEt/svED8oX9JIAO/B1b6oXLKq6+WF
         Y2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784174897; x=1784779697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f9V0pZbsyulMpnH6R6OfoQOZz9JXss18PvQ1c2eqK3s=;
        b=nD01i4R3B3b4hYXrUqctdbNJsp5J1re1vX0UX2PiwzYvmtjNap29bHTR3fH08MI8Gj
         I+LRWvZmGMJ1U4ySyssbFjchc++IdzyK/7gc1drLGaPzkOQu7GgOgC7nTdyzXdEin1WF
         HZsW2HDVG5XzbTfjVt9OuER6XtvMXP0Yy+oRxO2AziOADe/9arr8t2MItS5QKFe/l9Ub
         nAI4A5oO06Ah1HbeHJC+6fl4BSHyVwYi/0sSsK0hohn1KRUGgzysmWCt5iH3dZTZ2vSd
         Hx1+r/4f1zFUTbCdVDvTbckZjT57j77iIc7w6Yc0ugPo/t43wIpLaqLOc8Bo2HEbrLOp
         ydtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rol/wiZdsGR2tiRvmGVjAFaP4KFizlWJnmAtrOUv1TB03+8AD2r6fbWdVc4Qh8msXURvVSBlVHcQGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29gUODmUW/bhRRyUY6irDmd9qITA6EEwIYCxKGW08XT6Fsd2e
	4LtJ+QwYhASKJXQQvHBzoTbTBIZo77p91mB6VnUwXjc61lQNtfsX0+D5
X-Gm-Gg: AfdE7cn/6nug8T51kxBXoDjPBuVlQyxIi59QB+BW7Y5J2sRHgUrlkU3phwQpgERb+of
	xsJvrpSeL+5S2sWgbdfqZDa+9ef9J3P3WzEJ0j4fzd2Bwyra+AYDoK08b9GtamansCquQK5rF32
	JUWrFXjOdkdA1+kQHrV8+fpTmucId3YOAvLTbRtv1jK2md7VE1CG6KNtmdap2MALEziXhCFTwMZ
	7bCvCVdpvt/SaRfNfObApx8kuhCd6IB+Fvc+00KRgsriEOhTwU5wAmmtSFPFWRUA7mp3tOKUQeq
	VuL2UbMUga2g8ylU3JkFDqpeCb8UljdkCrRiFZXguXT/m+dX21Gzp9mecIRBHX6F78o7AlZCV5u
	gji2ZHnTTG8SJeIt7rmb7pLrU/mmXDJRNa6O4T4AcukQ06NFT+wzIjYax8x/S2raNVboZ9MspVz
	ASIuCDoUY+6ta39vu8unw3sjcOUrM0I6VZ08h2Bwg4nrGA1ozdnM6lDcS5EQ==
X-Received: by 2002:a17:90b:254d:b0:38d:c0f9:30be with SMTP id 98e67ed59e1d1-38e1b012d38mr8272945a91.38.1784174897247;
        Wed, 15 Jul 2026 21:08:17 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6f0fcdsm6473974eec.30.2026.07.15.21.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 21:08:16 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 15 Jul 2026 21:08:14 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v11 12/31] cxl/mem: Set up framework for handling DC
 Events
Message-ID: <alhZLnHZgvRcOvO8@AnisaLaptop.localdomain>
References: <20260625112638.550691-1-anisa.su@samsung.com>
 <20260625112638.550691-13-anisa.su@samsung.com>
 <dc8155d9-df6a-444b-a954-dad2d59cf704@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc8155d9-df6a-444b-a954-dad2d59cf704@intel.com>

On Fri, Jun 26, 2026 at 02:54:43PM -0700, Dave Jiang wrote:
> 
> 
> On 6/25/26 4:04 AM, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Adds the support for receiving DC event records but defers
> > the real add/release logic to subsequent commits. Simply refuse all
> > extents for DC_ADD and ack all DC_RELEASE events for now. Forced
> > release is currently unsupported.
> > 
> > In order, this commit adds the following:
> > 
> > 1. Learn about DC Event Records and how to respond to them
> > 
> > * cxl_mem_get_event_records() learns about the DC Event record.
> > Records of that type are routed to cxl_handle_dcd_event_records().
> > 
> > * cxl_handle_dcd_event_records() switches on event_type:
> > 	- DCD_ADD_CAPACITY     -> handle_add_event()
> > 	- DCD_RELEASE_CAPACITY -> cxl_rm_extent()
> > 	- DCD_FORCED_CAPACITY_RELEASE is logged and ignored (FM/device-only).
> > 
> > * cxl_send_dc_response() sends the reply mailbox commands
> > ADD_DC_RESPONSE / RELEASE_DC
> > 
> > 2. Add stubs for DC_ADD and DC_RELEASE logic
> > 
> > * handle_add_event() stages incoming extents onto
> > mds->add_ctx.pending_extents and, when More=0 closes the chain,
> > replies with an empty ADD_DC_RESPONSE — refusing all extents for now
> > 
> > * cxl_rm_extent() acks the release via memdev_release_extent() so the
> > device's view stays consistent; we can ack all releases because
> > we currently don't accept/use any extents offered.
> > 
> > 3. Structural setup for later commits:
> > 
> > * struct dc_extent, struct cxl_dc_tag_group, and pending_add_ctx
> > set up the stage for the real DC_ADD path, which will enforce
> > tag/grouping semantics
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> 
> Just a minor comment below besides all the issues raised by sashiko
> 
Got it!

> 
> > 
> > +
[snip]

I also meant to ask in the last rev but I forgot: are these stub
comments useful or should I just get rid of them?

> > +/*
> > + * Stub: ack the release back to the device so it knows we are not
> > + * using the range.  A later commit replaces this with the real
> > + * teardown that walks the region's tag group and tears down the
> > + * member dc_extent devices.
> > + */
> > +static int cxl_rm_extent(struct cxl_memdev_state *mds,
> > +			 struct cxl_extent *extent)
> > +{
> > +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> > +	struct range dpa_range = {
> > +		.start = start_dpa,
> > +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> > +	};
> > +
> > +	memdev_release_extent(mds, &dpa_range);
> > +	return 0;
> > +}
> > +
> > +static char *cxl_dcd_evt_type_str(u8 type)
> 
> Should it return 'const char *' instead?
> 
Yes

> DJ
> 
Thanks,
Anisa

> > +{
> > +	switch (type) {
> > +	case DCD_ADD_CAPACITY:
> > +		return "add";
> > +	case DCD_RELEASE_CAPACITY:
> > +		return "release";
> > +	case DCD_FORCED_CAPACITY_RELEASE:
> > +		return "force release";
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return "<unknown>";
> > +}
> > +
[snip]
 
