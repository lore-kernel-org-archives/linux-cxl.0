Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACA307483;
	Tue, 24 Jun 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801621; cv=none; b=Mi+mWV+C0B4hs6X9SCQUb5dg+65lEAFRUhuu/9oIAfdikUBFwY45NDMGbnDEmDcSBTnbXYRhz8g0oH837AbQn1qLUT/hSN7nNqkBwLyX90lDBtsVRI9bK0Di9rmRW6oUUGq/6yTnssjbCT2+lvqLR3spAqT4dd3tGhDGRlfSQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801621; c=relaxed/simple;
	bh=H96UaVMZ2NjDXytS4I6LKdfHpQjgJ55mU0qGKk2dKRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRG+nsDrk/OB0t4YpI2Leh/+KHS7XDUM67/A1l9cYODq+QVhESo/8MFbTR5Zv5zF0QlO3zA9HX5D3C5pAEyMpizPD27Qch2F7wyp4+dWELaZ2k4S43pn6JYHliM79CUKUZpq9rNSsB66FGghnFut08pN0h4/lnxUiHW+pVDtYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7itt1C9; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7itt1C9"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so2218363276.1;
        Tue, 24 Jun 2025 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801618; x=1751406418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X4FkzK1vIHXXkT/xfwGQHLL5/iBSkQzdD5mcVSep68=;
        b=b7itt1C99Wtjsp5rW4vMLwRS59E1C6ISD22RZvKGlrKLBY6A7Dkkfj9nDCPBKQdz8e
         AdwjvHV9vXPFsf42sjfbxmi8CXaNoPJP/sbucZbQTVSKJT4ZRDY6YJHq8wR0OPUlGdiE
         lVRHRMielmE33JYMwrIrNSWPChpEM+WfL/ROJ4fW8Mfrm8wsdv9GQau5uhrtH5Ea5SL/
         0gClT19CF9R09clqK33pNjQoT9DQT0C8vchar2x3QQi3q52mYjcIxvySKUgcxVJHC2pf
         L95zbvpLww0Z9qO/wjZDTvvJnKKsSUwNCeNQQ9vRp6h9+mvbR7LQgy9Dulw2MZOxtndZ
         mJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801618; x=1751406418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X4FkzK1vIHXXkT/xfwGQHLL5/iBSkQzdD5mcVSep68=;
        b=aMZmJiiEosJB79tF/W32at0tc3B3inEVb3hzgbFExqN0rfKx2Ffl5iVS/ccjHyChbQ
         +WDDpb8NG9cxzebcXWr/C4smW+9fMpBJpNuslh1+1hrBXrS7RHM8TC00R4yRCEQnar5Q
         g8FnnAiLl9YQf0H7NW5jClS1adYOaINbogFoYGcZZU1+iSZNRN0vtQj+TwPe+JbHwUQd
         0bezGe2gsV4o5ZG2AhgEBJx09GZDMX3JTxmwwgqw7iUcdoxhyf3ox+0KLGHvTrZ+4E0/
         j3SRHGks+nkrTp6fTmsIX2TCIKEjUqzCPWfxYzBX3/YwegMx24mliUCutC9C19bKiNeE
         HexQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzd0hjcLiRpYQNHXUaCMPB2zjjnkaFYQBPphhBQ9hJt1RCNa13mLTSrSQijC4NPdV4J/45m4/fgms=@vger.kernel.org, AJvYcCWBkkZhXqoFL+Qmmk3Yle+aPPTnRxQ2vthKAa3Bc3y6rYc2ZEqJ9P7HCp/C2Z78Rh0zFqjjSKu48XaKhv7l@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGtyqb0zPY+9GZmT+j/LfGWZsdiXPR/78LYHHsl7i8HmTBlDT
	g3KPICFAlj6tjrGIAgOIh5pQNaBgYflGI/sIx2/hMuJ6yiwyLDssGD6H
X-Gm-Gg: ASbGnct88cg0246nsUUWTL+k/Ce2wZTtKwdHCdVJwwwcQM70lVSUrSw6znPAarpRwPk
	R/gzqTernqRL0XZCPZ2ML76UhIvbKqWkK5uhyNsw3dp4FYJR+prTdnF8bNM/IAP2BuvmVX/Vye+
	cD/JoaAz+UuAHHxRsx0MbinKZVYdbbIQlLgTPIPGIVwbF91jTVQ7JKvsyGop1FB+BcCxfINUpKv
	KsRrClO1Qz0CArJYEi4BLDez4MeIGrNgncYyxzMfydTb6DJTF033xxN5JgdLm0HcNhV7RcBVoWA
	mOXvYMzr2XUCbjrUaBZDT3D9vLM14vCQhdZd8qhFLP+0w7wAT4RnLl9RD4yxqw==
X-Google-Smtp-Source: AGHT+IGuHgYXMzcha0KcT+CIr9rLcM40d+eszdLfZC66yc2GwoBIh+Acn+v3VdIm2K4NgvN4YvrwrA==
X-Received: by 2002:a05:6902:2401:b0:e85:ea51:fd00 with SMTP id 3f1490d57ef6-e86017a7b85mr539913276.6.1750801618260;
        Tue, 24 Jun 2025 14:46:58 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aaba56csm3270264276.3.2025.06.24.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:46:57 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Robert Richter <rrichter@amd.com>
Cc: Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH] [HACK] drop zen5_init checks due to segfault
Date: Tue, 24 Jun 2025 14:46:54 -0700
Message-ID: <20250624214656.96471-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aFo68StiDKzLjNdS@rric.localdomain>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Jun 2025 07:43:13 +0200 Robert Richter <rrichter@amd.com> wrote:

> On 17.06.25 13:33:18, Joshua Hahn wrote:
> > I was hoping for some help in understanding your explanation here -- I don't
> > think I can see where the dependency appears. (In particular, I'm having
> > trouble understanding where the efi_rts_wq dependnecy matters during the
> > cxl_zen5_init function). 
> 
> Here a temporary patch with an explanation in the description:

Hi Robert,

Thank you for this patch! I just tested on my machine, and can confirm that
this does indeed fix the problem. I'm not sure if this will be folded into
the rest of the patchset or if it will be its own, but I will add my
signatures below.

Thank you again, Have a great day!

Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> From a540b814d48574b67a9aaa97a5d7536c61d4deda Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@amd.com>
> Date: Tue, 13 May 2025 15:02:16 +0200
> Subject: [PATCH] cxl/acpi: Prepare use of EFI runtime services
> 
> In order to use EFI runtime services, esp. ACPI PRM which uses the
> efi_rts_wq workqueue, initialize EFI before CXL ACPI.
> 
> There is a subsys_initcall order dependency if driver is builtin:
> 
>  subsys_initcall(cxl_acpi_init);
>  subsys_initcall(efisubsys_init);
> 
> Prevent the efi_rts_wq workqueue being used by cxl_acpi_init() before
> its allocation. Use subsys_initcall_sync(cxl_acpi_init) to always run
> efisubsys_init() first.
> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

[...snip...]

Sent using hkml (https://github.com/sjp38/hackermail)
