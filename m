Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AB45000
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518043; cv=none; b=k6oFVilGYYVo1Up7JtH8cEKDb2JmKKgYTazhigcLCnUZeTJF/0f1qdXjXDYLqpC8lBCqbh7nqEIANxcpeiQml8/TEyKO7FUiy1LE/1vTuVecRLEouy+IOlKNZrIG+M1R5EyolOwR2Nah1vJYTwl5AYQVgFCk9JTKfPlbf/Zw2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518043; c=relaxed/simple;
	bh=V+wCndTRXo+3X0UPmL/A1okhq2tP6/EzYulMkZft02c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbluvBliyvlbnmzVLH7WVE6+g6X8INozmdKuCTL+DOpu5LdzrJfT1Bp1CE/g0UH+9lB6OEFZdJfiYq/owsR4vOkzuznIV/U7v4hePeA9x6LArAubnwMmRtqZJ7lZWuQTpAA4xFktZchr+Vj7Z9YD3mThj0D8Ck9xJCjefOAkzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOdlNNEJ; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOdlNNEJ"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so325869a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789518041; x=1790122841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXYtwTHnaHGmGuPdZD07fr4p1RgWffwiJHcJgMk0B/o=;
        b=DOdlNNEJixLDEbVuJLvEFxKvkBI+lEdc6cAbVPdEuM5WarslEODtCf6STgSHfP5wIn
         vUxGoAn05RlFaqO5Jp4T+qT70FFl/6tRDeGwkxks6xj1QO8XIcEmfOEcpyO4qrkbNOJV
         +hBCBshNvXznBHJj6W/h4WeQreu4GEznAHtt6uCDNAvRz+9OrsAxv8fmHAXrvekHHi+/
         5LGPzZcXpbdO3VOEpPVtSQ5j+XOMhX+f0BS77+VJ9aIYPmeJrXZVcNf689wWJbmsbqaX
         Slk3Bv/z+B7HxlbpychXa/3kDBfx4lDIGbnflrSFihc8YIQCaGLoO1ASFj86XEBkeJKF
         M1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789518041; x=1790122841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXYtwTHnaHGmGuPdZD07fr4p1RgWffwiJHcJgMk0B/o=;
        b=UfLksOa5/4U4p/QG3t1MyxqbB0A3NRYBen/8/JHDTqqZK/GNGRsev9u9+K5wcYDi0m
         4BM4BhR+7EnPuC63sO9/wbN93eZiXBF/i0bXjTsGmeFy0gzsEXd81GcnFUwU7ZM7cUR8
         HTb4xJCwAsbcDRoEALv+tXJtZu+LL5tY8ieafx+XOQWxbt6nh1KhXKUWWn5S/VJVYvoT
         Z9jBOMS82H0mC1V6orAGO4FAn3rttziW6skfxtQua6HY+ld7ob6XKIbIzYhkwKfY0F9U
         ZZFW+/t54OECjiAlYy2crAeMsjL8eDyIjopuWyKQ1D+Llf5KECvx2uaXNIPmNIKwK+ls
         XODA==
X-Forwarded-Encrypted: i=1; AKwUvBwERLwLJJOLaqDDtEVmGSdW7caUozUQu10tz5Z57yIBBhVp3e91EQfKxD3jqhjtN6t9S1RdbtFtgRA=@vger.kernel.org
X-Gm-Message-State: AFuF++kuMdearXlcwJhxZP31RWCq4k5yRufExBW/PUJuEC1TSHthl6Kp
	pQZRN2yu8FFnPxdu1o2Vlsu8RIZAnaIXoxdOA3ydtS04wfn6IxZCsL6w
X-Gm-Gg: AYBFou374LxpggY2lqI1HYD6GUc8L7Ca7u3emtbRSE18J6oReh1iCho2HVSupYw9Uxf
	DvBYNzQdRh/CCDePnJi49mCXSqou8zDGr84GknSbXAricxQey3pRa91BiFIm1TFoAnBdSqfNMNO
	gRVypqlsHj8ygu6Qp+n8jP7c0RNunRiz1Q7tbnD9vAUJ6/TU55MnWeTX2+/34K8lIKJVXxHW2BT
	0o5bfhiiFViuK6qqW2ZQKOVPSHR8/Qzv5BzlRgcGtvZlaZVceGtYtb8V5aEW0vbdiDV6t30xKoc
	QkcBhORa5KIhCkUwFGzGFrLEJYOnp3KRjoJvyBoLsgMqcJoqt7wW0QtQfs/QRVlARS2Nbg/hP7H
	tNLq6fu0xlOEs9ijxPoeshD0YSm5jecIvqP8iP0dxzPmjEIXTrplv+eNiFXJzD6Al88y8RHm/pf
	ekbCFyNik1FhoDsyNmDxJGciYzbcHJ4S/0VJiUY9/tKEjD585OS91KQhDkW4QPCyL+D2iXAj02I
	6lG2gBLjR0yamYpvWAoBQefljyx
X-Received: by 2002:a05:6a21:4a98:b0:3dd:5831:ef5c with SMTP id adf61e73a8af0-3dd5f5af371mr1422097637.17.1789518040876;
        Tue, 15 Sep 2026 17:20:40 -0700 (PDT)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab8ae01sm609027a12.18.2026.09.15.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 17:20:40 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: jic23@kernel.org,
	mst@redhat.com,
	junjie.cao@intel.com,
	dave@stgolabs.net,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH] MAINTAINERS: Add Anisa Su as a reviewer for CXL
Date: Wed, 16 Sep 2026 09:21:28 +0900
Message-ID: <20260916002143.777233-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I contributed the FMAPI DCD mailbox command support in hw/cxl and also
work on the Linux driver side, which is developed and tested against QEMU's
CXL emulation, so I would like to be Cc'd on incoming CXL changes to help
with review.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bf895732c..14412a6b4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3334,6 +3334,7 @@ F: docs/devel/migration/CPR.rst
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
 R: Junjie Cao <junjie.cao@intel.com>
+R: Anisa Su <anisa.su@samsung.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/

base-commit: 302c2f2df4d8b2eec81c38ee5d5b04e8e6e40d31
-- 
2.43.0

