Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D54457B0
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745341; cv=none; b=N8vz1mVluU9IVCPpYDbQoUq5EjSEk50RD7aIorJwb19ACEPqf+szoot91Nx6ye3WyZ/QJbaZDOHMpTiUXGl6rC3lzH+YpYXs1V/S4tUQu4iOQhtDm8F8TH3dVLx8EcClayPk87jfXJWM/acGLR34uZ4qZfQv5PL2Nh3LHiiHuxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745341; c=relaxed/simple;
	bh=4PQ5VCJ0pj1ClQf+gL1DN0rbtJDX7VFniSFaE/SsM8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5ia9Ejsg5Q4YfrME3l70iWnkra/ersuGnvUxx8Se3ruab/XqQ+gJXk7h7VusfEYkvx7e8hu6t63iFzB1gZP0BbXQzTqKb5oT5nVuYqhGKdIMy7R971kZJWUrx8HZBH+0zo1rP5jWxs3YWvOCBJ4bZjNa7hngetvj3CBjnCwo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QR2qusyJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QR2qusyJ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-907ae240ac3so13962706d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784745334; x=1785350134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enIHLWVARnnU4GIJ2wcKxnnWYjtcTdK3mCRnzCxbEg4=;
        b=QR2qusyJXl++DXwGm21FlzAZ0Z5jRRbzJIzwOM5+2ej0fkulK7JP/Y6drVrBFo+NWN
         TKTQ81OgtH6nBB4ONQa3yfQFp9SkEcZl1x8SI/RT6awM4nX7YRrJH21a8X1vHSVD5V2u
         l2od5/8bhdLovwhk6SJJDv/87iGIpDO4+h/BW9bf8PvUIw2OOElE3Is4sNAVAjYqwY6Z
         XpYVtA8xg2BzOfYIuE/niHv6ZQQh/3FK9Xnu1ocYm3Gn8/Vshwh+r+PPdUDe3cnHveXV
         bC0bjSXYfin12EgYSeimTGFiKmOFU18l5ZfSZ84vFv/YF3aNR+7sksGAKPOQijYh3/Pe
         NRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745334; x=1785350134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=enIHLWVARnnU4GIJ2wcKxnnWYjtcTdK3mCRnzCxbEg4=;
        b=HaebH2wBvcgSw/iSB3SPzIX8rv23h3GMZOxlLOyVQL5OmWVWr8LwqdudOph2ltGU2m
         ktwiOkey3F0i/1bnocv2laNRrjm65UjzUiIslY0pkbl8Aa2xBCFJumzupRt037OMoS84
         Qv9zcI7SaDU2fNM2pCzXA3sKGgAUYIAl3qDkcWQtJQQDxnPUPehdAmz4rwnfUifdxxbc
         KBsBsKYZ+bHCH1rOtkSwq/lsNEx5H9qX8TZkzkP6MCM3FP7lGPlzD06ikbnJukmg1JHt
         +hp9adWLxx7azwgi95Vx/oL2ahz44RC5+OXP1wWtWji4BP7uYZUDNJNryo1A0dPDzVaQ
         rpZg==
X-Gm-Message-State: AOJu0YyjrupuTDT5t+uipzw2zW9QEMbN0Ov3akWrnob2jK5aHUtFV0pY
	WjaPzum9kJWwPMYq5nHpZ53QMkezHxlI5TKJPl9RMr0VzmAlosvoov+otojsOLvXVH2MdBKgJRZ
	pryo6
X-Gm-Gg: AR+sD12l2EFMoWJrvc5n/mndI8MghH/Ehq2E8iMxC1UEm9Csu0MIdCEr5rwZpk5xt39
	9WeBfCZNjdXcaIEoqobIz6b6J6rvrSOrMJs3e4EuDvJwkaQm9EBvmon9f4fPcn5eGZ9NjjTA5RH
	FmHs6yAx/0hU6RT5v9n6Fo25/9LDgfodnlvmesbsdW2f3MzlzaRI+59H1i6rsm/PYT3fI+2sSTe
	kxVwBos3/b6R080fLW2P5W9kKX6MoJSs0rQGgkXPwuQiymmzKYh4n7Um2el2u+r56lTK/qAOdMy
	odzfaGdUmozIpv3D1+XC3YdpBoN+Pi8Sz4Eikh5EYqQ+UstkPCrCVBDlpl0ka7CiLV/00YiU8iM
	uwaAQ8ZC3O0/THV5iYYck36rUzCXX2d8I0yo8PWDejLTPEqRYk6K0+KQcP8M5SIKzOYUojv/pqU
	+0ZDbmINg5bobUt44uADx7ajMIMyG8nGxOpE1rEoQeOvuwwTVWYjfIF+ONSrJg9pY=
X-Received: by 2002:a05:6214:5a0a:b0:8f2:3472:5b33 with SMTP id 6a1803df08f44-907ca5946b5mr229296d6.23.1784745334110;
        Wed, 22 Jul 2026 11:35:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b3e96sm27630216d6.1.2026.07.22.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:35:33 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [RFC PATCH 7/8] dax/kmem: add the ltpin opt-in (CAP_LTPIN) for private nodes
Date: Wed, 22 Jul 2026 14:35:18 -0400
Message-ID: <20260722183519.935213-8-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722183519.935213-1-gourry@gourry.net>
References: <20260722183519.935213-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "ltpin" opt-in setting for NODE_PRIVATE_CAP_LTPIN so long-term GUP
pins (FOLL_LONGTERM) may target the node's folios.

Long-term pins block migration and hot-unplug indefinitely, so they are
refused on a private node unless it explicitly opts in.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 1cb3384c003e3..c33dac5939edd 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -633,6 +633,7 @@ KMEM_PRIVATE_CAP_ATTR(user_numa, NODE_PRIVATE_CAP_USER_NUMA);
 KMEM_PRIVATE_CAP_ATTR(hotunplug, NODE_PRIVATE_CAP_HOTUNPLUG);
 KMEM_PRIVATE_CAP_ATTR(demotion, NODE_PRIVATE_CAP_DEMOTION);
 KMEM_PRIVATE_CAP_ATTR(numa_balancing, NODE_PRIVATE_CAP_NUMA_BALANCING);
+KMEM_PRIVATE_CAP_ATTR(ltpin, NODE_PRIVATE_CAP_LTPIN);
 
 /* Per-service opt-ins. Visibility toggled by 'private' control */
 static struct attribute *dax_kmem_private_attrs[] = {
@@ -641,6 +642,7 @@ static struct attribute *dax_kmem_private_attrs[] = {
 	&dev_attr_hotunplug.attr,
 	&dev_attr_demotion.attr,
 	&dev_attr_numa_balancing.attr,
+	&dev_attr_ltpin.attr,
 	NULL,
 };
 static const struct attribute_group dax_kmem_private_group = {
-- 
2.53.0-Meta

