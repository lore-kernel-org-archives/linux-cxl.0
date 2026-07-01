Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA240F8D5
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918358; cv=none; b=I1rqCorNsO4cREM1Wv6zxbLeD8TrG2BMMD5msE21Y1t/dum0XlEQH824ACVoqEmbjFwTr5oPBqvp+JoXvu0J4J75hfvzmRxXuA0PcayO1NmMz5IcoTOMsCKRnRJlIC7OhOGuJ9AaloJUztCupjD/Mu5TH3m5uBrNj0fYYrSdQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918358; c=relaxed/simple;
	bh=O0/sSc5djxu9BW4d0paJyrvzS2rEhgQcnkyzbEMKO70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqVyQbZN1EuYWsKExD7sY6YUp2GVy6j7m17jWKr/+baYY+MmBB6JnQ+gaVxqm1n3Dq6RSPqGvhPhgXmGaUnIuvvPK7fv5wJDm0LjPszGJ8DlAKOboI+YtrelY3PbZeGCaQ5SG93ZocLlzgnP4Ms+kSApsdCk0y97anwODcbSnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NmFKauRv; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NmFKauRv"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7fe36f1be74so11199237b3.2
        for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782918354; x=1783523154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpcsb0+VdxshQ15XkMHrH6lVO/I8qddArljRZWvFEt8=;
        b=NmFKauRvkFHupjJtQ7IXa8B2he+S4I1eRiwnc+RdxFwoaPxIWcK1Qw6eMPtY/OSBKz
         zsW3JwO8CqlzXLs9wTN33qSGWgkbsZxolUzOzIWS3n4Eo/L1RXOdu69SAlwXk98YhEB1
         Y1i75xs6bY9hz8B6wj/8FSJRFYsqGVPutDRWRcQAzkaVifETFIL151Qh/EyZVnD36ewY
         AwKqK9liyvV+3orIhEyEu4I+WP5AgTZpYQ1web9Ql4p1Gtwd+3QMynLw2wfIhDCiRS0S
         l2kY1QYW4f5xQoNPZZGgRDRuX+I35dwp911Xm28HB5u4+7YHkK97HrmVyz2ZBjQfKMNY
         YJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918354; x=1783523154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wpcsb0+VdxshQ15XkMHrH6lVO/I8qddArljRZWvFEt8=;
        b=QME4d0LMS1np4qeKzD+Af79q/Ovd4Zrgp/+fZsAWXu3/0EiEgVQv5enol0CFVOCGyC
         8I+F2CrALEgib25fB1h0aS6J+XVp5vTD8LKTgVhd020zV62gz4RdTNpG0eE7Op1JKX/R
         GZVnDhZD5P+ypbhyzP3xjP5AMEkqexo+ahRRYyt5glymEvEVmJEnR/7wSTZC0FHiS9Ai
         3LYcgqxG0jtpHSy7o16WogkQHKCp5KQx5X3/JgeNSBXl5oLqvywB0KKuXJJ/n3B+PWCz
         Eh2xAHoUOwSyb0aeCCOm9+DGkEmSSUjHZrtf7jzL+SNiCv4pYxYyiyerOJoGE0hsSEyO
         OTpw==
X-Forwarded-Encrypted: i=1; AHgh+Rr36WS+BAj2lypYZBkJICRFElzieJA/qqoxpS7y2h6xHwwTIULEqS49XpjTQWH2smaH/qQ5dnk4OuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNLMjfz7iBkwxAMyoBaF+9Xy83ut00CwBTNIlarevcEKvtFnI
	Ai/jiIfuItKOT4cV/fEzV/FoVCIm13heuStQYsDCMlhh4ZMUbJzPcSvC0VssJXvrVoD9i4AYT+z
	yh83K
X-Gm-Gg: AfdE7ckuYPErvpgRAzl83NSaRsGNoMeSEdTM0CC1dMzD4jPOTaRIqTxwQHESP9Cj5dU
	AffAN9Q/Iyst+SRdcBawBEC7bATDy8mBFAXq8Eajvg6HxyDEZ3SBskrK7HV1voTWyuCkJESHRro
	/q9hpjlATjdvIvbNCXSVdIXUTB0+GAVPhB6Q4UjHSrgqD2Z8ejZUDfYVuGK14c/z/EMKkqRdMEN
	ZyAzEYbQus61hyvO791CAd9h8SIQs2Bd2n24srn942CxrP51KqVBQqhwQI9QorbU9+rjKKYljUP
	5pmyL1lnrnzcP9C87lmUqQf/h5DGjjURW3IfTuIJhIUzGucl168PGL7B2Jc36npa+pDRPteQqKV
	IMgeFfdpdlubIglU4Lyp1HH9nxySlTMErPtJOTnFyDux+DIGUTEyR6CvcgewN8CtdfXY/quX/26
	+PohuqvIDMEiVFdGJLjF1YhiFKDEDFJ1hflil9JpxMA2w2rIMO9DbQdVJUU0qq7+d3pInb
X-Received: by 2002:a05:690c:6906:b0:80b:968:29ff with SMTP id 00721157ae682-812eb86e8ecmr20804517b3.53.1782918353875;
        Wed, 01 Jul 2026 08:05:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3611d783bsm23143586d6.28.2026.07.01.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:05:53 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:05:48 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com, osalvador@suse.de,
	akpm@linux-foundation.org, rppt@kernel.org,
	mgorman@techsingularity.net, hannes@cmpxchg.org, vbabka@kernel.org
Subject: Re: [PATCH] mm/mm_init: handle alloc_percpu failure in
 free_area_init_core_hotplug
Message-ID: <akUszCySPFA7IRlb@gourry-fedora-PF4VCD3F>
References: <20260630214039.2263562-1-gourry@gourry.net>
 <b8baae33-d551-40fe-abb5-287f3711dd80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8baae33-d551-40fe-abb5-287f3711dd80@kernel.org>

On Wed, Jul 01, 2026 at 10:35:41AM +0200, David Hildenbrand (Arm) wrote:
> 
> >  	 * The node we allocated has no zone fallback lists. For avoiding
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 306ea5c13f54..37fd64ce144d 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1536,7 +1536,7 @@ void __init set_pageblock_order(void)
> >   * NOTE: this function is only called during memory hotplug
> >   */
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > -void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
> > +int __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
> >  {
> >  	int nid = pgdat->node_id;
> >  	enum zone_type z;
> > @@ -1544,8 +1544,14 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
> >  
> >  	pgdat_init_internals(pgdat);
> >  
> > -	if (pgdat->per_cpu_nodestats == &boot_nodestats)
> > -		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
> > +	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
> > +		struct per_cpu_nodestat __percpu *p;
> > +
> > +		p = alloc_percpu(struct per_cpu_nodestat);
> > +		if (!p)
> > +			return -ENOMEM;
> > +		pgdat->per_cpu_nodestats = p;
> 
> Is there a need for the temporary variable?
> 

at start:
    pgdat->per_cpu_nodestats = &boot_nodestats 

So need a tmp to do the swap/revert/etc

> Also how to handle cleanup on error? Or why can we skip cleanup? (what happens
> if we get another call to __try_online_node()  later?)
> 

-ENOMEM ->
    hotadd_init_pgdat -> NULL
        __try_online_node -> -ENOMEM
	    pr_err("Cannot online node %d due to NULL pgdat\n", nid);
	    try_online_node -> -ENOMEM
	        __add_memory_resource  ->  error_memblock_remove:

Basically we're left exactly where we were before we made the attempt.

Another call should work just fine after a bunch of dmesg spew.

If this happens during boot via add_memory then something else is
horribly horribly wrong and we'll at least get some debug info instead
of null deref.

~Gregory
