Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109978;
	b=Ipv7UwxZgzx9E0G20AGxYkxCJXXom3jemeyCpSUAtc8u8OCEff6E/xOEh6sYw9ApaTK1
	 4VgHXk+8ie9wtUXuz+gjCPVkMbN4ABJto/drc6iOy4I5QR5YEtuxl3pZ36aZ2jyZq0O2X
	 IKs6Um47qlH0iaKAIqY5uvepaPdey1KJPlDyt4bwfTgOwwXqap2Lz/gYPnGn48tOv8bpr
	 L4hlyLDB4i+LlUiej7wl/U2Q50dLViH1IgOKv1S5skvSjTa71oYQ2PkCp9a1jp950x90+
	 kjQVtRQZ9PJFx7QZrhZzdDvsnTQtnPNad8M89PmILCrlXOqSCyAxw+q+VXxJrgzDqMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=CcioC45MmLY3DkNK9gmi2R+KmuN+SF2m/a7+FcEpEKk=;
	b=PY6AOTJpy0yZn5Xco0oNPt32Oa0oEY3jfvQ99fZxLbJZGKl6gOrdkBBgyoYxsU2sBOiw
	 Ux5fenD2oJv6qF1bFEthWp+4Pf10hFqJX+EsT+Ejpx6DtydOE7vAgNgXesOMwZyOV0bAj
	 pHYkjaKCd44Ns6ZGgZiLmCoMiYbg/fvgNdDrZDyVGXGrbpkFcS9YPq/vuuyqjbdZHls9I
	 fv6s8TNvah4cAle+7agI6tQ1fhuRWVPfbfXDTJROm0RE7jDR6dQ+MOYEUskILp7fey94H
	 Tw8bs18ht75+opChTtW2McbdvekZyU4dBCR+EZojCOJMSO86ese5QDowl7T//8dqN2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WocpRbPS;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1B606A321
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 14:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B1B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WocpRbPS
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc013095d4so1295476137.2
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793109977; x=1793714777; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CcioC45MmLY3DkNK9gmi2R+KmuN+SF2m/a7+FcEpEKk=;
        b=WocpRbPSqHP+BacSU/D7X3AgNcwBTyKCSmQa1WiDzaZeb/i/7127ANs4AQKkrhDpj8
         sre2xom8UwklJb0Fuuk+38Ac1aNbTkJEwpaMNjuw/lRn49lXI9yAJuDIvoBzbQXkq+69
         BDfcgpBufrlBxtepqsCgYCDXFgsZqNVIKQG2cofamkjfl1KVq9n6ZJaSrL7qbhwz+J4M
         gO/E3ecD6ph1V1pFV/pybEZvGUxvw8tQj5nBIFB9zsljg19A4tN4oPRpKDjrTwAJBRHl
         ARuZ7aYO0XD8h13N67wpXKHOa2Efgjnc9yytKyWBmunOKcWT1TbMIDAbh/AQZIUTthuA
         LCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109977; x=1793714777;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcioC45MmLY3DkNK9gmi2R+KmuN+SF2m/a7+FcEpEKk=;
        b=WNE0CiHEiLIzrdTz0Y3Va0WcjyqsXEItEfXwe0HVLGRwZGV4TCHnk2om4rwg8Kt52F
         Kh+N5DIQfy2HjXEyOLKtN+Fcn5P7Vbm25QZdjY36cyJRsYjrflZK/57Fv9DyRru+81Fy
         twt+KnxYw1yD1ZUAjB7hdF570n16hrDLZD6AdotMBRW5uPdFsxYIR5x4Da9JBHgGC4f9
         bEb5l7Nc6JNqvWNb6E0lxHhekvmBTcFPS8t15K/qZ+rBh5aOjYBYMBlIYIiBTVo9FwvN
         XiZvcem17TwahdB4ajHIJMptiM4/bBv6qZXz3z2sbuP0Op7EeRUowPA2Zm7pTCZxzLeY
         wpdw==
X-Forwarded-Encrypted: i=1; AKwUvBzrLbUVuqsPr39WsNzjGGys37GSPW6gT2qb/flq+PXltnZ7L0rPi53Q9CjIP4zzyOeCT0F7eHwOoxo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4dzVyK6Qnzqqb/FpsAi0UJkn26f0hbFw/dt7af2978VsNoRth
	rIToymD/jl5z9azjq6v2E+EYlOmnmWi4JtIrpn/LThzub0I8G8TmRts7R0qPLk+P99M=
X-Gm-Gg: AYBFou2oPCo6oQqEv5JeQvxbcuIMFVu3wjFWdCQmo6E6/v+mGaN0kHhfD4Q2EZpvC+g
	wTd5eVFFCbTO/vAmanc9vZkl2fGU4hvNLz6EkidzZaTMpTHs/2hqwiwSglQJjg+S0vAE3DtTxLM
	3HKu+IuVJ6JYXzGVM5f0tnoNxUAdT6VFcecxqJPuUzpucP75tCi4mcjxreeZRDwuDuvEytNAdT/
	ncIlaGat1Jm+LoeNx1Pn1TkiTEAJGzXtlaPoMKYFCyLezAXRJU6LDpCG0hsDOobLnxJeJDCP8eE
	7Tp74b3VgcMYSnhvgxzfyGoMQMDnrqFzsBYNCzU1eQvSnp1gMWO5bWSrkGNOJo/ibOWiv/WgRRL
	aeUrKQQdraYckau2Z8LKT55oOzoL09Fn2R9Ki8Ddfhmry9sMmrvGEQujfoLwQQHpuBijF+HkVUL
	x8/d7sEAFjjupL3l5jnrSmT+16+OPIf/4wW90M4SCny3mXxBBQ8UVmFFcS7yPIikH8TAJuxY0Iv
	+CVikOjqtmjd9qqS5WBtAuCLPjzAk6i+U57B5hgl+QFR3w4mumUX/luhnZlYaHiOeGQLUex/usL
	Fe2pHALXHloBAYjwvunkiNdJyzA=
X-Received: by 2002:a05:6102:14a3:b0:7cc:28a6:ee1c with SMTP id ada2fe7eead31-7ce5ca1e4bbmr3674778137.2.1793109976725;
        Tue, 27 Oct 2026 07:06:16 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd2110sm103733996d6.13.2026.10.27.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:06:15 -0700 (PDT)
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
Subject: Re: [PATCH 4/6] mm/page_alloc: don't undo another isolation in
 alloc_contig_range
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 kernel-team@meta.com, akpm@linux-foundation.org, vbabka@kernel.org, 
 surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
 hannes@cmpxchg.org, ziy@nvidia.com, linmiaohe@huawei.com, 
 nao.horiguchi@gmail.com, ljs@kernel.org, liam@infradead.org, 
 rppt@kernel.org, osalvador@suse.de, muchun.song@linux.dev, 
 iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com, stable@vger.kernel.org
In-Reply-To: <a4fc92b5-7d99-49f4-94ac-89fdee699042@kernel.org>
References: <20261027042204.3741307-1-gourry@gourry.net>
 <20261027042204.3741307-5-gourry@gourry.net>
 <a4fc92b5-7d99-49f4-94ac-89fdee699042@kernel.org>
Date: Tue, 27 Oct 2026 10:06:14 -0400
Message-Id: <179310997463.2232644.3260379218896917308.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 14:37 +0100, David Hildenbrand (Arm) wrote:
> On 10/27/26 05:22, Gregory Price (Meta) wrote:
> 
> We have an existing AI fix for that as well already handled by Vlasta.
> 
> I think we'll have to establish some model of "ask David first before posting"
> because otherwise we just create duplicate work for everyone.
> 

Yeah, this is going to happen more.

I've been sitting in these patches for over a month while they soaked on
hardware getting performance tests.  

Maybe worth a private tree we can rebase on regularly for these kinds of
un-vetted/posted fixes to see what's coming?

-- 
~Gregory

