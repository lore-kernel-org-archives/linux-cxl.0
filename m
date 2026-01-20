Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFD43E9D2
	for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934323; cv=none; b=iDGI4pOpMw7nQlSfeezJGbeE72clq4k5TlwZKUptsfkpyyMtY2Cvs3n/z6tmhFsCZO+EAFfr390F0c06q6ZRAbx9fS0X9b6Z+NrwEvjtiRJtNyjTQljMZXn3fY+L/I65HQg/zG828Bk+4FTkRrI4iFvONl2a4lA1zjSaH9Qhb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934323; c=relaxed/simple;
	bh=YmhekH3BtLWUqg6+5Ty3aH1uKKxcFx123EWvmahHQL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtC409wOpl59umw/bdyERKxUsyfqGbLxOyEbTgLfrtWtvl9MgP3ntrlTIhpLiFdFkDB8fLLQFrJ+1xXwbwp4beOiJwPNirMSAyCEdP57OjPAd6lG6fmWKZ8fBekS6TSzZG8GyK6cAWNNILnpiPCu0DldMBcbjAJU4k7YvJz0r+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jCp42yeE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jCp42yeE"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014e8a42aeso61252221cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768934320; x=1769539120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOV934DYRc9ERWmoCuXpOFxaUel0buwbS4A/jVjuySc=;
        b=jCp42yeE+qfiGMUfLqVlxCb/4aF1LniQxlCgbIBs/+HG9prS8N8Z+kIj0TGK2BJVAh
         eEd7EyCT3SFfo8Ku1HrUzcDrfdIRq7oRUi8XYM+9CpsrOEaOwn5Of7It5rhFZ8dHaFZ7
         dvS59pmFwMCMBKOsX5pS2OVAYB0JEltjJWHTZ9uZ7Mko7SCauveD1/H8LWHa2UW0V3QL
         u/mMehgWeG2KuBhyv7LXdO/v5t3WzBGO4uLRE84zIjwuojYTUyLKCh1SuvPt5m0JRrJA
         Zwjge3uO++RJblexiBQPlbIzVxvzmO67VGPhL8QpaZ/Tj1VOr/3EOQeRdh1/kVfORknv
         LMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934320; x=1769539120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOV934DYRc9ERWmoCuXpOFxaUel0buwbS4A/jVjuySc=;
        b=hxxB+E0daBASe0cYkRqddBTRsKXAJCrj/ZKageqp1m0LONZPj+k0zwLq2xqsy09fUn
         W+jDb/+Q99gN28uIVKW2vshtl2jKK8Wfqq/MI+twkuiKyj5km/1sLJ8O3Vp5I7/03j3i
         GeKtrwq6A4wXNrl1o2QmuVW3NyRSmlTTR5yIiZk2Gno2YDrLHiS2Twd264BHRjlFhao3
         QsOoTjgO1DH026Q2/H4E7AiRW+/aMKZcIu+9sWMz0jzjAllAMliwDMifhVPqh62nkXD/
         YmZ5pt/Hd7bFkpTwPM4jdEvfjVbTF4e+TURDDAGqqEfY1mQkPSsvTe1I18Fl67KKpAgE
         /XNA==
X-Forwarded-Encrypted: i=1; AJvYcCVcA1wbcCmijlEgAOA1+2uMM/ZY4wBjacz7dZcjcBBXaKhNxmN1cwnguEm+OKKc/W2sZjTRAu9LFns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20KG6ILCCQTv/rZyXazzIr6dtx4jZ92R2DqUSnn3QZHr2poPw
	LNLDVM5yr8CETgQ6g3KHbSEW0v5BCSRUnUq3oBX7z5j6a2jhMCABEC94EZHGmsup+vg=
X-Gm-Gg: AY/fxX5iPByUhlMvvlqyvfeI3P5Lx/bVGWaT+sKDFrq/fK5/kBPmuJlmUdeGO72RECM
	qG+NCxXSfD3KXLyfSTnLkyeSbVD+RoJwNVoUcPGlSOPClJNGFFbL4wA5XeHxzijPfQfIBaxCQgU
	cp8YMLJ2r/ofrqz7sbZ5CcbtvTA1B9dW1zHwSGNt/YX9uX25GxJxfp7B6HBGr/93pxJUdKfbav5
	LvJ2RPkfW1hassz1GecaUiGxEFfzYguN8i6pT9pm0m8IMH7XVIJvJoS8HU17HjY06srylowH9uS
	mxunTCesNCF6L4HU4U5/EN/r3A9XWMo6BDaZ0emcYlnWpvg94iMr5bJ43S0qDy6DhElB4dl3PlU
	eiiOTQ9xxWGXEkIQkcc5IKlDZYOCMT3XxnPV7Wmxe4D51MrqhrxMsok0lz7WRppbhAuMTq3Zi8y
	kWFIHk7cmUTSkR3w99/QEh7Zm2U/hV116J6AXLuugB9umbAjm5m5G8K857qlX8Ce1K+l5uRw==
X-Received: by 2002:ac8:7dc2:0:b0:502:9c4f:e284 with SMTP id d75a77b69052e-502d84dee8fmr37431281cf.30.1768934320230;
        Tue, 20 Jan 2026 10:38:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f296sm105269001cf.12.2026.01.20.10.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:38:39 -0800 (PST)
Date: Tue, 20 Jan 2026 13:38:07 -0500
From: Gregory Price <gourry@gourry.net>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: david.laight.linux@gmail.com, akpm@linux-foundation.org,
	ankur.a.arora@oracle.com, dan.j.williams@intel.com,
	dave@stgolabs.net, david@kernel.org, fvdl@google.com,
	joao.m.martins@oracle.com, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhocko@suse.com, mjguzik@gmail.com,
	muchun.song@linux.dev, osalvador@suse.de, raghavendra.kt@amd.com,
	wangzhou1@hisilicon.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
Message-ID: <aW_Lj0q6swLVR8SY@gourry-fedora-PF4VCD3F>
References: <20260120094744.5d92e34a@pumpkin>
 <20260120103949.7673-1-lizhe.67@bytedance.com>
 <aW_G66HeWLbyiPHs@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW_G66HeWLbyiPHs@gourry-fedora-PF4VCD3F>

On Tue, Jan 20, 2026 at 01:18:19PM -0500, Gregory Price wrote:
> This is a trivial example, but it's unclear zero_on_free actually
> provides a benefit.  You have to know ahead of time what the runtime
> behavior, pre-zeroed count, and allocation pattern (0->10->5->...) would
> be to determine whether there's an actual reduction in startup time.
> 
> But just trivially, starting from the base case of no pages being
> zeroed, you're just injecting an additional zero(X) cost if program_a()
> consumes more hugepages than program_b().
> 
> Long way of saying the shift from alloc to free seems heuristic-y and
> you need stronger analysis / better data to show this change is actually
> beneficial in the general case.
> 

As an addendum to this:  Maybe this is an indication that a global
switch (per-node sysfs entry) is not the best decision, and that maybe
there's a better way to accomplish this with a reduced scope.

hugetlb-only sysfs knob
	- same issue as current proposal, but better placed
	  why would you only apply this on one node?

prctl thingy
	- limits effects to just those opting into alloc-on-free
	- probably still needs hugetlb-internal zeroed-pages tracking
	  but doesn't require the rest of the machinery

do it entirely in userland
	- modify the software to zero before exit
	- use MAP_UNINITIALIZED
	- useful and simple if your hugetlb use case is homogenous

there's probably more oprtions

~Gregory
