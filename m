Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36C3A4F31
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207916; cv=none; b=PZMBK31W1a2MtgJ6FtdZ1vsSJLbiV2zBe5NxSDhEnwX2Sqo+UuGIGpbs13qp9YQcxhN1m2Ux2lxFvRhqBmxKM6dJKMAqwM6/Zq6JZYAWpcwTg29a7SUCkod93gXpOcardgYoVRpCGf30N54JzrbjjDaa9b8wjN64tunR7LnDvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207916; c=relaxed/simple;
	bh=boTOgJMDH+5uJrVtW8SxoViMvapYkgn1WQqNvbdtv6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7dg0Cp5sB+2sgsn1RSddM33hup2znVixqiX/00FuQgW3EVCF1Zpi+R95n6pokH1k/eAkPlziZK/wcdK1pfFKTrEgE8WB+A3QO9PAwjo0N8Tg5ZP5cCvM+CQzJkkvFUIjOZheiO767IDknZ/G51FPe2xmWkeIik1yxP+JLvt7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9TOkmMB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9TOkmMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xv5Hc3Epjp7PUpL8zcU32FN49lioPMZa3oxVmw1Jn+I=;
	b=B9TOkmMBW8rmgTb7YK9aZZNp5Nu6C5wvzTp3Eu/SDeSk7vZj7shI/RlhLTRE59hCXPpPLI
	jbHs9Peh9PVD88I4qSjDCpQ8Og8wX/wjCRU7t6AYgF9wjAQ44UdOVpyJr1EQDvIIckgHdn
	412IT9NoLp3P/iRSV0v4MwsJIH3lPMw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-UL8-StDYOTihKjq8V3Pgeg-1; Mon,
 31 Aug 2026 16:25:08 -0400
X-MC-Unique: UL8-StDYOTihKjq8V3Pgeg-1
X-Mimecast-MFC-AGG-ID: UL8-StDYOTihKjq8V3Pgeg_1788207905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 653E5184A082;
	Mon, 31 Aug 2026 20:25:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B180B1800577;
	Mon, 31 Aug 2026 20:24:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	linux-cxl@vger.kernel.org,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	linux-edac@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	John Snow <jsnow@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Eric Blake <eblake@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 35/43] qapi: convert trivial intro sections for run-state.json
Date: Mon, 31 Aug 2026 16:19:37 -0400
Message-ID: <20260831201945.287730-36-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: uW850iR3zSaEdoV7zaZb6RyWFI8HdlKMTenYpm2SNJA_1788207905
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qapi/run-state.json | 113 ++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 71 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index e4fdead1e0b..2a968a6bc0b 100644
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
@@ -330,8 +317,7 @@
 
 ##
 # @RebootAction:
-#
-# Possible QEMU actions upon guest reboot
+#     Possible QEMU actions upon guest reboot
 #
 # @reset: Reset the VM
 #
@@ -345,8 +331,7 @@
 
 ##
 # @ShutdownAction:
-#
-# Possible QEMU actions upon guest shutdown
+#     Possible QEMU actions upon guest shutdown
 #
 # @poweroff: Shutdown the VM and exit
 #
@@ -377,8 +362,7 @@
 
 ##
 # @watchdog-set-action:
-#
-# Set watchdog action.
+#     Set watchdog action.
 #
 # @action: `WatchdogAction` action taken when watchdog timer expires.
 #
@@ -394,9 +378,8 @@
 
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
@@ -427,8 +410,7 @@
 
 ##
 # @GUEST_PANICKED:
-#
-# Emitted when guest OS panic is detected
+#     Emitted when guest OS panic is detected
 #
 # @action: action that has been taken, currently always "pause"
 #
@@ -447,8 +429,7 @@
 
 ##
 # @GUEST_CRASHLOADED:
-#
-# Emitted when guest OS crash loaded is detected
+#     Emitted when guest OS crash loaded is detected
 #
 # @action: action that has been taken, currently always "run"
 #
@@ -467,8 +448,8 @@
 
 ##
 # @GUEST_PVSHUTDOWN:
-#
-# Emitted when guest submits a shutdown request via pvpanic interface
+#     Emitted when guest submits a shutdown request via pvpanic
+#     interface
 #
 # Since: 9.1
 #
@@ -481,8 +462,8 @@
 
 ##
 # @GuestPanicAction:
-#
-# An enumeration of the actions taken when guest OS panic is detected
+#     An enumeration of the actions taken when guest OS panic is
+#     detected
 #
 # @pause: system pauses
 #
@@ -497,8 +478,7 @@
 
 ##
 # @GuestPanicInformationType:
-#
-# An enumeration of the guest panic information types
+#     An enumeration of the guest panic information types
 #
 # @hyper-v: hyper-v guest panic information type
 #
@@ -515,8 +495,7 @@
 
 ##
 # @GuestPanicInformation:
-#
-# Information about a guest panic
+#     Information about a guest panic
 #
 # @type: Crash type that defines the hypervisor specific information
 #
@@ -532,8 +511,7 @@
 
 ##
 # @GuestPanicInformationHyperV:
-#
-# Hyper-V specific guest panic information (HV crash MSRs)
+#     Hyper-V specific guest panic information (HV crash MSRs)
 #
 # @arg1: for Windows, `STOP` code for the guest crash.  For Linux,
 #     an error code.
@@ -562,8 +540,7 @@
 
 ##
 # @S390CrashReason:
-#
-# Reason why the CPU is in a crashed state.
+#     Reason why the CPU is in a crashed state.
 #
 # @unknown: no crash reason was set
 #
@@ -588,8 +565,7 @@
 
 ##
 # @GuestPanicInformationS390:
-#
-# S390 specific guest panic information (PSW)
+#     S390 specific guest panic information (PSW)
 #
 # @core: core id of the CPU that crashed
 #
@@ -632,9 +608,8 @@
 
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
@@ -648,8 +623,7 @@
 
 ##
 # @MEMORY_FAILURE:
-#
-# Emitted when a memory failure occurs on host side.
+#     Emitted when a memory failure occurs on host side.
 #
 # @recipient: recipient is defined as `MemoryFailureRecipient`.
 #
@@ -675,8 +649,7 @@
 
 ##
 # @MemoryFailureRecipient:
-#
-# Hardware memory failure occurs, handled by recipient.
+#     Hardware memory failure occurs, handled by recipient.
 #
 # @hypervisor: memory failure at QEMU process address space.  (none
 #     guest memory, but used by QEMU itself).
@@ -691,8 +664,7 @@
 
 ##
 # @MemoryFailureAction:
-#
-# Actions taken by QEMU in response to a hardware memory failure.
+#     Actions taken by QEMU in response to a hardware memory failure.
 #
 # @ignore: the memory failure could be ignored.  This will only be the
 #     case for action-optional failures.
@@ -719,8 +691,7 @@
 
 ##
 # @MemoryFailureFlags:
-#
-# Additional information on memory failures.
+#     Additional information on memory failures.
 #
 # @action-required: whether a memory failure event is action-required
 #     or action-optional (e.g. a failure during memory scrub).
@@ -736,8 +707,8 @@
 
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

