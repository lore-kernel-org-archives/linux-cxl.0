Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D231195B
	for <linux-cxl@vger.kernel.org>; Tue,  3 Feb 2026 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770151171; cv=none; b=a1B5L+ruXfwm42Fi+waCaE2EhOilmdBnLFBGs+o68TN0ydqgjAe1ASAF15Bd6HvI14O3dDFzIh5966EuzetbWr3UJeOsnrLmHy6qBZf2JzeDhNhnpqpJkiw5EnPhjquyOmoVkesKuY40Lz6g0dmsE65xHCSDCn9y3w9TtBxZ/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770151171; c=relaxed/simple;
	bh=4iRCeGebtGMBCmiuV/nCEu5lSfg+DGbwrNV85S3eVmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HS6RxdauATq12CoCWcp3bbIRrVZnCJw4/I9fDPQE6BxWvnj/oekbsc1Gnnm7z8rN40gzQDJpzGCOHMyVsLY3WRec+Yv7NM9d0u0tdeo1NvmFXY50YcCLDxivOp0FoVZO4+Wl+1bwNx3x8WlNg1e+0b+YWEdA55Zf1HJ5/JBxAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6a1Cmic; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6a1Cmic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770151169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/crHqpbetOcuuTBStzVgUPtEd+GUYHb0Q9+A3r+YMys=;
	b=V6a1CmicefhvBRbgFTzf944gxXol2jqj6tQhU2SMCQ2qbFgCjvJ9Gu7sreFwH5Iq6UNfBz
	lXpm8mShGo4Lro3VMZwSBcZvH/dbuBTOD5L24hKDGqEpot3h5J+Z2yTjVZX2YNzNyulZMU
	hIw/NJCle7iVQ7cNq2H/67UIKsdw8ZE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-vXAGoYCtOWmuUZ8_IwpMyg-1; Tue, 03 Feb 2026 15:39:28 -0500
X-MC-Unique: vXAGoYCtOWmuUZ8_IwpMyg-1
X-Mimecast-MFC-AGG-ID: vXAGoYCtOWmuUZ8_IwpMyg_1770151167
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435ab9ed85dso4174095f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 03 Feb 2026 12:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770151167; x=1770755967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/crHqpbetOcuuTBStzVgUPtEd+GUYHb0Q9+A3r+YMys=;
        b=E2wVE6aD6ru0E7RVgRF2ZNsBfD0G8gFRJoX2IK8otfyPhN8efW0TItszTVhxrYd0xw
         HwY1TWq3CuVDOinkxQoKZWXMeHvfxC2hCM0A29P+fqa0f9CN2eAlsDQDNEUUeeiMLinS
         tNWb+C8i4snz5e/wKAhOTtbwsExx6DBfVdaQFVruolv5d8Is4vQEVUqb2tvuFgcezPcb
         DTA0vj5QFaC9K0xkREl6UxvViuZXsBjb2aGUqX4858/uDAeyIvpKrb9JcrMTc/DKd/Hq
         H+Sf92a2ZJdN3ejZWl/h+pfzZefEB81MVuk59+YAXuFZJLlE2Ulatk5/P6p8gyf+hVOP
         YQAA==
X-Forwarded-Encrypted: i=1; AJvYcCXPRRy2Dx2pA1XeCxMfk2V1fgcTNEPp2qZ/e5sBcebXaj0Nsa863yb1F38q7ne4KJGyH30fBC9kXYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+wuu67Xp7UeeI4GzsmBHNEm8xfUUYy3wP1RamHmBNzEHY5Dh
	tt9xMRA1MlNJupOglUrchQdSZaYyD/aq006MjiXEhzFpnujr74/pbJNMT1ph2asJF0shjvtEfyk
	dHPyZUKSb10ttJaPKcCVcBC5/aHOX36O+qxJTIbFtBvcXMonDDl7+qvxeBCp79R7pcmocDg==
X-Gm-Gg: AZuq6aLZ0qsU6hJc235GOvl4iUFLIO93uhZ2OLiDtIqjR8a7EPw1qw18s2kaCHnB6/+
	24Vp+KzgrKy0ECQMeL5wcAwWhZ9G7/hoeUv3CcKwGzXwbTGv+IVP7B4XVUdBHkZJ0LV0JR0FCXO
	Z3mJjAv6bHKwLfUKEQ1MMfZdRY9LcQATTRga5f8wlMwAwaW9uLOroyllosbzN6RwfFN0FGo4KTa
	cplUQ7XZ6Slddcz/kTLIwVmhBc8p0xjojpWiWbgPgLVypC47vm0npox+DgE73aL95dUr62TgVnE
	xckQLWjvTs283+LYosxgVticOKPwNuW822IcijpokjFYuYHIGRAOelYtEbTM/9e/Pc3QMvchmeN
	tXbm/nReEBjXbZFV77LRQxJ6fmztKqRaJdg==
X-Received: by 2002:a05:6000:4301:b0:435:9b3d:d969 with SMTP id ffacd0b85a97d-43617e405c9mr883419f8f.21.1770151166438;
        Tue, 03 Feb 2026 12:39:26 -0800 (PST)
X-Received: by 2002:a05:6000:4301:b0:435:9b3d:d969 with SMTP id ffacd0b85a97d-43617e405c9mr883371f8f.21.1770151165779;
        Tue, 03 Feb 2026 12:39:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25683sm1324489f8f.6.2026.02.03.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 12:39:25 -0800 (PST)
Date: Tue, 3 Feb 2026 15:39:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org,
	Ravi Shankar <venkataravis@micron.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit
 mode)
Message-ID: <20260203153759-mutt-send-email-mst@kernel.org>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QamNFit4TF3TqFPU11tFeuIG1DxnQJ6xGm4-jqWpi5g_1770151167
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 02:45:04PM +0000, Jonathan Cameron wrote:
> Lightly reworked version of Davidlohr's v4.
> https://lore.kernel.org/qemu-devel/20251103195209.1319917-1-dave@stgolabs.net/
> 
> Whilst I have several other series posted for merge this applies fine
> to upstream, so no dependencies.
> Davidlohr, please check I didn't mess anthing up and perhaps give tags
> for the 3 new patches.

applying this on top does seem to conflict.
let me get rest merged then this can be rebased.

> v5 changes:
> - Rebase much earlier in the CXL queue as Davidlohr had it beind some stuff
>   I was carrying that is not ready for upstream just yet.
> - Update the CFMWS flags directly as the patch doing restriction control needs
>   some more thought.
> - Bios tables test data updates.
> - Don't provide flit mode control for gen_pcie_root_port as we don't need it
>   for the rest of the series which is all about CXL.
> 
> The following allows support for component basic back invalidation discovery
> and config, by exposing the BI routing table and decoder registers. Instead
> of going the type2[0] route, this series proposes adding support for type3
> hdm-db, which allows a more direct way of supporting BI in qemu.
> 
> As BI is a dependent on the larger flits introduced in PCIe (and CXL 3.0)
> add support for enabling that for CXL components. Negotiation is handled
> via an equivalent of what we do for link speed.
> 
> Davidlohr Bueso (3):
>   hw/pcie: Support enabling flit mode
>   hw/cxl: Support type3 HDM-DB
>   hw/cxl: Remove register special_ops->read()
> 
> Ira Weiny (1):
>   hw/cxl: Refactor component register initialization
> 
> Jonathan Cameron (3):
>   tests/bios-tables-test: Excluded CEDT.cxl for BI restriction
>     relaxation.
>   hw/cxl: Update CXL Fixed Memory Window ACPI description to include
>     Back Invalidate support.
>   tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
> 
>  docs/system/devices/cxl.rst               |  23 +++
>  include/hw/cxl/cxl_component.h            |  87 +++++++--
>  include/hw/cxl/cxl_device.h               |   4 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
>  include/hw/pci/pcie.h                     |   2 +-
>  include/hw/pci/pcie_port.h                |   1 +
>  hw/acpi/cxl.c                             |   2 +-
>  hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
>  hw/mem/cxl_type3.c                        |  15 +-
>  hw/pci-bridge/cxl_downstream.c            |  10 +-
>  hw/pci-bridge/cxl_root_port.c             |  11 +-
>  hw/pci-bridge/cxl_upstream.c              |  18 +-
>  hw/pci-bridge/pci_expander_bridge.c       |   2 +-
>  hw/pci/pcie.c                             |  23 ++-
>  tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
>  15 files changed, 313 insertions(+), 97 deletions(-)
> 
> -- 
> 2.48.1

