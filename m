Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F2386C0A
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609035; cv=none; b=htnmaNzkggLeRMpSQ+UKQMNrWOlbI5EFvxfW0AO1Ec+Dzf5lu2SKcixfHmyBl5Ra4+OQRpVvTusheuYjjpI5temEFR4kQTavRdXfNdHShX/FfxPVFCNDSwrBsuUMcOOm2V98sS15R7H/mCinWONpqF9/Z/8PIGSWPOjyI5o8fFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609035; c=relaxed/simple;
	bh=tjgdvByW5WBZqyhrd7wFuCriBR6z1oBevpMfu6TVGNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG5aLTmTDBpUwLLdSRMtKbcFOyJwo5AXOXwYll1lqXSvxgD6JrJfO6Glub0DRW5Vm79HyB3uPFz1eIvJokvw8j/Gl0ErxUHtpxtSuQO599yU1/0ItSteEX22ARDjvyIxsgc61Wd2A1Qw8L1uTw25Y82E30Pjhq4dxqPP0Z+GsI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TCMqfGI7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TCMqfGI7"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso6529446d6.3
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783609033; x=1784213833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cUc0YxX2OnLyX2sI3kys65ZvVtk8+5Y5AOwoYWzDFOM=;
        b=TCMqfGI7JdxQTtJlHSthwI0j8quYtYJeY8RBzzPK2VfrMHMjRiALGQ0Eiuwwj2B7VC
         RWwy1xBBzHUCe+qvPWlHySd/VMdwpNS8BNo76mQeWipiYA5ILkD3oK6pzEkF3sEeZqjt
         QkqssvgxLUbqdGJvMT9oDSZ8G59SLH6XimKp+HJE0x4SPHQvK+xZDI01ClfeapABqG0m
         0Q8reXbl1XMca7Sxu4fDNtetFRtZGZW9I+6sll8tPglYtEklTIwrXkU8MHPl4NJejqx/
         MLV1fIWuYt8JQJlGPzlpxHF6yIYSrGsatFAiu9srMIJ8Pbg/IBt25xOCMDI2rQjW3dW2
         RVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609033; x=1784213833;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cUc0YxX2OnLyX2sI3kys65ZvVtk8+5Y5AOwoYWzDFOM=;
        b=dYQe0iA96CV6MLIq2S8HvEdznzfiSmI3wmKzquRYL0tzPUjZeuh/cMUfDET/hN/jyj
         SVOYA8OQ5Xtod2t4CPpatORh5OpOuXum/iZB4S3f+0xrUpQOia1u4JnJn8E2UlhWLWKm
         rE0vnYh+zuXb9VsNAyPiX6DPeqm7Qa39eesoLR3Wgjx7wROmAkgFaFxmR08SwUhPr4s9
         qas77ikziA3kDdo7q93cTdlYjnvTSLgLlF/9jKPj30MJtSx6KZe3f4zKttMo4MqFOSD/
         8mnTi54Vy+S6j0Yho6zS4i0ucAIuwsc3beDkW/+S+ehtivMF6OpzwZgIf8XtbZ7wPq3k
         h4hg==
X-Forwarded-Encrypted: i=1; AHgh+RoAGONJFQ6u+ef34GYx1xIf+Ep8yhsZLRjHMfb7xh/PX8rTwAIGVwaB4TdNvoanhtkTGOu/nMSeAwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnvc7J3dFXDOjmOvJsC5XsUtuQ/x1ToA+1QmmCTTpmbn5YXF7C
	6h7dnu3ZBcNNZHFyXhQkCMMd8SxXToVuZKLuazbT80T5z9qFEiSsLUupq+yaNucyWwI=
X-Gm-Gg: AfdE7clMOaPrVy96Z+RpprPZNIHamgQ12gCWXwhCZP+SA95RQu9xA/uV6a5HrMLMOh2
	9xxXuM1pu0fEf2rV2gRrhXvDds+7hLewbSjxziN7zA/Jhw8UsU42srIm0hiAeFmIZGkCdHggmVV
	kHopOP15sbjwkUlyA+56KyNQE3be3wULN/Uo2nCZKJSMrqrdCVPcL5380eoE0ofGhClAuXstuSH
	wR45FEV22Hqa+uLIl2RYgBGXjCNEih/YjZYPnyh2zyrQGQf50APti/ecF4/ngskRPaJ8eN8qRnf
	KJmUIJTOAEI6GndGJ9hCBraUJsLlY7YM2a7fCN7H02D87Z0RtPZonyuWL67PY+cAygZrCLBshNI
	E4w65dBOoT1/eOwu0bSmY7GXrEmWRR9OfPNwMnuffwfdbhKvhwmnWMLhK5bLcCD9qGOq6sDJCxq
	KbOTzGbEjwR/E3axxBb8bio6DRy7TJQV3jxY4OgSsCFP0oihDA49d6JJ5fPqfCVYB1HNjN
X-Received: by 2002:a05:620a:460f:b0:92d:e54e:72db with SMTP id af79cd13be357-92ecf54a01bmr728326285a.22.1783609032712;
        Thu, 09 Jul 2026 07:57:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cedfe0sm1725553985a.43.2026.07.09.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:57:12 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:57:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 09/10] dax/kmem: add sysfs interface for atomic
 whole-device hotplug
Message-ID: <ak-2w-aHp5huBa2N@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-10-gourry@gourry.net>
 <ak9TSx-I-53dX6fx@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak9TSx-I-53dX6fx@MWDK4CY14F>

On Thu, Jul 09, 2026 at 04:07:31PM +0800, Richard Cheng wrote:
> > +	if (dax_kmem_state_is_online(data->state)) {
> > +		dev_warn(dev, "Hotplug regions stuck online until reboot\n");
> > +		any_hotremove_failed = true;
> > +		return;
> 
> Hi Gregory,
> 
> I suppose data->state is only updated when writing to the new daxX.Y/state file?
> If the blocks are offlined through the old per-block interface, data->state
> still says online and we will hit this early return.
> Everything is leaked and a later rebind fails -EBUSY.
> 
> Current behavior is using remove_memory(), and it succeeds on offlined blocks
> and fails safely with -EBUSY on online ones, no offlining from unbind context
> either way.
> 
> Your changelog state "on unbind fallback to legacy if still online", but the
> fallback only runs for data->state == MMOP_OFFLINE.
> Maybe drop this early return and just try dax_kmem_remove_ranges() here too?
> 

Hm, I think you are right.  When doing some testing I bounced between
tests which race with dax/state and block/state, and I missed the
obvious case of the whole device being offline but dax/state being stale.

I think this entire chunk actually just drops to:

dax_kmem_remove_ranges(dev_dax, data);

And the internal error catches the condition to the log.

Thanks! I will spin a new version next week.

~Gregory
