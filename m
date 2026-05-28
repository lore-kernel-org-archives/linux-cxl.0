Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDD1A680F
	for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 05:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947757; cv=none; b=QLSirx8hNxo80QnnySPjdbOY2ifD7eSlegtIQ1Wf8ynZL9MbrFmK9SWLZSk/rhHxqZq4tZllMLojvZazMOAs83p9fQLGuOrv9BIYZg/dbK0mjd3hsMPhoZyDZBq6TQP1gZHhPSQeMkJ2ribcPFq7c1VI+zf+lepEW8aL3V7OTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947757; c=relaxed/simple;
	bh=yxjOlZK2OiSCsBOg2UwiHx71hZLJL/H+5jNS9iPnx94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ENCIyBab7G3tzX8vbWn+ns/1A8kmafagGTqiWmbVA4bL5Mz377qdqB1zsL3NtzksATPyoXyUQK1gJawtlbT3FCXoLQqgDIz1S8DbQqWjcUv+tEk7gWNAiLAxMPMJx94jv4Y1bel+tA3HSJh98T8+tqXeeokw9ktQFY9ZJHTTppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puhKdIpQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puhKdIpQ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-835c98b659eso9964783b3a.0
        for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 22:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947755; x=1780552555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+/x1y/Lh0bso6UxK1vW2WZa03KFzqlFGYCtQYm4XYY=;
        b=puhKdIpQb4gxigjCC/R0TKyPlQzIQUWFdeiJBQ1g5YT3rhxg3OvNN2+gSZDBP+5YVx
         8VL1Xmgj1G6q7s/m/ZIrvP3noM1ol6PbasgaX7dfZxRoDDR3VY08EmgMclsVyfOXsewX
         KZ8V3ziN2m6cJWwU99gERiEF5zyCRckBJx4P0Q+39hrVow5xHOB8eSB0oWhqYvDzE98c
         YTpIfHMHK5g3zU39FKmO1LyQACjwIO+TMuCaiwHrsZgloy/XNFuEMwNEiRcP0ep9FMgQ
         uq+Ok+w447UDYONYg6SMZ50GCqX0K4iEL4gl6zd7OwO5ElArWu+9hkASOK2m6Y+kvVxb
         5lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947755; x=1780552555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+/x1y/Lh0bso6UxK1vW2WZa03KFzqlFGYCtQYm4XYY=;
        b=hxi+zcUOOQSocwb58IwQ9S834WgYBQj6NK8KpKDlomhIu4s3a/LdBlgK3T6l2c9Yim
         JGlSczwL0Bmul8Qb37K6gX7+GXsAnPMeFnocsgClexOt1l6tO0AAVI839zC5pLxY5XBs
         dp/xcqxU3z3v24+k2AYIvR/43G7bTy28VoGVByIVIdWKKmeoCArsNkw+y3m86LfaefaS
         HaxIVHlMmLf4dPF/DXXhAO9ykIY0Oxuqus3rq5COhd4hpXO+B6eq1mM1icSlAYdGgIul
         OnebSZ3hcNCTM1iwDjrvGOjsRd2Q/0WVAHdfB+RJDVUI53xRtrLRJrLSH4j1j5xuyvXF
         DuBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZosIbRNBA6e83wdoH82ygR8k7BHLGZr4/p5JYJmPSPr4x+ttQCfxbQbEu2tZJMvBNo4nHf/2stFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LJH9heyoTx5Ub44BwAAJTqWK9aD1mziu2rMZ+vGEJbMq8UXf
	SYNRLAINTUwC9dGtD1h63Hl4wDWjckQ+Veax7oONXJj6fRT9Q5f3sy8o
X-Gm-Gg: Acq92OGKkfx4nJHxzgoTiXVEl5F9zHSZIq1DH30vBonxxacBhPwmErQRIAh/cLVgK7a
	95I6PALS7AauKEdp7AAkyerh5S4NFFCXKv3F8hAfbng+I6Or34U96xGXPxFyrVMQpl3mTosTCk3
	eJ3ohtyHpEoQ0zQGKGQW9Go8pPlYnh4bLU3kgXVopJ8R1LJam1TQwFceOBxtVCK7VWdslVs2OR2
	tD4meMBeD1nfLAXHIZqrOAmEoGv6UksoHQpVxewKtsmN89DulQKbjgTTnMO9dEDl88Sfj9bWS1y
	3u4h7CkhFqyqhbwmHxYNWb51dhghQEU6f4+oJQZ/quwbBu2yvaxYvVv5xIPbfVFTbnLGCOzbIJt
	vq4r0MbM9plqk1r2IcfMzY/+00QRXso3f8VlRfaWGjMy70fIAYtC4daDBvo4zNZLvi7Rm+5WGXv
	rv8VVDPBvsrngEqQ0KRaDxYlOXDeY9yn+alP0=
X-Received: by 2002:a05:6a00:1944:b0:82f:5125:a327 with SMTP id d2e1a72fcca58-8415f33006amr23596647b3a.27.1779947755078;
        Wed, 27 May 2026 22:55:55 -0700 (PDT)
Received: from gmail.com ([114.249.134.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbce48sm758068b3a.10.2026.05.27.22.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:55:54 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/2] hw/cxl: bound Set Feature writes
Date: Thu, 28 May 2026 13:55:23 +0800
Message-Id: <cover.1779946245.git.physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429152750.2409174-1-physicalmtea@gmail.com>
References: <20260429152750.2409174-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thanks for the review.

This v3 splits the helper extraction from the actual bug fix. Patch 1
is a refactor only: it folds the existing patrol scrub and ECS bounds
checks into a helper, with no intended functional change.

Patch 2 uses that helper for the remaining Set Feature branches that
still copy into fixed-size write-attribute buffers without bounds
validation. That patch carries the Fixes tags.

I have left the qtest out of this backportable bugfix series for now.
I can send it separately after addressing the x86-only and magic-value
comments.

Changes since v2:

- split helper extraction from the bug fix
- add Fixes tags to the bug-fixing patch
- leave the qtest for a separate follow-up

Jia Jia (2):
  hw/cxl: factor Set Feature write bounds helper
  hw/cxl: validate PPR and sparing Set Feature writes

 hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 24 deletions(-)

-- 
2.34.1
