Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3A320A04
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222577; cv=none; b=MzvhOFuVZVjxVbLxVW+njp3bcVCYcaFTG2aYiWrKp2dAqnd3ZEnEfboTDSPDSeHuzIDhSlUjj8WpRIxnwWz0HFbv1BuKn3ibsK23da6e5YwrjBzr6D0fXfKo75M7Q386Phee8b1+SsLryoPk9E8es12bLulYOnkp3SOtsHrXt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222577; c=relaxed/simple;
	bh=L3GQgo6OjGVOPLqnB+mRMt0exi9Tsf+9bXuT0GtftnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbOiYj03OHUdN0HZXnN7qse6HE6fzjZgDhgwYXR6uipNIuttODiRMU1HFmyqjBzBBPIDCx2jCqd/+g+vGhXfX3x45fVpuj0ZLb2GtnQxsWUpknr+mqWCTgBtB/D4+aNvROsud1FHPcY8uctV8k5F9jnHePKTeBhwI/b2tGaP3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZCVWpA7; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZCVWpA7"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-861f30636f9so31868427b3.0
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222574; x=1788827374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5JtCGvs0RoOOzc1EIiROeWmZcDxME2qkzVy/zsJPtr8=;
        b=TZCVWpA71z31i7rEEjGNshXpaS3G8Zb7krSbMa2tzO24K1GJ7Xw08TESDCO1c7/t8k
         FImPl/OgUeiRZlrhsgSnZSGQ0t9vw7KNm9x6KCcr5ioWvmvGU9VWe0cek9cFzjA+r4C9
         Om9XmvUTZB+PBvmzeciB7GWHM2JBFYUq3Go2jt+R8Ppb+4G9qnw9fsyfPXAzaQ3m6xXw
         izG02sZCEI6H3YL4v2l0HGRW95u8ALTvsrXG/W01luUw3Xr2AvuFOWarZPWM8c5asDex
         jN2uz0hv7O9MOmVLa4AHtWC3CtHdOROKDnnDz8R1QDbwAfC07iTW5NnWYokE7zH7UWBT
         j7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222574; x=1788827374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5JtCGvs0RoOOzc1EIiROeWmZcDxME2qkzVy/zsJPtr8=;
        b=dFrY8bEzcDDd6/OBz2Fbd5Z+5+bloxhsrxSy0Drc+eMjflcww84jfblhF/iRF7oE6P
         sqxA6Q19+hFmvf4k+AyzKEW8fe9ikYj9p3wmCW8TYCw2IMD8ClWdhJ3Ko8rTFChYycfz
         IfX52u4zzYzd/nUxX5+RI7vxjkdiA16JoehYRSnPXeB4SWisaluWUc0AD22kpHdS5mqM
         N8HAAkia41fZvKHmeMAm5w8PBXRDJjbRYU9XBDbD4rGMj4Q41sFZKiXy1KKArDCCj5Vb
         qXkVHbt9KsO+8HOcRIac+0wv6XHExVjLoxogz0Ys2pO7cCq8ZXAZh3UgHibj4/g6+F07
         BheQ==
X-Gm-Message-State: AFuF++kd633OYU/6FjugrKfwiTr7fpM7WusHpAMxqVwpJIi13Y+Qqqmw
	tfWC4pvZyotm3kf5x7md4SyHznwGxeVpqPqCvOsetp9kWGaIe0gl9ld4VL/2RQ==
X-Gm-Gg: AYBFou3nmZo9Tse3xiKm3Wg+k6o6gQtyQSfn30SgGCJ2Y2004gTO6GC1T4wkQJ6ZPYf
	a7PhzJBnpZJajdqZZJMknOnFHDKybq19wtKga4ToZs5ECiEMy6oZR9eSsuezCEam+FXdVjar5UA
	16c+3iCjv02JLEUzK6W8rPG/I1SGKoGiabWHvAfn6DbcVRDqzvwQ91NMpAi7yZCY1wEpLgB2HpQ
	+6RU0Nt1ceGta/vbz5YB9Nv1EN59UQ8u6oXdgRTnnHMQkeTV7jlvqjlAW25Wk0o/DXghKtwOGOb
	OF3VjM5n0UfetE4YFISWh8/mvHG/OEHcYqx5j73ttBpXg2YR5O6jxigF4+Wpko8hbeI/4MGjTC3
	EG0nPfjvSbUDis0oqZADbUGvXeCUuyxufaTGf2lpudr/87pH8eHivhgF0w3xCYjPGPpLtwJQ19h
	Kbi5kZL3zx9irtSGJCJMZbYHqHsOeaytvBvf1Uyl8tQQL3BfNSsTy3rSKt+uEQFsF0ZidWtjnUI
	8neJI/4LioNlprefK+9g1/NM4VPhpLoWVOnAS8=
X-Received: by 2002:a05:690c:e0c6:10b0:80c:5ce9:8f29 with SMTP id 00721157ae682-85d6a2e124amr89256567b3.22.1788222574341;
        Mon, 31 Aug 2026 17:29:34 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e668ce7ecsm63349177b3.34.2026.08.31.17.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:29:33 -0700 (PDT)
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
Subject: [PATCH v2 0/4] cxl/events: Robustify event interrupt handling
Date: Mon, 31 Aug 2026 17:26:53 -0700
Message-ID: <20260901002912.958-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the 7.2 tag.

This patchset bundles various fixes along the event interrupt path.
The previous revision was a single patch, but Sashiko reported several
related pre-existing errors so I thought I may as well pick them all up into
one series.

Link to v1:
https://lore.kernel.org/linux-cxl/cover.1787768932.git.anisa.su@samsung.com/T/#m393e57d7f7f3916e8f2826a006ef0bc4dfd3606a

Patch 1:
========
cxl_event_thread() loops until the event status register is clear. The
Event Status register is device owned and read-only (CXL r4.0 8.2.9.3.1 Table 8-203),
so buggy device that never clears the register traps the thread
in an infinite loop. A persistent error would hang the thread too.

The cxl_event_thread() now drops any log whose status bit was set
while it returned 0 event records. Up to CXL_EVENT_DRAIN_ATTEMPTS
number of retries are allowed for transient errors, such as "Retry
Required" rc from the device, or mailbox -ETIMEDOUT/-EBUSY errors.

CXL_EVENT_DRAIN_ATTEMPTS is defined as 3.

Changes from v1:
- added retries for transient errors, pointed out by Richard Cheng

Patch 2:
========
Validates the record count the device reports. It is used
unchecked to index a flexible array in a buffer sized to the mailbox
payload, so an oversized count reads past the buffer, leaks the contents
to tracepoints, and then hands the same bytes back to the device in Clear
Event Records.

Patch 3:
========
Patch 1 addressed the event thread loop, which happens once per IRQ.
The event thread iterates over each of the event logs that have their
status bit set (Informational, Warning, Failure, etc.) Then for each log,
cxl_mem_get_records_log() gets event records until nr_rec reaches 0 for
that log.

A bad device that keeps reporting >0 records would keep the thread stuck
here.

This patch bounds the per-log loop by CXL_EVENT_LOG_MAX_PASSES, currently
set to 128. Probably overkill for a large mailbox, since the command
returns "as many even records... that fit into the mailbox output payload"
(CXL r4.0 Section 8.2.10.2.2 Get Event Records), but a spec-minimum sized
mailbox (256B) only fits 1 record, so I thought probably better to set the
the limit more generously. But it could be lowered.


Patch 4:
========
Returns IRQ_NONE when the handler processed nothing instead of
unconditionally returning IRQ_HANDLED.

Sashiko:
"Returning IRQ_HANDLED when no work was done prevents the kernel's core IRQ
subsystem from detecting and disabling a spurious interrupt storm. If a
failing CXL device floods the CPU with MSI interrupts, the kernel will never
disable the vector, which could completely lock up the processing core"


Testing:
========

NDTL:
ndctl's cxl suite (pmem/ndctl pending, 02754b5) against cxl_test:

15 passed, 2 skipped, 0 failed.
The two skips are cxl-type2.sh and cxl-features.sh, which are
unrelated to this series.

QEMU Tests:
All 4 patches have been tested on a QEMU branch modified to
emulate each of the above scenarios. A test script starts a VM for each
scenario and uses QMP to inject a general media event
(cxl-inject-general-media-event) with DPA = 0x1000 and all other fields set to
0 to trigger the event interrupt.

Each error scenario can be turned on with an environment var in QEMU:

/*   CXL_TEST_STICKY_EVENT_STATUS=1  leave the Event Status bit set once the
 *                                   log has been drained
 *   CXL_TEST_EVENT_RETRY=1          answer Get/Clear Event Records with Retry
 *                                   Required for every log
 *   CXL_TEST_BAD_RECORD_COUNT=1     claim more records than the payload holds
 *   CXL_TEST_EVENT_IRQ_STORM=1      raise the event interrupt without ever
 *                                   putting a record in a log
 *   CXL_TEST_ENDLESS_RECORDS=1      acknowledge Clear Event Records without
 *                                   removing anything, so the log never drains
 */
static bool cxl_test_knob(const char *name)
{
    const char *val = getenv(name);

    return val && val[0] == '1';
}

Then for example in cxl_event_delete_head(), if CXL_TEST_STICKY_EVENT_STATUS=1,
we skip clearing the log status:

-    if (cxl_event_empty(log)) {
+    if (cxl_event_empty(log) && !cxl_test_knob("CXL_TEST_STICKY_EVENT_STATUS")) {
         cxl_event_set_status(cxlds, log_type, false);
     }


For more details on QEMU, see this commit:
https://github.com/anisa-su993/qemu-anisa/commit/61960ab7fd7160226cd131a2cb1091b161c100bd

Test script:
https://github.com/anisa-su993/cxl-tests/blob/main/events/run-all.sh

Patch 1:
--------
  CXL_TEST_STICKY_EVENT_STATUS=1  leave the status bit set after the
                                  event log is cleared

<General Media Event injected w/QMP, triggering event interrupt on log 1>
[    7.421124] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
[    7.424094] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    7.426894] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    7.430098] cxl_core:cxl_clear_event_record:1048: cxl_pci 0000:0d:00.0: Event log '0': Clearing 1
[    7.433004] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0101
[    7.435831] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    7.438775] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    7.441527] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    7.444478] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
[    7.447274] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    7.450102] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    7.453001] cxl_pci 0000:0d:00.0: Event status 0x1 set with no records to read <---- detected error and stops

  CXL_TEST_EVENT_RETRY=1          answer Get/Clear Event Records with
                                  Retry Required for every log

<General Media Event injected w/QMP, triggering event interrupt on log 1>
[    7.377325] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
[    7.380459] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    7.383242] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    7.386105] cxl_pci:__cxl_pci_mbox_send_cmd:346: cxl_pci 0000:0d:00.0: Mailbox operation had an error: temporary error, retry once
[    7.389834] cxl_pci 0000:0d:00.0: Event log '0': Failed to query event records : -11
[    7.393652] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
[    7.396574] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    7.399323] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    7.402217] cxl_pci:__cxl_pci_mbox_send_cmd:346: cxl_pci 0000:0d:00.0: Mailbox operation had an error: temporary error, retry once
[    7.405949] cxl_pci 0000:0d:00.0: Event log '0': Failed to query event records : -11
[    7.409794] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
[    7.412716] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    7.415491] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    7.418399] cxl_pci:__cxl_pci_mbox_send_cmd:346: cxl_pci 0000:0d:00.0: Mailbox operation had an error: temporary error, retry once
[    7.422016] cxl_pci 0000:0d:00.0: Event log '0': Failed to query event records : -11
[    7.424199] cxl_pci 0000:0d:00.0: Event log drain gave up after 3 attempts: -11 <----- gave up after CXL_EVENT_DRAIN_ATTEMPTS


Patch 2:
--------
  CXL_TEST_BAD_RECORD_COUNT=1     claim 1 more record than the payload holds

[    7.334917] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
[    7.337746] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    7.340545] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    7.343614] cxl_pci 0000:0d:00.0: Event log '0': record count 2 mismatch in 160 byte payload
[    7.346197] cxl_pci 0000:0d:00.0: Event log drain failed: -5 <---- skip reading payload and return -EIO

Patch 3:
--------
  CXL_TEST_ENDLESS_RECORDS=1      acknowledge Clear Event Records without
                                  removing anything, so the log is never emptied
... skipping some logs
[    8.116284] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    8.117190] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    8.118218] cxl_core:cxl_clear_event_record:1048: cxl_pci 0000:0d:00.0: Event log '0': Clearing 1
[    8.119212] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0101
[    8.120130] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    8.121093] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
[    8.121992] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    8.123088] cxl_core:cxl_clear_event_record:1048: cxl_pci 0000:0d:00.0: Event log '0': Clearing 1
[    8.124027] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0101
[    8.124927] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[    8.125937] cxl_pci 0000:0d:00.0: Event log '0': Still reporting records after 128 passes, giving up <--- hit CXL_EVENT_LOG_MAX_PASSES ceiling
[    8.126878] cxl_pci 0000:0d:00.0: Event log drain failed: -5

Patch 4:
--------
  CXL_TEST_EVENT_IRQ_STORM=1      raise the event interrupt without ever
                                  putting a record in a log

...
[    9.929250] irq 28: nobody cared (try booting with the "irqpoll" option) <---- printed in __report_bad_irq()
[    9.929937] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 7.2.0+ #34 PREEMPT(full)
[    9.929939] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    9.929940] Call Trace:
[    9.930417]  <IRQ>
...
[    9.931396]  </TASK>
[    9.931397] handlers:
[    9.945340] [<00000000a6051941>] irq_default_primary_handler threaded [<00000000c56a4fd3>] cxl_event_thread <----- handler is cxl_event_thread
[    9.946222] Disabling IRQ #28

__report_bad_irq() turns off the interrupt "if 99,900 of the previous 100,000 interrupts
have not been handled". With the fix, we see that__report_bad_irq() is reached.
Without the fix (IRQ_HANDLED unconditionally returned), the interrupt is
not disabled and keeps firing.


Anisa Su (4):
  cxl/events: Bound get records loop in cxl_event_thread()
  cxl/events: Validate the record count reported by the device
  cxl/events: Bound the per-log Get Event Records loop
  cxl/events: Return IRQ_NONE when no events were processed

 drivers/cxl/core/mbox.c      | 94 ++++++++++++++++++++++++++++++------
 drivers/cxl/cxlmem.h         |  3 +-
 drivers/cxl/pci.c            | 67 ++++++++++++++++++++++---
 tools/testing/cxl/test/mem.c |  4 +-
 4 files changed, 143 insertions(+), 25 deletions(-)


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.43.0

