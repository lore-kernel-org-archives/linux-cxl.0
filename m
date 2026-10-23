Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720102;
	b=VeFFqB6EgsW0sxiBqIvPHBhLKXIjVABx2uBINx47HC3PahfdS8tR33v5vRg36NjNXd88
	 dHxOV/LpmVOl1kHmiPH1IS6i9T00+NC4C12K788LAUxq/SiOyqSRn2Sh4bXn6dv5UN/ic
	 /UlO/JnCddOhO68fqwIT4kO8CXqjg/4uRVuhW2mbph+Vf8xTAW19S2uPp0vHtZego9jFB
	 43X6pkY4HSi55e30hE6fKbZ+Yv7GzHGm2fxq69OmP8+aaFiDTE4MR+7VUONJ6W1YohqA4
	 8HpTa3di0pPIzbrrJm/DP7sRw/VLiwHBjuczxWNW0DOcaUvvEBs72qNpW99/f61ACoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=83wWFvyslHeXKdJBa6hq+X7wIniIzuYJyFQhzC6bhJI=;
	b=L6ErPTMwlaFAt5eq2M1ntvvRv2IXzm4ruetOd3jRQAo1NV0ty4yachWg34/iUTtLG7w/
	 A/Ugrqgpbt964l13BU4n9PpC6GUmmyJmowtY1gDTvjputFWQg+Wg9CjHHX5BhkouATywx
	 YBKeN/E3aodW1oLPuzWoX/FUwu1+qYBGaj9x8TrlgDFUGvw/DhtiWVMAUX7JFI/k1J52M
	 u+vt+Wh7TiiJCaM3V/CiUrPGufo1EArn9XwnbyTwTvfjlqzm7IT0ng2/Esx0b3SiDSO06
	 vm+3eh7TtpVFQ0Uo7Q/O5wvGurbz1yeFj5qyCKRiCJAZNXaoXNWLzhH0C+5HY9o3QIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZgSgjcG7;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21486606A31D
	for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 01:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21486606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZgSgjcG7
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93cbc3ab2fdso17413785a.3
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 18:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792720100; x=1793324900; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83wWFvyslHeXKdJBa6hq+X7wIniIzuYJyFQhzC6bhJI=;
        b=ZgSgjcG7DpUqp0jyH/lBORFkCopJ5LdyAMwKLNXPO4aP5Kh4D8x/pbPxa9Od+/AKaJ
         28QK2keK1yadKaJ8lRuyPbHvypLSCQJkUGxCo4HHkaiMMvXVD7RE0g8AwS5HGRTPiFyO
         pSUPS4uRMuscXzAACKtQDpSNdcu6FYu3U48nPI0YF6dT3eHy83CS5PM75DdQbrBbC6uK
         7BmkTkue4hrGguJVe7pd9fe3ig+uPwfD3gsG/BhsY7QBHJWb+B9qj995mgBE1tichHsv
         adAUQjTNL59MQCldjZA8+c7Ov3CaHyY03yvkGkS0H7KXVfjr4it96w/BO96EhqCeXFu2
         3gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720100; x=1793324900;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83wWFvyslHeXKdJBa6hq+X7wIniIzuYJyFQhzC6bhJI=;
        b=BznQVtzOu+4ecXG6Sa9xvX4wAJoWtvlSbccSEO0bSvAlIplsZr4XjqJ+7X48oqYMp7
         RCR0mF7pKuJtBoXIYd+A7dp9s63CU+ZRUoD/7CDwveN+LzWsp76HU8ujHGVIstSCcAl+
         WqtOW55e3BwadE2MJkBuwattfYdTl2pC1bn998/16vqom43uHQfqOTL9TiFx8zVxhtUL
         pwcGtdQZfxIzibEdUE1qCoFPtVcZ8qEmvWUpcqp1AfFXYF/krk7rW+6DBQL18cmMfdDS
         NrS2MUSF07T1T2KNrPkSst3Wj3y1f4wis04QJkaf6kFfE1aqGsegMvVIoHIAmV2uQa4b
         qY2w==
X-Forwarded-Encrypted: i=1; AKwUvBx/cV9QUZDvgNqVzXYu0KegoHtT7FhtPiYDd79KLgBH8AI6YBSv7rHzOSSLvMUQSTHZcKK0PqENjDI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpZQGkZiTbtRLUqA71oIDw3ve08MTsKX7Tsi1mZhjffgfxmFNn
	w6cyvXkex8wwqIjiEWQjGmcGSRzjOWGwOxmmeqYqYcYds4kTo60d+kpd16mGrsOWO3KsHqgxIXy
	7GLDx
X-Gm-Gg: AYBFou2yXf5LJUEa6QTN7sKJemWb7RD+Wi3G0X/8HetEdK8VnmujhhCzQcEAMK92Q2s
	dXmIO+UgzE1LfH3EKwQRkFYHFaaksQPmf9+N0JnBjOQk8AGH5krLy7q5k/Dto+eB8PPen+CwIyb
	eOwgJDCGIoSY10Il65x7iqrbtaIwiOUwLhqDpZEQiXhBXDG6UiLiXLursTPlkuPCi0LyT/w89wX
	qbMQ5YBh03LyRHMXBIhpkwqfjPW50wUs7rRaF7hUHFTULFcOXmWSmgXOni2piK41ufzgjTibsa/
	FU4Dwzzl6XGlrwy/wEbq+IiCLz2SIny0VAhKyjZc3N81RJKJz2BW+qc5r3/OJH7GKJxv8AV3oEm
	axjBdEx/aX+jJJGRcgSXbkPRmbln1Dva5SGyslKycqKqDs3hoifNTxOBKcKd8K1hNqwl9usrvU+
	loXKfmVQt39z52MShtUuuFPkALpn6FS+CjDHK7jirtE0ZS4ML1KAquY2ODd10GQmxyGjFX3c9w9
	VO4XE8A8XJDGUq5KIYiD56CgyZyvk4FVkwH/daREe3OiLjfzXhKBFYms7zDGvwK5W3/6/zuhrlw
	E1ev0oPk65TaEUTUN+u1ryX03Lw=
X-Received: by 2002:a05:620a:284a:b0:93a:2611:270f with SMTP id af79cd13be357-93f6f907c65mr207694785a.13.1792720099877;
        Thu, 22 Oct 2026 18:48:19 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396e3662sm7533396d6.20.2026.10.22.18.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:48:19 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/6] daxctl: offline whole-device memory via atomic
 unplug when available
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org
In-Reply-To: <atqHe2AK6Tka4t6f@aschofie-mobl2.lan>
References: <20261016214248.443247-1-gourry@gourry.net>
 <20261016214248.443247-4-gourry@gourry.net>
 <atly9gd-Rsf-AoqB@aschofie-mobl2.lan>
 <179268760050.4072493.10054383256417425305.b4-reply@b4>
 <atqHe2AK6Tka4t6f@aschofie-mobl2.lan>
Date: Thu, 22 Oct 2026 21:48:18 -0400
Message-Id: <179272009864.802238.3707618429496053322.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 15:00 -0700, Alison Schofield wrote:
> On Thu, Oct 22, 2026 at 12:46:40PM -0400, Gregory Price (Meta) wrote:
> > On 2026-10-21 19:20 -0700, Alison Schofield wrote:
> > > On Fri, Oct 16, 2026 at 05:42:45PM -0400, Gregory Price (Meta) wrote:
> > The only scenario I could come up with is having two versions of daxctl
> > fight with each other (old - no awareness of dax/state, new - uses
> > dax/state) but is this a real concern?
> 
> My concern isn't about 2 version of daxctl fighting. It's about
> preserving the documented behavior for "daxctl offline-memory". And just
> generally, if there is no need to change it, rather not change it.
> 
> From the daxctl offline-memory man page:
> If all blocks were already offline, print a message and return success
> without actually doing anything.
> 
> It seems the benefit of atomic unplug is w "daxctl reconfigure-device"
> path where memory needs to be removed before unbinding dax_kmem. Could
> we limit atomic unplug to that path?
> 
> To be clear, I don't know if that (limiting) is doable and I also don't
> know if any current user would care either way. I'm just defending the
> documentated behavior (FWIW).
> 

hm, maybe instead:

daxctl offline-memory      - stays exactly as-is
daxctl unplug-memory       - does the unplug
daxctl reconfigure-device  - converts to unplug-memory under the hood

userland that is suffering from these races can update their scripts
from offline-memory to unplug-memory, but if they're getting it from
reconfigure-device, they get it for free.

Unfortunately this is the painful result of `offline` having been the
default hotplug state when dax/kmem gets probed, instead of `unplugged`.
So we're a bit stuck with the `offline -> unplugged -> online` pattern.

The intent here was to try to get drivers creating dax/kmem to actively
set a default and effectively deprecate the global hotplug auto-online
setting (because a single auto-online setting for all devices does not
make much sense).

I intended to follow up the series with a CXL build parameter that lets
a system owner set the default, but omit "offline" and instead make them
choose between unplugged and some form of online.

I think that resolves the daxctl problem entirely more or less?

-- 
~Gregory

