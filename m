Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA423502BC;
	Fri, 23 Jan 2026 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168245; cv=none; b=iBmI2tsyj5n6xKxihhvg2hr9ZjaS2rehwd7Ey1YypUqf+JF4psvipPLxGIiy3ghIIti9gCu9CxyYhjf13yAkZWliea3YUbyXm++EPx8JDFBdyb9px1S9U299KZkvCEF4FZ5FAOYMw5gWdnEEsUA/BroQ8tDEiRfpRSaeontLo9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168245; c=relaxed/simple;
	bh=ALaJasNJ2wejbzkEys1efuxSdFHp/Xnq1TiHK0V7GUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXpCy7rTLe8PjWcR9bH7Hxl2HjoNj1LwElrqR7ny/vruavkdmZdEBCk/g2JTh0ht/eUNCIL3STciEzhran+rkSsntsdWHSm49xYHYTAvXA+jUksh78BKWO9RtArXAYRbZs/nBhOd4OL+1RirDkQazgnmdARhp06SIx2MDvSUhac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e9sCCxnq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/FGfCGw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e9sCCxnq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/FGfCGw"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I23DJBulHpzqgAw0h9OUkWIRLOPUsnKkbol9Lbu8HEU=;
	b=e9sCCxnqqjeoO4DxK090wj83SyzN4cbjLqFK2qtREIZJHFh0ahBUeABPtVMuGQx11wT1TB
	//SA/A7LlUYmtmEANfOTWL2hVsJjMyjUFaw0TzamdUagQn/LqUjOkaSQKealVDz9o9dSJ3
	oWKU8q11QrMToy2BR5jAifjqD3jdfl/kW34IKyoSe8Rf3mBXQYN+2xPnGsol4Z1xs1HkSb
	q+jqxX52G0BV5IoGS+pI+CNTkQEdrU2YLnEG7zVP8u/+BXJknqTBvy/koQMqOx/F8LKsoZ
	iyd9T+c3TU+Mw/9Ik3id+/BwGeEXOF4XjJFZjGDG/VZC51Slyzv5oxeQcwRAeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I23DJBulHpzqgAw0h9OUkWIRLOPUsnKkbol9Lbu8HEU=;
	b=e/FGfCGw4PQm3cyF+oX/zpaEurklrzAnx7eetDocbSXoSdtioeURqNrLhEHiLnmOqf63Fg
	eIFe7/TntY1CXLDA==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/21] perf/cxlpmu: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Date: Fri, 23 Jan 2026 12:37:02 +0100
Message-ID: <20260123113708.416727-17-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
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

Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-cxl@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

