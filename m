Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195748;
	b=UOYD5oyEd6dpF/G/fn+lw4LvQJdKxZn1A2dE59DQXy1lezaFm/EBPzQLaMUOHRC+T5ra
	 Oe4DrQDSIvlph57pluaGEZCN4nkQ45bU+ceMwkOz1p3aMEAH2eGJXwDB5FdhemU4bm4Of
	 VN2mdVolkM4iCFI8zdwB99T5bzkmKARRIVWfjXrpFn628/XFKkAX8nz3wRquNF7fnoOqM
	 sdt2K2+0cW1KHQAisn0WUcjUUW3t0+yoBB+lpXzAKcrbeFkx+kjZjEqu1JlMX/5yIzQp4
	 JpImEaLp7lgJtZ0Mt7+N1PNCiNLOIIhDRyLvXUXX6jTlVcBiGD6pfSt5jcjmrczI0YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=FTua7rg4GDko5qmXH3XgkgEw8Vao7QVw3C0DynZlLyQ=;
	b=gUoccs0lFrj/DCqiiOq26FQn39IIEsKHk1emwgBjQIAg+2ik51Lm3HJL3JWZCEViVzNy
	 Y4Qq901b5+5WB3fKlYiY6UcKMP2cNK2K0g+iBp3hgV8UmdBVShaLMqN8c0ufsmshW6PH9
	 gPnezu5L5WkMvn3P5vYC0ZKbNAzkA5VskmsWGX2iPo+arqOyu56r2ECf7AK8PTC2EvzF2
	 RIlu24h03UG2hiP3DjoBNVuDhfRzYFZ3KuPsPZNeGhTcqKZUDqNkTldWWV/WCkvXweMtW
	 nq5IPPl3LGKKZdmK4RnweCvtFLKCThl0jfcHg10LEsHqCAhWqF+96hsbqo+tsfVm1eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PuchEbQD;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381AD606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 13:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 381AD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PuchEbQD
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1f4d8e09aso1530809a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793195746; x=1793800546; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FTua7rg4GDko5qmXH3XgkgEw8Vao7QVw3C0DynZlLyQ=;
        b=PuchEbQDv1O28t+P7xnx9R8+KuaR2aUWETtB2/u/GCWEG8juMbswGsylOeFPXvomjn
         9UcT2zvhg8cbB+mIjgp6Lvgk1bdnVJdkcTbn9Ia0FVwgbJy/k+yIAO2X/nsuTudmd6Fj
         jsCUCvILb0DjkTt2orywCU2zbBdzlZ0vdR8yx/HEniN/MhADdPZlEjaDpwoinniO6bs3
         Jg4fjH8xx17IqDFvQnZ28mWPOgU3rFQppz44D2qLBQ6pXkTFEcVB2Lr6baznk4OH3TW0
         EsQlhwFJboo34ninkyB6QfWONgweTojlpimvPVxG7bn7sObclXk/3U2EN2YHxtPJQXxO
         EEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195746; x=1793800546;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTua7rg4GDko5qmXH3XgkgEw8Vao7QVw3C0DynZlLyQ=;
        b=tYVWniT0ugXB2HygiSE4TTSqyCrxJj5Xz3tq6pC/qJNhSOgc1iFq/4SazAw7fBCcap
         /BLqN/wq4+PbeNFw7jm7IACmE2XHvnojkOKdgPumcTvgTjge8oElWVAgkYdnqL/sAQzw
         iY3DI39MGWUb6onBBeB3ZLURknPXWPHNE9N7VAOslIzOrdiIwtfsiyHiawNYIAn2aaQS
         iVnoU4APyr3NaYchrYZd3p7mmN2RoiJh3HV9sXLRlGaSRaRxjgKOPBzYMjAY7W0F8ydz
         THDU1bylKNy6NxULNyawV7in4xl10d7WR8YI2wUMDqPft9Cg5IfDoZNuQ6lb4wbDN/X1
         yEWg==
X-Forwarded-Encrypted: i=1; AKwUvBxk2jy8dzr0q2VBcnvx43eHnLSiR7VDE0O0np7RArpMz7n8d1tu8lSQbuwuWvwt1uN50EgZUu2zhPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfgx0vZYQ+VDsMfFnN3LW5l22hv0sCEzQ3JKDCZ9RfRbZxImqf
	eYDNxiBRt2/nKnukkFqyDLGPVpQFr6p0ks3r+6p5k1nNv1csNeDfi0wLxw09KeQ62Es=
X-Gm-Gg: AYBFou34lxEesWIz4ZAkBBrCO58Ix4xg+bRWQ7j0a0U1G6zCXbb7n9LkgMsihMP0LO8
	FStSIP1dLOMJI0Ea1HfAWxSMGlVvRaqBOdrbtzlLdpnnyjLAYySVyuYUWXR1jwPQBVjpPehxhNq
	YU+Buxfb4k4+li3F1KVeZDWMbcmb0YLYsJfnREny8f9wZzcVi+Lakw5zqqBmF23SWZtPoM/TyxE
	TV946cU2v7TCiFAOR7Pxg5gi1m2dorqtbo1ONzU5JOGdsvoRBAmMmooeJ3+kj0lQ3807nSpFsvg
	WgiHHGiQ3ZFEIAmNZ6ilA6zrZq7D+GYM5yLnu7ScohpvwTrsyfa9c2rdx7usdgwPRIxRBfCZdiy
	DbN7Exm0cxKtix6I5Jwe/QHq7DiGmbO1nVvALR6UusEObLQd3XmJ459FWnfpBKDD8nKKfbrW7hy
	ON4wIKNehbKx9v+3qPUTyiepMWcse1KZoxlR+lXay3nKAAjjV8YYB00gvfLWMgJ60+QvZ+r5/NA
	NbYwV+Ht12S5M6XXDYjxgIB5/BkQeI3tHJURMjtxaxFf5obKoH29aT2lFpDVSB5UAMotA9dJ5Zm
	tLjK8V9Ma2X35RHSUDU=
X-Received: by 2002:a05:6402:518f:b0:6b3:8018:7643 with SMTP id 4fb4d7f45d1cf-6b49cc2222amr1744746a12.45.1793195746374;
        Wed, 28 Oct 2026 06:55:46 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4952e380csm1585500a12.0.2026.10.28.06.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:55:45 -0700 (PDT)
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
Subject: Re: [ndctl PATCH 3/4] libdaxctl: match memory blocks against each
 dax device mapping
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: nvdimm@lists.linux.dev, Gregory Price <gourry@gourry.net>, 
 linux-cxl@vger.kernel.org
In-Reply-To: <45bcae14b4f665af8427ebe38afdb9eff282bacd.1792695259.git.alison.schofield@intel.com>
References: <cover.1792695259.git.alison.schofield@intel.com>
 <45bcae14b4f665af8427ebe38afdb9eff282bacd.1792695259.git.alison.schofield@intel.com>
Date: Wed, 28 Oct 2026 06:55:44 -0700
Message-Id: <179319574485.768545.678014460424399236.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 12:56 -0700, Alison Schofield wrote:
> memblock_in_dev() treats a DAX device as one contiguous physical address
> range, even when the device has multiple ranges separated by gaps. This
> misses blocks in later ranges and may incorrectly include blocks belonging
> to another device.
> 
> Memory block counts and per-block online/offline operations use this
> lookup, so daxctl may operate on memory outside the requested device.
> 
> Match blocks against each individual mapping, retaining the single-range
> fallback for older kernels.
> 
> Fixes: e8bf803e359b ("libdaxctl: add a 'daxctl_memory' object for memory based operations")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  daxctl/lib/libdaxctl.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>

Ran through an analysis and testing round with my clanker, seems to want
this fixup.  Looked reasonable, just passing it along.

Will get proper tags for you this week.

-- >8 --

Counting an unplugged device's blocks can return -ENOENT when its node
still has unrelated RAM. mappings_init() leaves ENOENT after probing
past the final mapping, and unrelated blocks take continue before the
scan resets errno. End-of-directory can preserve that stale error.

Clear errno immediately before each readdir() call so the final errno
check describes that read alone. Errors from block operations still
exit through out_dir with their saved return value.

This corrects "libdaxctl: match memory blocks against each dax device
mapping". Returning real node-directory entries with memory entries
last reproduces the error in the posted series and verifies the fix.

---
 daxctl/lib/libdaxctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index e106fff..c154db9 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1716,8 +1716,8 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 		return rc;
 	}
 
-	errno = 0;
-	while ((de = readdir(node_dir)) != NULL) {
+	/* Helpers may leave errno set even when a block is skipped. */
+	for (errno = 0; (de = readdir(node_dir)) != NULL; errno = 0) {
 		if (strncmp(de->d_name, "memory", 6) == 0) {
 			if (strncmp(de->d_name, "memory_", 7) == 0)
 				continue;
@@ -1734,7 +1734,6 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 			if (rc == 0)
 				count++;
 		}
-		errno = 0;
 	}
 
 	if (status_flags & MEM_ST_ZONE_INCONSISTENT)

-- 
Gregory Price (Meta) <gourry@gourry.net>
