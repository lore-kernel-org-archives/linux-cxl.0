Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681FA2652A4
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195549; cv=none; b=cLI/2fsTPONIH18o4ReyaeePKcLDxg3gCb9aL/rie7pEL8vtpUcjg2L4a3wFQ5ipMeOz3523Y6QD/QM/Emn+jCjSfnjDPAvsQAsa9cCReon1LyInoQGrFaplBjaEqL0XqauaeX9Nzey8voSqHktV+JiR8C0N3hfxrZQwjcdO0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195549; c=relaxed/simple;
	bh=dwNTImMJO2gHVlejeQ8Ezs9GSst86dOsrCCdrs8fh6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWW84pCMOXRcRs9yc3EA86S+O0wF9MyKe6deHuzTkUOn0kVgd86FFBa8EeAykshztTUrnVre9gCAm/inTmkesWTSt831eChDqfRzVt8Ogz6iWK7EiLspzDtO3ClbAzr0SX+vGqfQRJcA8VQRoTLQSMsAgnV13q6pycYSRwqsbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=A1tjVfI1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="A1tjVfI1"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso32217216d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769195546; x=1769800346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAb3V8FwAoFt+i7QIjKEQtHflVF/O2of2sgUimojvUA=;
        b=A1tjVfI1/YSIGghnUuHAEIFbcLGo8l5KYHiHmJMb6V1pi0OST81qkNHZJQVi1fwWzT
         ujEsqPso36fMBDQmlnB86+vxjK+V5pHg75bQXWrPmgafA80jJAOPJFcmPwgolnmkGV+x
         yNpVG4NmynCS1O2pqmZmvAN3x1Ftqh4h/WhNJthB1hCmn4mOVdZemTQfbIcEvrYWGkbJ
         Gz/FziR/F8qJ+5uxvRUdsxgoXhO+NkuDdtoQEewdJij2oGUrdnUfDyQcx9gu5s+pOD2w
         2l0FhLX+8hKHFzWWA5FBdZGhXNIJTi5IPBWK9POvsVE8gTD2R38JMam8WMjVTw4uxPu+
         94CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769195546; x=1769800346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAb3V8FwAoFt+i7QIjKEQtHflVF/O2of2sgUimojvUA=;
        b=rnKbXwVDEJRUu8mE0urB0GM9q2hRODKg6S+22xJdglivM+BbFjnTTWnqeoGIcsLcsi
         2kRl89ulMaJa22Sbfz7tqK0EGhWxWc13NemlM9bJ6hBBWkyTprQqdxdtGCZOuHrH+SOR
         Z6fVeP/YTNjwgPlucD/kxyYesk8RiPql/ipQwuALNuIgW1j9wlzbxShzIX6KRTwHJsAE
         iH7e87/FmQXaY3eqnMWDG2duaTSS14w7TLQ2pkklfYBaHQe2IIPQQasvJOPjqDwW2tBk
         OYuCsGQJygaZHgoIYbj6l/kp45s6/i40tZ9ZraBricBj1XPGt0r/s7MzBwffhsgY0rs2
         7tQA==
X-Forwarded-Encrypted: i=1; AJvYcCUHHmKHiX4TgcLsH2QFKGU8sW2kRuJmXNpIOYDIZD+hI9xaXo0BG1khYwbP06RgeCujcqrE9R5rGRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFsolaEJj5TzM7FabDzPuHRA72wr1Iw5h2EME29Dg9CFBsXA4
	9gejuZ9DmebqS/SCtO/Fg9dW8RUY7X08R6OVF8FpFnhHJ944kwRGwV5eT6Zbyu0k5dM=
X-Gm-Gg: AZuq6aIpDweAuVTn5UhfecqtfZ3y+2KuadtMW23sVnPNo+io1jNiLuFBj3JiLAZO9qe
	le0zg0SC5/UVaounzKw+rKzcuCm9EkHoT2ys7CJYL7WcAlkCu4o7O0wdb2HcWCZbxv/Yo5woSEV
	yXyUfEuoCIYZxvJRkVpBzD18djbyIgxb33fqlxq5QJmT/+spzYc8tPSz0twFKoa/TcJwADxE3Ni
	by3jaV6yX147ynVf7O1vEFl6JLlSF8F1yqBJcF662Gi01PT1pJ5dJRjy1ypeRNm4Tpa+m38XV8+
	3hrpCDFK38e2sxEUX4gIYmPMRoiebLUDSUQEgFiDTfdL1KTxJFTN/JLw5reWLMvupxutMCKsR7H
	L/kXWBwQopEQ/e1HXE6rwXNqWSI+Gs5Fl1O45Zo3Rwu7XtNEZVP+4BzrfoGeHrXJJIK4iQLTaVw
	KZNWmh4a0G2N/c4pyM+w6XucZ5uYk/oJSyXLW2knqFnmoqHFKYHz9N9h6wt7y99g/UuE4wRHakK
	BHjrcRO
X-Received: by 2002:a05:6214:3008:b0:88a:2ac8:9b3 with SMTP id 6a1803df08f44-8947df771admr103884956d6.9.1769195546348;
        Fri, 23 Jan 2026 11:12:26 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491823cf0sm23001816d6.8.2026.01.23.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:12:25 -0800 (PST)
Date: Fri, 23 Jan 2026 14:12:24 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 3/8] mm/memory_hotplug: add APIs for explicit online type
 control
Message-ID: <aXPIGMVAvVEBgFhJ@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-4-gourry@gourry.net>
 <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>
 <aWfR86RIKEvyZsh6@gourry-fedora-PF4VCD3F>
 <4520e7b0-8218-404d-8ede-e62d95c50825@kernel.org>
 <aXLCAtwMkSMH3DNj@gourry-fedora-PF4VCD3F>
 <20260123182526.00005ee8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123182526.00005ee8@huawei.com>

On Fri, Jan 23, 2026 at 06:25:26PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 19:34:10 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Jan 22, 2026 at 11:41:24PM +0100, David Hildenbrand (Red Hat) wrote:
> > > 
> > > Right, but I don't want any other OOT kernel module to be able to make use
> > > of add_memory_driver_managed() to do arbitrary things, because we don't know
> > > if it's really user space setting the policy for that memory then.
> > >   
> > 
> > Ah, this was lost on me.
> > 
> > > So either restrict add_memory_driver_managed() to kmem+virtio_mem
> > > completely, or add another variant that will be kmem-only (or however that
> > > dax/cxl module is called).  
> > 
> > unclear to me how to restrict a function to specific drivers, but i can
> > add add_and_online_memory_driver_managed() trivially so no big issue.
> 
> Is EXPORT_SYMBOL_GPL_FOR_MODULE() enough?
> 

Is the issue just that add_memory_driver_manage is `extern`?  If so
yeah, i can just do the EXPORT_*_GPL path.

If you prefer FOR_MODULE, then yes I can do this.

~Gregory
