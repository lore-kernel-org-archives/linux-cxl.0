Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129888;
	b=cjb6L+s6RJ3TJMIw+yCjF+XS+8h5yHJwSThwphCeHZn/FMPoWBbeCpjGHK1tIaBPmrLg
	 O5U5stsE0IXJm32A/VMd6MsL9IcQ5a3h4MkqrvREVOfeE6N1WIZPBCIuu6EPnysR2T0Wi
	 6qncdE4v1njAfb01o9KFhWyJ0WVwlRdgJDHVVlV/9IkyaIEyPo17N02ehwheVguQnui7V
	 nB6szEdWnybNhIqP5Sp8zmUogquBMYcwLA/F8k2hEO/cMmm8z+J5eX/1Ypoy7e8dl7nQ8
	 O2FqM1+IkAvlXq5fr2ajloP2M+htMHOjZIxUQl6c6kPPy9ozg/JHMYL8rjUL54SiOEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=AoGn9VEZ3I8Ld7dNYqrh8Oigb3Q3zSaylzK9qrRu+PM=;
	b=UNRCqBL50A4nfhwvWnvldNJpvmI/ujgKDC4U5YO+Mx/ihkU2b2F8KVxth1fFIDoMzW16
	 u/YrOmd7NADey40nNMjHYqAfA1CAzWZbJQPzZIgqAkRmtMx9zrVcQIlBugl1i01vlh8/b
	 JuWmcIrcpDwhZSo+bs/oQ/3K2JSotT0CxfKxI93nf8lkq887pO4OggNMhvPPCkjcWTnHE
	 Yl642F8b6s5Gf3dYZ814k5fYe2SrHm0MBg6hc13z5Vr8IO1Jgs3pmHMDFJzccOK0bWyqB
	 Hr5WmzYFVJx1FqervdW7tvni6xH2znzPqG/jCEE7FvXNdzEJy3sPgfqRXNCbptvARVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q62RCPUn;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27570606A31F
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 19:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27570606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q62RCPUn
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c43373ae89aso26098066b.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793129885; x=1793734685; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AoGn9VEZ3I8Ld7dNYqrh8Oigb3Q3zSaylzK9qrRu+PM=;
        b=Q62RCPUnV4BTCTB/VEZDPth0/eDOGV+2DbB+rwnAq00Er9d0WiTUOmo52xTRwqLfBV
         8ybCdnY8085WTtUwWrWpufTibmSqT0JFTgolMCl912J1Zzj/GMVjMR960Pvlrj690xsz
         qB+dHNF0Abad0Ff+va4Zgh4Si4ZsBgnUfAwZz1fjhVj2YrL6Wq6YxdEMNUdhXhS6scKG
         GQiAhO21/G68Ca+/LjLdqqxa5Birf80FTPrjig/1R35308OJG8B25tVWURAo/130aM8z
         xl+tpCDpUmn9ss2ocgdoAgewATF9MyNbb834ULQLlUFbDoMciHANtGG9WpwrLj7kuc9G
         z7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129885; x=1793734685;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AoGn9VEZ3I8Ld7dNYqrh8Oigb3Q3zSaylzK9qrRu+PM=;
        b=JQQbniFak/dSo5fQsxJ9io4qGKQ2nz6OqL1V8uf24xqekt/wXECdjlaUa1EDUAjgTe
         zvTpvjzSWUSvlqJmc0l3RGoADCIbxuF9djlCGHQ4iR5tKvyCDom5qSgW2F4II8PmaIV/
         43Fy67KzvHNuqm0MQxLT9ZQK+vv2ND7sfDu47fMvATJ7pe2InAU0EiSfpxbhSO3BauUy
         /FE31pKpmnMjBpXQZvcW7A8xT9c7ks9LlM6ERhdYt1atFl1Ewb96eFhvgU9M7V/lPgNg
         5neS17XnKAbnG+eTGqromLov4gfSOlYN9NsJKdYsg358iTu9bV+AMaSggmRa10D+IY83
         1Fcg==
X-Forwarded-Encrypted: i=1; AKwUvBz6immphnqvtJEXBwm3u1xkx/coJJYROz0yMKXXsrhLpsLcS3w5uAI7lbJ+2+JlN9OUKC/Blvsv+ps=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZOu2+h2+NMayVlNiFA8ZGOw9Fp1GZNCIG3pioHkcBnxu2U50B
	jtfQKcqLJSPEMvfxVFotn7xHFa30nd61nvkzZWlTodGZjzfSLTQ/KB2YghWp3yPZH6o=
X-Gm-Gg: AYBFou26q6Ex3/0B+NOwjGyft2tHzNJ06JbrsqnoRTX8tT3R7JAlKh2M0Djd0LP6XIH
	xdCA1p56mfIJvtyGcwdEe2mq4RXRzGWXD2dWXiMm9xo+qsE1JTMwtMVrzyBRbE4u9UOo/kk+K8M
	ZrbB3skim38tucvvINZEvbxn7uf2FQujdQ39GukHVJbe/NNfTqkYP8ID6GDYP6mCOXyTo/euy74
	E1T9lgU/LILH7xjL98QreAFK34fD3pJTPu9UO9zkAfjfAl83wLnJVBNJL+u7R7y/sTuOHxaNzYz
	Lwpa0cHeFLOAf3kdkR8d8hCb6QK9hMrK/uoYHHjHQWpNrnaOBe9syJTSasqM3vZ9Bxl97vszB2q
	O4KkvcKpeOCoHDKqR0vGBuBuWNlwbZvuxSprhdZs1mNC62Fxsxsp7m055imshSm1q2neho7r7Cl
	VyPuCVevoxUKOVnpFgjE45onoKFJ+k5l0K3ykY0DMfk7g+MwLtgIfzt/m4c+T/NStGpYRaouzl9
	BNJqFuuc9E5k7zEBYvlIxuhvcSS/5nlczRIzvB9A4rBpA==
X-Received: by 2002:a17:907:7f9e:b0:c46:645f:cedc with SMTP id a640c23a62f3a-c49be054a4cmr17194666b.46.1793129885192;
        Tue, 27 Oct 2026 12:38:05 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964601f2sm455107a12.37.2026.10.27.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:38:03 -0700 (PDT)
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
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, "Gregory Price (Meta)" <gourry@gourry.net>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 kernel-team@meta.com, akpm@linux-foundation.org, vbabka@kernel.org, 
 surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
 hannes@cmpxchg.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, osalvador@suse.de, 
 muchun.song@linux.dev, iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com, 
 stable@vger.kernel.org
In-Reply-To: <8a841fb1-8e71-40c6-91d4-3252a0a1a368@kernel.org>
References: <20261027042204.3741307-1-gourry@gourry.net>
 <20261027042204.3741307-5-gourry@gourry.net>
 <a4fc92b5-7d99-49f4-94ac-89fdee699042@kernel.org>
 <179310997463.2232644.3260379218896917308.b4-reply@b4>
 <6f5aaf2b-894c-4306-a0b2-e56f815d0a89@kernel.org>
 <A4D82AB8-F33A-465C-AE69-933B746E4885@nvidia.com>
 <8a841fb1-8e71-40c6-91d4-3252a0a1a368@kernel.org>
Date: Tue, 27 Oct 2026 12:38:02 -0700
Message-Id: <179312988283.676746.1330276872732304961.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 19:58 +0100, David Hildenbrand (Arm) wrote:
> On 10/27/26 19:53, Zi Yan wrote:
> > On 27 Oct 2026, at 10:13, David Hildenbrand (Arm) wrote:
> > 
> >> Maybe. But if it's just us core people we can just talk on IRC etc (like Zi did
> >> two days ago when he was about to post something that I already had on my queue).
> > 
> > One idea is that maybe Sashiko is able to identify patches fixing
> > the same issue and does some grouping or tagging on the website.
> > Or send an email about it with a lore link.
> 
> I think that's too late. For us core devs we just need to sync on "has someone
> already a fix for that or is it worth cleaning the AI shite up and sending it out".
> 

It might be worth just having a maintainer Fixes:-only review branch
that automates pulling these things in and responding to conflicts.

I've been working on some b4 workbench automation to make triaging the
list a little more sustainable. It's getting there, but it needs time.

~Gregory

-- 
Gregory Price <gourry@gourry.net>
