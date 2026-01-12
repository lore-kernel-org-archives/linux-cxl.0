Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87A2550A3
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768260719; cv=none; b=eQtuUkxBHG0BMOFNaNqs2Yp3VKPBGJ1Cu1eqkoMetaBEglCi7nmqWBseis2YcDXFJAO7oX2rxJKy6ubgTv1kal9f3oS+q5ODMsxCIWdRLSZH3CWuIU0GDhBLIx67hFUN9Jn5REVuvthnW1ASTTzlkrSqJTOM2E1ubpeFzbSRH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768260719; c=relaxed/simple;
	bh=L++MAkaQvqNItCkQiT64oQtoza/heC4MjDaHxXJXLzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPpqz5l6K0M/tYZgZkGTEeCn1uPEfZ0OF0GcdKp2VWgF8JHBkY11lGtL1u0ziilMUa8wrjIH6MomfFI+WVfm3YGEtaPcv2T6EnUZ3Nyf0T0bHpUnCT94hOswBXJ0bS0t2oN+2Mr1YU6hOiKjjGj/piWmD9GUYGNAOPrIqBisUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NesXOhhM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NesXOhhM"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b23b6d9f11so747202985a.3
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 15:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768260717; x=1768865517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pIO8dQifpp5qZTd7WcwNdFqrDRKIKFleYoHUkXQdAb0=;
        b=NesXOhhM3RHd1sfBQMYZi8oTKdiUBU7ArfmPPZ2ookjGX9GilzxcZy7ZsMITZEfhmT
         atK3pcoNDQ7fXeUBnXlOaQhs7TkHhQLxymDBxRraId3xgBHRxQ0CvEjaT0ZQY898mLW1
         OgAoPGH9FODHRUMXjttUrb78JkzswM2lxC9mke2j4mfZ+SnwZh37jbs0OJOj9sTRf9Y+
         /lNvgSkJpPprccWu1SeFpxsP2wVrF/izp9QUHXT7a1ltzRvuEkMOuAt/M/LNrjxi/anX
         qpAxHku+U0VUggJ1zyl7vH5eInqY383srH2IJEov+I9bn/94GeaIHXIuyns9L4xF1Sul
         4ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768260717; x=1768865517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIO8dQifpp5qZTd7WcwNdFqrDRKIKFleYoHUkXQdAb0=;
        b=ZSqomq6CCjB+pSxz8SbLmQSXlcZtZ6DONf1PSymcEvEhDG0vumYkGufJpM1STZqvJb
         NESs9/sKoVP14G0qh0uVWelkyeRLTIIsNX3huoOqiTG3GE1/VA7zL+da3ZpBkgfdtm4Q
         uFwPciSFFVObo/ijqLIV8YdpxJSWRo+s8KFC5RN0k00nF3gKbA/wbvb30IQuHc0+viI3
         B3mIrMofcQWBm6K8tWjnW76PQ4hndvjBqivZWDYV6Di/q9QSR2FRxYR3NPPTNSVEk3CP
         khyblcSIobAgYxNFiFTPGf9iVS87qE6NixWjAhkfGn8iUIQjdrp1r895DFyxbxfPZ/Va
         BUKg==
X-Forwarded-Encrypted: i=1; AJvYcCWwK3g3bEGyX0Rr+TUye7Wl+XhSxMg4xG4xU/1av8xEm/WAmH2oiZFLbRv41nDSm3u0FuvoxvHDk9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9IfW5u4B4mB1WZHQChhdGLK4nLwAOMvFdjl8lfeFxTVefHeI
	e6gD55sjNOwslAkvjgVt/hIzDBHt8oA14m8gsJY0w2o41B3q5i1D+jiRyyEM+7ItJHg=
X-Gm-Gg: AY/fxX7v9iDTLao3GxK0BdlXT4raWmSXjgW8wKEqXH+YC7QhnMjAyfEE7jNotwZtfcT
	Na73vkXBlWkUUi/Eh36fHpbSqX4EkpcStLhdHH6g9O5HED4OiQxhSjHUnxCBoaW/IRSWH+f3Sfl
	h6jemo/O5iahawKsEQ9YK75iQLvSmWVf2KFhr0zUaNlQLgMCnrZnDxOJUlTxekmXCKmNfidc0gX
	8ZLmsO8EIhrywIGJZCsuZA6zBjx6YY3Ihp0yiO2DbRaGYWYuhFbBeqnXiKH1mSW5UGjblqf8H2b
	QpqRJyngl4sEYvzwemZ01Zz1arCmbSkIH6XtvEkgnYvNGg+CSKxtIU9jOX/7JSC9uwKLaU8rTZy
	K9weGhZ9FcMnN2rh8pjNOgDDBD91ZAa5F5vS/cmdwEegkZfBdpUVYxVt+BnwgzdZwDRfiG4tcJ5
	TZO8cwEQXjp3WKNYaDjrPVS08PJtq9NdNrhgB666utsHOMOpdiExXQbRZ5mjuU4mh4e54=
X-Google-Smtp-Source: AGHT+IHEv3oyWJcb06Rw4VjhDeFEk4R9SXi3D7aPoLG3khcVAljGyaq9fJ2LebD88CvTcTHK3Zmx+A==
X-Received: by 2002:a05:620a:3952:b0:89e:99b3:2eaa with SMTP id af79cd13be357-8c389375870mr2741069685a.8.1768260716611;
        Mon, 12 Jan 2026 15:31:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51bf8csm1591462585a.28.2026.01.12.15.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:31:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfRO6-00000003evB-2tne;
	Mon, 12 Jan 2026 19:31:54 -0400
Date: Mon, 12 Jan 2026 19:31:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Francois Dugast <francois.dugast@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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
Message-ID: <20260112233154.GM745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <aWVsUu1RBKgn0VFH@lstrano-desk.jf.intel.com>
 <45A4E73B-F6C2-44B7-8C81-13E24ED12127@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45A4E73B-F6C2-44B7-8C81-13E24ED12127@nvidia.com>

On Mon, Jan 12, 2026 at 06:15:26PM -0500, Zi Yan wrote:
> > We could move the call to free_zone_device_folio_prepare() [1] into the
> > driver-side implementation of ->folio_free() and drop the order argument
> > here. Zi didn’t particularly like that; he preferred calling
> > free_zone_device_folio_prepare() [2] before invoking ->folio_free(),
> > which is why this patch exists.
> 
> On a second thought, if calling free_zone_device_folio_prepare() in
> ->folio_free() works, feel free to do so.

I don't think there is anything "prepare" about
free_zone_device_folio_prepare() it effectively zeros the struct page
memory - ie undoes some amount of zone_device_page_init() and AFAIK
there are only two reasons to do this:

 1) It helps catch bugs where things are UAF'ing the folio, now they
    read back zeros (it also creates bugs where zero might be OK, so
    you might be better to poison it under a debug flag)

 2) It avoids the allocate side having to zero the page memory - and
    perhaps the allocate side is not doing a good job of this right now
    but I think you should state a position why it makes more sense for
    the free side to do this instead of the allocate side.

    IOW why should it be mandatory to call
    free_zone_device_folio_prepare() prior to zone_device_page_init()
    ?

Certainly if the only reason you are passing the order is because the
core code zero'd the order too early, that doesn't make alot of sense.

I think calling the deinit function paired with
zone_device_page_init() within the driver does make alot of sense and
I see no issue with that. But please name it more sensibly and
describe concretely why it should be split up like this.

Because what I see is you write to all the folios on free and then
write to them all again on allocation - which is 2x the cost that is
probably really needed...

Jason
