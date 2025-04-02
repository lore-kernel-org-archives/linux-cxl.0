Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E61EF0A3
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636360; cv=none; b=K1/KyxIegAOM95/iB2VJbnIEWsQCOWgyig9xnGmsoKHR6qaDO8hsZ799xsJfOJguIEMEQNtK8umIK8DerRRB6P6p8u2+oL4xL+Jv01iMe1FAeb4xcNZDuEYb1nX6Z5cJMK3847KhBh9tWnAkVOO6vX+y6sEAmqwabfQz4oMDTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636360; c=relaxed/simple;
	bh=sNRakoLWax2/Sy9bAn36kFcSUZriKDi9AhtMAS1mqiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvtBAppImTiStydRwxT14BjO6BBTAaKt4URpBm/uLtHQjxcZSeh09LMVuFPAv9TL+sQjgaIBEcaV9yG9efhCOpWy6DazHPvBn9o0lAsBduWNMN3WUXh7yTcSc9Gb3uDGimJU9aU8+Qns5BwHS7By+xCP0qbgQf2uaDKv3hA6wQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jEIqNqss; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jEIqNqss"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-477296dce76so2554461cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 02 Apr 2025 16:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743636356; x=1744241156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qglszhMPO/rWnXqXnD/3YJU/aNcJ8FUcQQSj6Lbju+A=;
        b=jEIqNqssvyziLurFBkDPOatD4k5+cI5EZ4uDNU5r5Zslkvwh5DdAf6BORtm+xJc8Xi
         4qKRLE48GLVbo9zrL/gh7X/uzfBBq42BLoG9d6ZHcDoSNDZonKmfDwgt2txQJpN7zHpG
         LF4hFFK/wZe2VtLzWWSQJGfsHSJYEAXKnr9I0bGcVQReYZRJR3RzAjJ8vJdMnZ/ujRWy
         rRKX8bWwjDbhI7dHBSwvGSANspT8F11nX53DYhMEBIpBYuOCYCpofKNQUizJCk4VRsc1
         bWvoBY0v8mEvRxg0iUcX0iI7lj4jRGXWulZ59j0ztqFyWK3HtuVycunokhX5b6O/CHpE
         tCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743636356; x=1744241156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qglszhMPO/rWnXqXnD/3YJU/aNcJ8FUcQQSj6Lbju+A=;
        b=YzDoxL5ZUJSGg8TvwWztkU0hGlmPhQYnkXg3V001lyRtQwGsl5eDf5JVucjCfBVDe2
         mI8fWQ0kyX6wG0kvJ3aoJv8FewYShpv2irRfTbCfve2D8c3Yd4psyYWjSFmZtfkX/wYd
         u3D3LtAAducXVErSdVGn2fl3AEIYFjp4mggzIaqsfVbM4NIfIwad2qEuuIR30W87BOZq
         LVQkXs0eOrvgA2sK/7EhIk1/19rN15eCTWcpVPC1YUcmqQ7G2M5nk40NTEfAb0EVsNbb
         3/M1zbJvk2/ja3odC3VncIpGAM9tDW3KEurdHSrirwkPbts7uivTcT+CKQsb3pheBvi/
         NNBw==
X-Gm-Message-State: AOJu0YyHy+l0PfWzMbHQ9qMV3uEu7sBfbYHZjEpD0rUFuhfliGpF2xH0
	i9T5WRGM49MmRsefPpXStD2ARyyFXnZUji46aLZ1FcVCfZmEj9MBmznFg6YCEjVXSH30roNpTaC
	C
X-Gm-Gg: ASbGnctl7Eg3f8656/DzcXwk0Fl4ITHQ24i45wBWZYLXMow9pZC3pRHWWEfG7qhbf8Y
	WAL0RAxi6wp8DeFu+1hrvIzQxQ9ZclvlyD1fTJxwAGw+LQN84wKOGWOxvUCYwIb0QgS62hFjuSV
	33deGgmXTVsp7FEyJa0rjlJ8+Y5vlNjEBgtcMDxtZa6hu2AWqE0Mv48jEhtC6YP2ZEinl9N7rGB
	LDU6OqALSdgNS1nKG3aeD/uQCH3teG8zJkbM2Sn5x31U9ViRgD44i3Nk1ZKwJokpQOwKAbpvsMo
	huoJlCHgYUKLmFVQ6TnWioQ247+A/UJYdbUoikuXiNJecfqcfbJMYFStV7OVqJ6YcD12KXctZCT
	K4xRI3ERaGDjpL5NKSxJ/pkJtalfIF3qC
X-Google-Smtp-Source: AGHT+IHRpZMBxvw5548CGHuNQlFhYfjRmI93KdHnuWhYZHThFbcpf23Zmq6d6JyIQ7DzX5oC9VzDaw==
X-Received: by 2002:ac8:5e07:0:b0:477:1e85:1e1b with SMTP id d75a77b69052e-47909f584dfmr55221091cf.8.1743636356506;
        Wed, 02 Apr 2025 16:25:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b1446e1sm427021cf.73.2025.04.02.16.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:25:56 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com
Subject: [PATCH v2] cxl: core/region - ignore interleave granularity when ways=1
Date: Wed,  2 Apr 2025 19:25:52 -0400
Message-ID: <20250402232552.999634-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When validating decoder IW/IG when setting up regions, the granularity
is irrelevant when iw=1 - all accesses will always route to the only
target anyway - so all ig values are "correct". Loosen the requirement
that `ig = (parent_iw * parent_ig)` when iw=1.

On some Zen5 platforms, the platform BIOS specifies a 256-byte
interleave granularity window for host bridges when there is only
one target downstream.  This leads to Linux rejecting the configuration
of a region with a x2 root with two x1 hostbridges.

Decoder Programming:
   root - iw:2 ig:256
   hb1  - iw:1 ig:256  (Linux expects 512)
   hb2  - iw:1 ig:256  (Linux expects 512)
   ep1  - iw:2 ig:256
   ep2  - iw:2 ig:256

This change allows all decoders downstream of a passthrough decoder to
also be configured as passthrough (iw:1 ig:X), but still disallows
downstream decoders from applying subsequent interleaves.

e.g. in the above example if there was another decoder south of hb1
attempting to interleave 2 endpoints - Linux would enforce hb1.ig=512
because the southern decoder would have iw:2 and require ig=pig*piw.

Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 04bc6cad092c..dec262eadf9a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1553,7 +1553,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
-		    cxld->interleave_granularity != ig ||
+		    (iw > 1 && cxld->interleave_granularity != ig) ||
 		    cxled->spa_range.start != p->res->start ||
 		    cxled->spa_range.end != p->res->end ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
-- 
2.47.1

