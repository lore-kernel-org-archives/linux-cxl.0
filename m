Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622775;
	b=svU7sX101mjH+ygMcc2MEd8FU8YVNlLZg3NUC0SRuPeeQZK18arC/xhzMfEADDKKdGPJ
	 BJWbdxM9uCsekmxOyMYHjJGTI18pKZjx+v/FF2DJe1w2ajDXpbxteAj0do5OS1TDKNBoR
	 GCvsHLqyYZjN4B+AhFau88Fi7UqcFiPGNFsJ/6z/hDs6bvARY09M11xQP+gddPVvz9p/a
	 Gzg2n4dFJaW/U13XxZIOOemXzMfGLVakGAAYxcO+bKMVS9tKRgHlvKnf8KADad1h1c9IJ
	 BCql1wv5pWXDyqpG6SK9y0DTnMvJ/UD/P3/9CD+5sosZxLYU4PEZLDJvMBDKykIF3rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622775;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MQ19bcwaq603ARreLcaNlnVPX00FfirjVvY5HRr13fo=;
	b=kHAX4IfSfO/VbzEgrJ85SjkFfcN8HDnvxjlPVxNmvwSySLPUBYDztVDKZ6FHftE1DfC3
	 GPYxTuagFr8i76HNQHILQRE0mAZj+Z23GMzfPS9P7zP8M2fKGpfxO3nHBycY3Vy5dvPYA
	 EUliD34TER6MyiJ/k6a7rOE4kcJ+MAzfAqPYEwJsF4tnxw/icYaffWKOBfIwe4HRA2CzD
	 xhEkiKzY8BlYG86tK7H6tbj2bAYUjttcF9VkNTUHgfu2wJwPiuOW1K3avG54jQfu1pLoY
	 6SR6t7/oiCuWAVgAuWfbMCc/CDYA97RKv+tExBd3uv/FJJbkL+AXU+UUvK68YNL6jcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A6606A327
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 12:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA3A6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso1581819a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 02 Nov 2026 04:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622774; x=1794227574;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQ19bcwaq603ARreLcaNlnVPX00FfirjVvY5HRr13fo=;
        b=lKgorTRpgQAIOlJsWcyEbwGsX87qUGCN7e/Vx+esvHv/kqhmhS5Ws0uJz4r8CQtu70
         PbxK8hx2miQt+ko3BPjYMrQ9jo7TwV2vOWsiFOWsRWsDovMMHdkR4lbievH6iaeMnpfr
         010K9lRbmHA87qAA/RKFoC1rzCHgBO2eYA4JFAzqKFQcoN/I4ENf4Ihl1tF31T/3wcSo
         oy+bR+tPz74hS7qsGQthW7p+OHelnyfWAbjO1cpCD1WSzdhW+d2L+P3Y0XeY/vcx8unA
         4uh3R2Gl+W9voMzgLirODniwxyOOVxkNCnozKAxHFy73YE50OlfNAGJKaNxgJIUS9FIj
         sJ/w==
X-Forwarded-Encrypted: i=1; AKwUvBzBk464cYh6CHVKQ/sTkoT5Wu62BN0Tt6Cu5rgD12ZW3ocLFHZJFK0N+uGBA3Cpexk5uhGEBh4hKgE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/waZbLoJnzII3b5EIlkyAa1CsIpLUaMCY4eyeBG1MgCcKzjeRW
	Kd3pqXAk4GKP54jEsHnCfVfUW/aDDPpJqvcvYixg9Ly0sfFdvK5dA8ReO8AcRhJdF9z9
X-Gm-Gg: AYBFou0CGyOcLcdGrhN+hBZNM0ec6vnBmNsdU5INl055S+x1W5X6mrh2x1E6zt1cvtR
	FKcoWGSCv+b+IP6uuwL12t4VE12DTdsm3AooY24qOO9amy95kMSkT+4P2Z6PkpQ8b+MCZZ15Ma8
	b6bnw/T019gJAozEXgcAbOaONU6tJripeFIwJ0olOhY2a/34yhWZxp7CVxUCzU6X79gtz2jGqnH
	gDEDvkECzHr5APDZNP66wCk3ISdOYECED7w9RwkpAunXKBnzu87yqMC2q84bALPZSc/1J4tkzCz
	olqUWLFJb82HYknw2+fpzgdWrS72rRc4Gjr7MfaFedAyQnGiJ0Jn+46DWLesBzQaE19FVQTKwXA
	QoXFdMk19C2Q7A1b+njt1FAFUgNsvEaRZH5AYQ+9kr7Lh8XwRSF3yT3C49cDxZEFmhh3ikTYWUZ
	gohh8Pafga3OllrweCy18usWfHP5JYBNZ7DOvFG6fKulA3X9iq/7YnB6ol5+z/gyA4Wy+kxGu0P
	WbIlQeZEt5Ts8KvsNcC6CgZEKC91AJxyymmY2fpxPrbpJTjNtoc3TEvMor6Clbh52UToLwqNRRQ
	8UoSkKXjIJkU1nPQHJ380jWOYaJVRBZfaDfA5x8LrX5P8CrsWW3AtxgzkKYFQemQgO2bZ5cf0D4
	ygqR0pIfa0e8QwhCkWCL62LZaoQmNiDrosiEXT9ibDgOCNGlB2zJUMxXawDDx
X-Received: by 2002:a17:902:e890:b0:2e5:98d7:821e with SMTP id d9443c01a7336-2eb364026a5mr93260695ad.7.1793622773885;
        Mon, 02 Nov 2026 04:32:53 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392492fbsm27101845ad.32.2026.11.02.04.32.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2026 04:32:53 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cxl/edac: Read cached DRAM event records under the
 xarray lock
Date: Mon, 02 Nov 2026 21:32:38 +0900
Message-ID: <20261102123233.74598-r1-ai@linux.com>
In-Reply-To: <aug-xbNiSauAAjjx@MWDK4CY14F>
References: <20261101013418.87326-1-ai@linux.com>
 <20261101013418.87326-2-ai@linux.com> <aug-xbNiSauAAjjx@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Richard,

Thanks for going through the whole series so carefully. v4 is out
with all three of your comments addressed:
https://lore.kernel.org/r/20261102123233.74598-1-ai@linux.com

On Mon, Nov 02, 2026 at 03:56:17PM +0800, Richard Cheng wrote:
> Did the bug actually happened ? if so , can you provide the error log ?

Only with a test-only delay. Without it, v4 ran for 1800 s and the
unpatched kernel for 900 s, with four repair loops and the host
injecting events with no gap, and neither reported anything. With
mdelay(20) added after xa_load() in cxl_find_rec_dram() and after the
lookup in the sparing path, the unpatched kernel hit this after 120 s
(trimmed):

  BUG: KASAN: slab-use-after-free in cxl_do_mem_sparing+0xed9/0x1000
  Read of size 2 at addr ff1100000670732b by task c1-repair.sh/153
  Call Trace:
   cxl_do_mem_sparing+0xed9/0x1000
   repair_store+0x1d9/0x340
   kernfs_fop_write_iter+0x337/0x510
   vfs_write+0x4a2/0xfc0
   ksys_write+0x111/0x250
   do_syscall_64+0x10e/0x5e0
  Allocated by task 68:
   kmemdup_noprof+0x20/0x40
   cxl_store_rec_dram+0xb0/0x360
   cxl_event_trace_record+0x617/0xd40
   __cxl_event_trace_record+0x14c/0x1d0
   cxl_mem_get_records_log+0x27d/0x540
   cxl_event_thread+0x14e/0x1f0
  Freed by task 68:
   kfree+0x1e3/0x5e0
   cxl_store_rec_dram+0x154/0x360
   cxl_event_trace_record+0x617/0xd40
   __cxl_event_trace_record+0x14c/0x1d0
   cxl_mem_get_records_log+0x27d/0x540
   cxl_event_thread+0x14e/0x1f0
  The buggy address is located 43 bytes inside of
   freed 128-byte region [ff11000006707300, ff11000006707380)

Offset 43 is media_hdr.validity_flags, the second read in the sparing
path, and the record was freed by cxl_store_rec_dram() in the event
thread. I can send the full log if it helps.

So the window is small in practice. The race was reported by Sashiko
from reading the code, and the delayed run confirms the free and the
read can overlap.

> Seems like the root cause is that the cxl's rwsem was only protecting CXL
> topology and DPA, while leaving memory problem's entry ( those xarray entry )
> without protection.

Yes, that matches what I found.

> Using xarray lock is fair for me, keeping the access short and the entry
> already use xarray as bookkeeping, though I'm wonder if there're better
> alternative for locking mechanism. we might want to discuss abit about that.

The other options I looked at were kfree_rcu(), which needs a wrapper
struct with an rcu_head around each cached record, and device_lock() in
the repair path, which can deadlock against unbind. A refcount per
record would also work, but it adds get/put to the event path for a
lookup that copies one small struct. I'm happy to switch if you or the
maintainers prefer one of these.

> What if we copy the whole struct cxl_event_dram ? PPR can continue
> passing NULL since it only needs matching result.

Agreed, that keeps the signature stable if callers need more fields
later. In v4 cxl_find_rec_dram() and cxl_mem_get_rec_dram() take a
struct cxl_event_dram *out, the sparing path reads validity_flags from
its own copy, and PPR passes NULL. The cover letter now describes
patch 1 first, as you asked.

Thanks,
Jongwon
