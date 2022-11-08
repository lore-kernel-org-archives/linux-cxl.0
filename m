Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3BC433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKHS3u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKHS3u (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:29:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153A8117D
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932189; x=1699468189;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TyL1xSoUtr2O5t0ps3P9bP9Nr+5KWGWfiHCpbCFTO14=;
  b=PXjzJpuUqkPVLM2/fbsEGpQ73a0hu5VO7cv3I//6IaQutMpumGlJP+my
   C+P9pLJ3nkal2ZcpfuTneycVibQqNTEZiyDdxKLG3MaS/0MMdPtM/LfPs
   0sPCUPGgeq0uB/Efnwf04z6Mofufx8dDSyqabqh+goagEkTAuCYSq23DO
   pzvkzSw3vUeKcjQ9CcxPhyWYiquwQ/PKc2Eh4+j31CGxXLMyCggWK4lG0
   FWzRZF+5696Tmt+H+lQHPt+wlsHyxAG3fXWdUe7YYwe5D6nrelN0WN/U5
   tRdGEaRImuxt7D4Df/8WCJhLFxHDPsla2ZdJjfPa1h2knFjybf77g412b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="310771047"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="310771047"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:29:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669649981"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669649981"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:29:48 -0800
Subject: [PATCH v4 00/10] cxl: add monitor support for trace events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:29:47 -0700
Message-ID: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch series for ndctl implements the monitor command for the cxl tool.
The initial implementation will collect CXL trace events emitted by the
kernel. libtraceevent and libtracefs will be used to parse the trace
event buffer. The monitor will pend on an epoll fd and wait for new event
entries to be posted. The output will be in json format. By default the events
are emitted to stdio, but can also be logged to a file. Each event is converted
to a JSON object and logged as such. All the fields exported are read by the
monitor code and added to the JSON object.

v4:
- Fix num_to_json for less than int size (Ira)
- Use TEP_FIELD flags to determine data type. (Steve)
- Use tracefs_event_enable() instad of directly toggle sysfs via lib calls (Steve)
- Remove tracefs_trace_is_on() in disable() call (Steve)
- Update to use tep_data_pid() (Steve)

v3:
- Change uuid parsing from u8[] to uuid_t (Alison)
- Add event_name to event_ctx for filtering (Alison)
- Add event_pid to event_ctx for filtering (Alison)
- Add parse_event callback to event_ctx for filtering (Alison)

v2:
- Simplify logging functions (Nathan)
- Drop ndctl prefix (Vishal)
- Reduce to single trace event system (Alison)
- Add systemd startup file
- Add man page

---

Alison Schofield (1):
      cxl: add an optional pid check to event parsing

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


 Documentation/cxl/cxl-monitor.txt |  77 +++++++++
 cxl/builtin.h                     |   1 +
 cxl/cxl-monitor.service           |   9 +
 cxl/cxl.c                         |   1 +
 cxl/event_trace.c                 | 263 ++++++++++++++++++++++++++++++
 cxl/event_trace.h                 |  28 ++++
 cxl/meson.build                   |   8 +
 cxl/monitor.c                     | 240 +++++++++++++++++++++++++++
 meson.build                       |   3 +
 ndctl.spec.in                     |   1 +
 10 files changed, 631 insertions(+)
 create mode 100644 Documentation/cxl/cxl-monitor.txt
 create mode 100644 cxl/cxl-monitor.service
 create mode 100644 cxl/event_trace.c
 create mode 100644 cxl/event_trace.h
 create mode 100644 cxl/monitor.c

--

