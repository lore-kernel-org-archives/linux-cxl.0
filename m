Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777048;
	b=EDzK3FcarDolCLR+mDRcHzEjVos7c6VOZFOQE1lrBINUOCsowemnEgXPGFyswkU6qh+r
	 +ZBx4fHPBZBJjhJPIxQuFU5kBN9IKqox2JVtSLU+9FJ+PRKwvqHhLyzFJBugVQCYkvs4N
	 Re6iHmemoR61z8KAFau5vHpLTOxq1NZZkYJB54r/bWnpALFPoEzylTwVIatEHBYIoDUXp
	 hDyXJy3lPekGLYQgpMUJW6CerklLJmDzMYrmcP7BRZ9azNjBzq8MHW6fR4AND5uaCdxue
	 ZH4WCdSbid6cbjFe8OZChFxVEE7SCkPkwS3dwjEgdovj+yAaqmMgX21NogjoH7cqLMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=hraUT/Vp7Vp58veMWgeGRnI/Rj38Sr/3KoYA2Iypfx0=;
	b=1aojvk3FYQiXatmyyiEyXpTng2DXqsMHleaq1Dgwt86KF0tQqHMGsFp4uLKkuE39J9v7
	 W62586iA61qR+7+J0KwdoY6TLOEFTjHEhCZC4+ncC/DffB0fJUfnMZAwY8klKcBkhqJK+
	 dFF4RQgHAasX8uDjjvLcyn9bgNmiQJdKDyTMxy+8pxxnbetgU+DRDJWK/xOFRIhhyGCGx
	 rkfekRw2GbQ47ggIKinKcrUxs5+5+JgB6DX+6uBCIHcZTLDNm2AyfsmuBwz108Afd0mN1
	 aCgg9hqiAHKe0DK2V5VMQUVIRIA8Qar39kRcBFFSKyQfpcizbMrpkj9uXbVcyDq2gTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RYvxYHzI;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A42606A31B
	for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 17:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A42606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RYvxYHzI
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53665358476so10739041cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792777047; x=1793381847; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hraUT/Vp7Vp58veMWgeGRnI/Rj38Sr/3KoYA2Iypfx0=;
        b=RYvxYHzI7vjde9qKR2hMxVCi7xO3umR/L8nNmM5JH6Enqrsn9fQSCixc1YOndgNkUZ
         OOZGhe6prqFRoDN8Yt1vya4jaBwVaxHfHxE+Jyy5VfrN9zW9Q/rvXra2eVlq692IauuH
         WF1T2e8PYs6t0P96aSwWMvkp9XXrKMcgjHGEC0zJE86RDp58zQSZ/Eow4FeS8w3ERQnC
         Y6AtPWcZaIw3c5RBOGMzad+HbKxxtEuVu1++Iose/nP8pjdaiGpxTADVaUaROb5CvKKH
         XZ/20cJ0SF/gXJCEu0ZbLYDRbi92Whz17sliFQiIg5OH55dCraj6LwCY8v4T08NaALc5
         vayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777047; x=1793381847;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hraUT/Vp7Vp58veMWgeGRnI/Rj38Sr/3KoYA2Iypfx0=;
        b=xGDfhsZTFpYa3EABa4ryDzD68EFLcosg0O82i09NtATnratm9p3dlnko9k5DGNtuon
         SjywEmd5iyoYuzN/XtWK97jnoFU3DPLO5wBaoD44ZSPWq/OxcYYT4SddycBSqdsKZ+C0
         vJNXCehY6kptWFAXi+mu0l64NE4rHGfi1vWbQrhsTJ3nh2K/t3g4Kgu9J43zIjelxtYM
         Nlg3YpbVKrWwRsJkuTrjN9mXWKz8WMQimaczJI9f9flr/TrIF+sver4CQRBojEK0mNIl
         1RpHcRSjbw6yt7VpckA/y8q6KzPaS/h57GHeMy32tp1DTZzx1QmXPbIoBl7mxe8QrBbJ
         6Ccg==
X-Forwarded-Encrypted: i=1; AKwUvBzWQbcJhStNSnNdErhOeAJmCGj1tfPToaB8aPT0T41giDKm4tk8hqyJ9Nr3CuFsaL20OAwZ3xICUn8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLo630C/gV6E/HloHXC25N5wWFj7QW9YQkPnQ8s9qyNeIiA6Okq
	JruMI2v0NzBR5EBtsIb/xbxJNZMKjmjX649ny7p+GHqGHluvYMmLEetMAr94JvdJd4Q=
X-Gm-Gg: AYBFou1IHM31bE9yXgbrJ7m95qaJ39+l93E93CYHLht7o/P8j5n0N8JgwiCzszERRdT
	mudPQLfeCAwQb5BQ08ngbAb3sQqVgAM5QxceZT3WAJGR5MAAFKBf3rXy0Fum+lD8j0suHvi5OYT
	gJSFVcbRMNYJ/POJ2awka8weXgdsUaMJfh3BsXTzmPxqt5aSLPqq4H6Gko2ihzvv+xUnfmPS2h7
	ttH+qpXt2xPnGrfpo47sWvVAvX7plw9Xu6FtUubOcZTbQRhODit+CWMsOZ6UJdLBfMojavjGwo4
	EowXnNGLUGKdrqqt1kBJH8nSOz/Z/O96GwG3+tHsax1gHKqc+v+a375PpesNvVVl0p059vhPBMf
	eyL1KLN6DCQgfYc6mvMUzLiNUUD78Lz+mKAqrYI6t1oU6Lrc+bvcrcDIsGYkH+SmK13TNq3My7Q
	8n5e2gwGOTMuEc1xKnYKIzHpjcQxM5NEyoirBe33FdyyEyWkjH6Wmw9LBHVDbDROP/71zVU5skw
	91OkwwO69kkruvfBJbhSXz9SeahiQOhfJVmkjcrnVChvfj5Pi2lO5WnKKrBo0OxzCMUZiyLD4Rj
	eGMmdzgEMLZqqtSrSoycKrzx2H4=
X-Received: by 2002:a05:622a:e082:10b0:537:a19d:40e0 with SMTP id d75a77b69052e-537a19d4158mr12656411cf.35.1792777046504;
        Fri, 23 Oct 2026 10:37:26 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c96375sm201576d6.33.2026.10.23.10.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:37:26 -0700 (PDT)
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
Subject: Re: [ndctl PATCH 0/4] libdaxctl: Fix multi-range memory block
 handling
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: nvdimm@lists.linux.dev, Gregory Price <gourry@gourry.net>, 
 linux-cxl@vger.kernel.org
In-Reply-To: <cover.1792695259.git.alison.schofield@intel.com>
References: <cover.1792695259.git.alison.schofield@intel.com>
Date: Fri, 23 Oct 2026 13:37:25 -0400
Message-Id: <179277704537.2498233.16797078329348590460.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 12:56 -0700, Alison Schofield wrote:
> [ Gregory: Hoping you can help w reviews here ]
> 

in my queue, thanks for looking at this.

-- 
~Gregory

