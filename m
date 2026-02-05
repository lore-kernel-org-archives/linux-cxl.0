Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18130F7EF
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279317; cv=none; b=E4JYG/wXoUVFMlT9jqd48OOm1iyJSfOI9ZUWzAOIOHDgp+1x1q3yl8IzrcPAGZ/86+GIDAmGuaHxZPkWC0yMNcnatOimwR0FqYooD2ZMkdEE7SSOiix/J6x+Ws+h/jWXGvwSYjM51Qp8JN5ZSKT9FfqusvGXOCarThRAXl0Kvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279317; c=relaxed/simple;
	bh=8vP8xYvw3fbjBJgIEEdyf12Zl94oTbtYcrQbu4TajzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RO4hg7VoKx251Bc15HkAqrlAICT3178e94HGDuWKDgN8SazVcmNsVGQogSel4DNwOVrlzd0kezh7LpS26wKSyDM6MowBWySOwGomh/NtFw/VV0UimiKr/L0gtkfSRAneaKANjufAgC98XTvL5EbkA1M/DPRNgpTh2Ey+2e5KBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgScRm/b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgScRm/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770279315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc1BOQ3rsAm6eCmXX67HOx5s1L4t7ZLDykW/kGCNqLQ=;
	b=YgScRm/bbsf4opYe0Zd/6tG2ugEIA7KLupKsVqcEeq3FouFq8Q3Si3Y38YmhHS33SPPEWJ
	kcVjeCjAUcPnvalCCBXinmVukGSJLQ/sfseOC6amDhqTM2xGzxPyxS0Gs98JbdtH1Uzrys
	dZ5AKJ5AFXhjxNa8j2CJ/geB3piPaZ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-MnHt6inFMMi4j98rP--VdQ-1; Thu, 05 Feb 2026 03:15:14 -0500
X-MC-Unique: MnHt6inFMMi4j98rP--VdQ-1
X-Mimecast-MFC-AGG-ID: MnHt6inFMMi4j98rP--VdQ_1770279313
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4361765dc85so446835f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 05 Feb 2026 00:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279313; x=1770884113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc1BOQ3rsAm6eCmXX67HOx5s1L4t7ZLDykW/kGCNqLQ=;
        b=H+U5BlsVnM/mnJcsJJDR+stlYcmQayKk1RHs2h3aMbG7XyeaW4xIZdVN+dVz5OoTcf
         8bT5gAgFLARLAyKolelnw12Sx7T9ZgZJC2yQVfMGfqVZk0NCpRjtrRh4gxHy5+PsMyF1
         tYaOKWxndA1qJPcEFsKpKMgCE/VxXzbxbLO79+9iCcsU0kI0TW2Tws0osaldg7cU65mc
         TKs/d4IXdhVPt4tmaAbV+kUMFK1lqFZaAFz4jMmpC6E7kP5Gw2ODHJsgQgTz49GigKLk
         5tSrjRNdXPUt/JeowzrUws2ES2QSF2Zufqn/5XVQQnghi22V+3YywvKMryMWDPjlmB0c
         N3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWMBpmx8Rr7W5ZhXM8n5qbiMEUcSHjJC7jn3gXr5X+iJ469F6nFlHoOzmnhptA9RHynjczuWMnhTGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzciyXVgDKl1CJG1PwpEaivO+jJemSbS17hcDBS4DoAH/FGCrae
	/HAEJcECRW/fsPD6/Np+o+HpbnpqbsMV5ady5o5Hte0VAlY0Qt/eiJRbWVRnjq//0bESxX1/pVT
	lzyCXJ/lOJEphy0qiSIPxz7XZ7QzKLYrcgghRfJ+htlJwpc5LwftM4b5LaDjKtA==
X-Gm-Gg: AZuq6aI3GfZxC2Rmlz7VamPVfpQpqHjdVJdA2HNssQP5G+WDPgdOMDx1a7NyL10FdRh
	pJjvxnw7STsiN4LqKAYzjAECZFIS70R9+ZG3UQ2tMnd3giPBcuDTu3iYdelaQ3cSQcb81hOQSLF
	cJy+z9gIB5F/JCywu53OsPTc7vrDHS69H7J4U0n3/o/VigMXC/FIe+TKxFeZscCYgkdvCV6Xy8/
	Un6rgTHd/3rQP011WY78rWtG8n1nfXcTzBrI08BPlexvluZSYvEi2gz/7lwfJUc1YU9TsZE3cdy
	ts+QGPIaDNLVHqEV54sm6EpIwNZI50Bhe1FYqltfh6xQ8NvxaLubr69f1qOjhQDdwvGmCkYeZLi
	97XX4WWyuHCPGFeIKsgG+zFuIc4nc/mSxJQ==
X-Received: by 2002:a05:6000:2912:b0:435:9653:e151 with SMTP id ffacd0b85a97d-43617e3459emr8453206f8f.3.1770279313140;
        Thu, 05 Feb 2026 00:15:13 -0800 (PST)
X-Received: by 2002:a05:6000:2912:b0:435:9653:e151 with SMTP id ffacd0b85a97d-43617e3459emr8453044f8f.3.1770279311148;
        Thu, 05 Feb 2026 00:15:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805edcfsm11518408f8f.35.2026.02.05.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:15:10 -0800 (PST)
Date: Thu, 5 Feb 2026 03:15:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org,
	Ravi Shankar <venkataravis@micron.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit
 mode)
Message-ID: <20260205031426-mutt-send-email-mst@kernel.org>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
 <20260203153759-mutt-send-email-mst@kernel.org>
 <20260204111202.000051d2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260204111202.000051d2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _4Te7S28vXfsduvMBO3f628DGGzCN3OCA-AS41bQqgA_1770279313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 11:12:02AM +0000, Jonathan Cameron wrote:
> On Tue, 3 Feb 2026 15:39:22 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jan 09, 2026 at 02:45:04PM +0000, Jonathan Cameron wrote:
> > > Lightly reworked version of Davidlohr's v4.
> > > https://lore.kernel.org/qemu-devel/20251103195209.1319917-1-dave@stgolabs.net/
> > > 
> > > Whilst I have several other series posted for merge this applies fine
> > > to upstream, so no dependencies.
> > > Davidlohr, please check I didn't mess anthing up and perhaps give tags
> > > for the 3 new patches.  
> > 
> > applying this on top does seem to conflict.
> > let me get rest merged then this can be rebased.
> Hi Michael
> 
> So I assume this is your v01-04-02-2026 branch.
> 
> I tried rebasing on that and ran into some issue.
> 
> Looks like you have a stale version of 
> [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
> https://lore.kernel.org/all/20260119111542.788389-1-Jonathan.Cameron@huawei.com/
> 
> Markus had some comments that needed a new version.
> Mostly updating a few more version numbers in the comments to keep things consistent.

Right and *that* now has review comments so  it looks like there will be
v5 ...

> 
> Not sure that has anything to do with the merge conflict.

> > 
> > > v5 changes:
> > > - Rebase much earlier in the CXL queue as Davidlohr had it beind some stuff
> > >   I was carrying that is not ready for upstream just yet.
> > > - Update the CFMWS flags directly as the patch doing restriction control needs
> > >   some more thought.
> > > - Bios tables test data updates.
> > > - Don't provide flit mode control for gen_pcie_root_port as we don't need it
> > >   for the rest of the series which is all about CXL.
> > > 
> > > The following allows support for component basic back invalidation discovery
> > > and config, by exposing the BI routing table and decoder registers. Instead
> > > of going the type2[0] route, this series proposes adding support for type3
> > > hdm-db, which allows a more direct way of supporting BI in qemu.
> > > 
> > > As BI is a dependent on the larger flits introduced in PCIe (and CXL 3.0)
> > > add support for enabling that for CXL components. Negotiation is handled
> > > via an equivalent of what we do for link speed.
> > > 
> > > Davidlohr Bueso (3):
> > >   hw/pcie: Support enabling flit mode
> > >   hw/cxl: Support type3 HDM-DB
> > >   hw/cxl: Remove register special_ops->read()
> > > 
> > > Ira Weiny (1):
> > >   hw/cxl: Refactor component register initialization
> > > 
> > > Jonathan Cameron (3):
> > >   tests/bios-tables-test: Excluded CEDT.cxl for BI restriction
> > >     relaxation.
> > >   hw/cxl: Update CXL Fixed Memory Window ACPI description to include
> > >     Back Invalidate support.
> > >   tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
> > > 
> > >  docs/system/devices/cxl.rst               |  23 +++
> > >  include/hw/cxl/cxl_component.h            |  87 +++++++--
> > >  include/hw/cxl/cxl_device.h               |   4 +
> > >  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
> > >  include/hw/pci/pcie.h                     |   2 +-
> > >  include/hw/pci/pcie_port.h                |   1 +
> > >  hw/acpi/cxl.c                             |   2 +-
> > >  hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
> > >  hw/mem/cxl_type3.c                        |  15 +-
> > >  hw/pci-bridge/cxl_downstream.c            |  10 +-
> > >  hw/pci-bridge/cxl_root_port.c             |  11 +-
> > >  hw/pci-bridge/cxl_upstream.c              |  18 +-
> > >  hw/pci-bridge/pci_expander_bridge.c       |   2 +-
> > >  hw/pci/pcie.c                             |  23 ++-
> > >  tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
> > >  15 files changed, 313 insertions(+), 97 deletions(-)
> > > 
> > > -- 
> > > 2.48.1  
> > 
> > 
> > 

