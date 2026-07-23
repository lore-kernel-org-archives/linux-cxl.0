Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96744372B45
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782477; cv=none; b=k/qSsk1hbwV4agYerBreE5bcfewNyI98tYdzGud20WHXEwIItw+Cm/BDCXcNeLa75uElRvXEjRHF4GMa3ZHaRXgyb4VxeUhobGbp1EP87koHr1lQQquSyRZGqQurdQORo879ety48tPxoU6cOrGD2lB404PZVfBCgEX6Xhive1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782477; c=relaxed/simple;
	bh=42TyToRv3G8hW8NmJjKYCl5ls30m6rerQNH20IVkjdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QMayO8jBykvoTDo4dVye8OYmtLtqxAqz93wjTNAV70KBcc6SCAn8CdjA0rOGgnIYqyIPU9R5UWIfcHDXqBFfzd7wl1gV3DzIYSCZ3zsumKDLHb1D3hPuMq8k4OHCiuYIGA8EVj/NebTddlctR10MNGMiwY7E/9EcQiBebbAGtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ke+2EC1G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke+2EC1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j66gSEdJekh31Cxv+QGs8EBkjEmWE9xovj2bAgh349I=;
	b=Ke+2EC1GeUd52ZM7Mgb/ywJsKH0CJtyNP7/ISDwu2Uc1HD/W4+tWmdwB6tGmrD6cmkRE6M
	yvVOFqSzot4MLOEiXpLHnrY//EuQclTC2s7liP1H29Nur5BYhaBtS6N42LPFnhVXsTrDnV
	zYK+E2iQe+hSbamEm4YRp/A7N7J+chM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-7i0Fa4lFPKK6BNYhHf8-hA-1; Thu,
 23 Jul 2026 00:54:19 -0400
X-MC-Unique: 7i0Fa4lFPKK6BNYhHf8-hA-1
X-Mimecast-MFC-AGG-ID: 7i0Fa4lFPKK6BNYhHf8-hA_1784782456
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF1A51805F13;
	Thu, 23 Jul 2026 04:54:15 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE7E918002AE;
	Thu, 23 Jul 2026 04:54:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Alex Williamson <alex@shazbot.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	John Snow <jsnow@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Igor Mammedov <imammedo@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-edac@vger.kernel.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	qemu-trivial@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 36/44] qapi: convert trivial intro sections for run-state.json
Date: Thu, 23 Jul 2026 00:47:57 -0400
Message-ID: <20260723044805.527643-37-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: apg24__65ZQdg_J1iS_ZANsiDEaR5XDWhAimOOHaN7g_1784782456
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/run-state.json | 120 +++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 75 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index a5771ad4681..bc8c17477e2 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -10,8 +10,7 @@
 
 ##
 # @RunState:
-#
-# An enumeration of VM run states.
+#     An enumeration of VM run states.
 #
 # @debug: QEMU is running on a debugger
 #
@@ -63,8 +62,7 @@
 
 ##
 # @ShutdownCause:
-#
-# An enumeration of reasons for a shutdown.
+#     An enumeration of reasons for a shutdown.
 #
 # @none: No shutdown request pending
 #
@@ -103,8 +101,7 @@
 
 ##
 # @StatusInfo:
-#
-# Information about VM run state
+#     Information about VM run state
 #
 # @running: true if all VCPUs are runnable, false if not runnable
 #
@@ -118,8 +115,7 @@
 
 ##
 # @query-status:
-#
-# Query the run status of the VM
+#     Query the run status of the VM
 #
 # Since: 0.14
 #
@@ -134,9 +130,8 @@
 
 ##
 # @SHUTDOWN:
-#
-# Emitted when the virtual machine has shut down, indicating that QEMU
-# is about to exit.
+#     Emitted when the virtual machine has shut down, indicating that
+#     QEMU is about to exit.
 #
 # @guest: If true, the shutdown was triggered by a guest request (such
 #     as a guest-initiated ACPI shutdown request or other
@@ -162,9 +157,8 @@
 
 ##
 # @POWERDOWN:
-#
-# Emitted when the virtual machine is powered down through the power
-# control system, such as via ACPI.
+#     Emitted when the virtual machine is powered down through the
+#     power control system, such as via ACPI.
 #
 # Since: 0.12
 #
@@ -177,8 +171,7 @@
 
 ##
 # @RESET:
-#
-# Emitted when the virtual machine is reset
+#     Emitted when the virtual machine is reset
 #
 # @guest: If true, the reset was triggered by a guest request (such as
 #     a guest-initiated ACPI reboot request or other hardware-specific
@@ -199,8 +192,7 @@
 
 ##
 # @STOP:
-#
-# Emitted when the virtual machine is stopped
+#     Emitted when the virtual machine is stopped
 #
 # Since: 0.12
 #
@@ -213,8 +205,7 @@
 
 ##
 # @RESUME:
-#
-# Emitted when the virtual machine resumes execution
+#     Emitted when the virtual machine resumes execution
 #
 # Since: 0.12
 #
@@ -227,9 +218,8 @@
 
 ##
 # @SUSPEND:
-#
-# Emitted when guest enters a hardware suspension state, for example,
-# S3 state, which is sometimes called standby state
+#     Emitted when guest enters a hardware suspension state, for
+#     example, S3 state, which is sometimes called standby state
 #
 # Since: 1.1
 #
@@ -261,9 +251,8 @@
 
 ##
 # @WAKEUP:
-#
-# Emitted when the guest has woken up from suspend state and is
-# running
+#     Emitted when the guest has woken up from suspend state and is
+#     running
 #
 # Since: 1.1
 #
@@ -276,8 +265,7 @@
 
 ##
 # @WATCHDOG:
-#
-# Emitted when the watchdog device's timer is expired
+#     Emitted when the watchdog device's timer is expired
 #
 # @action: action that has been taken
 #
@@ -300,9 +288,8 @@
 
 ##
 # @WatchdogAction:
-#
-# An enumeration of the actions taken when the watchdog device's timer
-# is expired
+#     An enumeration of the actions taken when the watchdog device's
+#     timer is expired
 #
 # @reset: system resets
 #
@@ -328,8 +315,7 @@
 
 ##
 # @RebootAction:
-#
-# Possible QEMU actions upon guest reboot
+#     Possible QEMU actions upon guest reboot
 #
 # @reset: Reset the VM
 #
@@ -343,8 +329,7 @@
 
 ##
 # @ShutdownAction:
-#
-# Possible QEMU actions upon guest shutdown
+#     Possible QEMU actions upon guest shutdown
 #
 # @poweroff: Shutdown the VM and exit
 #
@@ -375,8 +360,7 @@
 
 ##
 # @watchdog-set-action:
-#
-# Set watchdog action.
+#     Set watchdog action.
 #
 # @action: `WatchdogAction` action taken when watchdog timer expires.
 #
@@ -392,9 +376,8 @@
 
 ##
 # @set-action:
-#
-# Set the actions that will be taken by the emulator in response to
-# guest events.
+#     Set the actions that will be taken by the emulator in response
+#     to guest events.
 #
 # @reboot: `RebootAction` action taken on guest reboot.
 #
@@ -425,8 +408,7 @@
 
 ##
 # @GUEST_PANICKED:
-#
-# Emitted when guest OS panic is detected
+#     Emitted when guest OS panic is detected
 #
 # @action: action that has been taken, currently always "pause"
 #
@@ -445,8 +427,7 @@
 
 ##
 # @GUEST_CRASHLOADED:
-#
-# Emitted when guest OS crash loaded is detected
+#     Emitted when guest OS crash loaded is detected
 #
 # @action: action that has been taken, currently always "run"
 #
@@ -465,8 +446,8 @@
 
 ##
 # @GUEST_PVSHUTDOWN:
-#
-# Emitted when guest submits a shutdown request via pvpanic interface
+#     Emitted when guest submits a shutdown request via pvpanic
+#     interface
 #
 # Since: 9.1
 #
@@ -479,8 +460,8 @@
 
 ##
 # @GuestPanicAction:
-#
-# An enumeration of the actions taken when guest OS panic is detected
+#     An enumeration of the actions taken when guest OS panic is
+#     detected
 #
 # @pause: system pauses
 #
@@ -495,8 +476,7 @@
 
 ##
 # @GuestPanicInformationType:
-#
-# An enumeration of the guest panic information types
+#     An enumeration of the guest panic information types
 #
 # @hyper-v: hyper-v guest panic information type
 #
@@ -513,8 +493,7 @@
 
 ##
 # @GuestPanicInformation:
-#
-# Information about a guest panic
+#     Information about a guest panic
 #
 # @type: Crash type that defines the hypervisor specific information
 #
@@ -530,8 +509,7 @@
 
 ##
 # @GuestPanicInformationHyperV:
-#
-# Hyper-V specific guest panic information (HV crash MSRs)
+#     Hyper-V specific guest panic information (HV crash MSRs)
 #
 # @arg1: for Windows, `STOP` code for the guest crash.  For Linux,
 #     an error code.
@@ -560,8 +538,7 @@
 
 ##
 # @S390CrashReason:
-#
-# Reason why the CPU is in a crashed state.
+#     Reason why the CPU is in a crashed state.
 #
 # @unknown: no crash reason was set
 #
@@ -586,8 +563,7 @@
 
 ##
 # @GuestPanicInformationS390:
-#
-# S390 specific guest panic information (PSW)
+#     S390 specific guest panic information (PSW)
 #
 # @core: core id of the CPU that crashed
 #
@@ -607,10 +583,9 @@
 
 ##
 # @GuestPanicInformationTdx:
-#
-# TDX Guest panic information specific to TDX, as specified in the
-# "Guest-Hypervisor Communication Interface (GHCI) Specification",
-# section TDG.VP.VMCALL<ReportFatalError>.
+#     TDX Guest panic information specific to TDX, as specified in the
+#     "Guest-Hypervisor Communication Interface (GHCI) Specification",
+#     section TDG.VP.VMCALL<ReportFatalError>.
 #
 # @error-code: TD-specific error code
 #
@@ -630,9 +605,8 @@
 
 ##
 # @GuestPanicInformationSev:
-#
-# Information for AMD SEV-specific termination request (GHCB MSR
-# contents)
+#     Information for AMD SEV-specific termination request (GHCB MSR
+#     contents)
 #
 # @set: The reason code set provided by the guest
 #
@@ -646,8 +620,7 @@
 
 ##
 # @MEMORY_FAILURE:
-#
-# Emitted when a memory failure occurs on host side.
+#     Emitted when a memory failure occurs on host side.
 #
 # @recipient: recipient is defined as `MemoryFailureRecipient`.
 #
@@ -673,8 +646,7 @@
 
 ##
 # @MemoryFailureRecipient:
-#
-# Hardware memory failure occurs, handled by recipient.
+#     Hardware memory failure occurs, handled by recipient.
 #
 # @hypervisor: memory failure at QEMU process address space.  (none
 #     guest memory, but used by QEMU itself).
@@ -689,8 +661,7 @@
 
 ##
 # @MemoryFailureAction:
-#
-# Actions taken by QEMU in response to a hardware memory failure.
+#     Actions taken by QEMU in response to a hardware memory failure.
 #
 # @ignore: the memory failure could be ignored.  This will only be the
 #     case for action-optional failures.
@@ -717,8 +688,7 @@
 
 ##
 # @MemoryFailureFlags:
-#
-# Additional information on memory failures.
+#     Additional information on memory failures.
 #
 # @action-required: whether a memory failure event is action-required
 #     or action-optional (e.g. a failure during memory scrub).
@@ -734,8 +704,8 @@
 
 ##
 # @NotifyVmexitOption:
-#
-# An enumeration of the options specified when enabling notify VM exit
+#     An enumeration of the options specified when enabling notify VM
+#     exit
 #
 # @run: enable the feature, do nothing and continue if the notify VM
 #     exit happens.
-- 
2.55.0

