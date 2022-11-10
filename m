Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534C0C43219
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Nov 2022 00:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKJAHc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKJAHb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Nov 2022 19:07:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62A15FF2
        for <linux-cxl@vger.kernel.org>; Wed,  9 Nov 2022 16:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038849; x=1699574849;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nxd/PbylXCL9ZSk1tC2GClE+RNDCGz/YGjWjymwPubM=;
  b=FXZFLggYLsGbh2/9I7yDrx4kW1faLqpA8B/haulwwRgWgahbdLSNXs7c
   wD7HCtzkRbgO3uzJiVY1lu3SwcnrmBUYnBygsDiBRl6ZoxCNBHc6i3XAb
   gmq2Q5BWkRi1e+Y3MlulspYzbhGAl5naQdcKojnmkbP2SleTZvMG49YMj
   BTNRjHGb/ySJMAXeKCGQ5PsKRhUiXyrEB1xt+Gf+kvmyGECXQoMAL891N
   fX7hpFwOmVR9Wq1oZosaZYN+O1b8mEgIYuCqQI5GXSDSZGghY27fiUJnn
   6K/SWkfZEUyLWENEAvr6V5khmeeSn/QQYYjQEfQeNh6AnreihMmlYYtAU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="397455730"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="397455730"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:07:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631442490"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="631442490"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:07:28 -0800
Subject: [PATCH v5 0/7] ndctl: cxl: add monitor support for trace events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 09 Nov 2022 17:07:28 -0700
Message-ID: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
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

v5:
- Remove unneeded header includes. (Vishal)
- Reformat using git clang-format. (Vishal)
- Change uuid string to 40 bytes allocation. (Vishal)
- Change cxl_event_to_json_callback() to cxl_event_to_json(). (Vishal)
- Change cxl_event_parse_cb() to cxl_event_parse(). (Vishal)
- Squash patch 3 & 4. (Vishal)
- Move common logging helper to util/log.c. (Vishal)
- Squash patch 5 & 7. (Vishal)
- Drop Alison's pid patch. (Vishal)
- Fixup man page. (Vishal)

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

Dave Jiang (7):
      ndctl: cxl: add helper function to parse trace event to json object
      ndctl: cxl: add helper to parse through all current events
      ndctl: cxl: add common function to enable/disable event trace
      ndctl: move common logging functions from ndctl/monitor.c to util/log.c
      ndctl: cxl: add monitor command for event trace events
      ndctl: cxl: add systemd service for monitor
      ndctl: cxl: add man page documentation for monitor


 Documentation/cxl/cxl-monitor.txt |  62 ++++++++
 Documentation/cxl/meson.build     |   1 +
 cxl/builtin.h                     |   1 +
 cxl/cxl-monitor.service           |   9 ++
 cxl/cxl.c                         |   1 +
 cxl/event_trace.c                 | 251 ++++++++++++++++++++++++++++++
 cxl/event_trace.h                 |  27 ++++
 cxl/meson.build                   |   8 +
 cxl/monitor.c                     | 215 +++++++++++++++++++++++++
 meson.build                       |   3 +
 ndctl.spec.in                     |   1 +
 ndctl/monitor.c                   |  41 +----
 util/log.c                        |  34 ++++
 util/log.h                        |   8 +-
 14 files changed, 624 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/cxl/cxl-monitor.txt
 create mode 100644 cxl/cxl-monitor.service
 create mode 100644 cxl/event_trace.c
 create mode 100644 cxl/event_trace.h
 create mode 100644 cxl/monitor.c

--

