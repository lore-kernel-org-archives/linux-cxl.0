Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8DCC6FA8B
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Sep 2022 23:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiISXqr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiISXqp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Sep 2022 19:46:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166A4F652
        for <linux-cxl@vger.kernel.org>; Mon, 19 Sep 2022 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663631195; x=1695167195;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pfPNcLTJNo84gvexI3zu2cHwUZyU2v8zq5XeOdTTlAA=;
  b=mV/2icaVuVveH4ebwKD2cCw/yOtACW6POexSyt2R1qBgUCa7PrfHxU6l
   Zwztp0dHolA4OaTNy69QZfraWepKOHqO6EZmB2zAVf0rqpCxpXgX4AgZx
   bmVKdsXT6TeJCzraffxzgoau7jDEgrEt42TcF7B9rCzfi6wicwJr3SyI+
   5yyLtRnl6CkMZQ3qwwUbnX6GtZdNJ9mjg7DaSYMq2Oxtv8Aui0m9l9yXr
   nJUuNA/vCGUnBdes7iElX9fFS742oA5HhXpqG4/+aAGzA9gfzcN26c//f
   wS/gGpI8YppabQa/cK4QICjck0G4vOo3QaMbOlAHeM1lgq+MibTjJplIO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299541194"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="299541194"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:46:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="722504425"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:46:34 -0700
Subject: [PATCH v2 0/9] cxl: add monitor support for trace events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        nafonten@amd.com, nvdimm@lists.linux.dev
Date:   Mon, 19 Sep 2022 16:46:34 -0700
Message-ID: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v2:
- Simplify logging functions (Nathan)
- Drop ndctl prefix (Vishal)
- Reduce to single trace event system (Alison)
- Add systemd startup file
- Add man page

This patch series for ndctl implements the monitor command for the cxl
tool. The initial implementation will collect CXL trace events emitted
by the kernel. libtraceevent and libtracefs will be used to parse the
trace event buffer. The monitor will pend on an epoll fd and wait for
new event entries to be posted. The output will be in json format. By
default the events are emitted to stdio, but can also be logged to a
file. Each event is converted to a JSON object and logged as such.
All the fields exported are read by the monitor code and added to the
JSON object.

---

Dave Jiang (9):
      cxl: add helper function to parse trace event to json object
      cxl: add helper to parse through all current events
      cxl: add common function to enable event trace
      cxl: add common function to disable event trace
      cxl: add monitor function for event trace events
      cxl: add logging functions for monitor
      cxl: add monitor command to cxl
      cxl: add systemd service for monitor
      cxl: add man page documentation for monitor


 Documentation/cxl/cxl-monitor.txt |  77 ++++++++++
 cxl/builtin.h                     |   1 +
 cxl/cxl-monitor.service           |   9 ++
 cxl/cxl.c                         |   1 +
 cxl/event_trace.c                 | 228 ++++++++++++++++++++++++++++
 cxl/event_trace.h                 |  23 +++
 cxl/meson.build                   |   8 +
 cxl/monitor.c                     | 239 ++++++++++++++++++++++++++++++
 meson.build                       |   3 +
 ndctl.spec.in                     |   1 +
 10 files changed, 590 insertions(+)
 create mode 100644 Documentation/cxl/cxl-monitor.txt
 create mode 100644 cxl/cxl-monitor.service
 create mode 100644 cxl/event_trace.c
 create mode 100644 cxl/event_trace.h
 create mode 100644 cxl/monitor.c

--

