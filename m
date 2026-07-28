Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685438837F
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 04:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212071; cv=none; b=HXbqWrpUmNZn/Z6MsoWQoRBBItB+MBRPWu5iu9e8aS7Vj8Ly0XY/6dRizII0B61N9fXz2pqWRKSYMo2Bf1WhB7wjq12U+wDN1Zo+0NJ9Wra0cJGx1zC9tNguxjy34CF23QEvXXslOM5xIHr2Oru4brrAMrDDfYjMYhTauaTZwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212071; c=relaxed/simple;
	bh=RH42sLA4MuGPpZli7KVq7uoOU5s+9wzFRhN0P04gNHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gejvoAjiFhUssBGDIDX+sUC8inWkcTSUXaT1h0uXryrzR+jQTX36U7ez/08oc3Npq6i+O+X2aKJ9mPvM+Kj6CwseKX4OCh5Wjp700Xlj3QIQW/uYgNF8XynElAsRF91kvJFaLxZmUtAGtAhPb3eKh7VxQj46hI/zNvAW8ZTN4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l7WRVR7M; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l7WRVR7M"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c16ac21acso21979641cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 21:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785212065; x=1785816865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aN5W11Hsh6MzAnuT/d7MxNwGLL+Nh74FFhNYp722hFA=;
        b=l7WRVR7M0bkfomr7NEcDJmiOpwSHNzsM+ofVk9YD4ioMJAeZ1laeytn7S8AEjoKprb
         Pms233v+Xme92oHA9yXs/C5tG/eMsooav9dzuXEKSgvAvy6dypAU4cQJTIXETdXnD6+c
         BMnuZmJ3e1nXYnFSnZomIGLiMGw2nWTo0EEmMRFG2uDtZ85nG/udlvm7jy7F1YaIs1kD
         IRxGNW1lNPYtRuHJgGjTt+wa6WIUUEdZw6jX0hgMKJGk3e4+N9OK7kZujb5ySMFeGIRN
         ioQmgJ30H+YE09c4hyNdZeXr24yoHstncEcMarlJjkoSnmCmHR9m7c/L1ZmHqzOLGV9Q
         GvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785212065; x=1785816865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aN5W11Hsh6MzAnuT/d7MxNwGLL+Nh74FFhNYp722hFA=;
        b=VrLe0IvZLU1P0fgD01Op2EU3kHiVnnZ+PtDdKHKxhSFovz1oazgvJYCwQI+LffL5AV
         /ODVRZc3likM+SiTd3iIShMdh7g1Ubcs0OnuAxkA7tq9PBHA7IfD9CBQHka+3znFNmFq
         eHjc9LGtU580kaw7Rpf5M1WyuJdFukSZ4/uOLnaByORBx92l6o8uno29IX/hyaUdN1mS
         AhwOemjccDGe21d75DheyiPiMFlFk5zgbcUqpHVHI6Vu0XeIrqjN5PsCGyQ2Zriqxi3m
         wHRYd3t0SsFjovsJEM6z51X3nGtFpQcnucLEv36rC512fl6faEukhP5qUuxznWOPXaRQ
         284w==
X-Forwarded-Encrypted: i=1; AHgh+RrF3fzAqd29V6pbmV3oOjD6SITiBVKlHna5VsADGTr3gumKUP3r3dfNDTreEQHaPX5PdJE7/yyRVBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzT/1jPWWcEK05AOCAKAcH+BqW5hQijuqQ6v9GN6pJJ1nrjina
	YMO7NTdo8O3aGoOpRcyJbQnAExwwhvnR+OBCVf1Vu+2W13HfRH1oARy1lQLbhCsOBxw=
X-Gm-Gg: AR+sD13hB7XrsjBXIt6ateODGxCmimbMvIWGQfrxP9KTpvO5LC4Dmv5WzK98szRdrjV
	iz/joMIn0CFYXuc3FjcZzlbZipesugKIYrSpgKwBFPjaancRIzIPp9vWrIbXv2y8Pw7V/ZZZxJX
	gX53uzpYZjXjnf+scH5W8mfxFyXD84sxUGFB6ISXTZ8MhSe5vm0LuLS3N8KhehqQKKg9Fd2ljDd
	ezL2/3fp2HQRN2JLYomrSqtqs/q1ej4dj2Yjx96HAkS01q3fJWEsKdxEWo9LozlA+BDvrmGNaM6
	ar3UyQA3wtX2BtIIUXZIRXNChdpDMrgqJ1oNcM/GwdcZ7ltOWVkptTISeR8OyVcpBf0Tf8ja9X9
	YAWil8i/+Qik53Mj0LHsABHDf1JUnwgpM+BAcjOftleWbuALkX41ji6ERgxCX1cb7Pq86yibwfL
	gBlSGChW7eMAjKIPIP30kk5bVzZEuFiTDuo6+jf3H/QjcNpz9ttJkKTeZnpTa1KnJhNuvW
X-Received: by 2002:a05:620a:199f:b0:930:b440:a63 with SMTP id af79cd13be357-93302748796mr59604885a.80.1785212064648;
        Mon, 27 Jul 2026 21:14:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de657111sm760520085a.38.2026.07.27.21.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 21:14:24 -0700 (PDT)
Date: Tue, 28 Jul 2026 00:14:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, jic23@kernel.org, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, 
	danwilliams@nvidia.com, iweiny@kernel.org, ming.li@zohomail.com, rrichter@amd.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, sreddym@nvidia.com, 
	smadhavan@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com, 
	kristinc@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH] cxl/region: Restore passthrough decoder enable on region
 re-assembly
Message-ID: <amgqJDkOyyzMau2R@gourry-fedora-PF4VCD3F>
References: <20260727103743.63343-1-icheng@nvidia.com>
 <d96567c3-df6f-4008-9678-c4fed3787309@intel.com>
 <amgQUnkQ1VjyXtzx@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amgQUnkQ1VjyXtzx@MWDK4CY14F>

On Tue, Jul 28, 2026 at 11:03:37AM +0800, Richard Cheng wrote:
> On Mon, Jul 27, 2026 at 01:25:48PM +0800, Dave Jiang wrote:
> 
> I think this part is talking about physical remove/insert ? sorry maybe I commit message was too vague about the scenario.
> The case here is a SW-only teardown via sysfs, this is what I did.
> 
> """
> $ echo 1 > /sys/bus/pci/devices/$BDF/remove
> $ echo 1 > /sys/bus/pci/devices/$BDF/rescan
> """
> 
> No physical removal, no power cycle, no link-down, no reset. Linux drops and re-enumerates the same device, which never stopped running.
> The endpoint HDM decoder is still committed.
> 
> The device is byte-identical before and after, the kernel doesn't clear it either, the decoder is locked and cxl_decoder_reset() returns
> early for CXL_DECODER_F_LOCK before touching any register. The memory keeps decoding.
> 
> I don't think anything needs re-programming here? the only thing lost is kernel-side bookkeeping on the passthrough decoder, which is
> freed with port and reallocated with F_ENABLE clear on rescan. The endpoint recovers its state from HW.
> The passthrough decoder has no HW to recover from, that asymmetry is the bug.
> 

Being a passthrough decoder is just a special state of a switch decoder,
it doesn't necessarily imply programmability (Enable, Commit, Lock all
technically still apply, it's just ambiguous what they should be).

Wonder if we're just not setting these intermediate decoders up sanely.

If the endpoint is locked / not reprogrammable (commit / lock) on the
first go around, maybe the intermediate decoders should be force-locked
and not have F_ENABLE cleared on teardown?  It's not like this actually
changes anything on the hardware, it's just bookkeeping.

(although i will say it's been a bit since i looked at the flag state
machine here, so i could be misremembering what the rules around ENABLE
are i this context).

Curious - what happens if you fully unload cxl_pci between
remove/rescan?

~Gregory
