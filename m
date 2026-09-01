Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBE347FEC
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222584; cv=none; b=mMDAsq2gJEMxC+PdGilkybHTK2lSaZOkYKr4kg0h7xIilXWXXgWSb4bkFU0WUqqLluErF6tQIOeRdFGAVmD/If+IxnUr8DWbFa485vTX+1pnaOo530aRimF3WwvluDAQKcwsPKvvwUqpbY2mtXCGeOVxWwoJDxBRh8AMVPsXGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222584; c=relaxed/simple;
	bh=udTNsFFbhdTc742RCxscCCXjr/sv7u6SVCQbawqGdVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHE9HmDM9KFQL8dqXCDba/n2BNxdEYOyUzTeb86K74RKDTFZalr4s6olTCZp3irANzdYLWKUATg7wS8xl7A2XRuHWKXbBWVJQtcefNkQW3W9HzJgr4x/NDHvQ/TLKcRXt8WvWY94TEtb2d0tov0e+FQl29/jgLX76x19UIdox5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXWP2p8d; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXWP2p8d"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8200b55dc47so39670737b3.3
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 17:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222582; x=1788827382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ni7h/ReVZDDzxHeFfAULf6adsA5PdgF80vti03po7Q=;
        b=CXWP2p8dv3g6iGpblZ7Lx7OFwm9SX/4ytJiLpTKwTs3KSa9qF2kk/vqI0TEGaiEtKn
         zRqxCVyaC8MkOWOMB9IZyGHrJD8OxJleqXSLoJOM4GjbOtturwvz/WZVdSS2swWf21jN
         nN9mGjQPs4ShD7WUGjx3zB8yhBtl/NZDPdJ4D4RA+LV+mpBzFXwF4eJOA8n8t2hQ9rSa
         0bPnF20FJ83pUH0Jj1lkxoj8aiHX/nPZdnyDaejeddIe9cBUZ3OEOxfgX8XkqWQvyDUQ
         /jBLYNIKlGpTC7VkAwAXth+8nIMx6Mty/h2WSw8BK11YMRSLJ7p0XgFOGsuUdV7FkAEI
         aZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222582; x=1788827382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ni7h/ReVZDDzxHeFfAULf6adsA5PdgF80vti03po7Q=;
        b=k7QZseijl5M4VGNb1COF/Sfatw/ogHfhFwe/2jUZRQyr2e8R/b3NqfgGsJaiQt/08g
         dsekQMKGNJO1upd+5adphFxgSFbjNoT1W6SOd2net7HJfCeHDuLVHVxLn8QV0VdLZGKe
         8WCW/JcSRuYNQ02ad19QsD8oqM+n/jGxu78QhUJBdescfa+upT4krZDIV/Xl74RZ313Y
         9KyDR7skf+mW0//F2/tCcyVRyJwGHGQhP0D9BpVtvFLveJ5fNwaKD/hiblZXbwyp4eGA
         CWD89H+RqyqgOqadmh2hd/NUvNCXnt/YG8KUVn/+iiPfvuPEsZ+JoVdtOQzVICCxNODE
         YKIw==
X-Gm-Message-State: AFuF++kcOrSngCq8I/6iPEqcBwxIK4OCQlwq26ditPfGVbtzcDevsVQJ
	4USFAGaQ/tHwFNgCVL0AOLdxr6C5KWvaxxX2aUSVr7AJLOnEJT2e/kEFOXeQKQ==
X-Gm-Gg: AYBFou3vojb5L+0QvUfmgvps86YFZEhMxTmYSDzdAtwD0Um2xQrswbaC6Grvm9V7+aN
	lOb1umTZUlf6XU0F+estXNINev8VCdWSYsNuWJ6FagykJzhrkaJ9pHQTZCwuDsVxd85/xkxz/7o
	Jdr0dAWLvjTSS/cSlif8yXHWGPwdAcqNArj+32RXwQUFj2Z0jNL0F8LMbN/ufaU2xuX4zZfzLR0
	otYLDSCF6s3uQD6Kl8lmq/CdHplSMhMnebibxjbyQcbBkmDMiVGczqLTZt+X3JA96pKo8k3R2iZ
	BngIEJQoMtwwGVwEdr+M7ARTEtqprTWA91A1N4r9+zlZ0M0YW+Ir4el0JSuFiP4toDEymLbd5fu
	gK5az3lMnfYhsUR0tPmy4oIY1druk1DcCdSxFdSo1XnfQ/LVh67h8ygHmCDKYN8v7cE0DYfJntB
	8Ci5OsrnvoriY1W0rmSkpCsxdheziOsIOrmiBkmGjE39/9MplfF2udFFyygHbpuuUpmXLp0vOh7
	p/aOO7gY2XEqQPybX0XmDh6CzkOIHRuIvQegBA=
X-Received: by 2002:a05:690c:dd4:b0:80c:5cfa:34bc with SMTP id 00721157ae682-85d6a7c628bmr123988687b3.11.1788222581841;
        Mon, 31 Aug 2026 17:29:41 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e668ce7ecsm63349177b3.34.2026.08.31.17.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:29:41 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: benjamin.cheatham@amd.com,
	icheng@nvidia.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	jic23@kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 2/4] cxl/events: Validate the record count reported by the device
Date: Mon, 31 Aug 2026 17:26:55 -0700
Message-ID: <20260901002912.958-3-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901002912.958-1-anisa.su@samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_mem_get_records_log() takes the record count straight out of the Get
Event Records payload and uses it to read from payload->records[].
An oversized count reads past that buffer. Both
__cxl_event_trace_record() and cxl_clear_event_record() use the record
count to iterate oer payload->records[].

Bound the count by mbox_cmd.size_out which is already sanitized by
 __cxl_pci_mbox_send_cmd(). Report a bad record count as an error rather than a
drained log, so a device repeating the bad count does not keep the event
thread re-reading it.

Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 drivers/cxl/core/mbox.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2b71a8e1f35f..02b8c33a74b6 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1110,6 +1110,14 @@ static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		nr_rec = le16_to_cpu(payload->record_count);
 		if (!nr_rec)
 			break;
+
+		if (struct_size(payload, records, nr_rec) > mbox_cmd.size_out) {
+			dev_err_ratelimited(dev,
+				"Event log '%d': record count %u mismatch in %zu byte payload",
+				type, nr_rec, mbox_cmd.size_out);
+			rc = -EIO;
+			break;
+		}
 		*got_records = true;
 
 		for (i = 0; i < nr_rec; i++)
-- 
2.43.0

