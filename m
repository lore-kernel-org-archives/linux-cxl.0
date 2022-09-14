Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662D5ECAAD3
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Sep 2022 20:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiINUrx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiINUrw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Sep 2022 16:47:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8016AA25
        for <linux-cxl@vger.kernel.org>; Wed, 14 Sep 2022 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663188470; x=1694724470;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wpw38cfRGWJN/U73lTt426j1tWNt+0dnnuNoc4lw4hY=;
  b=HunmfLfN8XAa5A5tHcTUkFZAdJK57wwo3pRhvvPJ2rHuJZp74Y9n09lf
   JQY1GPEWEnBpHTJCVpJ1U/BsqY0uXVeDy5M4E9upFANz0fdW4V4w7KY3R
   DrX1CDOAJL+rro+08ISOz+RTBzPt1+h0hUTazJUsilzMnyiCJFR5ZNhGH
   doA/EJcSWQXCKrJpPkPEQfB6RfM/YaFd18JynCptBl4KIMNbA/Ehw39K5
   8tYMPBJSOz+WRVkViq4FE1XI6vLSm/qK95dNGMbqsc3LK5XjCxg3pRlTt
   hRimO/Pn48S04jRditdZvNhwgj2INNSE/w1Y0aLbkY7SZIkQoEjOMtUJJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="281570246"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="281570246"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:47:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="568155163"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:47:49 -0700
Subject: [PATCH 0/7] ndctl: cxl: add monitor support for trace events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Date:   Wed, 14 Sep 2022 13:47:49 -0700
Message-ID: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
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

---

Dave Jiang (7):
      ndctl: cxl: add helper function to parse trace event to json object
      ndctl: cxl: add helper to parse through all current events
      ndctl: cxl: add common function to enable event trace
      ndctl: cxl: add common function to disable event trace
      ndctl: cxl: add monitor function for event trace events
      ndctl: cxl: add logging functions for monitor
      ndctl: cxl: add monitor command to cxl


 cxl/builtin.h     |   1 +
 cxl/cxl.c         |   1 +
 cxl/event_trace.c | 236 ++++++++++++++++++++++++++++++++++++++++++++++
 cxl/event_trace.h |  23 +++++
 cxl/meson.build   |   4 +
 cxl/monitor.c     | 235 +++++++++++++++++++++++++++++++++++++++++++++
 meson.build       |   3 +
 7 files changed, 503 insertions(+)
 create mode 100644 cxl/event_trace.c
 create mode 100644 cxl/event_trace.h
 create mode 100644 cxl/monitor.c

--

