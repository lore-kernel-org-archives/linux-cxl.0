Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218341;
	b=mqmiGrpzNiuGlVIgdTgqUMrdn3JwcgybQaTXET+56mKsTmVcMzf7iu/bboFNN7pb4vfS
	 /fHNkV17g3obHHTiZG6x5hIu1GTerGYrYbua4XVV131FZZjJxWg6YsA9GbGche+BviQaf
	 KWXwDQwifWjAK1jod/oIF4jZZS5AfvJgXMNmP6Jxxkz/TgAONh/q6pkfH+xEFaQa8AwEJ
	 kR40qggCMqP9YHnMrBkkp+HVh8F6gfXfujk2WKcUZKSTVGlJuQl6LdUhHAi9t+amljcXz
	 VpsGmYfOMrVRJR+YFIpNb5vUEuOWdguW/eFJSW732VEg5Vro6lNd69IF3/Z50GYg/uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=bWRDA7A93lkdLQaskfQTKjWU2/DcAc6lekVUUxDbWlg=;
	b=G+pyBdmbEuuto9bNjB06euaOt8E0MLdwIBA/BkMQ/FMbe/55Mqdpl2eU1LT03WExdWcb
	 jolY8o1bkTEf5E+f7mdY4SN85zjDDozLpEyFF27WzE8LJaNoPUG3vmktM8fSlyQORYH0h
	 ZwFM5YdvRZGTjg6GWUzr20T/ygjVNYcpDRmRUniTY6JCLoBsutb06JHAq7ZtfPt5cUocS
	 TLJwLrHIxYXYqldp/0RjCSwtI8dlRbzyuBtQ8StCF46EvWCjr3xyaUW4/oXHukigEgAHO
	 NeQVrVSlDPN21lXpf1vGBJhn8iaJT6D7lf32TI6qAyKx40+NJDcCftF/BCUCY6J+Zvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ub8ZK+gd;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57364606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 20:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57364606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ub8ZK+gd
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c413dea9ca6so238007466b.2
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793218339; x=1793823139; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bWRDA7A93lkdLQaskfQTKjWU2/DcAc6lekVUUxDbWlg=;
        b=Ub8ZK+gdxDKpcRCl/HoW9GqRCTI2tZ+Qkk5CE4+LF95TkwZeaZXLPgqYj1jgGhwu84
         shUaRXEdMq1ihURxh4Sw+Sxw3RBKTVOVnXlUSlfNe41Q7nblvfZqbDaQchv4KBpmCVUE
         ngt6a97VEd4S2A/wvPOH9FIv7z2+3zwUtST1OxbeKfkny9xrnxHAv8DR94/xjLDpMvmA
         Sn4lhM2XUKXSaNzST//kwT+vKVQy7titacLKWxNoC06rVW4wQgxIsMiDBTWoHnl917kX
         619lIUzaQhDj22o29R9PLfd+SMUF2VecEcIVS3SM9HN9/8sODPtkYs0rizwiH5fINDxO
         +uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218339; x=1793823139;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWRDA7A93lkdLQaskfQTKjWU2/DcAc6lekVUUxDbWlg=;
        b=DIR1eEuukxDcfHyspD/ZXd7WK7jqVUyXP8QQtQtyrxG9b369zWo5yvL1enBzKlKQ/g
         GMjUbMt3MFS23jmfHor7Q7Ef7cutJgjQP5KDYOgqLYYm6xkS3N4M1OMZS+pBn/1eUjnB
         dsPv6sDvEZezR02Zt9PM7brw3AcxyJCWaE4SUnDS/SkOyD48IXyN3EuasxuBodAI1jC6
         5Fo7oTjbY3RtZIZauOkEZsnXG7lr6oX/JeAbdfzOfCRvZtf4EILQC/IxlMFXdGTi4ai+
         4ZnXesHBJgwwQL/aiutlXqNvG/jyZBEwi9blk3kEsq22Y7+oXynvUuZkeRCIiPAAOifS
         nsfw==
X-Forwarded-Encrypted: i=1; AKwUvBzJsq2F2d5fGLBR8Rg1kQuRU8rB5qo5uCc2Lk/EHAAc2NaqESuMGoasHOG/MOoYrGXghBn3RHq2I6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYqs4DSC3WR0fHpQDCCd8m3AwkNTGY9z2zTr4N14/CpcndKeBD
	wC3CTjo9yphygtmcwQckIAObpisQydQMjIM+iWQsZGy1IKW4pOfd2ngd336qJ5eh1zjt8wQlKk2
	+iewSTkE=
X-Gm-Gg: AYBFou1wJlVQ8761SjxrQqssWI3fe1VCj73w1qltcUwLdJTw7ZtkUhbkkWMEXDHOPt1
	9sjDbCr2oIkldI4+hDXaOZ85q1aSflHaKT7gX34D35ia/A1WDvstBtLc4hahGMWAThFXZkJ/Kob
	+qi2xuN3iyngQTGFwF/NiXo8VWqoqewkmeiEPRAaIlcSnRNZmYjaFSL71QukxcDhER4dsNG/soE
	Z6uK92YiyYh1BoG+P+HdRQgEnKY/AAI5zR3XyhTQRciGKmnf/1WH94YSmMy+z1K6JRsr3wrxcIC
	RhFvXL9vDdmU7GLGSYEhjWcve2g22C4NZfqickogQUsssIfiIKUdf0ZljYsVyl9rhjg6nurbDr4
	wugiH+DruaMC23O8I03ne5IUxQKR5D9WBDcjA4TcwQlDOHVY0RED3FkcSAodwA+Jykht6vTQUeg
	m+es/W8VeFSqWP0dwA/BCOVPhh/20/vCYLR1IYekjmq8Z/UJFCxCBe7rF7KYb/oqGKeQClPzuqf
	6CXISBaRxZTVb13zvVVjAodJk1wJrra8xUKJ+U16zPVNu0IKIBM2UsJ8RQ3vfYhqMEqFe1pYjXV
	rGux/1vakw+cl1L9qFq4qUHOAzTviV5tdrgq1BswfA==
X-Received: by 2002:a17:906:ee8b:b0:c29:659e:2fd2 with SMTP id a640c23a62f3a-c49bdf309a0mr272007966b.27.1793218338561;
        Wed, 28 Oct 2026 13:12:18 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4e::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a4e2401bsm331870166b.84.2026.10.28.13.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:12:18 -0700 (PDT)
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
Subject: Re: [ndctl PATCH 2/4] libdaxctl: tie mapping cache lifetime to the
 device
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: nvdimm@lists.linux.dev, Gregory Price <gourry@gourry.net>, 
 linux-cxl@vger.kernel.org
In-Reply-To: <6b3b42e253c4aca3f4c080d0a7698a09ef24465e.1792695259.git.alison.schofield@intel.com>
References: <cover.1792695259.git.alison.schofield@intel.com>
 <6b3b42e253c4aca3f4c080d0a7698a09ef24465e.1792695259.git.alison.schofield@intel.com>
Date: Wed, 28 Oct 2026 13:12:17 -0700
Message-Id: <179321833706.1001257.465249667653833159.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 12:56 -0700, Alison Schofield wrote:
> Cached mappings are not freed when a device is destroyed or invalidated
> when its ranges change. This leaks memory and can leave callers using
> obsolete physical address ranges, potentially operating on memory blocks
> that no longer belong to the device.
> 
> Free mappings on device destruction and invalidate the cache when device
> ranges may have changed.
> 
> Fixes: 5a31bf710399 ("libdaxctl: add mapping iterator APIs")
> Fixes: 52a2653098a5 ("libdaxctl: add daxctl_dev_set_mapping()")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Looks right to me.  I'm a little light on the lifetime details for
the cached mappings, but i couldn't find any obvious issues.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
