Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC137B002
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160825; cv=none; b=QwsEHf3iO1BYoh3bzP1zT9AxMYdzMaPS8uWbE3FJ7qQAuQo3wLumTT+SQUudgXt4Lv3TDH0kfc0vcx2V43g3b3ic6c9pktWSjEcQaPTYvkcR9/1tBprs2hx1zM0TipnbWOT1XQ4dte/jLx6MQ5/yp5eOwlj7+kvzg30eduHWmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160825; c=relaxed/simple;
	bh=CcoznjziQF4d1eDXcs4Y72p3P/Kd8w83UdlGdptqyPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEyC/iL0KJ2vCGlC3Sjxpk7gQfnPNZFHCjKrxxqPSTnkb375bWir2L2STQcs8/m/29jJoImEFVjTK0oWUyvoTGllVvQVzjNzHzRYlraiPfeYV6pEd3IR4mOZ8A0OpESzZhSZN3+effBStED0Ekh3C4JYgrDdqR016rXQDi55g80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEw1o/gv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEw1o/gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781160822; x=1812696822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CcoznjziQF4d1eDXcs4Y72p3P/Kd8w83UdlGdptqyPI=;
  b=NEw1o/gvlSDGd9Cv2M8rkKa0ePmC5cSbUm9fOejs3IYv2R4xtmjjE3Um
   PChw3+zvQ48Nba11Ty+KM9MMplsaCKbWxvBt02D9JlYmpwrdevw8FJCbp
   GQTGwlVS5WcfCEufgYNrlIFRMn/D2Cq0kQkiq9TrI5xS5BBsiZD8aIVsv
   Kvgq70TsGJNIW8sPv02onKh60HZZIzs49ygxDZ7UItlUVjH7yhfBfFxFu
   T54G0ihLRy9P9MuB1Gb8xv9zuFbgD/TXWJwaBryJw0H/I6NAmlNmXbhmy
   nTvNg50okm7XDEHFJVRKDMoGqg+p1IDbwYsR9RCQL14YrX5wK6PUib+QW
   A==;
X-CSE-ConnectionGUID: 8JXZv28/SZuGholaN094fA==
X-CSE-MsgGUID: oztj2LqdRsGq6RCyhlOLSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595449"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85595449"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:42 -0700
X-CSE-ConnectionGUID: xfEkZdzxTZCMTCfAcdPOJg==
X-CSE-MsgGUID: zz+fC0XlRVSsLQNZ5OPqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246469751"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:40 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH v2 1/5] hw/cxl: introduce trace-events infrastructure
Date: Thu, 11 Jun 2026 14:30:23 +0800
Message-ID: <20260611063027.1166493-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611063027.1166493-1-junjie.cao@intel.com>
References: <20260611063027.1166493-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL subsystem currently has no trace-events file.  Create one under
hw/cxl/ and register it in the top-level meson.build
trace_events_subdirs list so that subsequent patches can add trace
points incrementally.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/trace-events | 1 +
 hw/cxl/trace.h      | 2 ++
 meson.build         | 1 +
 3 files changed, 4 insertions(+)
 create mode 100644 hw/cxl/trace-events
 create mode 100644 hw/cxl/trace.h

diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
new file mode 100644
index 0000000000..23bc9b19b9
--- /dev/null
+++ b/hw/cxl/trace-events
@@ -0,0 +1 @@
+# See docs/devel/tracing.rst for syntax documentation.
diff --git a/hw/cxl/trace.h b/hw/cxl/trace.h
new file mode 100644
index 0000000000..ab87f3e98f
--- /dev/null
+++ b/hw/cxl/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-hw_cxl.h"
diff --git a/meson.build b/meson.build
index 19e123423b..c229199d5d 100644
--- a/meson.build
+++ b/meson.build
@@ -3596,6 +3596,7 @@ if have_system
     'hw/audio',
     'hw/block',
     'hw/char',
+    'hw/cxl',
     'hw/display',
     'hw/dma',
     'hw/fsi',
-- 
2.43.0

