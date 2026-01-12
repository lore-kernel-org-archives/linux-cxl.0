Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438831B131
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246100; cv=none; b=hhfeT6VzK9RbFH07rnzTpAt/MC5iCSQb+xEJ2ge9jrhWCfAPFN2ozMbIhDmSWW5eNDetN8i4FYGrjItM+OUInus7zmgPL4YbmkUaPbxAPvXvA0sJDV/Blqs7QZZtPx9wBBAUt6pQvReU+B79ruxp7Pd23RA0yxqIBv9JM4T50JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246100; c=relaxed/simple;
	bh=shxmX2+HmXmALgYV4I/T+QoVuAHA2Vhig6RTaEDJOds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzVu2+UgsfXUzLd9dPtN/znyGGscYZKxmm6Hkqv5C0A4r5AbGMb0M6ZfSYv86rbf7PmSJ+iryAVVMUgu/BJLT/EfQlzDsZ8pfwK5toN5WgBGNKNzHCtSe4+RX3DjsOZ+3rYfx8W+MEWko0/5gj3T5kQ2VRbQtWx+BomvBbiDxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pMnuPJ9A; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pMnuPJ9A"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2d6df99c5so584942385a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768246098; x=1768850898; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a9AdLI7uJUYtOYd89GixDifcE7N5970uW2swaB6ncSw=;
        b=pMnuPJ9A29sI3cWXfL3AcdhcYCbp5QX64v+VQQdObhNgHqPse++jj/lwWWU4Ot/o0L
         ptMMa5o08J8HeJp0iuLYJu4C+et1bBsiHqAqFIvCnT2jJ4ZG9Z4HFAZolq40731tJgYR
         GIJiYA09Jj8QTQMUlYp4dBqT3UbEnz1VhJE/IW8MoT9ueNAASvDJmCKaX408UqP9afJv
         P0EIWDjjT3k7iv+UTZO9m6KL7XquMEtRxKW/ntn/MMdJXSqV2RdUAWGbi+YrvVYqC2qd
         kZjwAZMSfUaAUrYobELCqUhcNbVnLfioXz93dU43Wtw28vnTyYawjN7aGDGNPkKi+HZ2
         c/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768246098; x=1768850898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9AdLI7uJUYtOYd89GixDifcE7N5970uW2swaB6ncSw=;
        b=ngF9QXefRinkUBG7GOCNwlQgl7FLCl8C7i/J7w+/kjIrUxyBHOwm0/n1tZexaRuUB8
         5dd9N0udvYiRKYOtmXSYMg4IBPzgfndmZCakHTxghtbT2u2mRhyEt/nd/qJF6yBmKVde
         HXyjk8GEUIHtiDmfRzz1lS/9LF5MO1zw0yNXo6VpSFSwFRNWQ/P/gGfWykJsvIX8c195
         Qb/rT2gGARl3ZZOHKRye6bTtt6jqdZwPX1DQG63yEuC4Z+AP6JJj9HM/rTEUO7IWUOx+
         NMAWFEwIFQDJwxsTuXYx1l9Jt6c0Tca1q4AfBQVetR3Y+95NQXDWwhm7P5VKgGrtO63s
         mCwA==
X-Forwarded-Encrypted: i=1; AJvYcCVNo+eV/l8+RfAqWFEKiNVx4LdrSgT6PO9uSCBLHhgvaCSUb4T//6V94vgP1b7Dbt4tC2c4gJrdl88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJj62SrhpECHukMyncUXP/zLYaIRVnQ+0nIqRgFKtgRYfgw6Y3
	k78I+zXMkFwqfYSJXTsqzi+zCINUERhqQ1CfXegcPHo5SK3rRcTE2a/RppwsbpXkXEo=
X-Gm-Gg: AY/fxX6WDvS2lZU7M1A9AnkIxC6YLn6HDKFZx74Au7zADIwlQ6rApX4nxW0EHCe5AGO
	/IcM7oefUVIzTcjxxPI6puU00BAbS3zKnNoDgBTamHbQqmcj5rsvvY6T6/tYl3dShslLqhCsivP
	rqNQX1tmK1+8F3OrosOy6F09UDJH1Lj11I370wMOBls/InR55bHZDT1GhQU63g0Qhr3t2pRfkgF
	nIMHGO3I+uGRDVy0IkPDgnVGVrzORWciDCCokoaA4GNC8J2h4o/xV3adt8XxxkpM6GDLUJcPUR2
	LdJ4UPVVQxYHSWa7LYg9aOxmHI+3dmxHT1vK5K97f4ZDQLBszMSzIL7lnSjvUbuAUpNPHRQys9B
	LGOl5e+VN0D0hdSwlpJ4e3O0auU9gQbAPCZya+uC8n2tkvuFUKlIka7jPCZjts39yZjVZwtweCV
	ceDAJo16PacyBBMnDU+BykX7FzzNcXOQfge6Z306GjAD5rL+418hjrIkpGesLx6De1iVE=
X-Received: by 2002:a05:620a:1726:b0:8b8:7f8d:c33b with SMTP id af79cd13be357-8c5208f18e3mr71372585a.43.1768246097807;
        Mon, 12 Jan 2026 11:28:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4cd7a3sm1609425185a.24.2026.01.12.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:28:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfNaK-00000003cxB-192v;
	Mon, 12 Jan 2026 15:28:16 -0400
Date: Mon, 12 Jan 2026 15:28:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Balbir Singh <balbirs@nvidia.com>,
	Francois Dugast <francois.dugast@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alistair Popple <apopple@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/7] mm/zone_device: Add order argument to folio_free
 callback
Message-ID: <20260112192816.GL745888@ziepe.ca>
References: <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
 <20260112165001.GG745888@ziepe.ca>
 <86D91C8B-C3EA-4836-8DC2-829499477618@nvidia.com>
 <20260112182500.GI745888@ziepe.ca>
 <6AFCEB51-8EE1-4AC9-8F39-FCA561BE8CB5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6AFCEB51-8EE1-4AC9-8F39-FCA561BE8CB5@nvidia.com>

On Mon, Jan 12, 2026 at 01:55:18PM -0500, Zi Yan wrote:
> > That's different, I am talking about reaching 0 because it has been
> > freed, meaning there are no external pointers to it.
> >
> > Further, when a page is frozen page_ref_freeze() takes in the number
> > of references the caller has ownership over and it doesn't succeed if
> > there are stray references elsewhere.
> >
> > This is very important because the entire operating model of split
> > only works if it has exclusive locks over all the valid pointers into
> > that page.
> >
> > Spurious refcount failures concurrent with split cannot be allowed.
> >
> > I don't see how pointing at __folio_freeze_and_split_unmapped() can
> > justify this series.
> >
> 
> But from anyone looking at the folio state, refcount == 0, compound_head
> is set, they cannot tell the difference.

This isn't reliable, nothing correct can be doing it :\

> If what you said is true, why is free_pages_prepare() needed? No one
> should touch these free pages. Why bother resetting these states.

? that function does alot of stuff, thinks like uncharging the cgroup
should obviously happen at free time.

What part of it are you looking at?

> > You can't refcount a folio out of nothing. It has to come from a
> > memory location that already is holding a refcount, and then you can
> > incr it.
> 
> Right. There is also no guarantee that all code is correct and follows
> this.

Let's concretely point at things that have a problem please.

> My point here is that calling prep_compound_page() on a compound page
> does not follow core MM’s conventions.

Maybe, but that doesn't mean it isn't the right solution..

Jason
