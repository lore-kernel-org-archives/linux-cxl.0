Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243122;
	b=yeSBgts/hJDGCh8haPZlGk05T5MNl4rQ5J3OhDnTWblVI5/GRmEzzCGckYwbk5OrC9Tt
	 ZWquBgER83KKBN7htaOJ6pNxYKujI8gMwQ8lECYZgTYy0bU6WlX5tYZe16LojjIpCchMj
	 MdXB8MIMAvgB9Z9fRaakCadPsooPrFvWr83bet8POc8ZhQmJrx97BHU7USzZCpclQ7NFN
	 Z/dnZF6sB0lmGSIq9E8QYKTF9JPcrH+42c6U+M2SGOmZcYg57xm/BAgyW29RfioCY6yFP
	 G1HwqjcIHJjO9WdRJleLmL0EEuGTW8KZfvvIA3tRtPUrMmyrXk2Y56OMVa7axOosrqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Qt+rBjELLMxb0qTKo9uNTiwBY/+V4YZH/Ya3Tn3lncw=;
	b=1b+uYXW+of1WOWNHfoY9H1ntWs0vIKW4YxPeWqMBNW8uB5feQdcCV1jxrL4l+GQT/wUn
	 HFU98Z++CsSMvjCwwcGWtPPiPU71eiOKLuShuZ9qGNsnI1FWhlx3TgRVa5NLYpL1fWN3c
	 cuBzJTuZY28Ewj+AcJtg/BeevGyGdh61PRXKY0rG3gryyu9gpRQ9XPPlA4rpez+D+n+fZ
	 H2lCQzsxVLuxcIXabLHO6kSeRXSUh4GTDy09E8cPb5t4pIHTzGgGUfO/2dAgzRNPQ9OIe
	 wIEbOGMFSuZnUzHSjtb5XsD2UaqkkNTWMa9vsRI5LOH0fp8+i4TOlDHl/g6Q6Pf68bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xHNh2s/Z";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28E606A31C
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 03:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D28E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHNh2s/Z
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so952623a91.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 20:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793243122; x=1793847922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qt+rBjELLMxb0qTKo9uNTiwBY/+V4YZH/Ya3Tn3lncw=;
        b=xHNh2s/ZBjEIdJDX4r+dFuo8rNJ9MVQVAR+r5+cnenMwbZpMBs1xnjBlakkyac9yTO
         8bMDjuugxd7EriUc3d3oVvtIWW2p3YbNJ6KsEsKfm1ubZUETX0TsFQzRwNVFq/3LHMUv
         XupBgGrNQPXrLmyVezeYmQp08Rnt+GIf42xgjCkAl2khgayG0W1ZslJ/HRhejgKgtgHn
         aFTEyIabEusutC3KAy6fFI5jwEfnN1Cwnh8aBLn4XOw3TnjNw0MbYfUpudFWA9sLlVpm
         eYZpu6l7g4dB6hYU0VRew9uzv8fblmkebY0fmLw8l+APd394gUkEs5tyKa6ZltcieY09
         Ysow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243122; x=1793847922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qt+rBjELLMxb0qTKo9uNTiwBY/+V4YZH/Ya3Tn3lncw=;
        b=ZxDYxT1NMAXN810sxN+eB2G9gPw/ROasAxNKMmRmc+hKSB7A/EFvyF8RXj+Pn+6Y0r
         Mwf1oGi398qJAHuB9vt85P48bWtwOF9q4EzjJYAw4KekSr519xbRLrXfSQWkciJgG6jE
         tzDGoMY914sF3Jk6w234a+7Ni90p+Oz9m0B2ENKqYii+v6hAJkrQIHQNBa/tst7OWu1q
         J/BvfPAcRUzRj4dRidI2WAzif5ZcrgMsZD3t2VnF1ZnVRQDMwVsPFhgCcu5JaQWhKIAb
         LKV0m8W/GrMISK8byLDyV/6GJWSxeZemuE10eVymwA2OSiDtYch8/btt3+BvbBGvX5IC
         oHmQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/t+yeHkc3FllsD6MZ7UvJpG5CLQK9n+fP2Pw1c0TyhDe43i644ZIZDMgXBaj2GA9brKUx/8dUr1I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJz734s3L3rXVuBNdKEh315sADhwCKomjJpHw2M+Bm9LZuEXfmY
	0vJPhUnmbt+CoPwvTQN9Hg4kn7J4hN1owWuHF7K0W9iOooeyn0INNnjZ
X-Gm-Gg: AYBFou2V3nSEtpywkFEL/H3VRdIWuvF+k+UKd9M163nve0GFhGWzFnJ8KslxeyCMkdq
	JDt7rj3q/+2oTZGdwQFUCIBTZGT3z2InJ/0Jj8yDlyKQ0qbCEeOFtjKC5kb9r7ZqmCKS90CaVOu
	ugCvYDq/EfHLyz62VxDfV2L5flaKVpNz1iKKKIdtclse+y9p+miDcORlWN/oqnGQr2gXsAhu/b9
	XyoN4AX0TXETWgXTfqGZ9tlDZIIapub/TNZMOqc6BusAobzGygQL+CS83liZLQZCt+gjrZi7JvI
	4GFsUB/4sTeRteieGgfDNcN5t0DDmPSt2AvbZVCqhoZ/42lcpTz8sZu4cHJFdTi5CgCcvvvq8w/
	O9rww4cZ8RtsIeo9h/0uNy7xLv3V37evaT81RiOowgZw2MQQHbI7ManvqkaQmfX0Ic7lE7V1qQ/
	yi7ojdQhmn+Q9auy0S+v4twHhOSqaCPCjLobVAL1GEbLJ+aWlsRwk4YiOTgTgMVauARr2QKRInD
	KU8UIHPvPdSlX5apN4eTT7KZ/ASKMRaBeVxgBfBqpKCikqhAIJtvNlvw39BRzrRusL3RdT3TxvS
	KZBshsCQIfESgrtJtGnoDIWpI946rRCp3qzUfFvbuyMrkOZBv6EgJA==
X-Received: by 2002:a17:90b:3810:b0:3ac:b08a:ed2c with SMTP id 98e67ed59e1d1-3ae5822fb8amr3357641a91.40.1793243121828;
        Wed, 28 Oct 2026 20:05:21 -0700 (PDT)
Received: from localhost.localdomain ([101.44.96.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm1932931a91.10.2026.10.28.20.05.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 20:05:21 -0700 (PDT)
Sender: Yilei Zheng <trilithzheng@gmail.com>
From: Yilei Zheng <trilith.zheng@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
Date: Thu, 29 Oct 2026 11:05:11 +0800
Message-Id: <20261029030511.12004-1-trilith.zheng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com> <20260903122128.12264-4-songmuchun@bytedance.com> <20261027065723.66564-1-trilith.zheng@gmail.com> <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Muchun,

> Thank you very much for the test, so in your scenario, this is also
> the behavior of your real workload (mainly read/write-based, rather
> than mmap), right?

Yes. We mount read-only rootfs images over virtio-pmem and FS-DAX. Most
file access goes through normal read/write. mmap is only used for
loading binaries and shared libraries at startup, which is a small part
of the image.

> To be fair, it does fix the issue, but it's not very clean. I might
> do some code cleanup first to solve this more gracefully. I want to
> move the initialization to where the template page is allocated,
> similar to what section-based vmemmap optimization does.

Makes sense. Initializing it at allocation time is cleaner.

> Thanks for the analysis and suggestions. However, the reason I
> haven't sent out v2 yet is that I've been trying to refactor the
> vmemmap optimization logic to make FS_DAX support cleaner. I think
> I'll probably do some code refactoring first.

Understood. It would also help if the refactor could support subsection
(2 MiB) alignment, so any 2 MiB-aligned device can use the optimization
without padding to a 128 MiB multiple.

> I'cc you next time if you'd like to help me test.

Sounds good. Please Cc me when you post v2 and I'll be glad to test.

Best regards,
Yilei
