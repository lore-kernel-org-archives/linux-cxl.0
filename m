Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6514F135
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097118; cv=none; b=V59b3uCfnZ5WfvJoj9IGR0MTwRC192ZSUcmMa//PplhAVV9bCPh6njsisIIqBhSN4FoVCGQtg1/Wn3ai7fLtGknF5ncJm/mcSqF+/T+p7Vmsyi6nD0XUbh3x3yzTmb5aKTREW5gT6zix09S8IHphLFnB42atwv6UIdwAhcVKynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097118; c=relaxed/simple;
	bh=qKjlToxfaPcholsWZHePU6dNENTJgpAjav9s8DbZ5ZI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDPY8fq5obh3kcH1UEPMjNEn0ZKvqeWZgBJwe3LXhyCnwYlrx0bCcRXzWDH5eWfg97BxAi+5LyAP52hc3OePu/lMZflY4ixvfrdCjNCPfi3mM1GrWwU+vjq5cW1YHlyxrty4wmVUUA458v+Lli9kzegrwk9N/EfwcEQuYv5I4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beO4pGri; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beO4pGri"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e396a69062so910147b3.0
        for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729097115; x=1729701915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RABL2RF01Ga9XpkAVqzY5/IVkiUt1spFGyVkgeyO5hM=;
        b=beO4pGria/PY2HkeTEmBzfAuqO5b/1D771t3TXU8S8+OJbw/1Cu4BULEwR/o+7zHxV
         PhZhepBqI6wH82Bk5gPB/dL4RhSxKKc1jIGwNrK/OyxqSmtslqEkAAkWtr5pO9S+Kfyq
         ZRk/ejHyfdnftuRLSRbZA1f6TnnN1Jzi5R7u5hRYDd4uWKvnD8Dbss7nDTQ0wCKoqY8r
         RFZB8RGCHl/EimhzInDwmsSgrjTEcxbWEGcVXCYq1qJuXyKZ0eJD0tX8Hq3b/oF8ZwcW
         abDMcMt0cweasqDoe/V2lBs5P92sqj/Q50ngE9Br+Ge2JH1vahmUxvIC9TKLdtLD+jWX
         h9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729097115; x=1729701915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RABL2RF01Ga9XpkAVqzY5/IVkiUt1spFGyVkgeyO5hM=;
        b=V34MPNI1g6q9B/DDkchQUaJNp7ALUtWcazflZubWaCkXKiRJ51t+Fi6ip/EH3VJa3j
         cPMouVn2naN+BTSA/KU+ro1RVyJVtJ1cbrqLj2HYc1cNju3iLOsGp5TIGXAXBz8H8XsD
         WcRT5+QLkBrZYYnwM/YiC0fn3ziuEL8zwnS/MN2HXvfQioQFOiMG6k2vviuCXStfXlQL
         khaiN2B79K+QtKzYe/16ZnlTle0dnL0dMUtkS5Ed1tn/kCYFonBZ40I4dCeZ6w2CLeBI
         n4QL5lE0e4gy3x+wIc71LiClNDp4djGgD6i3udvuM8t8dq1acXYxoDJq+UzLFDfWBXnw
         d9/A==
X-Forwarded-Encrypted: i=1; AJvYcCWU5/rkngwr6hie5NKld61Uq1LcDXSZtfsgdKU4rUd7lkkOaXWKjwUaWnmrWZXwEB3MgrBG6FxrW9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1bSW+JvltOUL1Ys26/KnbkRy247Z/K17s0UnpSWUY3V08Yoj
	lcIm0Ff05jqyjrFnvPSKo6oYCOpvj+XI6PXnhfNJ1v/llYmKUGSw
X-Google-Smtp-Source: AGHT+IEGjNq75Z0TNHUOEBobxg7WjOf7EkMLeAY9MH2m2qV3RqnzflX5OCh7d9mVE1/fN1rIb5esog==
X-Received: by 2002:a05:690c:38a:b0:6e3:116c:ebf3 with SMTP id 00721157ae682-6e347c4851amr168082307b3.28.1729097115458;
        Wed, 16 Oct 2024 09:45:15 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d25fcfsm7626937b3.120.2024.10.16.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:45:15 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 16 Oct 2024 09:45:00 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, nifan.cxl@gmail.com,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com, nmtadam.samsung@gmail.com,
	abhi.n@samsung.com, alok.rathore@samsung.com
Subject: Re: [QEMU PATCH] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Message-ID: <Zw_tjJ1E8jyu4S-f@fan>
References: <20241008164624.78608-1-nifan.cxl@gmail.com>
 <uuxiowlqgqs7mq2dfxixw4ryx4zfbygyaji7axfcln3nstdfed@nufwcfs2nj2a>
 <20241016170138.000001cf@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016170138.000001cf@Huawei.com>

On Wed, Oct 16, 2024 at 05:01:38PM +0100, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 20:01:07 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Tue, 08 Oct 2024, nifan.cxl@gmail.com wrote:\n
> > >From: Fan Ni <fan.ni@samsung.com>
> > >
> > >In the function cmd_firmware_update_get_info for handling Get FW info
> > >command (0x0200h), the vmem, pmem and DC capacity size check were
> > >incorrect. The size should be aligned to 256MiB, not smaller than
> > >256MiB.  
> > 
> > Can get rid of a level of parenthesis (other cmds as well), otherwise:
> > 
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> I missed this one when gathering up fixes the other day.
> I'll queue it up now with the excess brackets dropped.
> 
> Jonathan
Thanks Jonathan,
Please also take a look the following patch, it is a fix for dcd.

https://lore.kernel.org/linux-cxl/20241015190224.251293-1-nifan.cxl@gmail.com/T/#u

Fan

> 
> > 
> > >
> > >Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > >---
> > > hw/cxl/cxl-mailbox-utils.c | 6 +++---
> > > 1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > >index 9258e48f95..c82ad50ac8 100644
> > >--- a/hw/cxl/cxl-mailbox-utils.c
> > >+++ b/hw/cxl/cxl-mailbox-utils.c
> > >@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
> > >     } QEMU_PACKED *fw_info;
> > >     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> > >
> > >-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> > >-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
> > >-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
> > >+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> > >+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> > >+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
> > >         return CXL_MBOX_INTERNAL_ERROR;
> > >     }
> > >
> > >--
> > >2.43.0
> > >  
> 

-- 
Fan Ni
