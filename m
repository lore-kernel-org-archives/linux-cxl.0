Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC52214218
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081980; cv=none; b=qsq80a5Y+tOfwilf9wzDriNdXdvnlorsrsVpSMwGpdOhUo5/5oNEJJyNM1YUDFc3eTd5Q14W9BXaLBgVv/SLt5vmxUT69kSKKehiUdb/YQfJeVhSAtaT9CTPFtJEgPQuQureAbnh5wsxjUiBEzMDMS0JXu4qSrMMLsJYi1nIFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081980; c=relaxed/simple;
	bh=Lu62kKHMAjMzflS7Jlf2vQo4LhUNA22Sn176RTqDkwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6ZeS2lRmIu86zW2ju7p9/ADYn+qT9b1Qk0MrFKeTmqjIPpW/7LM8b5zswDNBJc19U147RCN/55u0Fl/nZq6xEjn4twQR4hKA6A1I4FFfLDy/nxcUiFhvDTPMlh4Sr7tRgIeGVIzd0Zd3Tt4dqKIy6trptQRIjyS0eMs6QfwiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ovXM+/vW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ovXM+/vW"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46fd4bf03cbso19806851cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740081977; x=1740686777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1KlFOn7Hg/ku1RTZ3R0CMdwBj99t0GI1rv1OK6Mr2w=;
        b=ovXM+/vWrkZBcNky/EZT6KkymxwUILtIhEBx0FDrm8vblAWSmFGjy5ULAFdee9cRje
         tbazEfal6L57f22h9rWyzAv8H2A9QCb+nmqmqXQr3NCrC2XfU2Pi3bXToYY0Ah1E6mIx
         oIaamsoCRumKV7OSeAHSRde2D7PcstFsw0qBWjTXAP16RtXkpeW7yuKP5KXS2Hww6uh2
         Aj8ffWZBBdCW4hno5CPiRq8KiwS4TGxLJsuLltvsLGUohxJxyEkZsBOlutY53Xjtqb2R
         o3upJL9aPg4ItdXyf2MVyidvX/EjUVQ/0hwuzsvtTFzjLu1i/YiCbizzqGGlfrzHiOn/
         6+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081977; x=1740686777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1KlFOn7Hg/ku1RTZ3R0CMdwBj99t0GI1rv1OK6Mr2w=;
        b=WBn1a3cH1poQjllH3SVmrSNa7nXu8f+So194uGCRGRa3vZxQTcwoQjjyNyuUlRhpfY
         ggEO1j3PYOcxmLhlKoRYODiMMRZ7OlxbnWPjmu4QrHfrMJF87nXvA4VAMauNQN9hpjvh
         vki3JKNZArh2KdVyQE5eBrNCtDr6YXXpAkOD86bjwXwXc74CQhBtkISs1AxbItW3Rthq
         4OrHQ5vflq47Nn0w1f3eJWr2VF2Kn16te0dVeicVPHxT0NPsqgC2ooVCJ8lG8dXN2bPS
         qgckbSy+yER62JGcbYPUfY2m+venlcTBsUJgXXvj+knuwRYdrlT9OYKpjRGqP4dPS6H8
         nMAA==
X-Forwarded-Encrypted: i=1; AJvYcCX1WR2tDjQC+26OQzmGTfR2KrPYTjkOk9dveMKeRiOJtQx7bylPwBd5dqZjZ8VQe5Lmzp32ZJZZPR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5KQiltwG6DF2AA7/HEKpKSoHzMLBgK0uDan9OiGWHfVQUk/50
	otB3G1hqQQAP8IbOTKgLNh4rjOfzE8eMuEyYuH6mLpfa/cHdFuhCnUSlYf4UZdg=
X-Gm-Gg: ASbGncucdVpssNXQSq0cR58PuywPV9fVEYchcXP5JOvfdwqpuNO7VVbxHgD5D97Pzp8
	ZoBw+9e+L1UvRyT9EIulYjUvhc4zc9u/SA6yzZTLlya+edlg+XMJtmIlmp7ZV6lGO6dWz06TsIk
	5mjGe36qvQB8lGUiXkwejYS2kPKolXosmkqOPCBkGDX0MqjBL+p+77VyeAcgvWUulaSe2L2gn0f
	jxoTAKQFDhMtE7W5wGXHHccGWMOMXr0WVRqIWkP0gSM+zCcqNKD0b65iZVQSktXEIPdpAyaiDev
	6K0eLa76N4JE/ylXhYcVep6lku6pcedZtJ3WhKvu1/0UyKiWr5HeKfN0MH7uJzdkAtwScfWDVg=
	=
X-Google-Smtp-Source: AGHT+IFqBXc3noHLl5J5ssCf0WWyGmo3wgivenGX96bW8nMSdpZU57GvoBw1O5ge2vFl9td66zPrCg==
X-Received: by 2002:a05:622a:13c7:b0:471:f3f2:62eb with SMTP id d75a77b69052e-472228ce17amr8517751cf.19.1740081977267;
        Thu, 20 Feb 2025 12:06:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ead6bdeesm51910061cf.32.2025.02.20.12.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:06:16 -0800 (PST)
Date: Thu, 20 Feb 2025 15:06:15 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7eLNyB230-wYof-@gourry-fedora-PF4VCD3F>
References: <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <Z7eEGwFltjWaoX-r@gourry-fedora-PF4VCD3F>
 <b4b312c8-1117-45cd-a3c3-c8747aca51bd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b312c8-1117-45cd-a3c3-c8747aca51bd@redhat.com>

On Thu, Feb 20, 2025 at 08:44:36PM +0100, David Hildenbrand wrote:
> On 20.02.25 20:35, Gregory Price wrote:
> 
> There were some discussions around variable-sized memory blocks. But we
> cannot rip out the old stuff, because it breaks API and thereby Linux user
> space. There would have to be a world switch (e.g., kernel cmdline, config
> option)
> 
> ... and some corner cases are rather nasty (e.g., hotunplugging boot memory,
> where we only learn from ACPI which regions actually belong to a single
> DIMM; dlpar hotunplugging individual memory blocks of boot memory IIRC).
> 

Probably we just end back up between a rock and a hard place then.  Let
me finish this documentation series and cleaning up corrections and I'll
come back around on this and figure out if it's feasible.

If variable sized memory blocks in infeasible, then the only solution to
misaligned memory regions seems to be to wag a finger at hardware vendors
as Dan suggests.

Thinking about my current acpi/block size extension, it does seem bad
that the user can't choose to force a larger block sizes without a
boot parameter - but i hesitate to add *yet another* switch on top of
that. The problem is complicated enough.

~Gregory
