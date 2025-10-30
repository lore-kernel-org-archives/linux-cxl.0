Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BA1AF0AF
	for <linux-cxl@vger.kernel.org>; Thu, 30 Oct 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842327; cv=none; b=QrfeDKzwSh+EWZXSH8gvSWqCJWIkful0VorlfSfu9BYlMuj2nDnBvJK2ndZWD6vaZCVInBwKPtk07vKl03LzRwOS8O2XbG1FOh62WmX6dFMcE9cDhW6TOYAgjsjVSO26QxfX+FRT8/tz2gjf9KSCoa220zXOqzhq9rl/Wegu+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842327; c=relaxed/simple;
	bh=+yZIzum66M0oPmn/3oQOleUS3Pi5YkNB9duKj2LX/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKn2frGWm7YZUo8mRV+Fj/zXmBTgLSak2L00gR5A9po3rUIUtSqRJT3zT3t0/YfVt9pOmimIFbCncnQgT6YcRgoDKqbiIQLQHipWgk6iwdc3bOV5sBng/ysTg4mlKAE6IfCgpOHDfOc74fqQOcAW3vAGcCTYQm6vvLa15t3RGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BMs5MKcw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BMs5MKcw"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so788875f8f.1
        for <linux-cxl@vger.kernel.org>; Thu, 30 Oct 2025 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761842323; x=1762447123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54giQrwwEn96jLZZhaBwfuj7+qjJhVGS+n5IIXiT1MA=;
        b=BMs5MKcwcPRdEGHBXIIEHAi2gLZWZAFj/qN9+GSE6lrW0HPSfcJUTD7Wp9mXQ4wUz1
         WNEo3v7y2DELWELE5rZoFMDVdl15Gck0+IVHhj4sEwfSjMX2QHa/s6p3AX9nZxXvFRwb
         /p4Dc0olMo8agC8m+8Z9CxGR1xD7rXO3UqHBfcTrqaf3U9PBx5a3gZ7W8gohNJjg6LAs
         hRFqdIS7EuPIcTT2o4KpW6aKFc6IBB9KW5X4oDyMihMyRjpYxsAtoxkQulOm/+/PN4jl
         1852AC9HXVCeVX1gdFHfQu+gJ8oGrqYh2NmH+Z1E6fop4JZK+iOCkZj2zFehrPQJ/76e
         tPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842323; x=1762447123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54giQrwwEn96jLZZhaBwfuj7+qjJhVGS+n5IIXiT1MA=;
        b=k9esPIostBeLN7ssBqFQRNVf1sbpBnIEL6VoLOEjUWVo+fhdUOiVcUmbRYswHmjDmt
         N5ZxgspBDd2Lm6feM10ZfFmcCIe/rchrkm1seLoqU36ho9eFoZVdXeWhJCDlFpv+YVki
         3VC6lAGmJ3RGDwrotYrI/8SWVe/b5HvJoVfFbKcVrjLtTE+naaOMzEDCPM/NZ56O9/2T
         pnBxUHuIXI3HL8s9GCU6bzhdrq43NT07jQw8DFXL7rMB+UtpmtkdCb0p6pO/TbRwlj40
         8qugSELmdXYPSGABYbjjsB1h7Urpe7SDGoBomyJeVnRyN2rf75VJIEYQvKmZYTfNdGFJ
         hk7A==
X-Forwarded-Encrypted: i=1; AJvYcCWK/4ivgcjIizQzifYBDvwgPZhEkGLwgFjYijQESpVpY397m83SjdBkfAo+9BM6mW43itINVC37yhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxtDgxoMw3ZfM14AAjz6E7fCObP9Jh6Eofh4Xd3yd+MX3f0kK
	jduRFS8f6EEqb1ioICF42qy60w1QR0y6IO3E2DpCzHgPCoGK9lV5zWDq9Vjaz9rMPGE=
X-Gm-Gg: ASbGncuK8u2AtO345Llh+z2ArN13bj1sNJjkHO5ffYylGp5oJn9K4oK9FC4QVY7fTkY
	wX4J8+SyTyDbhcQd4gqdfT2kJZxGKAdo+wXR3XE1SWZRaPiaQw459qtdQGFOgE/lnUO82HCOomp
	LLFSVyqxYsT4nIupY0qOUpUkNlooCCGQY+sFCJUQo250OJvCGbXmcxbI2oYYR5UfMIzYTHU68GS
	BG3YgZ2KuuLImK7DnpvHvXCVlFXvV7mZm2RdggDOVUjFpTvt9uIOKCv0z0mM/vm0UOCh0jzjuRR
	7sFTYY+yiRq5XE/w7We0kZDNY8qqKXWWQ7r5MtIkhXBx2Sp1fsJFEKY1Jdq1bTG5vlMPbtbJBfP
	hpTA/KIFt3F4CBUS1T7PohHreqeb2SWfkYt+CMuYmhs4jhsNqawASnjBI4JDhFa7b8LbneSRz/9
	f6MZj/NzJRA2e1DT4=
X-Google-Smtp-Source: AGHT+IH40grKlZFcgNET1Ic1yaJbEZTBCRZMx9hDmAfRXfwjzK7wZukFCQCR1jXrFH7HCUeLEGfujg==
X-Received: by 2002:a05:6000:430d:b0:429:b52e:3505 with SMTP id ffacd0b85a97d-429bd682fcbmr233503f8f.11.1761842323256;
        Thu, 30 Oct 2025 09:38:43 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728999a4bsm46197675e9.2.2025.10.30.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:38:42 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
Date: Thu, 30 Oct 2025 17:38:39 +0100
Message-ID: <20251030163839.307752-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672..0be4e508affe 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -136,7 +136,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
 		mutex_lock(&cxl_mbox->mbox_mutex);
 		if (mds->security.sanitize_node)
-			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
+			mod_delayed_work(system_percpu_wq, &mds->security.poll_dwork, 0);
 		mutex_unlock(&cxl_mbox->mbox_mutex);
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
-- 
2.51.0

