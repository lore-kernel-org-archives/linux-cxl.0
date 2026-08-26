Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD13F54C6
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769873; cv=none; b=jbVSuAup5iBTTOgokLiUeC/k5pTu9PgyOpUSmQR1wMKfx7EiXuDzAvwupz7pfEy7/k/CniJZfHlq7LSs7cfxxuynKuDqijhny7Ikav4xo3j7napoBEkvWcpgNRpbV+l/5AOOSZiSDMyRqqPP2o7Xe/8fJO/IUOuVy3hlfrETUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769873; c=relaxed/simple;
	bh=KnNQB6RhGxZtD5zitAdfkYK//sdY9kbwDlOqKKZ0AEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vz4XjKWK1qUzFGhFj8+VLbsdPMd9Cf6dWTK6Cbk8DFNeUN99mrAtm/W4VYOOwJ2y1qXQYEpG3vwahVH2oVWu3CBSThSL4sqJ6/jlCPmXuHNGRksM45K7LJ3rChY3SUnU2i80ekuJhpURY046hNw2uuYp7ZggkyTxXvkcnqOX+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFlmbNew; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFlmbNew"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836ce6cbe1eso16217527b3.1
        for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787769857; x=1788374657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1dnNHHjRAMOXmt6/oy/MLCUmMCkloY0kHSKM7bWqsY=;
        b=cFlmbNewmzvPVES/xpv66VqJeSst96avVIUvPj23i3py62iYv9Xfi0G1bPsFrCBRRM
         IEjGaj0wA6fq6aJ1kdNIJga09bmJ7YlqOU34Lamf4K1IKbeEFo3tzV0UKcuRl6WFmb8K
         P2LRAUUqFcZl3b+H/B7/e76sUJUa6ZXM2vqgouqrhM80GYSnBocqhyRAbllL46ZyDjQt
         rIbxJsVC7ifZ7uZB95XDO1BcphYwYRCE94hti/JgmLGKCdaBm2pdn+2TgNHf96+jR5fG
         7geXdZo7f5adFqBNSU9XdQGN+OgnqIx+3nZj8Fn0MP2bK6WWYGLPqq76tqCR+kg3my0t
         YEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787769857; x=1788374657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1dnNHHjRAMOXmt6/oy/MLCUmMCkloY0kHSKM7bWqsY=;
        b=gGHcxq00VjwCyo9w2su56aHM7e/AxMEeJjuAITc5wc7Yg4E0KsG3v1wNL67iY01LvB
         gYLC3W19SAfovIqvDifHEx4z1zPjch7CmlaVMjqAS3TxcrgJi54qoTGfj8ot92YF/dvV
         inVGgn5Z+ioDPdx/EM4Kzxu6IjH6QYIe4zpENymKwJSZ1Kah0+yVHQTMpUqHu4CKdpjS
         VIUi4J/SFZHLn6L3HQKRC0XvxBpRJfHaSwpqvIWxxg7n/NmYX1P1QA7YDGTdsW0FFKRK
         A6EJpgxk6X83DYFrOrr6WNjlIji0dlteJPlGzjKkvqSiCxTg7JPyf0+woDiq3gn4fK77
         WOew==
X-Gm-Message-State: AFuF++kJysWxaF5om57k182ODqyd6xcbtnjItzsGR9Ogid3SuWsDtU82
	zTA+LLzxx6IXLt0Fq6qjiHhiRvfomcTNyBTMClz/iXZln0OfHRaHTctwekjuAA==
X-Gm-Gg: AR+sD12bedJppgmT1gLkvo4YDZ9NRxHmweHp3g7S7joE+c4ElNcYSsE2ZNQ9KY/cY3l
	7bYSDvFgHamEUE/NyS6AzcakyfN8z2vbCSptbJ/apZJOEZPe4d3OirY7wJsuBaUetkhY6WZGSTG
	NWV4Z9PtPYiuKV4Q5+6gTr2zphuE9CS8tpjDNJER2ldaIa2rbgpU6HT/tTjqOwFvBhbhf5GUHgV
	3WqaHbjkPdT6b9vEe6Blkad4SzIIkzRkyy+budqKjIlYK+nkzeQtAYb1cNni0Rqor/nJ7qKyI6k
	myhGODCUmh+dfGwXI1djLPeGKltmpFQkJLBtzLx9wDmbTx5inhkMK6Z3o+17gCaJ6MDQ+cLkCk6
	/6QhtLtqBANmiCj92x3vLLtIqpFyyrDcuhLcnrWex0F2PJZFsMQL/dllVUHEIoHP4alwfEp01eW
	NcsAX5fjIGVGn04U1RSQlAFfGSZdB51+zXpI12gEUSSoYAbuvvth+ZNX7W3iWk+ixka5E4WKdSy
	BydFaCnLEspDyKIxC1uA2S6E1Aq8kJU7r5yw7c=
X-Received: by 2002:a05:690c:e1c3:10b0:845:f687:bee1 with SMTP id 00721157ae682-857406823bamr31343197b3.25.1787769857166;
        Wed, 26 Aug 2026 11:44:17 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d04e004sm20970317b3.36.2026.08.26.11.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:44:16 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: Fix infinite loop when draining a stuck event log
Date: Wed, 26 Aug 2026 11:43:07 -0700
Message-ID: <cover.1787768932.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the 7.2 tag.

While testing the DCD patchset on a real device, I encountered a scenario where
bit 4 of the Event Status Register, corresponding to the DC Event Log
(CXL r4.0 8.2.9.3.1 Table 8-203) is not cleared by the device after a DC event is
handled and the Clear Event Records (0x0101) command is sent.

This causes cxl_event_thread() to spin in an infinite loop because cxl_event_thread()
drains every log in the Event Status register and repeats until that register reads zero.
So the thread ends up resending infinite Get Event Records (0x0100) as fast as
the mailbox completes, even though the event log remains empty.

Although I encountered this specifically while testing DCD, this would apply
equally to other types of events (Informational, Warning, Failure, Fatal).

This patch bounds the loop on there being > 0 event records in the event
log. cxl_mem_get_records_log() and cxl_mem_get_event_records() now report failures
and which logs returned records; the thread stops on the first error and
drops any log whose status bit was set while it returned nothing. Every pass
either drains a record or clears a bit from a five-bit mask, so exiting the loop
no longer depends only on the status bit reported by the device. 
Logs are drained best effort so a broken one cannot suppress reporting from the rest.


Testing:

ndctl's cxl suite (pmem/ndctl pending, 02754b5) against cxl_test on
v7.2 plus this patch, 15 passed / 2 skipped / 0 failed.  

On HW:
Without the fix, we see an infinite loop:

[  452.430234] cxl_pci 0000:0b:00.0: DBG drain_mask: native_cxl_error=0 dcd_supported=1 mask=0x10
[  452.430248] cxl_pci 0000:0b:00.0: DBG event_thread: enter irq=236 mask=0x10
[  452.430254] cxl_pci 0000:0b:00.0: DBG event_thread: status=0x10 masked=0x10
^ Host receives DC interrupt

[  452.430258] cxl_pci 0000:0b:00.0: DBG get_event_records: status=0x10 dcd_supported=1
[  452.430262] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 size_out=1024
[  452.430268] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 size_in=1 doorbell_busy=0
[  452.430274] cxl_pci 0000:0b:00.0: Sending command: 0x0100
[  452.430309] cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
[  452.430313] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 doorbell cleared, dev rc=0
[  452.430345] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 nr_rec=1 flags=0x0
^ Get Event Record retrieves DC Add Event from event log

[  452.430355] cxl_pci 0000:0b:00.0: DCD event add : DPA:0x0 LEN:0x80000000
[  452.430363] cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430374] cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430381] cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430390] cxl decoder9.0: dpa:0x0 mapped in region:region0
[  452.430397] cxl decoder9.0: Add extent [range 0x0000000000000000-0x000000007fffffff] (e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430403] cxl_dax_region dax_region0: Alloc new tag group
[  452.430437]  extent0.1: dc_extent HPA [range 0x0000000000000000-0x000000007fffffff] (e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430444] cxl_dax_region dax_region0: Trying notify: type 0 tag e5407b12-9a68-4c31-8d5e-2f0916bd73a4
[  452.430449] cxl_dax_region dax_region0: Notify: type 0 tag e5407b12-9a68-4c31-8d5e-2f0916bd73a4
^ DC Add Event handled

[  452.430473] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x4802 size_in=32 doorbell_busy=0
[  452.430482] cxl_pci 0000:0b:00.0: Sending command: 0x4802
[  452.430658] cxl_pci 0000:0b:00.0: Doorbell wait took 1ms
[  452.430662] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x4802 doorbell cleared, dev rc=0
^ DC Add Response sent

[  452.430669] cxl_pci 0000:0b:00.0: Event log '4': Clearing 1
[  452.430674] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x101 size_in=8 doorbell_busy=0
[  452.430679] cxl_pci 0000:0b:00.0: Sending command: 0x0101
[  452.430705] cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
[  452.430708] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x101 doorbell cleared, dev rc=0
[  452.430712] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 cleared 1 recs rc=0
[  452.430717] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 size_out=1024
^ Clear Event Records succeeds

Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Reading event logs: 10
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Sending command: 0x0100
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: DCD event add : DPA:0x0 LEN:0x80000000
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
Aug 26 06:30:56 cxlqual kernel: cxl decoder9.0: dpa:0x0 mapped in region:region0
Aug 26 06:30:56 cxlqual kernel: cxl decoder9.0: Add extent [range 0x0000000000000000-0x000000007fffffff] (e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
Aug 26 06:30:56 cxlqual kernel: cxl_dax_region dax_region0: Alloc new tag group
Aug 26 06:30:56 cxlqual kernel:  extent0.1: dc_extent HPA [range 0x0000000000000000-0x000000007fffffff] (e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
Aug 26 06:30:56 cxlqual kernel: cxl_dax_region dax_region0: Trying notify: type 0 tag e5407b12-9a68-4c31-8d5e-2f0916bd73a4
Aug 26 06:30:56 cxlqual kernel: cxl_dax_region dax_region0: Notify: type 0 tag e5407b12-9a68-4c31-8d5e-2f0916bd73a4
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Sending command: 0x4802
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
^ DC Add Response succeeds

Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Event log '4': Clearing 1
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Sending command: 0x0101
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Doorbell wait took 1ms
^ Clear Event Records succeeds

Then loops infinitely:
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Sending command: 0x0100
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Reading event logs: 10
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Sending command: 0x0100
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Reading event logs: 10
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Sending command: 0x0100
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Reading event logs: 10
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Sending command: 0x0100
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Reading event logs: 10
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Sending command: 0x0100
Aug 26 06:30:56 cxlqual kernel: cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
...

To determine the cause, I added print statements to check the status bit and saw:

[  452.430753] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 doorbell cleared, dev rc=0
[  452.430764] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 nr_rec=0 flags=0x0
^ ---
nr_rec = 0, so the event log is empty

[  452.430768] cxl_pci 0000:0b:00.0: DBG get_event_records: status=0x10 drained=1 ret=0
^ ---
But the status bit = 0x10, which is the lower 4th bit of the Event Status Register,
corresponding to the Dynamic Capacity Event Log

With the patch (the extra dbg messages are not in this patch, they're just for verifying
the fix):

[  452.430234] cxl_pci 0000:0b:00.0: DBG drain_mask: native_cxl_error=0 dcd_supported=1 mask=0x10
[  452.430248] cxl_pci 0000:0b:00.0: DBG event_thread: enter irq=236 mask=0x10
[  452.430254] cxl_pci 0000:0b:00.0: DBG event_thread: status=0x10 masked=0x10
[  452.430258] cxl_pci 0000:0b:00.0: DBG get_event_records: status=0x10 dcd_supported=1
[  452.430262] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 size_out=1024
[  452.430268] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 size_in=1 doorbell_busy=0
[  452.430274] cxl_pci 0000:0b:00.0: Sending command: 0x0100
[  452.430309] cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
[  452.430313] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 doorbell cleared, dev rc=0
[  452.430345] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 nr_rec=1 flags=0x0
[  452.430355] cxl_pci 0000:0b:00.0: DCD event add : DPA:0x0 LEN:0x80000000
[  452.430363] cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430374] cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430381] cxl_pci 0000:0b:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430390] cxl decoder9.0: dpa:0x0 mapped in region:region0
[  452.430397] cxl decoder9.0: Add extent [range 0x0000000000000000-0x000000007fffffff] (e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430403] cxl_dax_region dax_region0: Alloc new tag group
[  452.430437]  extent0.1: dc_extent HPA [range 0x0000000000000000-0x000000007fffffff] (e5407b12-9a68-4c31-8d5e-2f0916bd73a4)
[  452.430444] cxl_dax_region dax_region0: Trying notify: type 0 tag e5407b12-9a68-4c31-8d5e-2f0916bd73a4
[  452.430449] cxl_dax_region dax_region0: Notify: type 0 tag e5407b12-9a68-4c31-8d5e-2f0916bd73a4
[  452.430473] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x4802 size_in=32 doorbell_busy=0
[  452.430482] cxl_pci 0000:0b:00.0: Sending command: 0x4802
[  452.430658] cxl_pci 0000:0b:00.0: Doorbell wait took 1ms
[  452.430662] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x4802 doorbell cleared, dev rc=0
[  452.430669] cxl_pci 0000:0b:00.0: Event log '4': Clearing 1
[  452.430674] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x101 size_in=8 doorbell_busy=0
[  452.430679] cxl_pci 0000:0b:00.0: Sending command: 0x0101
[  452.430705] cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
[  452.430708] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x101 doorbell cleared, dev rc=0
[  452.430712] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 cleared 1 recs rc=0
[  452.430717] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 size_out=1024
[  452.430721] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 size_in=1 doorbell_busy=0
[  452.430725] cxl_pci 0000:0b:00.0: Sending command: 0x0100
[  452.430749] cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
[  452.430753] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 doorbell cleared, dev rc=0
[  452.430764] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 nr_rec=0 flags=0x0
[  452.430768] cxl_pci 0000:0b:00.0: DBG get_event_records: status=0x10 drained=1 ret=0
[  452.430772] cxl_pci 0000:0b:00.0: DBG event_thread: drain status=0x10 drained=1 rc=0
[  452.430777] cxl_pci 0000:0b:00.0: DBG event_thread: status=0x10 masked=0x10
[  452.430781] cxl_pci 0000:0b:00.0: DBG get_event_records: status=0x10 dcd_supported=1
[  452.430784] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 size_out=1024
[  452.430788] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 size_in=1 doorbell_busy=0
[  452.430794] cxl_pci 0000:0b:00.0: Sending command: 0x0100
[  452.430820] cxl_pci 0000:0b:00.0: Doorbell wait took 0ms
[  452.430823] cxl_pci 0000:0b:00.0: DBG mbox: opcode=0x100 doorbell cleared, dev rc=0
[  452.430833] cxl_pci 0000:0b:00.0: DBG get_records_log: type=4 nr_rec=0 flags=0x0
[  452.430837] cxl_pci 0000:0b:00.0: DBG get_event_records: status=0x10 drained=0 ret=0
[  452.430840] cxl_pci 0000:0b:00.0: DBG event_thread: drain status=0x10 drained=0 rc=0
[  452.430844] cxl_pci 0000:0b:00.0: Event status 0x10 set with no records to read

^ --- detected that the status bit was set but the event log is empty and stops here


Anisa Su (1):
  cxl/events: Bound the event log drain loop

 drivers/cxl/core/mbox.c      | 58 ++++++++++++++++++++++++++++--------
 drivers/cxl/cxlmem.h         |  3 +-
 drivers/cxl/pci.c            | 39 +++++++++++++++++++-----
 tools/testing/cxl/test/mem.c |  4 +--
 4 files changed, 81 insertions(+), 23 deletions(-)


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.43.0

