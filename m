Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E6638AC9A
	for <linux-cxl@vger.kernel.org>; Wed,  2 Sep 2026 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337659; cv=none; b=DbCzv9Mr2vyXvIGvJ7QpR1DJKIlnGvbm6Rgm1BivAR0iuQnGwWs98Q3xho/3FBO0lWkGwsoUJxfzM0R2aT9rTesc09TB8eNi8vwyY9dU9/SNaWjVmPrxuTVxUCDAF/fIqGpkeketpp7I6AhZxW8aI8odn5D9CPOsr8eaGiJRUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337659; c=relaxed/simple;
	bh=AFcH1JFDPxlXyDOvxEesuRWYyPY7e1GkVBEI1Cq5ujw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ1EsXhTjjUPSgwwgKbiul1m6DdwSveMirePIE4r4s5UgkxOpELnEmm/10Lmlds/WZkSafQsq6+TSVoce2FuqHXoM0xq6fJB7LZHaUtvgw5hysInoXArjFEmFvAP4oQWorAPy8v+S38y6TLVL6qFISW8nZhyaeqhz1syV0rfpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD6xxY4c; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD6xxY4c"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so795133b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 02 Sep 2026 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788337656; x=1788942456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bmhmK8OOWzcA38NvSYNCBHWsd3GCk1GG+xEqFKhJtfY=;
        b=DD6xxY4cEjIo9HM6HrwIGtX+gRHMKOy+bv78GRTxjacoELS2rM5e9bMh6c08spWCTB
         rpcNZPwZUMkkoDhOZZXxRllCx0lxD1Y5sHwfap47y42YC3h4bmiEQoEbwSJgmtpxmNwm
         uxB+0d4KL6J1w2HNQDg8s6/jb+q1Mfg6qGxhuftqSf7Ioggc6D3emp46HfVakEb0acNs
         3g2Sl25u24SamZ8lilC211cYq7kT/cItJC8yq701weEgJTaSg52hdTum4XkPhCZIr16k
         Op+dk0X490MGjRPkWMbdtwbUNcN6d5qnUvvqPFj5T87HEWhZ4bwHOrKxshHzwZZEoO8c
         iZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788337656; x=1788942456;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmhmK8OOWzcA38NvSYNCBHWsd3GCk1GG+xEqFKhJtfY=;
        b=bzRl5vu/m/G2abI5dq11VNnv5gnTUvQmppcSx3/U7cPjna7DGwJ460D5jdqwRTIeAc
         uWWAPf+h6aaGJWcQCQjl3aiJDvxKPDKwcWUQjvJVeCwbpcamfor1B23WJkNl8x+NGerz
         4mPIUXp63LW+qbr79JfKZQzukrDYXvR+WpcpffQ0sxb8axjZvC0TiLUoW+GLLsTtqPnF
         21fP6pNX6NtJvRMG7OYc1vgOEfYoj2qg9hd+vu30SrMVmordnyx7TK3D6HK3yvENdzqY
         WE4f01nxwr+q/sOQYn81u6zZO9bZu4T9dXvMU+9PuGVsRURSoXus2in8UYvV10ZhvhLn
         ZNFQ==
X-Gm-Message-State: AFuF++nDeBY0nFj7fZhMMdVfZstHtlh7nC102RjOek1eBufNlbtfM17D
	zrEbPOF/P0gS6/0W3atQqmnU/rFlCwgkTUhHhPdteX5hJTkShe5655BQ
X-Gm-Gg: AR+sD12Oz5ceWmdnE5mi+xPtSu9bS+4KeMSv9vo+qmVD30Fhr9Us+/Yi6sSmw5+EEGF
	X9qFI+zKd1VTN2NF/dN25hiUw3gJCNVSUnYWtiCuLZPn73KKx2u6UbDMQyA5ILvU7ZJPeOURXCV
	uJ5FdcL7xPbGTMgOfYlsfcvQVKWxihvLc2Ua0vrtOKAUCGjuo8YkTMXFjMN93PR+UThVD0JZsgY
	p/n27ByhcbNhQ4FMgR2ONvC7CCKri9UG5ihqejv1uAgTY4kVNdvMJ18d/TyrFLeDGKRXcS3wzSW
	sG4nNPxKqiWE40T5cRvPgYRSN29PVSz06M+qJNxnBZQGV+qGS83gCgAkwdsjQdsPFV/vzMoeIkA
	gVrZuVfBQxY40us2/dkqxpjYn2CUBKADrURN2plVxNGTNWTy6d0o+ZIsgLiQfaD+vZqCYdxP1l5
	8p9/YR6NEubbso4pGKeqFdWBElc6KbdDELIVTNtGe7ZBNp9O9cEeqBV1KKZ5f7+s5iBC9EKyGiY
	FBdRjH4XwM9rlzvq2D/+mIYj/wxqwhNMYUQ3jFFYlWQsed+SA28VZjlWU9S0goWMq8m84xCTIKl
	ts7bKw==
X-Received: by 2002:a05:6a20:939d:b0:3d3:ae40:51e5 with SMTP id adf61e73a8af0-3d9af4f90e1mr4255741637.25.1788337655798;
        Wed, 02 Sep 2026 01:27:35 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79898sm5374066eec.15.2026.09.02.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:27:35 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 2 Sep 2026 01:27:33 -0700
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, benjamin.cheatham@amd.com, icheng@nvidia.com,
	dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
	jic23@kernel.org
Subject: Re: [PATCH v2 0/4] cxl/events: Robustify event interrupt handling
Message-ID: <apfd9eH0cVxMJJ5F@4470NRD-ASU.ssi.samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901002912.958-1-anisa.su@samsung.com>

On Mon, Aug 31, 2026 at 05:26:53PM -0700, Anisa Su wrote:
> Based on the 7.2 tag.
> 
> This patchset bundles various fixes along the event interrupt path.
> The previous revision was a single patch, but Sashiko reported several
> related pre-existing errors so I thought I may as well pick them all up into
> one series.
> 
> Link to v1:
> https://lore.kernel.org/linux-cxl/cover.1787768932.git.anisa.su@samsung.com/T/#m393e57d7f7f3916e8f2826a006ef0bc4dfd3606a
> 
Had a chat with Dave and he mentioned we only need to deal with device quirks
when they show up. So I plan to drop patches 2-4, since they are just Sashiko
reports and not observed on hardware.

For patch 1, there are a few considerations, so if any maintainers could have a quick
glance at the thread?

1. I did observe the bug on hardware, but it's a sample device and the
firmware is being patched, so nobody should see it happen IRL? The consequences
of the issue were:
	- 1 CPU taken up
	- driver can't be unbound since free_irq() waits for threads_active = 0

2. Li Ming mentioned checking the return value of cxl_mem_get_event_records()
is still valuable (currently a void function). So we could drop the other
changes from the patch and just keep that part.

Thanks,
Anisa

> Patch 1:
> ========
> cxl_event_thread() loops until the event status register is clear. The
> Event Status register is device owned and read-only (CXL r4.0 8.2.9.3.1 Table 8-203),
> so buggy device that never clears the register traps the thread
> in an infinite loop. A persistent error would hang the thread too.
> 
> The cxl_event_thread() now drops any log whose status bit was set
> while it returned 0 event records. Up to CXL_EVENT_DRAIN_ATTEMPTS
> number of retries are allowed for transient errors, such as "Retry
> Required" rc from the device, or mailbox -ETIMEDOUT/-EBUSY errors.
> 
> CXL_EVENT_DRAIN_ATTEMPTS is defined as 3.
> 
> Changes from v1:
> - added retries for transient errors, pointed out by Richard Cheng
> 
> Patch 2:
> ========
> Validates the record count the device reports. It is used
> unchecked to index a flexible array in a buffer sized to the mailbox
> payload, so an oversized count reads past the buffer, leaks the contents
> to tracepoints, and then hands the same bytes back to the device in Clear
> Event Records.
> 
> Patch 3:
> ========
> Patch 1 addressed the event thread loop, which happens once per IRQ.
> The event thread iterates over each of the event logs that have their
> status bit set (Informational, Warning, Failure, etc.) Then for each log,
> cxl_mem_get_records_log() gets event records until nr_rec reaches 0 for
> that log.
> 
> A bad device that keeps reporting >0 records would keep the thread stuck
> here.
> 
> This patch bounds the per-log loop by CXL_EVENT_LOG_MAX_PASSES, currently
> set to 128. Probably overkill for a large mailbox, since the command
> returns "as many even records... that fit into the mailbox output payload"
> (CXL r4.0 Section 8.2.10.2.2 Get Event Records), but a spec-minimum sized
> mailbox (256B) only fits 1 record, so I thought probably better to set the
> the limit more generously. But it could be lowered.
> 
> 
> Patch 4:
> ========
> Returns IRQ_NONE when the handler processed nothing instead of
> unconditionally returning IRQ_HANDLED.
> 
> Sashiko:
> "Returning IRQ_HANDLED when no work was done prevents the kernel's core IRQ
> subsystem from detecting and disabling a spurious interrupt storm. If a
> failing CXL device floods the CPU with MSI interrupts, the kernel will never
> disable the vector, which could completely lock up the processing core"
> 
> 
> Testing:
> ========
> 
> NDTL:
> ndctl's cxl suite (pmem/ndctl pending, 02754b5) against cxl_test:
> 
> 15 passed, 2 skipped, 0 failed.
> The two skips are cxl-type2.sh and cxl-features.sh, which are
> unrelated to this series.
> 
> QEMU Tests:
> All 4 patches have been tested on a QEMU branch modified to
> emulate each of the above scenarios. A test script starts a VM for each
> scenario and uses QMP to inject a general media event
> (cxl-inject-general-media-event) with DPA = 0x1000 and all other fields set to
> 0 to trigger the event interrupt.
> 
> Each error scenario can be turned on with an environment var in QEMU:
> 
> /*   CXL_TEST_STICKY_EVENT_STATUS=1  leave the Event Status bit set once the
>  *                                   log has been drained
>  *   CXL_TEST_EVENT_RETRY=1          answer Get/Clear Event Records with Retry
>  *                                   Required for every log
>  *   CXL_TEST_BAD_RECORD_COUNT=1     claim more records than the payload holds
>  *   CXL_TEST_EVENT_IRQ_STORM=1      raise the event interrupt without ever
>  *                                   putting a record in a log
>  *   CXL_TEST_ENDLESS_RECORDS=1      acknowledge Clear Event Records without
>  *                                   removing anything, so the log never drains
>  */
> static bool cxl_test_knob(const char *name)
> {
>     const char *val = getenv(name);
> 
>     return val && val[0] == '1';
> }
> 
> Then for example in cxl_event_delete_head(), if CXL_TEST_STICKY_EVENT_STATUS=1,
> we skip clearing the log status:
> 
> -    if (cxl_event_empty(log)) {
> +    if (cxl_event_empty(log) && !cxl_test_knob("CXL_TEST_STICKY_EVENT_STATUS")) {
>          cxl_event_set_status(cxlds, log_type, false);
>      }
> 
> 
> For more details on QEMU, see this commit:
> https://github.com/anisa-su993/qemu-anisa/commit/61960ab7fd7160226cd131a2cb1091b161c100bd
> 
> Test script:
> https://github.com/anisa-su993/cxl-tests/blob/main/events/run-all.sh
> 
> Patch 1:
> --------
>   CXL_TEST_STICKY_EVENT_STATUS=1  leave the status bit set after the
>                                   event log is cleared
> 
> <General Media Event injected w/QMP, triggering event interrupt on log 1>
> [    7.421124] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
> [    7.424094] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    7.426894] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    7.430098] cxl_core:cxl_clear_event_record:1048: cxl_pci 0000:0d:00.0: Event log '0': Clearing 1
> [    7.433004] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0101
> [    7.435831] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    7.438775] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    7.441527] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    7.444478] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
> [    7.447274] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    7.450102] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    7.453001] cxl_pci 0000:0d:00.0: Event status 0x1 set with no records to read <---- detected error and stops
> 
>   CXL_TEST_EVENT_RETRY=1          answer Get/Clear Event Records with
>                                   Retry Required for every log
> 
> <General Media Event injected w/QMP, triggering event interrupt on log 1>
> [    7.377325] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
> [    7.380459] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    7.383242] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    7.386105] cxl_pci:__cxl_pci_mbox_send_cmd:346: cxl_pci 0000:0d:00.0: Mailbox operation had an error: temporary error, retry once
> [    7.389834] cxl_pci 0000:0d:00.0: Event log '0': Failed to query event records : -11
> [    7.393652] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
> [    7.396574] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    7.399323] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    7.402217] cxl_pci:__cxl_pci_mbox_send_cmd:346: cxl_pci 0000:0d:00.0: Mailbox operation had an error: temporary error, retry once
> [    7.405949] cxl_pci 0000:0d:00.0: Event log '0': Failed to query event records : -11
> [    7.409794] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
> [    7.412716] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    7.415491] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    7.418399] cxl_pci:__cxl_pci_mbox_send_cmd:346: cxl_pci 0000:0d:00.0: Mailbox operation had an error: temporary error, retry once
> [    7.422016] cxl_pci 0000:0d:00.0: Event log '0': Failed to query event records : -11
> [    7.424199] cxl_pci 0000:0d:00.0: Event log drain gave up after 3 attempts: -11 <----- gave up after CXL_EVENT_DRAIN_ATTEMPTS
> 
> 
> Patch 2:
> --------
>   CXL_TEST_BAD_RECORD_COUNT=1     claim 1 more record than the payload holds
> 
> [    7.334917] cxl_core:cxl_mem_get_event_records:1187: cxl_pci 0000:0d:00.0: Reading event logs: 1
> [    7.337746] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    7.340545] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    7.343614] cxl_pci 0000:0d:00.0: Event log '0': record count 2 mismatch in 160 byte payload
> [    7.346197] cxl_pci 0000:0d:00.0: Event log drain failed: -5 <---- skip reading payload and return -EIO
> 
> Patch 3:
> --------
>   CXL_TEST_ENDLESS_RECORDS=1      acknowledge Clear Event Records without
>                                   removing anything, so the log is never emptied
> ... skipping some logs
> [    8.116284] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    8.117190] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    8.118218] cxl_core:cxl_clear_event_record:1048: cxl_pci 0000:0d:00.0: Event log '0': Clearing 1
> [    8.119212] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0101
> [    8.120130] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    8.121093] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0100
> [    8.121992] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    8.123088] cxl_core:cxl_clear_event_record:1048: cxl_pci 0000:0d:00.0: Event log '0': Clearing 1
> [    8.124027] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0101
> [    8.124927] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
> [    8.125937] cxl_pci 0000:0d:00.0: Event log '0': Still reporting records after 128 passes, giving up <--- hit CXL_EVENT_LOG_MAX_PASSES ceiling
> [    8.126878] cxl_pci 0000:0d:00.0: Event log drain failed: -5
> 
> Patch 4:
> --------
>   CXL_TEST_EVENT_IRQ_STORM=1      raise the event interrupt without ever
>                                   putting a record in a log
> 
> ...
> [    9.929250] irq 28: nobody cared (try booting with the "irqpoll" option) <---- printed in __report_bad_irq()
> [    9.929937] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 7.2.0+ #34 PREEMPT(full)
> [    9.929939] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [    9.929940] Call Trace:
> [    9.930417]  <IRQ>
> ...
> [    9.931396]  </TASK>
> [    9.931397] handlers:
> [    9.945340] [<00000000a6051941>] irq_default_primary_handler threaded [<00000000c56a4fd3>] cxl_event_thread <----- handler is cxl_event_thread
> [    9.946222] Disabling IRQ #28
> 
> __report_bad_irq() turns off the interrupt "if 99,900 of the previous 100,000 interrupts
> have not been handled". With the fix, we see that__report_bad_irq() is reached.
> Without the fix (IRQ_HANDLED unconditionally returned), the interrupt is
> not disabled and keeps firing.
> 
> 
> Anisa Su (4):
>   cxl/events: Bound get records loop in cxl_event_thread()
>   cxl/events: Validate the record count reported by the device
>   cxl/events: Bound the per-log Get Event Records loop
>   cxl/events: Return IRQ_NONE when no events were processed
> 
>  drivers/cxl/core/mbox.c      | 94 ++++++++++++++++++++++++++++++------
>  drivers/cxl/cxlmem.h         |  3 +-
>  drivers/cxl/pci.c            | 67 ++++++++++++++++++++++---
>  tools/testing/cxl/test/mem.c |  4 +-
>  4 files changed, 143 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> -- 
> 2.43.0
> 
