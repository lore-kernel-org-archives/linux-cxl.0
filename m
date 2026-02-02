Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D52638BC
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054390; cv=none; b=c/mDB/EexG7peJrAbmei3iiKDz1BAK4j3T7Oqvmz7xxReMm7md/iQNYRA4V/uF90BjCJ6wUi4DiewUdh7IHBPvzV4KsWNYjsyTsSaUOErE7qFLec4fImq07t6iedUnNzf/1J5F7a0NRK2puSJQG59CQgSCT9YbkdBz2R809b38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054390; c=relaxed/simple;
	bh=gL8uCUJiJhHkiRNkyf53CfWI8RBSbR1NS4lJMuLRlY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df7QNUjI4FuKJffbZbHRk0BwOZr4lHAJ/w7ydRl0xWFSL26k5Mp4h1LF54UN9q8jl86s4kVLK5m7MrnUfsdA0x/W889cvNg0wlyx5cEQUZCI4z5AH2DYYCSMoYKToXOgyLRQ/0cFpb1kf4uClO9EDbTbQvmtuA/wKkg88mE5pjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FhaemJHj; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FhaemJHj"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c7199e7f79so742438885a.0
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770054388; x=1770659188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1wm0NexTqa+iJZbv1CobgpMNsP/JgzOw/JXCIX3sf8=;
        b=FhaemJHj8nP4Xz0vsAeScEVMy7SHVg4mSlhJ59pasSiPnQ5mddAFKvsyV+d2mDoBZA
         eGJbg4Z9pOFim4xE85y0R5Di6iXbDAMFGcf+R2zIIby0Ygf1Owvs8u2+/HW7ILjsxF9g
         G1NeQO4b1NF9FmTXTX9W5w6Dlm7u266be99eQYKILV+t//GFuw2QT1fjyrrItMU44720
         8+SVPhMn522jFPRb8ew86WTIa6NUkmZf1cThnHp78YLtdVMoAsnGnjxrQWugfuPtgMLJ
         79IClZ+ie0w4kg5umbGLa13+m/pBRbCg+muFlFv3iRy9jT1PpVVy83NsQu+xd8IrBgzr
         4IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054388; x=1770659188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1wm0NexTqa+iJZbv1CobgpMNsP/JgzOw/JXCIX3sf8=;
        b=l0ETSq4ilWHGon+ppR8cSSjTvFTunNJy445r10pBSBC3W6oJv25DMLLDkDqJVs5cep
         bxlFZ2Kixo+JmLPodWCFhP70FpX5j6iSURqUxEfr5r6e4gGd513wK5Gctexobc81SloC
         k9ygy6+ilGToMcRllrcqT9xwsYZI5n0RA+OcC4n8kc+aFqV7Ebdyr2zaHO2twiIcAoYV
         C/lLOUNN8QWTL99IMEIgq/ssRXcKyTn2ecrCPp4Gn24ErLBZc5VJ9RXnFfBvNDEeojxX
         rREsV1Ev1BYvJrXddaZuOi8fOiH/UdwIrToP08i5SRhyDWh4z/8lEKitjTGYpkaFukT0
         Gihg==
X-Forwarded-Encrypted: i=1; AJvYcCWkjalFMU5KcU4Uj4KXGwDONtJs6arQI68rMv+EsXFZv76isAhq16A55rSJCRLMliowpcMObHukfcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRG3e6hXtGd5avTyfIcgGdHk8n0ZKYVy3ccFlS3AHHZ9UxNZa
	SIhLc8Q6s1a8HktKwvc4RJvVmONFcbc8W8Znic5M0ajhSZBUaA3RT8dfaesC0hHo0Dk=
X-Gm-Gg: AZuq6aJwnSu0kFSHiwJpqhSwrlq1PBv6ewRTWEGKBB+Cq1ifRGJ8LZWbMEgB0Nl8Ubp
	iAUI3FEUzJyAy2Iwv+Mq8k5KzZ0fmwEb/ZniJ4aAJPxjFgq6x2F0F07b3lvPMeEmMAeaEKgTbWK
	NFFVhffNJ7HZ5IlxnxCJ3WnTxW2c1hvU2M36PiAZ77XfWonou0z3IABof1sneGQQcQLb7BzVse0
	V0LONNtMfvOirBNqc38l9oWB8CuAANeTjNmln98TPT2Lrv+Ux0LsVNzFGZqm5wK/KTu3B3CFy4L
	+fBVx3TWm7rKjYFnwaTmTRJUORz4GrJoxVJD2n7OB805NT/2wbqfllI9RRO9DtcmWHAfIyneolQ
	P81wJjr7/sCpm8RW9I4b5oac+qK+aSgTKqvIqFKOI013y2EB8MMp/ynCL4rIFpwEg8x8mu1iB6X
	vayB0udUIXpfQr903UXkHfj1jGvUmTQiE+l1//eZpK0Gg0XwzvFJRK10lOIZg+RzmJ13t7wzVk5
	jE7vR8n
X-Received: by 2002:a05:6214:c8f:b0:888:4930:82aa with SMTP id 6a1803df08f44-894ea166512mr179211126d6.70.1770054387847;
        Mon, 02 Feb 2026 09:46:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d47e13sm1267680485a.45.2026.02.02.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:46:27 -0800 (PST)
Date: Mon, 2 Feb 2026 12:46:25 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH 1/9] mm/memory_hotplug: pass online_type to
 online_memory_block() via arg
Message-ID: <aYDi8bhxFnvMWl11@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-2-gourry@gourry.net>
 <20260202171029.00005e80@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202171029.00005e80@huawei.com>

On Mon, Feb 02, 2026 at 05:10:29PM +0000, Jonathan Cameron wrote:
> On Thu, 29 Jan 2026 16:04:34 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > Modify online_memory_block() to accept the online type through its arg
> > parameter rather than calling mhp_get_default_online_type() internally.
> > This prepares for allowing callers to specify explicit online types.
> > 
> > Update the caller in add_memory_resource() to pass the default online
> > type via a local variable.
> > 
> > No functional change.
> > 
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Trivial comment inline. I don't really care either way.
> Pushing the policy up to the caller and ensuring it's explicitly constant
> for all the memory blocks (as opposed to relying on locks) seems sensible to me
> even without anything else.
> 
> >  
> >  	/* online pages if requested */
> > -	if (mhp_get_default_online_type() != MMOP_OFFLINE)
> > -		walk_memory_blocks(start, size, NULL, online_memory_block);
> > +	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
> > +		int online_type = mhp_get_default_online_type();
> 
> Maybe move the local variable outside the loop to avoid the double call.
> 

ack.  will update for next version w/ Ben's notes and the build fix.

Thanks!
~Gregory
