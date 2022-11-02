Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27489C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKBVUT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKBVUG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1301ACDE
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424005; x=1698960005;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LspaTpMT6XKrGUtl1KwW+tycbHg24uOLDX22o36yhfA=;
  b=N++QWcFjI9X3rjlL8t639gr7s86RmuIZNw0BEFbohN1RulARj2ctuJyE
   lqkIUGvi6h1YiAFE+9EsNpKxV8Su6Xzd3hw/s5mSyBhMlxH79EjLeUx8u
   tgKU4Ewn2uUYEo5t/QLg0FnOqCn14puThhWPFG2j43A392QRAoSbgXvJf
   i8tq2/3wPJBXUzOMFHm10zw1Pbp1obPqkrF7K//irqhL3ohFsWOQYMr+u
   qULGaQd0f/7k/pz9Ez2rvP88mEfzvI5kaEHnN1Df76kcz1ooynPgMF0vN
   3hrksFsxl/lnozFxA9Q2cr97O2YRD720k3WMWh3Re8vLTb0cYfKIVxfp/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="307137868"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="307137868"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="739916600"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="739916600"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:04 -0700
Subject: [PATCH v3 00/10] cxl: add monitor support for trace events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:04 -0700
Message-ID: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Steve, can you please take a look at the usages of libtraceevent and
libtracefs and provide feedback on if they are properly done? Thanks!

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
 cxl/cxl-monitor.service           |   9 ++
 cxl/cxl.c                         |   1 +
 cxl/event_trace.c                 | 249 ++++++++++++++++++++++++++++++
 cxl/event_trace.h                 |  27 ++++
 cxl/meson.build                   |   8 +
 cxl/monitor.c                     | 240 ++++++++++++++++++++++++++++
 meson.build                       |   3 +
 ndctl.spec.in                     |   1 +
 10 files changed, 616 insertions(+)
 create mode 100644 Documentation/cxl/cxl-monitor.txt
 create mode 100644 cxl/cxl-monitor.service
 create mode 100644 cxl/event_trace.c
 create mode 100644 cxl/event_trace.h
 create mode 100644 cxl/monitor.c

--

