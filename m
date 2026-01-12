Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FD284B37
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256641; cv=none; b=jm5NoDfhf9rDgKJARqDPdqBGLiK4Z1jXNT+ikebhPNetIKgGQf1driHKFOd/aqB2drfFrRD6INHpVAvJf+VrmP05sJQJnJHPKS+7OeutHOeTJTdcTY4OA0K7KY35JTIiUyEOmVMbvguPBNtdVe07qZ2FIAH4+BTjwAg3+hyDg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256641; c=relaxed/simple;
	bh=/y8knCJYpMH3N4ECzUUH6dF+pwF/N5sMXnxLa4mfIcU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVNr+LMYDeH8+AJjKAU+tjw6gaoLdePxnKqPNyK8W/0cWlsaudhIqJC1B0bqPZCIctN1nc9NFr0eWYTG7YoPg7zf+9SiPVj7/bSAlfYHoW9lp8atzi9Q9nZ/Ng+ZWS55TX6fdOy8MZoIR9O4RxIRr0YP2nAuLggYQGrdWxHcKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kniowbD6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kniowbD6"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fb7704cb4so66757337b3.3
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768256639; x=1768861439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93tDfVPq8u+Tj9emFQ/vV5ziIcs6Bvby99UdXUIKp5k=;
        b=kniowbD6CFfeaYUXzne1yJ5eMf8vlLIBgy0Wy1DHp9uJNl+6udGJunSYrDxMy1nAHK
         7EgOVeGqxB+wk7zUMIpu/zCirtBbcUYsw6qMAu+vFELwUuB2kHTAarq1hx82y3c7e1Rd
         gpfbnRYW/0gVG5CCBiPIWrr07/sjByyfYik7xA1LzxoKLjbP2tmdu4qWJ7KHGt24ZKRC
         Uj0jFQi8J/phclhBzq+nDSK94WtGEBCNcvKRf3P2JQGrUiBBbxbTfbK77vWG0YLgNVM9
         w1cK7rql67aNmiR7Y7vwq5RsbuauYqNI8IZTQpWh9n21oPMmpeUByXhtBzog5hszc0wq
         NkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768256639; x=1768861439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93tDfVPq8u+Tj9emFQ/vV5ziIcs6Bvby99UdXUIKp5k=;
        b=Te6mOpKG8NZz6w6Av9xHACBdlNK7oTMKxGdTpK2IqlNvMHBxXDOMdyVlLxSk7bPr6p
         R3zod2qhznaBes1Qj8ngPQbr7APQMx5Ew6O8JBHSUZlnqZS+N3z0aWK+Onzz2KWLcwOx
         sDUGy+MLIxi1ukgY7fAfGw0JZ0Ohk5FayowySEDepFcjpWHde0RmFS3QntcfTutnVsAW
         RbleycWwPUPDhBs3f7sCeR1+keDCkyU/rQv4ZNUxvkGkt7Z6Q8vn7QIdspcWLcOSuRb3
         PAMV62u0vbLCuk2TdmZ7cIHlDlPEIblENu3UR982qlbazoR3CJ/Kl45nKdz09CjXqucf
         pfPw==
X-Forwarded-Encrypted: i=1; AJvYcCUBycNQBMXN0tnPNbTTwTgZ28gsGhEZaB+/T9uV8DUY6dIv4ShJX0rpydAQS/vwuv/5KQ5pdviNKHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmDfLwKu0ul/vChUDweY4HCb8UEWljCS2hrA2bYV9nRKJX03cc
	8RgD6iXtSyG8MvtHy+T/3Z8S/kFTOzRXylPAl5DFCSZwOBFSuI2eitZb
X-Gm-Gg: AY/fxX6REuDqtg6b6ryI4mJP2soMxzO+dwsYPOc52ETLQcmvowt6HeYEHgkuZ96vjzH
	oKTQjlcQ4+9eEV3HJzCpAFAlGB6n68lfy/H1VmFoHgj7F70OMlrPfL33TqGXo/fUuMR4emzF78N
	zBY0tLAG9hi7T4XA0yqxbaEGlvaBY+eH5lElvPTjtIXvpHj+o1dileX2hfF/glZPHk1UGOq9xf9
	BXyoh+NPWvpFbG+U5aWWNqdrwEO2xY46SmSR5kEJkA7jBqa+wl5N5CuOjrgNgtOjLh5/KG+EJ2w
	RMa9y8U7shsr2KWhxz6lUn+Eaw47td3gt+VBss3BQLl5ZB0+tjpqP5rFiS/jDjIYGBYVYS0+E3c
	vhKu69Iu+ibj+MA6dqMrmc4mfOsjdyb3fsw8ILMIMVWr2rdJblTLf63968Rf4WUWa73LEYAYnKL
	JFuK6T9DPD68VWEzvAu29mNyApq1A09g==
X-Google-Smtp-Source: AGHT+IHg4oYTvmbLA4t7OJrLI85GMdr7cAYyTRLnsQMXen1g4JHGV4QB/RwEowm6JLdl3DXj0npvQg==
X-Received: by 2002:a05:690c:e0d:b0:78f:9801:7614 with SMTP id 00721157ae682-790b57fe102mr175177107b3.32.1768256638983;
        Mon, 12 Jan 2026 14:23:58 -0800 (PST)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa55328fsm74577627b3.6.2026.01.12.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:23:58 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 12 Jan 2026 14:23:55 -0800
To: Ira Weiny <ira.weiny@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, dan.j.williams@intel.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <aWV0e03pP4hfqkLo@4470NRD-ASU.ssi.samsung.com>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
 <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
 <693c922448bbc_c04a9100eb@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693c922448bbc_c04a9100eb@iweiny-mobl.notmuch>

On Fri, Dec 12, 2025 at 04:07:32PM -0600, Ira Weiny wrote:
> Anisa Su wrote:
> > On Thu, Dec 04, 2025 at 11:28:40AM -0600, Ira Weiny wrote:
> > > anisa.su887@ wrote:
> > > > From: Anisa Su <anisa.su@samsung.com>
> > > > 
[snip] 
> > > Unfortunately none of the details presented in this cover letter really
> > > show why the kernel needs this additional complexity.
> > > 
> > > Can you go into more details on the use cases of multiple partitions?
> > > 
> > From what I understand, the motivation for DCD as a whole has always been a
> > blocker for the entire series. However, this year we've seen multiple vendors
> > demo memory pooling/sharing at SC,25[1], as well as the development of a 
> > controller that supports "memory pooling and sharing across 
> > multiple hosts" from Montage[2].
> 
> That is great!  Do we know if they used the patches which have been
> submitted?  Do we know if the user interfaces were sufficient?

Sorry for the delay! While I don't know the details of the software
stack used in those demos, I think the root of the question "Do we know
if the user interfaces were sufficient" goes back to the missing use
case for DCD.

So then, can I ask: how can I demonstrate a reasonable use case?
Ex: bringing up Kubernetes pods using this patchset on real hw?
Or something else?
^ This is also a question for the community, so everyone please chime in :)
>  
> How will this memory be presented with the new DAX changes being proposed?
>
From the call today, there seemed to be general agreement that the changes
proposed by Gregory's patches are a promising direction for DCD, bc it
allows hotplug/unplug capabilities without needing to route it through
the DAX subsystem.
I haven't looked at those patches yet, but from what was
discussed today, plan to move forward based on that. Are those the changes
you were referring to? Or the special famfs dax type you mentioned
below?
> > 
> > The flexibility and control provided by multiple partitions is
> > an important capability of DCD for enabling composable memory 
> > infrastructures. IMO, adding multi-partition support back in from v8 or
> > picking up this patchset would strengthen the series.
> > 
> > Let me know if this proposal sounds fair? Otherwise I can
> > separate out the 2 patches that are bug fixes.
> 
> After RC1 could you rebase the series and fold the bug fixes in?
> 
Yep, working on rebasing the series now and will send RC2 with the bug
fixes.
> Before we get to multiple DCD partitions the interface for DAX devices
> needs to be settled.  In the last community call we were discussing a
> special famfs dax type I believe.  Has any work been done on that?
>
That makes sense to me; I missed that call, so I'm not familiar with the
famfs dax type, but as I mentioned above, it sounds like Gregory's
patch set is a good solution to this, so I'll explore how to integrate
with that first.

> For multi-partitions we need some review on the partition (region) names
> because you made a change which would be incompatible with the base
> series.  But it would be good to get single partitions landed and then
> multiple partitions as you have added.
> 
Sounds good. For RC2, I'll keep it simple and just rebase + bug fixes.
> > Also, apologies if these points have already been discussed. I've not been
> > following this series for very long, so forgive the ignorance as I try to
> > catch up. If you can think of any materials/documentation outside of the
> > mailing list or open collab sync notes that would help fill in the gaps,
> > please let me know :)
> 
> NP this has been a while.  I've been looking for someone to take the
> series who is more familiar with the use cases.
> 
> I look forward to you posting a new series with the support you feel you
> need.
> 
> Ira
> 
Thanks Ira, I will definitely have to keep bothering you, though I'll
try to keep it to a minimum.

Thanks,
Anisa

[snip]
