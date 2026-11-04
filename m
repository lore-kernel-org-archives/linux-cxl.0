Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814614;
	b=IB2Z9fUr3jKjF87WyGGRnwYi3ntHsRMKG/GM5zXrjEaBj8pI/r035yvW0c0O4woea9Yq
	 egsdvbCbF5KzQeN9nrokVW8b40FdTS/fbjwgcbGc1Y85F7Q5Kbyf12rTkr+gVnTEv/HS2
	 P0m1WK5my1rBLvuTOrCw4K4OD9vqtufJhZTgHx25fwgjQ27vbnzynoHr+bfQeW8G8E/Eu
	 OrQudsPqI8wd+LTPYEo1ohyblStoBzMAKDfvHbChss+KV+1ijlstCfbBxK9w6nYJjr3tx
	 n0zp+Mk9wN1fgTQRWXcj5SMySZlMdh546DjVL1obU4tfhil+yp37g3d7za6UFleG38g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814614;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xDyBR0SVH7j6EXiT+u+KfOqHgFmy8XfO5bCPkpMbaRM=;
	b=1Rc6Oz/HQ2L7q7hcCTINpeE11U6EBGJvciEbmYUWcJ4Ji0yO9viy0fsYhAzfyER3Q26E
	 r/udTj3UkFRFyIyZ+p7aykYCvxgdUBFSOloEQEIdT1RnPZh6ZXn1i3/LIf8UCd8kn3UiE
	 3bPST4wIxYtpTZxmMzM4Iw55IGLM3EOsD38RoGxJD+RNTHY0c8DYo0BQSldgza/cR0Fto
	 /pe07pOsDRrctS3LIEY1hPHmsQxtGar/OW//Itg5hBOPDOrDJ/ItVgG6HG2L6ve/flEzA
	 ms3cJMz+rqpxyrUb7Xrhrh0wXX9XxC3znx4/ekzc87zX61PG+l8HXl8tduLh8UkQ+Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B047606B229;
	Wed,  4 Nov 2026 17:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873021F000C1;
	Wed,  4 Nov 2026 17:50:13 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH] MAINTAINERS: Add CXL reviewer Ben Cheatham
Date: Wed,  4 Nov 2026 10:50:03 -0700
Message-ID: <20261104175003.297974-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding Ben as a reviewer for the CXL subsystem.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a955a626784..edaf70961cba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6729,6 +6729,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
 R:	Ira Weiny <iweiny@kernel.org>
 R:	Li Ming <ming.li@zohomail.com>
 R:	Richard Cheng <icheng@nvidia.com>
+R:	Ben Cheatham <benjamin.cheatham@amd.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/cxl

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: 57bdcea37c2a480531ec5d1022422748e462077a
-- 
2.54.0

