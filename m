Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863986;
	b=MQIw1xlI5UrobM+Wm1Xsh0K+IL7cW5tdd3Hl+uH4yzOIxhoGQDWsoNcxMhD/tLfeF2e4
	 bgKB/HOv0sNVuA28t0qbW5xjjb7ptTOU7S47kY0Ae3F9xDuCmNvs7yvLEHqLvCHgbp88I
	 4j3y12EnTgtNTXgpXmTfVL3U5ibRETzCOQZE6/f6vhzDxgb0mtwAlL2nRaJ9Qlk8X9aLG
	 H+2Eg6aU4+sE3CIzgCQGtHb+Nq+3ZS71nH2YV6TOk3/2UzhhqZfVuIdstpFRUlmjsNfuo
	 cScB8nFoJ4RXWmtG5ogMCXuwjNsg8HgOrB5C5YQJo4cnu1IjvF3Lwtd8KwdLYEI6ciQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WcMr1j/4+3oZLw1BxDHaKn6hPUkgWZoYnJKMR4c7sJI=;
	b=XFULLZVhagpt1nQZnoSIlCfnnQ9O8WV3gy14Iy7C9O5X4Qtg9jXPU+K123eR/Wh9MWjp
	 irA+ZqdN25vzT5WOF9sqYJT0YOyjvUq7qKqxo07xHnL8Dr9uOFxXJtbHwKzxsfHya/9tB
	 tQV/okmhXeQmEFsW9JnOlsl791agwx8JDSf/S0TeVXcFxNK11DBH4MBqI2Jfvnv3QNNUj
	 +6sxiTSj2yggZ99iYdYDMh/DhWNLP6y/VdzkAZfohMAWw6dInugLTLRTBKplamurHxPER
	 hhrYYJOmYREdDBIFaZcy5ES7nXJ+q9gPo4CLaBNJuOOT6OjRTMvkFSozPYC+t/6OUzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDlqH2Mz;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C85606A334
	for <linux-cxl@vger.kernel.org>; Sat, 28 Nov 2026 11:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C85606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDlqH2Mz
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso4165911a91.0
        for <linux-cxl@vger.kernel.org>; Sat, 28 Nov 2026 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795863985; x=1796468785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WcMr1j/4+3oZLw1BxDHaKn6hPUkgWZoYnJKMR4c7sJI=;
        b=PDlqH2MzwVDl8oXiRGnexj5GWrL3LT5N3K+5ZolLecW2VjlTXDzmnEegS7viJH7HVo
         73/uQgVejIpqFme/mkWT7UTqAZHvyP5I2R02V9ue7jJeYP/J48xIwluvB16kR/Qayxhh
         mqMPg5c7/iOCFZRRQS9WF2so6GhD+G6EMKssIC4ikuCxu5pdiyYS0JNV8ICQBwsqUj0k
         iLkGcy0T4jaF8EQKgdlnGAOxvHFZWa1TSKLenFB5GitWOUQcKWxEGf+tpuDkjgZ1DoAo
         Jtnkcentt4nJwvF7y7i1O/r7N/hUEWnCO67HbVRQM9sv+EN+aPmAeohJqtSmqk3S6xvx
         Xktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795863985; x=1796468785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WcMr1j/4+3oZLw1BxDHaKn6hPUkgWZoYnJKMR4c7sJI=;
        b=px9XP5FhewbSltPf+OvCm+8T5EqXnCYTv+59Kc0WSUxwcJyzxLcsYeak4iuyxsQBOl
         2hEakDkkwlV0/K4ANEfaX1Yli7E9cEb1jt37ZDn1+8+dv371wEgs3n48y2ZdtqaqPsiN
         FMOJBpHixbeyGGk6kQqSIkFDq0hraXcZfaV+Z6wp/zH/IeDDTes4AIFEYNmGy0aXLJJT
         A4MHEgnBi+Kidjf/CbDbpWPlZ2N5lsE/6NXV8d9DzOlUVG801/Qfz+YwYMk5ujrPVzKX
         RsjFlgkeeLmAbKsJcPu1y7CqtfYKenDGKtBci9Uq3dODjXEYS0dafwESlVxS694KLc3u
         h0Mw==
X-Forwarded-Encrypted: i=1; AL+hErHmkyQlpegIjzpUJKo+zZAKJcL7LOtWMf95iOxV6RXY9liUIjIjU/QzDJS/bKwXO4niB1r/AjBv6jg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WO2MjJXK8dN+hw2jloHiddBE9Zz6iYARuzQn0H8nq/zbH+wkj
	qsyEvW3bkK/ucE9XarHJu3BP/IEOeMVT5us5PCraxfnjc/10FA6WxmSl
X-Gm-Gg: AZFdTZciTmgt4dVBpaZqobIKy2rElqtzSk57zbzZhbEu+Nu5EGMHjhNvBh42hOe5bpD
	qyRoWrDZ4PznSLnHnyf1fBNYtB/qfMmlk1v5KTpowQsEeBQj26kE30nK2a/lKqPNhFhFijpTcwh
	OkzJ9W7c36hgVslYffIciQG1vD57Xs0UtKonzfUJ3KWHpdk6PoRpt8cUekEDa30FwNiYz4dB2+1
	VTOJ2TjMnLodH1c+NJdJJyf9yMA8DfDSFYD0RMmFUwbIFk9xVGVt9BE1gXDdzKuwYLV2T5qen7D
	j9ur2UUY//sGiGUoBeOs/Q0k6gcMGAeJilANoGbYU6r04iGN5//Tc8C5vZhPWQkWQTvMWH1Adcf
	CrQsEg2k7l4XExwhWe3kxSF0KkDUg1IezXin4ehiXOKZceq/VdxJ6pSbl6c1y2wsEELrpkk4Mlb
	NthoYk3qJJmI9rHEqunMPILqrFZ230QJmtW7qwIzI9bEWXfyx6Oge8Yk7BUFSOihb3oq7YOCdVG
	7Il8+rwR/zgkY0OWz5SUVyZhIkDXORoalF4Q/6mrIy508y0evd09zFf1zqenqiPqepMqRpDtPgP
	p7q/5kxwdF9TXZcmVHgCFYfvOhDWTwvx3dc5dIDzC3s=
X-Received: by 2002:a17:90b:5289:b0:3b0:9bfa:72ac with SMTP id 98e67ed59e1d1-3b41c908147mr18971582a91.21.1795863984935;
        Sat, 28 Nov 2026 03:06:24 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm45456236a91.16.2026.11.28.03.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:06:24 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/7] cxl/mbox: Handle Activate FW as async bg
Date: Sat, 28 Nov 2026 20:05:38 +0900
Message-Id: <20261128110538.197124-1-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617193611.564668-3-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net> <20250617193611.564668-3-dave@stgolabs.net>
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

Hi Davidlohr,

Since you mentioned you are rebasing this series, here are two
problems I hit while building on top of it, in case they help
before you resend. This is on 1/7 and 2/7 rebased onto v7.4-rc4,
so apologies if your rebase already covers them.

1. tools/testing/cxl no longer builds

This patch moves poll_dwork and the sanitize flag from
cxl_security_state to cxl_background_state, but the cxl_test mock
sanitize still uses the old fields:

  test/mem.c:668: error: 'struct cxl_security_state' has no member named 'poll_dwork'
  test/mem.c:674: error: 'struct cxl_security_state' has no member named 'sanitize_active'

I saw this on the rebase. The series does not touch tools/testing, and
the mock already used these fields in June 2025, so I think the posted
version is affected as well, but I have not built that one. This is
what I used locally:

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -665,13 +665,13 @@ static int mock_partition_info(struct cxl_mbox_cmd *cmd)
 void cxl_mockmem_sanitize_work(struct work_struct *work)
 {
 	struct cxl_memdev_state *mds =
-		container_of(work, typeof(*mds), security.poll_dwork.work);
+		container_of(work, typeof(*mds), bg.poll_dwork.work);
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;

 	mutex_lock(&cxl_mbox->mbox_mutex);
 	if (mds->security.sanitize_node)
 		sysfs_notify_dirent(mds->security.sanitize_node);
-	mds->security.sanitize_active = false;
+	mds->bg.opcode = 0;
 	mutex_unlock(&cxl_mbox->mbox_mutex);

 	dev_dbg(mds->cxlds.dev, "sanitize complete\n");
@@ -700,9 +700,9 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
 	}

 	mutex_lock(&cxl_mbox->mbox_mutex);
-	if (schedule_delayed_work(&mds->security.poll_dwork,
+	if (schedule_delayed_work(&mds->bg.poll_dwork,
 				  msecs_to_jiffies(mdata->sanitize_timeout))) {
-		mds->security.sanitize_active = true;
+		mds->bg.opcode = CXL_MBOX_OP_SANITIZE;
 		dev_dbg(mds->cxlds.dev, "sanitize issued\n");
 	} else
 		rc = -EBUSY;
@@ -1766,7 +1766,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	cxl_mbox->mbox_send = cxl_mock_mbox_send;
 	cxl_mbox->payload_size = SZ_4K;
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
-	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
+	INIT_DELAYED_WORK(&mds->bg.poll_dwork, cxl_mockmem_sanitize_work);

 	if (is_rcd(pdev))
 		cxlds->rcd = true;

2. bg.poll_dwork can outlive cxl_pci after unbind

The only cancel_delayed_work_sync() of the poll work is in
sanitize_teardown_notifier(), which devm_cxl_sanitize_setup_notifier()
registers only when the device supports sanitize. With Activate FW now
also going through the async path, including the reset activation at
the end of a firmware upload, a device without sanitize can still have
the work queued when cxl_pci is unbound, and the timer then runs on the
freed cxl_memdev_state.

QEMU and cxl_test both support sanitize, so to reproduce it I used two
local test-only hacks: clear CXL_SEC_ENABLED_SANITIZE before the
notifier setup, and make the foreground Activate FW from QEMU look like
a background command that runs for 60 seconds. Then, with KASAN:

  cxl update-firmware mem0 -F fw.bin --wait
  echo 0000:0d:00.0 > /sys/bus/pci/drivers/cxl_pci/unbind

About a second later:

  BUG: KASAN: slab-use-after-free in __run_timers+0x794/0x870
  Write of size 8 at addr ffff88810104a480 by task swapper/3/0
   __run_timers+0x794/0x870
   run_timer_softirq+0xe9/0x1c0
  Allocated by task 13:
   devm_kmalloc+0x72/0x230
   _devm_cxl_dev_state_create+0x2b/0x1f0
   cxl_memdev_state_create+0x26/0x70
   cxl_pci_probe+0x185/0x1840
  Freed by task 678:
   release_nodes+0xb9/0x110
   devres_release_all+0x104/0x170
   device_unbind_cleanup+0x71/0x250
   device_release_driver_internal+0x393/0x520
   unbind_store+0xdb/0xf0

With the sanitize notifier left in place there is no report. Cancelling
the work with a devm action next to INIT_DELAYED_WORK() made the report
go away in the same setup, and rebinding worked:

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -420,6 +420,13 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 	return rc;
 }

+static void cxl_mbox_bgpoll_cancel(void *data)
+{
+	struct cxl_memdev_state *mds = data;
+
+	cancel_delayed_work_sync(&mds->bg.poll_dwork);
+}
+
 static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
@@ -427,7 +434,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
 	struct device *dev = cxlds->dev;
 	unsigned long timeout;
-	int irq, msgnum;
+	int irq, msgnum, rc;
 	u64 md_status;
 	u32 ctrl;

@@ -477,6 +484,10 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	dev_dbg(dev, "Mailbox payload sized %zu", cxl_mbox->payload_size);

 	INIT_DELAYED_WORK(&mds->bg.poll_dwork, cxl_mbox_bgpoll_work);
+	/* Any background command, not only sanitize, may leave it queued */
+	rc = devm_add_action_or_reset(dev, cxl_mbox_bgpoll_cancel, mds);
+	if (rc)
+		return rc;

 	/* background command interrupts are optional */
 	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) || !irq_avail)

The action is registered after the memdev state is allocated, so it
runs before that is freed, and the mailbox irq is requested later, so it
is already gone when the work is cancelled. Please feel free to fold
either change into your patches or do it differently.

One smaller observation from the same testing, in case it matters for
how completion is reported: without an interrupt, a 5 second background
activation was seen as complete after about 12 seconds, since the poller
checks after 1 s and then backs off by 10 s.

I used an AI coding assistant to help reproduce these two issues;

Thanks,

Unsung
