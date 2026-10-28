Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222562;
	b=G9lryEXX3Q1Jtm7rMl/n3oRQUpDZT8ZWsztFZ4nu+E+3jRvpvW/pHT9QJga3rYldfPaj
	 n2B0eBfdjYDdC0KZa1WOXaHYeMzFHzTN4Vzjh3t0PJGfLd8gEZ//0av12RpgWf4DF4jns
	 iCACcTR7MUWj2tNCBKDcqm7OG/Q6krorJgI2X7Hmv7Pqd8w8XMlHHUSXlbHelw3PTaQ35
	 phGSHdctJv3BtcyfSPr8WRKcofDrLgsjwWuQGy1ssx8qurvlUutkY8u5l5jP/8JiOhR0A
	 OKCcyUeUWXgI8icPZcz1y82dgNe49mEzSRPZL5V5Le/i1l4URUeRL0bwR9e1TzjLjHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-Mailer;
	bh=WMki2iGDcWIUAFS2COZpWEg7kj0OK6Yz3Faiyp7P30s=;
	b=mPq12UenWsraphAG2w226pmURHT7GuQoeUU7DgCa7VpTNHQ9rV4pGyN/GJt+j3d/qXHk
	 HaWCukkYufG1c+kIIZDmZqNIJ1ksq0RulA90QQFAPHmt05amlZmqTnqLTvnbzZhqjWv84
	 ei3Is9Zo7u4wAYKKVqbhox4edrvqk8PjVNHsodHPNpR4L8zzZ9n9kw/AbJm6OJ77bWhDk
	 GlV0I3CF+v0jW9gAPCs1CnOWbKWBTtSYJ7JFFMfDEbAZAl0OWkKji+XUNCcCayoiJUymA
	 9/XnXYDA4y7Qllw/7Ou/xF4P7Mf+YuNdoas6R4273f42kVIqciBAOaC4rum9mhm6SnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=A7jbuUAq;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6894606A321
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 21:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6894606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=A7jbuUAq
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso157380a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793222560; x=1793827360; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WMki2iGDcWIUAFS2COZpWEg7kj0OK6Yz3Faiyp7P30s=;
        b=A7jbuUAqYpfO0vAk2Eumz02eNSwU5WPmtoQwO+6EKYN5wMOgLaG9kcU4BN9QbVD/t1
         cBRMIyvwqaC1LcAfH+sDwzlDJZaXixXK6eNah3UPSqTm+HiCZeBm4P0RbRsFvcFQqXXZ
         bIPDTo8+fixpYluUhP1LE+xb3e4D4j44g39nbudrFykkqhqYkbCiyE6uaQlhl4Dnxqve
         Y36gmtwfxA9NLyHA6uSELUuvqVkVJu4w72kzyyZ/OvC2PEs/e0pJgoYrkHa5Len2X3l0
         b9t55YLGoDskY38aAfehhB35WiZUhjJbppVRWzNAGW8MtIt5yTLirXQSSQd0aLxsa1wW
         REqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222560; x=1793827360;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WMki2iGDcWIUAFS2COZpWEg7kj0OK6Yz3Faiyp7P30s=;
        b=sS8p5Mm/fFrTSDIrJv8djYcNaV51YD/rvP2nCspY9eDKcmnfA9pKMctxgDrPEUADMG
         jV/kSO9oNKDYkTlV3tSk8w6CiAYKYcbPXMg1lzOzholsaML8Fm0pDKmlbnzIXZXwTXU1
         slSosrzqk6cqyZyVth8/7g9HJmvQrMjQMXHsVf5E3G3dD5rzxSjI4a6dXcK/QrY6DXLI
         djOlvlOiQ/w9n6OrCo11nQ6URCHnxJIOD2j7T9lvcowRy+FIU1OwNHle5aaJJQpVr1Et
         TU2Fwf6OZVb5FEffRfv0YS251o48H+s3mMG3dgcqxlkUftJiYOzNx/6ZueCUXU96NBJC
         89Sw==
X-Gm-Message-State: AFq9FYI0iqIsMrIUf9I2dpWLQP6a+dDipnLw4fyNnbdJxc5QIxAP+idT
	x1mkIdJhWGZBfdQzHxpNiB/O4KXorHwkrryA6AKn5dCV/vep9kGukcYb+HYlbg7w++TT9E6DDxW
	KN1ytKcE=
X-Gm-Gg: AYBFou1cXV7QHaDA2sx1y6Br2HU9r44EFOeP1kvF2XsLCSZeSgMwCIyctRVFe/sKTk8
	fNTUuiSaSQxmd/xzmSfm5WFxaiWLMMW6mugrEqzDxX8lxCgh7cBMOLmREcZcGf9o9tBxz8+h3lW
	4IXA+j4Z9ARUOXQfas/PFqP/paRX6FNQgHtq11DAtT9wWodSz1h8dfSkSChUJyLA3oHwnQrzuNs
	QB9l9ZpBHfnHxk5OxlwHbK836xXYfIvsXLwrVL09M58bEUOfZnyrx4dTy8x6E4uIS/eh2Jhat9j
	vkw50rU7MuZ5xOFytB5oZruBjnpUsQNq7QQbTGUvTMJkQAXP99zAq/KW6T+/T2RWnRnLfrasknp
	gI8yK21+bLjKnNxWy6qDte+oShqRcv1YSDywY+2JawJk3WxJJINR6i4gZkCWP1wPhON/VIlvAiS
	Cu4HT8n40IwH/3Se4JT/4oyTk285K+m4rUJtw6VwdQRj6g0Gvf6z9Y0d68mmtU/u+a3QcZ6q5ok
	Giyg0fID7K3zTEI9NXgnFRsRnxgg52Xeq5+TMrD2k+Q220mpjfxSESvfDLOZ1ayRktiD8+9fQUL
	zSuIOvZd2VRFCH931cR8
X-Received: by 2002:aa7:c789:0:b0:6b3:e4e8:74ba with SMTP id 4fb4d7f45d1cf-6b4b0be034fmr390383a12.13.1793222559800;
        Wed, 28 Oct 2026 14:22:39 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:44::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964488e8sm1911850a12.31.2026.10.28.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:22:37 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nvdimm@lists.linux.dev, alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: [ndctl PATCH] libdaxctl: check the zone of onlined memory blocks
Date: Wed, 28 Oct 2026 14:21:23 -0700
Message-ID: <179322248318.3398847.13424413341337264007@gourry.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mailer: b4 0.17-dev

daxctl_memory_online_with_zone() is meant to scan the device's blocks
after onlining them and fail with -EBUSY if any block is not in the
requested zone: an agent such as an auto-online policy or a udev rule
may have onlined some blocks first, into a zone daxctl did not ask for.
online_one_memblock() relies on that scan, it ignores a failed write
for a block that someone else onlined ("There will be a full scan for
zone correctness later").

But daxctl_memory_op() returns the number of blocks it onlined, and the
function returns early on any non-zero value, so the scan only ever
runs when no block was onlined at all.  Whenever daxctl does online
memory, a zone mismatch goes unreported.

Example: 
  memory_hotplug.online_policy=auto-movable
  reconfigure-device --no-movable -m system-ram

  => reports success with the memory in ZONE_MOVABLE.

Return early only on errors, and return the number of onlined blocks
after the scan.

Fixes: 0542201b5902 ("daxctl: detect races when onlining memory blocks")
Signed-off-by: "Gregory Price (Meta)" <gourry@gourry.net>

---
 daxctl/lib/libdaxctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 01b1915..f4b2fda 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1691,7 +1691,7 @@ static int daxctl_memory_online_with_zone(struct daxctl_memory *mem,
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
-	int rc;
+	int rc, count;
 
 	switch (zone) {
 	case MEM_ZONE_MOVABLE:
@@ -1704,8 +1704,9 @@ static int daxctl_memory_online_with_zone(struct daxctl_memory *mem,
 		err(ctx, "%s: BUG: invalid zone for onlining\n", devname);
 		rc = -EINVAL;
 	}
-	if (rc)
+	if (rc < 0)
 		return rc;
+	count = rc;
 
 	/*
 	 * Detect any potential races when blocks were being brought online by
@@ -1724,7 +1725,7 @@ static int daxctl_memory_online_with_zone(struct daxctl_memory *mem,
 		return -EBUSY;
 	}
 
-	return rc;
+	return count;
 }
 
 DAXCTL_EXPORT int daxctl_memory_online(struct daxctl_memory *mem)

