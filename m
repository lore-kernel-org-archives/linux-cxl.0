Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7D3B42CB
	for <linux-cxl@vger.kernel.org>; Tue,  6 Oct 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280117; cv=pass; b=KHX3RPd7+zNPvacPy3gr5uPVmb1mqALBR5LHTzAnUbEW2UFkG8xXnLO2wAgsanpF67JkF4iRffxyH1JS7qsESBxPF9blcFYSjn/vHUDnpnjvqn/R3bs89xzvLG432HCRsAtqwB9AZE1pNnKfZ1sZ++5wq5eC2OYgwrXEEwKFkC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280117; c=relaxed/simple;
	bh=z8C5llEeSas+wDevoi5ayKBoOPvXKhtMoOZYxs8J+Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9j3VtqLoA4MXR8OfSFQLrnybDp+0ukTlb2S1EUIpy251dmWeno4dGielmnLerBRJBDOk1FkCVrWyRXqWzZ5Y4Lw3+XIg+o5CEn5i9Cg9qm1QJbo2+m84fiGC120OznMUyBZVdergCqyP9nF8nnfkmWVJRVd19MKrx6+H/cDDS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XZSpqJ14; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XZSpqJ14"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53397554beaso27892671cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 06 Oct 2026 02:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791280112; cv=none;
        d=google.com; s=arc-20260327;
        b=Rp+0zlhQ15X24+9SvTD8rADOJ9e0TLGFCDv9r9+4eVl+75vfS0VGw1EC7eBnws1TlM
         ZKbORwqeTH82Q6pkvb2tTd7v2i7rFlOts6GCk92HRx+PcCOLxKZ+bcwgn/E4xx9f3Bum
         NKH3A2IyPwBfWuHKxyrR6eC9Nfd0sdmUaiZWWOrarj17NN0IyvaGmAppSMf034vuKLp1
         dvlj7RP1yHLLJaJnmiGIbiJJoqsu/kHGDtBEPQ3IGuHZnxtJmyqbXtb4o/vWSJq8FHFH
         scvYt9fuMh95dXkIvYC0Wh/zROdquAQREPbVfP9TTqrZ0FbYmUOVm7T7b0St7458xUut
         XBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/5ZFcmaqybTJP5VKzEwaO+zhe9+eXiIc/pJbQP9+B04=;
        fh=J2QYbOp+NwsZGb565p1IaMEh3PnGyK0bTZXqMBmFKJE=;
        b=ePuTDC7uMgzN7DgHxI0IbRTXiVzN9ZGMfZ9gs9OdSAV/9Iq6pcOY3CTrJsKpup+Rtt
         7r2VLoshbh64mtiDUXYC2cQzUuB48SP2CRV87gyoIjrQeDpuKBDaXOh0PDOYJFqnTCub
         pzK1cyngTiYbOO8oazxNBcagPAkMom8d2hAHlsyBvmAONBpnmdNIjlE8lIzKC2st/itI
         VeWmjh0FemQHLf0Ib564n01gR6cfA1BXjbbfLNkVQKaCHMTzJGoVpqlE5HHMNuwaEYx8
         eFJoJgYtmNkqWKEyEmJWOdqOuvs6OVJHHmBrE3Aq2p6HbDTQn3AI97d+fc4KSAevNERv
         3lpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791280112; x=1791884912; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5ZFcmaqybTJP5VKzEwaO+zhe9+eXiIc/pJbQP9+B04=;
        b=XZSpqJ14jV0etdGDsBDvwGbtZKbssnTj2YlgxtYfwS8oQNRvjD3OdBHhs2QMwdygU7
         63LnXdEcsl8V9rIeMImbJE1LC0kZAJJvdMk6aCacqEluDHShkr/O39NSPsJYs5o+yMxG
         Jqh5IQlbkslM0GzrQbTt6hrRtDYxk0VaDZlZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280112; x=1791884912;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/5ZFcmaqybTJP5VKzEwaO+zhe9+eXiIc/pJbQP9+B04=;
        b=p9yc3mnQI6uCyOR54so6ywdCTCM97WEh1Gy2bF2mZbL8W3o7YL3FK30hXQMH1WVirW
         4SnK5qKH9cXwSdn11W6je2K12YNvx2lmdglMNjPNLG/DBasccK7NUnKldwEjg++AhgFZ
         s0uZr1t4nMU9dU6Xi2aDoRpLUygC/s3lBrvJ0liPcJly3D5unX61a+FUBt+uWNLcMpTB
         ITh+SS6bmJCz/zSDJ/VaDWyMcdE/V3UV4BqeRGfa7bhHRaOfTvPpZAjL+FhG/RgUPoZ+
         W3WvRiVnmfECA0XIPVLE15rWbDeT+SWHEbRPSCBFy6Hrx3Zeb+7YgL/jb6RcSrYMA/CQ
         RgoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwn7dP6rANfPLBlqLeeuZJHO5/A25JjnbYo5qMoSEovg56+7UV+pGj2bsffqd/VdSg7vhj+UKYKggo=@vger.kernel.org
X-Gm-Message-State: AFuF++lFSB03r6baEM4rxCalOmRagcrsbAhHH6rXZtGhnNxIGDeHM69E
	grVB21RUxt8URMaD8/YN/lJV6FUjd+Vkt3gtdFa7hlj6lqukqDZPrLwZBGuESTLtc7RupIp5CpR
	PxIMjEKKRTrQdZ2qVENXdtH88ZOxGQ7SZ/DyAoObj/g==
X-Gm-Gg: AYBFou1rehfUD5iyC9lRPlvg0PibGGnJxUerBo64N1pog/5KMnq4Jm2jLCoJnHQKxS9
	zjnC7q0e/h36V7bSTX1lWiISFA7UHa2BMMENephqvkshmG4KsF70Zs2QtuW4VYiBz9Y8Z7YhJUD
	KbvEHsb5vqraCcTPoBP/BnwDjkPM3qV984tWfz68qREBPj9zZUk6zwVXG5X+ezWPAMJ4vDYgZ9I
	dFiiiarAIik9xMVAE4X90lxCLsHk8PqajhjD+CwAf+NZhlgaOVusTChMVRLu6KseYOChv+RF7wm
	X7smmuxpIX7nAzKIrPgl35jaQsixbAB2W8gf7+R7VF7CyNMll01x0ziYwCnC5ANCn+T47wPXM++
	1CtYLfFNa/152
X-Received: by 2002:a05:622a:1911:b0:530:f77a:b162 with SMTP id
 d75a77b69052e-53511e4f3f3mr177910411cf.27.1791280112604; Tue, 06 Oct 2026
 02:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <asQcBebepPb9CXzS@groves.net>
In-Reply-To: <asQcBebepPb9CXzS@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 Oct 2026 11:48:20 +0200
X-Gm-Features: AclHuK80ssbUcTC90bN8pi5U0qILib7vm2yX0MtoI7xgqfk-YgE_-OE-vHSlWAI
Message-ID: <CAJfpeguEUTYk9m7g2gZTMui0yFDYWSGL1SZ9PvoYiCqjDmHp9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] fuse: DAX device based extent maps (famfs)
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, david@kernel.org, 
	willy@infradead.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 01:37, John Groves <john@groves.net> wrote:

> I see the kernel-side rejects these s/size/chunk_size/ strip extents if they
> are not all the same size. Why not put the chunk size in the header and let
> the extents honestly describe the offset and range that they cover?
> The current design can't test for sufficient strip extent sizes, although
> it replaces code that did verify this.

Not adding chunk size to the header is intentional to keep the API as
simple as possible.

> However, the smoke tests passing isn't fully legit, because the patch to the
> famfs fuse server passes the entire strip size on CYCLIC mappings, meaning
> it just produces a concatenation of ranges - which does not achieve the
> interleaving goal at all. That case degenerates to simple extents.

Are you talking about the case where there are multiple simple extents
each with a different striped mapping?

That case is supported by the API, but not the implementation (since
there was not test case).  If you do a test case, I'll add the
implementation.

> To be specific: each chase/dereference that results in an L3 cache miss adds
> a stall of (1 * MEMORY_LATENCY) to the fault time. This is the good reason
> why I didn't do any chasing in the fault path of the famfs code that you're
> replacing.

Please benchmark against the in-kernel implementation.  If there's
significant (meaning it may have a real effect on a real-life
workload) performance hit from using the rb-tree, then we can add an
optimization.  I don't want to add complexity without actually being
able to measure the gain.

> OK, one more. You're using the rbtree for indexing by file offset, which is
> a zero-based non-sparse range in this case. If this could not be avoided
> (which I think it can) you should use an xarray or radix tree for that...
> right?

Unlike xarray, the rb_tree API is one I'm familiar with. But nothing
prevents switching to xarray if that's a better choice.

Thanks,
Miklos


>
> >
> > Thanks,
> > Miklos
> >
> > ---
> > Changes since v1:
> >
> >  - moved 3 prep patches to fuse.git#for-next
> >  - introduce FUSE_PASSTHROUGH_V2 (Amir)
> >  - lots of small fixes and cleanups (Amir, Sashiko)
> >
> > ---
> > John Groves (1):
> >   dax: replace exported dax_dev_get() with non-allocating dax_dev_find()
>
> Golly, it seems like there's more than 1 patch worth of content from me here,
> but the chipper/shredder might meet the letter of copyright law in some
> jurisdictions...
>
> >
> > Miklos Szeredi (7):
> >   fuse: add helpers for EIO return value with kernel message
> >   fuse: support 64 bit, server allocated backing ID
> >   fuse: support opening 64 bit backing ID
> >   fuse: add support for opening dax device as backing
> >   fuse: add extent map data structure
> >   fuse: add extent map I/O support
> >   fuse: add support for striped backing
> >
> >  drivers/dax/super.c       |  38 ++++-
> >  fs/fuse/Makefile          |   2 +-
> >  fs/fuse/backing.c         | 292 ++++++++++++++++++++++++++++++-------
> >  fs/fuse/dev.c             |  21 +++
> >  fs/fuse/dev.h             |   3 +
> >  fs/fuse/dir.c             |   3 +-
> >  fs/fuse/ext_map.c         | 299 ++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/file.c            |  16 +-
> >  fs/fuse/fuse_i.h          |  72 +++++++--
> >  fs/fuse/inode.c           |  17 ++-
> >  fs/fuse/iomode.c          | 108 +++++++-------
> >  fs/fuse/notify.c          |  75 ++++++++++
> >  fs/fuse/passthrough.c     |  63 ++++----
> >  include/linux/dax.h       |   6 +-
> >  include/uapi/linux/fuse.h |  53 ++++++-
> >  15 files changed, 904 insertions(+), 164 deletions(-)
> >  create mode 100644 fs/fuse/ext_map.c
> >
> > --
> > 2.54.0
> >
>
> John
>
>
