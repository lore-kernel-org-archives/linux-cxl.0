Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015080;
	b=MaCaEgfqVSL+hJYCrdwQIVCyRqupRrQCadhLz1hmXjpJ3uYJXbuAg1CF+F1XcO/bvJ1Z
	 eoKVMyvtwKG4ce6Xa9jVeZvg4u1y3nl4K3pAKeBdKdN1NvK0dyNyFdG714RZJVDMjrA1O
	 O2bwvN6S5LX/i0YYLFNyTg8xKgpgfKGfnaRG6OnscQUsZ7SCVu9CFLLVMUZpSoAUYUDBl
	 uXGzAmDb8ii4ncoCLxm0gr6SYBlvH5FQPTV5599pW6Erf5o9YA1gTAOYZHKQLfedt4TFQ
	 0LE2oPqZ514kW0j1oYN+rOUZVdsTP3VO1lUNuL16CHu/OPOKrLmuV2lc+gUFFbDtfTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
	b=5URbjU+CWw2/7ivz8jE++nF8P56gYfTx3G4FtSxW1GQZ3Qb7JwpZE+wDHPMYsh50t2c2
	 sa0POQlvjcCbZJUJe91F0+NV04BH7odl+F9jqsg45INZ5BU4OzVe0GWD1RLrVq+R+dGWB
	 cWOjIXy3YioPX2w8FfW55SyIJ58HfEynv/K/s5/6UfftKalHtxP5eDtvA+vdPwTW/CWK2
	 UKxLFZyUCki027+d1BYWiOTq2UOjm4CZ8JIjlcWKBJbFpNfzdb5XNRoV88zN5wxhhFT16
	 UbNdd1Liy0faYfJYJu0Ax80LqJL5X2MVHB37krBwpjkoGhLf1Xotb4dhBYGbQE/FFnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e4KQUABj;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D2606A332
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586D2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e4KQUABj
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91eb3fea2a9so9480106d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015079; x=1795619879; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
        b=e4KQUABj7gEeUxSS/9AWkxdW17UGKfzuGQLoVBznmZ3Gt2tw44MXP7MS7fuK4a6Xch
         0yyAXWnxxjkzZiP8jzIwtt8wLQB5Qssy9Gb6kZK/rHIv3jESaumWf1ihxu4gqfy3WHhI
         oFqLxTx/jKx8gn2+JTWAhEQk7YXH4RcTH2yez5MsQAFrIf799A5J/GHOpS52hUYhDizF
         brNl3q2lSv7Y6eahBplN+1C7QJXZuPwNsoam+lFO8Uv4TSMXFVNwxTf74WshGCQjFYLx
         AQVaoBNexrSRe/cQbkOsywEWMHGfpBC1GgvoSO70//W1ftEDbFrlxKA7Po9FCE5MnZw0
         zQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015079; x=1795619879;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
        b=Ak6wnd0GjdQ5dubRSG/Hyosj7bZnW2ajYumTf5865U4nAe1Z6gL1qttCqmRBfYM45t
         ynzYiq+kYphfNX6rbE+Vt7qMylckmZ+V902QqY8w0sCLHctQblWCEEvva7/V7+gjmhBa
         YZtdtQe7jVgh/G9sLG1wGZeoP0pyyN85S8qtzSl3Fkq8T6o11t6JQ2XfH4i0pGC8aLEK
         hkiUC+TEOEVRLu2mr15au63MXXF0iJQgBUkm1D3GzNnRbFX2Cxrz9EX0yGfQS2NK8Qr1
         OkeLCKMuYc7L7XrofoPi0G7+iX4nBmQ4HMfEIQmb2diCdmkrc05472WbY1IKYZ/xaX0N
         +7xA==
X-Forwarded-Encrypted: i=1; AL+hErFwH4MG20tRXcyoigrdG7KQ4XwH9JyikmhYt1CEKV6PDnJmtgZhP1JSlnDBE1ijFtprdfFK5AAtrPM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iVazGBJaLqrkG+OvlQc9UUgca3xbkIHJoyfemamcL1rlS4Coc
	JqwnhrIKtXIODdx7zexQ4/RrY7bSrCO/dT6nBwj4ORhtmSHHlKmrkHPgbHMCxWA+S50=
X-Gm-Gg: AZFdTZcI2yf33c8bPBjeV+9ylc7r6ty4ZBoeN1oYI/DnsVGN3aAroO56AisLCeUtvzO
	rZ5irCVg/0vKcOEetBuvM8+dP7K5nrpOi+WAtIbxFTV6G7TWVq10Y7cZy+6DKh1e+8YKM5fpJkU
	OvVh6EgSo1N91uKEMs+htVc5EVHlF3d1YyApw9H8t+QPcN8XPiNgvNaU+eq/5jp0jMC0OeKJBm5
	y8/sds/HcKv2XXGDHuSyVnQttxi5yrt/rcQAvbyqtDTlT8NhuzljNMoAb+rR3DyOSEUfAPkZWeq
	6PKhSj7yzzrtqJ9KnTltswpIbSRgXQl3QQMHmIzQmTSxIMZQ6GHLW+ppCAzoJ9iL/B/cpsOq/ow
	gQSP6yYaPpsOVNAMNnGSFHpt1OdY5P5Uwt0BXkki9GUXf6J+AEzO+MYSzYMPNMx6nU/Y8UjD0A/
	6FkFqPwEzhhEVWbAiA0ZQIKrOS4R7fKbd7tAe8hVO976Y/ziRCTUmlNQV94kbdfz3VOOHC7jH4k
	pMZPlkKgpuV1pg1pKPlTq5qhAKv/sirFm8uHcjaV42tAyIlspwxCZhNyoRpIzGOAJCcuX916EAm
	W7ttpr+ICjMbpPtwyhzEmb6LK2xE3HAZyIQLTtc0STPBgnq1N/vzV0n9oe/weWj7XTMcEsdZQrl
	vjID6uHF26p59wdYfG0oxVxCfnMhX
X-Received: by 2002:a05:6214:5d88:b0:91f:2222:b498 with SMTP id 6a1803df08f44-92114f8f66fmr40206726d6.27.1795015079071;
        Wed, 18 Nov 2026 07:17:59 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d35dabsm23793796d6.17.2026.11.18.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:17:58 -0800 (PST)
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
Subject: Re: [PATCH 01/22] mm: add node-state-filtered zone and node
 iterators
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av1hKrtcATVjCnCM@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-2-gourry@gourry.net> <av1hKrtcATVjCnCM@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:17:57 -0500
Message-Id: <179501507729.1206716.6880334614636468959.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 16:29 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:38AM +0800, Gregory Price (Meta) wrote:
> > +/**
> > + * for_each_zone_node_state - iterate zones in intersect(nodemask, node_state(state))
> > + * @zone: The current zone in the iterator
> > + * @z: The current pointer within zonelist->_zonerefs being iterated
> > + * @zlist: The zonelist being iterated
> > + * @highidx: The zone index of the highest zone to return
> > + * @nodemask: Nodemask allowed by the allocator
> > + * @state: The node state the zone's node must be in
> > + *
> > + * The state filter is part of the iteration rather than a trailing if, so that
> > + * this expands to a single for statement: a macro ending in an unbraced if
> > + * silently steals a following else from the caller.
> > + */
> > +#define for_each_zone_node_state(zone, z, zlist, highidx, nodemask, state)	\
> > +	for (z = first_zones_zonelist_state(zlist, highidx, nodemask, state),	\
> > +		zone = zonelist_zone(z);					\
> > +		zone;								\
> > +		z = next_zones_zonelist_state(++z, highidx, nodemask, state),	\
> > +		zone = zonelist_zone(z))
> > +
> 
> A question on consistency. This one is a single for statement, with 2 new helper functions.
> for_each_populated_zone_state() in the same patch uses "if (!cond) ; else" form instead.
> 
> Both forms keep a caller's else correct. The only difference I can find is that the if/else
> form give a -Wdangling-else warning when the loop is the unbraced body of an if.
> 
> Is that the reason for the 2 helper function here? If the warning doesn't matter, this could
> use the same short form and drop the 2 functions. If it does matter, should
> for_each_populated_zone_state() be a single statement too ?
> 

Yeah I was getting that warning from various checks. I'd convinced
byself this was a false-positive, but it does look very funky indeed.

Let me look into this again, it's possible I can massage this better to
use the short form still.  It's also possible that I should just use a
different shape entirely than trying to use the existing pattern.

-- 
~Gregory

