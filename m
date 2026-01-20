Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6CD44DB9E
	for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933135; cv=none; b=es+5WwE+FI5Tg5Pl3g74zyKw/Arp7W0BR3HO2T3Mm+/r5NWvySLW3kAAbji0tFvan57MF9CChCk1rwAMHeoLkmvtGQSTcI4TXjEAB+VwMdioVrdHX3R5qPUEMwNXn90seUqAr/bBiHANvHcyzs5B7CpiZAVkDPEwXbHE1WQUSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933135; c=relaxed/simple;
	bh=XEUWYxPei4NEkgDam7A7un1qS7q4dsbYFTPlbpjhsk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewlCjPtrswes84uknUX/s6PJ8oqlRq7VjvHdRa+6OmATlzp8zIFTLMOHIwNBHpJDd8askMMEniElHTD2kVrX71xMjNTgGODtBjloch7dm/yuZ2V8Nn6JG16QQ97ILxD37rOEuVg3MvwsaBszA1M0YnbVhE1+vrH7xBu10HczrGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QYPy29cg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QYPy29cg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014d4ddb54so60598371cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 10:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768933132; x=1769537932; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UtgC14b32AkerxxtW7iTRCLeOq1ZZH1b7K2qfFqW7v4=;
        b=QYPy29cgzGhNOhwVxsQB7qyLliEa8lwjDch/wP9i+quS0k/hiP4F/aLENpvpEqG0Jk
         /IevR3umxfRc1BmJS6+D81camWZv/b3yFy/6DAi3vEdhNlvyuv9RMyg3YK/8HvwDmFly
         ysKJ4uSrBmnAVcu5RyoFNZSoSNxFvSV3Ng1lvk8OVzENH6cCDto+3K/C6zQ0Y+0fSE/q
         mvBOEgzzQQqyBzeYcl2kDSm0HMoC5eI7F1Y1A677ICp5zmIhaXiAwdbKGyp9qpfuTaTa
         4N2MTE1ezm4kmKm9dVmjP02NfPqw73DwC8r+UWQB49mKu+n8UTvNclf11GTEoKerflTt
         L2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933132; x=1769537932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtgC14b32AkerxxtW7iTRCLeOq1ZZH1b7K2qfFqW7v4=;
        b=U6D4zaomHzV+DR1ZzH7PMAktPMI6T3R7rp7BtD5bEb/ByOfzq3t6WuiHdQVPqyYvC+
         b2MBjmkV/zOLT6QVw8Z1GQ1xZkYaV694OhhHb4QK2ep+XZIyohVxS5UOr2TWKuQgKzUI
         ziG3CxlK7Eblc1oCQ+lrR4nhG3O6RG4giTYzNB9xfrFiIrw6Mj/SS8s1pOZe6kw4OmUy
         trrHiLN/CNPVCIVSaxbNfDHZf/3vxSZLxhOWEyFi68Z/3yF70eNjsVwElRqxt6AZQ6RH
         jg6ebGd5gh05dQKihaZrpn8KoURjvrmDlRD7S2jZ6k+N8uPuMDWUtHdKlbdJgKbTAtZZ
         SL9g==
X-Forwarded-Encrypted: i=1; AJvYcCWBlxWEayykRO/Se6mr+ZqW3UNxR3zqgsMKDXAMzLB+OaSbasTtet+yHhcyP2wDRXWovCAMs+tnp4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/6SnVL7K4urXul+SoVwEXbaoUbMGnkgulFgt7YjwlgVz3/Ja
	HEE7ifY7jWer1amIte4bb3Q4YPIrDKR2kJKdyNoef1J79MDfiUiWlHopZuInAgxMBj8=
X-Gm-Gg: AY/fxX5kLwHixJ21Wqj9DsQTz8VhRhOwHYxuqLoF/p3wmeVxt0ozXKJiG2LymVYV3cG
	sabLNljZUZD98pudBEsQnFKHB3Yn3Boqp/7A+lqoHHHmhQ+W5fWAdzSn5ZBzFWNVdj2bROLf3xH
	rqBuu+Ff3ckxDT1rRsnizGeadVPY/3Uhz2L67dIiBSfhsgU4VaUoVN4mk0IBIycF+I+11KA81We
	Gop7qExxYjbdTotTJZ+ilPFoBAf0MnPJI0vkv2YvCw+crD6PR0UtEDT1mN0oWaXwpN3JfF7RNfl
	Rd1awuCx7vCtNtyvjU1yXwUK9CFVekXLHordplO7VYyEMLUWeEFQGUu0PsbOcaYNGffXWgv4T/Y
	ghMfmKktMT1ssGvT3/+eNXJ2rEtHYd7Jos+Mxgt34qr96X7HWsH7RQm9DrQpL3f6ebATxpRILu5
	mNX2qPV5V9CrzeI8t5+rHheplxk6JFzaBxjtLft6J3YUEdJQBSmNMhvpnG4dRTyGpV3xE3VnvJ3
	pVZl8tz
X-Received: by 2002:ac8:7d93:0:b0:501:459b:6138 with SMTP id d75a77b69052e-502a179c71emr233059251cf.65.1768933132218;
        Tue, 20 Jan 2026 10:18:52 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d6e67csm94446971cf.7.2026.01.20.10.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:18:51 -0800 (PST)
Date: Tue, 20 Jan 2026 13:18:19 -0500
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
Message-ID: <aW_G66HeWLbyiPHs@gourry-fedora-PF4VCD3F>
References: <20260120094744.5d92e34a@pumpkin>
 <20260120103949.7673-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120103949.7673-1-lizhe.67@bytedance.com>

On Tue, Jan 20, 2026 at 06:39:48PM +0800, Li Zhe wrote:
> On Tue, 20 Jan 2026 09:47:44 +0000, david.laight.linux@gmail.com wrote:
> 
> > On Tue, 20 Jan 2026 14:27:06 +0800
> > "Li Zhe" <lizhe.67@bytedance.com> wrote:
> > 
> > > In light of the preceding discussion, we appear to have reached the
> > > following understanding:
> > > 
> > > (1) At present we prefer to mitigate slow application startup (e.g.,
> > > VM creation) by zeroing huge pages at the moment they are freed
> > > (init_on_free). The principal benefit is that user space gains the
> > > performance improvement without deploying any additional user space
> > > daemon.
> > 
> > Am I missing something?
> > If userspace does:
> > $ program_a; program_b
> > and pages used by program_a are zeroed when it exits you get the delay
> > for zeroing all the pages it used before program_b starts.
> > OTOH if the zeroing is deferred program_b only needs to zero the pages
> > it needs to start (and there may be some lurking).
> 
> Under the init_on-free approach, improving the speed of zeroing may
> indeed prove necessary.
> 
> However, I believe we should first reach consensus on adopting
> “init_on_free” as the solution to slow application startup before
> turning to performance tuning.
> 

His point was init_on_free may not actually reduce any delays on serial
applications, and can actually introduce additional delays.

Example
-------
program_a:  alloc_hugepages(10);
            exit();

program b:  alloc_hugepages(5);
	    exit();

/* Run programs in serial */
sh:  program_a && program_b

in zero_on_alloc():
	program_a eats zero(10) cost on startup
	program_b eats zero(5) cost on startup
	Overall zero(15) cost to start program_b

in zero_on_free()
	program_a eats zero(10) cost on startup
	program_a eats zero(10) cost on exit
	program_b eats zero(0) cost on startup
	Overall zero(20) cost to start program_b

zero_on_free is worse by zero(5)
-------

This is a trivial example, but it's unclear zero_on_free actually
provides a benefit.  You have to know ahead of time what the runtime
behavior, pre-zeroed count, and allocation pattern (0->10->5->...) would
be to determine whether there's an actual reduction in startup time.

But just trivially, starting from the base case of no pages being
zeroed, you're just injecting an additional zero(X) cost if program_a()
consumes more hugepages than program_b().

Long way of saying the shift from alloc to free seems heuristic-y and
you need stronger analysis / better data to show this change is actually
beneficial in the general case.

~Gregory
