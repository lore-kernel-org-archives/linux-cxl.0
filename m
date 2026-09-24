Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3E35C1B2
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233284; cv=none; b=n4LwW5bRcqUyTtBZvx9Nt6zoB3bMOsb6LeJQJk1EvJVIKnk1sae+FuBWyOLv5TXx3UXyDqsqeOYwfDRsRyHpYKn/r25Pl63U6oFez0vx8Z2ySdY7fHRPpdyKJiJKvJ9g1RlNilFDfQ9gLFF8NnLzaGRG/dDg0H8dXYzz4eQqwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233284; c=relaxed/simple;
	bh=rzBQSDF9pnJy639yfjCMhJHs/iLtKJrMhOPma1kMNlI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3Bi0HX4k0J/CldyGFwOfImoCXa8WGPfbAM5iu5yqpBMEVbmdCx0frNPDuITDTaXrTYskr1Csxckl5JQbDZ+K5UzLUcKvMBEaHJExmwPzpriEcpdKX4ZCN8qLeVTjzf6aFRoneGy8VUrMI+IG8+HMfmUan6+AFj288iuJ1Cckao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBTgqOKQ; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBTgqOKQ"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dcea9af0so150738c88.1
        for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 00:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233278; x=1790838078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P0jlOU5EOkAbjhXH+RJy8/8QimwaxVf/Jsjq6LoEDts=;
        b=YBTgqOKQu6ZmqXfHOn4O1wiDLx9HejhOyPnxPdwX6FK3vY8XM8xIz9LGPguEJ3zd5e
         LW7MHXmMRt/Ok1kBN6k90jdM/uExLI6mDHwX2Hogv4hSN5qHYPgv/St/CWcSOK6SZZMp
         UGdtxS8WVrbm15xmrHCMAdUjXcw5ak++9D199fu6zospqTTASO+mXXo6huIrr7/QmguW
         LD2JhOsSRYQOVTUUE9RWU799apGdFNiKPyYKSl4DFxYk/H2HuS+mOREOYW93DamMGQ9U
         kFmhQmJv3yEZFtF+TtUxXdY1hWAWqmGb6W+Ml1S3BReYQjmCwMnfwAmkqAUVOxiNyxrk
         YeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233278; x=1790838078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0jlOU5EOkAbjhXH+RJy8/8QimwaxVf/Jsjq6LoEDts=;
        b=uCm0iaayBCq0wcHSP1YhxSfvlEp6fA7yn6TdDtsSRpSAiPvtgP7jngFjpcEuwHXhD9
         41+l0WoDFhdlk3iX+dK6s3NvL0gZJ6ZnXI9G5o+fqvEQt6hG35tuzNYk7x5M/pUfimXn
         AZQollDukglF+LbwiwkfDjYOxvBLTYyTn03lfkcNXb9bgJpBAyHmGr4yOt1Q0p+BaqfB
         AcCILuf9LGiQ433OL7uLZCvS163lkiFeLwy+bhJ8OIej1VPFzd3Ywat7LLyAcJ4f6k5z
         E+h5ptUrCvKv9mUDtwzLuPv+Njnz5aLEHUBCgV18nN+fAQYk+75QN9CaE1EW0paWuiii
         Uasg==
X-Forwarded-Encrypted: i=1; AKwUvBwdi3lis83zF7jwAFCVHgHydgvYvWCL7jlFLhdsfDi6wlD1OComRRDiuljFwK8y3BxAVMvu+LtDYlk=@vger.kernel.org
X-Gm-Message-State: AFuF++kHLfP0gA3vp6buvnq+jr3RfVTli+Y7bexH7BJ8QE3xUx6n4X7g
	WPUOdvUA9nGvjAjyBDd+UYSSFGOmAZG9VfwynwPxSBgjXjZOZFcDNBmX
X-Gm-Gg: AYBFou32nj0nHmpVSxk80AXb0w16m4kkWknp6VQj8Q3Iv45UZ6jZly7vmEzkeYvsc3c
	os2rVjQBVT9hY73SOn1KMYe1UcrlS9n+x4HwgSQgfZ2dKA25CIt7Sfo9qUy1V8Q1qrjiEhoZtta
	+mV/uZXT67av2TlJc81U0gBB/0Je6jLB+hyusnhxa+TSp+q37QjdPrgME5kaLqvwBX7O3Pu69gZ
	C2YWAfQmPyG5WLgF7Hsc92XDZhCfFhwp0kjZSv7VXbu1a1CM8ih3K3JQZs8V9sG/0UdBlQDc8rr
	qhQfhgjddEVPJp+6+CoeppaJ07OmwVvcF/+93Sjm9TFXbx//M35Y1wEZG4ywESjUQzB0dM2VaaK
	z2xgEei4YQT3oBm2joXFaHIa3pAASmOKrBeWe+8eiDI8iKFLajIyiWF4bIhaKfXPqzpYfCItoVX
	VqGmPJ2S3p6wFwW34AfAfmm7Pff9ndV1Tp9up8oUmRqhFupMOPm2XxQTVnSOkRJyJ5DpTS/3Zq4
	5G4/ESIV1kzOsdvS5GAROGGz1pS1yaBVo3TyQsR9XSPzDVElowvmM8/11XM+6C0nmyT7BfLCNZX
	EfoeZV5OgItyZ9Ny
X-Received: by 2002:a05:701b:4183:20b0:141:2f15:552f with SMTP id a92af1059eb24-1450404c420mr1146055c88.9.1790233278142;
        Thu, 24 Sep 2026 00:01:18 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9895c1asm10626305c88.12.2026.09.24.00.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:01:17 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 24 Sep 2026 00:01:15 -0700
To: Jonathan Cameron <jic23@kernel.org>
Cc: Richard Cheng <icheng@nvidia.com>, Anisa Su <anisa.su887@gmail.com>,
	linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <arTKuytKaUo65G3w@4470NRD-ASU.ssi.samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-3-anisa.su@samsung.com>
 <arH3l77e_qQuyYWp@MWDK4CY14F>
 <20260924015551.02cf0201@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924015551.02cf0201@jic23-hlaptop>

On Thu, Sep 24, 2026 at 01:55:51AM +0100, Jonathan Cameron wrote:
> On Tue, 22 Sep 2026 11:44:16 +0800
> Richard Cheng <icheng@nvidia.com> wrote:
> 
> > On Fri, Sep 18, 2026 at 01:30:11PM +0800, Anisa Su wrote:
> > > From: Ira Weiny <iweiny@kernel.org>
> > > 
> > > Devices which support Dynamic Capacity (DC) are configured
> > > via mailbox commands. CXL r4.0 section 9.13.3 describes the use of
> > > the Get DC Configuration command in order to obtain DCD partition
> > > characteristics.
> > > 
> > > Implement the DC mailbox commands as specified in CXL 4.0 section
> > > 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> > > information. Disable DCD if an invalid configuration is found.
> > > 
> > > Initial enablement for Linux only supports one dynamic capacity
> > > partition. Read all the partitions the device reports but validate
> > > only the first, and configure it as 'dynamic ram 1'.
> > > 
> > > The specification requires that volatile capacity starts at DPA 0 and pmem
> > > starts at the DPA immediately following it, but DC partitions only need
> > > to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> > > So a device could leave a gap between ram/pmem (static) capacity and its first
> > > DC partition, or between one DC partition and the next.
> > > 
> > > However, Linux chooses not to support gaps between static and dynamic
> > > capacity, and requires the first DC partition to begin at the DPA
> > > immediately following static capacity.
> > > 
> > > Based on an original patch by Navneet Singh.
> > > 
> > > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > >  
> > 
> > Reviewed-by: Richard Cheng <icheng@nvidia.com>
> > 
> > I wonder if we can have comments in code explaining why linux doesn't support
> > gaps between static and DC, otherwise this can be a bit confusing why
> > the 1st DC partition needs to be immediately after the static part, at least
> > for me.
> 
Hm... Gregory asked the same in v13 so it's definitely a valid
question. It would require some tweaks to dpa resource tree management,
which currently supports skips (dpa not used but belongs to some partition)
but not holes (dpa belonging to no partition). It shouldn't cause too much churn
(although I haven't looked that closely) but can be done later when needed.

I didn't put into the comments/Documentation because like Jonathan mentioned
it's basically because we are lazy.

> Because we are lazy?  :)
> 
> Or maybe because the more we constrain the hardware that is supported
> the less variations we have deal with and test!
> 
Yes x100

> Jonathan
>
Anisa 
