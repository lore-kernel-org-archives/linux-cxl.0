Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F634F24B;
	Wed, 28 Jan 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594167; cv=none; b=mcCvzCIERbZ2IPjqM/7OZeAgXLyBFhgKOEdcOsqzG22sMrQy/xdsc6Bbtqig9hyKPtRhqTOsVRq52UMFEA9OfupHRSUz6A/9B4mfUjZRjIeY3CEl7A2VQoPunC2dExYSWkNjMeaZe3KFf+i39EQDBXhCceM4I9XNqTb9mVQzMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594167; c=relaxed/simple;
	bh=NhhXrFK1K8rrvFD9LU+XjJEJWOQEKbr2bMPl1LOz9FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awbJEs7/GEX8c56uRKCfWRt6CV0AGDPlNb4cBwaVlRuLoU3CKzcmT8jL2G6TKVJmnRHFROumtzYQavcO40NoxLrk3J+vICv468doDMdGSqL/ObyzbiSgTpb63nG2T6znbPMrqk7tgy2sOy4bgcajqUOsA+nFUQ8FcLsMmil4wdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJdzLYiT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qqmnRDX1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJdzLYiT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qqmnRDX1"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx9PaGhN8XCDO/Lj9TkDnHhjpxVfK1xRGoM2y5dZLgE=;
	b=eJdzLYiTOtn+behbDASDvueRmFhJUiXAo+sbMvKy9PSpe32UA3IbaBdr/H7TAKt4s3eWQJ
	1mkWb4hdMRlei4dr0axaMIynjo+I0gBnEqAV3TGy/cjBrUULLY2ZRS69zNNuKt3Jr1cfr3
	5Ra8A9w0R+jHBIi2z36oQQHU9VTdYbdV9E1c5XhvSUXnZh46O0dNAl1OeYF7t5dZUUqXjx
	5dnIq3GL2QQ9E6eDPJHKVuafdgH9AnA7qsVHvjNd0U1UwZanv13NHRToDMst/ExUJA3EYh
	21D+AMz6KZ60lTUfrrFi0b7s9ntEETBPWWmDI6ue5iSR07R92uOD45ycSrmY1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx9PaGhN8XCDO/Lj9TkDnHhjpxVfK1xRGoM2y5dZLgE=;
	b=qqmnRDX1e3Qb4lsgp8mVBqAc1EG132V9zjFZs7OsjSY4PWQweBYfL+HNzwKopevros2T4C
	UxBPiSEg/MDzVTBQ==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 14/20] perf/cxlpmu: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Date: Wed, 28 Jan 2026 10:55:34 +0100
Message-ID: <20260128095540.863589-15-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

The intention here was probably not allowing forced-threading.

Replace IRQF_ONESHOT with IRQF_NO_THREAD.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-cxl@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index d094030220bf2..68a54d97d2a8a 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -877,7 +877,7 @@ static int cxl_pmu_probe(struct device *dev)
 	if (!irq_name)
 		return -ENOMEM;
=20
-	rc =3D devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_ONESHOT,
+	rc =3D devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THRE=
AD,
 			      irq_name, info);
 	if (rc)
 		return rc;
--=20
2.51.0

