Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793323050;
	b=CJLwa03kron6CkhbqZLOp6fyFIRoFT4ZqzVbEp8gul2LpQFDMaV8MxM/q8E8M+sKrqdb
	 5MoZWWy3lnomg4SeKS2jC/A+4ltX1toNaHob0K4T045ZyRqFn9l8sYz9bKjVlYQo7VNco
	 wkQbCfkPUXArkvNpeuff8xFRduH7LTadtqKOZoIDTGZpRJMz7/jiQbUwMZYOS5DM31evf
	 y/kMMpcHqpB6MZZjBCaBR6U7Hg3xZfoch1OUdjYV31ZCC8DJwzUTkOlj7iiC05MwrFCV6
	 Uu8juREDzaZtfZir6sq658yh7UVOlu00o+3yKzJfIwhMqDp9GyezlEKQIfDC2GwzrrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=WJ4DVaiAmp5krpfxroberXtVy1jbtY3DUs/Jn0ssYiQ=;
	b=fGhWEDi6Zzj5RuethNfj8yfFv58dpMBj8FP6ua5Q8LiiUBHaBJFyY6YWGKtZJZRWj79M
	 unAOtltLNbYdfJPZlVQyHRucm/VN3dbHKfGH8mhBsy7HO+HVKr9nPlVIDGTp15VhoOvwH
	 PDyPS9csA9HKEnpxeITPfJS3sw42bsq29S0nAoxkDrbUdABjG9LevJy7HiWs4EytPD3m0
	 CNdeaNlJnl/5jD6c/WwmSDFGRIbbNfho6fymhXiGsooNziFnWYArxW1zU8uVhUzhOboWW
	 SPLSnjA4iaC4hIT+WvvYyJmYvSMfH8NVfmkdrM98LD+y6z64PjHbS+MXm8hFBE6myAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KYgf8fP2;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D4606A31C
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 01:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A1D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KYgf8fP2
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e64d52949so11185185a.1
        for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 18:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793323048; x=1793927848; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WJ4DVaiAmp5krpfxroberXtVy1jbtY3DUs/Jn0ssYiQ=;
        b=KYgf8fP20532BC3js6NEKSgprmUIYFVKT99Sit9ucUvLVd+waYnwCeNAAiwqx3JBm9
         VtXOnz6BzdgnPi74xeiIeIRerD8zsgf4f+1x/Nu6cEBDtzVHTvv1F2cFekbibneuykSr
         IvchF9SiQhLJxKYnGxLvVs400zB9EQ/AP29WVNpL7sD+zkSx+MAeVIMrvhi55e9bcq0s
         Yr6rxHTLFFywreOKKnYQf5StA7CFQHd7HrqfvHXS1Jl4xQj54y9sn/E6Vf8Nf8Db8OTr
         sENISPeWz2zIcHlGDC68UC4Rj30AgDIT5Nvifu48lcMGiNyHwhUUd4OHGrRE0lF77iq5
         iw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793323048; x=1793927848;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJ4DVaiAmp5krpfxroberXtVy1jbtY3DUs/Jn0ssYiQ=;
        b=NzxC45yMTTg1RabvaZo1OaQgReaQDmwe22obj5RoXwloVYXaBsMGM22Q6urcz1XFwk
         LeeD6TYjPU8flIvi/+b1b5kHxU0pxqHp99e/XRUaUPZB4mncauCchbEePc7MA4OAqdrn
         VoZVvXAw+j2iFmYajO0r5OXZDKm+/m6VFAyM5mdMqDeQxpbV1srkVVsoVs0oxaTmewpa
         hanCub9uy/iaa8w+dgdfsrPz+l074eo3AoOlTssUsjyu5lSARWltShxD5eDJozK2oxsa
         d6rH8Pctbi38GrcHpVBiyJSWeU0jn5To9qK/nbBnO0P6D4Ecv2v9PZzzo6egPNfUcHJu
         w2lQ==
X-Forwarded-Encrypted: i=1; AKwUvByJJlPQf7qbFOIFS4hGt6AgEv5FrdzMFfQq9nGq0kENx1iJDYOsWPpordjWPJZgAUlCp1nwPTIeljo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZuCUJiBP3Zx3+ipHzi5EWpjqpzKWblSKmn6N98iwK4usfYSH7
	q5EHiS9UwcD28c2TIb5+c4bSRWzD1UY877NslUdNhow5WO8Dyu8v6bSN78qFXRkS4qoat9pbqF3
	Xps34gfg=
X-Gm-Gg: AYBFou3uJwgzMp5crsMuAZTEcotVDXjzQNsaIfjuOU/CTTKl9Zae8HuFIw9L6znBe6o
	7FXeV/CYYmv79TlNU3JshXRuRLbGuCuzBZw9RI/9kxGmgTyFXJxq7PflQb9bKRpoomHZ81BBp+6
	jQMgYvYZt4TCYFU6yXlOUVBrhLfxIs9hVQdyvp++r0Db+2IxJGLxJUrRcVlZWool9qfVUsQn/fJ
	eGqDPxcVYvZTtZwv9EfVN+ZOobg23oofG8km0HEmbRk6mPySzUpgxNwgg9ex/OAT91RJBVx8mYu
	7KHqxmLZpTFVBnwO0tU6BizxcLLfap7YS30eSzYZQC6VkxF7SmAPnRV8pHJXh0WqCeuqZG9APwc
	dRGCkV8f1A9ONFPjaxwiZZaWGIeE3MPyaQGV8yKpWZdK0lXkd8TKLHst0zRlS+Uj02ythNl80k+
	keCNpzgr/6hPiNa2KmUTVYD9hD5CCJ7Bjl7FRYYBhshVcsn5J1x0cbM/ZVGVDateU3Kcyy+ajGQ
	rXNviEjl8gGgmrMof0+0RGeD9IBrmrr6aNvHcKBn+pVqaiPh9sROSKv5XlWxztVxqCne6k7P14/
	8Jd7g+A3mMffkHZM5FHvIMVAOiAOJjKcP4zPH2PSJqu3UaMV14wq70BndrsKmOKAltJpGaPj+Y/
	y
X-Received: by 2002:a05:620a:45ac:b0:93e:c12c:f121 with SMTP id af79cd13be357-944218577eemr157290085a.77.1793323048156;
        Thu, 29 Oct 2026 18:17:28 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm1291836d6.31.2026.10.29.18.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:17:27 -0700 (PDT)
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
Subject: Re: [ndctl PATCH v2 3/4] libdaxctl: match memory blocks against
 each dax device mapping
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: nvdimm@lists.linux.dev, Gregory Price <gourry@gourry.net>, 
 linux-cxl@vger.kernel.org
In-Reply-To: <730b33a1a2d7b4e6b3f319f459bf36f5fd901906.1793315621.git.alison.schofield@intel.com>
References: <cover.1793315621.git.alison.schofield@intel.com>
 <730b33a1a2d7b4e6b3f319f459bf36f5fd901906.1793315621.git.alison.schofield@intel.com>
Date: Thu, 29 Oct 2026 21:17:27 -0400
Message-Id: <179332304704.1311000.8174376858031226516.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 16:44 -0700, Alison Schofield wrote:
> memblock_in_dev() treats a DAX device as one contiguous physical address
> range, even when the device has multiple ranges separated by gaps. This
> misses blocks in later ranges and may incorrectly include blocks belonging
> to another device.
> 
> Memory block counts and per-block online/offline operations use this
> lookup, so daxctl may operate on memory outside the requested device.
> 
> Match blocks against each individual mapping, retaining the single-range
> fallback for older kernels. Reset errno before each readdir() so a stale
> ENOENT from the mapping lookup is not reported as a directory read error.
> 
> Fixes: e8bf803e359b ("libdaxctl: add a 'daxctl_memory' object for memory based operations")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

