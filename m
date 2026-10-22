Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686642;
	b=wCwiUi7ytrfliTT8W7CETRyu2rmpOwTugcdMZrSWLOJqaUNuNJcJE+6Sp99UD2j9NSIS
	 S7Ai+xu2glSGnRsVXIykR+Z709tRSfkPkWT78Xv+yAFhe0r3BDbPEeLdBLGzFjle/FrtK
	 7FpRkjFiiTgU5HmznKta1yEBv7LuG+G9JunqAJJ3oQoIjS2MLMO+eWPSGuLn2Xf/Zspi3
	 WRdK7Xnazez/C5lWtPmYm8fOorNS9JSrMOQ/Cp5EzmjRcRx0StnonPs8hxcNILWD9jgb+
	 lfr4lu11zp+h9wJVcU/ZcNsztDNeTW3uWmfX/UHbfPy2ncMnVXm+N8DpmZgr1fBSB5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=B9wBdkvsPD0u1RN+rtbABzIGn1cuCiu8JDpq3+Srt2A=;
	b=jKjVNuc9MlwkgpsGjAU4L8bu/I39ILf0XM4EwlbXMhlE10SKLDD+xTNthe+iLFJKOiTS
	 JWoqcRppYRh/T+TVhhMSGS8ukPaP4s4DDwiCjYW8/eoVk/TbuQmpcn6C4oLdaL7QaUU5T
	 T1NwAIdMLHopdb7atRLoQbbZ6xU5Q8Dkgnz48Tu6kB7qGGEdAfHbhhXQdOBR9Qw5MZUB0
	 G27axj0//kCSIfk1/k/GDRRGdW9vtHKwLx4FolWWTKYSCkBdvtP9aNPGoENq8w//pO6FM
	 Pzr0Qnt56z6zs5mDbEGxo8ozBYB1oIv3Ywf5m2P/lveYxrlNE8AR38jJbcbmJ0o7Ltw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WfruE+k8;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF64606A31A
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 16:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AF64606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WfruE+k8
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c11468b5fso846376d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792686640; x=1793291440; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B9wBdkvsPD0u1RN+rtbABzIGn1cuCiu8JDpq3+Srt2A=;
        b=WfruE+k8OmimJ1WONHIV3JsEkoaGXhJIBR2pvMra97IzyxGvArRvtEG+yvzT1RMgJa
         2o37lz7r8vKFEtL0U3Dnclvnp7yeK9H4wbChlPQLBhsZXJ8GzIGvij1vSa7EK+fYSy5H
         ZpprsOkAvNcxWFmZtIu37rtHX6RjvIIZNLdomYOYnZmAe/r3WnuXIPPJo5FwBxCaI2cy
         c8NmYyGhD7SPW4S4OIko7DZa2b3Nu6vyGv5FJDMcy9oB/jBvrsO0OCRaSg4k0Z5MWdkB
         NUO6T9yLIrG4opHoContaXuf5OwIz8egZSCuN4Giyy1XYlcNFxPla2JVLx1au2K4qyWg
         CPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792686640; x=1793291440;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B9wBdkvsPD0u1RN+rtbABzIGn1cuCiu8JDpq3+Srt2A=;
        b=ezJMODyOumCpqh5G3ZDjLPgyU/wO/7GyJxduAj2R91j1fEtCcpYpud39zVIq/7/60N
         3BDY7hM9A39riyXlbgY6yAgMMaFcob75B3B8iUqMu/hsVTmZ2zYIexVL9imXMVFtqE8u
         iibG3kWkGqIrv1hRKtivemdicWtukUOBJfhsq9u/F5lKSt1jy6c/DyuOkoVshwwDQAgq
         5CJiry8Z9RAdeOA6cY45eBc2unkP3SqTdXV68EX02+jL9RfgzjEwY4+uQ6ohzn2Td7ih
         kQOWwRVXmFvrJG5LF1nPuK0xR6lXh1fu/VFnkPB/A2/bJAiA3LJo81Iyfar1M0fU4BLx
         iWIQ==
X-Forwarded-Encrypted: i=1; AKwUvByAsnb/cyKy690VSTv/pqB3nza8Oq7n3TtPzKasggTvVLQ69iVQxfTNKjVZTrxTmBJKsS2VgTxzfV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYJV8eTXbV0jrZDJsb8+pdwLyTGyGYuhntgyfcwlafzvviSzIj
	ZWCNx3KFuKgjpZeLzJIZz/3Qdjm0qg9mB3EvmGE3ZKpbl+3LNVBkUie3RPT9Sj/N6vkUc6LIRqa
	6lZdb
X-Gm-Gg: AYBFou1+o7FVrhalSyeTE4aBHh6GKrpW3XfX0rVBAyEgqiWwwCEheUBtPWw+BrWUtDz
	z+q2pdfuh0U1f68FP7YOsj4U3g2gKKGyYCOS/SZ4SpvokOsguFRqi72//3qY6H9Jglrsg3l1uDm
	hu7I3ianfuW0StkSSH56C9evGgsgMG1jJQWcO9iW6KTtMw5qUtfDb7J+MfFOqXYqSx7gU7AValt
	WqLvO42NtV+fHudPD6AjxIEqR6NiCV1OKBRaukVX8gP/H8ZtlsbxY4TJGOzvS3Um7bTEvAcS8HH
	qchVtreaoQTkv43vje7FaRKD5Hvj5GaRp634xRQikIl1ZMs0xDoRoOdyGa89gtIGXlHBIA9dZMB
	L3zm1WUr7Fp+5mRbG7uo7EBmyADsjitJORyaCN35bC/EAUMmZ3GbwiFP9P3AW2E6aDXkVLCoji4
	+ZaqnLOuHFu1hIwfL483GYGSR+XPoW+sWj6Wpt5I7tMUNkOst7OxL7cHBEH6yESf+EnvHWUGJBQ
	RIBvNft0ov2ZEmuIR4pIA7KyNcUM7lD8ZjRbVC3vfinfseTKdXuVgZ7Z2Z00gvo8gP7jY/miwvM
	wWmyHj7BKAzklKNAK7FhnrEGUAg=
X-Received: by 2002:a05:620a:2796:b0:93c:9c0b:3898 with SMTP id af79cd13be357-93f57f58197mr938681785a.59.1792686637640;
        Thu, 22 Oct 2026 09:30:37 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e0952asm548887785a.34.2026.10.22.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:30:37 -0700 (PDT)
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
Subject: Re: [PATCH 0/6] daxctl: use dax kmem atomic whole-device hotplug
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org
In-Reply-To: <atluEdaffcWYOf_0@aschofie-mobl2.lan>
References: <20261016214248.443247-1-gourry@gourry.net>
 <atluEdaffcWYOf_0@aschofie-mobl2.lan>
Date: Thu, 22 Oct 2026 12:30:36 -0400
Message-Id: <179268663642.4072493.16012427078662920029.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-21 18:59 -0700, Alison Schofield wrote:
> On Fri, Oct 16, 2026 at 05:42:42PM -0400, Gregory Price (Meta) wrote:
> Hi Greg,
> 
> Next version, please add the ndctl label, ie [ndctl PATCH v2 0/6]
> (https://github.com/pmem/ndctl?tab=contributing-ov-file)

yeah sorry, i realized immediately after I sent it.  Noted for the
future.  I did also open a PR on github.

> 
> I see this goes with the kernel functionality that arrived in kernel 7.3.
> That took me a bit to realized because the linked kernel series shows
> crickets at v7.
> 
> I'd like to get this into the pending ndctl release, so let's see if we
> can close on a few things.
> 
> I tested against 7.3, regression and new tests and all is good there.
> I tested against 7.2 because daxctl command functionality itself needs to
> be backward compatible, and it is!
> 

I spent a good amount of time testing that it is :]

> Some per patch feedback and tags follow.
> 

ack

-- 
~Gregory

